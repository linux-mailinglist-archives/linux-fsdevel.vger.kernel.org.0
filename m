Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C707F2A3ECC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 09:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgKCIVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 03:21:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1411 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCIVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604391702; x=1635927702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uz7zoniJbYNB+FKsBSbyh2WGVir1CA+dn0PGQWVnpeQ=;
  b=ZXQuaqc+DqcKIQ8PCNz4kM0TUIvZ1h2kjO763MSo9Z7jCg8nTtV0MEFo
   1vW68PIh5TqO2illLb2AuH/9p1BFeidNOL2VW3+/fgjnD8j2FYHBF1mH6
   YjnjJEbh1mkMcRlcyLB86sxBe7cJV9N77l1mBevNcJZubmLH7jB7cgbZx
   0SbLquZtDkJ9inmnqdQGI14A+54qfWB7ct/dvG0p95PTuYS/pkKiOWllr
   jBngemYjPm2sSFc/6Etx10NE/Y0KzjbjSzJhcRQmAr2w3pG+zZpopljlj
   48iTLahFrHmMcFRVm0u+GRisp0rASPXorQEMCw6B6Owncj5C+CvFqi7Am
   w==;
IronPort-SDR: yz8zXk0JAl86JlKuQRNKLXzuS/qi3gA2GPP0R8QWCwR0gKjLNSYclGsmR7tU51GARfD2C92N35
 Z2WIxpZ7NTYTXkG0HUbjeEOw3xna/0kZlNgzLsSKo2lYbzHcfWucucRlEvUv0zkBtQL6ax7Hn1
 585Dj1r5kx3oXTF6FJVwsqR9/yOMCUgBEyUvDloZEu1pAaM38ck80WyB6919v5f1dojnyhwQYf
 gH1XvtDhbiJ7TNNETFqmIM8sSOymJGhFPUBPK6ztk77cRa20F5I9cZNus0hHcbm7YNwyZ9MpwY
 HdE=
X-IronPort-AV: E=Sophos;i="5.77,447,1596470400"; 
   d="scan'208";a="156074164"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 16:21:41 +0800
IronPort-SDR: rSELpLOsQpOUAgzubvCW2tcAauNWfyKixlVt2fGI4LCsbEmfdJ58PIJNSBWIUSkv7Z8pdyT2Er
 yhzFDgsDWerEGrZ2cdKIMmAIlRqhnUA6qr1eVMxyhDbZsWTrPqgAUT4zMT0lxQiSeAo2Gz6gEJ
 f60AF6UjVYPnIFYSy1lWqURbxKzNGxnv1xkXFONxOjtLKCrMNSBY4PilSDDvp5rQL7XFUjOG7A
 6HcWZgkehTs41R8thoLU7QZznkG87x/WuALKOwK/ZhRmcGGefltCQUpuudyb6Nvi+3nSclAJO2
 vGwkEYOtUyQs+eMGOyAZaTvi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 00:06:40 -0800
IronPort-SDR: TIdHvtn2TsEZ96dihnzZUNheuX/9bWJKqvbvB2p+2hUe6V0o2WPyTCbMQDXNfQhXsmiD+KdByR
 uytPxXmrXG2Vp/fUoqfX+/sW9N1rzcb7//vuCFvXnDr4XKKWO37FFjXJJOcN0m/mxplwVkgPnq
 3VUnpoZJVfxAI0d1shitLAODeZsfG8EQsKUbsA8Vb878Uko5mneXf9Ba/10zV0wufBdjak36GE
 1CEfVh54hi9uhE3FP6XvPUG8lZiTGufUa3fzSUlR7Po/94yoX9lb8HYK6eauFJZjjroTIG/qhc
 eGQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 03 Nov 2020 00:21:40 -0800
Received: (nullmailer pid 213706 invoked by uid 1000);
        Tue, 03 Nov 2020 08:21:40 -0000
Date:   Tue, 3 Nov 2020 17:21:40 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 11/41] btrfs: implement log-structured superblock for
 ZONED mode
Message-ID: <20201103082140.dhdy4drof62ove74@naota.dhcp.fujisawa.hgst.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
 <0485861e-40d4-a736-fc26-fc6fdb435baa@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0485861e-40d4-a736-fc26-fc6fdb435baa@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 01:22:56PM -0500, Josef Bacik wrote:
>On 10/30/20 9:51 AM, Naohiro Aota wrote:
>>Superblock (and its copies) is the only data structure in btrfs which has a
>>fixed location on a device. Since we cannot overwrite in a sequential write
>>required zone, we cannot place superblock in the zone. One easy solution is
>>limiting superblock and copies to be placed only in conventional zones.
>>However, this method has two downsides: one is reduced number of superblock
>>copies. The location of the second copy of superblock is 256GB, which is in
>>a sequential write required zone on typical devices in the market today.
>>So, the number of superblock and copies is limited to be two.  Second
>>downside is that we cannot support devices which have no conventional zones
>>at all.
>>
>>To solve these two problems, we employ superblock log writing. It uses two
>>zones as a circular buffer to write updated superblocks. Once the first
>>zone is filled up, start writing into the second buffer. Then, when the
>>both zones are filled up and before start writing to the first zone again,
>>it reset the first zone.
>>
>>We can determine the position of the latest superblock by reading write
>>pointer information from a device. One corner case is when the both zones
>>are full. For this situation, we read out the last superblock of each
>>zone, and compare them to determine which zone is older.
>>
>>The following zones are reserved as the circular buffer on ZONED btrfs.
>>
>>- The primary superblock: zones 0 and 1
>>- The first copy: zones 16 and 17
>>- The second copy: zones 1024 or zone at 256GB which is minimum, and next
>>   to it
>>
>>If these reserved zones are conventional, superblock is written fixed at
>>the start of the zone without logging.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/block-group.c |   9 ++
>>  fs/btrfs/disk-io.c     |  41 +++++-
>>  fs/btrfs/scrub.c       |   3 +
>>  fs/btrfs/volumes.c     |  21 ++-
>>  fs/btrfs/zoned.c       | 311 +++++++++++++++++++++++++++++++++++++++++
>>  fs/btrfs/zoned.h       |  40 ++++++
>>  6 files changed, 413 insertions(+), 12 deletions(-)
>>
>>diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>index c0f1d6818df7..e989c66aa764 100644
>>--- a/fs/btrfs/block-group.c
>>+++ b/fs/btrfs/block-group.c
>>@@ -1723,6 +1723,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
>>  static int exclude_super_stripes(struct btrfs_block_group *cache)
>>  {
>>  	struct btrfs_fs_info *fs_info = cache->fs_info;
>>+	bool zoned = btrfs_is_zoned(fs_info);
>>  	u64 bytenr;
>>  	u64 *logical;
>>  	int stripe_len;
>>@@ -1744,6 +1745,14 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
>>  		if (ret)
>>  			return ret;
>>+		/* shouldn't have super stripes in sequential zones */
>>+		if (zoned && nr) {
>>+			btrfs_err(fs_info,
>>+				  "Zoned btrfs's block group %llu should not have super blocks",
>>+				  cache->start);
>>+			return -EUCLEAN;
>>+		}
>>+
>
>I'm very confused about this check, namely how you've been able to 
>test without it blowing up, which makes me feel like I'm missing 
>something.
>
>We _always_ call exclude_super_stripes(), and we're simply looking up 
>the bytenr for that block, which appears to not do anything special 
>for zoned.  This should be looking up and failing whenever it looks 
>for super stripes far enough out. How are you not failing here 
>everytime you mount the fs?  Thanks,
>
>Josef

As previous discussion with David, we decided to exclude superblock
position of regular btrfs being allocated for zoned block groups, because
superblock is one of on-disk specification. (Sorry, I could not find a
pointer of the discussion) We also need to ensure some user data which
looks like a superblock won't corrupt the FS.

btrfs_find_allocatable_zones() is doing that exclusion ... this was my
understanding. But, to be precise, the function is just excluding
superblock log zones, not regular superblock positions.

However, it accidentally excludes superblock positions of regualr device.
We have superblocks on 16KB, 64MB and 256GB. And, we exclude zones 0, 1,
16, 17 and min(zones at 256GB, 1024). With typical 256MB zone size setup,
16KB and 64MB drop on zone 0, and 256GB on zone 1024. So, I was not hitting
this "if" on my test runs.

I'll fix btrfs_find_allocatable_zones() so that it also excludes regular
superblock positions.

Thanks,
