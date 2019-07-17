Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7206B29E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 02:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfGQADB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 20:03:01 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:42649 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGQADB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:03:01 -0400
Received: by mail-pl1-f177.google.com with SMTP id ay6so10940269plb.9;
        Tue, 16 Jul 2019 17:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6qtRzCGL7WK76UGXP+HRSEdebM0ElpllvtXWv0KXh+k=;
        b=nWjYiwIsvy2m3ZL48akqQF57rrKGmA7iHENDwP7ja3iIPEnx4yLNgcyPw45fgGN6WU
         hOPHtq1nrWg/CKWr4kHxDMbniajrAdM+lV3/1iP7iGwSACLOkYGUmYGKZDUVJ/a6mHng
         SCbDA1m9DQ8T0kx/tAVkTaOir1dVZcVYzaY/GkMorX5UYoccoh5P7Gk9iHouPR5XYG7A
         vdkPC7pflDxuH9jHiPhMI9bB0uSpcmpuICdTopZDtYfdDqcCbxu3D3aKvEFYeZTM8uFl
         5xmsq0TJ1U3WJEbRpEo/3bmxk4wTJF/UZpuzGTXjcNQH8HkzLt4Bi0nf82fr99d4SChE
         tdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6qtRzCGL7WK76UGXP+HRSEdebM0ElpllvtXWv0KXh+k=;
        b=tE/BLB/GwS9C+iikyOX7fuSJxDtogzlIlooGAkImh0Y8R3VNj7cEiFRzAAq6bt6Raf
         hQ8OeEGFmbqMRf6rWo30vKy07uN/UNtiP4ojoG35/fZ12KWDCKlqqG4xkerlDA0FInuv
         dtuvyrfJWq/ZGU9FNKE51MMzW1G7a427gwhbm9qKp8XvCGpK9jec85QiRrIdr4ZtAF/n
         b2FKBGvu8wuv4TcuKjrcDc8sm5oC/91MZIE7MVvBVu9OyWJvXM0sau2nhXGwPsk+j3Dn
         Ab0cPrZFYfUDXiJyAHyFBJtJdfIWcSYj70F4ZWOXEPyAF80Sq690tAK1uXToUnTyepLR
         HZ5w==
X-Gm-Message-State: APjAAAVu73QsnCnVYjYafzR0FZGqxPvT2vJXDk3OyXBLIXLPHL4jcz2U
        Go7GXt0Nzv+GexvoUneqoi42gr98qixu6m4/vw3zNyXu
X-Google-Smtp-Source: APXvYqzYlcIxK8DZAZ2lJxHm/qKgtSlmbXhMo9AJTr27xxbj04/ojlCXKhVcZag7HFx5+gp4CxGkjhFZ1tyc7dmO4NY=
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr39595363plc.78.1563321779919;
 Tue, 16 Jul 2019 17:02:59 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 16 Jul 2019 19:02:48 -0500
Message-ID: <CAH2r5mtXjyUP6_h86o5GmKxZ2syubbnc2-L95ctf96=TvBnbyA@mail.gmail.com>
Subject: [PATCH][CIFS] Add flock support
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000005cd052058dd5373c"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000005cd052058dd5373c
Content-Type: text/plain; charset="UTF-8"

The attached patch adds support for flock support similar to AFS, NFS etc.

Although the patch did seem to work in my experiments with flock, I did notice
that xfstest generic/504 fails because /proc/locks is not updated by cifs.ko
after a successful lock.  Any idea which helper function does that?


-- 
Thanks,

Steve

--0000000000005cd052058dd5373c
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-cifs-add-support-for-flock.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-add-support-for-flock.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jy6hex8u0>
X-Attachment-Id: f_jy6hex8u0

RnJvbSA5ZGU4ZTY4YThhYjBjN2U1OTA4MDg3NGYwNWIxZGYzNzQ3N2NmNjkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgMTYgSnVsIDIwMTkgMTg6NTU6MzggLTA1MDAKU3ViamVjdDogW1BBVENIXSBj
aWZzOiBhZGQgc3VwcG9ydCBmb3IgZmxvY2sKClRoZSBmbG9jayBzeXN0ZW0gY2FsbCBsb2NrcyB0
aGUgd2hvbGUgZmlsZSByYXRoZXIgdGhhbiBhIGJ5dGUKcmFuZ2UgYW5kIGlzIGN1cnJlbnRseSBl
bXVsYXRlZCBieSB2YXJpb3VzIG90aGVyIGZpbGUgc3lzdGVtcwpieSBzaW1wbHkgc2VuZGluZyBh
IGJ5dGUgcmFuZ2UgbG9jayBmb3IgdGhlIHdob2xlIGZpbGUuCgpUaGlzIHZlcnNpb24gb2YgdGhl
IHBhdGNoIG5lZWRzIGEgbWlub3IgdXBkYXRlIHRvIHBhc3MKeGZzdGVzdCBnZW5lcmljLzUwNCAo
d2UgbmVlZCB0byBmaWd1cmUgb3V0IGhvdyB0byB1cGRhdGUKL3Byb2MvbG9ja3MgYWZ0ZXIgYW4g
ZmxvY2sgY2FsbCBpcyBncmFudGVkKQoKU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZy
ZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL2NpZnMvY2lmc2ZzLmMgfCAgMyArKysKIGZzL2Np
ZnMvY2lmc2ZzLmggfCAgMSArCiBmcy9jaWZzL2ZpbGUuYyAgIHwgNTQgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDU4IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNmcy5jIGIvZnMvY2lmcy9jaWZz
ZnMuYwppbmRleCAzMjBjN2E2ZmQzMTguLmE2NzRmNTJiMDQwMyAxMDA2NDQKLS0tIGEvZnMvY2lm
cy9jaWZzZnMuYworKysgYi9mcy9jaWZzL2NpZnNmcy5jCkBAIC0xMTY4LDYgKzExNjgsNyBAQCBj
b25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGNpZnNfZmlsZV9vcHMgPSB7CiAJLm9wZW4gPSBj
aWZzX29wZW4sCiAJLnJlbGVhc2UgPSBjaWZzX2Nsb3NlLAogCS5sb2NrID0gY2lmc19sb2NrLAor
CS5mbG9jayA9IGNpZnNfZmxvY2ssCiAJLmZzeW5jID0gY2lmc19mc3luYywKIAkuZmx1c2ggPSBj
aWZzX2ZsdXNoLAogCS5tbWFwICA9IGNpZnNfZmlsZV9tbWFwLApAQCAtMTE4Nyw2ICsxMTg4LDcg
QEAgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBjaWZzX2ZpbGVfc3RyaWN0X29wcyA9IHsK
IAkub3BlbiA9IGNpZnNfb3BlbiwKIAkucmVsZWFzZSA9IGNpZnNfY2xvc2UsCiAJLmxvY2sgPSBj
aWZzX2xvY2ssCisJLmZsb2NrID0gY2lmc19mbG9jaywKIAkuZnN5bmMgPSBjaWZzX3N0cmljdF9m
c3luYywKIAkuZmx1c2ggPSBjaWZzX2ZsdXNoLAogCS5tbWFwID0gY2lmc19maWxlX3N0cmljdF9t
bWFwLApAQCAtMTIwNiw2ICsxMjA4LDcgQEAgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBj
aWZzX2ZpbGVfZGlyZWN0X29wcyA9IHsKIAkub3BlbiA9IGNpZnNfb3BlbiwKIAkucmVsZWFzZSA9
IGNpZnNfY2xvc2UsCiAJLmxvY2sgPSBjaWZzX2xvY2ssCisJLmZsb2NrID0gY2lmc19mbG9jaywK
IAkuZnN5bmMgPSBjaWZzX2ZzeW5jLAogCS5mbHVzaCA9IGNpZnNfZmx1c2gsCiAJLm1tYXAgPSBj
aWZzX2ZpbGVfbW1hcCwKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc2ZzLmggYi9mcy9jaWZzL2Np
ZnNmcy5oCmluZGV4IGFlYTAwNTcwMzc4NS4uMjYyZjcwOTgyMmVlIDEwMDY0NAotLS0gYS9mcy9j
aWZzL2NpZnNmcy5oCisrKyBiL2ZzL2NpZnMvY2lmc2ZzLmgKQEAgLTEwOCw2ICsxMDgsNyBAQCBl
eHRlcm4gc3NpemVfdCBjaWZzX3N0cmljdF9yZWFkdihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVj
dCBpb3ZfaXRlciAqdG8pOwogZXh0ZXJuIHNzaXplX3QgY2lmc191c2VyX3dyaXRldihzdHJ1Y3Qg
a2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSk7CiBleHRlcm4gc3NpemVfdCBjaWZz
X2RpcmVjdF93cml0ZXYoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20p
OwogZXh0ZXJuIHNzaXplX3QgY2lmc19zdHJpY3Rfd3JpdGV2KHN0cnVjdCBraW9jYiAqaW9jYiwg
c3RydWN0IGlvdl9pdGVyICpmcm9tKTsKK2V4dGVybiBpbnQgY2lmc19mbG9jayhzdHJ1Y3QgZmls
ZSAqZmlsZSwgaW50IGNtZCwgc3RydWN0IGZpbGVfbG9jayAqZmwpOwogZXh0ZXJuIGludCBjaWZz
X2xvY2soc3RydWN0IGZpbGUgKiwgaW50LCBzdHJ1Y3QgZmlsZV9sb2NrICopOwogZXh0ZXJuIGlu
dCBjaWZzX2ZzeW5jKHN0cnVjdCBmaWxlICosIGxvZmZfdCwgbG9mZl90LCBpbnQpOwogZXh0ZXJu
IGludCBjaWZzX3N0cmljdF9mc3luYyhzdHJ1Y3QgZmlsZSAqLCBsb2ZmX3QsIGxvZmZfdCwgaW50
KTsKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvZmlsZS5jIGIvZnMvY2lmcy9maWxlLmMKaW5kZXggOTcw
OTA2OTNkMTgyLi42NDE5Mjc3NTVkMGIgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvZmlsZS5jCisrKyBi
L2ZzL2NpZnMvZmlsZS5jCkBAIC0xNjg1LDYgKzE2ODUsNjAgQEAgY2lmc19zZXRsayhzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgc3RydWN0IGZpbGVfbG9jayAqZmxvY2ssIF9fdTMyIHR5cGUsCiAJcmV0dXJu
IHJjOwogfQogCitpbnQgY2lmc19mbG9jayhzdHJ1Y3QgZmlsZSAqZmlsZSwgaW50IGNtZCwgc3Ry
dWN0IGZpbGVfbG9jayAqZmwpCit7CisJaW50IHJjLCB4aWQ7CisJaW50IGxvY2sgPSAwLCB1bmxv
Y2sgPSAwOworCWJvb2wgd2FpdF9mbGFnID0gZmFsc2U7CisJYm9vbCBwb3NpeF9sY2sgPSBmYWxz
ZTsKKwlzdHJ1Y3QgY2lmc19zYl9pbmZvICpjaWZzX3NiOworCXN0cnVjdCBjaWZzX3Rjb24gKnRj
b247CisJc3RydWN0IGNpZnNJbm9kZUluZm8gKmNpbm9kZTsKKwlzdHJ1Y3QgY2lmc0ZpbGVJbmZv
ICpjZmlsZTsKKwlfX3UxNiBuZXRmaWQ7CisJX191MzIgdHlwZTsKKworCXJjID0gLUVBQ0NFUzsK
Kwl4aWQgPSBnZXRfeGlkKCk7CisKKwlpZiAoIShmbC0+ZmxfZmxhZ3MgJiBGTF9GTE9DSykpIHsK
KwkJY2lmc19kYmcoVkZTLCAicmV0IG5vbG9ja1xuIik7CisJCXJldHVybiAtRU5PTENLOworCX0K
KworCWNmaWxlID0gKHN0cnVjdCBjaWZzRmlsZUluZm8gKilmaWxlLT5wcml2YXRlX2RhdGE7CisJ
dGNvbiA9IHRsaW5rX3Rjb24oY2ZpbGUtPnRsaW5rKTsKKworCWNpZnNfcmVhZF9mbG9jayhmbCwg
JnR5cGUsICZsb2NrLCAmdW5sb2NrLCAmd2FpdF9mbGFnLAorCQkJdGNvbi0+c2VzLT5zZXJ2ZXIp
OworCWNpZnNfc2IgPSBDSUZTX0ZJTEVfU0IoZmlsZSk7CisJbmV0ZmlkID0gY2ZpbGUtPmZpZC5u
ZXRmaWQ7CisJY2lub2RlID0gQ0lGU19JKGZpbGVfaW5vZGUoZmlsZSkpOworCisJaWYgKGNhcF91
bml4KHRjb24tPnNlcykgJiYKKwkgICAgKENJRlNfVU5JWF9GQ05UTF9DQVAgJiBsZTY0X3RvX2Nw
dSh0Y29uLT5mc1VuaXhJbmZvLkNhcGFiaWxpdHkpKSAmJgorCSAgICAoKGNpZnNfc2ItPm1udF9j
aWZzX2ZsYWdzICYgQ0lGU19NT1VOVF9OT1BPU0lYQlJMKSA9PSAwKSkKKwkJcG9zaXhfbGNrID0g
dHJ1ZTsKKworCWlmICghbG9jayAmJiAhdW5sb2NrKSB7CisJCS8qCisJCSAqIGlmIG5vIGxvY2sg
b3IgdW5sb2NrIHRoZW4gbm90aGluZyB0byBkbyBzaW5jZSB3ZSBkbyBub3QKKwkJICoga25vdyB3
aGF0IGl0IGlzCisJCSAqLworCQljaWZzX2RiZyhWRlMsICJyZXR1cm4gRkxPQ0sgRU9QTk9UU1VQ
UFxuIik7CisJCWZyZWVfeGlkKHhpZCk7CisJCXJldHVybiAtRU9QTk9UU1VQUDsKKwl9CisKKwly
YyA9IGNpZnNfc2V0bGsoZmlsZSwgZmwsIHR5cGUsIHdhaXRfZmxhZywgcG9zaXhfbGNrLCBsb2Nr
LCB1bmxvY2ssCisJCQl4aWQpOworCWZyZWVfeGlkKHhpZCk7CisJY2lmc19kYmcoVkZTLCAiRkxP
Q0sgcmMgPSAlZFxuIiwgcmMpOworCXJldHVybiByYzsKKworCit9CisKIGludCBjaWZzX2xvY2so
c3RydWN0IGZpbGUgKmZpbGUsIGludCBjbWQsIHN0cnVjdCBmaWxlX2xvY2sgKmZsb2NrKQogewog
CWludCByYywgeGlkOwotLSAKMi4yMC4xCgo=
--0000000000005cd052058dd5373c--
