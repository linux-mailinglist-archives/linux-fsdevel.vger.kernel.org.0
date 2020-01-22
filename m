Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B270B145CCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 21:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgAVUAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 15:00:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46752 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 15:00:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id z26so510552lfg.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmXkOE0gQWDRjimVTEB4sD8JqwKTc5uBEhDESWZ8NPw=;
        b=GLauzyiFBTuk3X13M78MEbu9Kzz9Bqua6Tn5bTwgYr4+Wb5TA+GQxv7LcDqpOKIgfq
         rjbwLdlgVjIUdmW8DEA8AlbSPtfjLTTV8WMIR7BerZNkuz7ck9T5zENf1SPnrQ/iOlPX
         AVKANJGTXHiHyGPRuuoxw9y6BoOJI7S96PraU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmXkOE0gQWDRjimVTEB4sD8JqwKTc5uBEhDESWZ8NPw=;
        b=gLbPVFr7DcTs1WIw/P7xJB9eZROL7E1yH/8hJHLHg+zk+wqkAZmNLTF7j0Te1bJuQx
         lZq7RqzdwzTsnoOU0FX0sCS3lAlLsKwB9iM2sPjluXqEiysAoHR70lHUIJhwsPXfu9rM
         7p6H5RtM8zbFjazklqrwi+jXVn4F3h7FRo0Pb0cNrpvlkEpOZzXkdkjXOH1nOS2djIIc
         ImbML8Z6zuZH+QCb0gx5D+ixJlQIpjJBCDNfZuN+Et0nDB4vWbJ4n85x7Ypg4ZcTbN4C
         4rgL4hkJwVGEOjMHnKG82oxD7edL5J36q1MBLBVyqCYItiWMpCiVdEnYwA1b7CdA1Cpr
         KcGA==
X-Gm-Message-State: APjAAAWFnm679uPvAy8FT4xq+bOrLWhWpgPEfAcb0YyBMqXRM+gpY5xY
        z71BHQlqSEo47ePfQaCAwtTb/l6mtXE=
X-Google-Smtp-Source: APXvYqw1BDdilooI+PKQQyillsWWGKAWUbJ1bLgI4k9BvkVwAVxu62F0M3P+SqHovw6K5Vnz25NoYg==
X-Received: by 2002:ac2:5983:: with SMTP id w3mr2643045lfn.137.1579723249313;
        Wed, 22 Jan 2020 12:00:49 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id y21sm5641245lfy.46.2020.01.22.12.00.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:00:48 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id w1so435010ljh.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 12:00:47 -0800 (PST)
X-Received: by 2002:a2e:7a13:: with SMTP id v19mr20492671ljc.43.1579723247447;
 Wed, 22 Jan 2020 12:00:47 -0800 (PST)
MIME-Version: 1.0
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
 <CAHk-=wgNQ-rWoLg0OCJYYYbKBnRAUK4NPU-OD+vv-6fWnd=8kA@mail.gmail.com>
In-Reply-To: <CAHk-=wgNQ-rWoLg0OCJYYYbKBnRAUK4NPU-OD+vv-6fWnd=8kA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jan 2020 12:00:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=winQ_607Sp09H1w70A_WPmt7ydxrNrwvk=N29S=FpASZw@mail.gmail.com>
Message-ID: <CAHk-=winQ_607Sp09H1w70A_WPmt7ydxrNrwvk=N29S=FpASZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fs/readdir: Fix filldir() and filldir64() use of user_access_begin()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: multipart/mixed; boundary="000000000000021e77059cbffb27"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000021e77059cbffb27
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 22, 2020 at 10:24 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Patch looks better, but those names are horrid.

Hmm.

A bit more re-organization also allows us to do the unsafe_put_user()
unconditionally.

In particular, if we remove 'previous' as a pointer from the filldir
data structure, and replace it with 'prev_reclen', then we can do

        prev_reclen = buf->prev_reclen;
        dirent = buf->current_dir;
        prev = (void __user *) dirent - prev_reclen;
        if (!user_access_begin(prev, reclen + prev_reclen))
                goto efault;

and instead of checking that 'previous' pointer for NULL, we just
check prev_reclen for not being zero.

Yes, it replaces a few other

        lastdirent = buf.previous;

with the slightly more complicated

        lastdirent = (void __user *)buf.current_dir - buf.prev_reclen;

but on the whole it makes the _important_ code more streamlined, and
avoids having to have those if-else cases.

Something like the attached.

COMPLETELY UNTESTED! It compiles for me. The generated assembly looks
ok from a quick look.

Christophe, does this work for you on your ppc test-case?

Side note: I think verify_dirent_name() should check that 'len' is in
the appropriate range too, because right now a corrupted filesystem is
only noticed for a zero length. But a negative one, or one where the
reclen calculations would overflow, is not noticed.

Most filesystems have the source of 'len' being something like an
'unsigned char' so that it's pretty bounded anyway, which is likely
why nobody cared when we added that check, but..

               Linus

--000000000000021e77059cbffb27
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k5pqexac0>
X-Attachment-Id: f_k5pqexac0

IGZzL3JlYWRkaXIuYyB8IDc4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyks
IDM4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3JlYWRkaXIuYyBiL2ZzL3JlYWRkaXIu
YwppbmRleCBkMjZkNWVhNGRlN2IuLmViZGIwN2RkNDVmZSAxMDA2NDQKLS0tIGEvZnMvcmVhZGRp
ci5jCisrKyBiL2ZzL3JlYWRkaXIuYwpAQCAtMjA2LDcgKzIwNiw3IEBAIHN0cnVjdCBsaW51eF9k
aXJlbnQgewogc3RydWN0IGdldGRlbnRzX2NhbGxiYWNrIHsKIAlzdHJ1Y3QgZGlyX2NvbnRleHQg
Y3R4OwogCXN0cnVjdCBsaW51eF9kaXJlbnQgX191c2VyICogY3VycmVudF9kaXI7Ci0Jc3RydWN0
IGxpbnV4X2RpcmVudCBfX3VzZXIgKiBwcmV2aW91czsKKwlpbnQgcHJldl9yZWNsZW47CiAJaW50
IGNvdW50OwogCWludCBlcnJvcjsKIH07CkBAIC0yMTQsMTIgKzIxNCwxMyBAQCBzdHJ1Y3QgZ2V0
ZGVudHNfY2FsbGJhY2sgewogc3RhdGljIGludCBmaWxsZGlyKHN0cnVjdCBkaXJfY29udGV4dCAq
Y3R4LCBjb25zdCBjaGFyICpuYW1lLCBpbnQgbmFtbGVuLAogCQkgICBsb2ZmX3Qgb2Zmc2V0LCB1
NjQgaW5vLCB1bnNpZ25lZCBpbnQgZF90eXBlKQogewotCXN0cnVjdCBsaW51eF9kaXJlbnQgX191
c2VyICogZGlyZW50OworCXN0cnVjdCBsaW51eF9kaXJlbnQgX191c2VyICpkaXJlbnQsICpwcmV2
OwogCXN0cnVjdCBnZXRkZW50c19jYWxsYmFjayAqYnVmID0KIAkJY29udGFpbmVyX29mKGN0eCwg
c3RydWN0IGdldGRlbnRzX2NhbGxiYWNrLCBjdHgpOwogCXVuc2lnbmVkIGxvbmcgZF9pbm87CiAJ
aW50IHJlY2xlbiA9IEFMSUdOKG9mZnNldG9mKHN0cnVjdCBsaW51eF9kaXJlbnQsIGRfbmFtZSkg
KyBuYW1sZW4gKyAyLAogCQlzaXplb2YobG9uZykpOworCWludCBwcmV2X3JlY2xlbjsKIAogCWJ1
Zi0+ZXJyb3IgPSB2ZXJpZnlfZGlyZW50X25hbWUobmFtZSwgbmFtbGVuKTsKIAlpZiAodW5saWtl
bHkoYnVmLT5lcnJvcikpCkBAIC0yMzIsMjggKzIzMywyNiBAQCBzdGF0aWMgaW50IGZpbGxkaXIo
c3RydWN0IGRpcl9jb250ZXh0ICpjdHgsIGNvbnN0IGNoYXIgKm5hbWUsIGludCBuYW1sZW4sCiAJ
CWJ1Zi0+ZXJyb3IgPSAtRU9WRVJGTE9XOwogCQlyZXR1cm4gLUVPVkVSRkxPVzsKIAl9Ci0JZGly
ZW50ID0gYnVmLT5wcmV2aW91czsKLQlpZiAoZGlyZW50ICYmIHNpZ25hbF9wZW5kaW5nKGN1cnJl
bnQpKQotCQlyZXR1cm4gLUVJTlRSOwotCi0JLyoKLQkgKiBOb3RlISBUaGlzIHJhbmdlLWNoZWNr
cyAncHJldmlvdXMnICh3aGljaCBtYXkgYmUgTlVMTCkuCi0JICogVGhlIHJlYWwgcmFuZ2Ugd2Fz
IGNoZWNrZWQgaW4gZ2V0ZGVudHMKLQkgKi8KLQlpZiAoIXVzZXJfYWNjZXNzX2JlZ2luKGRpcmVu
dCwgc2l6ZW9mKCpkaXJlbnQpKSkKLQkJZ290byBlZmF1bHQ7Ci0JaWYgKGRpcmVudCkKLQkJdW5z
YWZlX3B1dF91c2VyKG9mZnNldCwgJmRpcmVudC0+ZF9vZmYsIGVmYXVsdF9lbmQpOworCXByZXZf
cmVjbGVuID0gYnVmLT5wcmV2X3JlY2xlbjsKIAlkaXJlbnQgPSBidWYtPmN1cnJlbnRfZGlyOwor
CXByZXYgPSAodm9pZCBfX3VzZXIgKikgZGlyZW50IC0gcHJldl9yZWNsZW47CisJaWYgKCF1c2Vy
X2FjY2Vzc19iZWdpbihwcmV2LCByZWNsZW4gKyBwcmV2X3JlY2xlbikpCisJCWdvdG8gZWZhdWx0
OworCWlmIChwcmV2X3JlY2xlbikgeworCQlpZiAodW5saWtlbHkoc2lnbmFsX3BlbmRpbmcoY3Vy
cmVudCkpKSB7CisJCQl1c2VyX2FjY2Vzc19lbmQoKTsKKwkJCXJldHVybiAtRUlOVFI7CisJCX0K
KwkJdW5zYWZlX3B1dF91c2VyKG9mZnNldCwgJnByZXYtPmRfb2ZmLCBlZmF1bHRfZW5kKTsKKwl9
CiAJdW5zYWZlX3B1dF91c2VyKGRfaW5vLCAmZGlyZW50LT5kX2lubywgZWZhdWx0X2VuZCk7CiAJ
dW5zYWZlX3B1dF91c2VyKHJlY2xlbiwgJmRpcmVudC0+ZF9yZWNsZW4sIGVmYXVsdF9lbmQpOwog
CXVuc2FmZV9wdXRfdXNlcihkX3R5cGUsIChjaGFyIF9fdXNlciAqKSBkaXJlbnQgKyByZWNsZW4g
LSAxLCBlZmF1bHRfZW5kKTsKIAl1bnNhZmVfY29weV9kaXJlbnRfbmFtZShkaXJlbnQtPmRfbmFt
ZSwgbmFtZSwgbmFtbGVuLCBlZmF1bHRfZW5kKTsKIAl1c2VyX2FjY2Vzc19lbmQoKTsKIAotCWJ1
Zi0+cHJldmlvdXMgPSBkaXJlbnQ7Ci0JZGlyZW50ID0gKHZvaWQgX191c2VyICopZGlyZW50ICsg
cmVjbGVuOwotCWJ1Zi0+Y3VycmVudF9kaXIgPSBkaXJlbnQ7CisJYnVmLT5jdXJyZW50X2RpciA9
ICh2b2lkIF9fdXNlciAqKWRpcmVudCArIHJlY2xlbjsKKwlidWYtPnByZXZfcmVjbGVuID0gcmVj
bGVuOwogCWJ1Zi0+Y291bnQgLT0gcmVjbGVuOwogCXJldHVybiAwOwogZWZhdWx0X2VuZDoKQEAg
LTI2Nyw3ICsyNjYsNiBAQCBTWVNDQUxMX0RFRklORTMoZ2V0ZGVudHMsIHVuc2lnbmVkIGludCwg
ZmQsCiAJCXN0cnVjdCBsaW51eF9kaXJlbnQgX191c2VyICosIGRpcmVudCwgdW5zaWduZWQgaW50
LCBjb3VudCkKIHsKIAlzdHJ1Y3QgZmQgZjsKLQlzdHJ1Y3QgbGludXhfZGlyZW50IF9fdXNlciAq
IGxhc3RkaXJlbnQ7CiAJc3RydWN0IGdldGRlbnRzX2NhbGxiYWNrIGJ1ZiA9IHsKIAkJLmN0eC5h
Y3RvciA9IGZpbGxkaXIsCiAJCS5jb3VudCA9IGNvdW50LApAQCAtMjg1LDggKzI4MywxMCBAQCBT
WVNDQUxMX0RFRklORTMoZ2V0ZGVudHMsIHVuc2lnbmVkIGludCwgZmQsCiAJZXJyb3IgPSBpdGVy
YXRlX2RpcihmLmZpbGUsICZidWYuY3R4KTsKIAlpZiAoZXJyb3IgPj0gMCkKIAkJZXJyb3IgPSBi
dWYuZXJyb3I7Ci0JbGFzdGRpcmVudCA9IGJ1Zi5wcmV2aW91czsKLQlpZiAobGFzdGRpcmVudCkg
eworCWlmIChidWYucHJldl9yZWNsZW4pIHsKKwkJc3RydWN0IGxpbnV4X2RpcmVudCBfX3VzZXIg
KiBsYXN0ZGlyZW50OworCQlsYXN0ZGlyZW50ID0gKHZvaWQgX191c2VyICopYnVmLmN1cnJlbnRf
ZGlyIC0gYnVmLnByZXZfcmVjbGVuOworCiAJCWlmIChwdXRfdXNlcihidWYuY3R4LnBvcywgJmxh
c3RkaXJlbnQtPmRfb2ZmKSkKIAkJCWVycm9yID0gLUVGQVVMVDsKIAkJZWxzZQpAQCAtMjk5LDcg
KzI5OSw3IEBAIFNZU0NBTExfREVGSU5FMyhnZXRkZW50cywgdW5zaWduZWQgaW50LCBmZCwKIHN0
cnVjdCBnZXRkZW50c19jYWxsYmFjazY0IHsKIAlzdHJ1Y3QgZGlyX2NvbnRleHQgY3R4OwogCXN0
cnVjdCBsaW51eF9kaXJlbnQ2NCBfX3VzZXIgKiBjdXJyZW50X2RpcjsKLQlzdHJ1Y3QgbGludXhf
ZGlyZW50NjQgX191c2VyICogcHJldmlvdXM7CisJaW50IHByZXZfcmVjbGVuOwogCWludCBjb3Vu
dDsKIAlpbnQgZXJyb3I7CiB9OwpAQCAtMzA3LDExICszMDcsMTIgQEAgc3RydWN0IGdldGRlbnRz
X2NhbGxiYWNrNjQgewogc3RhdGljIGludCBmaWxsZGlyNjQoc3RydWN0IGRpcl9jb250ZXh0ICpj
dHgsIGNvbnN0IGNoYXIgKm5hbWUsIGludCBuYW1sZW4sCiAJCSAgICAgbG9mZl90IG9mZnNldCwg
dTY0IGlubywgdW5zaWduZWQgaW50IGRfdHlwZSkKIHsKLQlzdHJ1Y3QgbGludXhfZGlyZW50NjQg
X191c2VyICpkaXJlbnQ7CisJc3RydWN0IGxpbnV4X2RpcmVudDY0IF9fdXNlciAqZGlyZW50LCAq
cHJldjsKIAlzdHJ1Y3QgZ2V0ZGVudHNfY2FsbGJhY2s2NCAqYnVmID0KIAkJY29udGFpbmVyX29m
KGN0eCwgc3RydWN0IGdldGRlbnRzX2NhbGxiYWNrNjQsIGN0eCk7CiAJaW50IHJlY2xlbiA9IEFM
SUdOKG9mZnNldG9mKHN0cnVjdCBsaW51eF9kaXJlbnQ2NCwgZF9uYW1lKSArIG5hbWxlbiArIDEs
CiAJCXNpemVvZih1NjQpKTsKKwlpbnQgcHJldl9yZWNsZW47CiAKIAlidWYtPmVycm9yID0gdmVy
aWZ5X2RpcmVudF9uYW1lKG5hbWUsIG5hbWxlbik7CiAJaWYgKHVubGlrZWx5KGJ1Zi0+ZXJyb3Ip
KQpAQCAtMzE5LDMwICszMjAsMzAgQEAgc3RhdGljIGludCBmaWxsZGlyNjQoc3RydWN0IGRpcl9j
b250ZXh0ICpjdHgsIGNvbnN0IGNoYXIgKm5hbWUsIGludCBuYW1sZW4sCiAJYnVmLT5lcnJvciA9
IC1FSU5WQUw7CS8qIG9ubHkgdXNlZCBpZiB3ZSBmYWlsLi4gKi8KIAlpZiAocmVjbGVuID4gYnVm
LT5jb3VudCkKIAkJcmV0dXJuIC1FSU5WQUw7Ci0JZGlyZW50ID0gYnVmLT5wcmV2aW91czsKLQlp
ZiAoZGlyZW50ICYmIHNpZ25hbF9wZW5kaW5nKGN1cnJlbnQpKQotCQlyZXR1cm4gLUVJTlRSOwot
Ci0JLyoKLQkgKiBOb3RlISBUaGlzIHJhbmdlLWNoZWNrcyAncHJldmlvdXMnICh3aGljaCBtYXkg
YmUgTlVMTCkuCi0JICogVGhlIHJlYWwgcmFuZ2Ugd2FzIGNoZWNrZWQgaW4gZ2V0ZGVudHMKLQkg
Ki8KLQlpZiAoIXVzZXJfYWNjZXNzX2JlZ2luKGRpcmVudCwgc2l6ZW9mKCpkaXJlbnQpKSkKLQkJ
Z290byBlZmF1bHQ7Ci0JaWYgKGRpcmVudCkKLQkJdW5zYWZlX3B1dF91c2VyKG9mZnNldCwgJmRp
cmVudC0+ZF9vZmYsIGVmYXVsdF9lbmQpOworCXByZXZfcmVjbGVuID0gYnVmLT5wcmV2X3JlY2xl
bjsKIAlkaXJlbnQgPSBidWYtPmN1cnJlbnRfZGlyOworCXByZXYgPSAodm9pZCBfX3VzZXIgKilk
aXJlbnQgLSBwcmV2X3JlY2xlbjsKKwlpZiAoIXVzZXJfYWNjZXNzX2JlZ2luKHByZXYsIHJlY2xl
biArIHByZXZfcmVjbGVuKSkKKwkJZ290byBlZmF1bHQ7CisJaWYgKHByZXZfcmVjbGVuKSB7CisJ
CWlmICh1bmxpa2VseShzaWduYWxfcGVuZGluZyhjdXJyZW50KSkpIHsKKwkJCXVzZXJfYWNjZXNz
X2VuZCgpOworCQkJcmV0dXJuIC1FSU5UUjsKKwkJfQorCQl1bnNhZmVfcHV0X3VzZXIob2Zmc2V0
LCAmcHJldi0+ZF9vZmYsIGVmYXVsdF9lbmQpOworCX0KIAl1bnNhZmVfcHV0X3VzZXIoaW5vLCAm
ZGlyZW50LT5kX2lubywgZWZhdWx0X2VuZCk7CiAJdW5zYWZlX3B1dF91c2VyKHJlY2xlbiwgJmRp
cmVudC0+ZF9yZWNsZW4sIGVmYXVsdF9lbmQpOwogCXVuc2FmZV9wdXRfdXNlcihkX3R5cGUsICZk
aXJlbnQtPmRfdHlwZSwgZWZhdWx0X2VuZCk7CiAJdW5zYWZlX2NvcHlfZGlyZW50X25hbWUoZGly
ZW50LT5kX25hbWUsIG5hbWUsIG5hbWxlbiwgZWZhdWx0X2VuZCk7CiAJdXNlcl9hY2Nlc3NfZW5k
KCk7CiAKLQlidWYtPnByZXZpb3VzID0gZGlyZW50OworCWJ1Zi0+cHJldl9yZWNsZW4gPSByZWNs
ZW47CiAJZGlyZW50ID0gKHZvaWQgX191c2VyICopZGlyZW50ICsgcmVjbGVuOwogCWJ1Zi0+Y3Vy
cmVudF9kaXIgPSBkaXJlbnQ7CiAJYnVmLT5jb3VudCAtPSByZWNsZW47CiAJcmV0dXJuIDA7CisK
IGVmYXVsdF9lbmQ6CiAJdXNlcl9hY2Nlc3NfZW5kKCk7CiBlZmF1bHQ6CkBAIC0zNTQsNyArMzU1
LDYgQEAgaW50IGtzeXNfZ2V0ZGVudHM2NCh1bnNpZ25lZCBpbnQgZmQsIHN0cnVjdCBsaW51eF9k
aXJlbnQ2NCBfX3VzZXIgKmRpcmVudCwKIAkJICAgIHVuc2lnbmVkIGludCBjb3VudCkKIHsKIAlz
dHJ1Y3QgZmQgZjsKLQlzdHJ1Y3QgbGludXhfZGlyZW50NjQgX191c2VyICogbGFzdGRpcmVudDsK
IAlzdHJ1Y3QgZ2V0ZGVudHNfY2FsbGJhY2s2NCBidWYgPSB7CiAJCS5jdHguYWN0b3IgPSBmaWxs
ZGlyNjQsCiAJCS5jb3VudCA9IGNvdW50LApAQCAtMzcyLDkgKzM3MiwxMSBAQCBpbnQga3N5c19n
ZXRkZW50czY0KHVuc2lnbmVkIGludCBmZCwgc3RydWN0IGxpbnV4X2RpcmVudDY0IF9fdXNlciAq
ZGlyZW50LAogCWVycm9yID0gaXRlcmF0ZV9kaXIoZi5maWxlLCAmYnVmLmN0eCk7CiAJaWYgKGVy
cm9yID49IDApCiAJCWVycm9yID0gYnVmLmVycm9yOwotCWxhc3RkaXJlbnQgPSBidWYucHJldmlv
dXM7Ci0JaWYgKGxhc3RkaXJlbnQpIHsKKwlpZiAoYnVmLnByZXZfcmVjbGVuKSB7CisJCXN0cnVj
dCBsaW51eF9kaXJlbnQ2NCBfX3VzZXIgKiBsYXN0ZGlyZW50OwogCQl0eXBlb2YobGFzdGRpcmVu
dC0+ZF9vZmYpIGRfb2ZmID0gYnVmLmN0eC5wb3M7CisKKwkJbGFzdGRpcmVudCA9ICh2b2lkIF9f
dXNlciAqKSBidWYuY3VycmVudF9kaXIgLSBidWYucHJldl9yZWNsZW47CiAJCWlmIChfX3B1dF91
c2VyKGRfb2ZmLCAmbGFzdGRpcmVudC0+ZF9vZmYpKQogCQkJZXJyb3IgPSAtRUZBVUxUOwogCQll
bHNlCg==
--000000000000021e77059cbffb27--
