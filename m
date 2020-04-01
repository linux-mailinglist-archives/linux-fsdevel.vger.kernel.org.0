Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3778919ABC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 14:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbgDAMgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 08:36:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37773 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732343AbgDAMgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:36:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id de14so29383617edb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2020 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTsGL65lvJuTsIl0dqr7bKucShhojW0xMedUkjqlVzM=;
        b=jCJFZ+HiNEuy/1r56aFNXrn6fHoEK8O3KCSz//LJzZatHHt+nxLGC/hod64eTteDFK
         seWl4HmqojVkL5q8Bn6tL0NJv+dwEUUj3UALZF1fbSNV+MWwr06bJR7UUSiXzzC1sT8E
         iCeJq2MPcTQXxneT4OlsyPJ5NPC0xTwgbWYXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTsGL65lvJuTsIl0dqr7bKucShhojW0xMedUkjqlVzM=;
        b=XlILij/Ekrukrm/LyFpIu3FU0qjXJvXfYR+zLkZ6FBTP17ohVybIYz0gjR817SyZGQ
         0hdEe84a69mahXj/LJOldbWMItPDUwWEqN+s2lySUisEwfR0pbO0/PyHATxShTThEdDp
         Nhg2UyZ0emzXiFhqEMY98nBCdQbTxANpCnfUnrYb0+PZxngMaadjPA7YnmF7oII9ejhF
         wLeAqCN/LYUOZBubN1V7WABNYb+iZh+xxKN2/eJ87wzXq2R7YlP/u6W0C1QFcgx+cOOE
         gdUP6Hi65AIVoNGTOQnxDVWCkcrv0fzzgn0c78NT2WoCo1AjgSyIrfVHls3VLxNsgmvH
         GZNA==
X-Gm-Message-State: ANhLgQ0OG8vQHPutPLIIRA/oFn+Kmkt6DtmUg59GxIwrs9OBtdbukvpm
        zTPePrdkwaYrFHTB3h7e2Q25Is7yUjcEW4bi34R/zg==
X-Google-Smtp-Source: ADFU+vsoMwBMgIgC/8S96zUEPD0HRtg+Cs7XYzKiQfJkDdEozIlnng26VULIF3grdKiGgeey0ggZqqyPn0VFldxuZ9g=
X-Received: by 2002:a50:c341:: with SMTP id q1mr21103698edb.247.1585744565376;
 Wed, 01 Apr 2020 05:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
 <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com>
 <50caf93782ba1d66bd6acf098fb8dcb0ecc98610.camel@themaw.net>
 <CAJfpegvvMVoNp1QeXEZiNucCeuUeDP4tKqVfq2F4koQKzjKmvw@mail.gmail.com>
 <2465266.1585729649@warthog.procyon.org.uk> <CAJfpegsyeJmH3zJuseaAAY06fzgavSzpOtYr-1Mw8GR0cLcQbA@mail.gmail.com>
In-Reply-To: <CAJfpegsyeJmH3zJuseaAAY06fzgavSzpOtYr-1Mw8GR0cLcQbA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Apr 2020 14:35:54 +0200
Message-ID: <CAJfpeguxACC68bMhS-mNm4m6ytrKgs1--jbF5X3tBiPf_iG1jg@mail.gmail.com>
Subject: Re: [PATCH 00/13] VFS: Filesystem information [ver #19]
To:     David Howells <dhowells@redhat.com>
Cc:     Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux API <linux-api@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000086676005a239ed40"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000086676005a239ed40
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 1, 2020 at 10:37 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Apr 1, 2020 at 10:27 AM David Howells <dhowells@redhat.com> wrote:
> >
> > Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > > According to dhowell's measurements processing 100k mounts would take
> > > about a few seconds of system time (that's the time spent by the
> > > kernel to retrieve the data,
> >
> > But the inefficiency of mountfs - at least as currently implemented - scales
> > up with the number of individual values you want to retrieve, both in terms of
> > memory usage and time taken.
>
> I've taken that into account when guesstimating a "few seconds per
> 100k entries".  My guess is that there's probably an order of
> magnitude difference between the performance of a fs based interface
> and a binary syscall based interface.  That could be reduced somewhat
> with a readfile(2) type API.

And to show that I'm not completely off base, attached a patch that
adds a limited readfile(2) syscall and uses it in the p2 method.

Results are promising:

./test-fsinfo-perf /tmp/a 30000
--- make mounts ---
--- test fsinfo by path ---
sum(mnt_id) = 930000
--- test fsinfo by mnt_id ---
sum(mnt_id) = 930000
--- test /proc/fdinfo ---
sum(mnt_id) = 930000
--- test mountfs ---
sum(mnt_id) = 930000
For   30000 mounts, f=    146400us f2=    136766us p=   1406569us p2=
  221669us; p=9.6*f p=10.3*f2 p=6.3*p2
--- umount ---

This is about a 2 fold increase in speed compared to open + read + close.

Is someone still worried about performance, or can we move on to more
interesting parts of the design?

Thanks,
Miklos

--00000000000086676005a239ed40
Content-Type: text/x-patch; charset="US-ASCII"; name="fsmount-readfile.patch"
Content-Disposition: attachment; filename="fsmount-readfile.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k8hbbx3t0>
X-Attachment-Id: f_k8hbbx3t0

SW5kZXg6IGxpbnV4L2ZzL21vdW50ZnMvc3VwZXIuYwo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC5vcmln
L2ZzL21vdW50ZnMvc3VwZXIuYwkyMDIwLTA0LTAxIDE0OjIxOjI0LjYwOTk1NTA3MiArMDIwMAor
KysgbGludXgvZnMvbW91bnRmcy9zdXBlci5jCTIwMjAtMDQtMDEgMTQ6MjE6NDIuNDI2MTUxNTQ1
ICswMjAwCkBAIC01MSwxMCArNTEsMTEgQEAgc3RhdGljIGJvb2wgbW91bnRmc19lbnRyeV92aXNp
YmxlKHN0cnVjdAogCiAJcmV0dXJuIHZpc2libGU7CiB9CisKIHN0YXRpYyBpbnQgbW91bnRmc19h
dHRyX3Nob3coc3RydWN0IHNlcV9maWxlICpzZiwgdm9pZCAqdikKIHsKIAljb25zdCBjaGFyICpu
YW1lID0gc2YtPmZpbGUtPmZfcGF0aC5kZW50cnktPmRfbmFtZS5uYW1lOwotCXN0cnVjdCBtb3Vu
dGZzX2VudHJ5ICplbnRyeSA9IHNmLT5wcml2YXRlOworCXN0cnVjdCBtb3VudGZzX2VudHJ5ICpl
bnRyeSA9IGZpbGVfaW5vZGUoc2YtPmZpbGUpLT5pX3ByaXZhdGU7CiAJc3RydWN0IG1vdW50ICpt
bnQ7CiAJc3RydWN0IHZmc21vdW50ICptOwogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2I7CkBAIC0x
NDAsMTIgKzE0MSw0MCBAQCBzdGF0aWMgaW50IG1vdW50ZnNfYXR0cl9zaG93KHN0cnVjdCBzZXFf
CiAJcmV0dXJuIGVycjsKIH0KIAorc3NpemVfdCBtb3VudGZzX2F0dHJfcmVhZGZpbGUoc3RydWN0
IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICpidWYsIHNpemVfdCBzaXplKQoreworCXN0cnVjdCBz
ZXFfZmlsZSBtID0geyAuc2l6ZSA9IFBBR0VfU0laRSwgLmZpbGUgPSBmaWxlIH07CisJc3NpemVf
dCByZXQ7CisKK3JldHJ5OgorCW0uYnVmID0ga3ZtYWxsb2MobS5zaXplLCBHRlBfS0VSTkVMKTsK
KwlpZiAoIW0uYnVmKQorCQlyZXR1cm4gLUVOT01FTTsKKworCXJldCA9IG1vdW50ZnNfYXR0cl9z
aG93KCZtLCBOVUxMKTsKKwlpZiAoIXJldCkgeworCQlpZiAobS5jb3VudCA9PSBtLnNpemUpIHsK
KwkJCWt2ZnJlZShtLmJ1Zik7CisJCQltLnNpemUgPDw9IDE7CisJCQltLmNvdW50ID0gMDsKKwkJ
CWdvdG8gcmV0cnk7CisJCX0KKwkJcmV0ID0gbWluKG0uY291bnQsIHNpemUpOworCQlpZiAoY29w
eV90b191c2VyKGJ1ZiwgbS5idWYsIHJldCkpCisJCQlyZXQgPSAtRUZBVUxUOworCX0KKworCWt2
ZnJlZShtLmJ1Zik7CisJcmV0dXJuIHJldDsKK30KKwogc3RhdGljIGludCBtb3VudGZzX2F0dHJf
b3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKIHsKLQlyZXR1cm4g
c2luZ2xlX29wZW4oZmlsZSwgbW91bnRmc19hdHRyX3Nob3csIGlub2RlLT5pX3ByaXZhdGUpOwor
CXJldHVybiBzaW5nbGVfb3BlbihmaWxlLCBtb3VudGZzX2F0dHJfc2hvdywgTlVMTCk7CiB9CiAK
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIG1vdW50ZnNfYXR0cl9mb3BzID0g
eworCS5yZWFkZmlsZQk9IG1vdW50ZnNfYXR0cl9yZWFkZmlsZSwKIAkub3BlbgkJPSBtb3VudGZz
X2F0dHJfb3BlbiwKIAkucmVhZAkJPSBzZXFfcmVhZCwKIAkubGxzZWVrCQk9IHNlcV9sc2VlaywK
SW5kZXg6IGxpbnV4L3NhbXBsZXMvdmZzL3Rlc3QtZnNpbmZvLXBlcmYuYwo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0t
LSBsaW51eC5vcmlnL3NhbXBsZXMvdmZzL3Rlc3QtZnNpbmZvLXBlcmYuYwkyMDIwLTA0LTAxIDE0
OjIxOjI0LjYwOTk1NTA3MiArMDIwMAorKysgbGludXgvc2FtcGxlcy92ZnMvdGVzdC1mc2luZm8t
cGVyZi5jCTIwMjAtMDQtMDEgMTQ6MjE6NDIuNDI2MTUxNTQ1ICswMjAwCkBAIC0xNzIsNiArMTcy
LDEyIEBAIHN0YXRpYyB2b2lkIGdldF9pZF9ieV9wcm9jKGludCBpeCwgY29uc3QKIAkvL3ByaW50
ZigiWyV1XSAldVxuIiwgaXgsIHgpOwogfQogCitzdGF0aWMgbG9uZyByZWFkZmlsZShpbnQgZGZk
LCBjb25zdCBjaGFyICpuYW1lLCBjaGFyICpidWZmZXIsIHNpemVfdCBzaXplLAorCQkgICAgIGlu
dCBmbGFncykKK3sKKwlyZXR1cm4gc3lzY2FsbChfX05SX3JlYWRmaWxlLCBkZmQsIG5hbWUsIGJ1
ZmZlciwgc2l6ZSwgZmxhZ3MpOworfQorCiBzdGF0aWMgdm9pZCBnZXRfaWRfYnlfZnNpbmZvXzIo
dm9pZCkKIHsKIAlzdHJ1Y3QgZnNpbmZvX21vdW50X3RvcG9sb2d5IHQ7CkBAIC0zMDAsMTEgKzMw
Niw4IEBAIHN0YXRpYyB2b2lkIGdldF9pZF9ieV9tb3VudGZzKHZvaWQpCiAJCX0KIAogCQlzcHJp
bnRmKHByb2NmaWxlLCAiJXUvcGFyZW50IiwgbW50X2lkKTsKLQkJZmQgPSBvcGVuYXQobW50ZmQs
IHByb2NmaWxlLCBPX1JET05MWSk7Ci0JCUVSUihmZCwgcHJvY2ZpbGUpOwotCQlsZW4gPSByZWFk
KGZkLCBidWZmZXIsIHNpemVvZihidWZmZXIpIC0gMSk7Ci0JCUVSUihsZW4sICJyZWFkL3BhcmVu
dCIpOwotCQljbG9zZShmZCk7CisJCWxlbiA9IHJlYWRmaWxlKG1udGZkLCBwcm9jZmlsZSwgYnVm
ZmVyLCBzaXplb2YoYnVmZmVyKSwgMCk7CisJCUVSUihsZW4sICJyZWFkZmlsZS9wYXJlbnQiKTsK
IAkJaWYgKGxlbiA+IDAgJiYgYnVmZmVyW2xlbiAtIDFdID09ICdcbicpCiAJCQlsZW4tLTsKIAkJ
YnVmZmVyW2xlbl0gPSAwOwpAQCAtMzE5LDExICszMjIsOCBAQCBzdGF0aWMgdm9pZCBnZXRfaWRf
YnlfbW91bnRmcyh2b2lkKQogCQlzdW1fY2hlY2sgKz0geDsKIAogCQlzcHJpbnRmKHByb2NmaWxl
LCAiJXUvY291bnRlciIsIG1udF9pZCk7Ci0JCWZkID0gb3BlbmF0KG1udGZkLCBwcm9jZmlsZSwg
T19SRE9OTFkpOwotCQlFUlIoZmQsIHByb2NmaWxlKTsKLQkJbGVuID0gcmVhZChmZCwgYnVmZmVy
LCBzaXplb2YoYnVmZmVyKSAtIDEpOwotCQlFUlIobGVuLCAicmVhZC9jb3VudGVyIik7Ci0JCWNs
b3NlKGZkKTsKKwkJbGVuID0gcmVhZGZpbGUobW50ZmQsIHByb2NmaWxlLCBidWZmZXIsIHNpemVv
ZihidWZmZXIpIC0gMSwgMCk7CisJCUVSUihsZW4sICJyZWFkZmlsZS9jb3VudGVyIik7CiAJCWlm
IChsZW4gPiAwICYmIGJ1ZmZlcltsZW4gLSAxXSA9PSAnXG4nKQogCQkJbGVuLS07CiAJCWJ1ZmZl
cltsZW5dID0gMDsKSW5kZXg6IGxpbnV4L2FyY2gveDg2L2VudHJ5L3N5c2NhbGxzL3N5c2NhbGxf
NjQudGJsCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4Lm9yaWcvYXJjaC94ODYvZW50cnkvc3lzY2FsbHMv
c3lzY2FsbF82NC50YmwJMjAyMC0wNC0wMSAxNDoyMTozNy4yODQwOTQ4NDAgKzAyMDAKKysrIGxp
bnV4L2FyY2gveDg2L2VudHJ5L3N5c2NhbGxzL3N5c2NhbGxfNjQudGJsCTIwMjAtMDQtMDEgMTQ6
MjE6NDIuNDEyMTUxMzkwICswMjAwCkBAIC0zNjIsNiArMzYyLDcgQEAKIDQzOQljb21tb24Jd2F0
Y2hfbW91bnQJCV9feDY0X3N5c193YXRjaF9tb3VudAogNDQwCWNvbW1vbgl3YXRjaF9zYgkJX194
NjRfc3lzX3dhdGNoX3NiCiA0NDEJY29tbW9uCWZzaW5mbwkJCV9feDY0X3N5c19mc2luZm8KKzQ0
Mgljb21tb24JcmVhZGZpbGUJCV9feDY0X3N5c19yZWFkZmlsZQogCiAjCiAjIHgzMi1zcGVjaWZp
YyBzeXN0ZW0gY2FsbCBudW1iZXJzIHN0YXJ0IGF0IDUxMiB0byBhdm9pZCBjYWNoZSBpbXBhY3QK
SW5kZXg6IGxpbnV4L2ZzL29wZW4uYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC5vcmlnL2ZzL29wZW4u
YwkyMDIwLTA0LTAxIDE0OjIxOjM3LjI4NDA5NDg0MCArMDIwMAorKysgbGludXgvZnMvb3Blbi5j
CTIwMjAtMDQtMDEgMTQ6MjE6NDIuNDI0MTUxNTIzICswMjAwCkBAIC0xMzQwLDMgKzEzNDAsMjUg
QEAgaW50IHN0cmVhbV9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cgogfQogCiBFWFBPUlRf
U1lNQk9MKHN0cmVhbV9vcGVuKTsKKworU1lTQ0FMTF9ERUZJTkU1KHJlYWRmaWxlLCBpbnQsIGRm
ZCwgY29uc3QgY2hhciBfX3VzZXIgKiwgZmlsZW5hbWUsCisJCWNoYXIgX191c2VyICosIGJ1ZmZl
ciwgc2l6ZV90LCBidWZzaXplLCBpbnQsIGZsYWdzKQoreworCXNzaXplX3QgcmV0OworCXN0cnVj
dCBmaWxlIGZpbGUgPSB7fTsKKworCWlmIChmbGFncykKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwly
ZXQgPSB1c2VyX3BhdGhfYXQoZGZkLCBmaWxlbmFtZSwgMCwgJmZpbGUuZl9wYXRoKTsKKwlpZiAo
IXJldCkgeworCQlmaWxlLmZfaW5vZGUgPSBmaWxlLmZfcGF0aC5kZW50cnktPmRfaW5vZGU7CisJ
CWZpbGUuZl9vcCA9IGZpbGUuZl9pbm9kZS0+aV9mb3A7CisJCXJldCA9IC1FT1BOT1RTVVBQOwor
CQlpZiAoZmlsZS5mX29wLT5yZWFkZmlsZSkKKwkJCXJldCA9IGZpbGUuZl9vcC0+cmVhZGZpbGUo
JmZpbGUsIGJ1ZmZlciwgYnVmc2l6ZSk7CisJCXBhdGhfcHV0KCZmaWxlLmZfcGF0aCk7CisJfQor
CisJcmV0dXJuIHJldDsKK30KSW5kZXg6IGxpbnV4L2luY2x1ZGUvbGludXgvc3lzY2FsbHMuaAo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Ci0tLSBsaW51eC5vcmlnL2luY2x1ZGUvbGludXgvc3lzY2FsbHMuaAkyMDIwLTA0
LTAxIDE0OjIxOjM3LjI4NDA5NDg0MCArMDIwMAorKysgbGludXgvaW5jbHVkZS9saW51eC9zeXNj
YWxscy5oCTIwMjAtMDQtMDEgMTQ6MjE6NDIuNDEzMTUxNDAxICswMjAwCkBAIC0xMDExLDYgKzEw
MTEsOCBAQCBhc21saW5rYWdlIGxvbmcgc3lzX3dhdGNoX3NiKGludCBkZmQsIGNvCiBhc21saW5r
YWdlIGxvbmcgc3lzX2ZzaW5mbyhpbnQgZGZkLCBjb25zdCBjaGFyIF9fdXNlciAqcGF0aG5hbWUs
CiAJCQkgICBzdHJ1Y3QgZnNpbmZvX3BhcmFtcyBfX3VzZXIgKnBhcmFtcywgc2l6ZV90IHBhcmFt
c19zaXplLAogCQkJICAgdm9pZCBfX3VzZXIgKnJlc3VsdF9idWZmZXIsIHNpemVfdCByZXN1bHRf
YnVmX3NpemUpOworYXNtbGlua2FnZSBsb25nIHN5c19yZWFkZmlsZShpbnQgZGZkLCBjb25zdCBj
aGFyIF9fdXNlciAqZmlsZW5hbWUsCisJCQkgICAgIGNoYXIgX191c2VyICpidWZmZXIsIHNpemVf
dCBidWZzaXplLCBpbnQgZmxhZ3MpOwogCiAvKgogICogQXJjaGl0ZWN0dXJlLXNwZWNpZmljIHN5
c3RlbSBjYWxscwpJbmRleDogbGludXgvaW5jbHVkZS91YXBpL2FzbS1nZW5lcmljL3VuaXN0ZC5o
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KLS0tIGxpbnV4Lm9yaWcvaW5jbHVkZS91YXBpL2FzbS1nZW5lcmljL3VuaXN0
ZC5oCTIwMjAtMDQtMDEgMTQ6MjE6MzcuMjg0MDk0ODQwICswMjAwCisrKyBsaW51eC9pbmNsdWRl
L3VhcGkvYXNtLWdlbmVyaWMvdW5pc3RkLmgJMjAyMC0wNC0wMSAxNDoyMTo0Mi40MTMxNTE0MDEg
KzAyMDAKQEAgLTg2MSw5ICs4NjEsMTEgQEAgX19TWVNDQUxMKF9fTlJfd2F0Y2hfbW91bnQsIHN5
c193YXRjaF9tbwogX19TWVNDQUxMKF9fTlJfd2F0Y2hfc2IsIHN5c193YXRjaF9zYikKICNkZWZp
bmUgX19OUl9mc2luZm8gNDQxCiBfX1NZU0NBTEwoX19OUl9mc2luZm8sIHN5c19mc2luZm8pCisj
ZGVmaW5lIF9fTlJfcmVhZGZpbGUgNDQyCitfX1NZU0NBTEwoX19OUl9yZWFkZmlsZSwgc3lzX3Jl
YWRmaWxlKQogCiAjdW5kZWYgX19OUl9zeXNjYWxscwotI2RlZmluZSBfX05SX3N5c2NhbGxzIDQ0
MgorI2RlZmluZSBfX05SX3N5c2NhbGxzIDQ0MwogCiAvKgogICogMzIgYml0IHN5c3RlbXMgdHJh
ZGl0aW9uYWxseSB1c2VkIGRpZmZlcmVudApJbmRleDogbGludXgvaW5jbHVkZS9saW51eC9mcy5o
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KLS0tIGxpbnV4Lm9yaWcvaW5jbHVkZS9saW51eC9mcy5oCTIwMjAtMDQtMDEg
MTQ6MjE6MTkuMTQ0ODk0ODA0ICswMjAwCisrKyBsaW51eC9pbmNsdWRlL2xpbnV4L2ZzLmgJMjAy
MC0wNC0wMSAxNDoyMTo0Mi40MjUxNTE1MzQgKzAyMDAKQEAgLTE4NjgsNiArMTg2OCw3IEBAIHN0
cnVjdCBmaWxlX29wZXJhdGlvbnMgewogCQkJCSAgIHN0cnVjdCBmaWxlICpmaWxlX291dCwgbG9m
Zl90IHBvc19vdXQsCiAJCQkJICAgbG9mZl90IGxlbiwgdW5zaWduZWQgaW50IHJlbWFwX2ZsYWdz
KTsKIAlpbnQgKCpmYWR2aXNlKShzdHJ1Y3QgZmlsZSAqLCBsb2ZmX3QsIGxvZmZfdCwgaW50KTsK
Kwlzc2l6ZV90ICgqcmVhZGZpbGUpKHN0cnVjdCBmaWxlICosIGNoYXIgX191c2VyICosIHNpemVf
dCk7CiB9IF9fcmFuZG9taXplX2xheW91dDsKIAogc3RydWN0IGlub2RlX29wZXJhdGlvbnMgewo=
--00000000000086676005a239ed40--
