Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7351F07E3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgFFQVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 12:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFFQVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 12:21:40 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A8EC03E96A;
        Sat,  6 Jun 2020 09:21:40 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id n123so6587819ybf.11;
        Sat, 06 Jun 2020 09:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MkbFJW3zlfS1nj8UUVM07ap+5iMMnw5cR08lDE3m/m4=;
        b=qVz6lhjDXU5VtVpy69TGLakvdzzzlFRhDh0YIL+c573Lv8FMw4IoPV9fomV3KJhF1k
         fOs3jM+XhrRv67uRBc9eJvDgZiSUdR99t5pq80PM+0X+He/jmsiA6XEUr25mjTNu1QQM
         nOzVIF5uSt5WlSX0BL3H9rQtsexgDd4p+qir2WcN3bF5hIoJep8vQswWIlTMYWR9xkuU
         V+RmM7e1VTHu/o3AzUbpOZub+aoDKJxBX9km1jhEjrVWZ/u4VnAV96OQEm1652aTqnMT
         WWdWmEnhxhifRq9b3JmK5s2wWYAgNkzb/WcQyxvlnAyEnEmt4EOhv0pahzIo/lFJK9US
         Htbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkbFJW3zlfS1nj8UUVM07ap+5iMMnw5cR08lDE3m/m4=;
        b=JL9U+yRBsEYDAH81D+s6cK3bzTCJ+nTrxp2DktAayzD2HpiJ5Qcuy3HGLmZbPT5xdh
         muc2bS3ST1PgUdzd1v4JINPfXrrRUfGbda+YT34bTCHGvJ3NNtLmcGtB6urWmP7PJSMV
         38TdJNLJFOXnOwZQNoDsJg6u9E0CqtjEeKNtq35eu2eRDR6wAvyvVm+yCDyAzWxQVttS
         vdlyFl4udAt+LP8lpQBnyELnNFSdwTFI40M0OnUkjqWaPS0vKsrdp5pB5z3bEyvS4HnV
         PLYd32RRV9YQHdlp2f3ZcGJooxUacomVgJG7QSvOmc6rT21i7o6lhKt8D1IF9QUFNDi0
         y0Uw==
X-Gm-Message-State: AOAM532YhPeHT7av60FFSjAaa0XMWDx4tLY2TdgjnGzf3NLXT3jB5Vy2
        s+2+4R6HEkGLEnU9vfS/B1UvWcnbjSz7QMn8yPSd1mX3
X-Google-Smtp-Source: ABdhPJx3CbzeWmHDBFpe03lR0igPK/aI4ujZvptp2gZNyKc36kf53VDk2MSawQr0Ou9xIS/r5xNWTS/2Qpm81JDT000=
X-Received: by 2002:a25:ba0f:: with SMTP id t15mr26229185ybg.376.1591460499107;
 Sat, 06 Jun 2020 09:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msEO21T56=yOQKCEz4mLinKQUd13MxEBMQeQFzvJZZCOQ@mail.gmail.com>
In-Reply-To: <CAH2r5msEO21T56=yOQKCEz4mLinKQUd13MxEBMQeQFzvJZZCOQ@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 6 Jun 2020 11:21:28 -0500
Message-ID: <CAH2r5mtX_Rm33dpdw_N0HoP+rC+YObQrYygnitBQz5kGHReZyA@mail.gmail.com>
Subject: Re: [PATCH] smb3: extend fscache mount volume coherency check
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000b953f905a76cc53e"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000b953f905a76cc53e
Content-Type: text/plain; charset="UTF-8"

slightly updated to fix a sparse endian warning


On Fri, Jun 5, 2020 at 5:24 PM Steve French <smfrench@gmail.com> wrote:
>
> It is better to check volume id and creation time, not just
> the root inode number to verify if the volume has changed
> when remounting.
>
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Steve French <stfrench@microsoft.com>
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve

--000000000000b953f905a76cc53e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-extend-fscache-mount-volume-coherency-check.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-extend-fscache-mount-volume-coherency-check.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kb3uhdap0>
X-Attachment-Id: f_kb3uhdap0

RnJvbSA1ODY1OTg1NDE2ZWJiNWEwYzE5OGE4MTlhMDk4YjVjYzMwMGFjOGE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IEZyaSwgNSBKdW4gMjAyMCAxNzoxOTo0NiAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIHNt
YjM6IGV4dGVuZCBmc2NhY2hlIG1vdW50IHZvbHVtZSBjb2hlcmVuY3kgY2hlY2sKCkl0IGlzIGJl
dHRlciB0byBjaGVjayB2b2x1bWUgaWQgYW5kIGNyZWF0aW9uIHRpbWUsIG5vdCBqdXN0CnRoZSBy
b290IGlub2RlIG51bWJlciB0byB2ZXJpZnkgaWYgdGhlIHZvbHVtZSBoYXMgY2hhbmdlZAp3aGVu
IHJlbW91bnRpbmcuCgpSZXZpZXdlZC1ieTogRGF2aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0
LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNyb3NvZnQuY29t
PgotLS0KIGZzL2NpZnMvY2FjaGUuYyAgIHwgIDkgKystLS0tLS0tCiBmcy9jaWZzL2ZzY2FjaGUu
YyB8IDE3ICsrKysrKysrKysrKysrKy0tCiBmcy9jaWZzL2ZzY2FjaGUuaCB8ICA5ICsrKysrKysr
KwogMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2ZzL2NpZnMvY2FjaGUuYyBiL2ZzL2NpZnMvY2FjaGUuYwppbmRleCBiNzQyMGU2
MDViMjguLjBmMmFkZWNiOTRmMiAxMDA2NDQKLS0tIGEvZnMvY2lmcy9jYWNoZS5jCisrKyBiL2Zz
L2NpZnMvY2FjaGUuYwpAQCAtNTMsMTMgKzUzLDYgQEAgY29uc3Qgc3RydWN0IGZzY2FjaGVfY29v
a2llX2RlZiBjaWZzX2ZzY2FjaGVfc2VydmVyX2luZGV4X2RlZiA9IHsKIAkudHlwZSA9IEZTQ0FD
SEVfQ09PS0lFX1RZUEVfSU5ERVgsCiB9OwogCi0vKgotICogQXV4aWxpYXJ5IGRhdGEgYXR0YWNo
ZWQgdG8gQ0lGUyBzdXBlcmJsb2NrIHdpdGhpbiB0aGUgY2FjaGUKLSAqLwotc3RydWN0IGNpZnNf
ZnNjYWNoZV9zdXBlcl9hdXhkYXRhIHsKLQl1NjQJcmVzb3VyY2VfaWQ7CQkvKiB1bmlxdWUgc2Vy
dmVyIHJlc291cmNlIGlkICovCi19OwotCiBjaGFyICpleHRyYWN0X3NoYXJlbmFtZShjb25zdCBj
aGFyICp0cmVlbmFtZSkKIHsKIAljb25zdCBjaGFyICpzcmM7CkBAIC05OCw2ICs5MSw4IEBAIGZz
Y2FjaGVfY2hlY2thdXggY2lmc19mc2NhY2hlX3N1cGVyX2NoZWNrX2F1eCh2b2lkICpjb29raWVf
bmV0ZnNfZGF0YSwKIAogCW1lbXNldCgmYXV4ZGF0YSwgMCwgc2l6ZW9mKGF1eGRhdGEpKTsKIAlh
dXhkYXRhLnJlc291cmNlX2lkID0gdGNvbi0+cmVzb3VyY2VfaWQ7CisJYXV4ZGF0YS52b2xfY3Jl
YXRlX3RpbWUgPSB0Y29uLT52b2xfY3JlYXRlX3RpbWU7CisJYXV4ZGF0YS52b2xfc2VyaWFsX251
bWJlciA9IHRjb24tPnZvbF9zZXJpYWxfbnVtYmVyOwogCiAJaWYgKG1lbWNtcChkYXRhLCAmYXV4
ZGF0YSwgZGF0YWxlbikgIT0gMCkKIAkJcmV0dXJuIEZTQ0FDSEVfQ0hFQ0tBVVhfT0JTT0xFVEU7
CmRpZmYgLS1naXQgYS9mcy9jaWZzL2ZzY2FjaGUuYyBiL2ZzL2NpZnMvZnNjYWNoZS5jCmluZGV4
IGVhNmFjZTljMjQxNy4uZGE2ODgxODU0MDNjIDEwMDY0NAotLS0gYS9mcy9jaWZzL2ZzY2FjaGUu
YworKysgYi9mcy9jaWZzL2ZzY2FjaGUuYwpAQCAtOTYsNiArOTYsNyBAQCB2b2lkIGNpZnNfZnNj
YWNoZV9nZXRfc3VwZXJfY29va2llKHN0cnVjdCBjaWZzX3Rjb24gKnRjb24pCiB7CiAJc3RydWN0
IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyID0gdGNvbi0+c2VzLT5zZXJ2ZXI7CiAJY2hhciAqc2hh
cmVuYW1lOworCXN0cnVjdCBjaWZzX2ZzY2FjaGVfc3VwZXJfYXV4ZGF0YSBhdXhkYXRhOwogCiAJ
c2hhcmVuYW1lID0gZXh0cmFjdF9zaGFyZW5hbWUodGNvbi0+dHJlZU5hbWUpOwogCWlmIChJU19F
UlIoc2hhcmVuYW1lKSkgewpAQCAtMTA0LDExICsxMDUsMTYgQEAgdm9pZCBjaWZzX2ZzY2FjaGVf
Z2V0X3N1cGVyX2Nvb2tpZShzdHJ1Y3QgY2lmc190Y29uICp0Y29uKQogCQlyZXR1cm47CiAJfQog
CisJbWVtc2V0KCZhdXhkYXRhLCAwLCBzaXplb2YoYXV4ZGF0YSkpOworCWF1eGRhdGEucmVzb3Vy
Y2VfaWQgPSB0Y29uLT5yZXNvdXJjZV9pZDsKKwlhdXhkYXRhLnZvbF9jcmVhdGVfdGltZSA9IHRj
b24tPnZvbF9jcmVhdGVfdGltZTsKKwlhdXhkYXRhLnZvbF9zZXJpYWxfbnVtYmVyID0gdGNvbi0+
dm9sX3NlcmlhbF9udW1iZXI7CisKIAl0Y29uLT5mc2NhY2hlID0KIAkJZnNjYWNoZV9hY3F1aXJl
X2Nvb2tpZShzZXJ2ZXItPmZzY2FjaGUsCiAJCQkJICAgICAgICZjaWZzX2ZzY2FjaGVfc3VwZXJf
aW5kZXhfZGVmLAogCQkJCSAgICAgICBzaGFyZW5hbWUsIHN0cmxlbihzaGFyZW5hbWUpLAotCQkJ
CSAgICAgICAmdGNvbi0+cmVzb3VyY2VfaWQsIHNpemVvZih0Y29uLT5yZXNvdXJjZV9pZCksCisJ
CQkJICAgICAgICZhdXhkYXRhLCBzaXplb2YoYXV4ZGF0YSksCiAJCQkJICAgICAgIHRjb24sIDAs
IHRydWUpOwogCWtmcmVlKHNoYXJlbmFtZSk7CiAJY2lmc19kYmcoRllJLCAiJXM6ICgweCVwLzB4
JXApXG4iLApAQCAtMTE3LDggKzEyMywxNSBAQCB2b2lkIGNpZnNfZnNjYWNoZV9nZXRfc3VwZXJf
Y29va2llKHN0cnVjdCBjaWZzX3Rjb24gKnRjb24pCiAKIHZvaWQgY2lmc19mc2NhY2hlX3JlbGVh
c2Vfc3VwZXJfY29va2llKHN0cnVjdCBjaWZzX3Rjb24gKnRjb24pCiB7CisJc3RydWN0IGNpZnNf
ZnNjYWNoZV9zdXBlcl9hdXhkYXRhIGF1eGRhdGE7CisKKwltZW1zZXQoJmF1eGRhdGEsIDAsIHNp
emVvZihhdXhkYXRhKSk7CisJYXV4ZGF0YS5yZXNvdXJjZV9pZCA9IHRjb24tPnJlc291cmNlX2lk
OworCWF1eGRhdGEudm9sX2NyZWF0ZV90aW1lID0gdGNvbi0+dm9sX2NyZWF0ZV90aW1lOworCWF1
eGRhdGEudm9sX3NlcmlhbF9udW1iZXIgPSB0Y29uLT52b2xfc2VyaWFsX251bWJlcjsKKwogCWNp
ZnNfZGJnKEZZSSwgIiVzOiAoMHglcClcbiIsIF9fZnVuY19fLCB0Y29uLT5mc2NhY2hlKTsKLQlm
c2NhY2hlX3JlbGlucXVpc2hfY29va2llKHRjb24tPmZzY2FjaGUsICZ0Y29uLT5yZXNvdXJjZV9p
ZCwgZmFsc2UpOworCWZzY2FjaGVfcmVsaW5xdWlzaF9jb29raWUodGNvbi0+ZnNjYWNoZSwgJmF1
eGRhdGEsIGZhbHNlKTsKIAl0Y29uLT5mc2NhY2hlID0gTlVMTDsKIH0KIApkaWZmIC0tZ2l0IGEv
ZnMvY2lmcy9mc2NhY2hlLmggYi9mcy9jaWZzL2ZzY2FjaGUuaAppbmRleCA4YzA4NjJlNDEzMDYu
LjEwOTE2MzNkMmFkYiAxMDA2NDQKLS0tIGEvZnMvY2lmcy9mc2NhY2hlLmgKKysrIGIvZnMvY2lm
cy9mc2NhY2hlLmgKQEAgLTI3LDYgKzI3LDE1IEBACiAKICNpZmRlZiBDT05GSUdfQ0lGU19GU0NB
Q0hFCiAKKy8qCisgKiBBdXhpbGlhcnkgZGF0YSBhdHRhY2hlZCB0byBDSUZTIHN1cGVyYmxvY2sg
d2l0aGluIHRoZSBjYWNoZQorICovCitzdHJ1Y3QgY2lmc19mc2NhY2hlX3N1cGVyX2F1eGRhdGEg
eworCXU2NAlyZXNvdXJjZV9pZDsJCS8qIHVuaXF1ZSBzZXJ2ZXIgcmVzb3VyY2UgaWQgKi8KKwlf
X2xlNjQJdm9sX2NyZWF0ZV90aW1lOworCXUzMgl2b2xfc2VyaWFsX251bWJlcjsKK30gX19wYWNr
ZWQ7CisKIC8qCiAgKiBBdXhpbGlhcnkgZGF0YSBhdHRhY2hlZCB0byBDSUZTIGlub2RlIHdpdGhp
biB0aGUgY2FjaGUKICAqLwotLSAKMi4yNS4xCgo=
--000000000000b953f905a76cc53e--
