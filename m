Return-Path: <linux-fsdevel+bounces-71382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE981CC0B30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 04:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7602A301DE2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 03:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD5D27EFFA;
	Tue, 16 Dec 2025 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGbwrTTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3513AA2F;
	Tue, 16 Dec 2025 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765854973; cv=none; b=c64/1WKfhavdfqi3s8U30lv4GtTP2pwOQS7/DplfbXTyYVMlACiYnZ61mOY751+6P3VjM5u0xli9wOFiMKn6wLWdeEJB1exHh5lqhJ2NNkNjVhfZKB/+11W5dHagN+oIN2xxPR+ZbCu3+bvvnF6HAu2LoWjNTf7wkoyNhDTAN1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765854973; c=relaxed/simple;
	bh=Z7LAXQaV+xdo64VXbtUYTIaKLjpkNKlKQekw/kGSNO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A81moDzfrn/EdoT7d5z2Uf8s6ScKsYU2fEeKBsCMu1LiutBaB/evfQe55AFIw8M5rHnxcwNYZQAOQeOTzwEmr0JLZdrpz8Itka6fFvmThcygHz80bgXFgOwqJeuKWxmDFhS3NZSBlnPWw9ADsHxZoJRhpM4Ou5M+zy8D3UyaUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGbwrTTv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765854971; x=1797390971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z7LAXQaV+xdo64VXbtUYTIaKLjpkNKlKQekw/kGSNO8=;
  b=KGbwrTTvELHvy1ZGDaP3POJ2D5tS8Y/FSlgeHfGeR/VSB5AtzWMRuGhq
   uBsiPVLUx4cPG+fdRQtuNtLqMMo/RvOLOOQB/bcW88N9uMfDneg9cD0gJ
   mzs6NfvmJCZOJBSwV7+jOFEBUvtrYTuhIaMP1hSpWpC7x/0/sjmvfXV6j
   V2gPSNpbMZFLgJ0elJRG1QQYubkmitlykCDKtDNe6T6qFC2ex0QWxid3B
   ipyhH/6vaTdKq24Kryer2QOBBgCJWjpYs4Kw6G1xx9p6RGJAm8SUYAj7M
   bSwV/6vGXFrlWUw6YOmAEHHG2RPRun/0Vn+BFUKDNmSNJw/75WRLkkkdr
   g==;
X-CSE-ConnectionGUID: BGRhErp8QM+PdGjc9M04/A==
X-CSE-MsgGUID: 6OT/glS5Rr65tKp1MCSJSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67838588"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="67838588"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 19:16:10 -0800
X-CSE-ConnectionGUID: Cluc8MxxQ5WvjiHGotn3Qw==
X-CSE-MsgGUID: 9tLsIoDGT9GRN8e8idZFMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="197643425"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by orviesa009.jf.intel.com with ESMTP; 15 Dec 2025 19:16:09 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVLXi-000000002ue-0vzs;
	Tue, 16 Dec 2025 03:16:06 +0000
Date: Tue, 16 Dec 2025 04:16:05 +0100
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 8/9] blk-crypto: optimize data unit alignment checking
Message-ID: <202512160419.nTnYWVyJ-lkp@intel.com>
References: <20251210152343.3666103-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210152343.3666103-9-hch@lst.de>

Hi Christoph,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev brauner-vfs/vfs.all next-20251216]
[cannot apply to tytso-ext4/dev linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/fscrypt-keep-multiple-bios-in-flight-in-fscrypt_zeroout_range_inline_crypt/20251211-002354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20251210152343.3666103-9-hch%40lst.de
patch subject: [PATCH 8/9] blk-crypto: optimize data unit alignment checking
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20251216/202512160419.nTnYWVyJ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251216/202512160419.nTnYWVyJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512160419.nTnYWVyJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/blk-merge.c: In function 'bio_split_io_at':
>> block/blk-merge.c:332:47: error: 'struct bio' has no member named 'bi_crypt_context'
     332 |                 struct bio_crypt_ctx *bc = bio->bi_crypt_context;
         |                                               ^~


vim +332 block/blk-merge.c

   310	
   311	/**
   312	 * bio_split_io_at - check if and where to split a bio
   313	 * @bio:  [in] bio to be split
   314	 * @lim:  [in] queue limits to split based on
   315	 * @segs: [out] number of segments in the bio with the first half of the sectors
   316	 * @max_bytes: [in] maximum number of bytes per bio
   317	 *
   318	 * Find out if @bio needs to be split to fit the queue limits in @lim and a
   319	 * maximum size of @max_bytes.  Returns a negative error number if @bio can't be
   320	 * split, 0 if the bio doesn't have to be split, or a positive sector offset if
   321	 * @bio needs to be split.
   322	 */
   323	int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
   324			unsigned *segs, unsigned max_bytes)
   325	{
   326		struct bio_vec bv, bvprv, *bvprvp = NULL;
   327		unsigned nsegs = 0, bytes = 0, gaps = 0;
   328		struct bvec_iter iter;
   329		unsigned len_align_mask = lim->dma_alignment;
   330	
   331		if (bio_has_crypt_ctx(bio)) {
 > 332			struct bio_crypt_ctx *bc = bio->bi_crypt_context;
   333	
   334			len_align_mask |= (bc->bc_key->crypto_cfg.data_unit_size - 1);
   335		}
   336	
   337		bio_for_each_bvec(bv, bio, iter) {
   338			if (bv.bv_offset & len_align_mask)
   339				return -EINVAL;
   340	
   341			/*
   342			 * If the queue doesn't support SG gaps and adding this
   343			 * offset would create a gap, disallow it.
   344			 */
   345			if (bvprvp) {
   346				if (bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
   347					goto split;
   348				gaps |= bvec_seg_gap(bvprvp, &bv);
   349			}
   350	
   351			if (nsegs < lim->max_segments &&
   352			    bytes + bv.bv_len <= max_bytes &&
   353			    bv.bv_offset + bv.bv_len <= lim->max_fast_segment_size) {
   354				nsegs++;
   355				bytes += bv.bv_len;
   356			} else {
   357				if (bvec_split_segs(lim, &bv, &nsegs, &bytes,
   358						lim->max_segments, max_bytes))
   359					goto split;
   360			}
   361	
   362			bvprv = bv;
   363			bvprvp = &bvprv;
   364		}
   365	
   366		*segs = nsegs;
   367		bio->bi_bvec_gap_bit = ffs(gaps);
   368		return 0;
   369	split:
   370		if (bio->bi_opf & REQ_ATOMIC)
   371			return -EINVAL;
   372	
   373		/*
   374		 * We can't sanely support splitting for a REQ_NOWAIT bio. End it
   375		 * with EAGAIN if splitting is required and return an error pointer.
   376		 */
   377		if (bio->bi_opf & REQ_NOWAIT)
   378			return -EAGAIN;
   379	
   380		*segs = nsegs;
   381	
   382		/*
   383		 * Individual bvecs might not be logical block aligned. Round down the
   384		 * split size so that each bio is properly block size aligned, even if
   385		 * we do not use the full hardware limits.
   386		 *
   387		 * It is possible to submit a bio that can't be split into a valid io:
   388		 * there may either be too many discontiguous vectors for the max
   389		 * segments limit, or contain virtual boundary gaps without having a
   390		 * valid block sized split. A zero byte result means one of those
   391		 * conditions occured.
   392		 */
   393		bytes = ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
   394		if (!bytes)
   395			return -EINVAL;
   396	
   397		/*
   398		 * Bio splitting may cause subtle trouble such as hang when doing sync
   399		 * iopoll in direct IO routine. Given performance gain of iopoll for
   400		 * big IO can be trival, disable iopoll when split needed.
   401		 */
   402		bio_clear_polled(bio);
   403		bio->bi_bvec_gap_bit = ffs(gaps);
   404		return bytes >> SECTOR_SHIFT;
   405	}
   406	EXPORT_SYMBOL_GPL(bio_split_io_at);
   407	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

