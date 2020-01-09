Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B8E1359B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 14:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgAINIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 08:08:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33277 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbgAINIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:08:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so7399348wrq.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2020 05:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B/hZ/MJPBl7pA615/pT9WNDuOx9msIPABsSiAQcUiAE=;
        b=aPvO1xkp7/jsDA6zSifuO78xte9Hp8z2Qf9gYghA97GumrVLts87+2RIg7G0PLp4PV
         bN0KWxmi8fYNDB9Tn7X7minxUikwUVHz90rvfg8SdyfdEv4XMjamaHMQGixwbEaS90Dp
         3fzpdnAvbrsefPbCOR7YqPqQxcxnCcjX/Csad//p0cS7jkvThqrN31qd5zKdGjBtm0/8
         9C0aVDkDBjmpGMYSxTbqh4BM+hcNyhBYg6y9CEYHLcWqt/7+Lq/AFBIvDodhPWRURgtT
         NrmOhNbgHBzG2dhB2ZYvtHKaDN/aJ77ZPSuJA9Hj/R/DYt3tUy+2Vz5OiNM+allOCDOA
         XmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B/hZ/MJPBl7pA615/pT9WNDuOx9msIPABsSiAQcUiAE=;
        b=ivFRha2fnrPEi9ixgs01a9EfvKkv8Gptj7vbmUWyRmnEXgo1/qu4L7KB6pV4A8a9bK
         Avb9AoMIpP2Gd+t0kVxGS8KT+MlSrAz/lBS112eLtuw6mWRgmgJpwN7IUEzJuYAfC/sI
         vc7jQKOHVXYgiarLqAk8hUQevWuOOJOke90YtE8xWAkF7BoyVkb0C9v3nLCwPGRAh7m9
         t9+uZmJQuMNsMhfiGV+6nS10yDejMl58ZdjcRKkBazWLVgn/GRoxLehzcePHA5cN8N9D
         Nuiy+Kg5BJsHkhnM4eHOM8+xdCnSbjLgvX0oplKOjaS4DJBX2pnMpePJHcoTEtOwWMog
         TDVg==
X-Gm-Message-State: APjAAAVZ54XD7Uo2ne9aIuEFoe/VYs7bsgTgky22Ej5nosk64/ycf/mA
        Nn13p/flycPkq+o4cz8b43WlATxP
X-Google-Smtp-Source: APXvYqxs0vh9fJd2ELfC8Cxm6rquz978L3K7FNRlOc+R4OaIBTT/E49JEbgPVuXRG6ZCB7fvzIcU5w==
X-Received: by 2002:adf:ea05:: with SMTP id q5mr11081251wrm.48.1578575318720;
        Thu, 09 Jan 2020 05:08:38 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v8sm7962088wrw.2.2020.01.09.05.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 05:08:38 -0800 (PST)
Date:   Thu, 9 Jan 2020 14:08:37 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] udf: Fix free space reporting for metadata and virtual
 partitions
Message-ID: <20200109130837.b6f62jpeb3myns64@pali>
References: <20200108121919.12343-1-jack@suse.cz>
 <20200108223240.gi5g2jza3rxuzk6z@pali>
 <20200109124405.GE22232@quack2.suse.cz>
 <20200109125657.ir264jcd6oujox3a@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200109125657.ir264jcd6oujox3a@pali>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 09 January 2020 13:56:57 Pali Rohár wrote:
> On Thursday 09 January 2020 13:44:05 Jan Kara wrote:
> > On Wed 08-01-20 23:32:40, Pali Rohár wrote:
> > > On Wednesday 08 January 2020 13:19:19 Jan Kara wrote:
> > > > Free space on filesystems with metadata or virtual partition maps
> > > > currently gets misreported. This is because these partitions are just
> > > > remapped onto underlying real partitions from which keep track of free
> > > > blocks. Take this remapping into account when counting free blocks as
> > > > well.
> > > > 
> > > > Reported-by: Pali Rohár <pali.rohar@gmail.com>
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >  fs/udf/super.c | 19 ++++++++++++++-----
> > > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > > > 
> > > > I plan to take this patch to my tree.
> > > > 
> > > > diff --git a/fs/udf/super.c b/fs/udf/super.c
> > > > index 8c28e93e9b73..b89e420a4b85 100644
> > > > --- a/fs/udf/super.c
> > > > +++ b/fs/udf/super.c
> > > > @@ -2492,17 +2492,26 @@ static unsigned int udf_count_free_table(struct super_block *sb,
> > > >  static unsigned int udf_count_free(struct super_block *sb)
> > > >  {
> > > >  	unsigned int accum = 0;
> > > > -	struct udf_sb_info *sbi;
> > > > +	struct udf_sb_info *sbi = UDF_SB(sb);
> > > >  	struct udf_part_map *map;
> > > > +	unsigned int part = sbi->s_partition;
> > > > +	int ptype = sbi->s_partmaps[part].s_partition_type;
> > > > +
> > > > +	if (ptype == UDF_METADATA_MAP25) {
> > > > +		part = sbi->s_partmaps[part].s_type_specific.s_metadata.
> > > > +							s_phys_partition_ref;
> > > > +	} else if (ptype == UDF_VIRTUAL_MAP15 || ptype == UDF_VIRTUAL_MAP20) {
> > > > +		part = UDF_I(sbi->s_vat_inode)->i_location.
> > > > +							partitionReferenceNum;
> > > 
> > > Hello! I do not think that it make sense to report "free blocks" for
> > > discs with Virtual partition. By definition of VAT, all blocks prior to
> > > VAT are already "read-only" and therefore these blocks cannot be use for
> > > writing new data by any implementation. And because VAT is stored on the
> > > last block, in our model all blocks are "occupied".
> > 
> > Fair enough. Let's just always return 0 for disks with VAT partition.
> > 
> > > > +	}
> > > >  
> > > > -	sbi = UDF_SB(sb);
> > > >  	if (sbi->s_lvid_bh) {
> > > >  		struct logicalVolIntegrityDesc *lvid =
> > > >  			(struct logicalVolIntegrityDesc *)
> > > >  			sbi->s_lvid_bh->b_data;
> > > > -		if (le32_to_cpu(lvid->numOfPartitions) > sbi->s_partition) {
> > > > +		if (le32_to_cpu(lvid->numOfPartitions) > part) {
> > > >  			accum = le32_to_cpu(
> > > > -					lvid->freeSpaceTable[sbi->s_partition]);
> > > > +					lvid->freeSpaceTable[part]);
> > > 
> > > And in any case freeSpaceTable should not be used for discs with VAT.
> > > And we should ignore its value for discs with VAT.
> > > 
> > > UDF 2.60 2.2.6.2: Free Space Table values be maintained ... except ...
> > > for a virtual partition ...
> > > 
> > > And same applies for "partition with Access Type pseudo-overwritable".
> > 
> > Well this is handled by the 'accum == 0xffffffff' condition below. So we
> > effectively ignore these values.
> 
> Ok.

Now I'm thinking about another scenario: UDF allows you to have two
partitions of Type1 (physical) on one volume: one with read-only access
type and one with overwritable access type.

UDF 2.60 2.2.6.2 says: For a partition with Access Type read-only, the
Free Space Table value shall be set to zero. And therefore we should
ignore it.

But current implementation for discs without Metadata partition (all
with UDF 2.01) reads free space table (only) from partition

  unsigned int part = sbi->s_partition;

So is this s_partition one with read-only or overwritable access type?

And to make it more complicated, UDF 2.60 2.2.10 requires that such discs
(with two partitions) needs to have also Metadata Partition Map.

> > > >  			if (accum == 0xFFFFFFFF)
> > > >  				accum = 0;
> > > >  		}
> > 
> > 								Honza
> 

-- 
Pali Rohár
pali.rohar@gmail.com
