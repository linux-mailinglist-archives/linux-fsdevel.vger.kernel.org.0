Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B1B419F48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 21:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbhI0Tk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 15:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhI0Tk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 15:40:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4224C061575;
        Mon, 27 Sep 2021 12:39:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y28so81813120lfb.0;
        Mon, 27 Sep 2021 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lQhqwgKc+3MgcNnjasbAchY3FY8i0ZMRACEKim1a6VQ=;
        b=gM3NwiYFMI4MN2z1ChxIAIDTULrVWvBiZJN/5cJvuqiF5WUVmD/+pxfMoSZFmljLPy
         ceoVeG0KYybOnirBpgJEPyCE8JySJEJ5ZYfvMu2sE2mFEaK/5tLm3T3PUdOlqC2N8iVC
         EOzc1H1ymVRlW3nU6CO8agRrVi9Om3p4aSoOGMh7N4ewCnPdjzgIC7eDnK28d/816TFz
         XNGJsCqOGOx5DK+xtIs7O6HpfyDk8GMwFCZN4xzYEXvyi9fW354Po3zGyL7OwUjVNfxS
         Qj75v8hp7FILuKJpnzvZdL203PN/+tXYj5kD6vwzlf352IASqJTDHC4vvBAiz/0fSQMc
         reDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lQhqwgKc+3MgcNnjasbAchY3FY8i0ZMRACEKim1a6VQ=;
        b=L7sh+LBWuQuC7DjctrVdEeX0a+hjtq1fKxnXgERoZ5SkscyMz3OEvSrCthyIQoqAN0
         AInK3P4pJ/s9NdrJFW7yMAQGUJnXaszIiVAI9NKK9Tx4fZtqvezXzIV8lOULU/gAL6gG
         An6jAooDLbvKQOJEywG0IxC2k7ixq5qcaWHn89+BinKnuBrQFNnir+5HRDW5xaIp1Qw5
         fUf4wgegGjppFDoXm5YI0jfhoK4dFsgMmBs+KFbN0mAKgmwWXlE8YgXK8nOf+Mp9mUyX
         yY96D7iuYgSMvf86BYUfHiU6LlBzyFdfA5o8lsv0irGiM7SowplyNR40SRaurDP4/f3k
         Bmfw==
X-Gm-Message-State: AOAM533foJamAUYrBppH0HwrfKUzgWH4euCvNu4UveHA66K0M4VFCc/U
        5qN0Ulv1FpDGiWofqMEb2jcTrjIUIzE=
X-Google-Smtp-Source: ABdhPJz04abIHMOQQkApaNgKaDil76rU8yGuSAgzhZE2rkkRulp2hByvcV1AI0Va8Y/cW3sJrGd4/g==
X-Received: by 2002:a19:c145:: with SMTP id r66mr1472825lff.563.1632771557260;
        Mon, 27 Sep 2021 12:39:17 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id f26sm2089980ljj.82.2021.09.27.12.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 12:39:16 -0700 (PDT)
Date:   Mon, 27 Sep 2021 22:39:15 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        joe@perches.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fs/ntfs3: Refactoring of ntfs_set_ea
Message-ID: <20210927193915.a6yexhkgfqt23bim@kari-VirtualBox>
References: <a1204ce8-80e6-bf44-e7d1-f1674ff28dcd@paragon-software.com>
 <eeaa59a8-4ca1-9392-69f9-e3179a75de75@paragon-software.com>
 <20210927192236.3s75h74aglrpg3s2@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927192236.3s75h74aglrpg3s2@kari-VirtualBox>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Joe's address was wrong. Just resend.

On Mon, Sep 27, 2021 at 10:22:36PM +0300, Kari Argillander wrote:
> On Mon, Sep 27, 2021 at 06:28:37PM +0300, Konstantin Komarov wrote:
> > Make code more readable.
> > Don't try to read zero bytes.
> > Add warning when size of exteneded attribute exceeds limit.
> > Thanks Joe Perches <joe@perches.com> for help.
> 
> Usually if someone review and suggest something small do not add this
> kind of line to commit message. Also you need permission to add this. It
> us same kind of situation when we add suggested-by tag. Linux
> documentation stated that it cannot be there if we do not have
> permission from other.
> 
> Also at least add that person email 'to line'. Sometimes if someone make
> huge impact to patch you can ask and add this kind of line. But then
> again it might make more sense to add it suggested or even signed off
> tag depending in situation.
> 
> It can stay if Joe says it is ok.
> 
> > 
> > Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > ---
> >  fs/ntfs3/xattr.c | 31 +++++++++++++++++--------------
> >  1 file changed, 17 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> > index 1ab109723b10..5023d6f7e671 100644
> > --- a/fs/ntfs3/xattr.c
> > +++ b/fs/ntfs3/xattr.c
> > @@ -75,6 +75,7 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
> >  			size_t add_bytes, const struct EA_INFO **info)
> >  {
> >  	int err;
> > +	struct ntfs_sb_info *sbi = ni->mi.sbi;
> >  	struct ATTR_LIST_ENTRY *le = NULL;
> >  	struct ATTRIB *attr_info, *attr_ea;
> >  	void *ea_p;
> > @@ -99,10 +100,10 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
> >  
> >  	/* Check Ea limit. */
> >  	size = le32_to_cpu((*info)->size);
> > -	if (size > ni->mi.sbi->ea_max_size)
> > +	if (size > sbi->ea_max_size)
> >  		return -EFBIG;
> >  
> > -	if (attr_size(attr_ea) > ni->mi.sbi->ea_max_size)
> > +	if (attr_size(attr_ea) > sbi->ea_max_size)
> >  		return -EFBIG;
> >  
> >  	/* Allocate memory for packed Ea. */
> > @@ -110,15 +111,16 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
> >  	if (!ea_p)
> >  		return -ENOMEM;
> >  
> > -	if (attr_ea->non_res) {
> > +	if (!size) {
> > +		;
> > +	} else if (attr_ea->non_res) {
> >  		struct runs_tree run;
> >  
> >  		run_init(&run);
> >  
> >  		err = attr_load_runs(attr_ea, ni, &run, NULL);
> >  		if (!err)
> > -			err = ntfs_read_run_nb(ni->mi.sbi, &run, 0, ea_p, size,
> > -					       NULL);
> > +			err = ntfs_read_run_nb(sbi, &run, 0, ea_p, size, NULL);
> >  		run_close(&run);
> >  
> >  		if (err)
> > @@ -366,21 +368,22 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
> >  	new_ea->name[name_len] = 0;
> >  	memcpy(new_ea->name + name_len + 1, value, val_size);
> >  	new_pack = le16_to_cpu(ea_info.size_pack) + packed_ea_size(new_ea);
> > -
> > -	/* Should fit into 16 bits. */
> > -	if (new_pack > 0xffff) {
> > -		err = -EFBIG; // -EINVAL?
> > -		goto out;
> > -	}
> >  	ea_info.size_pack = cpu_to_le16(new_pack);
> > -
> >  	/* New size of ATTR_EA. */
> >  	size += add;
> > -	if (size > sbi->ea_max_size) {
> > +	ea_info.size = cpu_to_le32(size);
> > +
> > +	/*
> > +	 * 1. Check ea_info.size_pack for overflow.
> > +	 * 2. New attibute size must fit value from $AttrDef
> > +	 */
> > +	if (new_pack > 0xffff || size > sbi->ea_max_size) {
> > +		ntfs_inode_warn(
> > +			inode,
> > +			"The size of extended attributes must not exceed 64KiB");
> >  		err = -EFBIG; // -EINVAL?
> >  		goto out;
> >  	}
> > -	ea_info.size = cpu_to_le32(size);
> >  
> >  update_ea:
> >  
> > -- 
> > 2.33.0
> > 
> > 
