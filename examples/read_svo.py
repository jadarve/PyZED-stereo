import sys

import pyzed.camera as zcam
import pyzed.globals as sl

def main():

    # command line arguments
    if len(sys.argv) != 2:
        print('Please specify path to .svo file')
        exit()

    filepath = sys.argv[1]
    print('Reading SVO file: {0}'.format(filepath))

    # Create a ZED camera from a .svo file
    cam = zcam.Camera(filepath)

    # choose between MODE_NONE, MODE_PERFORMANCE or MODE_QUALITY
    cam.init(sl.MODE_QUALITY)

    print('Frame count: {0}'.format(cam.SVONumberOfFrames))
    print('Frame position: {0}'.format(cam.SVOPosition))
    print('Resolution: {0}'.format(cam.ImageSize))

    # camera parameters
    p = cam.getParameters()
    print('Camera parameters:\n{0}'.format(p))

    print('Left camera intrinsics matrix:\n{0}'.format(p.LeftCam.getIntrinsicsMatrix()))
    print('Right camera intrinsics matrix:\n{0}'.format(p.RightCam.getIntrinsicsMatrix()))


    for i in range(cam.SVONumberOfFrames):
    # for i in range(0):

        cam.SVOPosition = i
        cam.grab(sl.SENSING_MODE_FILL)
        
        # images from SVO file are encoded in BGR format
        img_left = cam.retrieveImage(sl.SIDE_LEFT)
        img_right = cam.retrieveImage(sl.SIDE_RIGHT)

        # extract depth
        depth = cam.retrieveMeasure(sl.MEASURE_DEPTH) / 1000.0 # convert to meters

        ###############################
        # DO YOUR PROCESSING HERE
        ###############################


    print('FINISH')
    

if __name__ == '__main__':
    main()
