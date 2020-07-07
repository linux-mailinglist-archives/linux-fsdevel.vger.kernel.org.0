Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6772F2164D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 05:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgGGDtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 23:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgGGDtt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:49:49 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28BEE2053B;
        Tue,  7 Jul 2020 03:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594093788;
        bh=FQkOsZPnEgmAxG8A6T3ibW42eaK1EOzMrxi6QiQ7hxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXqnhlHg9ULR5J3IcMg0VNJvIlSI8RMLOHJggSBT2o7xvx7C37cU1vlHOg349ABq1
         RuSD8BwRH+L8Ytd02B7GCJDfzl9pg8rLQGXJEhGAE8FvKjLtF0pErfwUQgG1XxuvqA
         SRtbfSOhvBP9VdlMSbIoZPdlN4nlnemLmK5K8z2U=
Date:   Mon, 6 Jul 2020 20:49:47 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Aravind Ramesh <Aravind.Ramesh@wdc.com>
Cc:     "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "hch@lst.de" <hch@lst.de>, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 1/2] f2fs: support zone capacity less than zone size
Message-ID: <20200707034947.GA3142230@google.com>
References: <20200702155401.13322-1-aravind.ramesh@wdc.com>
 <20200702155401.13322-2-aravind.ramesh@wdc.com>
 <20200707000722.GB2897553@google.com>
 <BY5PR04MB6995E03B6FE331FF0CDEE7AD8C660@BY5PR04MB6995.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR04MB6995E03B6FE331FF0CDEE7AD8C660@BY5PR04MB6995.namprd04.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/07, Aravind Ramesh wrote:
> Hello Jaegeuk,
> 
> I had mentioned the dependency in the cover letter for this patch, as below.
> 
> This series is based on the git tree
> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git branch dev
> 
> and requires the below patch in order to build.
> 
> https://lore.kernel.org/linux-nvme/20200701063720.GA28954@lst.de/T/#m19e0197ae1837b7fe959b13fbc2a859b1f2abc1e
> 
> The above patch has been merged to the nvme-5.9 branch in the git tree:
> git://git.infradead.org/nvme.git
> 
> Could you consider picking up that patch in your tree ?
> 
> I have run checkpatch before sending this, it was ok. Ran it again.

I see. I don't have any device, so have to rely on your tests as usual.
Thank you for posting the patch, and will check any regression.

> 
> f2fs$ scripts/checkpatch.pl ./0001-f2fs-support-zone-capacity-less-than-zone-size.patch
> total: 0 errors, 0 warnings, 289 lines checked
> 
> ./0001-f2fs-support-zone-capacity-less-than-zone-size.patch has no obvious style problems and is ready for submission.
> 
> Thanks,
> Aravind
> 
> > -----Original Message-----
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Sent: Tuesday, July 7, 2020 5:37 AM
> > To: Aravind Ramesh <Aravind.Ramesh@wdc.com>
> > Cc: yuchao0@huawei.com; linux-fsdevel@vger.kernel.org; linux-f2fs-
> > devel@lists.sourceforge.net; hch@lst.de; Damien Le Moal
> > <Damien.LeMoal@wdc.com>; Niklas Cassel <Niklas.Cassel@wdc.com>; Matias
> > Bjorling <Matias.Bjorling@wdc.com>
> > Subject: Re: [PATCH 1/2] f2fs: support zone capacity less than zone size
> > 
> > Hi,
> > 
> > Is there any dependency to the patch? And, could you please run checkpatch script?
> > 
> > Thanks,
> > 
> > On 07/02, Aravind Ramesh wrote:
> > > NVMe Zoned Namespace devices can have zone-capacity less than zone-size.
> > > Zone-capacity indicates the maximum number of sectors that are usable
> > > in a zone beginning from the first sector of the zone. This makes the
> > > sectors sectors after the zone-capacity till zone-size to be unusable.
> > > This patch set tracks zone-size and zone-capacity in zoned devices and
> > > calculate the usable blocks per segment and usable segments per section.
> > >
> > > If zone-capacity is less than zone-size mark only those segments which
> > > start before zone-capacity as free segments. All segments at and
> > > beyond zone-capacity are treated as permanently used segments. In
> > > cases where zone-capacity does not align with segment size the last
> > > segment will start before zone-capacity and end beyond the
> > > zone-capacity of the zone. For such spanning segments only sectors within the
> > zone-capacity are used.
> > >
> > > Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> > > Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > ---
> > >  fs/f2fs/f2fs.h    |   5 ++
> > >  fs/f2fs/segment.c | 136
> > ++++++++++++++++++++++++++++++++++++++++++++--
> > >  fs/f2fs/segment.h |   6 +-
> > >  fs/f2fs/super.c   |  41 ++++++++++++--
> > >  4 files changed, 176 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index
> > > e6e47618a357..73219e4e1ba4 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -1232,6 +1232,7 @@ struct f2fs_dev_info {  #ifdef
> > > CONFIG_BLK_DEV_ZONED
> > >  	unsigned int nr_blkz;		/* Total number of zones */
> > >  	unsigned long *blkz_seq;	/* Bitmap indicating sequential zones */
> > > +	block_t *zone_capacity_blocks;  /* Array of zone capacity in blks */
> > >  #endif
> > >  };
> > >
> > > @@ -3395,6 +3396,10 @@ void f2fs_destroy_segment_manager_caches(void);
> > >  int f2fs_rw_hint_to_seg_type(enum rw_hint hint);  enum rw_hint
> > > f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
> > >  			enum page_type type, enum temp_type temp);
> > > +unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> > > +			unsigned int segno);
> > > +unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> > > +			unsigned int segno);
> > >
> > >  /*
> > >   * checkpoint.c
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c index
> > > c35614d255e1..d2156f3f56a5 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -4294,9 +4294,12 @@ static void init_free_segmap(struct
> > > f2fs_sb_info *sbi)  {
> > >  	unsigned int start;
> > >  	int type;
> > > +	struct seg_entry *sentry;
> > >
> > >  	for (start = 0; start < MAIN_SEGS(sbi); start++) {
> > > -		struct seg_entry *sentry = get_seg_entry(sbi, start);
> > > +		if (f2fs_usable_blks_in_seg(sbi, start) == 0)
> > > +			continue;
> > > +		sentry = get_seg_entry(sbi, start);
> > >  		if (!sentry->valid_blocks)
> > >  			__set_free(sbi, start);
> > >  		else
> > > @@ -4316,7 +4319,7 @@ static void init_dirty_segmap(struct f2fs_sb_info *sbi)
> > >  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> > >  	struct free_segmap_info *free_i = FREE_I(sbi);
> > >  	unsigned int segno = 0, offset = 0, secno;
> > > -	unsigned short valid_blocks;
> > > +	unsigned short valid_blocks, usable_blks_in_seg;
> > >  	unsigned short blks_per_sec = BLKS_PER_SEC(sbi);
> > >
> > >  	while (1) {
> > > @@ -4326,9 +4329,10 @@ static void init_dirty_segmap(struct f2fs_sb_info *sbi)
> > >  			break;
> > >  		offset = segno + 1;
> > >  		valid_blocks = get_valid_blocks(sbi, segno, false);
> > > -		if (valid_blocks == sbi->blocks_per_seg || !valid_blocks)
> > > +		usable_blks_in_seg = f2fs_usable_blks_in_seg(sbi, segno);
> > > +		if (valid_blocks == usable_blks_in_seg || !valid_blocks)
> > >  			continue;
> > > -		if (valid_blocks > sbi->blocks_per_seg) {
> > > +		if (valid_blocks > usable_blks_in_seg) {
> > >  			f2fs_bug_on(sbi, 1);
> > >  			continue;
> > >  		}
> > > @@ -4678,6 +4682,101 @@ int f2fs_check_write_pointer(struct
> > > f2fs_sb_info *sbi)
> > >
> > >  	return 0;
> > >  }
> > > +
> > > +static bool is_conv_zone(struct f2fs_sb_info *sbi, unsigned int zone_idx,
> > > +						unsigned int dev_idx)
> > > +{
> > > +	if (!bdev_is_zoned(FDEV(dev_idx).bdev))
> > > +		return true;
> > > +	return !test_bit(zone_idx, FDEV(dev_idx).blkz_seq); }
> > > +
> > > +/* Return the zone index in the given device */ static unsigned int
> > > +get_zone_idx(struct f2fs_sb_info *sbi, unsigned int secno,
> > > +					int dev_idx)
> > > +{
> > > +	block_t sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi,
> > > +secno));
> > > +
> > > +	return (sec_start_blkaddr - FDEV(dev_idx).start_blk) >>
> > > +						sbi->log_blocks_per_blkz;
> > > +}
> > > +
> > > +/*
> > > + * Return the usable segments in a section based on the zone's
> > > + * corresponding zone capacity. Zone is equal to a section.
> > > + */
> > > +static inline unsigned int f2fs_usable_zone_segs_in_sec(
> > > +		struct f2fs_sb_info *sbi, unsigned int segno) {
> > > +	unsigned int dev_idx, zone_idx, unusable_segs_in_sec;
> > > +
> > > +	dev_idx = f2fs_target_device_index(sbi, START_BLOCK(sbi, segno));
> > > +	zone_idx = get_zone_idx(sbi, GET_SEC_FROM_SEG(sbi, segno), dev_idx);
> > > +
> > > +	/* Conventional zone's capacity is always equal to zone size */
> > > +	if (is_conv_zone(sbi, zone_idx, dev_idx))
> > > +		return sbi->segs_per_sec;
> > > +
> > > +	/*
> > > +	 * If the zone_capacity_blocks array is NULL, then zone capacity
> > > +	 * is equal to the zone size for all zones
> > > +	 */
> > > +	if (!FDEV(dev_idx).zone_capacity_blocks)
> > > +		return sbi->segs_per_sec;
> > > +
> > > +	/* Get the segment count beyond zone capacity block */
> > > +	unusable_segs_in_sec = (sbi->blocks_per_blkz -
> > > +				FDEV(dev_idx).zone_capacity_blocks[zone_idx])
> > >>
> > > +				sbi->log_blocks_per_seg;
> > > +	return sbi->segs_per_sec - unusable_segs_in_sec; }
> > > +
> > > +/*
> > > + * Return the number of usable blocks in a segment. The number of
> > > +blocks
> > > + * returned is always equal to the number of blocks in a segment for
> > > + * segments fully contained within a sequential zone capacity or a
> > > + * conventional zone. For segments partially contained in a
> > > +sequential
> > > + * zone capacity, the number of usable blocks up to the zone capacity
> > > + * is returned. 0 is returned in all other cases.
> > > + */
> > > +static inline unsigned int f2fs_usable_zone_blks_in_seg(
> > > +			struct f2fs_sb_info *sbi, unsigned int segno) {
> > > +	block_t seg_start, sec_start_blkaddr, sec_cap_blkaddr;
> > > +	unsigned int zone_idx, dev_idx, secno;
> > > +
> > > +	secno = GET_SEC_FROM_SEG(sbi, segno);
> > > +	seg_start = START_BLOCK(sbi, segno);
> > > +	dev_idx = f2fs_target_device_index(sbi, seg_start);
> > > +	zone_idx = get_zone_idx(sbi, secno, dev_idx);
> > > +
> > > +	/*
> > > +	 * Conventional zone's capacity is always equal to zone size,
> > > +	 * so, blocks per segment is unchanged.
> > > +	 */
> > > +	if (is_conv_zone(sbi, zone_idx, dev_idx))
> > > +		return sbi->blocks_per_seg;
> > > +
> > > +	if (!FDEV(dev_idx).zone_capacity_blocks)
> > > +		return sbi->blocks_per_seg;
> > > +
> > > +	sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
> > > +	sec_cap_blkaddr = sec_start_blkaddr +
> > > +				FDEV(dev_idx).zone_capacity_blocks[zone_idx];
> > > +
> > > +	/*
> > > +	 * If segment starts before zone capacity and spans beyond
> > > +	 * zone capacity, then usable blocks are from seg start to
> > > +	 * zone capacity. If the segment starts after the zone capacity,
> > > +	 * then there are no usable blocks.
> > > +	 */
> > > +	if (seg_start >= sec_cap_blkaddr)
> > > +		return 0;
> > > +	if (seg_start + sbi->blocks_per_seg > sec_cap_blkaddr)
> > > +		return sec_cap_blkaddr - seg_start;
> > > +
> > > +	return sbi->blocks_per_seg;
> > > +}
> > >  #else
> > >  int f2fs_fix_curseg_write_pointer(struct f2fs_sb_info *sbi)  { @@
> > > -4688,7 +4787,36 @@ int f2fs_check_write_pointer(struct f2fs_sb_info
> > > *sbi)  {
> > >  	return 0;
> > >  }
> > > +
> > > +static inline unsigned int f2fs_usable_zone_blks_in_seg(struct f2fs_sb_info *sbi,
> > > +							unsigned int segno)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static inline unsigned int f2fs_usable_zone_segs_in_sec(struct f2fs_sb_info *sbi,
> > > +							unsigned int segno)
> > > +{
> > > +	return 0;
> > > +}
> > >  #endif
> > > +unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> > > +					unsigned int segno)
> > > +{
> > > +	if (f2fs_sb_has_blkzoned(sbi))
> > > +		return f2fs_usable_zone_blks_in_seg(sbi, segno);
> > > +
> > > +	return sbi->blocks_per_seg;
> > > +}
> > > +
> > > +unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> > > +					unsigned int segno)
> > > +{
> > > +	if (f2fs_sb_has_blkzoned(sbi))
> > > +		return f2fs_usable_zone_segs_in_sec(sbi, segno);
> > > +
> > > +	return sbi->segs_per_sec;
> > > +}
> > >
> > >  /*
> > >   * Update min, max modified time for cost-benefit GC algorithm diff
> > > --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h index
> > > f261e3e6a69b..79b0dc33feaf 100644
> > > --- a/fs/f2fs/segment.h
> > > +++ b/fs/f2fs/segment.h
> > > @@ -411,6 +411,7 @@ static inline void __set_free(struct f2fs_sb_info *sbi,
> > unsigned int segno)
> > >  	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
> > >  	unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
> > >  	unsigned int next;
> > > +	unsigned int usable_segs = f2fs_usable_segs_in_sec(sbi, segno);
> > >
> > >  	spin_lock(&free_i->segmap_lock);
> > >  	clear_bit(segno, free_i->free_segmap); @@ -418,7 +419,7 @@ static
> > > inline void __set_free(struct f2fs_sb_info *sbi, unsigned int segno)
> > >
> > >  	next = find_next_bit(free_i->free_segmap,
> > >  			start_segno + sbi->segs_per_sec, start_segno);
> > > -	if (next >= start_segno + sbi->segs_per_sec) {
> > > +	if (next >= start_segno + usable_segs) {
> > >  		clear_bit(secno, free_i->free_secmap);
> > >  		free_i->free_sections++;
> > >  	}
> > > @@ -444,6 +445,7 @@ static inline void __set_test_and_free(struct f2fs_sb_info
> > *sbi,
> > >  	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
> > >  	unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
> > >  	unsigned int next;
> > > +	unsigned int usable_segs = f2fs_usable_segs_in_sec(sbi, segno);
> > >
> > >  	spin_lock(&free_i->segmap_lock);
> > >  	if (test_and_clear_bit(segno, free_i->free_segmap)) { @@ -453,7
> > > +455,7 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
> > >  			goto skip_free;
> > >  		next = find_next_bit(free_i->free_segmap,
> > >  				start_segno + sbi->segs_per_sec, start_segno);
> > > -		if (next >= start_segno + sbi->segs_per_sec) {
> > > +		if (next >= start_segno + usable_segs) {
> > >  			if (test_and_clear_bit(secno, free_i->free_secmap))
> > >  				free_i->free_sections++;
> > >  		}
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c index
> > > 80cb7cd358f8..2686b07ae7eb 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -1164,6 +1164,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
> > >  		blkdev_put(FDEV(i).bdev, FMODE_EXCL);  #ifdef
> > CONFIG_BLK_DEV_ZONED
> > >  		kvfree(FDEV(i).blkz_seq);
> > > +		kvfree(FDEV(i).zone_capacity_blocks);
> > >  #endif
> > >  	}
> > >  	kvfree(sbi->devs);
> > > @@ -3039,13 +3040,26 @@ static int init_percpu_info(struct
> > > f2fs_sb_info *sbi)  }
> > >
> > >  #ifdef CONFIG_BLK_DEV_ZONED
> > > +
> > > +struct f2fs_report_zones_args {
> > > +	struct f2fs_dev_info *dev;
> > > +	bool zone_cap_mismatch;
> > > +};
> > > +
> > >  static int f2fs_report_zone_cb(struct blk_zone *zone, unsigned int idx,
> > > -			       void *data)
> > > +			      void *data)
> > >  {
> > > -	struct f2fs_dev_info *dev = data;
> > > +	struct f2fs_report_zones_args *rz_args = data;
> > > +
> > > +	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
> > > +		return 0;
> > > +
> > > +	set_bit(idx, rz_args->dev->blkz_seq);
> > > +	rz_args->dev->zone_capacity_blocks[idx] = zone->capacity >>
> > > +						F2FS_LOG_SECTORS_PER_BLOCK;
> > > +	if (zone->len != zone->capacity && !rz_args->zone_cap_mismatch)
> > > +		rz_args->zone_cap_mismatch = true;
> > >
> > > -	if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL)
> > > -		set_bit(idx, dev->blkz_seq);
> > >  	return 0;
> > >  }
> > >
> > > @@ -3053,6 +3067,7 @@ static int init_blkz_info(struct f2fs_sb_info
> > > *sbi, int devi)  {
> > >  	struct block_device *bdev = FDEV(devi).bdev;
> > >  	sector_t nr_sectors = bdev->bd_part->nr_sects;
> > > +	struct f2fs_report_zones_args rep_zone_arg;
> > >  	int ret;
> > >
> > >  	if (!f2fs_sb_has_blkzoned(sbi))
> > > @@ -3078,12 +3093,26 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int
> > devi)
> > >  	if (!FDEV(devi).blkz_seq)
> > >  		return -ENOMEM;
> > >
> > > -	/* Get block zones type */
> > > +	/* Get block zones type and zone-capacity */
> > > +	FDEV(devi).zone_capacity_blocks = f2fs_kzalloc(sbi,
> > > +					FDEV(devi).nr_blkz * sizeof(block_t),
> > > +					GFP_KERNEL);
> > > +	if (!FDEV(devi).zone_capacity_blocks)
> > > +		return -ENOMEM;
> > > +
> > > +	rep_zone_arg.dev = &FDEV(devi);
> > > +	rep_zone_arg.zone_cap_mismatch = false;
> > > +
> > >  	ret = blkdev_report_zones(bdev, 0, BLK_ALL_ZONES, f2fs_report_zone_cb,
> > > -				  &FDEV(devi));
> > > +				  &rep_zone_arg);
> > >  	if (ret < 0)
> > >  		return ret;
> > >
> > > +	if (!rep_zone_arg.zone_cap_mismatch) {
> > > +		kvfree(FDEV(devi).zone_capacity_blocks);
> > > +		FDEV(devi).zone_capacity_blocks = NULL;
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >  #endif
> > > --
> > > 2.19.1
