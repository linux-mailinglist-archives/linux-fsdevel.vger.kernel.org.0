Return-Path: <linux-fsdevel+bounces-4327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9E07FE92E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 07:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC96B1C20BE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546881DFEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwX80EGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56AA1717;
	Wed, 29 Nov 2023 21:32:31 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db510605572so509812276.0;
        Wed, 29 Nov 2023 21:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701322351; x=1701927151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzcdX3G/l13x66KSxdI5x0zUnfQyH8pp0lMS/qUmaXQ=;
        b=SwX80EGM9VR/C+ZWnvk63cKDDCO2oEhhLFv89BFqpLCpMWwVa4PBzL0Khgq45K5sKQ
         jyuhyUpWFJLx8X3PwFG33JsQlVc24aLLViY9L4SRsZnTJ0i10BTj5lLs/k0JTVJlpKB2
         POaZzyKllavchO3mzEEX2UEDsHTFKnsQNyc+Vv0pQsJuoBpAoirwcwUQNm1VTbebKTvX
         Y3mFQhFFj1LupcZxxF+D+sFDhHTzbRV6w/3tQSwXraQBzryt59lhXWZ206Pib/V5ELBC
         Fjo+OkW6qJEqaAUQDtHqaUhNLLZ2IM6wkll493yiIYKgBftH95FcFWeZUtklXCd6ez9p
         HX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701322351; x=1701927151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzcdX3G/l13x66KSxdI5x0zUnfQyH8pp0lMS/qUmaXQ=;
        b=JG0FrqQytwJ/b1OvwBcDtN+L6yuDp+nj3W/mdATgg830wx4xEdRAFck5h12MDPB0mB
         LUZ2y6d2US/ogj9YoB8IDepKIdmVD82AtGHl+MxEgHEcgYjvyH/Jtlu5eA/WfMyGpmlq
         Jpt978hgQqjlCKitAZGE62HX5wYW4yX4koVZSRFc5OnE7gJ6CRAmd4hqTszAnmc4e9sM
         R00HpqbkYSdnSGotbCgsV0MjKbXM4jKEpD5kflJG5FpZOxZZtZDlmaCypBzgd+Qitdt4
         xoE04Nk+aq0zb1fTob8olEWFmoPPYTlLm3xLYBh0ZTxCjSlLD5VfE9ZCFJcbOvf/4wG4
         Te3A==
X-Gm-Message-State: AOJu0YzJfC60q6xeONg7ChPz3yk6Z5xQmDXA+JUZhua2Hcii/tub12n+
	RIwLVET6lB5p2soHWFreHGRm4yvHhZxbGsAXWFY=
X-Google-Smtp-Source: AGHT+IFhpfUEWzyOk2tHJj3SJo7J92Bms3ThL3HO7eHzD0VJ4uYO4OZtZXkKFhIM0XiJOdYC4nQOD8G+OZ+NRh38lOo=
X-Received: by 2002:a25:fb10:0:b0:da1:b041:70ac with SMTP id
 j16-20020a25fb10000000b00da1b04170acmr19113357ybe.10.1701322350801; Wed, 29
 Nov 2023 21:32:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org> <20231129-idmap-fscap-refactor-v1-7-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-7-da5a26058a5b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 07:32:19 +0200
Message-ID: <CAOQ4uxiz+ng5qEY4qkE_q8Gv3jrd6b7mZnppkDoJthhD+Ud4Ow@mail.gmail.com>
Subject: Re: [PATCH 07/16] fs: add inode operations to get/set/remove fscaps
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 11:51=E2=80=AFPM Seth Forshee (DigitalOcean)
<sforshee@kernel.org> wrote:
>
> Add inode operations for getting, setting and removing filesystem
> capabilities rather than passing around raw xattr data. This provides
> better type safety for ids contained within xattrs.
>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  include/linux/fs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 98b7a7a8c42e..a0a77f67b999 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2002,6 +2002,11 @@ struct inode_operations {
>                                      int);
>         int (*set_acl)(struct mnt_idmap *, struct dentry *,
>                        struct posix_acl *, int);
> +       int (*get_fscaps)(struct mnt_idmap *, struct dentry *,
> +                         struct vfs_caps *);
> +       int (*set_fscaps)(struct mnt_idmap *, struct dentry *,
> +                         const struct vfs_caps *, int flags);
> +       int (*remove_fscaps)(struct mnt_idmap *, struct dentry *);
>         int (*fileattr_set)(struct mnt_idmap *idmap,
>                             struct dentry *dentry, struct fileattr *fa);
>         int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
>

Please document in Documentation/filesystems/{vfs,locking}.rst

Thanks,
Amir.

