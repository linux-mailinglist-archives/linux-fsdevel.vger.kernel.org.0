Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0745A55CF37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbiF1JNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 05:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343880AbiF1JNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:13:41 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DD01144E;
        Tue, 28 Jun 2022 02:13:40 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id j6so11455375vsi.0;
        Tue, 28 Jun 2022 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wv4IhbUoJIJ6FY8emeu2nW/quqmYxyRnsn5FkPiw4hM=;
        b=EzWMZ77YFY0QGPdpz46oi8T7nOWoLIkf6/KE4+cmbk5ODTDvp8q0QRth+hH0Q1uzom
         0RpTfSdTBPc79umzb36z68zyYmi3jrYVpAN+Xgu+UyIV2pX8pNY4wW7YRzReOXYDp3xC
         oz3mX5+9BdUtWmdjySu6aS60ftRpS8mzCrhATGHXO43o0SNcTNwm5CPAi3ELnSI+S3v1
         XVNPdIN84lTAw/BFO5+6iwG7Nzxo2W7YZ/DJMh/X3O8hr9p4hciktmmr2FMmCnUEXz8o
         vyBul5126M1Tk4ofXcFnTrmgSXrbvBVM/qJczYRYznuBifIVgdgJA0XlUkip/rKQPAbh
         cybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wv4IhbUoJIJ6FY8emeu2nW/quqmYxyRnsn5FkPiw4hM=;
        b=vShH6eimGqD3xUEaWTyvfoTI0TMbPx0wul2Aho8/a6XeSsTJmBvaKaCvI0W+wJ4Ab6
         RXgJDirkuhIrdE8IJ1i9tm/BmUmk4CcnBTmHhFQBPB4yaXkBYDY4cKqcIG/ze7Sqc2yt
         A7xTraOoqJLokd2K/w6NTdq4xnprsjdR2DzyAdZCJ1pomeC5v/Ytab5PVCHKhUD/Jlum
         92toC14v2k5IU2yrHzroKTUagvhePIJ+ns8qSNjcJWjrRZSaag3APJ5aOQSHZtJQwfD6
         OpU6ZC3Ou2iYhFKgtkMeFrk0DB9SDV0WafGaa0jzB/r1F3djhuVSyXGnEoLJsYKfcJ4Z
         oIvQ==
X-Gm-Message-State: AJIora/IupFCPotZbgdArDpEj6y2Z336LPCEaVyT9necv5T756meGXf1
        gV0FEU7JANM7+ok+8TiSKstgeL32bu28IPpQN4A=
X-Google-Smtp-Source: AGRyM1vpIbFyTcoQg+rofP4ZBNZFA6aslHM3rI7Dr+AESiZaQ3H14jdwbjRmBCSGsBBwVIQ6suNq9u3mmZo9cDAN6tE=
X-Received: by 2002:a67:fa01:0:b0:354:3136:c62e with SMTP id
 i1-20020a67fa01000000b003543136c62emr809435vsq.2.1656407619656; Tue, 28 Jun
 2022 02:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220628081731.22411-1-duguoweisz@gmail.com>
In-Reply-To: <20220628081731.22411-1-duguoweisz@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Jun 2022 12:13:28 +0300
Message-ID: <CAOQ4uxjufy39fONi+2div2tF0YBfbexjtT3KzKWT2NrPxVbWag@mail.gmail.com>
Subject: Re: [PATCH 5/5] fanotify: add inline modifier
To:     Guowei Du <duguoweisz@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        duguowei <duguowei@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:17 AM Guowei Du <duguoweisz@gmail.com> wrote:
>
> From: duguowei <duguowei@xiaomi.com>
>
> No functional change.
> This patch only makes a little change for compiling.

There is no reason to do that.
The compiler does that based on the user's optimization preference.

Thanks,
Amir.

>
> Signed-off-by: duguowei <duguowei@xiaomi.com>
> ---
>  fs/notify/fanotify/fanotify.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 4f897e109547..a32752350e0e 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -18,12 +18,12 @@
>
>  #include "fanotify.h"
>
> -static bool fanotify_path_equal(struct path *p1, struct path *p2)
> +static inline bool fanotify_path_equal(struct path *p1, struct path *p2)
>  {
>         return p1->mnt == p2->mnt && p1->dentry == p2->dentry;
>  }
>
> -static unsigned int fanotify_hash_path(const struct path *path)
> +static inline unsigned int fanotify_hash_path(const struct path *path)
>  {
>         return hash_ptr(path->dentry, FANOTIFY_EVENT_HASH_BITS) ^
>                 hash_ptr(path->mnt, FANOTIFY_EVENT_HASH_BITS);
> @@ -35,20 +35,18 @@ static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
>         return fsid1->val[0] == fsid2->val[0] && fsid1->val[1] == fsid2->val[1];
>  }
>
> -static unsigned int fanotify_hash_fsid(__kernel_fsid_t *fsid)
> +static inline unsigned int fanotify_hash_fsid(__kernel_fsid_t *fsid)
>  {
>         return hash_32(fsid->val[0], FANOTIFY_EVENT_HASH_BITS) ^
>                 hash_32(fsid->val[1], FANOTIFY_EVENT_HASH_BITS);
>  }
>
> -static bool fanotify_fh_equal(struct fanotify_fh *fh1,
> +static inline bool fanotify_fh_equal(struct fanotify_fh *fh1,
>                               struct fanotify_fh *fh2)
>  {
> -       if (fh1->type != fh2->type || fh1->len != fh2->len)
> -               return false;
> -
> -       return !fh1->len ||
> -               !memcmp(fanotify_fh_buf(fh1), fanotify_fh_buf(fh2), fh1->len);
> +       return fh1->type == fh2->type && fh1->len == fh2->len &&
> +               (!fh1->len ||
> +                !memcmp(fanotify_fh_buf(fh1), fanotify_fh_buf(fh2), fh1->len));
>  }
>
>  static unsigned int fanotify_hash_fh(struct fanotify_fh *fh)
> --
> 2.36.1
>
