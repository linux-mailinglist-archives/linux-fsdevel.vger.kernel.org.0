Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D71269400
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 19:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgINRr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 13:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgINRrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:47:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674F3C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 10:47:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c2so385428ljj.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZgwQ0xT4bYrUbZoo2DKW4vm50tEl1CKWxi4qRlsmu0w=;
        b=WztijGP/hsBA+nSjIdYAJ0Lmc8tlhSMHmAQpUqMJ75sKF8d4c6otqiNMBZgJMPDg4E
         OaJrGK/IfBFquaNWahWdSZ/x4nrh3wfxuuSqC4dt4DmiHc4Pl0lUdWRweB/yPEyCinLm
         Xv5gX/E4FyLmDsZnBS7YU1NmXWQOSwmm85PvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgwQ0xT4bYrUbZoo2DKW4vm50tEl1CKWxi4qRlsmu0w=;
        b=mxgct8TUznAlJ5uJmzIe6jSidyryHl3lHfia/CMYSyk4gwMfewv2lVp4AvrMHGUzA+
         sfJHvtHsiiQjQ0PfTlPvy7x0G34c738Uc5mbBWzCDOerD9Nd4+eRFwjUGuxVRo7KIZ2B
         WFLLaHNXFdNrfO0N7ZO5z+BgjzJ9GZ9BrzL/gYRU///umDexQbZOn0kPnss85RCPuxx5
         4DX05Buzu6PJH8Svpx5UADyyh+X1DgJQGzITAlKysFSjDZqZLrdIiY4ecIul1blVEMpL
         zGN+6TPsqjQvHC0k8afQoK11mQfSdTtNpQJMcmzECdf4I0nKkuX2mgNTv5SX1hVoxkXa
         9hhA==
X-Gm-Message-State: AOAM5334lfAeizfLr0gJ5vo4OLFHOrpg53RxteWO95+2Cui7HjVl6cGn
        XZP8NJA5Q6qF9twQWeDQdPxhwhadCeZp8A==
X-Google-Smtp-Source: ABdhPJwqTWK6met7MYKLuReYk4+3ElUEFOUebCD30ESe/Tjh1LunYaNRee5FYA4WyGAa50K/xsy2bA==
X-Received: by 2002:a2e:7a14:: with SMTP id v20mr5656946ljc.429.1600105660441;
        Mon, 14 Sep 2020 10:47:40 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id h17sm4174777ljj.4.2020.09.14.10.47.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 10:47:38 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id z17so151138lfi.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 10:47:38 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr4185985lfr.352.1600105658008;
 Mon, 14 Sep 2020 10:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com>
In-Reply-To: <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Sep 2020 10:47:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
Message-ID: <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Michael Larabel <Michael@michaellarabel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000059775405af49a110"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000059775405af49a110
Content-Type: text/plain; charset="UTF-8"

Michael et al,
 Ok, I redid my failed "hybrid mode" patch from scratch (original
patch never sent out, I never got it to a working point).

Having learnt from my mistake, this time instead of trying to mix the
old and the new code, instead I just extended the new code, and wrote
a _lot_ of comments about it.

I also made it configurable, using a "page_lock_unfairness" knob,
which this patch defaults to 1000 (which is basically infinite).
That's just a value that says how many times we'll try the old unfair
case, so "1000" means "we'll re-queue up to a thousand times before we
say enough is enough" and zero is the fair mode that shows the
performance problems.

I've only (lightly) tested those two extremes, I think the interesting
range is likely in the 1-5 range.

So you can do

    echo 0 > /proc/sys/vm/page_lock_unfairness
    .. run test ..

and you should get the same numbers as without this patch (within
noise, of course).

Or do

    echo 5 > /proc/sys/vm/page_lock_unfairness
    .. run test ..

and get numbers for "we accept some unfairness, but if we have to
requeue more than five times, we force the fair mode".

Again, the default is 1000, which is ludicrously high (it's not a
"this many retries per page" count, it's a "for each waiter" count). I
made it that high just because I have *not* run any numbers for that
interesting range, I just checked the extreme cases, and I wanted to
make sure that Michael sees the old performance (modulo other changes
to 5.9, of course).

Comments? The patch really has a fair amount of comments in it, in
fact the code changes are reasonably small, most of the changes really
are about new and updated comments about what is going on.

I was burnt by making a mess of this the first time, so I proceeded
more thoughtfully this time. Hopefullyt the end result is also better.

(Note that it's a commit and has a SHA1, but it's from my "throw-away
tree for testing", so it doesn't have my sign-off or any real commit
message yet: I'll do that once it gets actual testing and comments).

                 Linus

--00000000000059775405af49a110
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-Page-lock-unfairness-sysctl.patch"
Content-Disposition: attachment; 
	filename="0001-Page-lock-unfairness-sysctl.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kf2tjtp90>
X-Attachment-Id: f_kf2tjtp90

RnJvbSA4ODBkYjEwYTlmZWExZGFkMGM4Y2YyOWFlMDRiNDQ0NmQyZTcxNzBiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFN1biwgMTMgU2VwIDIwMjAgMTQ6MDU6MzUgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBQYWdlIGxvY2sgdW5mYWlybmVzcyBzeXNjdGwKCi0tLQogaW5jbHVkZS9saW51eC9t
bS5oICAgfCAgIDIgKwogaW5jbHVkZS9saW51eC93YWl0LmggfCAgIDEgKwoga2VybmVsL3N5c2N0
bC5jICAgICAgfCAgIDggKysrCiBtbS9maWxlbWFwLmMgICAgICAgICB8IDE2MCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCiA0IGZpbGVzIGNoYW5nZWQsIDE0MCBp
bnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L21tLmggYi9pbmNsdWRlL2xpbnV4L21tLmgKaW5kZXggY2E2ZTZhODE1NzZiLi5iMmYzNzBmMGI0
MjAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbW0uaAorKysgYi9pbmNsdWRlL2xpbnV4L21t
LmgKQEAgLTQxLDYgKzQxLDggQEAgc3RydWN0IHdyaXRlYmFja19jb250cm9sOwogc3RydWN0IGJk
aV93cml0ZWJhY2s7CiBzdHJ1Y3QgcHRfcmVnczsKIAorZXh0ZXJuIGludCBzeXNjdGxfcGFnZV9s
b2NrX3VuZmFpcm5lc3M7CisKIHZvaWQgaW5pdF9tbV9pbnRlcm5hbHModm9pZCk7CiAKICNpZm5k
ZWYgQ09ORklHX05FRURfTVVMVElQTEVfTk9ERVMJLyogRG9uJ3QgdXNlIG1hcG5ycywgZG8gaXQg
cHJvcGVybHkgKi8KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvd2FpdC5oIGIvaW5jbHVkZS9s
aW51eC93YWl0LmgKaW5kZXggODk4Yzg5MGZjMTUzLi4yN2ZiOTljZmViMDIgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvbGludXgvd2FpdC5oCisrKyBiL2luY2x1ZGUvbGludXgvd2FpdC5oCkBAIC0yMSw2
ICsyMSw3IEBAIGludCBkZWZhdWx0X3dha2VfZnVuY3Rpb24oc3RydWN0IHdhaXRfcXVldWVfZW50
cnkgKndxX2VudHJ5LCB1bnNpZ25lZCBtb2RlLCBpbnQKICNkZWZpbmUgV1FfRkxBR19XT0tFTgkJ
MHgwMgogI2RlZmluZSBXUV9GTEFHX0JPT0tNQVJLCTB4MDQKICNkZWZpbmUgV1FfRkxBR19DVVNU
T00JCTB4MDgKKyNkZWZpbmUgV1FfRkxBR19ET05FCQkweDEwCiAKIC8qCiAgKiBBIHNpbmdsZSB3
YWl0LXF1ZXVlIGVudHJ5IHN0cnVjdHVyZToKZGlmZiAtLWdpdCBhL2tlcm5lbC9zeXNjdGwuYyBi
L2tlcm5lbC9zeXNjdGwuYwppbmRleCAwOWU3MGVlMjMzMmUuLmFmYWQwODU5NjBiOCAxMDA2NDQK
LS0tIGEva2VybmVsL3N5c2N0bC5jCisrKyBiL2tlcm5lbC9zeXNjdGwuYwpAQCAtMjkxMiw2ICsy
OTEyLDE0IEBAIHN0YXRpYyBzdHJ1Y3QgY3RsX3RhYmxlIHZtX3RhYmxlW10gPSB7CiAJCS5wcm9j
X2hhbmRsZXIJPSBwZXJjcHVfcGFnZWxpc3RfZnJhY3Rpb25fc3lzY3RsX2hhbmRsZXIsCiAJCS5l
eHRyYTEJCT0gU1lTQ1RMX1pFUk8sCiAJfSwKKwl7CisJCS5wcm9jbmFtZQk9ICJwYWdlX2xvY2tf
dW5mYWlybmVzcyIsCisJCS5kYXRhCQk9ICZzeXNjdGxfcGFnZV9sb2NrX3VuZmFpcm5lc3MsCisJ
CS5tYXhsZW4JCT0gc2l6ZW9mKHN5c2N0bF9wYWdlX2xvY2tfdW5mYWlybmVzcyksCisJCS5tb2Rl
CQk9IDA2NDQsCisJCS5wcm9jX2hhbmRsZXIJPSBwcm9jX2RvaW50dmVjX21pbm1heCwKKwkJLmV4
dHJhMQkJPSBTWVNDVExfWkVSTywKKwl9LAogI2lmZGVmIENPTkZJR19NTVUKIAl7CiAJCS5wcm9j
bmFtZQk9ICJtYXhfbWFwX2NvdW50IiwKZGlmZiAtLWdpdCBhL21tL2ZpbGVtYXAuYyBiL21tL2Zp
bGVtYXAuYwppbmRleCAxYWFlYTI2NTU2Y2MuLmQwYTc2MDY5YmNiOCAxMDA2NDQKLS0tIGEvbW0v
ZmlsZW1hcC5jCisrKyBiL21tL2ZpbGVtYXAuYwpAQCAtOTg4LDkgKzk4OCw0MyBAQCB2b2lkIF9f
aW5pdCBwYWdlY2FjaGVfaW5pdCh2b2lkKQogCXBhZ2Vfd3JpdGViYWNrX2luaXQoKTsKIH0KIAor
LyoKKyAqIFRoZSBwYWdlIHdhaXQgY29kZSB0cmVhdHMgdGhlICJ3YWl0LT5mbGFncyIgc29tZXdo
YXQgdW51c3VhbGx5LCBiZWNhdXNlCisgKiB3ZSBoYXZlIG11bHRpcGxlIGRpZmZlcmVudCBraW5k
cyBvZiB3YWl0cywgbm90IGp1c3QgaGUgdXN1YWwgImV4Y2x1c2l2ZSIKKyAqIG9uZS4KKyAqCisg
KiBXZSBoYXZlOgorICoKKyAqICAoYSkgbm8gc3BlY2lhbCBiaXRzIHNldDoKKyAqCisgKglXZSdy
ZSBqdXN0IHdhaXRpbmcgZm9yIHRoZSBiaXQgdG8gYmUgcmVsZWFzZWQsIGFuZCB3aGVuIGEgd2Fr
ZXIKKyAqCWNhbGxzIHRoZSB3YWtldXAgZnVuY3Rpb24sIHdlIHNldCBXUV9GTEFHX1dPS0VOIGFu
ZCB3YWtlIGl0IHVwLAorICoJYW5kIHJlbW92ZSBpdCBmcm9tIHRoZSB3YWl0IHF1ZXVlLgorICoK
KyAqCVNpbXBsZSBhbmQgc3RyYWlnaHRmb3J3YXJkLgorICoKKyAqICAoYikgV1FfRkxBR19FWENM
VVNJVkU6CisgKgorICoJVGhlIHdhaXRlciBpcyB3YWl0aW5nIHRvIGdldCB0aGUgbG9jaywgYW5k
IG9ubHkgb25lIHdhaXRlciBzaG91bGQKKyAqCWJlIHdva2VuIHVwIHRvIGF2b2lkIGFueSB0aHVu
ZGVyaW5nIGhlcmQgYmVoYXZpb3IuIFdlJ2xsIHNldCB0aGUKKyAqCVdRX0ZMQUdfV09LRU4gYml0
LCB3YWtlIGl0IHVwLCBhbmQgcmVtb3ZlIGl0IGZyb20gdGhlIHdhaXQgcXVldWUuCisgKgorICoJ
VGhpcyBpcyB0aGUgdHJhZGl0aW9uYWwgZXhjbHVzaXZlIHdhaXQuCisgKgorICogIChiKSBXUV9G
TEFHX0VYQ0xVU0lWRSB8IFdRX0ZMQUdfQ1VTVE9NOgorICoKKyAqCVRoZSB3YWl0ZXIgaXMgd2Fp
dGluZyB0byBnZXQgdGhlIGJpdCwgYW5kIGFkZGl0aW9uYWxseSB3YW50cyB0aGUKKyAqCWxvY2sg
dG8gYmUgdHJhbnNmZXJyZWQgdG8gaXQgZm9yIGZhaXIgbG9jayBiZWhhdmlvci4gSWYgdGhlIGxv
Y2sKKyAqCWNhbm5vdCBiZSB0YWtlbiwgd2Ugc3RvcCB3YWxraW5nIHRoZSB3YWl0IHF1ZXVlIHdp
dGhvdXQgd2FraW5nCisgKgl0aGUgd2FpdGVyLgorICoKKyAqCVRoaXMgaXMgdGhlICJmYWlyIGxv
Y2sgaGFuZG9mZiIgY2FzZSwgYW5kIGluIGFkZGl0aW9uIHRvIHNldHRpbmcKKyAqCVdRX0ZMQUdf
V09LRU4sIHdlIHNldCBXUV9GTEFHX0RPTkUgdG8gbGV0IHRoZSB3YWl0ZXIgZWFzaWx5IHNlZQor
ICoJdGhhdCBpdCBub3cgaGFzIHRoZSBsb2NrLgorICovCiBzdGF0aWMgaW50IHdha2VfcGFnZV9m
dW5jdGlvbih3YWl0X3F1ZXVlX2VudHJ5X3QgKndhaXQsIHVuc2lnbmVkIG1vZGUsIGludCBzeW5j
LCB2b2lkICphcmcpCiB7Ci0JaW50IHJldDsKKwl1bnNpZ25lZCBpbnQgZmxhZ3M7CiAJc3RydWN0
IHdhaXRfcGFnZV9rZXkgKmtleSA9IGFyZzsKIAlzdHJ1Y3Qgd2FpdF9wYWdlX3F1ZXVlICp3YWl0
X3BhZ2UKIAkJPSBjb250YWluZXJfb2Yod2FpdCwgc3RydWN0IHdhaXRfcGFnZV9xdWV1ZSwgd2Fp
dCk7CkBAIC05OTksMzUgKzEwMzMsNDQgQEAgc3RhdGljIGludCB3YWtlX3BhZ2VfZnVuY3Rpb24o
d2FpdF9xdWV1ZV9lbnRyeV90ICp3YWl0LCB1bnNpZ25lZCBtb2RlLCBpbnQgc3luYywKIAkJcmV0
dXJuIDA7CiAKIAkvKgotCSAqIElmIGl0J3MgYW4gZXhjbHVzaXZlIHdhaXQsIHdlIGdldCB0aGUg
Yml0IGZvciBpdCwgYW5kCi0JICogc3RvcCB3YWxraW5nIGlmIHdlIGNhbid0LgotCSAqCi0JICog
SWYgaXQncyBhIG5vbi1leGNsdXNpdmUgd2FpdCwgdGhlbiB0aGUgZmFjdCB0aGF0IHRoaXMKLQkg
KiB3YWtlIGZ1bmN0aW9uIHdhcyBjYWxsZWQgbWVhbnMgdGhhdCB0aGUgYml0IGFscmVhZHkKLQkg
KiB3YXMgY2xlYXJlZCwgYW5kIHdlIGRvbid0IGNhcmUgaWYgc29tZWJvZHkgdGhlbgotCSAqIHJl
LXRvb2sgaXQuCisJICogSWYgaXQncyBhIGxvY2sgaGFuZG9mZiB3YWl0LCB3ZSBnZXQgdGhlIGJp
dCBmb3IgaXQsIGFuZAorCSAqIHN0b3Agd2Fsa2luZyAoYW5kIGRvIG5vdCB3YWtlIGl0IHVwKSBp
ZiB3ZSBjYW4ndC4KIAkgKi8KLQlyZXQgPSAwOwotCWlmICh3YWl0LT5mbGFncyAmIFdRX0ZMQUdf
RVhDTFVTSVZFKSB7Ci0JCWlmICh0ZXN0X2FuZF9zZXRfYml0KGtleS0+Yml0X25yLCAma2V5LT5w
YWdlLT5mbGFncykpCisJZmxhZ3MgPSB3YWl0LT5mbGFnczsKKwlpZiAoZmxhZ3MgJiBXUV9GTEFH
X0VYQ0xVU0lWRSkgeworCQlpZiAodGVzdF9iaXQoa2V5LT5iaXRfbnIsICZrZXktPnBhZ2UtPmZs
YWdzKSkKIAkJCXJldHVybiAtMTsKLQkJcmV0ID0gMTsKKwkJaWYgKGZsYWdzICYgV1FfRkxBR19D
VVNUT00pIHsKKwkJCWlmICh0ZXN0X2FuZF9zZXRfYml0KGtleS0+Yml0X25yLCAma2V5LT5wYWdl
LT5mbGFncykpCisJCQkJcmV0dXJuIC0xOworCQkJZmxhZ3MgfD0gV1FfRkxBR19ET05FOworCQl9
CiAJfQotCXdhaXQtPmZsYWdzIHw9IFdRX0ZMQUdfV09LRU47CiAKKwkvKgorCSAqIFdlIGFyZSBo
b2xkaW5nIHRoZSB3YWl0LXF1ZXVlIGxvY2ssIGJ1dCB0aGUgd2FpdGVyIHRoYXQKKwkgKiBpcyB3
YWl0aW5nIGZvciB0aGlzIHdpbGwgYmUgY2hlY2tpbmcgdGhlIGZsYWdzIHdpdGhvdXQKKwkgKiBh
bnkgbG9ja2luZy4KKwkgKgorCSAqIFNvIHVwZGF0ZSB0aGUgZmxhZ3MgYXRvbWljYWxseSwgYW5k
IHdha2UgdXAgdGhlIHdhaXRlcgorCSAqIGFmdGVyd2FyZHMgdG8gYXZvaWQgYW55IHJhY2VzLiBU
aGlzIHN0b3JlLXJlbGVhc2UgcGFpcnMKKwkgKiB3aXRoIHRoZSBsb2FkLWFjcXVpcmUgaW4gd2Fp
dF9vbl9wYWdlX2JpdF9jb21tb24oKS4KKwkgKi8KKwlzbXBfc3RvcmVfcmVsZWFzZSgmd2FpdC0+
ZmxhZ3MsIGZsYWdzIHwgV1FfRkxBR19XT0tFTik7CiAJd2FrZV91cF9zdGF0ZSh3YWl0LT5wcml2
YXRlLCBtb2RlKTsKIAogCS8qCiAJICogT2ssIHdlIGhhdmUgc3VjY2Vzc2Z1bGx5IGRvbmUgd2hh
dCB3ZSdyZSB3YWl0aW5nIGZvciwKIAkgKiBhbmQgd2UgY2FuIHVuY29uZGl0aW9uYWxseSByZW1v
dmUgdGhlIHdhaXQgZW50cnkuCiAJICoKLQkgKiBOb3RlIHRoYXQgdGhpcyBoYXMgdG8gYmUgdGhl
IGFic29sdXRlIGxhc3QgdGhpbmcgd2UgZG8sCi0JICogc2luY2UgYWZ0ZXIgbGlzdF9kZWxfaW5p
dCgmd2FpdC0+ZW50cnkpIHRoZSB3YWl0IGVudHJ5CisJICogTm90ZSB0aGF0IHRoaXMgcGFpcnMg
d2l0aCB0aGUgImZpbmlzaF93YWl0KCkiIGluIHRoZQorCSAqIHdhaXRlciwgYW5kIGhhcyB0byBi
ZSB0aGUgYWJzb2x1dGUgbGFzdCB0aGluZyB3ZSBkby4KKwkgKiBBZnRlciB0aGlzIGxpc3RfZGVs
X2luaXQoJndhaXQtPmVudHJ5KSB0aGUgd2FpdCBlbnRyeQogCSAqIG1pZ2h0IGJlIGRlLWFsbG9j
YXRlZCBhbmQgdGhlIHByb2Nlc3MgbWlnaHQgZXZlbiBoYXZlCiAJICogZXhpdGVkLgogCSAqLwog
CWxpc3RfZGVsX2luaXRfY2FyZWZ1bCgmd2FpdC0+ZW50cnkpOwotCXJldHVybiByZXQ7CisJcmV0
dXJuIChmbGFncyAmIFdRX0ZMQUdfRVhDTFVTSVZFKSAhPSAwOwogfQogCiBzdGF0aWMgdm9pZCB3
YWtlX3VwX3BhZ2VfYml0KHN0cnVjdCBwYWdlICpwYWdlLCBpbnQgYml0X25yKQpAQCAtMTEwNyw4
ICsxMTUwLDggQEAgZW51bSBiZWhhdmlvciB7CiB9OwogCiAvKgotICogQXR0ZW1wdCB0byBjaGVj
ayAob3IgZ2V0KSB0aGUgcGFnZSBiaXQsIGFuZCBtYXJrIHRoZQotICogd2FpdGVyIHdva2VuIGlm
IHN1Y2Nlc3NmdWwuCisgKiBBdHRlbXB0IHRvIGNoZWNrIChvciBnZXQpIHRoZSBwYWdlIGJpdCwg
YW5kIG1hcmsgdXMgZG9uZQorICogaWYgc3VjY2Vzc2Z1bC4KICAqLwogc3RhdGljIGlubGluZSBi
b29sIHRyeWxvY2tfcGFnZV9iaXRfY29tbW9uKHN0cnVjdCBwYWdlICpwYWdlLCBpbnQgYml0X25y
LAogCQkJCQlzdHJ1Y3Qgd2FpdF9xdWV1ZV9lbnRyeSAqd2FpdCkKQEAgLTExMTksMTMgKzExNjIs
MTcgQEAgc3RhdGljIGlubGluZSBib29sIHRyeWxvY2tfcGFnZV9iaXRfY29tbW9uKHN0cnVjdCBw
YWdlICpwYWdlLCBpbnQgYml0X25yLAogCX0gZWxzZSBpZiAodGVzdF9iaXQoYml0X25yLCAmcGFn
ZS0+ZmxhZ3MpKQogCQlyZXR1cm4gZmFsc2U7CiAKLQl3YWl0LT5mbGFncyB8PSBXUV9GTEFHX1dP
S0VOOworCXdhaXQtPmZsYWdzIHw9IFdRX0ZMQUdfV09LRU4gfCBXUV9GTEFHX0RPTkU7CiAJcmV0
dXJuIHRydWU7CiB9CiAKKy8qIEhvdyBtYW55IHRpbWVzIGRvIHdlIGFjY2VwdCBsb2NrIHN0ZWFs
aW5nIGZyb20gdW5kZXIgYSB3YWl0ZXI/ICovCitpbnQgc3lzY3RsX3BhZ2VfbG9ja191bmZhaXJu
ZXNzID0gMTAwMDsKKwogc3RhdGljIGlubGluZSBpbnQgd2FpdF9vbl9wYWdlX2JpdF9jb21tb24o
d2FpdF9xdWV1ZV9oZWFkX3QgKnEsCiAJc3RydWN0IHBhZ2UgKnBhZ2UsIGludCBiaXRfbnIsIGlu
dCBzdGF0ZSwgZW51bSBiZWhhdmlvciBiZWhhdmlvcikKIHsKKwlpbnQgdW5mYWlybmVzcyA9IHN5
c2N0bF9wYWdlX2xvY2tfdW5mYWlybmVzczsKIAlzdHJ1Y3Qgd2FpdF9wYWdlX3F1ZXVlIHdhaXRf
cGFnZTsKIAl3YWl0X3F1ZXVlX2VudHJ5X3QgKndhaXQgPSAmd2FpdF9wYWdlLndhaXQ7CiAJYm9v
bCB0aHJhc2hpbmcgPSBmYWxzZTsKQEAgLTExNDMsMTEgKzExOTAsMTggQEAgc3RhdGljIGlubGlu
ZSBpbnQgd2FpdF9vbl9wYWdlX2JpdF9jb21tb24od2FpdF9xdWV1ZV9oZWFkX3QgKnEsCiAJfQog
CiAJaW5pdF93YWl0KHdhaXQpOwotCXdhaXQtPmZsYWdzID0gYmVoYXZpb3IgPT0gRVhDTFVTSVZF
ID8gV1FfRkxBR19FWENMVVNJVkUgOiAwOwogCXdhaXQtPmZ1bmMgPSB3YWtlX3BhZ2VfZnVuY3Rp
b247CiAJd2FpdF9wYWdlLnBhZ2UgPSBwYWdlOwogCXdhaXRfcGFnZS5iaXRfbnIgPSBiaXRfbnI7
CiAKK3JlcGVhdDoKKwl3YWl0LT5mbGFncyA9IDA7CisJaWYgKGJlaGF2aW9yID09IEVYQ0xVU0lW
RSkgeworCQl3YWl0LT5mbGFncyA9IFdRX0ZMQUdfRVhDTFVTSVZFOworCQlpZiAoLS11bmZhaXJu
ZXNzIDwgMCkKKwkJCXdhaXQtPmZsYWdzIHw9IFdRX0ZMQUdfQ1VTVE9NOworCX0KKwogCS8qCiAJ
ICogRG8gb25lIGxhc3QgY2hlY2sgd2hldGhlciB3ZSBjYW4gZ2V0IHRoZQogCSAqIHBhZ2UgYml0
IHN5bmNocm9ub3VzbHkuCkBAIC0xMTcwLDI3ICsxMjI0LDYzIEBAIHN0YXRpYyBpbmxpbmUgaW50
IHdhaXRfb25fcGFnZV9iaXRfY29tbW9uKHdhaXRfcXVldWVfaGVhZF90ICpxLAogCiAJLyoKIAkg
KiBGcm9tIG5vdyBvbiwgYWxsIHRoZSBsb2dpYyB3aWxsIGJlIGJhc2VkIG9uCi0JICogdGhlIFdR
X0ZMQUdfV09LRU4gZmxhZywgYW5kIHRoZSBhbmQgdGhlIHBhZ2UKLQkgKiBiaXQgdGVzdGluZyAo
YW5kIHNldHRpbmcpIHdpbGwgYmUgLSBvciBoYXMKLQkgKiBhbHJlYWR5IGJlZW4gLSBkb25lIGJ5
IHRoZSB3YWtlIGZ1bmN0aW9uLgorCSAqIHRoZSBXUV9GTEFHX1dPS0VOIGFuZCBXUV9GTEFHX0RP
TkUgZmxhZywgdG8KKwkgKiBzZWUgd2hldGhlciB0aGUgcGFnZSBiaXQgdGVzdGluZyBoYXMgYWxy
ZWFkeQorCSAqIGJlZW4gZG9uZSBieSB0aGUgd2FrZSBmdW5jdGlvbi4KIAkgKgogCSAqIFdlIGNh
biBkcm9wIG91ciByZWZlcmVuY2UgdG8gdGhlIHBhZ2UuCiAJICovCiAJaWYgKGJlaGF2aW9yID09
IERST1ApCiAJCXB1dF9wYWdlKHBhZ2UpOwogCisJLyoKKwkgKiBOb3RlIHRoYXQgdW50aWwgdGhl
ICJmaW5pc2hfd2FpdCgpIiwgb3IgdW50aWwKKwkgKiB3ZSBzZWUgdGhlIFdRX0ZMQUdfV09LRU4g
ZmxhZywgd2UgbmVlZCB0bworCSAqIGJlIHZlcnkgY2FyZWZ1bCB3aXRoIHRoZSAnd2FpdC0+Zmxh
Z3MnLCBiZWNhdXNlCisJICogd2UgbWF5IHJhY2Ugd2l0aCBhIHdha2VyIHRoYXQgc2V0cyB0aGVt
LgorCSAqLwogCWZvciAoOzspIHsKKwkJdW5zaWduZWQgaW50IGZsYWdzOworCiAJCXNldF9jdXJy
ZW50X3N0YXRlKHN0YXRlKTsKIAotCQlpZiAoc2lnbmFsX3BlbmRpbmdfc3RhdGUoc3RhdGUsIGN1
cnJlbnQpKQorCQkvKiBMb29wIHVudGlsIHdlJ3ZlIGJlZW4gd29rZW4gb3IgaW50ZXJydXB0ZWQg
Ki8KKwkJZmxhZ3MgPSBzbXBfbG9hZF9hY3F1aXJlKCZ3YWl0LT5mbGFncyk7CisJCWlmICghKGZs
YWdzICYgV1FfRkxBR19XT0tFTikpIHsKKwkJCWlmIChzaWduYWxfcGVuZGluZ19zdGF0ZShzdGF0
ZSwgY3VycmVudCkpCisJCQkJYnJlYWs7CisKKwkJCWlvX3NjaGVkdWxlKCk7CisJCQljb250aW51
ZTsKKwkJfQorCisJCS8qIElmIHdlIHdlcmUgbm9uLWV4Y2x1c2l2ZSwgd2UncmUgZG9uZSAqLwor
CQlpZiAoYmVoYXZpb3IgIT0gRVhDTFVTSVZFKQogCQkJYnJlYWs7CiAKLQkJaWYgKHdhaXQtPmZs
YWdzICYgV1FfRkxBR19XT0tFTikKKwkJLyogSWYgdGhlIHdha2VyIGdvdCB0aGUgbG9jayBmb3Ig
dXMsIHdlJ3JlIGRvbmUgKi8KKwkJaWYgKGZsYWdzICYgV1FfRkxBR19ET05FKQogCQkJYnJlYWs7
CiAKLQkJaW9fc2NoZWR1bGUoKTsKKwkJLyoKKwkJICogT3RoZXJ3aXNlLCBpZiB3ZSdyZSBnZXR0
aW5nIHRoZSBsb2NrLCB3ZSBuZWVkIHRvCisJCSAqIHRyeSB0byBnZXQgaXQgb3Vyc2VsdmVzLgor
CQkgKgorCQkgKiBBbmQgaWYgdGhhdCBmYWlscywgd2UnbGwgaGF2ZSB0byByZXRyeSB0aGlzIGFs
bC4KKwkJICovCisJCWlmICh1bmxpa2VseSh0ZXN0X2FuZF9zZXRfYml0KGJpdF9uciwgJnBhZ2Ut
PmZsYWdzKSkpCisJCQlnb3RvIHJlcGVhdDsKKworCQl3YWl0LT5mbGFncyB8PSBXUV9GTEFHX0RP
TkU7CisJCWJyZWFrOwogCX0KIAorCS8qCisJICogSWYgYSBzaWduYWwgaGFwcGVuZWQsIHRoaXMg
J2ZpbmlzaF93YWl0KCknIG1heSByZW1vdmUgdGhlIGxhc3QKKwkgKiB3YWl0ZXIgZnJvbSB0aGUg
d2FpdC1xdWV1ZXMsIGJ1dCB0aGUgUGFnZVdhaXRlcnMgYml0IHdpbGwgcmVtYWluCisJICogc2V0
LiBUaGF0J3Mgb2suIFRoZSBuZXh0IHdha2V1cCB3aWxsIHRha2UgY2FyZSBvZiBpdCwgYW5kIHRy
eWluZworCSAqIHRvIGRvIGl0IGhlcmUgd291bGQgYmUgZGlmZmljdWx0IGFuZCBwcm9uZSB0byBy
YWNlcy4KKwkgKi8KIAlmaW5pc2hfd2FpdChxLCB3YWl0KTsKIAogCWlmICh0aHJhc2hpbmcpIHsK
QEAgLTEyMDAsMTIgKzEyOTAsMjAgQEAgc3RhdGljIGlubGluZSBpbnQgd2FpdF9vbl9wYWdlX2Jp
dF9jb21tb24od2FpdF9xdWV1ZV9oZWFkX3QgKnEsCiAJfQogCiAJLyoKLQkgKiBBIHNpZ25hbCBj
b3VsZCBsZWF2ZSBQYWdlV2FpdGVycyBzZXQuIENsZWFyaW5nIGl0IGhlcmUgaWYKLQkgKiAhd2Fp
dHF1ZXVlX2FjdGl2ZSB3b3VsZCBiZSBwb3NzaWJsZSAoYnkgb3Blbi1jb2RpbmcgZmluaXNoX3dh
aXQpLAotCSAqIGJ1dCBzdGlsbCBmYWlsIHRvIGNhdGNoIGl0IGluIHRoZSBjYXNlIG9mIHdhaXQg
aGFzaCBjb2xsaXNpb24uIFdlCi0JICogYWxyZWFkeSBjYW4gZmFpbCB0byBjbGVhciB3YWl0IGhh
c2ggY29sbGlzaW9uIGNhc2VzLCBzbyBkb24ndAotCSAqIGJvdGhlciB3aXRoIHNpZ25hbHMgZWl0
aGVyLgorCSAqIE5PVEUhIFRoZSB3YWl0LT5mbGFncyB3ZXJlbid0IHN0YWJsZSB1bnRpbCB3ZSd2
ZSBkb25lIHRoZQorCSAqICdmaW5pc2hfd2FpdCgpJywgYW5kIHdlIGNvdWxkIGhhdmUgZXhpdGVk
IHRoZSBsb29wIGFib3ZlIGR1ZQorCSAqIHRvIGEgc2lnbmFsLCBhbmQgaGFkIGEgd2FrZXVwIGV2
ZW50IGhhcHBlbiBhZnRlciB0aGUgc2lnbmFsCisJICogdGVzdCBidXQgYmVmb3JlIHRoZSAnZmlu
aXNoX3dhaXQoKScuCisJICoKKwkgKiBTbyBvbmx5IGFmdGVyIHRoZSBmaW5pc2hfd2FpdCgpIGNh
biB3ZSByZWxpYWJseSBkZXRlcm1pbmUKKwkgKiBpZiB3ZSBnb3Qgd29rZW4gdXAgb3Igbm90LCBz
byB3ZSBjYW4gbm93IGZpZ3VyZSBvdXQgdGhlIGZpbmFsCisJICogcmV0dXJuIHZhbHVlIGJhc2Vk
IG9uIHRoYXQgc3RhdGUgd2l0aG91dCByYWNlcy4KKwkgKgorCSAqIEFsc28gbm90ZSB0aGF0IFdR
X0ZMQUdfV09LRU4gaXMgc3VmZmljaWVudCBmb3IgYSBub24tZXhjbHVzaXZlCisJICogd2FpdGVy
LCBidXQgYW4gZXhjbHVzaXZlIG9uZSByZXF1aXJlcyBXUV9GTEFHX0RPTkUuCiAJICovCisJaWYg
KGJlaGF2aW9yID09IEVYQ0xVU0lWRSkKKwkJcmV0dXJuIHdhaXQtPmZsYWdzICYgV1FfRkxBR19E
T05FID8gMCA6IC1FSU5UUjsKIAogCXJldHVybiB3YWl0LT5mbGFncyAmIFdRX0ZMQUdfV09LRU4g
PyAwIDogLUVJTlRSOwogfQotLSAKMi4yOC4wLjIxOC5nYzEyZWYzZDM0OQoK
--00000000000059775405af49a110--
