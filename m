Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB7162D85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgBRRzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:55:20 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46725 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgBRRzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:55:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id x14so23985770ljd.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2020 09:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IxPM9qbKacJo32I7q0izB6enJdesl8gGck2uZJzx0m4=;
        b=bPkzFbVoN988JuGgeawOfoYtQ3gEIUluZ6B4429WQYWTNA5rdi1w1Od57v6QxoSd8a
         JbppmaXMsRLVxcyP/uKNUgCnX/ZXBWzvXBp1KF/k8T15bCdwWDEac5TmDEUl8iHL6Y6t
         XkfktNTFPje1RtVnpB8nqi0NDZmgBx0gPF4HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxPM9qbKacJo32I7q0izB6enJdesl8gGck2uZJzx0m4=;
        b=qNXDfok17LBIwMxyl8SqH9mBOeV6qvkdt3FNoD8nek61anttTIVQLhiG/jptffIc9i
         VQ2p6DFMf3RVwESQQpQbAclmfaOlL8WL5gA7kpVSh4ID7kEqc+dSp3lRGVkhQoQyGSGT
         z3lxLp8N3YuwNK3GLW7gbLidH3vy4Cfco6FuODBD7XWduLLGPBTqG2sFvmQ4ZiPmDr8F
         pLo5BbHHYgONOptFwVKvnHuyektp7OyrubRPbawOLRMt3zIQUqyvX9n3OyGGiIgTATz/
         JQW/u5EDRH5qvNdjC67lPDTdPsLN3CUSjS5G13qYI/Dlr6zHzJJ/3fKXWSGhFIYMw8w1
         vBBg==
X-Gm-Message-State: APjAAAUYriUADgakq9TgSg+yYcide/DwtspFKje8xeItS/ZfPfO4g0D/
        gyhdNaP6L/14QAhZCyNgG17qNe3TbYc=
X-Google-Smtp-Source: APXvYqwMerXCViRvuxNEYxdC1X7pSltn/5McU7KYDfpHqY9vhwKlWXpf3nW8scHskytrVeKus22Stg==
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr13762040ljj.4.1582048517009;
        Tue, 18 Feb 2020 09:55:17 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r10sm3249329ljk.9.2020.02.18.09.55.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 09:55:15 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id q8so23952003ljj.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2020 09:55:14 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr13232782ljj.241.1582048514190;
 Tue, 18 Feb 2020 09:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20200214154854.6746-1-sashal@kernel.org> <20200214154854.6746-542-sashal@kernel.org>
 <CANaxB-zjYecWpjMoX6dXY3B5HtVu8+G9npRnaX2FnTvp9XucTw@mail.gmail.com> <CAHk-=wjd6BKXEpU0MfEaHuOEK-StRToEcYuu6NpVfR0tR5d6xw@mail.gmail.com>
In-Reply-To: <CAHk-=wjd6BKXEpU0MfEaHuOEK-StRToEcYuu6NpVfR0tR5d6xw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Feb 2020 09:54:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgs8E4JYVJHaRV2hMn3dxUnM8i0Kn2mA1SjzJdsbB9tXw@mail.gmail.com>
Message-ID: <CAHk-=wgs8E4JYVJHaRV2hMn3dxUnM8i0Kn2mA1SjzJdsbB9tXw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.5 542/542] pipe: use exclusive waits when
 reading or writing
To:     Andrei Vagin <avagin@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        stable <stable@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000b4dda2059edd5fc7"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000b4dda2059edd5fc7
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 18, 2020 at 9:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The things that change the number of readers or writers should simply
> use "wake_up_all()".
>
> So I think the right fix is the attached patch. Since you had such a
> lovely test-case, let me go test it too ;)

Good that I did. I missed the _real_ case of this - pipe_release().
Because that used a different wakeup function.

In fact, that case uses wake_up_interruptible_sync_poll(), which
doesn't have the "all" version.

But it doesn't actually need that fancy thing, since it's only meant
for "let's avoid waking up things that don't need these poll keys",
and the whole point is that now we're closing the pipe so we should
wake up everybody.

And in fact the test for "are there readers or writers" was
nonsensical. We shouldn't wake up readers just because they still
exist. We should wake up readers only if they exist, _and_ there are
no writers left (and vice versa).

Anyway, new patch attached. This hasn't been tested either, but I'll
let you know if it's broken too ;)

                  Linus

--000000000000b4dda2059edd5fc7
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k6s6tp0o0>
X-Attachment-Id: f_k6s6tp0o0

IGZzL3BpcGUuYyB8IDE3ICsrKysrKysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNl
cnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3BpcGUuYyBiL2ZzL3Bp
cGUuYwppbmRleCA1YTM0ZDZjMjJkNGMuLjg5ZDU0YzE5MTFmZSAxMDA2NDQKLS0tIGEvZnMvcGlw
ZS5jCisrKyBiL2ZzL3BpcGUuYwpAQCAtNzIyLDkgKzcyMiwxMCBAQCBwaXBlX3JlbGVhc2Uoc3Ry
dWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiAJaWYgKGZpbGUtPmZfbW9kZSAm
IEZNT0RFX1dSSVRFKQogCQlwaXBlLT53cml0ZXJzLS07CiAKLQlpZiAocGlwZS0+cmVhZGVycyB8
fCBwaXBlLT53cml0ZXJzKSB7Ci0JCXdha2VfdXBfaW50ZXJydXB0aWJsZV9zeW5jX3BvbGwoJnBp
cGUtPnJkX3dhaXQsIEVQT0xMSU4gfCBFUE9MTFJETk9STSB8IEVQT0xMRVJSIHwgRVBPTExIVVAp
OwotCQl3YWtlX3VwX2ludGVycnVwdGlibGVfc3luY19wb2xsKCZwaXBlLT53cl93YWl0LCBFUE9M
TE9VVCB8IEVQT0xMV1JOT1JNIHwgRVBPTExFUlIgfCBFUE9MTEhVUCk7CisJLyogV2FzIHRoYXQg
dGhlIGxhc3QgcmVhZGVyIG9yIHdyaXRlciwgYnV0IG5vdCB0aGUgb3RoZXIgc2lkZT8gKi8KKwlp
ZiAoIXBpcGUtPnJlYWRlcnMgIT0gIXBpcGUtPndyaXRlcnMpIHsKKwkJd2FrZV91cF9pbnRlcnJ1
cHRpYmxlX2FsbCgmcGlwZS0+cmRfd2FpdCk7CisJCXdha2VfdXBfaW50ZXJydXB0aWJsZV9hbGwo
JnBpcGUtPndyX3dhaXQpOwogCQlraWxsX2Zhc3luYygmcGlwZS0+ZmFzeW5jX3JlYWRlcnMsIFNJ
R0lPLCBQT0xMX0lOKTsKIAkJa2lsbF9mYXN5bmMoJnBpcGUtPmZhc3luY193cml0ZXJzLCBTSUdJ
TywgUE9MTF9PVVQpOwogCX0KQEAgLTEwMjYsOCArMTAyNyw4IEBAIHN0YXRpYyBpbnQgd2FpdF9m
b3JfcGFydG5lcihzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlLCB1bnNpZ25lZCBpbnQgKmNu
dCkKIAogc3RhdGljIHZvaWQgd2FrZV91cF9wYXJ0bmVyKHN0cnVjdCBwaXBlX2lub2RlX2luZm8g
KnBpcGUpCiB7Ci0Jd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZwaXBlLT5yZF93YWl0KTsKLQl3YWtl
X3VwX2ludGVycnVwdGlibGUoJnBpcGUtPndyX3dhaXQpOworCXdha2VfdXBfaW50ZXJydXB0aWJs
ZV9hbGwoJnBpcGUtPnJkX3dhaXQpOworCXdha2VfdXBfaW50ZXJydXB0aWJsZV9hbGwoJnBpcGUt
PndyX3dhaXQpOwogfQogCiBzdGF0aWMgaW50IGZpZm9fb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBzdHJ1Y3QgZmlsZSAqZmlscCkKQEAgLTExNDQsNyArMTE0NSw3IEBAIHN0YXRpYyBpbnQgZmlm
b19vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxwKQogCiBlcnJfd3I6
CiAJaWYgKCEtLXBpcGUtPndyaXRlcnMpCi0JCXdha2VfdXBfaW50ZXJydXB0aWJsZSgmcGlwZS0+
cmRfd2FpdCk7CisJCXdha2VfdXBfaW50ZXJydXB0aWJsZV9hbGwoJnBpcGUtPnJkX3dhaXQpOwog
CXJldCA9IC1FUkVTVEFSVFNZUzsKIAlnb3RvIGVycjsKIApAQCAtMTI3MSw4ICsxMjcyLDggQEAg
c3RhdGljIGxvbmcgcGlwZV9zZXRfc2l6ZShzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlLCB1
bnNpZ25lZCBsb25nIGFyZykKIAlwaXBlLT5tYXhfdXNhZ2UgPSBucl9zbG90czsKIAlwaXBlLT50
YWlsID0gdGFpbDsKIAlwaXBlLT5oZWFkID0gaGVhZDsKLQl3YWtlX3VwX2ludGVycnVwdGlibGVf
YWxsKCZwaXBlLT5yZF93YWl0KTsKLQl3YWtlX3VwX2ludGVycnVwdGlibGVfYWxsKCZwaXBlLT53
cl93YWl0KTsKKwl3YWtlX3VwX2ludGVycnVwdGlibGUoJnBpcGUtPnJkX3dhaXQpOworCXdha2Vf
dXBfaW50ZXJydXB0aWJsZSgmcGlwZS0+d3Jfd2FpdCk7CiAJcmV0dXJuIHBpcGUtPm1heF91c2Fn
ZSAqIFBBR0VfU0laRTsKIAogb3V0X3JldmVydF9hY2N0Ogo=
--000000000000b4dda2059edd5fc7--
