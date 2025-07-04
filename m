Return-Path: <linux-fsdevel+bounces-53963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EFFAF9378
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 15:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDFC1CA4596
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 13:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA532FA649;
	Fri,  4 Jul 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnOcbzpl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D82FA63D
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633999; cv=none; b=SP0yg4LXQ70b23cVC+1V1Kl/0moWmcg0Ki7Jixelr0LHCw39Q0XzBTOLvsuqU1L7grWVmVf/69P2wyEaR/zrKlgE8vtHn/bVOvvCRhFBDO5R42S3j294+eCi3sTDNcDUVJi7NMToxenNQMA8Rn6n7+CsJV95EF97XtfZ+3+Yd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633999; c=relaxed/simple;
	bh=xtaobWYquXV8vVLZA13HjZsPjle3R/wvEv5NetOZtN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKDEteeUrCdBGuJM1AYQiXmfsl3ywHKsZazU68GzU/rf3Bs0+bWeSrVljk0EVu6TRceSjuL1CKw/ADmS3bddkycSidA/ZE+d+c2zhLOZwvkg3dk+Fy7YDZ6HVU7QDcmnWf1FxrEWYG3BCFnMSb/AgocnJhpfTNGS5v+BSg4Oh4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnOcbzpl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751633996; x=1783169996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xtaobWYquXV8vVLZA13HjZsPjle3R/wvEv5NetOZtN4=;
  b=TnOcbzplannn2zpQMF1Nzd6wDbAKbD15JeD2ZgKD3vrHIBRXXIrCXVQ2
   /jhUGSdhixfbWS3UKKF/+j37nXBqHPGPrvohyL745tMLGuZt0L7gwWhDN
   E8p0EozJQlhhRpiSmMD+wQCB/YjZraxa+NWugyq6LkJJfdzCV2PptmOjm
   /kz5PYawFztPiiqilKtRxLX1YbnBctouvfGtf2SeNBypZtbjoPSSMwY1B
   STxp+6I/1KlwXnfWmqt1d7+AW6Xx6hKJuAdlAcAjxgMWBv2TO1l/rPgkC
   czHYEU8TRIxJyTW2ORh0xKgEZnkrsvgUUJINhfnzIPceZVxGE2Oixny3e
   A==;
X-CSE-ConnectionGUID: TSfvP7RZTAeRWqEILm+gnw==
X-CSE-MsgGUID: pKngIZeWSqirVJF6mMfaFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76518619"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="76518619"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 05:59:56 -0700
X-CSE-ConnectionGUID: Hfmy+bIRRei6wZRfo7Ya+g==
X-CSE-MsgGUID: YQOE7kJ8R5+PhyPIp8B5Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="154060730"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Jul 2025 05:59:54 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXg19-0003jX-2u;
	Fri, 04 Jul 2025 12:59:51 +0000
Date: Fri, 4 Jul 2025 20:59:27 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/2] fuse: use default writeback accounting
Message-ID: <202507042032.MdzNkWm3-lkp@intel.com>
References: <20250703164556.1576674-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703164556.1576674-1-joannelkoong@gmail.com>

Hi Joanne,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mszeredi-fuse/for-next]
[also build test WARNING on akpm-mm/mm-everything linus/master v6.16-rc4 next-20250703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/mm-remove-BDI_CAP_WRITEBACK_ACCT/20250704-004813
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20250703164556.1576674-1-joannelkoong%40gmail.com
patch subject: [PATCH v1 1/2] fuse: use default writeback accounting
config: microblaze-randconfig-r073-20250704 (https://download.01.org/0day-ci/archive/20250704/202507042032.MdzNkWm3-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507042032.MdzNkWm3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507042032.MdzNkWm3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/fuse/file.c: In function 'fuse_writepage_finish':
>> fs/fuse/file.c:1787:27: warning: unused variable 'bdi' [-Wunused-variable]
     struct backing_dev_info *bdi = inode_to_bdi(inode);
                              ^~~
   fs/fuse/file.c: In function 'fuse_writepage_args_page_fill':
>> fs/fuse/file.c:1982:16: warning: unused variable 'inode' [-Wunused-variable]
     struct inode *inode = folio->mapping->host;
                   ^~~~~


vim +/bdi +1787 fs/fuse/file.c

3be5a52b30aa5c Miklos Szeredi  2008-04-30  1781  
509a6458b44f72 Joanne Koong    2024-08-26  1782  static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1783  {
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1784  	struct fuse_args_pages *ap = &wpa->ia.ap;
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1785  	struct inode *inode = wpa->inode;
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1786  	struct fuse_inode *fi = get_fuse_inode(inode);
0c58a97f919c24 Joanne Koong    2025-04-14 @1787  	struct backing_dev_info *bdi = inode_to_bdi(inode);
385b126815d927 Pavel Emelyanov 2013-06-29  1788  	int i;
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1789  
ef2027c20ad4a6 Joanne Koong    2025-07-03  1790  	for (i = 0; i < ap->num_folios; i++)
0c58a97f919c24 Joanne Koong    2025-04-14  1791  		/*
0c58a97f919c24 Joanne Koong    2025-04-14  1792  		 * Benchmarks showed that ending writeback within the
0c58a97f919c24 Joanne Koong    2025-04-14  1793  		 * scope of the fi->lock alleviates xarray lock
0c58a97f919c24 Joanne Koong    2025-04-14  1794  		 * contention and noticeably improves performance.
0c58a97f919c24 Joanne Koong    2025-04-14  1795  		 */
0c58a97f919c24 Joanne Koong    2025-04-14  1796  		folio_end_writeback(ap->folios[i]);
c04e3b21181923 Joanne Koong    2024-08-26  1797  
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1798  	wake_up(&fi->page_waitq);
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1799  }
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1800  
f15ecfef058d94 Kirill Tkhai    2018-11-09  1801  /* Called under fi->lock, may release and reacquire it */
fcee216beb9c15 Max Reitz       2020-05-06  1802  static void fuse_send_writepage(struct fuse_mount *fm,
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1803  				struct fuse_writepage_args *wpa, loff_t size)
f15ecfef058d94 Kirill Tkhai    2018-11-09  1804  __releases(fi->lock)
f15ecfef058d94 Kirill Tkhai    2018-11-09  1805  __acquires(fi->lock)
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1806  {
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1807  	struct fuse_inode *fi = get_fuse_inode(wpa->inode);
ff7c3ee4842d87 Joanne Koong    2025-05-12  1808  	struct fuse_args_pages *ap = &wpa->ia.ap;
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1809  	struct fuse_write_in *inarg = &wpa->ia.write.in;
ff7c3ee4842d87 Joanne Koong    2025-05-12  1810  	struct fuse_args *args = &ap->args;
ff7c3ee4842d87 Joanne Koong    2025-05-12  1811  	__u64 data_size = 0;
ff7c3ee4842d87 Joanne Koong    2025-05-12  1812  	int err, i;
ff7c3ee4842d87 Joanne Koong    2025-05-12  1813  
ff7c3ee4842d87 Joanne Koong    2025-05-12  1814  	for (i = 0; i < ap->num_folios; i++)
ff7c3ee4842d87 Joanne Koong    2025-05-12  1815  		data_size += ap->descs[i].length;
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1816  
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1817  	fi->writectr++;
385b126815d927 Pavel Emelyanov 2013-06-29  1818  	if (inarg->offset + data_size <= size) {
385b126815d927 Pavel Emelyanov 2013-06-29  1819  		inarg->size = data_size;
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1820  	} else if (inarg->offset < size) {
385b126815d927 Pavel Emelyanov 2013-06-29  1821  		inarg->size = size - inarg->offset;
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1822  	} else {
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1823  		/* Got truncated off completely */
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1824  		goto out_free;
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1825  	}
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1826  
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1827  	args->in_args[1].size = inarg->size;
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1828  	args->force = true;
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1829  	args->nocreds = true;
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1830  
fcee216beb9c15 Max Reitz       2020-05-06  1831  	err = fuse_simple_background(fm, args, GFP_ATOMIC);
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1832  	if (err == -ENOMEM) {
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1833  		spin_unlock(&fi->lock);
fcee216beb9c15 Max Reitz       2020-05-06  1834  		err = fuse_simple_background(fm, args, GFP_NOFS | __GFP_NOFAIL);
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1835  		spin_lock(&fi->lock);
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1836  	}
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1837  
f15ecfef058d94 Kirill Tkhai    2018-11-09  1838  	/* Fails on broken connection only */
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1839  	if (unlikely(err))
f15ecfef058d94 Kirill Tkhai    2018-11-09  1840  		goto out_free;
f15ecfef058d94 Kirill Tkhai    2018-11-09  1841  
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1842  	return;
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1843  
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1844   out_free:
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1845  	fi->writectr--;
509a6458b44f72 Joanne Koong    2024-08-26  1846  	fuse_writepage_finish(wpa);
f15ecfef058d94 Kirill Tkhai    2018-11-09  1847  	spin_unlock(&fi->lock);
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1848  	fuse_writepage_free(wpa);
f15ecfef058d94 Kirill Tkhai    2018-11-09  1849  	spin_lock(&fi->lock);
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1850  }
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1851  
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1852  /*
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1853   * If fi->writectr is positive (no truncate or fsync going on) send
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1854   * all queued writepage requests.
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1855   *
f15ecfef058d94 Kirill Tkhai    2018-11-09  1856   * Called with fi->lock
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1857   */
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1858  void fuse_flush_writepages(struct inode *inode)
f15ecfef058d94 Kirill Tkhai    2018-11-09  1859  __releases(fi->lock)
f15ecfef058d94 Kirill Tkhai    2018-11-09  1860  __acquires(fi->lock)
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1861  {
fcee216beb9c15 Max Reitz       2020-05-06  1862  	struct fuse_mount *fm = get_fuse_mount(inode);
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1863  	struct fuse_inode *fi = get_fuse_inode(inode);
9de5be06d0a89c Miklos Szeredi  2019-04-24  1864  	loff_t crop = i_size_read(inode);
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1865  	struct fuse_writepage_args *wpa;
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1866  
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1867  	while (fi->writectr >= 0 && !list_empty(&fi->queued_writes)) {
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1868  		wpa = list_entry(fi->queued_writes.next,
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1869  				 struct fuse_writepage_args, queue_entry);
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1870  		list_del_init(&wpa->queue_entry);
fcee216beb9c15 Max Reitz       2020-05-06  1871  		fuse_send_writepage(fm, wpa, crop);
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1872  	}
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1873  }
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1874  
fcee216beb9c15 Max Reitz       2020-05-06  1875  static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1876  			       int error)
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1877  {
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1878  	struct fuse_writepage_args *wpa =
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1879  		container_of(args, typeof(*wpa), ia.ap.args);
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1880  	struct inode *inode = wpa->inode;
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1881  	struct fuse_inode *fi = get_fuse_inode(inode);
3466958beb31a8 Vivek Goyal     2021-04-06  1882  	struct fuse_conn *fc = get_fuse_conn(inode);
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1883  
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1884  	mapping_set_error(inode->i_mapping, error);
3466958beb31a8 Vivek Goyal     2021-04-06  1885  	/*
3466958beb31a8 Vivek Goyal     2021-04-06  1886  	 * A writeback finished and this might have updated mtime/ctime on
3466958beb31a8 Vivek Goyal     2021-04-06  1887  	 * server making local mtime/ctime stale.  Hence invalidate attrs.
3466958beb31a8 Vivek Goyal     2021-04-06  1888  	 * Do this only if writeback_cache is not enabled.  If writeback_cache
3466958beb31a8 Vivek Goyal     2021-04-06  1889  	 * is enabled, we trust local ctime/mtime.
3466958beb31a8 Vivek Goyal     2021-04-06  1890  	 */
3466958beb31a8 Vivek Goyal     2021-04-06  1891  	if (!fc->writeback_cache)
fa5eee57e33e79 Miklos Szeredi  2021-10-22  1892  		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);
f15ecfef058d94 Kirill Tkhai    2018-11-09  1893  	spin_lock(&fi->lock);
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1894  	fi->writectr--;
509a6458b44f72 Joanne Koong    2024-08-26  1895  	fuse_writepage_finish(wpa);
f15ecfef058d94 Kirill Tkhai    2018-11-09  1896  	spin_unlock(&fi->lock);
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1897  	fuse_writepage_free(wpa);
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1898  }
3be5a52b30aa5c Miklos Szeredi  2008-04-30  1899  
a9667ac88e2b20 Miklos Szeredi  2021-09-01  1900  static struct fuse_file *__fuse_write_file_get(struct fuse_inode *fi)
adcadfa8f373f3 Pavel Emelyanov 2013-06-29  1901  {
84840efc3c0f22 Miklos Szeredi  2021-10-22  1902  	struct fuse_file *ff;
adcadfa8f373f3 Pavel Emelyanov 2013-06-29  1903  
f15ecfef058d94 Kirill Tkhai    2018-11-09  1904  	spin_lock(&fi->lock);
84840efc3c0f22 Miklos Szeredi  2021-10-22  1905  	ff = list_first_entry_or_null(&fi->write_files, struct fuse_file,
72523425fb434e Miklos Szeredi  2013-10-01  1906  				      write_entry);
84840efc3c0f22 Miklos Szeredi  2021-10-22  1907  	if (ff)
adcadfa8f373f3 Pavel Emelyanov 2013-06-29  1908  		fuse_file_get(ff);
f15ecfef058d94 Kirill Tkhai    2018-11-09  1909  	spin_unlock(&fi->lock);
adcadfa8f373f3 Pavel Emelyanov 2013-06-29  1910  
adcadfa8f373f3 Pavel Emelyanov 2013-06-29  1911  	return ff;
adcadfa8f373f3 Pavel Emelyanov 2013-06-29  1912  }
adcadfa8f373f3 Pavel Emelyanov 2013-06-29  1913  
a9667ac88e2b20 Miklos Szeredi  2021-09-01  1914  static struct fuse_file *fuse_write_file_get(struct fuse_inode *fi)
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1915  {
a9667ac88e2b20 Miklos Szeredi  2021-09-01  1916  	struct fuse_file *ff = __fuse_write_file_get(fi);
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1917  	WARN_ON(!ff);
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1918  	return ff;
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1919  }
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1920  
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1921  int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1922  {
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1923  	struct fuse_inode *fi = get_fuse_inode(inode);
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1924  	struct fuse_file *ff;
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1925  	int err;
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1926  
5c791fe1e2a4f4 Miklos Szeredi  2021-10-22  1927  	/*
5c791fe1e2a4f4 Miklos Szeredi  2021-10-22  1928  	 * Inode is always written before the last reference is dropped and
5c791fe1e2a4f4 Miklos Szeredi  2021-10-22  1929  	 * hence this should not be reached from reclaim.
5c791fe1e2a4f4 Miklos Szeredi  2021-10-22  1930  	 *
5c791fe1e2a4f4 Miklos Szeredi  2021-10-22  1931  	 * Writing back the inode from reclaim can deadlock if the request
5c791fe1e2a4f4 Miklos Szeredi  2021-10-22  1932  	 * processing itself needs an allocation.  Allocations triggering
5c791fe1e2a4f4 Miklos Szeredi  2021-10-22  1933  	 * reclaim while serving a request can't be prevented, because it can
5c791fe1e2a4f4 Miklos Szeredi  2021-10-22  1934  	 * involve any number of unrelated userspace processes.
5c791fe1e2a4f4 Miklos Szeredi  2021-10-22  1935  	 */
5c791fe1e2a4f4 Miklos Szeredi  2021-10-22  1936  	WARN_ON(wbc->for_reclaim);
5c791fe1e2a4f4 Miklos Szeredi  2021-10-22  1937  
a9667ac88e2b20 Miklos Szeredi  2021-09-01  1938  	ff = __fuse_write_file_get(fi);
ab9e13f7c771b5 Maxim Patlasov  2014-04-28  1939  	err = fuse_flush_times(inode, ff);
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1940  	if (ff)
e26ee4efbc7961 Amir Goldstein  2024-02-01  1941  		fuse_file_put(ff, false);
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1942  
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1943  	return err;
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1944  }
1e18bda86e2dcc Miklos Szeredi  2014-04-28  1945  
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1946  static struct fuse_writepage_args *fuse_writepage_args_alloc(void)
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1947  {
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1948  	struct fuse_writepage_args *wpa;
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1949  	struct fuse_args_pages *ap;
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1950  
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1951  	wpa = kzalloc(sizeof(*wpa), GFP_NOFS);
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1952  	if (wpa) {
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1953  		ap = &wpa->ia.ap;
cbe9c115b7441d Joanne Koong    2024-10-24  1954  		ap->num_folios = 0;
68bfb7eb7f7de3 Joanne Koong    2024-10-24  1955  		ap->folios = fuse_folios_alloc(1, GFP_NOFS, &ap->descs);
cbe9c115b7441d Joanne Koong    2024-10-24  1956  		if (!ap->folios) {
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1957  			kfree(wpa);
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1958  			wpa = NULL;
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1959  		}
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1960  	}
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1961  	return wpa;
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1962  
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1963  }
33826ebbbe4b45 Miklos Szeredi  2019-09-10  1964  
660585b56e63ca Miklos Szeredi  2021-09-01  1965  static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
660585b56e63ca Miklos Szeredi  2021-09-01  1966  					 struct fuse_writepage_args *wpa)
660585b56e63ca Miklos Szeredi  2021-09-01  1967  {
660585b56e63ca Miklos Szeredi  2021-09-01  1968  	if (!fc->sync_fs)
660585b56e63ca Miklos Szeredi  2021-09-01  1969  		return;
660585b56e63ca Miklos Szeredi  2021-09-01  1970  
660585b56e63ca Miklos Szeredi  2021-09-01  1971  	rcu_read_lock();
660585b56e63ca Miklos Szeredi  2021-09-01  1972  	/* Prevent resurrection of dead bucket in unlikely race with syncfs */
660585b56e63ca Miklos Szeredi  2021-09-01  1973  	do {
660585b56e63ca Miklos Szeredi  2021-09-01  1974  		wpa->bucket = rcu_dereference(fc->curr_bucket);
660585b56e63ca Miklos Szeredi  2021-09-01  1975  	} while (unlikely(!atomic_inc_not_zero(&wpa->bucket->count)));
660585b56e63ca Miklos Szeredi  2021-09-01  1976  	rcu_read_unlock();
660585b56e63ca Miklos Szeredi  2021-09-01  1977  }
660585b56e63ca Miklos Szeredi  2021-09-01  1978  
0acad9289be33d Joanne Koong    2024-08-26  1979  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
0c58a97f919c24 Joanne Koong    2025-04-14  1980  					  uint32_t folio_index)
0acad9289be33d Joanne Koong    2024-08-26  1981  {
0acad9289be33d Joanne Koong    2024-08-26 @1982  	struct inode *inode = folio->mapping->host;
0acad9289be33d Joanne Koong    2024-08-26  1983  	struct fuse_args_pages *ap = &wpa->ia.ap;
0acad9289be33d Joanne Koong    2024-08-26  1984  
0c58a97f919c24 Joanne Koong    2025-04-14  1985  	ap->folios[folio_index] = folio;
68bfb7eb7f7de3 Joanne Koong    2024-10-24  1986  	ap->descs[folio_index].offset = 0;
f3cb8bd908c72e Joanne Koong    2025-05-12  1987  	ap->descs[folio_index].length = folio_size(folio);
0acad9289be33d Joanne Koong    2024-08-26  1988  }
0acad9289be33d Joanne Koong    2024-08-26  1989  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

