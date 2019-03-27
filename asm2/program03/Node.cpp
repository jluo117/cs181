#include <iostream>
#include <string>

using namespace std;

#include "Node.h"

Node::Node(string data) : small(data), left(0), middle(0), right(0), parent(0) {
}

void Node::printSmall() const {
    if (!small.empty()) {
        cout << small << ", ";
    }
}

void Node::printLarge() const {
    if (!large.empty()) {
        cout << large << ", ";
    }
}

bool Node::isLeaf() const {
    return !(left || middle || right);
}

bool Node::isThreeNode() const {
    return !large.empty();
}

bool Node::isEmpty() const {
    return small.empty() && large.empty();
}

void Node::swapData() {
    string tempString = small;
    small = large;
    large = tempString;
}
