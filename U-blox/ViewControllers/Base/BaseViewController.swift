/*
 * Copyright (C) u-blox
 *
 * u-blox reserves all rights in this deliverable (documentation, software, etc.,
 * hereafter “Deliverable”).
 *
 * u-blox grants you the right to use, copy, modify and distribute the
 * Deliverable provided hereunder for any purpose without fee.
 *
 * THIS DELIVERABLE IS BEING PROVIDED "AS IS", WITHOUT ANY EXPRESS OR IMPLIED
 * WARRANTY. IN PARTICULAR, NEITHER THE AUTHOR NOR U-BLOX MAKES ANY
 * REPRESENTATION OR WARRANTY OF ANY KIND CONCERNING THE MERCHANTABILITY OF THIS
 * DELIVERABLE OR ITS FITNESS FOR ANY PARTICULAR PURPOSE.
 *
 * In case you provide us a feedback or make a contribution in the form of a
 * further development of the Deliverable (“Contribution”), u-blox will have the
 * same rights as granted to you, namely to use, copy, modify and distribute the
 * Contribution provided to us for any purpose without fee.
 */

import UIKit

class BaseViewController: UIViewController {

    private var pendingAlert: UIAlertController?
    var isPendingAlertVisible: Bool {
        return pendingAlert != nil
    }

    func showPendingAlert(title: String?, buttonAction anActrion: ((UIAlertAction) -> Void)?, completion: (() -> Swift.Void)? = nil) {
        pendingAlert = AlertUtil.createAlert(type: .withActivityIndicator, title: title, action: anActrion)
        present(pendingAlert!, animated: true, completion: completion)
    }
    func changePendingAlert(title: String?) {
        pendingAlert?.title = title
    }
    func dismissPendingAlert(completion: (() -> Swift.Void)? = nil) {
        guard let alert = pendingAlert else {
            completion?()
            return
        }
        alert.dismiss(animated: true, completion: completion)
        pendingAlert = nil
    }
}
