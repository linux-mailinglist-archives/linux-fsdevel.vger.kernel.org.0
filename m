Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6A23FAACD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 12:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbhH2KRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 06:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234835AbhH2KRc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 06:17:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C3AB60E73;
        Sun, 29 Aug 2021 10:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630232200;
        bh=Iz//lVGXB3DYwlffCR72uZ3CK9sHVaAqRgu/FvrJGfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OM9VxJwxzPxcsO2QNOc234zLRPWKH0F//MFeUsmDUpftcMjL1BkCBFrq6s/T/Bn24
         W3WXjw0dDwJ6fjm6KHTXGM0ErCQ0ZoZrcovqtUxLlOntGTGlN9O7yfmbxecbDqwZlQ
         2S5hOJeyqP7uoJVvO1CDmZbQS1Dg7v15EC+4FTqvDcquhAKFkmjrolv9chHNTC0JFd
         msDKLB25z8l3e7WnvGT+wZNpF9O6rauOje3+VCgPDUQZmERecW2eICDWqIKdD/7TBq
         LrjjuSBiNIGQ0YnXy0XLdtq+wUaDXrkBrfO/m1MbbU62Ax/8PXfiE4qbKPuJBsBVg7
         r0hANBAWsciaA==
Received: by pali.im (Postfix)
        id 6447AB0F; Sun, 29 Aug 2021 12:16:37 +0200 (CEST)
Date:   Sun, 29 Aug 2021 12:16:37 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 8/9] fs/ntfs3: Rename mount option no_acl_rules >
 (no)acl_rules
Message-ID: <20210829101637.2w2cxrhsdlv44z5x@pali>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
 <20210829095614.50021-9-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829095614.50021-9-kari.argillander@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Sunday 29 August 2021 12:56:13 Kari Argillander wrote:
> Rename mount option no_acl_rules to noacl_rules. This allow us to use
> possibility to mount with options noacl_rules or acl_rules.

$commit_message =~ s/acl/acs/g;

Anyway, for me "noacs_rules" name looks strange. Underline is used as a
word separator and so original name "no_acs_rules" looks better. But if
you are going to remove first underline, why not then remove also the
second one? So name would be "noacsrules" and better matches naming
convention?

And I see that other filesystems have option 'mode' (e.g. iso9660, udf)
whicha is basically superset of this no_acs_rules as it supports to set
permission to also any other mode than 0777.

Maybe this could be a good thing to unify across all filesystems in
future...

> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
>  Documentation/filesystems/ntfs3.rst |  2 +-
>  fs/ntfs3/file.c                     |  2 +-
>  fs/ntfs3/ntfs_fs.h                  |  2 +-
>  fs/ntfs3/super.c                    | 12 ++++++------
>  fs/ntfs3/xattr.c                    |  2 +-
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
> index ded706474825..bdc9dd5a9185 100644
> --- a/Documentation/filesystems/ntfs3.rst
> +++ b/Documentation/filesystems/ntfs3.rst
> @@ -73,7 +73,7 @@ prealloc		Preallocate space for files excessively when file size is
>  			increasing on writes. Decreases fragmentation in case of
>  			parallel write operations to different files.
>  
> -no_acs_rules		"No access rules" mount option sets access rights for
> +noacs_rules		"No access rules" mount option sets access rights for
>  			files/folders to 777 and owner/group to root. This mount
>  			option absorbs all other permissions:
>  			- permissions change for files/folders will be reported
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index c79e4aff7a19..4c9ff7fcf0b1 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -743,7 +743,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  	umode_t mode = inode->i_mode;
>  	int err;
>  
> -	if (sbi->options->no_acs_rules) {
> +	if (sbi->options->noacs_rules) {
>  		/* "no access rules" - force any changes of time etc. */
>  		attr->ia_valid |= ATTR_FORCE;
>  		/* and disable for editing some attributes */
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 45d6f4f91222..5df55bc733bd 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -70,7 +70,7 @@ struct ntfs_mount_options {
>  		showmeta : 1, /*show meta files*/
>  		nohidden : 1, /*do not show hidden files*/
>  		force : 1, /*rw mount dirty volume*/
> -		no_acs_rules : 1, /*exclude acs rules*/
> +		noacs_rules : 1, /*exclude acs rules*/
>  		prealloc : 1 /*preallocate space when file is growing*/
>  		;
>  };
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index e5c319604c4d..d7408b4f6813 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -221,7 +221,7 @@ enum Opt {
>  	Opt_acl,
>  	Opt_iocharset,
>  	Opt_prealloc,
> -	Opt_no_acs_rules,
> +	Opt_noacs_rules,
>  	Opt_err,
>  };
>  
> @@ -239,7 +239,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
>  	fsparam_flag_no("acl",			Opt_acl),
>  	fsparam_flag_no("showmeta",		Opt_showmeta),
>  	fsparam_flag_no("prealloc",		Opt_prealloc),
> -	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
> +	fsparam_flag_no("acs_rules",		Opt_noacs_rules),
>  	fsparam_string("iocharset",		Opt_iocharset),
>  
>  	__fsparam(fs_param_is_string,
> @@ -351,8 +351,8 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
>  	case Opt_prealloc:
>  		opts->prealloc = result.negated ? 0 : 1;
>  		break;
> -	case Opt_no_acs_rules:
> -		opts->no_acs_rules = 1;
> +	case Opt_noacs_rules:
> +		opts->noacs_rules = result.negated ? 1 : 0;
>  		break;
>  	default:
>  		/* Should not be here unless we forget add case. */
> @@ -538,8 +538,8 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
>  		seq_puts(m, ",nohidden");
>  	if (opts->force)
>  		seq_puts(m, ",force");
> -	if (opts->no_acs_rules)
> -		seq_puts(m, ",no_acs_rules");
> +	if (opts->noacs_rules)
> +		seq_puts(m, ",noacs_rules");
>  	if (opts->prealloc)
>  		seq_puts(m, ",prealloc");
>  	if (sb->s_flags & SB_POSIXACL)
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index a17d48735b99..4b37ed239579 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -774,7 +774,7 @@ int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode)
>  int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
>  		    int mask)
>  {
> -	if (ntfs_sb(inode->i_sb)->options->no_acs_rules) {
> +	if (ntfs_sb(inode->i_sb)->options->noacs_rules) {
>  		/* "no access rules" mode - allow all changes */
>  		return 0;
>  	}
> -- 
> 2.25.1
> 
