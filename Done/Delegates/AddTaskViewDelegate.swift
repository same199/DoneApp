//
//  AddTaskViewDelegate.swift
//  Done
//
//  Created by LizOk&Same on 9.09.26.
//

import UIKit

protocol AddTaskViewDelegate: AnyObject {

    func addTaskViewDidChangeState(
        _ view: AddTaskView,
        isExpanded: Bool
    )

    func addTaskView(
        _ view: AddTaskView,
        didTapSaveWith title: String,
        description: String
    )
    
    func addTaskViewDidChangeDescriptionState(
        _ view: AddTaskView,
        isVisible: Bool
    )
}
