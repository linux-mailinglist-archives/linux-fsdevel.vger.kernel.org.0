Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B27D26D338
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 07:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIQFro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 01:47:44 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5028 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIQFrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 01:47:43 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 01:47:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600321662; x=1631857662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zc28sktHmZGR/538cxHdIG6BpU19Y6P1jMgKf27Avc0=;
  b=FMXsT4rq3Mt2ZmF2+9fGXwsn5bdDzA46FRQYyG19Q77SHWP/t4P3UPyx
   o4bQK9UXkFJvLI/MWJDTOHjgfVFf0PL0+W5dXQqj0gVBs+LGVgcIkhH9C
   dMsY7vPAR9JIGGBRPjVflG9VKl92XraZAsqPFPa3eMK8p0eWFsMODPGtj
   dGG+TwA8jY3I/zSticZq/i++cAUPETbLgRrsqXZlvgPyZFFzGLVglgZ9Z
   lmRcOD1FG30+kIUjNrCmDKhResd51BO+1M38X3pBTtt1bUUWCUC8m5lCD
   gzf+0vdedUd1FnIWRL3ajJRXaGMBOeLwsKPWslJconiBB6I+5ak5Hu+1Q
   Q==;
IronPort-SDR: bOOmUpPdFmCmZNdcKMcL+EE+UTtvCTgYOVgLYuvTHBeilm0/fXOS8zd7rNqL0XaFO43/TVUZG2
 FNSi88j9wcq2o7dcc3js4c90afOUAHDiSWnpD0wtnlooiaSkFDqfLboMl8nC0r69tbqBk/HjD1
 T1TT4vSKyW3YliVzyWz2kmAZMNP15hf8v9LJy17B5/m2dk3JZyRx37L4e8FzsuivE8/da6qQNQ
 rEiMFz2cw1+Eb9sZUsEqg1iQgdFCtOM5GxcHCy5EW9bKHRv/stap5jRntddx5snc4brfotqTf2
 3B4=
X-IronPort-AV: E=Sophos;i="5.76,435,1592841600"; 
   d="scan'208";a="257254660"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 13:40:35 +0800
IronPort-SDR: iGMQI5D8SuAMQzikzJvv9NKU0kILo4vnNvhTUsj2128kschqHBf8uYxsIf+GNMsUbPMput36pR
 3o8n7++QIhIA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 22:27:44 -0700
IronPort-SDR: GllSouYna0iRrnJQgVR5kfO/0Lq0+Wmr5/szIjDz/epSFz/BHY5LlDIRYlxboEyn9L7YNebDI7
 0a1G9C9uHFnA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 16 Sep 2020 22:40:34 -0700
Received: (nullmailer pid 820317 invoked by uid 1000);
        Thu, 17 Sep 2020 05:40:33 -0000
Date:   Thu, 17 Sep 2020 14:40:33 +0900
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 00/39] btrfs: zoned block device support
Message-ID: <20200917054033.homtvyj3iffrjile@naota.dhcp.fujisawa.hgst.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
 <20200915080927.GF1791@twin.jikos.cz>
 <SN4PR0401MB359839054A125BF64641B4E89B210@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359839054A125BF64641B4E89B210@SN4PR0401MB3598.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 05:42:50PM +0000, Johannes Thumshirn wrote:
>On 15/09/2020 10:25, David Sterba wrote:
>> On Fri, Sep 11, 2020 at 09:32:20PM +0900, Naohiro Aota wrote:
>>> Changelog
>>> v6:
>>>  - Use bitmap helpers (Johannes)
>>>  - Code cleanup (Johannes)
>>>  - Rebased on kdave/for-5.5
>>>  - Enable the tree-log feature.
>>>  - Treat conventional zones as sequential zones, so we can now allow
>>>    mixed allocation of conventional zone and sequential write required
>>>    zone to construct a block group.
>>>  - Implement log-structured superblock
>>>    - No need for one conventional zone at the beginning of a device.
>>>  - Fix deadlock of direct IO writing
>>>  - Fix building with !CONFIG_BLK_DEV_ZONED (Johannes)
>>>  - Fix leak of zone_info (Johannes)
>>
>> I did a quick check to see if the patchset passes the default VM tests
>> and there's use after free short after the fstests start. No zoned
>> devices or such. I had to fix some conflicts when rebasing on misc-next
>> but I tried to base it on the last iomap-dio patch ("btrfs: switch to
>> iomap for direct IO"), same result so it's something in the zoned
>> patches.
>>
>> The reported pointer 0x6b6b6b6b6d1918eb contains the use-after-free
>> poison (0x6b) (CONFIG_PAGE_POISONING=y).
>>
>> MKFS_OPTIONS  -- -f -K --csum xxhash /dev/vdb
>> MOUNT_OPTIONS -- -o discard /dev/vdb /tmp/scratch
>
>Hi David,
>
>Can you check if this on top of the series fixes the issue? According
>to Keith we can't call bio_iovec() from endio() as the iterator is already
>advanced (see req_bio_endio()).
>
>

Thank you for fixing this.

>diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>index bda4e02b5eab..311956697682 100644
>--- a/fs/btrfs/extent_io.c
>+++ b/fs/btrfs/extent_io.c
>@@ -2753,10 +2753,6 @@ static void end_bio_extent_writepage(struct bio *bio)
>        u64 end;
>        struct bvec_iter_all iter_all;
>
>-       btrfs_record_physical_zoned(bio_iovec(bio).bv_page->mapping->host,
>-                                   page_offset(bio_iovec(bio).bv_page) + bio_iovec(bio).bv_offset,
>-                                   bio);
>-
>        ASSERT(!bio_flagged(bio, BIO_CLONED));
>        bio_for_each_segment_all(bvec, bio, iter_all) {
>                struct page *page = bvec->bv_page;
>@@ -2782,6 +2778,7 @@ static void end_bio_extent_writepage(struct bio *bio)
>                start = page_offset(page);
>                end = start + bvec->bv_offset + bvec->bv_len - 1;
>
>+               btrfs_record_physical_zoned(inode, start, bio);

We need to record the physical address only once per an ordered extent.
So, this should be like:

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c21d1dbe314e..0bbe6e52ea0d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2748,6 +2748,7 @@ static void end_bio_extent_writepage(struct bio *bio)
         u64 start;
         u64 end;
         struct bvec_iter_all iter_all;
+       bool first_bvec = true;

         ASSERT(!bio_flagged(bio, BIO_CLONED));
         bio_for_each_segment_all(bvec, bio, iter_all) {
@@ -2774,6 +2775,11 @@ static void end_bio_extent_writepage(struct bio *bio)
                 start = page_offset(page);
                 end = start + bvec->bv_offset + bvec->bv_len - 1;

+               if (first_bvec) {
+                       btrfs_record_physical_zoned(inode, start, bio);
+                       first_bvec = false;
+               }
+
                 end_extent_writepage(page, error, start, end);
                 end_page_writeback(page);
         }


>                end_extent_writepage(page, error, start, end);
>                end_page_writeback(page);
>        }
>diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>index 576f8e333f16..6fdb21029ea9 100644
>--- a/fs/btrfs/zoned.c
>+++ b/fs/btrfs/zoned.c
>@@ -1086,8 +1086,7 @@ void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
> {
>        struct btrfs_ordered_extent *ordered;
>        struct bio_vec bvec = bio_iovec(bio);
>-       u64 physical = ((u64)bio->bi_iter.bi_sector << SECTOR_SHIFT) +
>-               bvec.bv_offset;
>+       u64 physical = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
>
>        if (bio_op(bio) != REQ_OP_ZONE_APPEND)
>                return;
>
