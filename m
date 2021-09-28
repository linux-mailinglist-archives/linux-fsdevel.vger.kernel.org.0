Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A23F41B584
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 19:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbhI1SAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 14:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhI1SA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:00:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53512C06161C;
        Tue, 28 Sep 2021 10:58:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u18so94115541lfd.12;
        Tue, 28 Sep 2021 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=68p1tAQ5Jz/+Bnsf/d8ssuN60AfPupdQ5Ex9JLDoD9Q=;
        b=hfaJWJijWESeyx+nfAyg/5CUbQMOg6oC23UpLWwtplLtdufQsotDCaAJycNtLSaffX
         YjxDeqXVAQy5as4OgYiRYi10ftKa6jjAkTdZ/Abs64cZYU0EPbo91KF4DZ8ZJBXkgop5
         kpWEBBL+HEAr0STVxrnOdWSU2tBr8D0ck5o7fjE0bAoIzP9vIv0ttESrEpVccQD3VVVq
         E90TES/koWKD2cSkSK54w1qC6G0zBmsCgbSSkWfBaN9RAqf4YxYkWRKstuQQ5vnV2n3z
         qYL45vzUUzXjse7/XHATX0G3f6mAkUZrfVhUpdTjXtY+zXXjEFV4qA9OBR/G/nUI5Ydx
         v0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=68p1tAQ5Jz/+Bnsf/d8ssuN60AfPupdQ5Ex9JLDoD9Q=;
        b=WWZ4cX204uuBeJAFN2e2ApYvNVvihOApuN0gX4TX8QIO8bbtmW5F/LyASvGUq6gSeY
         uTuNa54VZapFsuCE1LlfL6eU762R5XTK2vQwKl7K3NaGfnh1FDBQ5Jq8vEVIC5NpjcZK
         h6DZOulNwBp7hHidNx70V/Wrl6X8sQMUXlKG3jmrSKrQiU/rwJEjVf9qjDcXen72flhU
         1az7TGUVQSJ7lsov3O13G8YxgRn204oj9NLRYzvxGJp/axWEWMGUW8ZlkG6Ig1cZ0LvJ
         xc4KZXn5VyXF+ogXH6ijYVi8R0iApNqx2DbFea0FML7NH4Ys0HOn4+J/aGCkTzMETSLf
         RmuQ==
X-Gm-Message-State: AOAM531VNepvadP52WfJOIB9XsgmrlVT2H16VSU3f7Irvr08w5zv8TSs
        y/OejOyIWI7Kq2sr9eo+xtvkDkXT+tg=
X-Google-Smtp-Source: ABdhPJwHlivlQiRnD5k8IklBc6f4F+Q6oIjddUwg9tGJBV+1ajKB/xsV4QfPlYoGqNrXjBDZUgFa+A==
X-Received: by 2002:a05:651c:178e:: with SMTP id bn14mr1339716ljb.521.1632851927694;
        Tue, 28 Sep 2021 10:58:47 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id j11sm1983386lfu.33.2021.09.28.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 10:58:47 -0700 (PDT)
Date:   Tue, 28 Sep 2021 20:58:45 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs/ntfs3: Reject mount if boot's cluster size <
 media sector size
Message-ID: <20210928175845.ytqj4o4m2e5bsfrr@kari-VirtualBox>
References: <16cbff75-f705-37cb-ad3f-43d433352f6b@paragon-software.com>
 <6036b141-56e2-0d08-b9ff-641c3451f45a@paragon-software.com>
 <20210927185621.2wkznecc4jndja6b@kari-VirtualBox>
 <fbdcbb8f-380c-4da9-2860-a3729c75e04b@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbdcbb8f-380c-4da9-2860-a3729c75e04b@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:21:54PM +0300, Konstantin Komarov wrote:
> 
> 
> On 27.09.2021 21:56, Kari Argillander wrote:
> > On Mon, Sep 27, 2021 at 06:48:00PM +0300, Konstantin Komarov wrote:
> >> If we continue to work in this case, then we can corrupt fs.
> >>
> > 
> > Should have fixes tag.
> > 
> 
> The bug is in initial commit.
> Do I need to write
> Fixes: 82cae269cfa95 "fs/ntfs3: Add initialization of super block"
> ?

Yes, but format is not right. It needs to be 12 letter sha and need
brackets.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")

Just add these to your gitconfig

[core]
	abbrev = 12
[pretty]
	fixes = Fixes: %h (\"%s\")

And after that you can use
	git show -s --pretty=fixes <sha>

You can see also that others have used this same fixes line in commits:

b8155e95de38 ("fs/ntfs3: Fix error handling in indx_insert_into_root()")
8c83a4851da1 ("fs/ntfs3: Potential NULL dereference in hdr_find_split()")
04810f000afd ("fs/ntfs3: Fix error code in indx_add_allocate()")
1263eddfea99 ("fs/ntfs3: Remove unused including <linux/version.h>")
8c01308b6d6b ("fs/ntfs3: Remove unused variable cnt in ntfs_security_init()")
71eeb6ace80b ("fs/ntfs3: Fix integer overflow in multiplication")

The reason for fixes tag is that automatic tools can more easily
cherry-pick things. Kernel stable branches example big these
automatically, but there is also other companys which big these. Also it
is sometimes nice to check commit which introduce this bug. Also some
organization or study might use these for some statics.

> 
> >> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> >> ---
> >>  fs/ntfs3/super.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> >> index 7099d9b1f3aa..193f9a98f6ab 100644
> >> --- a/fs/ntfs3/super.c
> >> +++ b/fs/ntfs3/super.c
> >> @@ -763,9 +763,14 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
> >>  	sbi->mft.lbo = mlcn << sbi->cluster_bits;
> >>  	sbi->mft.lbo2 = mlcn2 << sbi->cluster_bits;
> >>  
> >> +	/* Compare boot's cluster and sector. */
> > 
> > Pretty random obvious comment and I do not know what this does in this
> > patch.
> > 
> >>  	if (sbi->cluster_size < sbi->sector_size)
> >>  		goto out;
> >>  
> >> +	/* Compare boot's cluster and media sector. */
> >> +	if (sbi->cluster_size < sector_size)
> >> +		goto out; /* No way to use ntfs_get_block in this case. */
> > 
> > Usually comment should not go after line. If you take chunk from patch
> > 3/3 then this is not issue.
> > 
> >> +
> >>  	sbi->cluster_mask = sbi->cluster_size - 1;
> >>  	sbi->cluster_mask_inv = ~(u64)sbi->cluster_mask;
> >>  	sbi->record_size = record_size = boot->record_size < 0
> >> -- 
> >> 2.33.0
> >>
> >>
> >>
