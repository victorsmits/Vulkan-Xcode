#pragma once

template <class T>
class optional {
private:
	bool _has_value = false;
	T value;

public:
	void setValue(T v);
	T getValue();
	bool has_value();
};

template <class T>
void optional<T>::setValue(T v) {
	value = v;
	_has_value = true;
}

template <class T>
T optional<T>::getValue() {
	return value;
}

template <class T>
bool optional<T>::has_value() {
	return _has_value;
}

