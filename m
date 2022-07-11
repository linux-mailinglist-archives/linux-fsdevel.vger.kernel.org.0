Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37445704D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 15:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiGKN7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 09:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiGKN7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:59:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF34255BB
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 06:59:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w12so5622061edd.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWiFVldYFpc43AAKGHak4SIYlIz8MXzcKwTkW7YdQfA=;
        b=AP9KrQr3hrMTHU6BqHP+ayGIjC/0dB3htDH8429174+d/0ySgzU87bdU/3eQWWq1gi
         CcAPj8o7Xa7nPpeAx0ThLXyahv+DBWMparJjcj5+DDA1XkQpBeq74rziOO/uFdgJbcjA
         45zm6fR8ENYetI/dvZYzgoKlwtf+BVvi+oPoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWiFVldYFpc43AAKGHak4SIYlIz8MXzcKwTkW7YdQfA=;
        b=a61DKzLWRJbMHUR9EuKyxJ5yLSXBqwowWbLdl6txuuQklMWcXjVpOvnj48mrERarpS
         NU9uQlgejatNipacVAMPq8fGJoawbciZDTO+A1Kq20ZjuzBTVNdx9G4e4tyrrGnCgEtI
         ac7mt0NDY8xG1juB4aisdKhlwRTy1AX9N655cb6e3QSAqnEJ3p+Kx3xLmL5xhkD0oTMx
         1QtDr6dqwNiwHW9Ck8LI/SZW1LIJkjloGbRk+6TB/lpPfWZXVF/R05OmEXFKpZP+th1A
         Y4UcWQsA6h8g7tVFKY/F9tOTLKX4jq0nKSWo9CSyxZt4haCuChrDRXygmKXDyud6g0Ed
         4x0g==
X-Gm-Message-State: AJIora/+/UvADeQKooiBl/nPgZEh5iZRTk530ZI+nxLvHmcUkFKfVX5L
        t3iWAHsw1zbQnweBlEmZ5t07cUtuzKI88oFyhe5q4w==
X-Google-Smtp-Source: AGRyM1sId/5c6MRVW8i7r4v1jnvt85NJTrNopRdfjCQHsNpRA+adWQMm3wdkGkx9WJLaVti3ehCYq9YmSlCtR13hAnw=
X-Received: by 2002:a05:6402:5205:b0:43a:b520:c7de with SMTP id
 s5-20020a056402520500b0043ab520c7demr20935862edd.22.1657547966498; Mon, 11
 Jul 2022 06:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <YrShFXRLtRt6T/j+@risky> <CAJfpegvH1EMS_469yOyUP9f=eCAEqzhyngm7h=YLRExeRdPEaw@mail.gmail.com>
In-Reply-To: <CAJfpegvH1EMS_469yOyUP9f=eCAEqzhyngm7h=YLRExeRdPEaw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 11 Jul 2022 15:59:15 +0200
Message-ID: <CAJfpegurW7==LEp2yXWMYdBYXTZN4HCMMVJPu-f8yvHVbu79xQ@mail.gmail.com>
Subject: Re: strange interaction between fuse + pidns
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000be1cf105e387f5bd"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000be1cf105e387f5bd
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Jul 2022 at 12:35, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Can you try the attached untested patch?

Updated patch to avoid use after free on req->args.

Still mostly untested.

Thanks,
Miklos

--000000000000be1cf105e387f5bd
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-allow-flush-to-be-killed-v2.patch"
Content-Disposition: attachment; 
	filename="fuse-allow-flush-to-be-killed-v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l5gt93xl0>
X-Attachment-Id: f_l5gt93xl0

LS0tCiBmcy9mdXNlL2Rldi5jICAgIHwgICAyMyArKysrKysrKysrKysrKysrKy0tLS0tLQogZnMv
ZnVzZS9maWxlLmMgICB8ICAgIDEgKwogZnMvZnVzZS9mdXNlX2kuaCB8ICAgIDMgKysrCiAzIGZp
bGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgotLS0gYS9mcy9m
dXNlL2Rldi5jCisrKyBiL2ZzL2Z1c2UvZGV2LmMKQEAgLTM5Nyw2ICszOTcsMTIgQEAgc3RhdGlj
IHZvaWQgcmVxdWVzdF93YWl0X2Fuc3dlcihzdHJ1Y3QgZgogCQkJcmVxLT5vdXQuaC5lcnJvciA9
IC1FSU5UUjsKIAkJCXJldHVybjsKIAkJfQorCQlpZiAocmVxLT5hcmdzLT5raWxsYWJsZSkgewor
CQkJcmVxLT5vdXQuaC5lcnJvciA9IC1FSU5UUjsKKwkJCS8qIGZ1c2VfcmVxdWVzdF9lbmQoKSB3
aWxsIGRyb3AgZmluYWwgcmVmICovCisJCQlzcGluX3VubG9jaygmZmlxLT5sb2NrKTsKKwkJCXJl
dHVybjsKKwkJfQogCQlzcGluX3VubG9jaygmZmlxLT5sb2NrKTsKIAl9CiAKQEAgLTQ3OCw2ICs0
ODQsOCBAQCBzdGF0aWMgdm9pZCBmdXNlX2FyZ3NfdG9fcmVxKHN0cnVjdCBmdXNlCiAJcmVxLT5h
cmdzID0gYXJnczsKIAlpZiAoYXJncy0+ZW5kKQogCQlfX3NldF9iaXQoRlJfQVNZTkMsICZyZXEt
PmZsYWdzKTsKKwlpZiAoIWFyZ3MtPm91dF9udW1hcmdzKQorCQlfX3NldF9iaXQoRlJfTk9PVVRB
UkcsICZyZXEtPmZsYWdzKTsKIH0KIAogc3NpemVfdCBmdXNlX3NpbXBsZV9yZXF1ZXN0KHN0cnVj
dCBmdXNlX21vdW50ICpmbSwgc3RydWN0IGZ1c2VfYXJncyAqYXJncykKQEAgLTQ4Niw2ICs0OTQs
OCBAQCBzc2l6ZV90IGZ1c2Vfc2ltcGxlX3JlcXVlc3Qoc3RydWN0IGZ1c2VfCiAJc3RydWN0IGZ1
c2VfcmVxICpyZXE7CiAJc3NpemVfdCByZXQ7CiAKKwlXQVJOX09OKGFyZ3MtPmtpbGxhYmxlICYm
IGFyZ3MtPm91dF9udW1hcmdzKTsKKwogCWlmIChhcmdzLT5mb3JjZSkgewogCQlhdG9taWNfaW5j
KCZmYy0+bnVtX3dhaXRpbmcpOwogCQlyZXEgPSBmdXNlX3JlcXVlc3RfYWxsb2MoZm0sIEdGUF9L
RVJORUwgfCBfX0dGUF9OT0ZBSUwpOwpAQCAtNDk0LDcgKzUwNCw4IEBAIHNzaXplX3QgZnVzZV9z
aW1wbGVfcmVxdWVzdChzdHJ1Y3QgZnVzZV8KIAkJCWZ1c2VfZm9yY2VfY3JlZHMocmVxKTsKIAog
CQlfX3NldF9iaXQoRlJfV0FJVElORywgJnJlcS0+ZmxhZ3MpOwotCQlfX3NldF9iaXQoRlJfRk9S
Q0UsICZyZXEtPmZsYWdzKTsKKwkJaWYgKCFhcmdzLT5raWxsYWJsZSkKKwkJCV9fc2V0X2JpdChG
Ul9GT1JDRSwgJnJlcS0+ZmxhZ3MpOwogCX0gZWxzZSB7CiAJCVdBUk5fT04oYXJncy0+bm9jcmVk
cyk7CiAJCXJlcSA9IGZ1c2VfZ2V0X3JlcShmbSwgZmFsc2UpOwpAQCAtMTkxMywxMyArMTkyNCwx
MyBAQCBzdGF0aWMgc3NpemVfdCBmdXNlX2Rldl9kb193cml0ZShzdHJ1Y3QKIAlzZXRfYml0KEZS
X0xPQ0tFRCwgJnJlcS0+ZmxhZ3MpOwogCXNwaW5fdW5sb2NrKCZmcHEtPmxvY2spOwogCWNzLT5y
ZXEgPSByZXE7Ci0JaWYgKCFyZXEtPmFyZ3MtPnBhZ2VfcmVwbGFjZSkKLQkJY3MtPm1vdmVfcGFn
ZXMgPSAwOwotCi0JaWYgKG9oLmVycm9yKQorCWlmIChvaC5lcnJvciB8fCB0ZXN0X2JpdChGUl9O
T09VVEFSRywgJnJlcS0+ZmxhZ3MpKSB7CiAJCWVyciA9IG5ieXRlcyAhPSBzaXplb2Yob2gpID8g
LUVJTlZBTCA6IDA7Ci0JZWxzZQorCX0gZWxzZSB7CisJCWlmICghcmVxLT5hcmdzLT5wYWdlX3Jl
cGxhY2UpCisJCQljcy0+bW92ZV9wYWdlcyA9IDA7CiAJCWVyciA9IGNvcHlfb3V0X2FyZ3MoY3Ms
IHJlcS0+YXJncywgbmJ5dGVzKTsKKwl9CiAJZnVzZV9jb3B5X2ZpbmlzaChjcyk7CiAKIAlzcGlu
X2xvY2soJmZwcS0+bG9jayk7Ci0tLSBhL2ZzL2Z1c2UvZmlsZS5jCisrKyBiL2ZzL2Z1c2UvZmls
ZS5jCkBAIC01MDQsNiArNTA0LDcgQEAgc3RhdGljIGludCBmdXNlX2ZsdXNoKHN0cnVjdCBmaWxl
ICpmaWxlLAogCWFyZ3MuaW5fYXJnc1swXS5zaXplID0gc2l6ZW9mKGluYXJnKTsKIAlhcmdzLmlu
X2FyZ3NbMF0udmFsdWUgPSAmaW5hcmc7CiAJYXJncy5mb3JjZSA9IHRydWU7CisJYXJncy5raWxs
YWJsZSA9IHRydWU7CiAKIAllcnIgPSBmdXNlX3NpbXBsZV9yZXF1ZXN0KGZtLCAmYXJncyk7CiAJ
aWYgKGVyciA9PSAtRU5PU1lTKSB7Ci0tLSBhL2ZzL2Z1c2UvZnVzZV9pLmgKKysrIGIvZnMvZnVz
ZS9mdXNlX2kuaApAQCAtMjYxLDYgKzI2MSw3IEBAIHN0cnVjdCBmdXNlX2FyZ3MgewogCWJvb2wg
cGFnZV96ZXJvaW5nOjE7CiAJYm9vbCBwYWdlX3JlcGxhY2U6MTsKIAlib29sIG1heV9ibG9jazox
OworCWJvb2wga2lsbGFibGU6MTsKIAlzdHJ1Y3QgZnVzZV9pbl9hcmcgaW5fYXJnc1szXTsKIAlz
dHJ1Y3QgZnVzZV9hcmcgb3V0X2FyZ3NbMl07CiAJdm9pZCAoKmVuZCkoc3RydWN0IGZ1c2VfbW91
bnQgKmZtLCBzdHJ1Y3QgZnVzZV9hcmdzICphcmdzLCBpbnQgZXJyb3IpOwpAQCAtMzE0LDYgKzMx
NSw3IEBAIHN0cnVjdCBmdXNlX2lvX3ByaXYgewogICogRlJfRklOSVNIRUQ6CQlyZXF1ZXN0IGlz
IGZpbmlzaGVkCiAgKiBGUl9QUklWQVRFOgkJcmVxdWVzdCBpcyBvbiBwcml2YXRlIGxpc3QKICAq
IEZSX0FTWU5DOgkJcmVxdWVzdCBpcyBhc3luY2hyb25vdXMKKyAqIEZSX05PT1VUQVJHOgkJcmVw
bHkgaXMgb25seSBoZWFkZXIKICAqLwogZW51bSBmdXNlX3JlcV9mbGFnIHsKIAlGUl9JU1JFUExZ
LApAQCAtMzI4LDYgKzMzMCw3IEBAIGVudW0gZnVzZV9yZXFfZmxhZyB7CiAJRlJfRklOSVNIRUQs
CiAJRlJfUFJJVkFURSwKIAlGUl9BU1lOQywKKwlGUl9OT09VVEFSRywKIH07CiAKIC8qKgo=
--000000000000be1cf105e387f5bd--
