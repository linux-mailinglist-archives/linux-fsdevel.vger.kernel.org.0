Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B57A6123E7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 05:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfLRE2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 23:28:54 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4641 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfLRE2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576643341; x=1608179341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=12oQObDFKrBu4T5/+RMxqkkkkyXyITEQA/gm0GMGims=;
  b=Epwt2p+htI/nc5+7CN0LQMt2RxdfArYGBIOaxTr/Sjp4OGoQPdeGHZQP
   EHsu8u8fejtF9O2zF0SwndDy2UyHN8JfIlpxLq+Dn61g/5Cqh1J924pBs
   O71wU4NSahD2An0qgNQzLQAFLWlgzVi6r47GCQnKhIKofAkRu1UJbIyRV
   Tv5O6R4EJp5mLtR4ODamvzQy6LuQL3fS7oJ6cqozwMAdctPp8Us3wo6L9
   iBxwlqzFMizS2td7nA8G6oBjaju+0yNURt77UON+BMCku8NpZYI/YzsmP
   SbpmPbJrsvoIGlR4rmla+UtsAU/dRaE+9yIV/rdZnn62SLBQ0EzNY7f8i
   w==;
IronPort-SDR: lh43bccDTmTl7sQMr1W9331DOQxYLCXkLlaiaa2Cv9/Bl4FuqjeH6ID+D4Fblk3+Abue9t0pYZ
 j2J2HuZjsqO1OwCoutRjzjmqI7ybyjCowDXVk2S1GB0gx/jmeCDSpU4VFXiAN6+9Snia042KaP
 vMQDge1ZK8zT0mc7fsbBBCZ37cbReQfTEcApkjgK6EBRqs3XuRBynEHoHKJQEazPnpgbMUor25
 vi9xdsgVuBdIL1vn0xn8EkVq/5jlYvkXgHlRCn4Ol7K2DQnGe/2Z/lqA/MkOyGwJQP0eWwaMhA
 iMI=
X-IronPort-AV: E=Sophos;i="5.69,328,1571673600"; 
   d="scan'208";a="227189204"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2019 12:29:00 +0800
IronPort-SDR: 0z2KCGsJPvmoP40ZWKdrwiOLFFP5xTTGry2U1FG442oHwLVDyu98lbJldoyNYF/UMg286deSGI
 K0V7eeZL4qiFJjb3+nBHf0h2ORlL+KgkUDk3p6P35qFXTG7hVfZ24KTBjVfdk8pvDsFkFNzD5r
 JZwcuX9zH95TyYSX9+vXRC3GsIRtLxhpTHRRcYT/GI8EwWCZTTIyUqGOpjLQRvqh+TpWqZ9j6V
 B+WcbJRNl2Y7XjsjXmzK8O7sWZJTbvX4QUwOpEaKncDyqNHYYCjp29LZeNWDmVe6a+ZT8OEAJE
 WgducPxhk+47apgp7OlB2psK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 20:23:17 -0800
IronPort-SDR: z6UNRgU/RvXykk9DirwKgNCtR5Wkv6x56Dd2lLZGR+pGPbdjZFm1ZmWW7tIzUs5h4JSPTAMj9M
 VmTl4pJW9xWzQq4Dl4rYKV+Fn3ZefKevqkbX2Y8BSN5NHxE6Zvw3+DHzFt9G1zPP/BCui1OQOz
 apO9RBKQwvWqmsI2CbGY3yy873gKBAMkbolUEp7p37s4O2eX4aoGSgixmL99Y1kcY+jpPcB8o6
 7s17tbE50uGcsU85WVrtofafwYvjSaZzZhabts34AC033sa2c46TC3NoLkod7L7O5+UG/KArvP
 w7Q=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with SMTP; 17 Dec 2019 20:28:52 -0800
Received: (nullmailer pid 723626 invoked by uid 1000);
        Wed, 18 Dec 2019 04:28:51 -0000
Date:   Wed, 18 Dec 2019 13:28:51 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 05/28] btrfs: disallow space_cache in HMZONED mode
Message-ID: <20191218042851.pbz4gumvgyw3wxd6@naota.dhcp.fujisawa.hgst.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-6-naohiro.aota@wdc.com>
 <eac611c8-54d7-cd91-af86-1bc5b0944bde@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <eac611c8-54d7-cd91-af86-1bc5b0944bde@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 11:24:10AM -0500, Josef Bacik wrote:
>On 12/12/19 11:08 PM, Naohiro Aota wrote:
>>As updates to the space cache v1 are in-place, the space cache cannot be
>>located over sequential zones and there is no guarantees that the device
>>will have enough conventional zones to store this cache. Resolve this
>>problem by disabling completely the space cache v1.  This does not
>>introduces any problems with sequential block groups: all the free space is
>>located after the allocation pointer and no free space before the pointer.
>>There is no need to have such cache.
>>
>>Note: we can technically use free-space-tree (space cache v2) on HMZONED
>>mode. But, since HMZONED mode now always allocate extents in a block group
>>sequentially regardless of underlying device zone type, it's no use to
>>enable and maintain the tree.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/hmzoned.c | 18 ++++++++++++++++++
>>  fs/btrfs/hmzoned.h |  5 +++++
>>  fs/btrfs/super.c   | 11 +++++++++--
>>  3 files changed, 32 insertions(+), 2 deletions(-)
>>
>>diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
>>index 1b24facd46b8..d62f11652973 100644
>>--- a/fs/btrfs/hmzoned.c
>>+++ b/fs/btrfs/hmzoned.c
>>@@ -250,3 +250,21 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
>>  out:
>>  	return ret;
>>  }
>>+
>>+int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
>>+{
>>+	if (!btrfs_fs_incompat(info, HMZONED))
>>+		return 0;
>>+
>>+	/*
>>+	 * SPACE CACHE writing is not CoWed. Disable that to avoid write
>>+	 * errors in sequential zones.
>>+	 */
>>+	if (btrfs_test_opt(info, SPACE_CACHE)) {
>>+		btrfs_err(info,
>>+			  "space cache v1 not supportted in HMZONED mode");
>>+		return -EOPNOTSUPP;
>>+	}
>>+
>>+	return 0;
>>+}
>>diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
>>index 8e17f64ff986..d9ebe11afdf5 100644
>>--- a/fs/btrfs/hmzoned.h
>>+++ b/fs/btrfs/hmzoned.h
>>@@ -29,6 +29,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>>  int btrfs_get_dev_zone_info(struct btrfs_device *device);
>>  void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
>>  int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);
>>+int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info);
>>  #else /* CONFIG_BLK_DEV_ZONED */
>>  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>>  				     struct blk_zone *zone)
>>@@ -48,6 +49,10 @@ static inline int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
>>  	btrfs_err(fs_info, "Zoned block devices support is not enabled");
>>  	return -EOPNOTSUPP;
>>  }
>>+static inline int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
>>+{
>>+	return 0;
>>+}
>>  #endif
>>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
>>diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>index 616f5abec267..1424c3c6e3cf 100644
>>--- a/fs/btrfs/super.c
>>+++ b/fs/btrfs/super.c
>>@@ -442,8 +442,13 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>>  	cache_gen = btrfs_super_cache_generation(info->super_copy);
>>  	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
>>  		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
>>-	else if (cache_gen)
>>-		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
>>+	else if (cache_gen) {
>>+		if (btrfs_fs_incompat(info, HMZONED))
>>+			btrfs_info(info,
>>+			"ignoring existing space cache in HMZONED mode");
>
>It would be good to clear the cache gen in this case.  I assume this 
>can happen if we add a hmzoned device to an existing fs with space 
>cache already?  I'd hate for weird corner cases to pop up if we 
>removed it later and still had a valid cache gen in place.  Thanks,
>
>Josef

We at least currently prohibit to add a zoned device to an non-zoned
files system. So, that case of adding zoned device to an existing fs
with space cache, won't happen usually. This condintion deals with
device corruption or bug in userland tools. Anyway, I will clear the
cache in this case.
