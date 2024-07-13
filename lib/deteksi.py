from flask import Flask, request, jsonify
import mediapipe as mp
import cv2
import numpy as np
import base64
import pickle

app = Flask(__name__)

mp_hands = mp.solutions.hands
hands = mp_hands.Hands()

# Load your model
with open('model_cobadataset.pkl', 'rb') as model_file:
    model = pickle.load(model_file)

def decode_image(image_data):
    nparr = np.frombuffer(base64.b64decode(image_data), np.uint8)
    img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    return img

def process_image(image):
    results = hands.process(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
    return results

@app.route('/detect', methods=['POST'])
def detect():
    data = request.json
    image_data = data['image']
    image = decode_image(image_data)
    results = process_image(image)

    response = {
        'landmarks': []
    }

    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            landmarks = []
            for landmark in hand_landmarks.landmark:
                landmarks.append({
                    'x': landmark.x,
                    'y': landmark.y,
                    'z': landmark.z
                })
            response['landmarks'].append(landmarks)

    # Process landmarks with your model
    if response['landmarks']:
        # Here you would input the landmarks to your model
        # For example:
        # processed_data = your_data_preprocessing_function(response['landmarks'])
        # model_output = model.predict(processed_data)
        # Add model_output to your response if needed
        pass

    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
