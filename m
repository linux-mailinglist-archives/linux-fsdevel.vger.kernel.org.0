Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E468124506
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 11:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfLRKtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 05:49:24 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:41408 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfLRKtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 05:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576666163; x=1608202163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/DMjkVyfyvI2kcubUQsHCGEvs74jyidMQ1Qv+JhyxmQ=;
  b=Jfvl26RQ2b+Zzm3pmvvYKcG27RKmcUuxMESH9wM+k+7sjj+SV9geBDgG
   Fx+XFRDXIzP631i3U4LWtU9JXC2GM/pPKpAIx2gnX9i3gH3gxGVLNBo8H
   vLxth3OIfDw51qzHZo9TUWEhAhMdumP0VIHuXGDa69S2RBlBuez7ttbwB
   L1luXD88uryTcjiQDOwM5I0S6uCjHe+PGDI19NzTHs17RcyOYcyu1RcSh
   gcxceYN5O7ojStLDQh5qIbS2O3Kcn/iYglKcmXqL8CtrFE4G6L2+0ho37
   1qlvyPsxSX4vUCqIxvk8e9hK7fsVIfjxiedQuOWdXls/jR/7S8GrbRG/7
   g==;
IronPort-SDR: 3Zj82qrszqCRBQFbotOdJh5vIkLTgah+sX5J7Wx9anwJ3KiYwC5vRUeUIa4JmcmjV+lvJkuO1G
 rRDr5MZuHD958IXwVKKB/HWwb31bYh71U7xBjwskKx3FzXA31EtW7TVaHT1ZvCMaW89MWRNpf3
 /I6uYr/ylp60RwE2dA+YX/IzsW7G6++Carc/eDuLy8wzvTML8gmLNFlOE7IMsXuMx5bNyK9mKJ
 at4BPl8qft7QLn911EkB0MOxWpJ+7cT3ef86djTPnz0hjvnVElW2/Iu6RK8yAwLXRx7dtFj9Qo
 k1s=
X-IronPort-AV: E=Sophos;i="5.69,329,1571673600"; 
   d="scan'208";a="127245447"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2019 18:49:23 +0800
IronPort-SDR: KY4wa/9YEg+D5B8juMLSc9dh1MWWGgYs0ZQIQAhdjwyoatOevqOhcp+2y87MBG+snQ3V0xXLoM
 cKIHgjdwAoSejqcIn0JWwhaNI2FFtBrqPcBnhw/TIJcuP7Jp73Z1477JJLHo2NipZMBQartPmy
 8W6Tz8su6dMbVzK+K3I99jUjbn2zhC0knnczCOll9B57tkHqzoGVNaxMY0YP78+hAJ+6GxAQOQ
 EApux5aD13/bSjhE8tULxx+yz1jzrQFKm25z1r95uj6ecA8rBz7WaVfVJ+PxtpkyaTQie+eWAL
 sLwdIhjJOWNVYDJdF8uTdh5z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 02:43:25 -0800
IronPort-SDR: qMJQrwt3meamHp8ztthaqI/oHOAqwWEgE9uTreqXeFi+ssrqlGTGNgBvr5VE5B4Qt2MVxH/j6l
 n2HaQSNHrHFEgIh+moNkIV0jrD1lj1d/CNgImbIACWUj6YhAOmSdUlEyqWJZic3htnOL2CJNE3
 YWYISe116o9fewjG7iXk/VAYMx03BC4k9QsSWWRksPxh+pLohML+NIzPet8UDHKgBAd4TMsWqt
 7B4Ualz35zK8RPsxqDnKrczLlZq0yO5TNtZLJ37BK5sGeDxkC4euofLdQUJimhleH/lgiFa6jV
 TFQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with SMTP; 18 Dec 2019 02:49:21 -0800
Received: (nullmailer pid 1323844 invoked by uid 1000);
        Wed, 18 Dec 2019 10:49:20 -0000
Date:   Wed, 18 Dec 2019 19:49:20 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 24/28] btrfs: enable relocation in HMZONED mode
Message-ID: <20191218104920.ozsa3pawkvxs2gg5@naota.dhcp.fujisawa.hgst.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-25-naohiro.aota@wdc.com>
 <83984f9c-4f37-4a04-daea-8169959dc09d@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <83984f9c-4f37-4a04-daea-8169959dc09d@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 04:32:04PM -0500, Josef Bacik wrote:
>On 12/12/19 11:09 PM, Naohiro Aota wrote:
>>To serialize allocation and submit_bio, we introduced mutex around them. As
>>a result, preallocation must be completely disabled to avoid a deadlock.
>>
>>Since current relocation process relies on preallocation to move file data
>>extents, it must be handled in another way. In HMZONED mode, we just
>>truncate the inode to the size that we wanted to pre-allocate. Then, we
>>flush dirty pages on the file before finishing relocation process.
>>run_delalloc_hmzoned() will handle all the allocation and submit IOs to
>>the underlying layers.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/relocation.c | 39 +++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 37 insertions(+), 2 deletions(-)
>>
>>diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>>index d897a8e5e430..2d17b7566df4 100644
>>--- a/fs/btrfs/relocation.c
>>+++ b/fs/btrfs/relocation.c
>>@@ -3159,6 +3159,34 @@ int prealloc_file_extent_cluster(struct inode *inode,
>>  	if (ret)
>>  		goto out;
>>+	/*
>>+	 * In HMZONED, we cannot preallocate the file region. Instead,
>>+	 * we dirty and fiemap_write the region.
>>+	 */
>>+
>>+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED)) {
>>+		struct btrfs_root *root = BTRFS_I(inode)->root;
>>+		struct btrfs_trans_handle *trans;
>>+
>>+		end = cluster->end - offset + 1;
>>+		trans = btrfs_start_transaction(root, 1);
>>+		if (IS_ERR(trans))
>>+			return PTR_ERR(trans);
>>+
>>+		inode->i_ctime = current_time(inode);
>>+		i_size_write(inode, end);
>>+		btrfs_ordered_update_i_size(inode, end, NULL);
>>+		ret = btrfs_update_inode(trans, root, inode);
>>+		if (ret) {
>>+			btrfs_abort_transaction(trans, ret);
>>+			btrfs_end_transaction(trans);
>>+			return ret;
>>+		}
>>+		ret = btrfs_end_transaction(trans);
>>+
>>+		goto out;
>>+	}
>>+
>
>Why are we arbitrarily extending the i_size here?  If we don't need 
>prealloc we don't need to jack up the i_size either.

We need to extend i_size to read data from the relocating block
group. If not, btrfs_readpage() in relocate_file_extent_cluster()
always reads zero filled page because the read position is beyond the
file size.

>>  	cur_offset = prealloc_start;
>>  	while (nr < cluster->nr) {
>>  		start = cluster->boundary[nr] - offset;
>>@@ -3346,6 +3374,10 @@ static int relocate_file_extent_cluster(struct inode *inode,
>>  		btrfs_throttle(fs_info);
>>  	}
>>  	WARN_ON(nr != cluster->nr);
>>+	if (btrfs_fs_incompat(fs_info, HMZONED) && !ret) {
>>+		ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
>>+		WARN_ON(ret);
>
>Do not WAR_ON() when this could happen due to IO errors.  Thanks,
>
>Josef

Sure. We can just drop it.
