Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215782D468C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 17:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbgLIQQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 11:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgLIQP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:15:59 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF66DC0613CF
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 08:15:14 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id n18so661293ual.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 08:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3W9sqOrwAulwVbMuxwJdxJbXZUpBydsuade0H2Bxx6s=;
        b=mNWew8HpJYvccwiSgi45xXidkGxcSOp4jKkumZijklNh4xFBseenzUZR+TquEox3V8
         0OtnmYyjA8B6PKvBZYBSkq6GzQ5wDzY0Kp/pR6O/EEZn0kcLl8KqlcglSN5TnSV9r160
         DgVNMBnEBcT5Y1kTRIr5kGbOIHEAozq5PlF1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3W9sqOrwAulwVbMuxwJdxJbXZUpBydsuade0H2Bxx6s=;
        b=PwRw//n455e+8xB8XJzzoV88ajUkzk1aDyC4LHkRYE03k5IcjEdccmi3kDLqx90VY9
         EbXitWt6LqFNprYc8HjU0XYNyU2lgyjs9Zj2L1MwCaQ33gQa+M+4orWRRcrZ9AbfVgdZ
         J5vsaN0ycYbKyhn1pLfy4FIgnLMy9oZcGV/EZaNqsVCCEHy1EcnaeVWuCBz1nq2DA7QU
         vGN0swkPaYSmUu6QoLQClVObXXCWXuq0QWcbEC/Qo8XEKaQ7U8wwOcEdoymBR7pdNZe7
         kKaMVvAyDAcpqfaRinkfHF3N4C8wo6R3Qv4nC0h2fiXsr8V5cdB04iaHLpxVg6HqFZoR
         lvmw==
X-Gm-Message-State: AOAM532yKeT+pRPfVOH2bthpvDaRuO5qV3Wa9Vcl0Ybvx7WuYD4byKvW
        Rq1w3FNAxUINM2DUG7uM39yT+D2IBRBCggVsFN/7Cg==
X-Google-Smtp-Source: ABdhPJxAHvl1reGWSJqAxI1RBupHq59/0siiE1l/4EWg7ua6xU0BYdHHVioant+AGtBaFDFkHJO377JDa4XytxxPvBQ=
X-Received: by 2002:a9f:3012:: with SMTP id h18mr2333665uab.11.1607530513896;
 Wed, 09 Dec 2020 08:15:13 -0800 (PST)
MIME-Version: 1.0
References: <000000000000be4c9505b4c35420@google.com> <20201209133842.GA28118@quack2.suse.cz>
 <20201209135934.GB28118@quack2.suse.cz>
In-Reply-To: <20201209135934.GB28118@quack2.suse.cz>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 9 Dec 2020 17:15:02 +0100
Message-ID: <CAJfpegtZc=qXiQ55UOM1bhhPhhHkvPp3DzXSLS93uAfXSQ5vBw@mail.gmail.com>
Subject: Re: kernel BUG at fs/notify/dnotify/dnotify.c:LINE! (2)
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+f427adf9324b92652ccc@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="0000000000003f4b0305b60a5d7e"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000003f4b0305b60a5d7e
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 9, 2020 at 2:59 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 09-12-20 14:38:42, Jan Kara wrote:
> > Hello!
> >
> > so I was debugging the dnotify crash below (it's 100% reproducible for me)
> > and I came to the following. The reproducer opens 'file0' on FUSE
> > filesystem which is a directory at that point. Then it attached dnotify
> > mark to the directory 'file0' and then it does something to the FUSE fs
> > which I don't understand but the result is that when FUSE is unmounted the
> > 'file0' inode is actually a regular file (note that I've verified this is
> > really the same inode pointer). This then confuses dnotify which doesn't
> > tear down its structures properly and eventually crashes. So my question
> > is: How can an inode on FUSE filesystem morph from a dir to a regular file?
> > I presume this could confuse much more things than just dnotify?
> >
> > Before I dwelve more into FUSE internals, any idea Miklos what could have
> > gone wrong and how to debug this further?
>
> I've got an idea where to look and indeed it is the fuse_do_getattr() call
> that finds attributes returned by the server are inconsistent so it calls
> make_bad_inode() which, among other things, does:
>
>         inode->i_mode = S_IFREG;
>
> Indeed calling make_bad_inode() on a live inode doesn't look like a good
> idea. IMHO FUSE needs to come up with some other means of marking the inode
> as stale. Miklos?

Something like the attached.  It's untested and needs the
fuse_is_bad() test in more ops...

Thanks,
Miklos

--0000000000003f4b0305b60a5d7e
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-fix-bad-inode.patch"
Content-Disposition: attachment; filename="fuse-fix-bad-inode.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kihm4n1z0>
X-Attachment-Id: f_kihm4n1z0

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGlyLmMgYi9mcy9mdXNlL2Rpci5jCmluZGV4IGZmN2RiZWIx
NmY4OC4uMTE3MjE3OWM5ZmJhIDEwMDY0NAotLS0gYS9mcy9mdXNlL2Rpci5jCisrKyBiL2ZzL2Z1
c2UvZGlyLmMKQEAgLTIwMiw3ICsyMDIsNyBAQCBzdGF0aWMgaW50IGZ1c2VfZGVudHJ5X3JldmFs
aWRhdGUoc3RydWN0IGRlbnRyeSAqZW50cnksIHVuc2lnbmVkIGludCBmbGFncykKIAlpbnQgcmV0
OwogCiAJaW5vZGUgPSBkX2lub2RlX3JjdShlbnRyeSk7Ci0JaWYgKGlub2RlICYmIGlzX2JhZF9p
bm9kZShpbm9kZSkpCisJaWYgKGlub2RlICYmIGZ1c2VfaXNfYmFkKGlub2RlKSkKIAkJZ290byBp
bnZhbGlkOwogCWVsc2UgaWYgKHRpbWVfYmVmb3JlNjQoZnVzZV9kZW50cnlfdGltZShlbnRyeSks
IGdldF9qaWZmaWVzXzY0KCkpIHx8CiAJCSAoZmxhZ3MgJiBMT09LVVBfUkVWQUwpKSB7CkBAIC0x
MDMwLDcgKzEwMzAsNyBAQCBzdGF0aWMgaW50IGZ1c2VfZG9fZ2V0YXR0cihzdHJ1Y3QgaW5vZGUg
Kmlub2RlLCBzdHJ1Y3Qga3N0YXQgKnN0YXQsCiAJaWYgKCFlcnIpIHsKIAkJaWYgKGZ1c2VfaW52
YWxpZF9hdHRyKCZvdXRhcmcuYXR0cikgfHwKIAkJICAgIChpbm9kZS0+aV9tb2RlIF4gb3V0YXJn
LmF0dHIubW9kZSkgJiBTX0lGTVQpIHsKLQkJCW1ha2VfYmFkX2lub2RlKGlub2RlKTsKKwkJCWZ1
c2VfbWFrZV9iYWQoaW5vZGUpOwogCQkJZXJyID0gLUVJTzsKIAkJfSBlbHNlIHsKIAkJCWZ1c2Vf
Y2hhbmdlX2F0dHJpYnV0ZXMoaW5vZGUsICZvdXRhcmcuYXR0ciwKQEAgLTEzMjcsNyArMTMyNyw3
IEBAIHN0YXRpYyBjb25zdCBjaGFyICpmdXNlX2dldF9saW5rKHN0cnVjdCBkZW50cnkgKmRlbnRy
eSwgc3RydWN0IGlub2RlICppbm9kZSwKIAlpbnQgZXJyOwogCiAJZXJyID0gLUVJTzsKLQlpZiAo
aXNfYmFkX2lub2RlKGlub2RlKSkKKwlpZiAoZnVzZV9pc19iYWQoaW5vZGUpKQogCQlnb3RvIG91
dF9lcnI7CiAKIAlpZiAoZmMtPmNhY2hlX3N5bWxpbmtzKQpAQCAtMTM3NSw3ICsxMzc1LDcgQEAg
c3RhdGljIGludCBmdXNlX2Rpcl9mc3luYyhzdHJ1Y3QgZmlsZSAqZmlsZSwgbG9mZl90IHN0YXJ0
LCBsb2ZmX3QgZW5kLAogCXN0cnVjdCBmdXNlX2Nvbm4gKmZjID0gZ2V0X2Z1c2VfY29ubihpbm9k
ZSk7CiAJaW50IGVycjsKIAotCWlmIChpc19iYWRfaW5vZGUoaW5vZGUpKQorCWlmIChmdXNlX2lz
X2JhZChpbm9kZSkpCiAJCXJldHVybiAtRUlPOwogCiAJaWYgKGZjLT5ub19mc3luY2RpcikKQEAg
LTE2NjQsNyArMTY2NCw3IEBAIGludCBmdXNlX2RvX3NldGF0dHIoc3RydWN0IGRlbnRyeSAqZGVu
dHJ5LCBzdHJ1Y3QgaWF0dHIgKmF0dHIsCiAKIAlpZiAoZnVzZV9pbnZhbGlkX2F0dHIoJm91dGFy
Zy5hdHRyKSB8fAogCSAgICAoaW5vZGUtPmlfbW9kZSBeIG91dGFyZy5hdHRyLm1vZGUpICYgU19J
Rk1UKSB7Ci0JCW1ha2VfYmFkX2lub2RlKGlub2RlKTsKKwkJZnVzZV9tYWtlX2JhZChpbm9kZSk7
CiAJCWVyciA9IC1FSU87CiAJCWdvdG8gZXJyb3I7CiAJfQpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9m
aWxlLmMgYi9mcy9mdXNlL2ZpbGUuYwppbmRleCBjMDMwMzRlOGMxNTIuLjMwZmRiM2FkZjliOSAx
MDA2NDQKLS0tIGEvZnMvZnVzZS9maWxlLmMKKysrIGIvZnMvZnVzZS9maWxlLmMKQEAgLTQ2Myw3
ICs0NjMsNyBAQCBzdGF0aWMgaW50IGZ1c2VfZmx1c2goc3RydWN0IGZpbGUgKmZpbGUsIGZsX293
bmVyX3QgaWQpCiAJRlVTRV9BUkdTKGFyZ3MpOwogCWludCBlcnI7CiAKLQlpZiAoaXNfYmFkX2lu
b2RlKGlub2RlKSkKKwlpZiAoZnVzZV9pc19iYWQoaW5vZGUpKQogCQlyZXR1cm4gLUVJTzsKIAog
CWVyciA9IHdyaXRlX2lub2RlX25vdyhpbm9kZSwgMSk7CkBAIC01MzUsNyArNTM1LDcgQEAgc3Rh
dGljIGludCBmdXNlX2ZzeW5jKHN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3Qgc3RhcnQsIGxvZmZf
dCBlbmQsCiAJc3RydWN0IGZ1c2VfY29ubiAqZmMgPSBnZXRfZnVzZV9jb25uKGlub2RlKTsKIAlp
bnQgZXJyOwogCi0JaWYgKGlzX2JhZF9pbm9kZShpbm9kZSkpCisJaWYgKGZ1c2VfaXNfYmFkKGlu
b2RlKSkKIAkJcmV0dXJuIC1FSU87CiAKIAlpbm9kZV9sb2NrKGlub2RlKTsKQEAgLTg1OSw3ICs4
NTksNyBAQCBzdGF0aWMgaW50IGZ1c2VfcmVhZHBhZ2Uoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVj
dCBwYWdlICpwYWdlKQogCWludCBlcnI7CiAKIAllcnIgPSAtRUlPOwotCWlmIChpc19iYWRfaW5v
ZGUoaW5vZGUpKQorCWlmIChmdXNlX2lzX2JhZChpbm9kZSkpCiAJCWdvdG8gb3V0OwogCiAJZXJy
ID0gZnVzZV9kb19yZWFkcGFnZShmaWxlLCBwYWdlKTsKQEAgLTk1Miw3ICs5NTIsNyBAQCBzdGF0
aWMgdm9pZCBmdXNlX3JlYWRhaGVhZChzdHJ1Y3QgcmVhZGFoZWFkX2NvbnRyb2wgKnJhYykKIAlz
dHJ1Y3QgZnVzZV9jb25uICpmYyA9IGdldF9mdXNlX2Nvbm4oaW5vZGUpOwogCXVuc2lnbmVkIGlu
dCBpLCBtYXhfcGFnZXMsIG5yX3BhZ2VzID0gMDsKIAotCWlmIChpc19iYWRfaW5vZGUoaW5vZGUp
KQorCWlmIChmdXNlX2lzX2JhZChpbm9kZSkpCiAJCXJldHVybjsKIAogCW1heF9wYWdlcyA9IG1p
bl90KHVuc2lnbmVkIGludCwgZmMtPm1heF9wYWdlcywKQEAgLTE1NTUsNyArMTU1NSw3IEBAIHN0
YXRpYyBzc2l6ZV90IGZ1c2VfZmlsZV9yZWFkX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1
Y3QgaW92X2l0ZXIgKnRvKQogCXN0cnVjdCBmdXNlX2ZpbGUgKmZmID0gZmlsZS0+cHJpdmF0ZV9k
YXRhOwogCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBmaWxlX2lub2RlKGZpbGUpOwogCi0JaWYgKGlz
X2JhZF9pbm9kZShpbm9kZSkpCisJaWYgKGZ1c2VfaXNfYmFkKGlub2RlKSkKIAkJcmV0dXJuIC1F
SU87CiAKIAlpZiAoRlVTRV9JU19EQVgoaW5vZGUpKQpAQCAtMTU3Myw3ICsxNTczLDcgQEAgc3Rh
dGljIHNzaXplX3QgZnVzZV9maWxlX3dyaXRlX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1
Y3QgaW92X2l0ZXIgKmZyb20pCiAJc3RydWN0IGZ1c2VfZmlsZSAqZmYgPSBmaWxlLT5wcml2YXRl
X2RhdGE7CiAJc3RydWN0IGlub2RlICppbm9kZSA9IGZpbGVfaW5vZGUoZmlsZSk7CiAKLQlpZiAo
aXNfYmFkX2lub2RlKGlub2RlKSkKKwlpZiAoZnVzZV9pc19iYWQoaW5vZGUpKQogCQlyZXR1cm4g
LUVJTzsKIAogCWlmIChGVVNFX0lTX0RBWChpbm9kZSkpCkBAIC0yMTcyLDcgKzIxNzIsNyBAQCBz
dGF0aWMgaW50IGZ1c2Vfd3JpdGVwYWdlcyhzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywK
IAlpbnQgZXJyOwogCiAJZXJyID0gLUVJTzsKLQlpZiAoaXNfYmFkX2lub2RlKGlub2RlKSkKKwlp
ZiAoZnVzZV9pc19iYWQoaW5vZGUpKQogCQlnb3RvIG91dDsKIAogCWRhdGEuaW5vZGUgPSBpbm9k
ZTsKQEAgLTI5NTQsNyArMjk1NCw3IEBAIGxvbmcgZnVzZV9pb2N0bF9jb21tb24oc3RydWN0IGZp
bGUgKmZpbGUsIHVuc2lnbmVkIGludCBjbWQsCiAJaWYgKCFmdXNlX2FsbG93X2N1cnJlbnRfcHJv
Y2VzcyhmYykpCiAJCXJldHVybiAtRUFDQ0VTOwogCi0JaWYgKGlzX2JhZF9pbm9kZShpbm9kZSkp
CisJaWYgKGZ1c2VfaXNfYmFkKGlub2RlKSkKIAkJcmV0dXJuIC1FSU87CiAKIAlyZXR1cm4gZnVz
ZV9kb19pb2N0bChmaWxlLCBjbWQsIGFyZywgZmxhZ3MpOwpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9m
dXNlX2kuaCBiL2ZzL2Z1c2UvZnVzZV9pLmgKaW5kZXggZDUxNTk4MDE3ZDEzLi44NDg0ZjAwNTM2
ODcgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZnVzZV9pLmgKKysrIGIvZnMvZnVzZS9mdXNlX2kuaApA
QCAtMTcyLDYgKzE3Miw4IEBAIGVudW0gewogCUZVU0VfSV9JTklUX1JEUExVUywKIAkvKiogQW4g
b3BlcmF0aW9uIGNoYW5naW5nIGZpbGUgc2l6ZSBpcyBpbiBwcm9ncmVzcyAgKi8KIAlGVVNFX0lf
U0laRV9VTlNUQUJMRSwKKwkvKiBCYWQgaW5vZGUgKi8KKwlGVVNFX0lfQkFELAogfTsKIAogc3Ry
dWN0IGZ1c2VfY29ubjsKQEAgLTg1OCw2ICs4NjAsMTYgQEAgc3RhdGljIGlubGluZSB1NjQgZnVz
ZV9nZXRfYXR0cl92ZXJzaW9uKHN0cnVjdCBmdXNlX2Nvbm4gKmZjKQogCXJldHVybiBhdG9taWM2
NF9yZWFkKCZmYy0+YXR0cl92ZXJzaW9uKTsKIH0KIAorc3RhdGljIGlubGluZSB2b2lkIGZ1c2Vf
bWFrZV9iYWQoc3RydWN0IGlub2RlICppbm9kZSkKK3sKKwlzZXRfYml0KEZVU0VfSV9CQUQsICZn
ZXRfZnVzZV9pbm9kZShpbm9kZSktPnN0YXRlKTsKK30KKworc3RhdGljIGlubGluZSBib29sIGZ1
c2VfaXNfYmFkKHN0cnVjdCBpbm9kZSAqaW5vZGUpCit7CisJcmV0dXJuIHRlc3RfYml0KEZVU0Vf
SV9CQUQsICZnZXRfZnVzZV9pbm9kZShpbm9kZSktPnN0YXRlKTsKK30KKwogLyoqIERldmljZSBv
cGVyYXRpb25zICovCiBleHRlcm4gY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBmdXNlX2Rl
dl9vcGVyYXRpb25zOwogCmRpZmYgLS1naXQgYS9mcy9mdXNlL2lub2RlLmMgYi9mcy9mdXNlL2lu
b2RlLmMKaW5kZXggMWE0N2FmYzk1ZjgwLi5mOTRiMGJiNTc2MTkgMTAwNjQ0Ci0tLSBhL2ZzL2Z1
c2UvaW5vZGUuYworKysgYi9mcy9mdXNlL2lub2RlLmMKQEAgLTEzMiw3ICsxMzIsNyBAQCBzdGF0
aWMgdm9pZCBmdXNlX2V2aWN0X2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUpCiAJCQlmaS0+Zm9y
Z2V0ID0gTlVMTDsKIAkJfQogCX0KLQlpZiAoU19JU1JFRyhpbm9kZS0+aV9tb2RlKSAmJiAhaXNf
YmFkX2lub2RlKGlub2RlKSkgeworCWlmIChTX0lTUkVHKGlub2RlLT5pX21vZGUpICYmICFmdXNl
X2lzX2JhZChpbm9kZSkpIHsKIAkJV0FSTl9PTighbGlzdF9lbXB0eSgmZmktPndyaXRlX2ZpbGVz
KSk7CiAJCVdBUk5fT04oIWxpc3RfZW1wdHkoJmZpLT5xdWV1ZWRfd3JpdGVzKSk7CiAJfQpAQCAt
MzQyLDcgKzM0Miw3IEBAIHN0cnVjdCBpbm9kZSAqZnVzZV9pZ2V0KHN0cnVjdCBzdXBlcl9ibG9j
ayAqc2IsIHU2NCBub2RlaWQsCiAJCXVubG9ja19uZXdfaW5vZGUoaW5vZGUpOwogCX0gZWxzZSBp
ZiAoKGlub2RlLT5pX21vZGUgXiBhdHRyLT5tb2RlKSAmIFNfSUZNVCkgewogCQkvKiBJbm9kZSBo
YXMgY2hhbmdlZCB0eXBlLCBhbnkgSS9PIG9uIHRoZSBvbGQgc2hvdWxkIGZhaWwgKi8KLQkJbWFr
ZV9iYWRfaW5vZGUoaW5vZGUpOworCQlmdXNlX21ha2VfYmFkKGlub2RlKTsKIAkJaXB1dChpbm9k
ZSk7CiAJCWdvdG8gcmV0cnk7CiAJfQpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9yZWFkZGlyLmMgYi9m
cy9mdXNlL3JlYWRkaXIuYwppbmRleCAzYjVlOTEwNDU4NzEuLjM0NDFmZmE3NDBmMyAxMDA2NDQK
LS0tIGEvZnMvZnVzZS9yZWFkZGlyLmMKKysrIGIvZnMvZnVzZS9yZWFkZGlyLmMKQEAgLTIwNyw3
ICsyMDcsNyBAQCBzdGF0aWMgaW50IGZ1c2VfZGlyZW50cGx1c19saW5rKHN0cnVjdCBmaWxlICpm
aWxlLAogCQkJZHB1dChkZW50cnkpOwogCQkJZ290byByZXRyeTsKIAkJfQotCQlpZiAoaXNfYmFk
X2lub2RlKGlub2RlKSkgeworCQlpZiAoZnVzZV9pc19iYWQoaW5vZGUpKSB7CiAJCQlkcHV0KGRl
bnRyeSk7CiAJCQlyZXR1cm4gLUVJTzsKIAkJfQpAQCAtNTY4LDcgKzU2OCw3IEBAIGludCBmdXNl
X3JlYWRkaXIoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBkaXJfY29udGV4dCAqY3R4KQogCXN0
cnVjdCBpbm9kZSAqaW5vZGUgPSBmaWxlX2lub2RlKGZpbGUpOwogCWludCBlcnI7CiAKLQlpZiAo
aXNfYmFkX2lub2RlKGlub2RlKSkKKwlpZiAoZnVzZV9pc19iYWQoaW5vZGUpKQogCQlyZXR1cm4g
LUVJTzsKIAogCW11dGV4X2xvY2soJmZmLT5yZWFkZGlyLmxvY2spOwo=
--0000000000003f4b0305b60a5d7e--
