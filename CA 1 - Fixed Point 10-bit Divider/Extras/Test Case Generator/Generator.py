import random


def generate_random_binary():
    return format(random.randint(2**4, 2**9 - 1), '010b')


def generate_random_binary_divisor():
    return format(random.randint(1, 2**2 - 1)*8, '010b')


def div(A, B):
    int_A = int(A, 2)
    int_B = int(B, 2)

    res = int_A / int_B
    bin = format(int(res * (2 ** 4)), '010b')
    return bin


data = []
overflow_count = 0
sum = 0
for i in range(1, 5):
    sum += 1/(2**i)

for _ in range(100):
    A = generate_random_binary()[:10]
    B = generate_random_binary_divisor()[:10]
    Q = div(A, B)[:10]
    float_A = int(A, 2) / (2 ** 4)
    float_B = int(B, 2) / (2 ** 4)
    Q_res = int(Q, 2) / (2 ** 4)

    if (float_A/float_B > (2**5-1)+sum):
        Q = "OVERFLOW!"
        overflow_count += 1
    data.append((A, B, Q))

print(overflow_count)

with open('input.txt', 'w') as file:
    for A, B, Q in data:
        file.write(
            f'A = 10\'b{A};\nB = 10\'b{B};\nrst = 1; start = 0;\n#10 rst = 0; start = 1;#10 start=0; #380;\n\n')


with open(f'output.txt', 'w') as file:
    for A, B, Q in data:
        file.write(f'A = {A} , B= {B} , Q = {Q} \n')
