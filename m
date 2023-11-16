Return-Path: <linux-fsdevel+bounces-2931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B217EDACD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 05:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F191280F6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 04:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB153A8;
	Thu, 16 Nov 2023 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dv+KWzBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB4197
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 20:33:48 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-da41acaea52so337213276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 20:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109227; x=1700714027; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6JnX6LhDVyRia5AIt4T5fsWFKT3oTlNbS/+dMYZ6fZQ=;
        b=Dv+KWzBQX+5o5++l8yO+HpDSfefpsTNkBvdbl2blus3gc1/iv25pulROvWqYEZsLAS
         mosbscQfoRuSsRGdBdLqwUu/0jxO7bFEHasVVbvlJTPNKM1hWVRE6D+PFzSa7U75WsgZ
         r4iw3Eev5Nii51+0Y8t5QyPJupT0TDMvXN2U6S+0QBVSh6a2pB6EpQUF7bUb3TAkI+nD
         dfK9pFLFwO2glDh+b/NF2VYHmy9IZQ61ZbS4iskaLp31yzpAc0xv3iFyeXtWOzhb701s
         +A8uibPrCCP+sG+Fd7nOorXrU1gtryXvylSrrLsGly3uwlSBiafBYkb+XLlwP5dhr5FM
         xvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109227; x=1700714027;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JnX6LhDVyRia5AIt4T5fsWFKT3oTlNbS/+dMYZ6fZQ=;
        b=iHz1OxNkKQjW9DEZV7VgiKfWx+1uyAuDwKbhV8QKhi7EDb/SdEb1Tw0kiNUrmNhrR2
         pAhCrDQ4qT7T2LRA3KlLYcV/DXTIlUykUE2R2EpajKnDHhQVz+cZA8/9wqLaboupbrBD
         Mp6Z12M3hpi+O+XD1KMY5KTz5W/BZvPnArEVqaPO3pv5nQyHILJi39u1se3poTBnl1zZ
         hhrhumknjKYV4z7f6b4iKjxylz08W+qVAF6bvF7+ALOwQHLiX845g+ZXd0SlSkSgh662
         vIihckmesHU+U6cgTgNqTdXM20EoZYm6p7RDCY0f8Y2YqxpovAE+9bu7cOIMHfzVFGVG
         EPog==
X-Gm-Message-State: AOJu0YwiES56IbQbYxZjbeqcS4As61AtKY2NciXT5OB+8kpk5cs5RLiC
	TKYb1TL+Vh2vlzV8G9qzKuVd
X-Google-Smtp-Source: AGHT+IHfo74mq9awQWwORNNl/SJsz0tMju17DF0SkQPXgHULIEfdwSZtzepXS9fSQ+d8wK7ugySoKw==
X-Received: by 2002:a25:b4b:0:b0:d9a:be79:c902 with SMTP id 72-20020a250b4b000000b00d9abe79c902mr14846966ybl.53.1700109227402;
        Wed, 15 Nov 2023 20:33:47 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id s20-20020a05621412d400b00647386a3234sm1081913qvv.85.2023.11.15.20.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:46 -0800 (PST)
Date: Wed, 15 Nov 2023 23:33:46 -0500
Message-ID: <3d5492a66547c78a888b4256ec0a73f4.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 11/23] security: Introduce inode_post_removexattr hook
References: <20231107134012.682009-12-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-12-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_removexattr hook.
> 
> At inode_removexattr hook, EVM verifies the file's existing HMAC value. At
> inode_post_removexattr, EVM re-calculates the file's HMAC with the passed
> xattr removed and other file metadata.
> 
> Other LSMs could similarly take some action after successful xattr removal.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/xattr.c                    |  9 +++++----
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  5 +++++
>  security/security.c           | 14 ++++++++++++++
>  4 files changed, 26 insertions(+), 4 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index ce3bc7642e18..8aa6e9f316dd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2452,6 +2452,20 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>  	return evm_inode_removexattr(idmap, dentry, name);
>  }
>  
> +/**
> + * security_inode_post_removexattr() - Update the inode after a removexattr op
> + * @dentry: file
> + * @name: xattr name
> + *
> + * Update the inode after a successful removexattr operation.
> + */
> +void security_inode_post_removexattr(struct dentry *dentry, const char *name)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;

Similar comment about the S_PRIVATE check as was in patch 10/23.

> +	call_void_hook(inode_post_removexattr, dentry, name);
> +}
> +
>  /**
>   * security_inode_need_killpriv() - Check if security_inode_killpriv() required
>   * @dentry: associated dentry
> -- 
> 2.34.1

--
paul-moore.com

