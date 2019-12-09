Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A0E11731C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 18:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLIRsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 12:48:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36026 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLIRsu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:48:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id n12so11430535lfe.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 09:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LQ+LMuNUc6UzcbkWxd/rVAV7ZUCn5ppE+1rXFKEHhc=;
        b=CkDKjnxWG4FRbtEbI7ud7XBkCBtyfJArxT9/XBR2xQYpr8HBAqwH2Tf0JminQO2nlV
         x7XlZnDMnvVttfpm0UsAW28SHg3Kafh2gKQ6WiOFSBT48kh6c+G6q6rtBbGrQur6oeXC
         /89sNopGRySvD+a7Wl8ZaN0nqRFhJbctudN9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LQ+LMuNUc6UzcbkWxd/rVAV7ZUCn5ppE+1rXFKEHhc=;
        b=ntR68eAH5WZYKqzpFdAQIrROtFd7CeaAeOZkcKYi/JDPMILn3m4Ub+x/7SDA1RT9Lj
         b1Dlz3B+NjHKPzAPc2IXb8EC+BjsDEz9lNcZz09PEdceeTWH29W5nYM0UaYQMKxkZX2h
         2x2rgoUJa0F4ipOz6OAy3jEmpuuG2GkicD0WZHLABZM6uWU5JnQ7oXHy/kklEWp3x1jE
         G+d856FgkdLDg1fVG6CqieaFKlvjIb0vR8yxv5DmcGYZUTs/xKXY6ZcaGXUsRlbb12Uw
         GDIuyjHNHfYYfkfqB/8z1QB8+uqpWy4ANK3cY1qDXJAYQfHqCJIQF06Cnn0dPo5G0joL
         z3jQ==
X-Gm-Message-State: APjAAAV89OIQklrlciG3Rmik0DAgAEPyW1twOP+N+2OrRkrffMLoHizX
        sb9sxDbWrXo7o/REG/NyluEE9Fkwnhk=
X-Google-Smtp-Source: APXvYqymDPcb6iFGu98qWfLIzZqzGwM2B5JeXVpaWZMi+ERtzh8Pj5X4q6sBtTfHaWlNW/hGzwovEA==
X-Received: by 2002:a19:6a04:: with SMTP id u4mr5944778lfu.62.1575913726116;
        Mon, 09 Dec 2019 09:48:46 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id p4sm283156lji.107.2019.12.09.09.48.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 09:48:44 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id j6so16682965lja.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 09:48:44 -0800 (PST)
X-Received: by 2002:a2e:241a:: with SMTP id k26mr17623229ljk.26.1575913723833;
 Mon, 09 Dec 2019 09:48:43 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com> <CAKfTPtDBtPuvK0NzYC0VZgEhh31drCDN=o+3Hd3fUwoffQg0fw@mail.gmail.com>
In-Reply-To: <CAKfTPtDBtPuvK0NzYC0VZgEhh31drCDN=o+3Hd3fUwoffQg0fw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Dec 2019 09:48:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com>
Message-ID: <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        DJ Delorie <dj@redhat.com>
Cc:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000b4feb20599490119"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000b4feb20599490119
Content-Type: text/plain; charset="UTF-8"

[ Added DJ to the participants, since he seems to be the Fedora make
maintainer - DJ, any chance that this absolutely horrid 'make' buf can
be fixed in older versions too, not just rawhide? The bugfix is two
and a half years old by now, and the bug looks real and very serious ]

On Mon, Dec 9, 2019 at 1:54 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Which version of make should I use to reproduce the problem ?

So the problematic one is "make-4.2.1-13.fc30.x86_64" in Fedora 30.
I'm assuming it's fairly plain 4.2.1, but I didn't try to look into
the source rpm or anything like that.

The working one for me was just the top of -git from

    https://git.savannah.gnu.org/git/make.git

which is 4.2.92 right now.

The fix is presumably commit b552b05 ("[SV 51159] Use a non-blocking
read with pselect to avoid hangs") as per Akemi. That is indeed after
4.2.1, and it looks real.

Before that commit the buggy jobserver code basically does

 (1) use pselect() to wait for readable and see child deaths atomically
 (2) use blocking read to get the token

and while (1) is atomic, if the child death happens between the two,
it goes into the blocking read and has SIGCHLD blocked, so it will try
to read the token from the token pipe, but it will never react to the
child death - and the child death is what is going to _release_ a
token.

So what seems to happen is that when the right timing triggers, you
end up with a lot of sub-makes waiting for a token, but they are also
all supposed to _release_ a token. So you don't have enough tokens to
go around. In the worst case, _everybody_ who has a token is also not
releasing it, and then you end up triggering the timeout code (after
one second), which will make things really go into a crawl.

And by a crawl I mean that worst-case you really end up with just one
job per second per sub-make. It will take _hours_ to compile the
kernel at that speed, when it normally finishes in 15 minutes on my
machine even when I do a from-scratch allmodconfig build.

It does seem to be a major bug in the jobserver code. In particular
with the trial fair and exclusive wakeup patch that I sent out in the
other thread, it seems to be _reliably_ much worse and triggers 100%
of the time for me.

It's possible that my trial patch is buggy, but everything else looks
fine, and with a fixed make the trial patch works for me.

I'll include the trial patch here too, I think I cc'd you on the other
thread too, but hey..

Anyway, it looks like the sync wakeup thing is more of a "get timing
right by luck" thing than anything else. Possibly it actually causes
the reverse order of reader wakeups more often (ie the most _recent_
reader is most likely to get woken up synchronously) and that may be
what really ends up masking the jobserver problem, since apparently
doing wakeups in the fair and proper order makes things much worse..

What a horrible pain that pipe rework ended up being. But I think
we're in better shape now than we used to be, it just had very
unfortunate timing issues and several real bugs.

But sadly, there's no way I can push that fair pipe wakeup thing as
long as this horribly buggy version of make is widespread.

                 Linus

--000000000000b4feb20599490119
Content-Type: application/x-patch; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k3ypp8jm0>
X-Attachment-Id: f_k3ypp8jm0

IGZzL2NvcmVkdW1wLmMgICAgICAgICAgICAgfCAgNCArLS0KIGZzL3BpcGUuYyAgICAgICAgICAg
ICAgICAgfCA2NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LQogZnMvc3BsaWNlLmMgICAgICAgICAgICAgICB8ICA4ICsrKy0tLQogaW5jbHVkZS9saW51eC9w
aXBlX2ZzX2kuaCB8ICAyICstCiA0IGZpbGVzIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyksIDMw
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2NvcmVkdW1wLmMgYi9mcy9jb3JlZHVtcC5j
CmluZGV4IGIxZWE3ZGZiZDE0OS4uZjgyOTZhODJkMDFkIDEwMDY0NAotLS0gYS9mcy9jb3JlZHVt
cC5jCisrKyBiL2ZzL2NvcmVkdW1wLmMKQEAgLTUxNyw3ICs1MTcsNyBAQCBzdGF0aWMgdm9pZCB3
YWl0X2Zvcl9kdW1wX2hlbHBlcnMoc3RydWN0IGZpbGUgKmZpbGUpCiAJcGlwZV9sb2NrKHBpcGUp
OwogCXBpcGUtPnJlYWRlcnMrKzsKIAlwaXBlLT53cml0ZXJzLS07Ci0Jd2FrZV91cF9pbnRlcnJ1
cHRpYmxlX3N5bmMoJnBpcGUtPndhaXQpOworCXdha2VfdXBfaW50ZXJydXB0aWJsZV9zeW5jKCZw
aXBlLT5yZF93YWl0KTsKIAlraWxsX2Zhc3luYygmcGlwZS0+ZmFzeW5jX3JlYWRlcnMsIFNJR0lP
LCBQT0xMX0lOKTsKIAlwaXBlX3VubG9jayhwaXBlKTsKIApAQCAtNTI1LDcgKzUyNSw3IEBAIHN0
YXRpYyB2b2lkIHdhaXRfZm9yX2R1bXBfaGVscGVycyhzdHJ1Y3QgZmlsZSAqZmlsZSkKIAkgKiBX
ZSBhY3R1YWxseSB3YW50IHdhaXRfZXZlbnRfZnJlZXphYmxlKCkgYnV0IHRoZW4gd2UgbmVlZAog
CSAqIHRvIGNsZWFyIFRJRl9TSUdQRU5ESU5HIGFuZCBpbXByb3ZlIGR1bXBfaW50ZXJydXB0ZWQo
KS4KIAkgKi8KLQl3YWl0X2V2ZW50X2ludGVycnVwdGlibGUocGlwZS0+d2FpdCwgcGlwZS0+cmVh
ZGVycyA9PSAxKTsKKwl3YWl0X2V2ZW50X2ludGVycnVwdGlibGUocGlwZS0+cmRfd2FpdCwgcGlw
ZS0+cmVhZGVycyA9PSAxKTsKIAogCXBpcGVfbG9jayhwaXBlKTsKIAlwaXBlLT5yZWFkZXJzLS07
CmRpZmYgLS1naXQgYS9mcy9waXBlLmMgYi9mcy9waXBlLmMKaW5kZXggODcxMDllNzYxZmE1Li4x
ZWI2NGNhYjYzYjUgMTAwNjQ0Ci0tLSBhL2ZzL3BpcGUuYworKysgYi9mcy9waXBlLmMKQEAgLTEw
OCwxNiArMTA4LDE5IEBAIHZvaWQgcGlwZV9kb3VibGVfbG9jayhzdHJ1Y3QgcGlwZV9pbm9kZV9p
bmZvICpwaXBlMSwKIC8qIERyb3AgdGhlIGlub2RlIHNlbWFwaG9yZSBhbmQgd2FpdCBmb3IgYSBw
aXBlIGV2ZW50LCBhdG9taWNhbGx5ICovCiB2b2lkIHBpcGVfd2FpdChzdHJ1Y3QgcGlwZV9pbm9k
ZV9pbmZvICpwaXBlKQogewotCURFRklORV9XQUlUKHdhaXQpOworCURFRklORV9XQUlUKHJkd2Fp
dCk7CisJREVGSU5FX1dBSVQod3J3YWl0KTsKIAogCS8qCiAJICogUGlwZXMgYXJlIHN5c3RlbS1s
b2NhbCByZXNvdXJjZXMsIHNvIHNsZWVwaW5nIG9uIHRoZW0KIAkgKiBpcyBjb25zaWRlcmVkIGEg
bm9uaW50ZXJhY3RpdmUgd2FpdDoKIAkgKi8KLQlwcmVwYXJlX3RvX3dhaXQoJnBpcGUtPndhaXQs
ICZ3YWl0LCBUQVNLX0lOVEVSUlVQVElCTEUpOworCXByZXBhcmVfdG9fd2FpdCgmcGlwZS0+cmRf
d2FpdCwgJnJkd2FpdCwgVEFTS19JTlRFUlJVUFRJQkxFKTsKKwlwcmVwYXJlX3RvX3dhaXQoJnBp
cGUtPndyX3dhaXQsICZ3cndhaXQsIFRBU0tfSU5URVJSVVBUSUJMRSk7CiAJcGlwZV91bmxvY2so
cGlwZSk7CiAJc2NoZWR1bGUoKTsKLQlmaW5pc2hfd2FpdCgmcGlwZS0+d2FpdCwgJndhaXQpOwor
CWZpbmlzaF93YWl0KCZwaXBlLT5yZF93YWl0LCAmcmR3YWl0KTsKKwlmaW5pc2hfd2FpdCgmcGlw
ZS0+d3Jfd2FpdCwgJndyd2FpdCk7CiAJcGlwZV9sb2NrKHBpcGUpOwogfQogCkBAIC0yODYsNyAr
Mjg5LDcgQEAgcGlwZV9yZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICp0
bykKIAlzaXplX3QgdG90YWxfbGVuID0gaW92X2l0ZXJfY291bnQodG8pOwogCXN0cnVjdCBmaWxl
ICpmaWxwID0gaW9jYi0+a2lfZmlscDsKIAlzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlID0g
ZmlscC0+cHJpdmF0ZV9kYXRhOwotCWJvb2wgd2FzX2Z1bGw7CisJYm9vbCB3YXNfZnVsbCwgd2Fr
ZV9uZXh0X3JlYWRlciA9IGZhbHNlOwogCXNzaXplX3QgcmV0OwogCiAJLyogTnVsbCByZWFkIHN1
Y2NlZWRzLiAqLwpAQCAtMzQ0LDEwICszNDcsMTAgQEAgcGlwZV9yZWFkKHN0cnVjdCBraW9jYiAq
aW9jYiwgc3RydWN0IGlvdl9pdGVyICp0bykKIAogCQkJaWYgKCFidWYtPmxlbikgewogCQkJCXBp
cGVfYnVmX3JlbGVhc2UocGlwZSwgYnVmKTsKLQkJCQlzcGluX2xvY2tfaXJxKCZwaXBlLT53YWl0
LmxvY2spOworCQkJCXNwaW5fbG9ja19pcnEoJnBpcGUtPnJkX3dhaXQubG9jayk7CiAJCQkJdGFp
bCsrOwogCQkJCXBpcGUtPnRhaWwgPSB0YWlsOwotCQkJCXNwaW5fdW5sb2NrX2lycSgmcGlwZS0+
d2FpdC5sb2NrKTsKKwkJCQlzcGluX3VubG9ja19pcnEoJnBpcGUtPnJkX3dhaXQubG9jayk7CiAJ
CQl9CiAJCQl0b3RhbF9sZW4gLT0gY2hhcnM7CiAJCQlpZiAoIXRvdGFsX2xlbikKQEAgLTM3MSwx
OSArMzc0LDI0IEBAIHBpcGVfcmVhZChzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRl
ciAqdG8pCiAJCX0KIAkJX19waXBlX3VubG9jayhwaXBlKTsKIAkJaWYgKHdhc19mdWxsKSB7Ci0J
CQl3YWtlX3VwX2ludGVycnVwdGlibGVfc3luY19wb2xsKCZwaXBlLT53YWl0LCBFUE9MTE9VVCB8
IEVQT0xMV1JOT1JNKTsKKwkJCXdha2VfdXBfaW50ZXJydXB0aWJsZV9zeW5jX3BvbGwoJnBpcGUt
PndyX3dhaXQsIEVQT0xMT1VUIHwgRVBPTExXUk5PUk0pOwogCQkJa2lsbF9mYXN5bmMoJnBpcGUt
PmZhc3luY193cml0ZXJzLCBTSUdJTywgUE9MTF9PVVQpOwogCQl9Ci0JCXdhaXRfZXZlbnRfaW50
ZXJydXB0aWJsZShwaXBlLT53YWl0LCBwaXBlX3JlYWRhYmxlKHBpcGUpKTsKKwkJd2FpdF9ldmVu
dF9pbnRlcnJ1cHRpYmxlX2V4Y2x1c2l2ZShwaXBlLT5yZF93YWl0LCBwaXBlX3JlYWRhYmxlKHBp
cGUpKTsKIAkJX19waXBlX2xvY2socGlwZSk7CiAJCXdhc19mdWxsID0gcGlwZV9mdWxsKHBpcGUt
PmhlYWQsIHBpcGUtPnRhaWwsIHBpcGUtPm1heF91c2FnZSk7CisJCXdha2VfbmV4dF9yZWFkZXIg
PSB0cnVlOwogCX0KKwlpZiAocGlwZV9lbXB0eShwaXBlLT5oZWFkLCBwaXBlLT50YWlsKSkKKwkJ
d2FrZV9uZXh0X3JlYWRlciA9IGZhbHNlOwogCV9fcGlwZV91bmxvY2socGlwZSk7CiAKIAlpZiAo
d2FzX2Z1bGwpIHsKLQkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlX3N5bmNfcG9sbCgmcGlwZS0+d2Fp
dCwgRVBPTExPVVQgfCBFUE9MTFdSTk9STSk7CisJCXdha2VfdXBfaW50ZXJydXB0aWJsZV9zeW5j
X3BvbGwoJnBpcGUtPndyX3dhaXQsIEVQT0xMT1VUIHwgRVBPTExXUk5PUk0pOwogCQlraWxsX2Zh
c3luYygmcGlwZS0+ZmFzeW5jX3dyaXRlcnMsIFNJR0lPLCBQT0xMX09VVCk7CiAJfQorCWlmICh3
YWtlX25leHRfcmVhZGVyKQorCQl3YWtlX3VwX2ludGVycnVwdGlibGVfc3luY19wb2xsKCZwaXBl
LT5yZF93YWl0LCBFUE9MTElOIHwgRVBPTExSRE5PUk0pOwogCWlmIChyZXQgPiAwKQogCQlmaWxl
X2FjY2Vzc2VkKGZpbHApOwogCXJldHVybiByZXQ7CkBAIC00MTUsNiArNDIzLDcgQEAgcGlwZV93
cml0ZShzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSkKIAlzaXplX3Qg
dG90YWxfbGVuID0gaW92X2l0ZXJfY291bnQoZnJvbSk7CiAJc3NpemVfdCBjaGFyczsKIAlib29s
IHdhc19lbXB0eSA9IGZhbHNlOworCWJvb2wgd2FrZV9uZXh0X3dyaXRlciA9IGZhbHNlOwogCiAJ
LyogTnVsbCB3cml0ZSBzdWNjZWVkcy4gKi8KIAlpZiAodW5saWtlbHkodG90YWxfbGVuID09IDAp
KQpAQCAtNDkzLDE2ICs1MDIsMTYgQEAgcGlwZV93cml0ZShzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0
cnVjdCBpb3ZfaXRlciAqZnJvbSkKIAkJCSAqIGl0LCBlaXRoZXIgdGhlIHJlYWRlciB3aWxsIGNv
bnN1bWUgaXQgb3IgaXQnbGwgc3RpbGwKIAkJCSAqIGJlIHRoZXJlIGZvciB0aGUgbmV4dCB3cml0
ZS4KIAkJCSAqLwotCQkJc3Bpbl9sb2NrX2lycSgmcGlwZS0+d2FpdC5sb2NrKTsKKwkJCXNwaW5f
bG9ja19pcnEoJnBpcGUtPnJkX3dhaXQubG9jayk7CiAKIAkJCWhlYWQgPSBwaXBlLT5oZWFkOwog
CQkJaWYgKHBpcGVfZnVsbChoZWFkLCBwaXBlLT50YWlsLCBwaXBlLT5tYXhfdXNhZ2UpKSB7Ci0J
CQkJc3Bpbl91bmxvY2tfaXJxKCZwaXBlLT53YWl0LmxvY2spOworCQkJCXNwaW5fdW5sb2NrX2ly
cSgmcGlwZS0+cmRfd2FpdC5sb2NrKTsKIAkJCQljb250aW51ZTsKIAkJCX0KIAogCQkJcGlwZS0+
aGVhZCA9IGhlYWQgKyAxOwotCQkJc3Bpbl91bmxvY2tfaXJxKCZwaXBlLT53YWl0LmxvY2spOwor
CQkJc3Bpbl91bmxvY2tfaXJxKCZwaXBlLT5yZF93YWl0LmxvY2spOwogCiAJCQkvKiBJbnNlcnQg
aXQgaW50byB0aGUgYnVmZmVyIGFycmF5ICovCiAJCQlidWYgPSAmcGlwZS0+YnVmc1toZWFkICYg
bWFza107CkBAIC01NTQsMTQgKzU2MywxNyBAQCBwaXBlX3dyaXRlKHN0cnVjdCBraW9jYiAqaW9j
Yiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKQogCQkgKi8KIAkJX19waXBlX3VubG9jayhwaXBlKTsK
IAkJaWYgKHdhc19lbXB0eSkgewotCQkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlX3N5bmNfcG9sbCgm
cGlwZS0+d2FpdCwgRVBPTExJTiB8IEVQT0xMUkROT1JNKTsKKwkJCXdha2VfdXBfaW50ZXJydXB0
aWJsZV9zeW5jX3BvbGwoJnBpcGUtPnJkX3dhaXQsIEVQT0xMSU4gfCBFUE9MTFJETk9STSk7CiAJ
CQlraWxsX2Zhc3luYygmcGlwZS0+ZmFzeW5jX3JlYWRlcnMsIFNJR0lPLCBQT0xMX0lOKTsKIAkJ
fQotCQl3YWl0X2V2ZW50X2ludGVycnVwdGlibGUocGlwZS0+d2FpdCwgcGlwZV93cml0YWJsZShw
aXBlKSk7CisJCXdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZV9leGNsdXNpdmUocGlwZS0+d3Jfd2Fp
dCwgcGlwZV93cml0YWJsZShwaXBlKSk7CiAJCV9fcGlwZV9sb2NrKHBpcGUpOwogCQl3YXNfZW1w
dHkgPSBwaXBlX2VtcHR5KGhlYWQsIHBpcGUtPnRhaWwpOworCQl3YWtlX25leHRfd3JpdGVyID0g
dHJ1ZTsKIAl9CiBvdXQ6CisJaWYgKHBpcGVfZnVsbChwaXBlLT5oZWFkLCBwaXBlLT50YWlsLCBw
aXBlLT5tYXhfdXNhZ2UpKQorCQl3YWtlX25leHRfd3JpdGVyID0gZmFsc2U7CiAJX19waXBlX3Vu
bG9jayhwaXBlKTsKIAogCS8qCkBAIC01NzQsOSArNTg2LDExIEBAIHBpcGVfd3JpdGUoc3RydWN0
IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20pCiAJICogd2FrZSB1cCBwZW5kaW5n
IGpvYnMKIAkgKi8KIAlpZiAod2FzX2VtcHR5KSB7Ci0JCXdha2VfdXBfaW50ZXJydXB0aWJsZV9z
eW5jX3BvbGwoJnBpcGUtPndhaXQsIEVQT0xMSU4gfCBFUE9MTFJETk9STSk7CisJCXdha2VfdXBf
aW50ZXJydXB0aWJsZV9zeW5jX3BvbGwoJnBpcGUtPnJkX3dhaXQsIEVQT0xMSU4gfCBFUE9MTFJE
Tk9STSk7CiAJCWtpbGxfZmFzeW5jKCZwaXBlLT5mYXN5bmNfcmVhZGVycywgU0lHSU8sIFBPTExf
SU4pOwogCX0KKwlpZiAod2FrZV9uZXh0X3dyaXRlcikKKwkJd2FrZV91cF9pbnRlcnJ1cHRpYmxl
X3N5bmNfcG9sbCgmcGlwZS0+d3Jfd2FpdCwgRVBPTExPVVQgfCBFUE9MTFdSTk9STSk7CiAJaWYg
KHJldCA+IDAgJiYgc2Jfc3RhcnRfd3JpdGVfdHJ5bG9jayhmaWxlX2lub2RlKGZpbHApLT5pX3Ni
KSkgewogCQlpbnQgZXJyID0gZmlsZV91cGRhdGVfdGltZShmaWxwKTsKIAkJaWYgKGVycikKQEAg
LTYyMCwxMiArNjM0LDE1IEBAIHBpcGVfcG9sbChzdHJ1Y3QgZmlsZSAqZmlscCwgcG9sbF90YWJs
ZSAqd2FpdCkKIAl1bnNpZ25lZCBpbnQgaGVhZCwgdGFpbDsKIAogCS8qCi0JICogUmVhZGluZyBv
bmx5IC0tIG5vIG5lZWQgZm9yIGFjcXVpcmluZyB0aGUgc2VtYXBob3JlLgorCSAqIFJlYWRpbmcg
cGlwZSBzdGF0ZSBvbmx5IC0tIG5vIG5lZWQgZm9yIGFjcXVpcmluZyB0aGUgc2VtYXBob3JlLgog
CSAqCiAJICogQnV0IGJlY2F1c2UgdGhpcyBpcyByYWN5LCB0aGUgY29kZSBoYXMgdG8gYWRkIHRo
ZQogCSAqIGVudHJ5IHRvIHRoZSBwb2xsIHRhYmxlIF9maXJzdF8gLi4KIAkgKi8KLQlwb2xsX3dh
aXQoZmlscCwgJnBpcGUtPndhaXQsIHdhaXQpOworCWlmIChmaWxwLT5mX21vZGUgJiBGTU9ERV9S
RUFEKQorCQlwb2xsX3dhaXQoZmlscCwgJnBpcGUtPnJkX3dhaXQsIHdhaXQpOworCWlmIChmaWxw
LT5mX21vZGUgJiBGTU9ERV9XUklURSkKKwkJcG9sbF93YWl0KGZpbHAsICZwaXBlLT53cl93YWl0
LCB3YWl0KTsKIAogCS8qCiAJICogLi4gYW5kIG9ubHkgdGhlbiBjYW4geW91IGRvIHRoZSByYWN5
IHRlc3RzLiBUaGF0IHdheSwKQEAgLTY4NCw3ICs3MDEsOCBAQCBwaXBlX3JlbGVhc2Uoc3RydWN0
IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiAJCXBpcGUtPndyaXRlcnMtLTsKIAog
CWlmIChwaXBlLT5yZWFkZXJzIHx8IHBpcGUtPndyaXRlcnMpIHsKLQkJd2FrZV91cF9pbnRlcnJ1
cHRpYmxlX3N5bmNfcG9sbCgmcGlwZS0+d2FpdCwgRVBPTExJTiB8IEVQT0xMT1VUIHwgRVBPTExS
RE5PUk0gfCBFUE9MTFdSTk9STSB8IEVQT0xMRVJSIHwgRVBPTExIVVApOworCQl3YWtlX3VwX2lu
dGVycnVwdGlibGVfc3luY19wb2xsKCZwaXBlLT5yZF93YWl0LCBFUE9MTElOIHwgRVBPTExSRE5P
Uk0gfCBFUE9MTEVSUiB8IEVQT0xMSFVQKTsKKwkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlX3N5bmNf
cG9sbCgmcGlwZS0+d3Jfd2FpdCwgRVBPTExPVVQgfCBFUE9MTFdSTk9STSB8IEVQT0xMRVJSIHwg
RVBPTExIVVApOwogCQlraWxsX2Zhc3luYygmcGlwZS0+ZmFzeW5jX3JlYWRlcnMsIFNJR0lPLCBQ
T0xMX0lOKTsKIAkJa2lsbF9mYXN5bmMoJnBpcGUtPmZhc3luY193cml0ZXJzLCBTSUdJTywgUE9M
TF9PVVQpOwogCX0KQEAgLTc2Nyw3ICs3ODUsOCBAQCBzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICph
bGxvY19waXBlX2luZm8odm9pZCkKIAkJCSAgICAgR0ZQX0tFUk5FTF9BQ0NPVU5UKTsKIAogCWlm
IChwaXBlLT5idWZzKSB7Ci0JCWluaXRfd2FpdHF1ZXVlX2hlYWQoJnBpcGUtPndhaXQpOworCQlp
bml0X3dhaXRxdWV1ZV9oZWFkKCZwaXBlLT5yZF93YWl0KTsKKwkJaW5pdF93YWl0cXVldWVfaGVh
ZCgmcGlwZS0+d3Jfd2FpdCk7CiAJCXBpcGUtPnJfY291bnRlciA9IHBpcGUtPndfY291bnRlciA9
IDE7CiAJCXBpcGUtPm1heF91c2FnZSA9IHBpcGVfYnVmczsKIAkJcGlwZS0+cmluZ19zaXplID0g
cGlwZV9idWZzOwpAQCAtOTg1LDcgKzEwMDQsOCBAQCBzdGF0aWMgaW50IHdhaXRfZm9yX3BhcnRu
ZXIoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSwgdW5zaWduZWQgaW50ICpjbnQpCiAKIHN0
YXRpYyB2b2lkIHdha2VfdXBfcGFydG5lcihzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlKQog
ewotCXdha2VfdXBfaW50ZXJydXB0aWJsZSgmcGlwZS0+d2FpdCk7CisJd2FrZV91cF9pbnRlcnJ1
cHRpYmxlKCZwaXBlLT5yZF93YWl0KTsKKwl3YWtlX3VwX2ludGVycnVwdGlibGUoJnBpcGUtPndy
X3dhaXQpOwogfQogCiBzdGF0aWMgaW50IGZpZm9fb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBz
dHJ1Y3QgZmlsZSAqZmlscCkKQEAgLTEwOTYsMTMgKzExMTYsMTMgQEAgc3RhdGljIGludCBmaWZv
X29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbHApCiAKIGVycl9yZDoK
IAlpZiAoIS0tcGlwZS0+cmVhZGVycykKLQkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZwaXBlLT53
YWl0KTsKKwkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZwaXBlLT53cl93YWl0KTsKIAlyZXQgPSAt
RVJFU1RBUlRTWVM7CiAJZ290byBlcnI7CiAKIGVycl93cjoKIAlpZiAoIS0tcGlwZS0+d3JpdGVy
cykKLQkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZwaXBlLT53YWl0KTsKKwkJd2FrZV91cF9pbnRl
cnJ1cHRpYmxlKCZwaXBlLT5yZF93YWl0KTsKIAlyZXQgPSAtRVJFU1RBUlRTWVM7CiAJZ290byBl
cnI7CiAKQEAgLTEyMjksNyArMTI0OSw4IEBAIHN0YXRpYyBsb25nIHBpcGVfc2V0X3NpemUoc3Ry
dWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSwgdW5zaWduZWQgbG9uZyBhcmcpCiAJcGlwZS0+bWF4
X3VzYWdlID0gbnJfc2xvdHM7CiAJcGlwZS0+dGFpbCA9IHRhaWw7CiAJcGlwZS0+aGVhZCA9IGhl
YWQ7Ci0Jd2FrZV91cF9pbnRlcnJ1cHRpYmxlX2FsbCgmcGlwZS0+d2FpdCk7CisJd2FrZV91cF9p
bnRlcnJ1cHRpYmxlX2FsbCgmcGlwZS0+cmRfd2FpdCk7CisJd2FrZV91cF9pbnRlcnJ1cHRpYmxl
X2FsbCgmcGlwZS0+d3Jfd2FpdCk7CiAJcmV0dXJuIHBpcGUtPm1heF91c2FnZSAqIFBBR0VfU0la
RTsKIAogb3V0X3JldmVydF9hY2N0OgpkaWZmIC0tZ2l0IGEvZnMvc3BsaWNlLmMgYi9mcy9zcGxp
Y2UuYwppbmRleCAzMDA5NjUyYTQxYzguLmQ2NzE5MzZkMGFhZCAxMDA2NDQKLS0tIGEvZnMvc3Bs
aWNlLmMKKysrIGIvZnMvc3BsaWNlLmMKQEAgLTE2NSw4ICsxNjUsOCBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHBpcGVfYnVmX29wZXJhdGlvbnMgdXNlcl9wYWdlX3BpcGVfYnVmX29wcyA9IHsKIHN0
YXRpYyB2b2lkIHdha2V1cF9waXBlX3JlYWRlcnMoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlw
ZSkKIHsKIAlzbXBfbWIoKTsKLQlpZiAod2FpdHF1ZXVlX2FjdGl2ZSgmcGlwZS0+d2FpdCkpCi0J
CXdha2VfdXBfaW50ZXJydXB0aWJsZSgmcGlwZS0+d2FpdCk7CisJaWYgKHdhaXRxdWV1ZV9hY3Rp
dmUoJnBpcGUtPnJkX3dhaXQpKQorCQl3YWtlX3VwX2ludGVycnVwdGlibGUoJnBpcGUtPnJkX3dh
aXQpOwogCWtpbGxfZmFzeW5jKCZwaXBlLT5mYXN5bmNfcmVhZGVycywgU0lHSU8sIFBPTExfSU4p
OwogfQogCkBAIC00NjIsOCArNDYyLDggQEAgc3RhdGljIGludCBwaXBlX3RvX3NlbmRwYWdlKHN0
cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUsCiBzdGF0aWMgdm9pZCB3YWtldXBfcGlwZV93cml0
ZXJzKHN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUpCiB7CiAJc21wX21iKCk7Ci0JaWYgKHdh
aXRxdWV1ZV9hY3RpdmUoJnBpcGUtPndhaXQpKQotCQl3YWtlX3VwX2ludGVycnVwdGlibGUoJnBp
cGUtPndhaXQpOworCWlmICh3YWl0cXVldWVfYWN0aXZlKCZwaXBlLT53cl93YWl0KSkKKwkJd2Fr
ZV91cF9pbnRlcnJ1cHRpYmxlKCZwaXBlLT53cl93YWl0KTsKIAlraWxsX2Zhc3luYygmcGlwZS0+
ZmFzeW5jX3dyaXRlcnMsIFNJR0lPLCBQT0xMX09VVCk7CiB9CiAKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvcGlwZV9mc19pLmggYi9pbmNsdWRlL2xpbnV4L3BpcGVfZnNfaS5oCmluZGV4IGRi
Y2ZhNjg5MjM4NC4uZDU3NjUwMzk2NTJhIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3BpcGVf
ZnNfaS5oCisrKyBiL2luY2x1ZGUvbGludXgvcGlwZV9mc19pLmgKQEAgLTQ3LDcgKzQ3LDcgQEAg
c3RydWN0IHBpcGVfYnVmZmVyIHsKICAqKi8KIHN0cnVjdCBwaXBlX2lub2RlX2luZm8gewogCXN0
cnVjdCBtdXRleCBtdXRleDsKLQl3YWl0X3F1ZXVlX2hlYWRfdCB3YWl0OworCXdhaXRfcXVldWVf
aGVhZF90IHJkX3dhaXQsIHdyX3dhaXQ7CiAJdW5zaWduZWQgaW50IGhlYWQ7CiAJdW5zaWduZWQg
aW50IHRhaWw7CiAJdW5zaWduZWQgaW50IG1heF91c2FnZTsK
--000000000000b4feb20599490119--
