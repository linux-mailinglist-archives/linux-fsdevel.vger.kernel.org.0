Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86999F83C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 00:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfKKXv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 18:51:26 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:46137 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfKKXvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:51:25 -0500
Received: by mail-lf1-f48.google.com with SMTP id o65so7569822lff.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 15:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Jr8GhMrrt/B5MXgl6TQY/T7xl692bmOyZCXN0LAOj8=;
        b=IbYZZWEI4KLhUtWSkrs7hcs68+mEge6/KLgmu1047nQtr8xXaC+fl5/qcP+Z0UfI2r
         FK4INqmH+Qpf28gOugYt+TB7BEFWjBUtO/OlIANn3GeMtU8xVQCR4bgX9tvJDsGcfGgt
         8RhepscHXu3gvogkyKNhV60hOA+mHP91rWAbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Jr8GhMrrt/B5MXgl6TQY/T7xl692bmOyZCXN0LAOj8=;
        b=Mz7OeT/T/EeHKzASZKFocYvRtIX6MGgtMFaKydPKb7JDsmYUInGWdokOaqUWOr3yxf
         LKGmy8hSPT8BGXrHzoLM2beS0DzSW3nDJv5AWUtkOUdR7NSMeGxEx08Ak134q46MRFsM
         TLp6OGquIkxIAOyy+FLQDSErjLpDn4tzJDfJXGOUIL2fORBExvkOO4uC4mDw+pZc45te
         wgnUlbVOb4RpnvxBw3AldchYv0Y/buI+jMyWD8QVfZbr465FeRX6O/g5PeXAXvN6sRj7
         wyAMwiEybrnlGQA14hqnb58lItiMT85YaroHx7f6jWy/DhB5tZA9a+LgF63AqRKabPNh
         qCsQ==
X-Gm-Message-State: APjAAAWVAtlJJLBDXfcXNT8E0GQQmxXgdfVEWL5oj3vdLQJwj7sinQOt
        4xc/XwbGsa/pN4FbFSqhgDy4NF6zg8M=
X-Google-Smtp-Source: APXvYqwpy92d2RIDrzGY6o6agnAkwzkleJOVV3Fi3p+Gyon4i63GTn6qHqRM7r0viuK9fVLWjGpKeA==
X-Received: by 2002:a19:6b10:: with SMTP id d16mr17580284lfa.137.1573516282456;
        Mon, 11 Nov 2019 15:51:22 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a15sm5460929lfj.78.2019.11.11.15.51.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 15:51:20 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id m6so11273224lfl.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 15:51:19 -0800 (PST)
X-Received: by 2002:ac2:5bca:: with SMTP id u10mr17489031lfn.134.1573516279685;
 Mon, 11 Nov 2019 15:51:19 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
 <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com> <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
In-Reply-To: <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 15:51:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whFejio0dC3T3a-5wuy9aum45unqacxkFpt5yo+-J502w@mail.gmail.com>
Message-ID: <CAHk-=whFejio0dC3T3a-5wuy9aum45unqacxkFpt5yo+-J502w@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kirill Smelkov <kirr@nexedi.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000e6518e05971aced8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000e6518e05971aced8
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 11, 2019 at 11:00 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> > if (ppos) {
> >      pos = *ppos; // data-race
>
> That code uses "fdget_pos().
>
> Which does mutual exclusion _if_ the file is something we care about
> pos for, and if it has more than one process using it.

That said, the more I look at that code, the less I like it.

I have this feeling we really should get rid of FMODE_ATOMIC_POS
entirely, now that we have the much nicer FMODE_STREAM to indicate
that 'pos' really doesn't matter.

Also, the test for "file_count(file) > 1" really is wrong, in that it
means that we protect against other processes, but not other threads.

So maybe we really should do the attached thing. Adding Al and Kirill
to the cc for comments. Kirill did some fairly in-depth review of the
whole locking on f_pos, it might be good to get his comments.

Al? Note the change from

-               if (file_count(file) > 1) {
+               if ((v & FDPUT_FPUT) || file_count(file) > 1) {

in __fdget_pos(). It basically says that the threaded case also does
the pos locking.

NOTE! This is entirely untested. It might be totally broken. It passes
my "LooksSuperficiallyFine(tm)" test, but that's all I'm going to say
about the patch.

            Linus

--000000000000e6518e05971aced8
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k2v2y66l0>
X-Attachment-Id: f_k2v2y66l0

IGZzL2ZpbGUuYyAgICAgICAgICB8IDQgKystLQogZnMvb3Blbi5jICAgICAgICAgIHwgNiArLS0t
LS0KIGluY2x1ZGUvbGludXgvZnMuaCB8IDIgLS0KIDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2ZpbGUuYyBiL2ZzL2ZpbGUu
YwppbmRleCAzZGE5MWExMTJiYWIuLjcwOGU1YzJiN2Q2NSAxMDA2NDQKLS0tIGEvZnMvZmlsZS5j
CisrKyBiL2ZzL2ZpbGUuYwpAQCAtNzk1LDggKzc5NSw4IEBAIHVuc2lnbmVkIGxvbmcgX19mZGdl
dF9wb3ModW5zaWduZWQgaW50IGZkKQogCXVuc2lnbmVkIGxvbmcgdiA9IF9fZmRnZXQoZmQpOwog
CXN0cnVjdCBmaWxlICpmaWxlID0gKHN0cnVjdCBmaWxlICopKHYgJiB+Myk7CiAKLQlpZiAoZmls
ZSAmJiAoZmlsZS0+Zl9tb2RlICYgRk1PREVfQVRPTUlDX1BPUykpIHsKLQkJaWYgKGZpbGVfY291
bnQoZmlsZSkgPiAxKSB7CisJaWYgKGZpbGUgJiYgIShmaWxlLT5mX21vZGUgJiBGTU9ERV9TVFJF
QU0pKSB7CisJCWlmICgodiAmIEZEUFVUX0ZQVVQpIHx8IGZpbGVfY291bnQoZmlsZSkgPiAxKSB7
CiAJCQl2IHw9IEZEUFVUX1BPU19VTkxPQ0s7CiAJCQltdXRleF9sb2NrKCZmaWxlLT5mX3Bvc19s
b2NrKTsKIAkJfQpkaWZmIC0tZ2l0IGEvZnMvb3Blbi5jIGIvZnMvb3Blbi5jCmluZGV4IGI2MmY1
YzA5MjNhOC4uNWM2ODI4MmVhNzllIDEwMDY0NAotLS0gYS9mcy9vcGVuLmMKKysrIGIvZnMvb3Bl
bi5jCkBAIC03NzEsMTAgKzc3MSw2IEBAIHN0YXRpYyBpbnQgZG9fZGVudHJ5X29wZW4oc3RydWN0
IGZpbGUgKmYsCiAJCWYtPmZfbW9kZSB8PSBGTU9ERV9XUklURVI7CiAJfQogCi0JLyogUE9TSVgu
MS0yMDA4L1NVU3Y0IFNlY3Rpb24gWFNJIDIuOS43ICovCi0JaWYgKFNfSVNSRUcoaW5vZGUtPmlf
bW9kZSkgfHwgU19JU0RJUihpbm9kZS0+aV9tb2RlKSkKLQkJZi0+Zl9tb2RlIHw9IEZNT0RFX0FU
T01JQ19QT1M7Ci0KIAlmLT5mX29wID0gZm9wc19nZXQoaW5vZGUtPmlfZm9wKTsKIAlpZiAoV0FS
Tl9PTighZi0+Zl9vcCkpIHsKIAkJZXJyb3IgPSAtRU5PREVWOwpAQCAtMTI1Niw3ICsxMjUyLDcg
QEAgRVhQT1JUX1NZTUJPTChub25zZWVrYWJsZV9vcGVuKTsKICAqLwogaW50IHN0cmVhbV9vcGVu
KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxwKQogewotCWZpbHAtPmZfbW9k
ZSAmPSB+KEZNT0RFX0xTRUVLIHwgRk1PREVfUFJFQUQgfCBGTU9ERV9QV1JJVEUgfCBGTU9ERV9B
VE9NSUNfUE9TKTsKKwlmaWxwLT5mX21vZGUgJj0gfihGTU9ERV9MU0VFSyB8IEZNT0RFX1BSRUFE
IHwgRk1PREVfUFdSSVRFKTsKIAlmaWxwLT5mX21vZGUgfD0gRk1PREVfU1RSRUFNOwogCXJldHVy
biAwOwogfQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mcy5oIGIvaW5jbHVkZS9saW51eC9m
cy5oCmluZGV4IGUwZDkwOWQzNTc2My4uYTdjM2Y2ZGQ1NzAxIDEwMDY0NAotLS0gYS9pbmNsdWRl
L2xpbnV4L2ZzLmgKKysrIGIvaW5jbHVkZS9saW51eC9mcy5oCkBAIC0xNDgsOCArMTQ4LDYgQEAg
dHlwZWRlZiBpbnQgKGRpb19pb2RvbmVfdCkoc3RydWN0IGtpb2NiICppb2NiLCBsb2ZmX3Qgb2Zm
c2V0LAogLyogRmlsZSBpcyBvcGVuZWQgd2l0aCBPX1BBVEg7IGFsbW9zdCBub3RoaW5nIGNhbiBi
ZSBkb25lIHdpdGggaXQgKi8KICNkZWZpbmUgRk1PREVfUEFUSAkJKChfX2ZvcmNlIGZtb2RlX3Qp
MHg0MDAwKQogCi0vKiBGaWxlIG5lZWRzIGF0b21pYyBhY2Nlc3NlcyB0byBmX3BvcyAqLwotI2Rl
ZmluZSBGTU9ERV9BVE9NSUNfUE9TCSgoX19mb3JjZSBmbW9kZV90KTB4ODAwMCkKIC8qIFdyaXRl
IGFjY2VzcyB0byB1bmRlcmx5aW5nIGZzICovCiAjZGVmaW5lIEZNT0RFX1dSSVRFUgkJKChfX2Zv
cmNlIGZtb2RlX3QpMHgxMDAwMCkKIC8qIEhhcyByZWFkIG1ldGhvZChzKSAqLwo=
--000000000000e6518e05971aced8--
