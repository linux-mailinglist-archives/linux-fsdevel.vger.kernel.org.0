Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677B6462D25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 07:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhK3G50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 01:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhK3G50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:57:26 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B240C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 22:54:06 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i6so20186822ila.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 22:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlbnCpLDPpR3jmnVL3xuLsL27+TP3NBtwhAiCm3SnnQ=;
        b=S+UUyl50Fhj/dKoCyVE3Yz5y521y9419ezj7VMHuZpXQQiEDn5eqcNYMD+z7Tln63Q
         cjzzBzoX0WIIkXlm24EE0rYlQ5Z9R89QFuqaBRJ/5WZQdda84YQUqLUy9oh3iahbHx2l
         M3Jhf81SkVfmpZxBkGwuaQo9gjHT86PSThQlXEx/L7PU7BK6X1bk6YO5wUs0LQgVpBzp
         Edu7b6xuRN6kpLYrKT725x4I00SLtSKd5NYH5c6qqpm4XVn1Jx9gZbUCHr6PKAiWQvB8
         6LGHFOn16LvozkC+DoMR0P6pjTToPeczbqulEituOozvbEDZ8ILfYw8nyQ1jb/474cV2
         s9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wlbnCpLDPpR3jmnVL3xuLsL27+TP3NBtwhAiCm3SnnQ=;
        b=YwLw4fUISBPxD/JluXFrDdNyUtfCiSK/dgRN7hDd2jNDz4/jrgfBjLHAZerQe0UCwC
         i3EFHVzBhiCMx2pBgOMTMIzHj7ileigUO/3yF+tj4johe0xfQxoVaQj60SmUOBpTRFye
         qn4okdOsr2cTI6YuMC7ZOY6GKniT73XCSsyJ/RQgfJqCt43GkxmYAE6xbP94VfH+n0Pk
         TsyhUuOC5gt+TWJ0wZwkkt6GoB+H/bUphBhYbTwZJPnzbzVNFXna6KYNZ71aHIScQevG
         m/NoKRDHqbQNqTOTCWW/kFhOgDbByXawoIeadsjSKzg2mkluuqW95JXPbanL5XgBM4P/
         yD6w==
X-Gm-Message-State: AOAM530TuZ8/A1dZ03y+kMjTvvy/Ow4f3dhEmSQCj2zhsxHiYCRIxf2M
        yQrfnXZXV7fUTPy9D6NBCt52oUm/6YbL0Cz0cRA=
X-Google-Smtp-Source: ABdhPJwNZBxBTs/zMzcLWD4G6LL9Ugcf11W2p+IVUSUGrypFPNZTenyN+/cnygYYRSz1pVBih0y4SWr+4fwL2a1vueU=
X-Received: by 2002:a05:6e02:c87:: with SMTP id b7mr58787200ile.198.1638255245605;
 Mon, 29 Nov 2021 22:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20211123114227.3124056-1-brauner@kernel.org> <20211123114227.3124056-8-brauner@kernel.org>
In-Reply-To: <20211123114227.3124056-8-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Nov 2021 08:53:53 +0200
Message-ID: <CAOQ4uxjgdh=D4_vPRBoVXs1wkJC8zyyf+T3DdmxwxcqjfF43Xg@mail.gmail.com>
Subject: Re: [PATCH 07/10] fs: remove unused low-level mapping helpers
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 2:19 PM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Now that we ported all places to use the new low-level mapping helpers
> that are able to support filesystems mounted with an idmapping we can
> remove the old low-level mapping helpers. With the removal of these old
> helpers we also conclude the renaming of the mapping helpers we started
> in [1].
>
> [1]: commit a65e58e791a1 ("fs: document and rename fsid helpers")
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>  include/linux/mnt_mapping.h | 56 -------------------------------------
>  1 file changed, 56 deletions(-)
>
> diff --git a/include/linux/mnt_mapping.h b/include/linux/mnt_mapping.h
> index c555b9836d35..f55b62fd27ae 100644
> --- a/include/linux/mnt_mapping.h
> +++ b/include/linux/mnt_mapping.h
> @@ -13,62 +13,6 @@ struct user_namespace;
>   */
>  extern struct user_namespace init_user_ns;
>
> -/**
> - * kuid_into_mnt - map a kuid down into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - * @kuid: kuid to be mapped
> - *
> - * Return: @kuid mapped according to @mnt_userns.
> - * If @kuid has no mapping INVALID_UID is returned.
> - */
> -static inline kuid_t kuid_into_mnt(struct user_namespace *mnt_userns,
> -                                  kuid_t kuid)
> -{
> -       return make_kuid(mnt_userns, __kuid_val(kuid));
> -}
> -
> -/**
> - * kgid_into_mnt - map a kgid down into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - * @kgid: kgid to be mapped
> - *
> - * Return: @kgid mapped according to @mnt_userns.
> - * If @kgid has no mapping INVALID_GID is returned.
> - */
> -static inline kgid_t kgid_into_mnt(struct user_namespace *mnt_userns,
> -                                  kgid_t kgid)
> -{
> -       return make_kgid(mnt_userns, __kgid_val(kgid));
> -}
> -
> -/**
> - * kuid_from_mnt - map a kuid up into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - * @kuid: kuid to be mapped
> - *
> - * Return: @kuid mapped up according to @mnt_userns.
> - * If @kuid has no mapping INVALID_UID is returned.
> - */
> -static inline kuid_t kuid_from_mnt(struct user_namespace *mnt_userns,
> -                                  kuid_t kuid)
> -{
> -       return KUIDT_INIT(from_kuid(mnt_userns, kuid));
> -}
> -
> -/**
> - * kgid_from_mnt - map a kgid up into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - * @kgid: kgid to be mapped
> - *
> - * Return: @kgid mapped up according to @mnt_userns.
> - * If @kgid has no mapping INVALID_GID is returned.
> - */
> -static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
> -                                  kgid_t kgid)
> -{
> -       return KGIDT_INIT(from_kgid(mnt_userns, kgid));
> -}
> -
>  /**
>   * initial_idmapping - check whether this is the initial mapping
>   * @ns: idmapping to check
> --
> 2.30.2
>
