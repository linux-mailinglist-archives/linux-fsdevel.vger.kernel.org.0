Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED513ED844
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhHPOAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 10:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhHPOAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:00:24 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC48C0612A6;
        Mon, 16 Aug 2021 06:59:31 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id n6so27315364ljp.9;
        Mon, 16 Aug 2021 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XZeOo7antsCURipi9p9pHgTVtk8UBEylz/6Al+9JzzE=;
        b=eNLSA5SVbhuErx+lowyphptgjYRLhktQS4skGDUS2neXw0nd7QSBV2pujUwtzLMIxO
         GlB0sMkEMXRc6S5wt/SSsOLxJDsbLHClyGWAlXe69rPsttoPDQ5O780wpnDEvlWsFjQi
         ew8Q5Lr1oOPwfsQ8oC5KI9aHAdo/6QPVmrDsVWtFEu4NtQIB3BML2Fa4NDY/cyRMz2Hn
         09//brz3ZOwnYsUb6kz8czalGqSuSb63o0ryFs5v7RoJ+J7zmGXvjsWZmPZ9AAdK1fzN
         ps5NB8Oij0hUq61Jggp+wMxdaqMqKEFXF3gake2nIg73u474NvA/h7B0impBPZGqLF//
         0ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XZeOo7antsCURipi9p9pHgTVtk8UBEylz/6Al+9JzzE=;
        b=QB7gcimjbjxIT8oF1XgQ5WaScRi6T3zLVW041nOtNyuQSA9aRBHg27Ncnh1nUXkEtC
         4lUPhbTIpqsvBNpahtdSnEW1rdUJZpdJnQd4r8FB4ImKNTEgfmUO76iplH9dq/sg1yxH
         ioChjiYyjfRQbYiYbPevZNp3zYbWZHGrKEupEY7xccYJ9qWWPtUn1mrKbWSs+J6UPksc
         +/mKzPAqR+NTFeOUu7+uiLPfMUQxTPen30nckOMhQAEKKFF07k6LTpnx7JTI5ed/yZYY
         pgXXAK3EJ5lhfBUgwDfAXxXNTB7onGl3H0Reob0loGOT3TOvFZ2JWMRGIqKFxD7Sgf6Y
         RcRQ==
X-Gm-Message-State: AOAM531y6DTGm93zoERz29ZD92jZYkbi7cI6/Y3OcLyDS2EsCvR9id5d
        U6yxEnpTKFZMVGDDY2ie6ZU=
X-Google-Smtp-Source: ABdhPJxLhQ2TycU+cuFd9OLQ/3S4m16XYf9rO+OMvECKUVPslFN3cqG/cKVJw8cw57zS9B4ecQrMaQ==
X-Received: by 2002:a05:651c:10a2:: with SMTP id k2mr2678336ljn.262.1629122369383;
        Mon, 16 Aug 2021 06:59:29 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id r25sm1175785ljc.118.2021.08.16.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 06:59:28 -0700 (PDT)
Date:   Mon, 16 Aug 2021 16:59:27 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 1/4] fs/ntfs3: Use new api for mounting
Message-ID: <20210816135927.rkr73agluihdb4hw@kari-VirtualBox>
References: <20210816024703.107251-1-kari.argillander@gmail.com>
 <20210816024703.107251-2-kari.argillander@gmail.com>
 <20210816134030.r63djan72nbrx66k@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816134030.r63djan72nbrx66k@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 03:40:30PM +0200, Christian Brauner wrote:
> On Mon, Aug 16, 2021 at 05:47:00AM +0300, Kari Argillander wrote:
> > We have now new mount api as described in Documentation/filesystems. We
> > should use it as it gives us some benefits which are desribed here
> > https://lore.kernel.org/linux-fsdevel/159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk/
> > 
> > Nls loading is changed a little bit because new api not have default
> > optioni for mount parameters. So we need to load nls table before and
> > change that if user specifie someting else.
> > 
> > Also try to use fsparam_flag_no as much as possible. This is just nice
> > little touch and is not mandatory but it should not make any harm. It
> > is just convenient that we can use example acl/noacl mount options.
> > 
> > Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> > ---
> >  fs/ntfs3/super.c | 382 ++++++++++++++++++++++++-----------------------
> >  1 file changed, 193 insertions(+), 189 deletions(-)
> > 
> > diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> > index 6be13e256c1a..d805e0b31404 100644
> > --- a/fs/ntfs3/super.c
> > +++ b/fs/ntfs3/super.c
> > @@ -28,10 +28,11 @@
> >  #include <linux/buffer_head.h>
> >  #include <linux/exportfs.h>
> >  #include <linux/fs.h>
> > +#include <linux/fs_context.h>
> > +#include <linux/fs_parser.h>
> >  #include <linux/iversion.h>
> >  #include <linux/module.h>
> >  #include <linux/nls.h>
> > -#include <linux/parser.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/statfs.h>
> >  
> > @@ -197,6 +198,30 @@ void *ntfs_put_shared(void *ptr)
> >  	return ret;
> >  }
> >  
> > +/*
> > + * ntfs_load_nls
> > + *
> > + * Load nls table or if @nls is utf8 then return NULL because
> > + * nls=utf8 is totally broken.
> > + */
> > +static struct nls_table *ntfs_load_nls(char *nls)
> > +{
> > +	struct nls_table *ret;
> > +
> > +	if (!nls)
> > +		return ERR_PTR(-EINVAL);
> > +	if (strcmp(nls, "utf8"))
> > +		return NULL;
> > +	if (strcmp(nls, CONFIG_NLS_DEFAULT))
> > +		return load_nls_default();
> > +
> > +	ret = load_nls(nls);
> > +	if (!ret)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	return ret;
> > +}
> > +
> >  static inline void clear_mount_options(struct ntfs_mount_options *options)
> >  {
> >  	unload_nls(options->nls);
> > @@ -222,208 +247,164 @@ enum Opt {
> >  	Opt_err,
> >  };
> >  
> > -static const match_table_t ntfs_tokens = {
> > -	{ Opt_uid, "uid=%u" },
> > -	{ Opt_gid, "gid=%u" },
> > -	{ Opt_umask, "umask=%o" },
> > -	{ Opt_dmask, "dmask=%o" },
> > -	{ Opt_fmask, "fmask=%o" },
> > -	{ Opt_immutable, "sys_immutable" },
> > -	{ Opt_discard, "discard" },
> > -	{ Opt_force, "force" },
> > -	{ Opt_sparse, "sparse" },
> > -	{ Opt_nohidden, "nohidden" },
> > -	{ Opt_acl, "acl" },
> > -	{ Opt_noatime, "noatime" },
> > -	{ Opt_showmeta, "showmeta" },
> > -	{ Opt_nls, "nls=%s" },
> > -	{ Opt_prealloc, "prealloc" },
> > -	{ Opt_no_acs_rules, "no_acs_rules" },
> > -	{ Opt_err, NULL },
> > +// clang-format off
> > +static const struct fs_parameter_spec ntfs_fs_parameters[] = {
> > +	fsparam_u32("uid",			Opt_uid),
> > +	fsparam_u32("gid",			Opt_gid),
> > +	fsparam_u32oct("umask",			Opt_umask),
> > +	fsparam_u32oct("dmask",			Opt_dmask),
> > +	fsparam_u32oct("fmask",			Opt_fmask),
> > +	fsparam_flag_no("sys_immutable",	Opt_immutable),
> > +	fsparam_flag_no("discard",		Opt_discard),
> > +	fsparam_flag_no("force",		Opt_force),
> > +	fsparam_flag_no("sparse",		Opt_sparse),
> > +	fsparam_flag("nohidden",		Opt_nohidden),
> > +	fsparam_flag_no("acl",			Opt_acl),
> > +	fsparam_flag("noatime",			Opt_noatime),
> > +	fsparam_flag_no("showmeta",		Opt_showmeta),
> > +	fsparam_string("nls",			Opt_nls),
> > +	fsparam_flag_no("prealloc",		Opt_prealloc),
> > +	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
> > +	{}
> >  };
> > +// clang-format on
> >  
> > -static noinline int ntfs_parse_options(struct super_block *sb, char *options,
> > -				       int silent,
> > -				       struct ntfs_mount_options *opts)
> > +static void ntfs_default_options(struct ntfs_mount_options *opts)
> >  {
> > -	char *p;
> > -	substring_t args[MAX_OPT_ARGS];
> > -	int option;
> > -	char nls_name[30];
> > -	struct nls_table *nls;
> > -
> >  	opts->fs_uid = current_uid();
> >  	opts->fs_gid = current_gid();
> > -	opts->fs_fmask_inv = opts->fs_dmask_inv = ~current_umask();
> > -	nls_name[0] = 0;
> > -
> > -	if (!options)
> > -		goto out;
> > +	opts->fs_fmask_inv = ~current_umask();
> > +	opts->fs_dmask_inv = ~current_umask();
> > +	opts->nls = ntfs_load_nls(CONFIG_NLS_DEFAULT);
> > +}
> >  
> > -	while ((p = strsep(&options, ","))) {
> > -		int token;
> > +static int ntfs_fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> > +{
> > +	struct ntfs_sb_info *sbi = fc->s_fs_info;
> > +	struct ntfs_mount_options *opts = &sbi->options;
> > +	struct fs_parse_result result;
> > +	int opt;
> >  
> > -		if (!*p)
> > -			continue;
> > +	opt = fs_parse(fc, ntfs_fs_parameters, param, &result);
> > +	if (opt < 0)
> > +		return opt;
> >  
> > -		token = match_token(p, ntfs_tokens, args);
> > -		switch (token) {
> > -		case Opt_immutable:
> > -			opts->sys_immutable = 1;
> > -			break;
> > -		case Opt_uid:
> > -			if (match_int(&args[0], &option))
> > -				return -EINVAL;
> > -			opts->fs_uid = make_kuid(current_user_ns(), option);
> > -			if (!uid_valid(opts->fs_uid))
> > -				return -EINVAL;
> > -			opts->uid = 1;
> > -			break;
> > -		case Opt_gid:
> > -			if (match_int(&args[0], &option))
> > -				return -EINVAL;
> > -			opts->fs_gid = make_kgid(current_user_ns(), option);
> > -			if (!gid_valid(opts->fs_gid))
> > -				return -EINVAL;
> > -			opts->gid = 1;
> > -			break;
> > -		case Opt_umask:
> > -			if (match_octal(&args[0], &option))
> > -				return -EINVAL;
> > -			opts->fs_fmask_inv = opts->fs_dmask_inv = ~option;
> > -			opts->fmask = opts->dmask = 1;
> > -			break;
> > -		case Opt_dmask:
> > -			if (match_octal(&args[0], &option))
> > -				return -EINVAL;
> > -			opts->fs_dmask_inv = ~option;
> > -			opts->dmask = 1;
> > -			break;
> > -		case Opt_fmask:
> > -			if (match_octal(&args[0], &option))
> > -				return -EINVAL;
> > -			opts->fs_fmask_inv = ~option;
> > -			opts->fmask = 1;
> > -			break;
> > -		case Opt_discard:
> > -			opts->discard = 1;
> > -			break;
> > -		case Opt_force:
> > -			opts->force = 1;
> > -			break;
> > -		case Opt_sparse:
> > -			opts->sparse = 1;
> > -			break;
> > -		case Opt_nohidden:
> > -			opts->nohidden = 1;
> > -			break;
> > -		case Opt_acl:
> > +	switch (opt) {
> > +	case Opt_uid:
> > +		opts->fs_uid = make_kuid(current_user_ns(), result.uint_32);
> > +		if (!uid_valid(opts->fs_uid))
> > +			return -EINVAL;
> > +		opts->uid = 1;
> > +		break;
> > +	case Opt_gid:
> > +		opts->fs_gid = make_kgid(current_user_ns(), result.uint_32);
> > +		if (!gid_valid(opts->fs_gid))
> > +			return -EINVAL;
> > +		opts->gid = 1;
> > +		break;
> > +	case Opt_umask:
> > +		opts->fs_fmask_inv = ~result.uint_32;
> > +		opts->fs_dmask_inv = ~result.uint_32;
> > +		opts->fmask = 1;
> > +		opts->dmask = 1;
> > +		break;
> > +	case Opt_dmask:
> > +		opts->fs_dmask_inv = ~result.uint_32;
> > +		opts->dmask = 1;
> > +		break;
> > +	case Opt_fmask:
> > +		opts->fs_fmask_inv = ~result.uint_32;
> > +		opts->fmask = 1;
> > +		break;
> > +	case Opt_immutable:
> > +		opts->sys_immutable = result.negated ? 0 : 1;
> > +		break;
> > +	case Opt_discard:
> > +		opts->discard = result.negated ? 0 : 1;
> > +		break;
> > +	case Opt_force:
> > +		opts->force = result.negated ? 0 : 1;
> > +		break;
> > +	case Opt_sparse:
> > +		opts->sparse = result.negated ? 0 : 1;
> > +		break;
> > +	case Opt_nohidden:
> > +		opts->nohidden = 1;
> > +		break;
> > +	case Opt_acl:
> > +		if (!result.negated)
> >  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
> > -			sb->s_flags |= SB_POSIXACL;
> > -			break;
> > +			fc->sb_flags |= SB_POSIXACL;
> >  #else
> > -			ntfs_err(sb, "support for ACL not compiled in!");
> > -			return -EINVAL;
> > +			return invalf(fc, "ntfs3: Support for ACL not compiled in!");
> >  #endif
> > -		case Opt_noatime:
> > -			sb->s_flags |= SB_NOATIME;
> > -			break;
> > -		case Opt_showmeta:
> > -			opts->showmeta = 1;
> > -			break;
> > -		case Opt_nls:
> > -			match_strlcpy(nls_name, &args[0], sizeof(nls_name));
> > -			break;
> > -		case Opt_prealloc:
> > -			opts->prealloc = 1;
> > -			break;
> > -		case Opt_no_acs_rules:
> > -			opts->no_acs_rules = 1;
> > -			break;
> > -		default:
> > -			if (!silent)
> > -				ntfs_err(
> > -					sb,
> > -					"Unrecognized mount option \"%s\" or missing value",
> > -					p);
> > -			//return -EINVAL;
> > +		else
> > +			fc->sb_flags &= ~SB_POSIXACL;
> > +		break;
> > +	case Opt_noatime:
> > +		fc->sb_flags |= SB_NOATIME;
> > +		break;
> > +	case Opt_showmeta:
> > +		opts->showmeta = result.negated ? 0 : 1;
> > +		break;
> > +	case Opt_nls:
> > +		unload_nls(opts->nls);
> > +
> > +		opts->nls = ntfs_load_nls(param->string);
> > +		if (IS_ERR(opts->nls)) {
> > +			return invalf(fc, "ntfs3: Cannot load nls %s",
> > +				      param->string);
> >  		}
> > -	}
> >  
> > -out:
> > -	if (!strcmp(nls_name[0] ? nls_name : CONFIG_NLS_DEFAULT, "utf8")) {
> > -		/* For UTF-8 use utf16s_to_utf8s/utf8s_to_utf16s instead of nls */
> > -		nls = NULL;
> > -	} else if (nls_name[0]) {
> > -		nls = load_nls(nls_name);
> > -		if (!nls) {
> > -			ntfs_err(sb, "failed to load \"%s\"", nls_name);
> > -			return -EINVAL;
> > -		}
> > -	} else {
> > -		nls = load_nls_default();
> > -		if (!nls) {
> > -			ntfs_err(sb, "failed to load default nls");
> > -			return -EINVAL;
> > -		}
> > +		param->string = NULL;
> > +		break;
> > +	case Opt_prealloc:
> > +		opts->prealloc = result.negated ? 0 : 1;
> > +		break;
> > +	case Opt_no_acs_rules:
> > +		opts->no_acs_rules = 1;
> > +		break;
> > +	default:
> > +		/* Should not be here unless we forget add case. */
> > +		return -EINVAL;
> >  	}
> > -	opts->nls = nls;
> > -
> >  	return 0;
> >  }
> >  
> > -static int ntfs_remount(struct super_block *sb, int *flags, char *data)
> > +static int ntfs_fs_reconfigure(struct fs_context *fc)
> >  {
> > -	int err, ro_rw;
> > +	int ro_rw;
> > +	struct super_block *sb = fc->root->d_sb;
> >  	struct ntfs_sb_info *sbi = sb->s_fs_info;
> > -	struct ntfs_mount_options old_opts;
> > -	char *orig_data = kstrdup(data, GFP_KERNEL);
> > -
> > -	if (data && !orig_data)
> > -		return -ENOMEM;
> > -
> > -	/* Store  original options */
> > -	memcpy(&old_opts, &sbi->options, sizeof(old_opts));
> > -	clear_mount_options(&sbi->options);
> > -	memset(&sbi->options, 0, sizeof(sbi->options));
> > -
> > -	err = ntfs_parse_options(sb, data, 0, &sbi->options);
> > -	if (err)
> > -		goto restore_opts;
> > +	struct ntfs_mount_options *new_opts = fc->s_fs_info;
> > +	int *flags = &fc->sb_flags;
> 
> Afaict this doesn't need to be a pointer anymore.
> fscontext->reconfigure() doesn't have a int *flags parameter.

Yeah.

> >  
> >  	ro_rw = sb_rdonly(sb) && !(*flags & SB_RDONLY);
> >  	if (ro_rw && (sbi->flags & NTFS_FLAGS_NEED_REPLAY)) {
> > -		ntfs_warn(
> > -			sb,
> > +		ntfs_warn(sb,
> >  			"Couldn't remount rw because journal is not replayed. Please umount/remount instead\n");
> > -		err = -EINVAL;
> > -		goto restore_opts;
> > +		goto clear_new_mount;
> >  	}
> >  
> >  	sync_filesystem(sb);
> >  
> >  	if (ro_rw && (sbi->volume.flags & VOLUME_FLAG_DIRTY) &&
> > -	    !sbi->options.force) {
> > +	    !new_opts->force) {
> >  		ntfs_warn(sb, "volume is dirty and \"force\" flag is not set!");
> > -		err = -EINVAL;
> > -		goto restore_opts;
> > +		goto clear_new_mount;
> >  	}
> >  
> > -	clear_mount_options(&old_opts);
> > +	*flags |= (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME) |
> > +		  SB_NODIRATIME | SB_NOATIME;
> >  
> > -	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME) |
> > -		 SB_NODIRATIME | SB_NOATIME;
> > -	ntfs_info(sb, "re-mounted. Opts: %s", orig_data);
> > -	err = 0;
> > -	goto out;
> > -
> > -restore_opts:
> >  	clear_mount_options(&sbi->options);
> > -	memcpy(&sbi->options, &old_opts, sizeof(old_opts));
> > +	sbi->options = *new_opts;
> >  
> > -out:
> > -	kfree(orig_data);
> > -	return err;
> > +	return 0;
> > +
> > +clear_new_mount:
> > +	clear_mount_options(new_opts);
> > +	return -EINVAL;
> >  }
> >  
> >  static struct kmem_cache *ntfs_inode_cachep;
> > @@ -628,7 +609,6 @@ static const struct super_operations ntfs_sops = {
> >  	.statfs = ntfs_statfs,
> >  	.show_options = ntfs_show_options,
> >  	.sync_fs = ntfs_sync_fs,
> > -	.remount_fs = ntfs_remount,
> >  	.write_inode = ntfs3_write_inode,
> >  };
> >  
> > @@ -892,10 +872,10 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
> >  }
> >  
> >  /* try to mount*/
> > -static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
> > +static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >  {
> >  	int err;
> > -	struct ntfs_sb_info *sbi;
> > +	struct ntfs_sb_info *sbi = sb->s_fs_info;
> >  	struct block_device *bdev = sb->s_bdev;
> >  	struct inode *bd_inode = bdev->bd_inode;
> >  	struct request_queue *rq = bdev_get_queue(bdev);
> > @@ -914,11 +894,6 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
> >  
> >  	ref.high = 0;
> >  
> > -	sbi = ntfs_zalloc(sizeof(struct ntfs_sb_info));
> > -	if (!sbi)
> > -		return -ENOMEM;
> > -
> > -	sb->s_fs_info = sbi;
> >  	sbi->sb = sb;
> >  	sb->s_flags |= SB_NODIRATIME;
> >  	sb->s_magic = 0x7366746e; // "ntfs"
> > @@ -930,10 +905,6 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
> >  	ratelimit_state_init(&sbi->msg_ratelimit, DEFAULT_RATELIMIT_INTERVAL,
> >  			     DEFAULT_RATELIMIT_BURST);
> >  
> > -	err = ntfs_parse_options(sb, data, silent, &sbi->options);
> > -	if (err)
> > -		goto out;
> > -
> >  	if (!rq || !blk_queue_discard(rq) || !rq->limits.discard_granularity) {
> >  		;
> >  	} else {
> > @@ -1409,19 +1380,52 @@ int ntfs_discard(struct ntfs_sb_info *sbi, CLST lcn, CLST len)
> >  	return err;
> >  }
> >  
> > -static struct dentry *ntfs_mount(struct file_system_type *fs_type, int flags,
> > -				 const char *dev_name, void *data)
> > +static int ntfs_fs_get_tree(struct fs_context *fc)
> > +{
> > +	return get_tree_bdev(fc, ntfs_fill_super);
> > +}
> > +
> > +static void ntfs_fs_free(struct fs_context *fc)
> >  {
> > -	return mount_bdev(fs_type, flags, dev_name, data, ntfs_fill_super);
> > +	struct ntfs_sb_info *sbi = fc->s_fs_info;
> > +
> > +	if (sbi)
> > +		put_ntfs(sbi);
> > +}
> > +
> > +static const struct fs_context_operations ntfs_context_ops = {
> > +	.parse_param	= ntfs_fs_parse_param,
> > +	.get_tree	= ntfs_fs_get_tree,
> > +	.reconfigure	= ntfs_fs_reconfigure,
> > +	.free		= ntfs_fs_free,
> > +};
> > +
> > +/*
> > + * Set up the filesystem mount context.
> > + */
> > +static int ntfs_init_fs_context(struct fs_context *fc)
> > +{
> > +	struct ntfs_sb_info *sbi;
> > +
> > +	sbi = ntfs_zalloc(sizeof(struct ntfs_sb_info));
> > +	if (!sbi)
> > +		return -ENOMEM;
> > +
> > +	ntfs_default_options(&sbi->options);
> > +
> > +	fc->s_fs_info = sbi;
> > +	fc->ops = &ntfs_context_ops;
> > +	return 0;
> >  }
> >  
> >  // clang-format off
> >  static struct file_system_type ntfs_fs_type = {
> > -	.owner		= THIS_MODULE,
> > -	.name		= "ntfs3",
> > -	.mount		= ntfs_mount,
> > -	.kill_sb	= kill_block_super,
> > -	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,

Note FS_ALLOW_IDMAP here.

> > +	.owner			= THIS_MODULE,
> > +	.name			= "ntfs3",
> > +	.init_fs_context	= ntfs_init_fs_context,
> > +	.parameters		= ntfs_fs_parameters,
> > +	.kill_sb		= kill_block_super,
> > +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> 
> If you add idmapped mount support right away please try to make sure and
> enable ntfs3 with xfstests if that's all possible.

This is already implemented by Komarov in new series. He haven't yet
sended it to mailing list. It is already in linux-next.

Komarov has also stated that they use xfstests (link). And he has showed
test results.
https://lore.kernel.org/linux-fsdevel/0e175373cef24e2abe76e203bb36d260@paragon-software.com/

I have tested these with kvm-xfstests which has support for ntfs3 made
by Theodore Ts'o. Current results:

./kvm-xfstests -c ntfs3 -X "generic/014,generic/129,generic/405,generic/476" -g auto
ntfs3/default: 662 tests, 43 failures, 207 skipped, 7442 seconds
  Failures: generic/012 generic/013 generic/016 generic/021 
    generic/022 generic/040 generic/041 generic/065 generic/066 
    generic/092 generic/094 generic/104 generic/130 generic/177 
    generic/225 generic/228 generic/240 generic/255 generic/258 
    generic/316 generic/321 generic/322 generic/335 generic/336 
    generic/341 generic/342 generic/343 generic/348 generic/360 
    generic/401 generic/423 generic/475 generic/483 generic/498 
    generic/510 generic/526 generic/527 generic/538 generic/551 
    generic/552 generic/631 generic/633 generic/640 
Totals: 455 tests, 207 skipped, 43 failures, 0 errors, 7088s

ACL support seems broken. Notice that many of these are in group "punch"
and punch a hole for regular files was added in "V28" but maybe that
does not work correctly as showed by xfstests.

There is also on going patch set by Theodore for support ntfs3 and fuse
based filesystem in straight in xfstests (link). And after that gets
there then we can ask 01 project to include ntfs3 to their testing.
And hopefully Paragon will send some ntfs related test to upstream.
https://lore.kernel.org/fstests/YQoVXWRFGeY19onQ@mit.edu/

