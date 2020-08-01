Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2FA2353D5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgHARjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 13:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgHARjU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 13:39:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998D5C06174A
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2020 10:39:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x9so35590964ljc.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2020 10:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSMz53TZKQ6sk3S4b6W05ZI4+3GXVw8jD2Gw4lqXtXk=;
        b=K1nTPli+t7wJ57gIA/1k20l1xjyfXxoXZKinZ0qdkj2q3y2vQec3aGF0Dur6AHEU5/
         pivQjYNyYfJthJRDoNpzMRNNPRvQk1oKe+Fya2s79I6atkeOXqlXpdpyIMcpgFvAuh9J
         i9MICiVjdmLnaHL2z5fNku9gi8HwGErLcJEss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSMz53TZKQ6sk3S4b6W05ZI4+3GXVw8jD2Gw4lqXtXk=;
        b=ooJm+Gcjmm4O2Y+190xYHuzcPEoZCTQY5v3l7Gbo7iTHoGprk6N+LpdPTbzRwUKRLJ
         xp6h8qSzZJRq0fPFuvAOg7DKP2Bw2+bRtNNG2wVvw6Zv0EON9ApoIXhsijwfN50DI2Ss
         PaA7dX37qm8JshSnsXmG7C28QyfkEQAEpKkh+f23aiDEV0bO8vCxL3f9wpGU2Nf8bfpw
         a0qvcWPgXiK6SbntR1u+xOwgvBo4e7eapE+MgE03S6z6BgW6QmecAGVI+6QNmDpwjH2U
         TNpqj5KmLXPyZhjvdS2OBxQUQ8sFuO6JvVNhUA4l1BG7zOKX7t4s6dk6UjvnWtaU8o0R
         IURA==
X-Gm-Message-State: AOAM532D6bJUKNolZJLOk83TSZejRqSRPUw6dlSrOuCa+1+7Ix/rlw/H
        2o5f1tOFK5uSxgQba2DPy8zmz0hzqwg=
X-Google-Smtp-Source: ABdhPJzHu+r3t1APrC7qIHLi/u7R9JUAYloqogcbEfelTcuE2LZdDPDVEr/Ik1NjlbSTx377OgZbkw==
X-Received: by 2002:a2e:9acc:: with SMTP id p12mr4600089ljj.363.1596303557777;
        Sat, 01 Aug 2020 10:39:17 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id h14sm2477590ljb.53.2020.08.01.10.39.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2020 10:39:16 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id s9so18467005lfs.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2020 10:39:16 -0700 (PDT)
X-Received: by 2002:a19:c206:: with SMTP id l6mr4698688lfc.152.1596303556090;
 Sat, 01 Aug 2020 10:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000045b3fe05abcced2f@google.com> <fc097a54-0384-9d21-323f-c3ca52cdb956@I-love.SAKURA.ne.jp>
In-Reply-To: <fc097a54-0384-9d21-323f-c3ca52cdb956@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Aug 2020 10:39:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj15SDiHjP2wPiC=Ru-RrUjOuT4AoULj6N_9pVvSXaWiw@mail.gmail.com>
Message-ID: <CAHk-=wj15SDiHjP2wPiC=Ru-RrUjOuT4AoULj6N_9pVvSXaWiw@mail.gmail.com>
Subject: Re: INFO: task hung in pipe_read (2)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     syzbot <syzbot+96cc7aba7e969b1d305c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/mixed; boundary="0000000000006a4f6205abd462ab"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000006a4f6205abd462ab
Content-Type: text/plain; charset="UTF-8"

On Sat, Aug 1, 2020 at 8:30 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Waiting for response at https://lkml.kernel.org/r/45a9b2c8-d0b7-8f00-5b30-0cfe3e028b28@I-love.SAKURA.ne.jp .

I think handle_userfault() should have a (shortish) timeout, and just
return VM_FAULT_RETRY.

The code is overly complex anyway, because it predates the "just return RETRY".

And because we can't wait forever when the source of the fault is a
kernel exception, I think we should add some extra logic to just say
"if this is a retry, we've already done this once, just return an
error".

This is a TEST PATCH ONLY. I think we'll actually have to do something
like this, but I think the final version might need to allow a couple
of retries, rather than just give up after just one second.

But for testing your case, this patch might be enough to at least show
that "yeah, this kind of approach works".

Andrea? Comments? As mentioned, this is probably much too aggressive,
but I do think we need to limit the time that the kernel will wait for
page faults.

Because userfaultfd has become a huge source of security holes as a
way to time kernel faults or delay them indefinitely.

                     Linus

--0000000000006a4f6205abd462ab
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kdbxwnv70>
X-Attachment-Id: f_kdbxwnv70

IGZzL3VzZXJmYXVsdGZkLmMgfCAzNSArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2ZzL3VzZXJmYXVsdGZkLmMgYi9mcy91c2VyZmF1bHRmZC5jCmluZGV4IDUyZGUy
OTAwMGM3ZS4uYmQ3Mzk0ODhiYjI5IDEwMDY0NAotLS0gYS9mcy91c2VyZmF1bHRmZC5jCisrKyBi
L2ZzL3VzZXJmYXVsdGZkLmMKQEAgLTQ3Myw2ICs0NzMsMTYgQEAgdm1fZmF1bHRfdCBoYW5kbGVf
dXNlcmZhdWx0KHN0cnVjdCB2bV9mYXVsdCAqdm1mLCB1bnNpZ25lZCBsb25nIHJlYXNvbikKIAkJ
Z290byBvdXQ7CiAJfQogCisJLyoKKwkgKiBJZiB0aGlzIGlzIGEga2VybmVsIGZhdWx0LCBhbmQg
d2UncmUgcmV0cnlpbmcsIGNvbnNpZGVyCisJICogaXQgZmF0YWwuIE90aGVyd2lzZSB3ZSBoYXZl
IGRlYWRsb2NrcyBhbmQgb3RoZXIgbmFzdHkKKwkgKiBzdHVmZi4KKwkgKi8KKwlpZiAodm1mLT5m
bGFncyAmIEZBVUxUX0ZMQUdfVFJJRUQpIHsKKwkJaWYgKFdBUk5fT05fT05DRSghKHZtZi0+Zmxh
Z3MgJiBGQVVMVF9GTEFHX1VTRVIpKSkKKwkJCWdvdG8gb3V0OworCX0KKwogCS8qCiAJICogSGFu
ZGxlIG5vd2FpdCwgbm90IG11Y2ggdG8gZG8gb3RoZXIgdGhhbiB0ZWxsIGl0IHRvIHJldHJ5CiAJ
ICogYW5kIHdhaXQuCkBAIC01MTYsMzMgKzUyNiwxMiBAQCB2bV9mYXVsdF90IGhhbmRsZV91c2Vy
ZmF1bHQoc3RydWN0IHZtX2ZhdWx0ICp2bWYsIHVuc2lnbmVkIGxvbmcgcmVhc29uKQogCQkJCQkJ
ICAgICAgIHZtZi0+ZmxhZ3MsIHJlYXNvbik7CiAJbW1hcF9yZWFkX3VubG9jayhtbSk7CiAKKwkv
KiBXZSdsbCB3YWl0IGZvciB1cCB0byBhIHNlY29uZCwgYW5kIHRoZW4gcmV0dXJuIFZNX0ZBVUxU
X1JFVFJZICovCiAJaWYgKGxpa2VseShtdXN0X3dhaXQgJiYgIVJFQURfT05DRShjdHgtPnJlbGVh
c2VkKSAmJgogCQkgICAhdXNlcmZhdWx0ZmRfc2lnbmFsX3BlbmRpbmcodm1mLT5mbGFncykpKSB7
CiAJCXdha2VfdXBfcG9sbCgmY3R4LT5mZF93cWgsIEVQT0xMSU4pOwotCQlzY2hlZHVsZSgpOwor
CQlzY2hlZHVsZV90aW1lb3V0KEhaKTsKIAkJcmV0IHw9IFZNX0ZBVUxUX01BSk9SOwotCi0JCS8q
Ci0JCSAqIEZhbHNlIHdha2V1cHMgY2FuIG9yZ2luYXRlIGV2ZW4gZnJvbSByd3NlbSBiZWZvcmUK
LQkJICogdXBfcmVhZCgpIGhvd2V2ZXIgdXNlcmZhdWx0cyB3aWxsIHdhaXQgZWl0aGVyIGZvciBh
Ci0JCSAqIHRhcmdldGVkIHdha2V1cCBvbiB0aGUgc3BlY2lmaWMgdXdxIHdhaXRxdWV1ZSBmcm9t
Ci0JCSAqIHdha2VfdXNlcmZhdWx0KCkgb3IgZm9yIHNpZ25hbHMgb3IgZm9yIHVmZmQKLQkJICog
cmVsZWFzZS4KLQkJICovCi0JCXdoaWxlICghUkVBRF9PTkNFKHV3cS53YWtlbikpIHsKLQkJCS8q
Ci0JCQkgKiBUaGlzIG5lZWRzIHRoZSBmdWxsIHNtcF9zdG9yZV9tYigpCi0JCQkgKiBndWFyYW50
ZWUgYXMgdGhlIHN0YXRlIHdyaXRlIG11c3QgYmUKLQkJCSAqIHZpc2libGUgdG8gb3RoZXIgQ1BV
cyBiZWZvcmUgcmVhZGluZwotCQkJICogdXdxLndha2VuIGZyb20gb3RoZXIgQ1BVcy4KLQkJCSAq
LwotCQkJc2V0X2N1cnJlbnRfc3RhdGUoYmxvY2tpbmdfc3RhdGUpOwotCQkJaWYgKFJFQURfT05D
RSh1d3Eud2FrZW4pIHx8Ci0JCQkgICAgUkVBRF9PTkNFKGN0eC0+cmVsZWFzZWQpIHx8Ci0JCQkg
ICAgdXNlcmZhdWx0ZmRfc2lnbmFsX3BlbmRpbmcodm1mLT5mbGFncykpCi0JCQkJYnJlYWs7Ci0J
CQlzY2hlZHVsZSgpOwotCQl9CiAJfQogCiAJX19zZXRfY3VycmVudF9zdGF0ZShUQVNLX1JVTk5J
TkcpOwo=
--0000000000006a4f6205abd462ab--
