Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E9A3FAB35
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 13:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbhH2LuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 07:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbhH2LuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 07:50:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208BBC061575;
        Sun, 29 Aug 2021 04:49:15 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y6so20475553lje.2;
        Sun, 29 Aug 2021 04:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Q6XuCPYcHjsaIBgbifsfoz1wQdKaW98lHko/EageT4A=;
        b=B7tWrOb9YXDqebGEaWvPCURenktpwxQsIfL3j/2Yc9Zyk/LM9Z9ryHnAZanNW2KCY5
         26//8YWkG6dhHFM2yVIKcGYJuZfLtyixNkxOgqE2OWOSOusnZwahx+D9C02yqU+GNtSv
         eXyHSPSyCJUDm2w/uDtodkP2BzRUj7AKr+5wb7cWtZ8BJoBtg/pxk9OTYBmD9tWgdMgC
         pf9rsULSi6wTIqVPfBew9hwc/QFQ6sVwVcJMdcxPylkeb7dUQtBWxU1JfknyMm47n7of
         6oxQOvNPCCVyIaf19ZA3KGuy8FC5Gfz5sq+uq91Bxh6YNCR3AEn/LJN8RSExHQHpETPa
         o6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q6XuCPYcHjsaIBgbifsfoz1wQdKaW98lHko/EageT4A=;
        b=DhdpeuwF/PZRkcSVO0/5K1PThkyJDbI5Qkr4NnA8u5QgJpow5Sl6/7etvBfsauv/kQ
         oN+Jc6gAqbWSl+Icst39Y8VVID0+mCDzg+9rNf/jp8GPCX6o5hwiQ/BlF0+UDr9UrUTM
         5hggxzmmOyGYltM5PEgmP8kulwTjn6g7N++frUZbUkeogWIXLunLnAWlNlZsUC4plQI0
         mCNHU4Jtbj50tHuem6UhsWRiKaFGlryMOxEtIucEHNGvgli8/B0uCryfU/F8DTVaEcE1
         P2wRqr8sFsisWdz9C/+dh1f9Uu/dUoYl14lz47vMo3m3CzefPLZ2xvgZhuVPSuNn1A7X
         uSrg==
X-Gm-Message-State: AOAM533mCy4hd/LJtpiio1+UTcYKgUVACrlNLporuk34nETnU06NtoZS
        m8da0jqyAnzIAI/NyABgjCAHSw5+83Vh5g==
X-Google-Smtp-Source: ABdhPJwTHaxsATdDPsCO98wlAYcimFtlGAMDtC77lqKkiINCUwyxD5hR6JTvN/lWEmHuFKwGPUtQ0g==
X-Received: by 2002:a2e:7810:: with SMTP id t16mr15601261ljc.24.1630237753404;
        Sun, 29 Aug 2021 04:49:13 -0700 (PDT)
Received: from kari-VirtualBox (37-33-245-172.bb.dnainternet.fi. [37.33.245.172])
        by smtp.gmail.com with ESMTPSA id p16sm754130lfo.181.2021.08.29.04.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 04:49:12 -0700 (PDT)
Date:   Sun, 29 Aug 2021 14:49:10 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 8/9] fs/ntfs3: Rename mount option no_acl_rules >
 (no)acl_rules
Message-ID: <20210829114910.pf2vcrr726hu2svu@kari-VirtualBox>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
 <20210829095614.50021-9-kari.argillander@gmail.com>
 <20210829101637.2w2cxrhsdlv44z5x@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210829101637.2w2cxrhsdlv44z5x@pali>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 29, 2021 at 12:16:37PM +0200, Pali Rohár wrote:
> Hello!
> 
> On Sunday 29 August 2021 12:56:13 Kari Argillander wrote:
> > Rename mount option no_acl_rules to noacl_rules. This allow us to use
> > possibility to mount with options noacl_rules or acl_rules.
> 
> $commit_message =~ s/acl/acs/g;

Thanks.

> 
> Anyway, for me "noacs_rules" name looks strange. Underline is used as a
> word separator and so original name "no_acs_rules" looks better. But if
> you are going to remove first underline, why not then remove also the
> second one? So name would be "noacsrules" and better matches naming
> convention?

I agree. Now that you wrote it like that I see that is definitely
better.

> And I see that other filesystems have option 'mode' (e.g. iso9660, udf)
> whicha is basically superset of this no_acs_rules as it supports to set
> permission to also any other mode than 0777.

We also have umask, fmask and dmask. Isn't fmask=mode and dmask=dmode?

I have not tested these really, but my impression is that noacsrules
will kinda overwrite everything else. It can also lie to user because
user can change file permission, but it will not change in reality.

I'm not even sure when do we need this option. Konstantin can probably
enlighten us or at least me.

> Maybe this could be a good thing to unify across all filesystems in
> future...

Hopefully.

> 
> > Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> > ---
> >  Documentation/filesystems/ntfs3.rst |  2 +-
> >  fs/ntfs3/file.c                     |  2 +-
> >  fs/ntfs3/ntfs_fs.h                  |  2 +-
> >  fs/ntfs3/super.c                    | 12 ++++++------
> >  fs/ntfs3/xattr.c                    |  2 +-
> >  5 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
> > index ded706474825..bdc9dd5a9185 100644
> > --- a/Documentation/filesystems/ntfs3.rst
> > +++ b/Documentation/filesystems/ntfs3.rst
> > @@ -73,7 +73,7 @@ prealloc		Preallocate space for files excessively when file size is
> >  			increasing on writes. Decreases fragmentation in case of
> >  			parallel write operations to different files.
> >  
> > -no_acs_rules		"No access rules" mount option sets access rights for
> > +noacs_rules		"No access rules" mount option sets access rights for
> >  			files/folders to 777 and owner/group to root. This mount
> >  			option absorbs all other permissions:
> >  			- permissions change for files/folders will be reported
> > diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> > index c79e4aff7a19..4c9ff7fcf0b1 100644
> > --- a/fs/ntfs3/file.c
> > +++ b/fs/ntfs3/file.c
> > @@ -743,7 +743,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
> >  	umode_t mode = inode->i_mode;
> >  	int err;
> >  
> > -	if (sbi->options->no_acs_rules) {
> > +	if (sbi->options->noacs_rules) {
> >  		/* "no access rules" - force any changes of time etc. */
> >  		attr->ia_valid |= ATTR_FORCE;
> >  		/* and disable for editing some attributes */
> > diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> > index 45d6f4f91222..5df55bc733bd 100644
> > --- a/fs/ntfs3/ntfs_fs.h
> > +++ b/fs/ntfs3/ntfs_fs.h
> > @@ -70,7 +70,7 @@ struct ntfs_mount_options {
> >  		showmeta : 1, /*show meta files*/
> >  		nohidden : 1, /*do not show hidden files*/
> >  		force : 1, /*rw mount dirty volume*/
> > -		no_acs_rules : 1, /*exclude acs rules*/
> > +		noacs_rules : 1, /*exclude acs rules*/
> >  		prealloc : 1 /*preallocate space when file is growing*/
> >  		;
> >  };
> > diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> > index e5c319604c4d..d7408b4f6813 100644
> > --- a/fs/ntfs3/super.c
> > +++ b/fs/ntfs3/super.c
> > @@ -221,7 +221,7 @@ enum Opt {
> >  	Opt_acl,
> >  	Opt_iocharset,
> >  	Opt_prealloc,
> > -	Opt_no_acs_rules,
> > +	Opt_noacs_rules,
> >  	Opt_err,
> >  };
> >  
> > @@ -239,7 +239,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
> >  	fsparam_flag_no("acl",			Opt_acl),
> >  	fsparam_flag_no("showmeta",		Opt_showmeta),
> >  	fsparam_flag_no("prealloc",		Opt_prealloc),
> > -	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
> > +	fsparam_flag_no("acs_rules",		Opt_noacs_rules),
> >  	fsparam_string("iocharset",		Opt_iocharset),
> >  
> >  	__fsparam(fs_param_is_string,
> > @@ -351,8 +351,8 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
> >  	case Opt_prealloc:
> >  		opts->prealloc = result.negated ? 0 : 1;
> >  		break;
> > -	case Opt_no_acs_rules:
> > -		opts->no_acs_rules = 1;
> > +	case Opt_noacs_rules:
> > +		opts->noacs_rules = result.negated ? 1 : 0;
> >  		break;
> >  	default:
> >  		/* Should not be here unless we forget add case. */
> > @@ -538,8 +538,8 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
> >  		seq_puts(m, ",nohidden");
> >  	if (opts->force)
> >  		seq_puts(m, ",force");
> > -	if (opts->no_acs_rules)
> > -		seq_puts(m, ",no_acs_rules");
> > +	if (opts->noacs_rules)
> > +		seq_puts(m, ",noacs_rules");
> >  	if (opts->prealloc)
> >  		seq_puts(m, ",prealloc");
> >  	if (sb->s_flags & SB_POSIXACL)
> > diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> > index a17d48735b99..4b37ed239579 100644
> > --- a/fs/ntfs3/xattr.c
> > +++ b/fs/ntfs3/xattr.c
> > @@ -774,7 +774,7 @@ int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode)
> >  int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
> >  		    int mask)
> >  {
> > -	if (ntfs_sb(inode->i_sb)->options->no_acs_rules) {
> > +	if (ntfs_sb(inode->i_sb)->options->noacs_rules) {
> >  		/* "no access rules" mode - allow all changes */
> >  		return 0;
> >  	}
> > -- 
> > 2.25.1
> > 
> 
