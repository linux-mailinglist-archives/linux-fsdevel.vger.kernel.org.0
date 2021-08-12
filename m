Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B373EA663
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhHLOSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 10:18:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52732 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbhHLOSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:18:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EC51F221FB;
        Thu, 12 Aug 2021 14:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628777891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QR0JcWHj1RZ/z/tKtiOSkgL8u32xy5MinF2YRbQktU0=;
        b=izsYXAnlwq0cGmtUOspRecEZb1InAmamvsaIRayjGFS8M/0ZUexNZY+S1duUgzZ9cgRU2F
        lMB4RgYEhtYLESL387fUGSs0Gdl+5Zl7dXAu8UfhNUpeilQL4NbxuVecsgPFCfTxnpaEj/
        tP+nvArHEd0UO6nsAqx6WPY5UTvfctk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628777891;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QR0JcWHj1RZ/z/tKtiOSkgL8u32xy5MinF2YRbQktU0=;
        b=lZX0QR0k/mtDnK8yXBjujF70H9W/NQkcE9hOMI+uSGHq9AV0G1WW8UCC17IilVLgrlIH8w
        vC6oiDC00FnWprDQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id D7944A3F4E;
        Thu, 12 Aug 2021 14:18:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BEA981F2BA7; Thu, 12 Aug 2021 16:18:11 +0200 (CEST)
Date:   Thu, 12 Aug 2021 16:18:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 04/20] isofs: joliet: Fix iocharset=utf8 mount option
Message-ID: <20210812141811.GF14675@quack2.suse.cz>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-5-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210808162453.1653-5-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 08-08-21 18:24:37, Pali Rohár wrote:
> Currently iocharset=utf8 mount option is broken. To use UTF-8 as iocharset,
> it is required to use utf8 mount option.
> 
> Fix iocharset=utf8 mount option to use be equivalent to the utf8 mount
> option.
> 
> If UTF-8 as iocharset is used then s_nls_iocharset is set to NULL. So
> simplify code around, remove s_utf8 field as to distinguish between UTF-8
> and non-UTF-8 it is needed just to check if s_nls_iocharset is set to NULL
> or not.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I can also take this patch through my tree if you want.

								Honza

> ---
>  fs/isofs/inode.c  | 27 +++++++++++++--------------
>  fs/isofs/isofs.h  |  1 -
>  fs/isofs/joliet.c |  4 +---
>  3 files changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 21edc423b79f..678e2c51b855 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -155,7 +155,6 @@ struct iso9660_options{
>  	unsigned int overriderockperm:1;
>  	unsigned int uid_set:1;
>  	unsigned int gid_set:1;
> -	unsigned int utf8:1;
>  	unsigned char map;
>  	unsigned char check;
>  	unsigned int blocksize;
> @@ -356,7 +355,6 @@ static int parse_options(char *options, struct iso9660_options *popt)
>  	popt->gid = GLOBAL_ROOT_GID;
>  	popt->uid = GLOBAL_ROOT_UID;
>  	popt->iocharset = NULL;
> -	popt->utf8 = 0;
>  	popt->overriderockperm = 0;
>  	popt->session=-1;
>  	popt->sbsector=-1;
> @@ -389,10 +387,13 @@ static int parse_options(char *options, struct iso9660_options *popt)
>  		case Opt_cruft:
>  			popt->cruft = 1;
>  			break;
> +#ifdef CONFIG_JOLIET
>  		case Opt_utf8:
> -			popt->utf8 = 1;
> +			kfree(popt->iocharset);
> +			popt->iocharset = kstrdup("utf8", GFP_KERNEL);
> +			if (!popt->iocharset)
> +				return 0;
>  			break;
> -#ifdef CONFIG_JOLIET
>  		case Opt_iocharset:
>  			kfree(popt->iocharset);
>  			popt->iocharset = match_strdup(&args[0]);
> @@ -495,7 +496,6 @@ static int isofs_show_options(struct seq_file *m, struct dentry *root)
>  	if (sbi->s_nocompress)		seq_puts(m, ",nocompress");
>  	if (sbi->s_overriderockperm)	seq_puts(m, ",overriderockperm");
>  	if (sbi->s_showassoc)		seq_puts(m, ",showassoc");
> -	if (sbi->s_utf8)		seq_puts(m, ",utf8");
>  
>  	if (sbi->s_check)		seq_printf(m, ",check=%c", sbi->s_check);
>  	if (sbi->s_mapping)		seq_printf(m, ",map=%c", sbi->s_mapping);
> @@ -518,9 +518,10 @@ static int isofs_show_options(struct seq_file *m, struct dentry *root)
>  		seq_printf(m, ",fmode=%o", sbi->s_fmode);
>  
>  #ifdef CONFIG_JOLIET
> -	if (sbi->s_nls_iocharset &&
> -	    strcmp(sbi->s_nls_iocharset->charset, CONFIG_NLS_DEFAULT) != 0)
> +	if (sbi->s_nls_iocharset)
>  		seq_printf(m, ",iocharset=%s", sbi->s_nls_iocharset->charset);
> +	else
> +		seq_puts(m, ",iocharset=utf8");
>  #endif
>  	return 0;
>  }
> @@ -863,14 +864,13 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
>  	sbi->s_nls_iocharset = NULL;
>  
>  #ifdef CONFIG_JOLIET
> -	if (joliet_level && opt.utf8 == 0) {
> +	if (joliet_level) {
>  		char *p = opt.iocharset ? opt.iocharset : CONFIG_NLS_DEFAULT;
> -		sbi->s_nls_iocharset = load_nls(p);
> -		if (! sbi->s_nls_iocharset) {
> -			/* Fail only if explicit charset specified */
> -			if (opt.iocharset)
> +		if (strcmp(p, "utf8") != 0) {
> +			sbi->s_nls_iocharset = opt.iocharset ?
> +				load_nls(opt.iocharset) : load_nls_default();
> +			if (!sbi->s_nls_iocharset)
>  				goto out_freesbi;
> -			sbi->s_nls_iocharset = load_nls_default();
>  		}
>  	}
>  #endif
> @@ -886,7 +886,6 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
>  	sbi->s_gid = opt.gid;
>  	sbi->s_uid_set = opt.uid_set;
>  	sbi->s_gid_set = opt.gid_set;
> -	sbi->s_utf8 = opt.utf8;
>  	sbi->s_nocompress = opt.nocompress;
>  	sbi->s_overriderockperm = opt.overriderockperm;
>  	/*
> diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
> index 055ec6c586f7..dcdc191ed183 100644
> --- a/fs/isofs/isofs.h
> +++ b/fs/isofs/isofs.h
> @@ -44,7 +44,6 @@ struct isofs_sb_info {
>  	unsigned char s_session;
>  	unsigned int  s_high_sierra:1;
>  	unsigned int  s_rock:2;
> -	unsigned int  s_utf8:1;
>  	unsigned int  s_cruft:1; /* Broken disks with high byte of length
>  				  * containing junk */
>  	unsigned int  s_nocompress:1;
> diff --git a/fs/isofs/joliet.c b/fs/isofs/joliet.c
> index be8b6a9d0b92..c0f04a1e7f69 100644
> --- a/fs/isofs/joliet.c
> +++ b/fs/isofs/joliet.c
> @@ -41,14 +41,12 @@ uni16_to_x8(unsigned char *ascii, __be16 *uni, int len, struct nls_table *nls)
>  int
>  get_joliet_filename(struct iso_directory_record * de, unsigned char *outname, struct inode * inode)
>  {
> -	unsigned char utf8;
>  	struct nls_table *nls;
>  	unsigned char len = 0;
>  
> -	utf8 = ISOFS_SB(inode->i_sb)->s_utf8;
>  	nls = ISOFS_SB(inode->i_sb)->s_nls_iocharset;
>  
> -	if (utf8) {
> +	if (!nls) {
>  		len = utf16s_to_utf8s((const wchar_t *) de->name,
>  				de->name_len[0] >> 1, UTF16_BIG_ENDIAN,
>  				outname, PAGE_SIZE);
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
