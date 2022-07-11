Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FBC56FFF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 13:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiGKLQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 07:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiGKLPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:15:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B4275E4
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 03:35:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t3so5434407edd.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17Ntu7u7zL0owgy2AXHqHsIDETCSIzpTPW2VE5tWiYs=;
        b=QzlsXM01+eHeF1/SAU+u7zrD7f9xTS62efNCWfVZ6g/lSK+bWdoQdkr1DlYUGTNBNY
         LKZlhAvyZfZBOIaXua+9MLaMo06cMSuJwff9w/EbvJbhOb0vfO+ptJOe/zKsjfYXAUt9
         CNmLfpnBiRBl8EOBNSk7/T4Q/0nknjUoA4yAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17Ntu7u7zL0owgy2AXHqHsIDETCSIzpTPW2VE5tWiYs=;
        b=wh+WH1/wtbJ32jrVssE1wEcYSOp2LAQTyPlg/1Ek7m+N9eEMZOhhLSIBcwoOdzzyYp
         JVvoB10YN81iXj8uK5ZfyF+O6bSzSy50IFH9pw578aXgNoTn9oVmoMv8gR7YBnFIBLDz
         oN5RCmEWaCgYFG2tN9H7jzEDXe5L9tF6BRhDH/y55o7PA9nd31yAHnlo9FO4wQWsGizO
         rxVRRrDa2ZChVp62Pk1PIbJb/AWiW1U7z2TEaQbEK1kpZdNgP8f8RDkbf86mBqnVkhzf
         BK6b/v3NyduSoLMGwfhjBpyOs/BE5hxB3ojEllcAjtR6L0cG5Qo9lFdMV3goq97JUrW1
         suMg==
X-Gm-Message-State: AJIora+GMquj+bZqO56JB1mlVtlmGb9RcfoNYmivfcb9z1D/ONsWVu91
        mmZ0cGDrrmtU/HQUwHhqWZPfshnQOBayN+Q7QbKbTw==
X-Google-Smtp-Source: AGRyM1vWJDB6ChHbko8qaqB8zHCS7nZITLWnWRoVQjOYBOB1coargybjk1cKLA0Ef3tXyF2YAmAB0isyete1cUJQKZ0=
X-Received: by 2002:a05:6402:4245:b0:43a:961a:583f with SMTP id
 g5-20020a056402424500b0043a961a583fmr23724564edb.374.1657535743970; Mon, 11
 Jul 2022 03:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <YrShFXRLtRt6T/j+@risky>
In-Reply-To: <YrShFXRLtRt6T/j+@risky>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 11 Jul 2022 12:35:32 +0200
Message-ID: <CAJfpegvH1EMS_469yOyUP9f=eCAEqzhyngm7h=YLRExeRdPEaw@mail.gmail.com>
Subject: Re: strange interaction between fuse + pidns
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000039912305e3851d71"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000039912305e3851d71
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jun 2022 at 19:21, Tycho Andersen <tycho@tycho.pizza> wrote:

>         /*
> -        * Either request is already in userspace, or it was forced.
> -        * Wait it out.
> +        * Womp womp. We sent a request to userspace and now we're getting
> +        * killed.
>          */
> -       wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));

You can't remove this, it's a crucial part of fuse request handling.
Yes, it causes pain, but making *sent* requests killable is a lot more
work.

For one: need to duplicate caller's locking state (i_rwsem, ...) and
move the request into a backround queue instead of just finishing it
off immediately so that the shadow locking can be torn down when the
reply actually arrives.  This affects a lot of requests.

Or we could special case FUSE_FLUSH, which doesn't have any locking.

The reason force=true is needed for FUSE_FLUSH is because it affects
posix lock state.   Not waiting for the reply if the task is killed
could have observable consequences, but my guess is that it's an
uninteresting corner case and would not cause regressions in real
life.

Can you try the attached untested patch?

Thanks,
Miklos

--00000000000039912305e3851d71
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-allow-flush-to-be-killed.patch"
Content-Disposition: attachment; 
	filename="fuse-allow-flush-to-be-killed.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l5gly66p0>
X-Attachment-Id: f_l5gly66p0

LS0tCiBmcy9mdXNlL2Rldi5jICAgIHwgICAgOSArKysrKysrKy0KIGZzL2Z1c2UvZmlsZS5jICAg
fCAgICAxICsKIGZzL2Z1c2UvZnVzZV9pLmggfCAgICAxICsKIDMgZmlsZXMgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKLS0tIGEvZnMvZnVzZS9kZXYuYworKysgYi9m
cy9mdXNlL2Rldi5jCkBAIC0zOTcsNiArMzk3LDEyIEBAIHN0YXRpYyB2b2lkIHJlcXVlc3Rfd2Fp
dF9hbnN3ZXIoc3RydWN0IGYKIAkJCXJlcS0+b3V0LmguZXJyb3IgPSAtRUlOVFI7CiAJCQlyZXR1
cm47CiAJCX0KKwkJaWYgKHJlcS0+YXJncy0+a2lsbGFibGUpIHsKKwkJCXJlcS0+b3V0LmguZXJy
b3IgPSAtRUlOVFI7CisJCQkvKiBmdXNlX3JlcXVlc3RfZW5kKCkgd2lsbCBkcm9wIGZpbmFsIHJl
ZiAqLworCQkJc3Bpbl91bmxvY2soJmZpcS0+bG9jayk7CisJCQlyZXR1cm47CisJCX0KIAkJc3Bp
bl91bmxvY2soJmZpcS0+bG9jayk7CiAJfQogCkBAIC00OTQsNyArNTAwLDggQEAgc3NpemVfdCBm
dXNlX3NpbXBsZV9yZXF1ZXN0KHN0cnVjdCBmdXNlXwogCQkJZnVzZV9mb3JjZV9jcmVkcyhyZXEp
OwogCiAJCV9fc2V0X2JpdChGUl9XQUlUSU5HLCAmcmVxLT5mbGFncyk7Ci0JCV9fc2V0X2JpdChG
Ul9GT1JDRSwgJnJlcS0+ZmxhZ3MpOworCQlpZiAoIWFyZ3MtPmtpbGxhYmxlKQorCQkJX19zZXRf
Yml0KEZSX0ZPUkNFLCAmcmVxLT5mbGFncyk7CiAJfSBlbHNlIHsKIAkJV0FSTl9PTihhcmdzLT5u
b2NyZWRzKTsKIAkJcmVxID0gZnVzZV9nZXRfcmVxKGZtLCBmYWxzZSk7Ci0tLSBhL2ZzL2Z1c2Uv
ZmlsZS5jCisrKyBiL2ZzL2Z1c2UvZmlsZS5jCkBAIC01MDQsNiArNTA0LDcgQEAgc3RhdGljIGlu
dCBmdXNlX2ZsdXNoKHN0cnVjdCBmaWxlICpmaWxlLAogCWFyZ3MuaW5fYXJnc1swXS5zaXplID0g
c2l6ZW9mKGluYXJnKTsKIAlhcmdzLmluX2FyZ3NbMF0udmFsdWUgPSAmaW5hcmc7CiAJYXJncy5m
b3JjZSA9IHRydWU7CisJYXJncy5raWxsYWJsZSA9IHRydWU7CiAKIAllcnIgPSBmdXNlX3NpbXBs
ZV9yZXF1ZXN0KGZtLCAmYXJncyk7CiAJaWYgKGVyciA9PSAtRU5PU1lTKSB7Ci0tLSBhL2ZzL2Z1
c2UvZnVzZV9pLmgKKysrIGIvZnMvZnVzZS9mdXNlX2kuaApAQCAtMjYxLDYgKzI2MSw3IEBAIHN0
cnVjdCBmdXNlX2FyZ3MgewogCWJvb2wgcGFnZV96ZXJvaW5nOjE7CiAJYm9vbCBwYWdlX3JlcGxh
Y2U6MTsKIAlib29sIG1heV9ibG9jazoxOworCWJvb2wga2lsbGFibGU6MTsKIAlzdHJ1Y3QgZnVz
ZV9pbl9hcmcgaW5fYXJnc1szXTsKIAlzdHJ1Y3QgZnVzZV9hcmcgb3V0X2FyZ3NbMl07CiAJdm9p
ZCAoKmVuZCkoc3RydWN0IGZ1c2VfbW91bnQgKmZtLCBzdHJ1Y3QgZnVzZV9hcmdzICphcmdzLCBp
bnQgZXJyb3IpOwo=
--00000000000039912305e3851d71--
