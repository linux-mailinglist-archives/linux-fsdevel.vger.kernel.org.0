Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C741F6B2F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 02:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbfGQAt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 20:49:56 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:33123 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfGQAt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:49:56 -0400
Received: by mail-pl1-f182.google.com with SMTP id c14so10974245plo.0;
        Tue, 16 Jul 2019 17:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tGsN9GPdMew1/H698m+/9lZZK7mS0PNqO3Qz666Qn2o=;
        b=bDIW/Cri00OIuOV6jk66vr92OJaPvX3EWm5RpJKl2gZ++vKzOloKjmA1UdHuu2wx3u
         9X/KNKvRz38wkb1Mq8oSBQnx2WkGqeNtvKRAnEGx2gzlKLY/6a93gX60PpmvgWYT9T2W
         W8lVgkxug0i9hw/ELC8yj0Gh90MRzKiQ0wiBiH6VJYA2ocFSkgE1tQ+P4vRi9bWnvkPG
         k9gXC053VlMoQ07NAzLmAVc0f292aEY+LZQOeMufQN9teSVZCNREaFnQ9f56NvivDh2i
         gM+/9iUDfywAk5G9b+5LkmE6QkCaOYC8tBI1n7u1tsnmOChpoM4A7kpd6h/zXqep+0Un
         gQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tGsN9GPdMew1/H698m+/9lZZK7mS0PNqO3Qz666Qn2o=;
        b=gnFpWY51UdR0UUSB0RWiAInjXK11+nj4Db/0sOC+Za6vfmBe9hOufWc4E4GBo5G8Q1
         HQdbNEaWAaHr7rMmJZC3Bt9ZRZLCPLqvHLtzgdfgJHOn1+bH1p/imK6ijdltM6ExhBG5
         qqelu9f5+9K+QCl1+nh48r8AfuCHJyE2gr/Rx8Ohn1t8pxyxJ88XbGq/BLxnRVVMsgiw
         w6RL8lLxDZmDhiC05F8DJYCHCb2NGh3tulShnKoMeyUJyfyhPhA4n1o6MJiDfYQ9n6tt
         7M82jLkCbaamOAhZ10qyjzjaiUbX+3UTTwIfl3otzj1iTA9qYnLyZG6Pt0nX6RFvteJ4
         a5Vw==
X-Gm-Message-State: APjAAAXjuMJ3tpjxPHI4DxmyACdq35jfETDMrm5sZLX7DqxOkZs17/LQ
        QJF78GJG5wBkjXv/0vVBNNsUhDNBlHhJ9k9AxNtGTEzt
X-Google-Smtp-Source: APXvYqx/Fn6jhtRc2jduP62kMVS2lDV1QVw+wHUGTTIMyW3+yGisfeKtgbMRzGvShWHXkoOAgu9jVbY90/jLVKWbSfk=
X-Received: by 2002:a17:902:2a68:: with SMTP id i95mr39960047plb.167.1563324594779;
 Tue, 16 Jul 2019 17:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mtXjyUP6_h86o5GmKxZ2syubbnc2-L95ctf96=TvBnbyA@mail.gmail.com>
In-Reply-To: <CAH2r5mtXjyUP6_h86o5GmKxZ2syubbnc2-L95ctf96=TvBnbyA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 16 Jul 2019 19:49:43 -0500
Message-ID: <CAH2r5mtQ2QNn+fbdQ_HFSJQ-zv2m4-b02RYVGum0Fy+=yHgftA@mail.gmail.com>
Subject: Re: [PATCH][CIFS] Add flock support
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000247153058dd5df5e"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000247153058dd5df5e
Content-Type: text/plain; charset="UTF-8"

Pavel spotted the problem - fixed and reattached updated patch


On Tue, Jul 16, 2019 at 7:02 PM Steve French <smfrench@gmail.com> wrote:
>
> The attached patch adds support for flock support similar to AFS, NFS etc.
>
> Although the patch did seem to work in my experiments with flock, I did notice
> that xfstest generic/504 fails because /proc/locks is not updated by cifs.ko
> after a successful lock.  Any idea which helper function does that?
>
>
> --
> Thanks,
>
> Steve



--
Thanks,

Steve

--000000000000247153058dd5df5e
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-cifs-add-support-for-flock.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-add-support-for-flock.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jy6j398j0>
X-Attachment-Id: f_jy6j398j0

RnJvbSA4ZDM5ZjZmZTAzZGIyNTBmZTUyNmMwMDI4MDE2MDczYWZhMDIwYjAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgMTYgSnVsIDIwMTkgMTg6NTU6MzggLTA1MDAKU3ViamVjdDogW1BBVENIXSBj
aWZzOiBhZGQgc3VwcG9ydCBmb3IgZmxvY2sKClRoZSBmbG9jayBzeXN0ZW0gY2FsbCBsb2NrcyB0
aGUgd2hvbGUgZmlsZSByYXRoZXIgdGhhbiBhIGJ5dGUKcmFuZ2UgYW5kIHNvIGlzIGN1cnJlbnRs
eSBlbXVsYXRlZCBieSB2YXJpb3VzIG90aGVyIGZpbGUgc3lzdGVtcwpieSBzaW1wbHkgc2VuZGlu
ZyBhIGJ5dGUgcmFuZ2UgbG9jayBmb3IgdGhlIHdob2xlIGZpbGUuCkFkZCBmbG9jayBoYW5kbGlu
ZyBmb3IgY2lmcy5rbyBpbiBzaW1pbGFyIHdheS4KCnhmc3Rlc3QgZ2VuZXJpYy81MDQgcGFzc2Vz
IHdpdGggdGhpcyBhcyB3ZWxsCgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNo
QG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvY2lmcy9jaWZzZnMuYyB8ICAzICsrKwogZnMvY2lmcy9j
aWZzZnMuaCB8ICAxICsKIGZzL2NpZnMvZmlsZS5jICAgfCA1MiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDMgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc2ZzLmMgYi9m
cy9jaWZzL2NpZnNmcy5jCmluZGV4IDMyMGM3YTZmZDMxOC4uYTY3NGY1MmIwNDAzIDEwMDY0NAot
LS0gYS9mcy9jaWZzL2NpZnNmcy5jCisrKyBiL2ZzL2NpZnMvY2lmc2ZzLmMKQEAgLTExNjgsNiAr
MTE2OCw3IEBAIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgY2lmc19maWxlX29wcyA9IHsK
IAkub3BlbiA9IGNpZnNfb3BlbiwKIAkucmVsZWFzZSA9IGNpZnNfY2xvc2UsCiAJLmxvY2sgPSBj
aWZzX2xvY2ssCisJLmZsb2NrID0gY2lmc19mbG9jaywKIAkuZnN5bmMgPSBjaWZzX2ZzeW5jLAog
CS5mbHVzaCA9IGNpZnNfZmx1c2gsCiAJLm1tYXAgID0gY2lmc19maWxlX21tYXAsCkBAIC0xMTg3
LDYgKzExODgsNyBAQCBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGNpZnNfZmlsZV9zdHJp
Y3Rfb3BzID0gewogCS5vcGVuID0gY2lmc19vcGVuLAogCS5yZWxlYXNlID0gY2lmc19jbG9zZSwK
IAkubG9jayA9IGNpZnNfbG9jaywKKwkuZmxvY2sgPSBjaWZzX2Zsb2NrLAogCS5mc3luYyA9IGNp
ZnNfc3RyaWN0X2ZzeW5jLAogCS5mbHVzaCA9IGNpZnNfZmx1c2gsCiAJLm1tYXAgPSBjaWZzX2Zp
bGVfc3RyaWN0X21tYXAsCkBAIC0xMjA2LDYgKzEyMDgsNyBAQCBjb25zdCBzdHJ1Y3QgZmlsZV9v
cGVyYXRpb25zIGNpZnNfZmlsZV9kaXJlY3Rfb3BzID0gewogCS5vcGVuID0gY2lmc19vcGVuLAog
CS5yZWxlYXNlID0gY2lmc19jbG9zZSwKIAkubG9jayA9IGNpZnNfbG9jaywKKwkuZmxvY2sgPSBj
aWZzX2Zsb2NrLAogCS5mc3luYyA9IGNpZnNfZnN5bmMsCiAJLmZsdXNoID0gY2lmc19mbHVzaCwK
IAkubW1hcCA9IGNpZnNfZmlsZV9tbWFwLApkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzZnMuaCBi
L2ZzL2NpZnMvY2lmc2ZzLmgKaW5kZXggYWVhMDA1NzAzNzg1Li4yNjJmNzA5ODIyZWUgMTAwNjQ0
Ci0tLSBhL2ZzL2NpZnMvY2lmc2ZzLmgKKysrIGIvZnMvY2lmcy9jaWZzZnMuaApAQCAtMTA4LDYg
KzEwOCw3IEBAIGV4dGVybiBzc2l6ZV90IGNpZnNfc3RyaWN0X3JlYWR2KHN0cnVjdCBraW9jYiAq
aW9jYiwgc3RydWN0IGlvdl9pdGVyICp0byk7CiBleHRlcm4gc3NpemVfdCBjaWZzX3VzZXJfd3Jp
dGV2KHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKTsKIGV4dGVybiBz
c2l6ZV90IGNpZnNfZGlyZWN0X3dyaXRldihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3Zf
aXRlciAqZnJvbSk7CiBleHRlcm4gc3NpemVfdCBjaWZzX3N0cmljdF93cml0ZXYoc3RydWN0IGtp
b2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20pOworZXh0ZXJuIGludCBjaWZzX2Zsb2Nr
KHN0cnVjdCBmaWxlICosIGludCwgc3RydWN0IGZpbGVfbG9jayAqKTsKIGV4dGVybiBpbnQgY2lm
c19sb2NrKHN0cnVjdCBmaWxlICosIGludCwgc3RydWN0IGZpbGVfbG9jayAqKTsKIGV4dGVybiBp
bnQgY2lmc19mc3luYyhzdHJ1Y3QgZmlsZSAqLCBsb2ZmX3QsIGxvZmZfdCwgaW50KTsKIGV4dGVy
biBpbnQgY2lmc19zdHJpY3RfZnN5bmMoc3RydWN0IGZpbGUgKiwgbG9mZl90LCBsb2ZmX3QsIGlu
dCk7CmRpZmYgLS1naXQgYS9mcy9jaWZzL2ZpbGUuYyBiL2ZzL2NpZnMvZmlsZS5jCmluZGV4IDk3
MDkwNjkzZDE4Mi4uZTJkZWY4OTFmYjJjIDEwMDY0NAotLS0gYS9mcy9jaWZzL2ZpbGUuYworKysg
Yi9mcy9jaWZzL2ZpbGUuYwpAQCAtMTY2OCw3ICsxNjY4LDcgQEAgY2lmc19zZXRsayhzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgc3RydWN0IGZpbGVfbG9jayAqZmxvY2ssIF9fdTMyIHR5cGUsCiAJCXJjID0g
c2VydmVyLT5vcHMtPm1hbmRfdW5sb2NrX3JhbmdlKGNmaWxlLCBmbG9jaywgeGlkKTsKIAogb3V0
OgotCWlmIChmbG9jay0+ZmxfZmxhZ3MgJiBGTF9QT1NJWCkgeworCWlmICgoZmxvY2stPmZsX2Zs
YWdzICYgRkxfUE9TSVgpIHx8IChmbG9jay0+ZmxfZmxhZ3MgJiBGTF9GTE9DSykpIHsKIAkJLyoK
IAkJICogSWYgdGhpcyBpcyBhIHJlcXVlc3QgdG8gcmVtb3ZlIGFsbCBsb2NrcyBiZWNhdXNlIHdl
CiAJCSAqIGFyZSBjbG9zaW5nIHRoZSBmaWxlLCBpdCBkb2Vzbid0IG1hdHRlciBpZiB0aGUKQEAg
LTE2ODUsNiArMTY4NSw1NiBAQCBjaWZzX3NldGxrKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3Qg
ZmlsZV9sb2NrICpmbG9jaywgX191MzIgdHlwZSwKIAlyZXR1cm4gcmM7CiB9CiAKK2ludCBjaWZz
X2Zsb2NrKHN0cnVjdCBmaWxlICpmaWxlLCBpbnQgY21kLCBzdHJ1Y3QgZmlsZV9sb2NrICpmbCkK
K3sKKwlpbnQgcmMsIHhpZDsKKwlpbnQgbG9jayA9IDAsIHVubG9jayA9IDA7CisJYm9vbCB3YWl0
X2ZsYWcgPSBmYWxzZTsKKwlib29sIHBvc2l4X2xjayA9IGZhbHNlOworCXN0cnVjdCBjaWZzX3Ni
X2luZm8gKmNpZnNfc2I7CisJc3RydWN0IGNpZnNfdGNvbiAqdGNvbjsKKwlzdHJ1Y3QgY2lmc0lu
b2RlSW5mbyAqY2lub2RlOworCXN0cnVjdCBjaWZzRmlsZUluZm8gKmNmaWxlOworCV9fdTE2IG5l
dGZpZDsKKwlfX3UzMiB0eXBlOworCisJcmMgPSAtRUFDQ0VTOworCXhpZCA9IGdldF94aWQoKTsK
KworCWlmICghKGZsLT5mbF9mbGFncyAmIEZMX0ZMT0NLKSkKKwkJcmV0dXJuIC1FTk9MQ0s7CisK
KwljZmlsZSA9IChzdHJ1Y3QgY2lmc0ZpbGVJbmZvICopZmlsZS0+cHJpdmF0ZV9kYXRhOworCXRj
b24gPSB0bGlua190Y29uKGNmaWxlLT50bGluayk7CisKKwljaWZzX3JlYWRfZmxvY2soZmwsICZ0
eXBlLCAmbG9jaywgJnVubG9jaywgJndhaXRfZmxhZywKKwkJCXRjb24tPnNlcy0+c2VydmVyKTsK
KwljaWZzX3NiID0gQ0lGU19GSUxFX1NCKGZpbGUpOworCW5ldGZpZCA9IGNmaWxlLT5maWQubmV0
ZmlkOworCWNpbm9kZSA9IENJRlNfSShmaWxlX2lub2RlKGZpbGUpKTsKKworCWlmIChjYXBfdW5p
eCh0Y29uLT5zZXMpICYmCisJICAgIChDSUZTX1VOSVhfRkNOVExfQ0FQICYgbGU2NF90b19jcHUo
dGNvbi0+ZnNVbml4SW5mby5DYXBhYmlsaXR5KSkgJiYKKwkgICAgKChjaWZzX3NiLT5tbnRfY2lm
c19mbGFncyAmIENJRlNfTU9VTlRfTk9QT1NJWEJSTCkgPT0gMCkpCisJCXBvc2l4X2xjayA9IHRy
dWU7CisKKwlpZiAoIWxvY2sgJiYgIXVubG9jaykgeworCQkvKgorCQkgKiBpZiBubyBsb2NrIG9y
IHVubG9jayB0aGVuIG5vdGhpbmcgdG8gZG8gc2luY2Ugd2UgZG8gbm90CisJCSAqIGtub3cgd2hh
dCBpdCBpcworCQkgKi8KKwkJZnJlZV94aWQoeGlkKTsKKwkJcmV0dXJuIC1FT1BOT1RTVVBQOwor
CX0KKworCXJjID0gY2lmc19zZXRsayhmaWxlLCBmbCwgdHlwZSwgd2FpdF9mbGFnLCBwb3NpeF9s
Y2ssIGxvY2ssIHVubG9jaywKKwkJCXhpZCk7CisJZnJlZV94aWQoeGlkKTsKKwlyZXR1cm4gcmM7
CisKKworfQorCiBpbnQgY2lmc19sb2NrKHN0cnVjdCBmaWxlICpmaWxlLCBpbnQgY21kLCBzdHJ1
Y3QgZmlsZV9sb2NrICpmbG9jaykKIHsKIAlpbnQgcmMsIHhpZDsKLS0gCjIuMjAuMQoK
--000000000000247153058dd5df5e--
