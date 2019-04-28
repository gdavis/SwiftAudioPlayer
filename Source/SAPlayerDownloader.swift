//
//  SAPlayerDownloader.swift
//  SwiftAudioPlayer
//
//  Created by Tanha Kabir on 2019-02-25.
//  Copyright © 2019 Tanha Kabir, Jon Mercer
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

extension SAPlayer {
    /**
     Actions relating to downloading remote audio to the device for offline playback.
     
     - Note: All saved urls generated from downloaded audio corresponds to a specific remote url. Thus, can be queryed if original remote url is known.
     
     - Important: Please ensure that you have passed in the background download completion handler in the AppDelegate with `setBackgroundCompletionHandler` to allow for downloading audio while app is in the background.
     */
    public struct Downloader {
        /**
         Download audio from a remote url. Will save the audio on the device for playback later.
         
         Save the saved url of the downloaded audio for future playback or query for the saved url with the same remote url in the future.
         
         - Note: It's recommended to have a weak reference to a class that uses this function
         
         - Parameter url: The remote url to download audio from.
         - Parameter completion: Completion handler that will return once the download is successful and complete.
         - Parameter savedUrl: The url of where the audio was saved locally on the device. Will receive once download has completed.
         */
        public static func downloadAudio(withRemoteUrl url: URL, completion: @escaping (_ savedUrl: URL) -> ()) {
            SAPlayer.shared.addUrlToMapping(url: url)
            AudioDataManager.shared.startDownload(withRemoteURL: url, completion: completion)
        }
        
        public static func cancelDownload(withRemoteUrl url: URL) {
            AudioDataManager.shared.deleteDownload(withRemoteURL: url)
        }
        
        public static func deleteDownload(withRemoteUrl url: URL) {
            AudioDataManager.shared.deleteDownload(withRemoteURL: url)
        }
        
        public static func isDownloaded(withRemoteUrl url: URL) -> Bool {
            return AudioDataManager.shared.getPersistedUrl(withRemoteURL: url) != nil
        }
        
        public static func getSavedUrl(forRemoteUrl url: URL) -> URL? {
            return AudioDataManager.shared.getPersistedUrl(withRemoteURL: url)
        }
        
        public static func setBackgroundCompletionHandler(_ completionHandler: @escaping () -> ()) {
            AudioDataManager.shared.setBackgroundCompletionHandler(completionHandler)
        }
    }
}
