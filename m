Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B550246693B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 18:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348171AbhLBRiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 12:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348094AbhLBRiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:38:13 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AA0C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 09:34:51 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so583175otl.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Dec 2021 09:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iCJUReenGm5/J4xr/ptnYZNffc1nEjUxdrmF+6H1QJ4=;
        b=gpH0L347TDwN3/i37DjKVIpefYCE5YYCHvWD1MupUd5vAA2BPYeii5ZE7IjuZCHTIS
         iYrwxk4aGUfs3DdrK+qS60Dxnag0y1CpvwClxuOgDUZA4XOWL4UFtCUQrGEYmOjJ2OWC
         ig3phKefNKCOEsmtyu6/bpKD9h2B5+IU7dBL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iCJUReenGm5/J4xr/ptnYZNffc1nEjUxdrmF+6H1QJ4=;
        b=t5JwLyc81107c41Y9euLZqLhroaCyaPPe6jkGO00O/MSGS3MW3Enel8Ivm3EoG99WO
         0YnLnzJhJ8gJiodEkLE9imrAmhdjRHj+OHgjlbnjntkn2iFG4WAjcwjBnyahJK7LXkmj
         HY3HtxCGpPVihR0prZ8kMEY2eF1t3fQDOC7IaLlwBQD0fmRelQXo5RIetqgx2klpnJvR
         axL1nOyaLDrEqMXuk4h8KOuYCT0CqqwMJN1aiquP/wJQDjIRF76Y8z02lp6p5Y1dLMs9
         5/dJiWSQ9TCp4qLugaIOnk7CmKigjaEsh/6Vln/OWw1uZQu6iLaE8qbTOhgPEumhXred
         yJ/A==
X-Gm-Message-State: AOAM533oZTlL+LlBCDP77sGIDTBuSVYWhLbOoWeMz0j+kVA5esGcPnpA
        m8PlL8dn3Ad+RHAu6NAbO5x5N8FtJJjpd/nn
X-Google-Smtp-Source: ABdhPJyV00MXMhXAd+iaAy8TSFR9HeVqNcTyAfJw6QpisHv+D+o1peA2zRl9Sgux7SjpbfchKmsPfg==
X-Received: by 2002:a9d:550c:: with SMTP id l12mr12692598oth.69.1638466490571;
        Thu, 02 Dec 2021 09:34:50 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:49aa:e3a:9f96:cf34])
        by smtp.gmail.com with ESMTPSA id p10sm134751otp.53.2021.12.02.09.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:34:50 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:34:49 -0600
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 06/10] fs: use low-level mapping helpers
Message-ID: <YakDuY2qLG7KiNF8@do-x1extreme>
References: <20211130121032.3753852-1-brauner@kernel.org>
 <20211130121032.3753852-7-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130121032.3753852-7-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:10:28PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> In a few places the vfs needs to interact with bare k{g,u}ids directly
> instead of struct inode. These are just a few. In previous patches we
> introduced low-level mapping helpers that are able to support
> filesystems mounted an idmapping. This patch simply converts the places
> to use these new helpers.
> 
> Link: https://lore.kernel.org/r/20211123114227.3124056-7-brauner@kernel.org (v1)
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Seth Forshee <sforshee@digitalocean.com>

> ---
> /* v2 */
> unchanged
> ---
>  fs/ksmbd/smbacl.c    | 18 ++----------------
>  fs/ksmbd/smbacl.h    |  4 ++--
>  fs/open.c            |  4 ++--
>  fs/posix_acl.c       | 16 ++++++++++------
>  security/commoncap.c | 13 ++++++++-----
>  5 files changed, 24 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
> index ab8099e0fd7f..6ecf55ea1fed 100644
> --- a/fs/ksmbd/smbacl.c
> +++ b/fs/ksmbd/smbacl.c
> @@ -275,14 +275,7 @@ static int sid_to_id(struct user_namespace *user_ns,
>  		uid_t id;
>  
>  		id = le32_to_cpu(psid->sub_auth[psid->num_subauth - 1]);
> -		/*
> -		 * Translate raw sid into kuid in the server's user
> -		 * namespace.
> -		 */
> -		uid = make_kuid(&init_user_ns, id);
> -
> -		/* If this is an idmapped mount, apply the idmapping. */
> -		uid = kuid_from_mnt(user_ns, uid);
> +		uid = mapped_kuid_user(user_ns, &init_user_ns, KUIDT_INIT(id));
>  		if (uid_valid(uid)) {
>  			fattr->cf_uid = uid;
>  			rc = 0;
> @@ -292,14 +285,7 @@ static int sid_to_id(struct user_namespace *user_ns,
>  		gid_t id;
>  
>  		id = le32_to_cpu(psid->sub_auth[psid->num_subauth - 1]);
> -		/*
> -		 * Translate raw sid into kgid in the server's user
> -		 * namespace.
> -		 */
> -		gid = make_kgid(&init_user_ns, id);
> -
> -		/* If this is an idmapped mount, apply the idmapping. */
> -		gid = kgid_from_mnt(user_ns, gid);
> +		gid = mapped_kgid_user(user_ns, &init_user_ns, KGIDT_INIT(id));
>  		if (gid_valid(gid)) {
>  			fattr->cf_gid = gid;
>  			rc = 0;
> diff --git a/fs/ksmbd/smbacl.h b/fs/ksmbd/smbacl.h
> index eba1ebb9e92e..811af3309429 100644
> --- a/fs/ksmbd/smbacl.h
> +++ b/fs/ksmbd/smbacl.h
> @@ -217,7 +217,7 @@ static inline uid_t posix_acl_uid_translate(struct user_namespace *mnt_userns,
>  	kuid_t kuid;
>  
>  	/* If this is an idmapped mount, apply the idmapping. */
> -	kuid = kuid_into_mnt(mnt_userns, pace->e_uid);
> +	kuid = mapped_kuid_fs(mnt_userns, &init_user_ns, pace->e_uid);
>  
>  	/* Translate the kuid into a userspace id ksmbd would see. */
>  	return from_kuid(&init_user_ns, kuid);
> @@ -229,7 +229,7 @@ static inline gid_t posix_acl_gid_translate(struct user_namespace *mnt_userns,
>  	kgid_t kgid;
>  
>  	/* If this is an idmapped mount, apply the idmapping. */
> -	kgid = kgid_into_mnt(mnt_userns, pace->e_gid);
> +	kgid = mapped_kgid_fs(mnt_userns, &init_user_ns, pace->e_gid);
>  
>  	/* Translate the kgid into a userspace id ksmbd would see. */
>  	return from_kgid(&init_user_ns, kgid);
> diff --git a/fs/open.c b/fs/open.c
> index 2450cc1a2f64..40a00e71865b 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -653,8 +653,8 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
>  	gid = make_kgid(current_user_ns(), group);
>  
>  	mnt_userns = mnt_user_ns(path->mnt);
> -	uid = kuid_from_mnt(mnt_userns, uid);
> -	gid = kgid_from_mnt(mnt_userns, gid);
> +	uid = mapped_kuid_user(mnt_userns, &init_user_ns, uid);
> +	gid = mapped_kgid_user(mnt_userns, &init_user_ns, gid);
>  
>  retry_deleg:
>  	newattrs.ia_valid =  ATTR_CTIME;
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 632bfdcf7cc0..4b5fb9a9b90f 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -375,7 +375,9 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
>                                          goto check_perm;
>                                  break;
>                          case ACL_USER:
> -				uid = kuid_into_mnt(mnt_userns, pa->e_uid);
> +				uid = mapped_kuid_fs(mnt_userns,
> +						      &init_user_ns,
> +						      pa->e_uid);
>  				if (uid_eq(uid, current_fsuid()))
>                                          goto mask;
>  				break;
> @@ -388,7 +390,9 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
>                                  }
>  				break;
>                          case ACL_GROUP:
> -				gid = kgid_into_mnt(mnt_userns, pa->e_gid);
> +				gid = mapped_kgid_fs(mnt_userns,
> +						      &init_user_ns,
> +						      pa->e_gid);
>  				if (in_group_p(gid)) {
>  					found = 1;
>  					if ((pa->e_perm & want) == want)
> @@ -735,17 +739,17 @@ static void posix_acl_fix_xattr_userns(
>  		case ACL_USER:
>  			uid = make_kuid(from, le32_to_cpu(entry->e_id));
>  			if (from_user)
> -				uid = kuid_from_mnt(mnt_userns, uid);
> +				uid = mapped_kuid_user(mnt_userns, &init_user_ns, uid);
>  			else
> -				uid = kuid_into_mnt(mnt_userns, uid);
> +				uid = mapped_kuid_fs(mnt_userns, &init_user_ns, uid);
>  			entry->e_id = cpu_to_le32(from_kuid(to, uid));
>  			break;
>  		case ACL_GROUP:
>  			gid = make_kgid(from, le32_to_cpu(entry->e_id));
>  			if (from_user)
> -				gid = kgid_from_mnt(mnt_userns, gid);
> +				gid = mapped_kgid_user(mnt_userns, &init_user_ns, gid);
>  			else
> -				gid = kgid_into_mnt(mnt_userns, gid);
> +				gid = mapped_kgid_fs(mnt_userns, &init_user_ns, gid);
>  			entry->e_id = cpu_to_le32(from_kgid(to, gid));
>  			break;
>  		default:
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 09479f71ee2e..d288a62e2999 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -419,7 +419,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
>  	kroot = make_kuid(fs_ns, root);
>  
>  	/* If this is an idmapped mount shift the kuid. */
> -	kroot = kuid_into_mnt(mnt_userns, kroot);
> +	kroot = mapped_kuid_fs(mnt_userns, &init_user_ns, kroot);
>  
>  	/* If the root kuid maps to a valid uid in current ns, then return
>  	 * this as a nscap. */
> @@ -489,6 +489,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
>   * @size:	size of @ivalue
>   * @task_ns:	user namespace of the caller
>   * @mnt_userns:	user namespace of the mount the inode was found from
> + * @fs_userns:	user namespace of the filesystem
>   *
>   * If the inode has been found through an idmapped mount the user namespace of
>   * the vfsmount must be passed through @mnt_userns. This function will then
> @@ -498,7 +499,8 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
>   */
>  static kuid_t rootid_from_xattr(const void *value, size_t size,
>  				struct user_namespace *task_ns,
> -				struct user_namespace *mnt_userns)
> +				struct user_namespace *mnt_userns,
> +				struct user_namespace *fs_userns)
>  {
>  	const struct vfs_ns_cap_data *nscap = value;
>  	kuid_t rootkid;
> @@ -508,7 +510,7 @@ static kuid_t rootid_from_xattr(const void *value, size_t size,
>  		rootid = le32_to_cpu(nscap->rootid);
>  
>  	rootkid = make_kuid(task_ns, rootid);
> -	return kuid_from_mnt(mnt_userns, rootkid);
> +	return mapped_kuid_user(mnt_userns, fs_userns, rootkid);
>  }
>  
>  static bool validheader(size_t size, const struct vfs_cap_data *cap)
> @@ -559,7 +561,8 @@ int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
>  			/* user is privileged, just write the v2 */
>  			return size;
>  
> -	rootid = rootid_from_xattr(*ivalue, size, task_ns, mnt_userns);
> +	rootid = rootid_from_xattr(*ivalue, size, task_ns, mnt_userns,
> +				   &init_user_ns);
>  	if (!uid_valid(rootid))
>  		return -EINVAL;
>  
> @@ -700,7 +703,7 @@ int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
>  	/* Limit the caps to the mounter of the filesystem
>  	 * or the more limited uid specified in the xattr.
>  	 */
> -	rootkuid = kuid_into_mnt(mnt_userns, rootkuid);
> +	rootkuid = mapped_kuid_fs(mnt_userns, &init_user_ns, rootkuid);
>  	if (!rootid_owns_currentns(rootkuid))
>  		return -ENODATA;
>  
> -- 
> 2.30.2
> 
