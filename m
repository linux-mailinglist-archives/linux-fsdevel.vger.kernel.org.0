Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9227755E7D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346269AbiF1OLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 10:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345830AbiF1OLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:11:20 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC8C31373;
        Tue, 28 Jun 2022 07:11:19 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-101d96fe0a5so17247572fac.2;
        Tue, 28 Jun 2022 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N/+LcjIcvwP7HKu1jl5kE1kEhRDVcFLmZDHt8jW83BU=;
        b=RjGO2aCwGsiRM1Z/OZYvU17TQRUf5p/28ulWAXuHnqzybluyK9cJQ94E+9plLfxyTj
         BTE4VIuUsb6QTHJyYnbiIVXo14vRF9Xn6EkcmZHI+WN72cBQYyB1XrwPivnEGhPTtT/3
         ms1x2qKgGWKTeA8uBsROiYIAn9jJG1YKcDLnmA1XsablwhyGW8eGIqzcZd6/Vox4/m+L
         bo5tYvf5o0BctitCFJDYVgiBvaFv4ABL2Eid+2a4tJA8uimYv3i2ceyrhbzGGaQBlM5O
         rT2zl4qhLpUbIIdLBsFoheS5YdQTOCqA/n0dlk8jmQQu9bzFm9B31hBug+BgwYSaKCjY
         8VCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N/+LcjIcvwP7HKu1jl5kE1kEhRDVcFLmZDHt8jW83BU=;
        b=5UacVDpHWaLfu0bDLmY7zGSA3IskhBZncIcJdpecfFkmoTfaPQA6PxIgQHTM1wAyBl
         3CwsKeAG9pV0O9M0vPiGskkKSPI21NoURK88YOPqzaEmBJEKCr5uW1rFwhiQuT7SPAaG
         2M5weJKPi6DGo3XDscg3Lwbycry87GLcOrWnPnWgdnYk1BK9aQcMqVF+pjm5g0lQ7OT6
         ZjSsq+zHpPT3TYgxDbuLNyJv4UV2eV0kp/gSYhi4CjdZl5d7fVACPFhKTAiwlBFWFnre
         ljAXsmRbwmiaIweOAwCmG3zWBix+kUrZkVq3/G26y5ca+EzzrQXM2VPEruslKvt0Fgfz
         H0iA==
X-Gm-Message-State: AJIora9/y98FzeY4ITZHTLoRqXcyvCJl4vqGmUfKUKJ2APeYUBprg1D0
        NzeVE7qW2VviEZT0seIcK61gKqFx5viEKmzspN5WWDKoRcvrOw==
X-Google-Smtp-Source: AGRyM1sQ+TQcaVBSd3qgQs4Z10N64qZ957FMRKOFUFLgTx9geUELSLh+ABILqrV0w67JZ0+qaVj85BrtMZMmdQM7VSQ=
X-Received: by 2002:a05:6870:9122:b0:101:baca:30b9 with SMTP id
 o34-20020a056870912200b00101baca30b9mr14143580oae.71.1656425478570; Tue, 28
 Jun 2022 07:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220502160030.131168-8-cgzones@googlemail.com>
 <20220615152623.311223-1-cgzones@googlemail.com> <20220615152623.311223-4-cgzones@googlemail.com>
 <20220628125659.l6irgn6ryoseojv3@wittgenstein>
In-Reply-To: <20220628125659.l6irgn6ryoseojv3@wittgenstein>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 28 Jun 2022 16:11:07 +0200
Message-ID: <CAJ2a_De=_jnYryfQRh08u_qQM=OQW_mnL=iM+C8pUBQ+j4sbLQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] fs: use new capable_any functionality
To:     Christian Brauner <brauner@kernel.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 28 Jun 2022 at 14:57, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Jun 15, 2022 at 05:26:19PM +0200, Christian G=C3=B6ttsche wrote:
> > Use the new added capable_any function in appropriate cases, where a
> > task is required to have any of two capabilities.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
>
> Not seeing the whole patch series so it's a bit difficult to judge but
> in general we've needed something like this for quite some time.

Full patch series:
https://patchwork.kernel.org/project/selinux/list/?series=3D650662
or
https://lore.kernel.org/lkml/20220615152623.311223-8-cgzones@googlemail.com=
/

> > v3:
> >    rename to capable_any()
> > ---
> >  fs/pipe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/pipe.c b/fs/pipe.c
> > index 74ae9fafd25a..18ab3baeec44 100644
> > --- a/fs/pipe.c
> > +++ b/fs/pipe.c
> > @@ -776,7 +776,7 @@ bool too_many_pipe_buffers_hard(unsigned long user_=
bufs)
> >
> >  bool pipe_is_unprivileged_user(void)
> >  {
> > -     return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
> > +     return !capable_any(CAP_SYS_RESOURCE, CAP_SYS_ADMIN);
> >  }
> >
> >  struct pipe_inode_info *alloc_pipe_info(void)
> > --
> > 2.36.1
> >
