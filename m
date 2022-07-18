Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93C4577E6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 11:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiGRJOR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 05:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiGRJOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:14:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFE6F5B9
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 02:14:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ss3so20009269ejc.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 02:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUeHNrPcbgcPWPwewb02SjJEm6kE+JIMReuJUoqG3iw=;
        b=OAFJy8YpvX9OS2BoMivpYxPDEwgfR7xFkOLlZ7QS04TtulbnmOCbl6ehuOOmtKAfGH
         k8j5+jIpmOWVytXhdX/JTpwBaMFKxL7QCJwC0xGFibHt2lH3EwwoWSD5Yw+jG0NvnTTF
         xSX3pUWMWH9T76V9D1sgEVMtZC5oGDwIDcIrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUeHNrPcbgcPWPwewb02SjJEm6kE+JIMReuJUoqG3iw=;
        b=auBMvpm9kWa51Wl0S1onirmqBFnLIAu4CeLs45xO72t7DV08KJ8ZOamKVVnmaMtG27
         7cHQoNg5EagArWLOplYHBM3/+lEfQeDyrY603u7eZPBVBGmFD1ZcdlaFUkZUbbYuLkXL
         2YUM5AyWbNxLOf+nX/ew7PZT0hRjAQczCe1mrnbFW5Y5GRyAmAosHbY8dmcMm+OhFqWI
         kJXuszEuHFU5J0NVXcehlWTLX6QgIEIWKi269NN878qQMzGnM/dH1XJUjHoTvfNYeZij
         O4n6BZ4+QQUccDVDj+FPw96x4GFetxhjt4ucX5/oFk4jVBrnmC0oWe5QhSJ25B7oOzsG
         +j+g==
X-Gm-Message-State: AJIora/Tv8HcupYYCMQ0ycj37eATbytrcGhhMaEEfDZzLwat6sJFy9Vz
        IMx4orLIrxlauC38GkgobEYP7WQcMeTun0yoa55jPQ==
X-Google-Smtp-Source: AGRyM1tei5MOBwBW/httC+ufQ7v+Wagvm+SjEH8CT3A2BsT0RpKzd+k3XZ9vyt0tQIRANwiS9CXfcihWKeACkCBzfiE=
X-Received: by 2002:a17:907:2855:b0:72b:700e:21eb with SMTP id
 el21-20020a170907285500b0072b700e21ebmr24974561ejc.270.1658135653827; Mon, 18
 Jul 2022 02:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
In-Reply-To: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jul 2022 11:14:02 +0200
Message-ID: <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
Subject: Re: [PATCH] ovl: Handle ENOSYS when fileattr support is missing in
 lower/upper fs
To:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a2f11305e410ca32"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000a2f11305e410ca32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Jul 2022 at 20:36, Christian Kohlsch=C3=BCtter
<christian@kohlschutter.com> wrote:
>
> overlayfs may fail to complete updates when a filesystem lacks
> fileattr/xattr syscall support and responds with an ENOSYS error code,
> resulting in an unexpected "Function not implemented" error.

Issue seems to be with fuse: nothing should be returning ENOSYS to
userspace except the syscall lookup code itself.  ENOSYS means that
the syscall does not exist.

Fuse uses ENOSYS in the protocol to indicate that the filesystem does
not support that operation, but that's not the value that the
filesystem should be returning to userspace.

The getxattr/setxattr implementations already translate ENOSYS to
EOPNOTSUPP, but ioctl doesn't.

The attached patch (untested) should do this.   Can you please give it a tr=
y?

Thanks,
Miklos

--000000000000a2f11305e410ca32
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-ioctl-translate-enosys.patch"
Content-Disposition: attachment; 
	filename="fuse-ioctl-translate-enosys.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l5qj3i030>
X-Attachment-Id: f_l5qj3i030

LS0tCiBmcy9mdXNlL2lvY3RsLmMgfCAgIDE1ICsrKysrKysrKysrKystLQogMSBmaWxlIGNoYW5n
ZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgotLS0gYS9mcy9mdXNlL2lvY3Rs
LmMKKysrIGIvZnMvZnVzZS9pb2N0bC5jCkBAIC05LDYgKzksMTcgQEAKICNpbmNsdWRlIDxsaW51
eC9jb21wYXQuaD4KICNpbmNsdWRlIDxsaW51eC9maWxlYXR0ci5oPgogCitzdGF0aWMgc3NpemVf
dCBmdXNlX3NlbmRfaW9jdGwoc3RydWN0IGZ1c2VfbW91bnQgKmZtLCBzdHJ1Y3QgZnVzZV9hcmdz
ICphcmdzKQoreworCXNzaXplX3QgcmV0ID0gZnVzZV9zaW1wbGVfcmVxdWVzdChmbSwgYXJncyk7
CisKKwkvKiBUcmFuc2xhdGUgRU5PU1lTLCB3aGljaCBzaG91bGRuJ3QgYmUgcmV0dXJuZWQgZnJv
bSBmcyAqLworCWlmIChyZXQgPT0gLUVOT1NZUykKKwkJcmV0ID0gLUVOT1RUWTsKKworCXJldHVy
biByZXQ7Cit9CisKIC8qCiAgKiBDVVNFIHNlcnZlcnMgY29tcGlsZWQgb24gMzJiaXQgYnJva2Ug
b24gNjRiaXQga2VybmVscyBiZWNhdXNlIHRoZQogICogQUJJIHdhcyBkZWZpbmVkIHRvIGJlICdz
dHJ1Y3QgaW92ZWMnIHdoaWNoIGlzIGRpZmZlcmVudCBvbiAzMmJpdApAQCAtMjU5LDcgKzI3MCw3
IEBAIGxvbmcgZnVzZV9kb19pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW4KIAlhcC5hcmdzLm91
dF9wYWdlcyA9IHRydWU7CiAJYXAuYXJncy5vdXRfYXJndmFyID0gdHJ1ZTsKIAotCXRyYW5zZmVy
cmVkID0gZnVzZV9zaW1wbGVfcmVxdWVzdChmbSwgJmFwLmFyZ3MpOworCXRyYW5zZmVycmVkID0g
ZnVzZV9zZW5kX2lvY3RsKGZtLCAmYXAuYXJncyk7CiAJZXJyID0gdHJhbnNmZXJyZWQ7CiAJaWYg
KHRyYW5zZmVycmVkIDwgMCkKIAkJZ290byBvdXQ7CkBAIC0zOTMsNyArNDA0LDcgQEAgc3RhdGlj
IGludCBmdXNlX3ByaXZfaW9jdGwoc3RydWN0IGlub2RlCiAJYXJncy5vdXRfYXJnc1sxXS5zaXpl
ID0gaW5hcmcub3V0X3NpemU7CiAJYXJncy5vdXRfYXJnc1sxXS52YWx1ZSA9IHB0cjsKIAotCWVy
ciA9IGZ1c2Vfc2ltcGxlX3JlcXVlc3QoZm0sICZhcmdzKTsKKwllcnIgPSBmdXNlX3NlbmRfaW9j
dGwoZm0sICZhcmdzKTsKIAlpZiAoIWVycikgewogCQlpZiAob3V0YXJnLnJlc3VsdCA8IDApCiAJ
CQllcnIgPSBvdXRhcmcucmVzdWx0Owo=
--000000000000a2f11305e410ca32--
