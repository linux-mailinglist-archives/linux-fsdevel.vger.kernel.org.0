Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80CFF19AEAE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbgDAP0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 11:26:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36637 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732797AbgDAP0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:26:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id i7so399915edq.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2020 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfLjzLeMWjfMsXUpfBMpZITQLNm0/s+5U4p6mPLkyx4=;
        b=PUPKOUBO1PptuoeDS6EalNpVTD9SHcie5wEhMjj46aXzacsfDhGqOQTO3YBYuFiGgn
         /PF10eXlMZiXtqVYf8mt9Ad7bv2XiUJXFgKYpO7grbhvE3hU81vIiCLtf4L0aV9AEMBD
         MQovOW/WX/yzCbxqhsR3TmZHZYFQ0PiI7DSuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfLjzLeMWjfMsXUpfBMpZITQLNm0/s+5U4p6mPLkyx4=;
        b=ssJPBa4v0EinydgzE9vkq+bDu/WpuTD1zdwRDCY3A2f1phvD/AEiy6ImNmAMYZPhgx
         JPqch7dJsHrQlDoQNie/94Qdy3hZld171DyXvGJ2JBy0xd7fSaFohh4ZVv2wtfX1buRL
         124i6pnBKrn+cKVCfFPx/Bw6EQN4yBfPCVNCiPSeQddGbmFGOoVfkpUiGeyD7QgGvg5z
         pMTTcdCrl9GwBMqomH5VmQxFlBfAJXKCbnlvjUe3D0GuNYPsbAG3Qgea/S+BWjGB2osY
         381jVnfPj99Tj/GY7XY2x4rWBoC2njhCk176B9wKow476j5dY7t/ZjzHrQVndyynhZ7R
         WQfA==
X-Gm-Message-State: ANhLgQ3Ibz5OI2V+Ru0wPackItPzVVaV07SjAv+ZFwoJOL7GtzqhU8cd
        F5XHyYYHfwdq+nHFW/O/CPIYs+4xZtecmiuksV+42w==
X-Google-Smtp-Source: ADFU+vsDOkYmNk1t4VKHYrgQmsjI2a5WQNpmU6OLd3OnE/zDH6ktDgckAE9e+jdXXUMmh6W3IpQF87frWTqlZ/CKZow=
X-Received: by 2002:aa7:d2cb:: with SMTP id k11mr21860746edr.128.1585754765844;
 Wed, 01 Apr 2020 08:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpeguu52VuLAzjFH4rJJ7WYLB5ag8y+r3VMb-0bqH8c-uJUg@mail.gmail.com>
 <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk> <20200401090445.6t73dt7gz36bv4rh@ws.net.home>
 <2488530.1585749351@warthog.procyon.org.uk> <2488734.1585749502@warthog.procyon.org.uk>
In-Reply-To: <2488734.1585749502@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Apr 2020 17:25:54 +0200
Message-ID: <CAJfpeguLJcAEgx2JWRNcKMkyFTWB0r4wS6F4fJHK3VHtY=EjXQ@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     David Howells <dhowells@redhat.com>
Cc:     Karel Zak <kzak@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: multipart/mixed; boundary="00000000000085172a05a23c4d0d"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000085172a05a23c4d0d
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 1, 2020 at 3:58 PM David Howells <dhowells@redhat.com> wrote:
>
> David Howells <dhowells@redhat.com> wrote:
>
> > > Attached patch applies against readfile patch.
> >
> > But doesn't actually do what Karel asked for.  show_mountinfo() itself does
> > not give you what Karel asked for.

Not sure what you mean.  I think it shows precisely the information
Karel asked for.

>  Plus there's more information you need to
> > add to it.

The mountinfo format is extensible (see
Documentation/filesystems/proc.txt) so for example adding the change
counters would be simple.

> And arguably, it's worse than just reading /proc/mounts.  If you get a
> notification that something changed (ie. you poll /proc/mounts or mount
> notifications gives you an overrun) you now have to read *every*
> /mountfs/*/info file.  That is way more expensive.

fsinfo(2) will never be substantially cheaper than reading and parsing
/mnt/MNT_ID/info.  In fact reading a large part of the mount table
using fsinfo(2) will be substantially slower than parsing
/proc/self/mountinfo (this doesn't actually do the parsing but that
would add a very small amount of overhead):

root@kvm:~# ./test-fsinfo-perf /tmp/a 30000
--- make mounts ---
--- test fsinfo by path ---
sum(mnt_id) = 960000
--- test fsinfo by mnt_id ---
sum(mnt_id) = 960000
--- test /proc/fdinfo ---
sum(mnt_id) = 960000
--- test mountfs ---
sum(mnt_id) = 960000
--- test mountinfo ---
sum(mnt_id) = 960000
For   30000 mounts, f=    154963us f2=    148337us p=   1803699us p2=
  257019us; m=     53996us; p=11.6*f p=12.2*f2 p=7.0*p2 p=33.4*m
--- umount ---

Yes, that's 33 times faster!

Thanks,
Miklos

--00000000000085172a05a23c4d0d
Content-Type: text/x-patch; charset="US-ASCII"; name="test-fsinfo-perf-mountinfo.patch"
Content-Disposition: attachment; filename="test-fsinfo-perf-mountinfo.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k8hhddno0>
X-Attachment-Id: f_k8hhddno0

LS0tCiBzYW1wbGVzL3Zmcy90ZXN0LWZzaW5mby1wZXJmLmMgfCAgIDkxICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgODcgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKCi0tLSBhL3NhbXBsZXMvdmZzL3Rlc3QtZnNpbmZvLXBlcmYu
YworKysgYi9zYW1wbGVzL3Zmcy90ZXN0LWZzaW5mby1wZXJmLmMKQEAgLTMzOSw2ICszMzksNzkg
QEAgc3RhdGljIHZvaWQgZ2V0X2lkX2J5X21vdW50ZnModm9pZCkKIAl9IHdoaWxlIChwID0gY29t
bWEsICpjb21tYSk7CiB9CiAKK3N0YXRpYyB2b2lkIGdldF9pZF9ieV9tb3VudGluZm8odm9pZCkK
K3sKKwl1bnNpZ25lZCBpbnQgYmFzZV9tbnRfaWQsIG1udF9pZCwgeDsKKwlzc2l6ZV90IGxlbjsK
KwljaGFyIHByb2NmaWxlWzEwMF0sIGJ1ZmZlcls0MDk2XSwgKnAsICpubDsKKwlpbnQgZmQsIGZk
MiwgbW50ZmQ7CisKKwkvKiBTdGFydCBvZmYgYnkgcmVhZGluZyB0aGUgbW91bnQgSUQgZnJvbSB0
aGUgYmFzZSBwYXRoICovCisJZmQgPSBvcGVuKGJhc2VfcGF0aCwgT19QQVRIKTsKKwlFUlIoZmQs
ICJvcGVuL3BhdGgiKTsKKwlzcHJpbnRmKHByb2NmaWxlLCAiL3Byb2Mvc2VsZi9mZGluZm8vJXUi
LCBmZCk7CisJZmQyID0gb3Blbihwcm9jZmlsZSwgT19SRE9OTFkpOworCUVSUihmZDIsICJvcGVu
L3Byb2MiKTsKKwlsZW4gPSByZWFkKGZkMiwgYnVmZmVyLCBzaXplb2YoYnVmZmVyKSAtIDEpOwor
CUVSUihsZW4sICJyZWFkIik7CisJYnVmZmVyW2xlbl0gPSAwOworCWNsb3NlKGZkMik7CisJY2xv
c2UoZmQpOworCisJcCA9IGJ1ZmZlcjsKKwlkbyB7CisJCW5sID0gc3RyY2hyKHAsICdcbicpOwor
CQlpZiAobmwpCisJCQkqbmwrKyA9ICdcMCc7CisJCWVsc2UKKwkJCW5sID0gTlVMTDsKKworCQlp
ZiAoc3RybmNtcChwLCAibW50X2lkOiIsIDcpICE9IDApCisJCQljb250aW51ZTsKKwkJcCArPSA3
OworCQl3aGlsZSAoaXNibGFuaygqcCkpCisJCQlwKys7CisJCS8qIEhhdmUgdG8gYWxsb3cgZm9y
IGV4dHJhIG51bWJlcnMgYmVpbmcgYWRkZWQgdG8gdGhlIGxpbmUgKi8KKwkJaWYgKHNzY2FuZihw
LCAiJXUiLCAmYmFzZV9tbnRfaWQpICE9IDEpIHsKKwkJCWZwcmludGYoc3RkZXJyLCAiQmFkIGZv
cm1hdCAlc1xuIiwgcHJvY2ZpbGUpOworCQkJZXhpdCgzKTsKKwkJfQorCQlicmVhazsKKworCX0g
d2hpbGUgKChwID0gbmwpKTsKKworCWlmICghcCkgeworCQlmcHJpbnRmKHN0ZGVyciwgIk1pc3Np
bmcgZmllbGQgJXNcbiIsIHByb2NmaWxlKTsKKwkJZXhpdCgzKTsKKwl9CisKKwlpZiAoMCkgcHJp
bnRmKCJbQl0gJXVcbiIsIGJhc2VfbW50X2lkKTsKKworCW1udGZkID0gb3BlbigiL3Byb2Mvc2Vs
Zi9tb3VudGluZm8iLCBPX1JET05MWSk7CisJRVJSKG1udGZkLCAiL3Byb2Mvc2VsZi9tb3VudGlu
Zm8iKTsKKworCXdoaWxlICgobGVuID0gcmVhZChtbnRmZCwgYnVmZmVyLCBzaXplb2YoYnVmZmVy
KSkpKSB7CisJCUVSUihsZW4sICJyZWFkL21vdW50aW5mbyIpOworCisJCWZvciAocCA9IGJ1ZmZl
cjsgcCA8IGJ1ZmZlciArIGxlbjsgcCA9IG5sICsgMSkgeworCQkJbmwgPSBzdHJjaHIocCwgJ1xu
Jyk7CisJCQlpZiAoIW5sKSB7CisJCQkJZnByaW50ZihzdGRlcnIsICJlcnJvciBwYXJzaW5nIG1v
dW50aW5mb1xuIik7CisJCQkJZXhpdCgzKTsKKwkJCX0KKwkJCSpubCA9ICdcMCc7CisJCQlpZiAo
c3NjYW5mKHAsICIlaSAlaSIsICZtbnRfaWQsICZ4KSAhPSAyKSB7CisJCQkJZnByaW50ZihzdGRl
cnIsICJlcnJvciBwYXJzaW5nIG1vdW50aW5mb1xuIik7CisJCQkJZXhpdCgzKTsKKwkJCX0KKwkJ
CWlmICh4ID09IGJhc2VfbW50X2lkKQorCQkJCXN1bV9jaGVjayArPSB4OworCQl9CisJfQorCisJ
Y2xvc2UobW50ZmQpOworfQorCiBzdGF0aWMgdW5zaWduZWQgbG9uZyBkdXJhdGlvbihzdHJ1Y3Qg
dGltZXZhbCAqYmVmb3JlLCBzdHJ1Y3QgdGltZXZhbCAqYWZ0ZXIpCiB7CiAJdW5zaWduZWQgbG9u
ZyBhLCBiOwpAQCAtMzU0LDggKzQyNyw5IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJn
dikKIAlzdHJ1Y3QgdGltZXZhbCBmMl9iZWZvcmUsIGYyX2FmdGVyOwogCXN0cnVjdCB0aW1ldmFs
IHBfYmVmb3JlLCBwX2FmdGVyOwogCXN0cnVjdCB0aW1ldmFsIHAyX2JlZm9yZSwgcDJfYWZ0ZXI7
CisJc3RydWN0IHRpbWV2YWwgbV9iZWZvcmUsIG1fYWZ0ZXI7CiAJY29uc3QgY2hhciAqcGF0aDsK
LQl1bnNpZ25lZCBsb25nIGZfZHVyLCBmMl9kdXIsIHBfZHVyLCBwMl9kdXI7CisJdW5zaWduZWQg
bG9uZyBmX2R1ciwgZjJfZHVyLCBwX2R1ciwgcDJfZHVyLCBtX2R1cjsKIAogCWlmIChhcmdjIDwg
MikgewogCQlmcHJpbnRmKHN0ZGVyciwgIkZvcm1hdDogJXMgPHBhdGg+IFtucl9tb3VudHNdXG4i
LCBhcmd2WzBdKTsKQEAgLTQwMiwxNyArNDc2LDI2IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFy
ICoqYXJndikKIAlFUlIoZ2V0dGltZW9mZGF5KCZwMl9hZnRlciwgTlVMTCksICJnZXR0aW1lb2Zk
YXkiKTsKIAlwcmludGYoInN1bShtbnRfaWQpID0gJWx1XG4iLCBzdW1fY2hlY2spOwogCisJcHJp
bnRmKCItLS0gdGVzdCBtb3VudGluZm8gLS0tXG4iKTsKKwlzdW1fY2hlY2sgPSAwOworCUVSUihn
ZXR0aW1lb2ZkYXkoJm1fYmVmb3JlLCBOVUxMKSwgImdldHRpbWVvZmRheSIpOworCWdldF9pZF9i
eV9tb3VudGluZm8oKTsKKwlFUlIoZ2V0dGltZW9mZGF5KCZtX2FmdGVyLCBOVUxMKSwgImdldHRp
bWVvZmRheSIpOworCXByaW50Zigic3VtKG1udF9pZCkgPSAlbHVcbiIsIHN1bV9jaGVjayk7CisK
IAlmX2R1ciAgPSBkdXJhdGlvbigmZl9iZWZvcmUsICAmZl9hZnRlcik7CiAJZjJfZHVyID0gZHVy
YXRpb24oJmYyX2JlZm9yZSwgJmYyX2FmdGVyKTsKIAlwX2R1ciAgPSBkdXJhdGlvbigmcF9iZWZv
cmUsICAmcF9hZnRlcik7CiAJcDJfZHVyID0gZHVyYXRpb24oJnAyX2JlZm9yZSwgJnAyX2FmdGVy
KTsKKwltX2R1ciAgPSBkdXJhdGlvbigmbV9iZWZvcmUsICAmbV9hZnRlcik7CiAJLy9wcmludGYo
ImZzaW5mbyBkdXJhdGlvbiAlMTBsdXVzIGZvciAlZCBtb3VudHNcbiIsIGZfZHVyLCBucl9tb3Vu
dHMpOwogCS8vcHJpbnRmKCJwcm9jZmQgZHVyYXRpb24gJTEwbHV1cyBmb3IgJWQgbW91bnRzXG4i
LCBwX2R1ciwgbnJfbW91bnRzKTsKIAotCXByaW50ZigiRm9yICU3ZCBtb3VudHMsIGY9JTEwbHV1
cyBmMj0lMTBsdXVzIHA9JTEwbHV1cyBwMj0lMTBsdXVzOyBwPSUuMWYqZiBwPSUuMWYqZjIgcD0l
LjFmKnAyXG4iLAotCSAgICAgICBucl9tb3VudHMsIGZfZHVyLCBmMl9kdXIsIHBfZHVyLCBwMl9k
dXIsCisJcHJpbnRmKCJGb3IgJTdkIG1vdW50cywgZj0lMTBsdXVzIGYyPSUxMGx1dXMgcD0lMTBs
dXVzIHAyPSUxMGx1dXM7IG09JTEwbHV1czsgcD0lLjFmKmYgcD0lLjFmKmYyIHA9JS4xZipwMiBw
PSUuMWYqbVxuIiwKKwkgICAgICAgbnJfbW91bnRzLCBmX2R1ciwgZjJfZHVyLCBwX2R1ciwgcDJf
ZHVyLCBtX2R1ciwKIAkgICAgICAgKGRvdWJsZSlwX2R1ciAvIChkb3VibGUpZl9kdXIsCiAJICAg
ICAgIChkb3VibGUpcF9kdXIgLyAoZG91YmxlKWYyX2R1ciwKLQkgICAgICAgKGRvdWJsZSlwX2R1
ciAvIChkb3VibGUpcDJfZHVyKTsKKwkgICAgICAgKGRvdWJsZSlwX2R1ciAvIChkb3VibGUpcDJf
ZHVyLAorCSAgICAgICAoZG91YmxlKXBfZHVyIC8gKGRvdWJsZSltX2R1cik7CiAJcmV0dXJuIDA7
CiB9Cg==
--00000000000085172a05a23c4d0d--
