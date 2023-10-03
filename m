Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AE07B7217
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 21:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbjJCTxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 15:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjJCTxX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:53:23 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AA193
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 12:53:19 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d8673a90f56so1431414276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 12:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696362799; x=1696967599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obo4De/sb/6Zy5gCkdvqVVEu8bO8itwyRVmAwvT9wCU=;
        b=TSvtyr84qG2UWU/dLgktGyntsNsjamLM8XfbEKKi0xaViyXNKNjmtcMQrnzWLhLL4Q
         P8KAsR487RJnjRFH422aqXXMMjGglwHN+ha1fIc3qZFh+InvO/N/z9RMDblEP31qEcpc
         5bxRwz7/pDU6KQMJfHLQVf10FHeiS9eEJk7VzE+jjzIL/a1vzdYPDX4LU+P9C4ZPZe0Q
         85HY8YbzQSmmspRlplY/GDFZABNSfsh9h96cJzhRXdeiMh1Wkb53A+gPWcxbBDjru8B9
         eFYLMuGaUGw3ABVW2U3cuycvmIfDlMLX+9nKSk2KHeWFCs5OixjyfEghAfPtJbbOj0D6
         RZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362799; x=1696967599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obo4De/sb/6Zy5gCkdvqVVEu8bO8itwyRVmAwvT9wCU=;
        b=J3CGyjvkU5J0t78ytnShAWsO0Zs7yd4IBHPXkUD6CJseQ6sH3FILA/aUhTmPhGfGEq
         vvT4UBmhfyespBMkYSV7ViVvLrJsnIuuES3Il8S4wNG2nnnLpP3/UrlV9/sFCVw5NZRP
         /dWk0OwvfGYuQsacrO5XUYUAOEVLvNCTY42xhrWcL648/MKewT94YdFXnIzsFA+YgCTE
         Pvn0vlrsVVfPUwGUXQ2rFdkahz85iw8Yt8zTV4JuLuj9wpvku4FRt0kRPtQpBza41sq4
         OcnKuzqzYR91sXHsiCWTzToiY+aHTnw6xGwEIlyVQz59HdXXpwEdJswuDKI6vb7Pd6Uf
         O+Aw==
X-Gm-Message-State: AOJu0Yz3/m2Qqj2VYj3T5kcrlOx8TYWtEqhCjtV4nAYysQ0uhi2B/Q2M
        vyII5XGGCKcouGWs5ybApzyzlnwWRcV8SfuDZRGF
X-Google-Smtp-Source: AGHT+IGRWbBVpwyn2Gy/b1A1hMErs5fxoRn8w73xjBh7Wo/Ch2afVLnnkAKf9fTwTwkxjia0xxUsD5psv8fz2pWG8cM=
X-Received: by 2002:a25:2e4a:0:b0:d90:b45d:6e6a with SMTP id
 b10-20020a252e4a000000b00d90b45d6e6amr226292ybn.2.1696362799131; Tue, 03 Oct
 2023 12:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230928110300.32891-1-jlayton@kernel.org> <20230928110413.33032-1-jlayton@kernel.org>
 <20230928110413.33032-82-jlayton@kernel.org>
In-Reply-To: <20230928110413.33032-82-jlayton@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 Oct 2023 15:53:08 -0400
Message-ID: <CAHC9VhTphmv=s2QFwdnwFKd77UKhHNf5oEaLPJJU0Z0EO9HoUA@mail.gmail.com>
Subject: Re: [PATCH 83/87] security/selinux: convert to new inode {a,m}time accessors
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 7:23=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 6fa640263216..6c596ae7fef9 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1198,7 +1198,7 @@ static struct inode *sel_make_inode(struct super_bl=
ock *sb, umode_t mode)
>
>         if (ret) {
>                 ret->i_mode =3D mode;
> -               ret->i_atime =3D ret->i_mtime =3D inode_set_ctime_current=
(ret);
> +               simple_inode_init_ts(ret);
>         }
>         return ret;
>  }
> --
> 2.41.0

--=20
paul-moore.com
