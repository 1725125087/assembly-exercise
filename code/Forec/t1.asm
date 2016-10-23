;; last edit date: 2016/10/24
;; author: Forec
;; LICENSE
;; Copyright (c) 2015-2017, Forec <forec@bupt.edu.cn>

;; Permission to use, copy, modify, and/or distribute this code for any
;; purpose with or without fee is hereby granted, provided that the above
;; copyright notice and this permission notice appear in all copies.

;; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
;; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
;; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
;; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
;; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
;; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
;; OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

title forec_t1

data segment
    array dw 23, 36, 2, 100, 32000, 54, 0
    zero dw 1           ;; zero��Ԫ��ʼ��Ϊ 1���������
ends

code segment
    assume cs:code, ds:data
starts:
    mov ax, data
    mov ds, ax
    lea bx, array       ;; bx �������� array ��ʼ��ַ
    mov [bx + 7*2], 0h  ;; ������ 0 ���� zero ��Ԫ 
    mov zero, 1h        ;; ������ 1 ���� zero ��Ԫ���������
    lea bx, array[12]   ;; bx �������� 0 �� array ������λ����   
    mov [bx+2], 0h      ;; ������ 0 ���� zero ��Ԫ                                         
	mov ah, 4ch
	int 21h
ends
    end starts