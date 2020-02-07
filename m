Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75ABD15551B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 10:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBGJxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 04:53:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10557 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBGJxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581069184; x=1612605184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uAhaW1PCwfpLEY/AjgTXX0WT17aWZpd3hV4pcZcfrvk=;
  b=fyfbtuLpsxwG8+AuHJ0WdEicK/2AoJBfaT+E4rgkzuRBZU++SzoJvGTO
   kqqX2/3z/RCV8KjZhIDvkbB9Shkyu4+c8vEgGJTdZ3NN66d5NHzaDHdK1
   E1fxivxiNBpbNnyhKyWMfisAUWXLPEy2qu09Ul374E6c7qdLHgQwYux3r
   SuTeZ5Jw3t9ymsPrOGoUXBg2UfOtyxJ16+qEFjdh3JGwShjkddX1pjfAX
   oA7oF3QPkjQGvq+vxOEBUi7PBrvfKLdGIfOfG46uPwoCp0Lb/rVVPOwh4
   8HtWK5J1zW3CBmSodVHo30/ncOt38VHFGsR6aq6VAlByPiKSHeqfIG/fP
   A==;
IronPort-SDR: m+9CnK2RHtuVm2UWZmQMb32mmLfglCDOiJuBuPdME9GNS7Dzh0tNk6NFM6idya+VWckZNxvkFD
 HHBhY3Hoy5dqEqX8f2QEKkD2bRuU8Z++k2qPhG8DkyaLBtfiiMZ5CwgOFB5vgbqgJjclk561+a
 NGy1efxu1Ry0j+afsjOrTyW8lVFQTNoCJMvpV9oBfRp2asNabROAqZhb63Ya2NxmXjoiOtWtUh
 8gFSNbxuQqk4b7M8zV4VYZKLQ5IFR4Ax+6VhrTI5ESadxr+gyfrfksrlHMAm4+QJv/TNQUROku
 jAY=
X-IronPort-AV: E=Sophos;i="5.70,412,1574092800"; 
   d="scan'208";a="129341481"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 17:53:04 +0800
IronPort-SDR: qJcSue52ogLl+svGGTqfnDCLvyUFhkPD55pKC82QCYhcQPxc9eJa/tSjb1VicraRo1+BAeSj/n
 e7wRoVYE7Mql6nKO7/xK176Zb1cVk03gwmRIDgt5QZwpj9rTJyEF3Cahroth7own3bQWkvtYyO
 eb8DZEtabAi6nvm4De0gMvf5qCkC1FWr/ucs4hdqiOIIBEMPaDbKDbQGOGEl7VyBKvolHQwIsE
 tMzkDq5dmZcKNDHaYtMOqM5A3237Ln5GrG7Pp9W8Lcs29LNag2BuRm+6vMQGIJW/eswEZ4mQPK
 zEuLA5Uh6DIMObdvypeUTCnS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 01:46:02 -0800
IronPort-SDR: MAlY9cJwe1Fts3ws/tHOaXWVw6oTtBnuDLoIzU5WdNMp078m3FYNMrKExbH0K0xuxJCIC3To9T
 zwn+f8XlTHIMw6e+FvckYZjGEeTKKCGtAT8cIUFdor5AsOoGYFxgAAm6oPEot30sdS/JBW5fbm
 rrL8OVzucS4I+VOkqa3HQmubNdZk9LghFB9/0FYXLPgiB7bgYkiUn/+Q/9zlfNoM7rqo14elQ+
 p3pup2bAjbxGhj1dk/yCmywiz3d3HXEI+ATZVno3af2BHrxz4JzOhkSAWxK6GDE0Je6gMBpENX
 Ccc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 07 Feb 2020 01:53:03 -0800
Received: (nullmailer pid 968290 invoked by uid 1000);
        Fri, 07 Feb 2020 09:53:02 -0000
Date:   Fri, 7 Feb 2020 18:53:02 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/20] btrfs: introduce clustered_alloc_info
Message-ID: <20200207095302.62scyueq2zdxi6ac@naota.dhcp.fujisawa.hgst.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-13-naohiro.aota@wdc.com>
 <ae469d32-e2a7-72df-cdd7-30a81734201f@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ae469d32-e2a7-72df-cdd7-30a81734201f@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 12:01:28PM -0500, Josef Bacik wrote:
>On 2/6/20 5:42 AM, Naohiro Aota wrote:
>>Introduce struct clustered_alloc_info to manage parameters related to
>>clustered allocation. By separating clustered_alloc_info and
>>find_free_extent_ctl, we can introduce other allocation policy. One can
>>access per-allocation policy private information from "alloc_info" of
>>struct find_free_extent_ctl.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/extent-tree.c | 99 +++++++++++++++++++++++++-----------------
>>  1 file changed, 59 insertions(+), 40 deletions(-)
>>
>>diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>index b1f52eee24fe..8124a6461043 100644
>>--- a/fs/btrfs/extent-tree.c
>>+++ b/fs/btrfs/extent-tree.c
>>@@ -3456,9 +3456,6 @@ struct find_free_extent_ctl {
>>  	/* Where to start the search inside the bg */
>>  	u64 search_start;
>>-	/* For clustered allocation */
>>-	u64 empty_cluster;
>>-
>>  	bool have_caching_bg;
>>  	bool orig_have_caching_bg;
>>@@ -3470,18 +3467,6 @@ struct find_free_extent_ctl {
>>  	 */
>>  	int loop;
>>-	/*
>>-	 * Whether we're refilling a cluster, if true we need to re-search
>>-	 * current block group but don't try to refill the cluster again.
>>-	 */
>>-	bool retry_clustered;
>>-
>>-	/*
>>-	 * Whether we're updating free space cache, if true we need to re-search
>>-	 * current block group but don't try updating free space cache again.
>>-	 */
>>-	bool retry_unclustered;
>>-
>>  	/* If current block group is cached */
>>  	int cached;
>>@@ -3499,8 +3484,28 @@ struct find_free_extent_ctl {
>>  	/* Allocation policy */
>>  	enum btrfs_extent_allocation_policy policy;
>>+	void *alloc_info;
>>  };
>>+struct clustered_alloc_info {
>>+	/* For clustered allocation */
>>+	u64 empty_cluster;
>>+
>>+	/*
>>+	 * Whether we're refilling a cluster, if true we need to re-search
>>+	 * current block group but don't try to refill the cluster again.
>>+	 */
>>+	bool retry_clustered;
>>+
>>+	/*
>>+	 * Whether we're updating free space cache, if true we need to re-search
>>+	 * current block group but don't try updating free space cache again.
>>+	 */
>>+	bool retry_unclustered;
>>+
>>+	struct btrfs_free_cluster *last_ptr;
>>+	bool use_cluster;
>This isn't the right place for this, rather I'd put it in the 
>find_free_extent_ctl if you want it at all.
>
>And in fact I question the whole need for this in the first place.  I 
>assume your goal is to just disable clustered allocation for shingle 
>drives, so why don't you just handle that with your extent allocation 
>policy flag?  If it's set to shingled then use_cluster = false and you 
>are good to go, no need to add all this complication of the cluster 
>ctl.

Not really. The clustered allocator (= the current allocator) first
try allocation using a cluster by calling find_free_extent_clustered()
and, if it failed, try allocation without cluster by calling
find_free_extent_unclustered(). This "use_cluster" indicates to skip
the first find_free_extent_clustered().

When not in BTRFS_EXTENT_ALLOC_CLUSTERED, then both of these functions
are skipped (actually, another function for the policy is called). So
the policy controls higher-level function call and the "use_cluster"
controls lower level (only in BTRFS_EXTENT_ALLOC_CLUSTERED level)
function call.

>If you are looking to save space in the ctl, then I would just union 
>{} the cluster stuff inside of the find_free_extent_ctl so the right 
>flags are used for the correction allocation policy.
>
>This whole last set of 10 patches needs to be reworked.  Thanks,

I'm fine with keeping these variable in find_free_extent_ctl. We can
delay this separation of clustered_alloc_info until we really want to
e.g. when some other policy want to use many per-policy
variables. (and, actually, zoned allocator is not using any per-policy
variable)

Thanks,
Naohiro
