Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2841A0EC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 15:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgDGN72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 09:59:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37750 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgDGN71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:59:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id de14so4170249edb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2020 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqe/lMioF3rr7wkki1S9O6T9iLt/kpYKFjZ4BIclciI=;
        b=oQwNAlq9uQG76hiuQGtYOS4ARo5k2jRQs+ucBz94VaHpekKqE/9uqAFc2SF65Kdcw6
         oGrB7s34Y2/T2DjNsS4ihYg1zhOQLEno2Agos53yevyTP1T6kV0ZNyJhq5GDYE8+gRSC
         K8qe3ZfLPMfc498lE5Jbya6N3qj98NAhuMqfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqe/lMioF3rr7wkki1S9O6T9iLt/kpYKFjZ4BIclciI=;
        b=W/YiGhT8YBCzNRB0oM2XUKLnYcOpOAAXDB01C4StRTt2m2/mgeSPvZlLdOe5HammSo
         aWDYh3X4S9RYlAmG/Qw/tTjta1psvpB+J1MJWKOv/6aTzh7oaNo/KXo/jGmMsv6XGJz6
         t49cFWVWeb23pnqN1mFaW9ZRE1EHgeC85ro44B53L5MB0kqwQBOg+0n+Q9Pqj7KRBZ+5
         s7BQP4ELOcJC2zJHmr6HtvaFxd95OOttYrEsmOY00C1SL7O/sCSFeUJ2REZ+4q5Wq7av
         yE1g4c/ivKev+iRelwbJsHj6Yn5fd0jVqXUK4BULsRIpp0mD/KREyq53zj+wsPElkPJW
         DQNg==
X-Gm-Message-State: AGi0PuYpGr92Yxp0ucwVcx3atJ3H9anj6fQMleVh9x2iHrexGGZfvXC7
        O8c4DbE9/odEwn05qLudxE5JUzulpt3qJ9iMJ1OZlw==
X-Google-Smtp-Source: APiQypJ/lpfvkrxltKAShH8KskIPyKjaVvMHi0AGOqarLBgt/23p7UMVEZJffNchoZveGw1Hgmf0fjf+YrhtEaOWXq0=
X-Received: by 2002:a17:906:fd7:: with SMTP id c23mr2234448ejk.312.1586267962932;
 Tue, 07 Apr 2020 06:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
 <20200402152831.GA31612@gardel-login> <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login> <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
 <20200403110842.GA34663@gardel-login> <CAJfpegtYKhXB-HNddUeEMKupR5L=RRuydULrvm39eTung0=yRg@mail.gmail.com>
 <20200403150143.GA34800@gardel-login> <CAJfpegudLD8F-25k-k=9G96JKB+5Y=xFT=ZMwiBkNTwkjMDumA@mail.gmail.com>
 <20200406172917.GA37692@gardel-login> <a4b5828d73ff097794f63f5f9d0fd1532067941c.camel@themaw.net>
In-Reply-To: <a4b5828d73ff097794f63f5f9d0fd1532067941c.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Apr 2020 15:59:10 +0200
Message-ID: <CAJfpegvYGB01i9eqCH-95Ynqy0P=CuxPCSAbSpBPa-TV8iXN0Q@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Ian Kent <raven@themaw.net>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Content-Type: multipart/mixed; boundary="000000000000733b8805a2b3ca6b"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000733b8805a2b3ca6b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2020 at 4:22 AM Ian Kent <raven@themaw.net> wrote:
> > Right now, when you have n mounts, and any mount changes, or one is
> > added or removed then we have to parse the whole mount table again,
> > asynchronously, processing all n entries again, every frickin
> > time. This means the work to process n mounts popping up at boot is
> > O(n=C2=B2). That sucks, it should be obvious to anyone. Now if we get t=
hat
> > fixed, by some mount API that can send us minimal notifications about
> > what happened and where, then this becomes O(n), which is totally OK.

Something's not right with the above statement.  Hint: if there are
lots of events in quick succession, you can batch them quite easily to
prevent overloading the system.

Wrote a pair of utilities to check out the capabilities of the current
API.   The first one just creates N mounts, optionally sleeping
between each.  The second one watches /proc/self/mountinfo and
generates individual (add/del/change) events based on POLLPRI and
comparing contents with previous instance.

First use case: create 10,000 mounts, then start the watcher and
create 1000 mounts with a 50ms sleep between them.  Total time (user +
system) consumed by the watcher: 25s.  This is indeed pretty dismal,
and a per-mount query will help tremendously.  But it's still "just"
25ms per mount, so if the mounts are far apart (which is what this
test is about), this won't thrash the system.  Note, how this is self
regulating: if the load is high, it will automatically batch more
requests, preventing overload.  It is also prone to lose pairs of add
+ remove in these case (and so is the ring buffer based one from
David).

Second use case: start the watcher and create 50,000 mounts with no
sleep between them.   Total time consumed by the watcher: 0.154s or
3.08us/event.    Note, the same test case adds about 5ms for the
50,000 umount events, which is 0.1us/event.

Real life will probably be between these extremes, but it's clear that
there's room for improvement in userspace as well as kernel
interfaces.  The current kernel interface is very efficient in
retrieving a lot of state in one go.  It is not efficient in handling
small differences.

> > Anyway, I have the suspicion this discussion has stopped being
> > useful. I think you are trying to fix problems that userspce actually
> > doesn't have. I can just tell you what we understand the problems
> > are,
> > but if you are out trying to fix other percieved ones, then great,
> > but
> > I mostly lost interest.

I was, and still am, trying to see the big picture.

Whatever.   I think it's your turn to show some numbers about how the
new API improves performance of systemd with a large number of mounts.

Thanks,
Miklos

--000000000000733b8805a2b3ca6b
Content-Type: text/x-csrc; charset="US-ASCII"; name="many-mounts.c"
Content-Disposition: attachment; filename="many-mounts.c"
Content-Transfer-Encoding: base64
Content-ID: <f_k8pyrb060>
X-Attachment-Id: f_k8pyrb060

I2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+
CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPGVyci5oPgojaW5jbHVkZSA8c3lzL3N0YXQu
aD4KI2luY2x1ZGUgPHN5cy9tb3VudC5oPgoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3Zb
XSkKewoJY2hhciAqYmFzZV9wYXRoID0gYXJndlsxXTsKCWNoYXIgbmFtZVs0MDk2XTsKCWludCBu
cl9tb3VudHMsIGksIHNsZWVwX21zID0gMDsKCglpZiAoYXJnYyA8IDMgfHwgYXJnYyA+IDQpCgkJ
ZXJyeCgxLCAidXNhZ2U6ICVzIGJhc2VfcGF0aCBucl9tb3VudHMgW3NsZWVwX21zXSIsIGFyZ3Zb
MF0pOwoKCW5yX21vdW50cyA9IGF0b2koYXJndlsyXSk7CglpZiAoYXJnYyA+IDMpCgkJc2xlZXBf
bXMgPSBhdG9pKGFyZ3ZbM10pOwoKCWZwcmludGYoc3RkZXJyLCAiTW91bnRpbmcuLi5cbiIpOwoJ
aWYgKG1vdW50KCJub25lIiwgYmFzZV9wYXRoLCAidG1wZnMiLCAwLCBOVUxMKSA9PSAtMSkKCQll
cnIoMSwgIm1vdW50L3RtcGZzIik7CglpZiAobW91bnQoIm5vbmUiLCBiYXNlX3BhdGgsIE5VTEws
IE1TX1BSSVZBVEUsIE5VTEwpID09IC0xKQoJCWVycigxLCAibW91bnQvTVNfUFJJVkFURSIpOwoJ
Zm9yIChpID0gMDsgaSA8IG5yX21vdW50czsgaSsrKSB7CgkJc3ByaW50ZihuYW1lLCAiJXMvJWQi
LCBiYXNlX3BhdGgsIGkpOwoJCWlmIChta2RpcihuYW1lLCAwNzU1KSA9PSAtMSkKCQkJZXJyKDEs
ICJta2RpciIpOwoJCWlmIChtb3VudCgibm9uZSIsIG5hbWUsICJ0bXBmcyIsIDAsIE5VTEwpID09
IC0xKQoJCQllcnIoMSwgIm1vdW50L3RtcGZzIik7CgkJaWYgKG1vdW50KCJub25lIiwgbmFtZSwg
TlVMTCwgTVNfUFJJVkFURSwgTlVMTCkgPT0gLTEpCgkJCWVycigxLCAibW91bnQvTVNfUFJJVkFU
RSIpOwoJCWlmIChzbGVlcF9tcykKCQkJdXNsZWVwKHNsZWVwX21zICogMTAwMCk7Cgl9CglmcHJp
bnRmKHN0ZGVyciwgIlByZXNzIEVOVEVSXG4iKTsKCWdldGNoYXIoKTsKCglmcHJpbnRmKHN0ZGVy
ciwgIlVubW91bnRpbmcuLi5cbiIpOwoJaWYgKHVtb3VudDIoYmFzZV9wYXRoLCBNTlRfREVUQUNI
KSA9PSAtMSkKCQllcnIoMSwgInVtb3VudCIpOwoKCWZwcmludGYoc3RkZXJyLCAiRG9uZVxuIik7
CgoJcmV0dXJuIDA7Cn0K
--000000000000733b8805a2b3ca6b
Content-Type: text/x-csrc; charset="US-ASCII"; name="watch_mounts.c"
Content-Disposition: attachment; filename="watch_mounts.c"
Content-Transfer-Encoding: base64
Content-ID: <f_k8pyrjxu1>
X-Attachment-Id: f_k8pyrjxu1

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8c3RyaW5nLmg+
CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8cG9sbC5o
PgojaW5jbHVkZSA8ZXJyLmg+CgpzdHJ1Y3QgaW5kZXggewoJc3RydWN0IGluZGV4ICpuZXh0OwoJ
c3RydWN0IGluZGV4ICpwcmV2OwoJY29uc3QgY2hhciAqbGluZTsKfTsKCnN0cnVjdCBzdGF0ZSB7
CglzaXplX3QgYnVmc2l6ZTsKCWNoYXIgKmJ1ZjsKCXNpemVfdCBpbmRleF9zaXplOwoJc3RydWN0
IGluZGV4ICppbmRleDsKCXN0cnVjdCBpbmRleCBoZWFkOwp9OwoKc3RhdGljIHZvaWQgcmVhZF9t
b3VudGluZm8oc3RydWN0IHBvbGxmZCAqcGZkLCBjaGFyICpidWYsIHNpemVfdCBidWZzaXplKQp7
CglpbnQgcmVhZGNudCwgYmFja29mZiA9IDAsIHJldHJ5ID0gMDsKCXNpemVfdCBsZW47Cglzc2l6
ZV90IHJlczsKCnJldHJ5OgoJaWYgKGxzZWVrKHBmZC0+ZmQsIDAsIFNFRUtfU0VUKSA9PSAob2Zm
X3QpIC0xKQoJCWVycigxLCAibHNlZWsiKTsKCWxlbiA9IDA7CglyZWFkY250ID0gMDsKCWRvIHsK
CQlpZiAobGVuID49IGJ1ZnNpemUgLSA0MDk2KQoJCQllcnJ4KDEsICJidWZmZXIgb3ZlcnJ1biIp
OwoJCXJlcyA9IHJlYWQocGZkLT5mZCwgYnVmICsgbGVuLCBidWZzaXplIC0gbGVuKTsKCQlpZiAo
cmVzID09IC0xKQoJCQllcnIoMSwgInJlYWQiKTsKCQlsZW4gKz0gcmVzOwoKCQlpZiAoIXJlcyB8
fCAhKCsrcmVhZGNudCAlIDE2KSkgewoJCQlpZiAocG9sbChwZmQsIDEsIDApID09IC0xKQoJCQkJ
ZXJyKDEsICJwb2xsLzAiKTsKCQkJaWYgKHBmZC0+cmV2ZW50cyAmIFBPTExQUkkpIHsKCQkJCWlm
ICghYmFja29mZikgewoJCQkJCWJhY2tvZmYrKzsKCQkJCQlnb3RvIHJldHJ5OwoJCQkJfQoJCQkJ
aWYgKCFyZXRyeSkgewoJCQkJCWZwcmludGYoc3RkZXJyLCAicmV0cnkuIik7CgkJCQkJcmV0cnkg
PSAxOwoJCQkJfQoJCQkJZG8gewoJCQkJCXVzbGVlcChiYWNrb2ZmICogMTAwMCk7CgkJCQkJaWYg
KGJhY2tvZmYgPCAxMjgpCgkJCQkJCWJhY2tvZmYgKj0gMjsKCQkJCQlpZiAocG9sbChwZmQsIDEs
IDApID09IC0xKQoJCQkJCQllcnIoMSwgInBvbGwvMCIpOwoJCQkJfSB3aGlsZSAocGZkLT5yZXZl
bnRzICYgUE9MTFBSSSk7CgkJCQlnb3RvIHJldHJ5OwoJCQl9CgkJfQoJfSB3aGlsZSAocmVzKTsK
CWJ1ZltsZW5dID0gJ1wwJzsKCglpZiAocmV0cnkpIHsKCQlmcHJpbnRmKHN0ZGVyciwgIi4uXG4i
KTsKCQlyZXRyeSA9IDA7Cgl9Cn0KCnN0YXRpYyB2b2lkIGFkZF9pbmRleChzdHJ1Y3Qgc3RhdGUg
KnMsIHN0cnVjdCBpbmRleCAqdGhpcywgY29uc3QgY2hhciAqbGluZSkKewoJc3RydWN0IGluZGV4
ICpwcmV2ID0gcy0+aGVhZC5wcmV2LCAqbmV4dCA9ICZzLT5oZWFkOwoKCWlmICh0aGlzLT5saW5l
KQoJCWVycngoMSwgImluZGV4IGNvcnJ1cHRpb24iKTsKCgl0aGlzLT5saW5lID0gbGluZTsKCXRo
aXMtPm5leHQgPSBuZXh0OwoJdGhpcy0+cHJldiA9IHByZXY7CglwcmV2LT5uZXh0ID0gbmV4dC0+
cHJldiA9IHRoaXM7Cn0KCnN0YXRpYyB2b2lkIGRlbF9pbmRleChzdHJ1Y3QgaW5kZXggKnRoaXMp
CnsKCXN0cnVjdCBpbmRleCAqcHJldiA9IHRoaXMtPnByZXYsICpuZXh0ID0gdGhpcy0+bmV4dDsK
Cgl0aGlzLT5saW5lID0gTlVMTDsKCXByZXYtPm5leHQgPSBuZXh0OwoJbmV4dC0+cHJldiA9IHBy
ZXY7Cn0KCnN0YXRpYyB2b2lkIGRpZmZfbW91bnRpbmZvKHN0cnVjdCBzdGF0ZSAqb2xkLCBzdHJ1
Y3Qgc3RhdGUgKmN1cikKewoJY2hhciAqbGluZSwgKmVuZDsKCXN0cnVjdCBpbmRleCAqdGhpczsK
CWludCBtbnRpZDsKCgljdXItPmhlYWQubmV4dCA9IGN1ci0+aGVhZC5wcmV2ID0gJmN1ci0+aGVh
ZDsKCWZvciAobGluZSA9IGN1ci0+YnVmOyBsaW5lWzBdOyBsaW5lID0gZW5kICsgMSkgewoJCWVu
ZCA9IHN0cmNocihsaW5lLCAnXG4nKTsKCQlpZiAoIWVuZCkKCQkJZXJyeCgxLCAicGFyc2luZyAo
MSkiKTsKCQkqZW5kID0gJ1wwJzsKCQlpZiAoc3NjYW5mKGxpbmUsICIlaSIsICZtbnRpZCkgIT0g
MSkKCQkJZXJyeCgxLCAicGFyc2luZyAoMikiKTsKCQlpZiAobW50aWQgPCAwIHx8IChzaXplX3Qp
IG1udGlkID49IGN1ci0+aW5kZXhfc2l6ZSkKCQkJZXJyeCgxLCAiaW5kZXggb3ZlcmZsb3ciKTsK
CQlhZGRfaW5kZXgoY3VyLCAmY3VyLT5pbmRleFttbnRpZF0sIGxpbmUpOwoKCQl0aGlzID0gJm9s
ZC0+aW5kZXhbbW50aWRdOwoJCWlmICh0aGlzLT5saW5lKSB7CgkJCWlmIChzdHJjbXAodGhpcy0+
bGluZSwgbGluZSkpCgkJCQlwcmludGYoIiogJXNcbiIsIGxpbmUpOwoJCQlkZWxfaW5kZXgodGhp
cyk7CgkJfSBlbHNlIHsKCQkJcHJpbnRmKCIrICVzXG4iLCBsaW5lKTsKCQl9Cgl9Cgl3aGlsZSAo
b2xkLT5oZWFkLm5leHQgIT0gJm9sZC0+aGVhZCkgewoJCXRoaXMgPSBvbGQtPmhlYWQubmV4dDsK
CQlwcmludGYoIi0gJXNcbiIsIHRoaXMtPmxpbmUpOwoJCWRlbF9pbmRleCh0aGlzKTsKCX0KCWZm
bHVzaChzdGRvdXQpOwp9CgppbnQgbWFpbih2b2lkKQp7CglzdHJ1Y3Qgc3RhdGUgc3RhdGVbMl0s
ICpvbGQgPSAmc3RhdGVbMF0sICpjdXIgPSAmc3RhdGVbMV0sICp0bXA7CglzdHJ1Y3QgcG9sbGZk
IHBmZCA9IHsgLmV2ZW50cyA9IFBPTExQUkkgfTsKCglvbGQtPmluZGV4X3NpemUgPSBjdXItPmlu
ZGV4X3NpemUgPSAxMzEwNzI7CglvbGQtPmJ1ZnNpemUgPSBjdXItPmJ1ZnNpemUgPSBjdXItPmlu
ZGV4X3NpemUgKiAxMjg7CglvbGQtPmluZGV4ID0gY2FsbG9jKG9sZC0+aW5kZXhfc2l6ZSwgc2l6
ZW9mKHN0cnVjdCBpbmRleCkpOwoJY3VyLT5pbmRleCA9IGNhbGxvYyhjdXItPmluZGV4X3NpemUs
IHNpemVvZihzdHJ1Y3QgaW5kZXgpKTsKCW9sZC0+YnVmID0gbWFsbG9jKG9sZC0+YnVmc2l6ZSk7
CgljdXItPmJ1ZiA9IG1hbGxvYyhjdXItPmJ1ZnNpemUpOwoJaWYgKCFvbGQtPmluZGV4IHx8ICFj
dXItPmluZGV4IHx8ICFvbGQtPmJ1ZiB8fCAhY3VyLT5idWYpCgkJZXJyKDEsICJhbGxvY2F0aW5n
IGJ1ZmZlcnMiKTsKCglvbGQtPmJ1ZlswXSA9ICdcMCc7CglvbGQtPmhlYWQucHJldiA9IG9sZC0+
aGVhZC5uZXh0ID0gJm9sZC0+aGVhZDsKCglwZmQuZmQgPSBvcGVuKCIvcHJvYy9zZWxmL21vdW50
aW5mbyIsIE9fUkRPTkxZKTsKCWlmIChwZmQuZmQgPT0gLTEpCgkJZXJyKDEsICJvcGVuIik7CgoJ
d2hpbGUgKDEpIHsKCQlyZWFkX21vdW50aW5mbygmcGZkLCBjdXItPmJ1ZiwgY3VyLT5idWZzaXpl
KTsKCQlkaWZmX21vdW50aW5mbyhvbGQsIGN1cik7CgoJCXRtcCA9IG9sZDsKCQlvbGQgPSBjdXI7
CgkJY3VyID0gdG1wOwoKCQlpZiAocG9sbCgmcGZkLCAxLCAtMSkgPT0gLTEpCgkJCWVycigxLCAi
cG9sbC9pbmYiKTsKCX0KfQo=
--000000000000733b8805a2b3ca6b--
