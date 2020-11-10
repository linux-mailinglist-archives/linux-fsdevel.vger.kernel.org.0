Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC5B2AD3FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 11:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgKJKms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 05:42:48 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:32599 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJKms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605005115; x=1636541115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IR6s48VUF79F7IHuTbSyeydOgtg3RNNnWrFvk1zoqUQ=;
  b=ZtgBi0xrwtEqJiD7NjmAT+kVp9IB3cUEhHHv50WxRJDs6AOYvMJKlscx
   qwlvlT+rIdb8mP4AynuLymSAJ2aFWECH6HvSvEyMHppsfcxRUNrsIQm1w
   yRfFuBA8RiExngvirKff5gv1g5E4HQM4aHANpZqLgff4zZ0CWGezmc+qy
   Hvv2fpd61c/DZ4i6ghH2yPqBGIbtqablm+wfMaSCvV2+2c32G1M8dA1hC
   tdXFXwDYiYlR7Aiz0S+fqAXQuQaJ1nk02E1LQ9qYYe/D4Put2gg3wK7Dj
   YS5U5C6Bcb+pZWhkM559pHdlwkpuoLtpCtHD5DhCSqMGEDPhthjeWtcyh
   A==;
IronPort-SDR: jvJFJTUSL7RpZR9BpINkaCymMs8ag4YScGu40UJO0Z2NhpjZ7M5GtFoKGEWZcoQjUTjmxPyzXN
 atWb3qKSZTS1iCQrxHOlfs9zAKXgwSp5aMHGo6KKBttRopQOCLn/y1BazgEppyIDQ/c/ZAh+un
 lcbOtFYVkcMusoTGfzFzma6bglHyNE8B+luFuHMOb8HaNtis9g8HmgbI/mEjaUqGQn8y+A6SED
 jGJJBGFBsSy+Om4fp+4/ov931ioaOOc95TEqM7b4o3iykR6FIj3mJquX0fiUKg+nRy0BpKikUN
 sGY=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="255828431"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 18:45:14 +0800
IronPort-SDR: F9Gp/oKWQPNrU8ewbZqKyiUnSGDhyGbDeBB9hS7I57JydxDkZ2WTCU3jfqSAEgABJUn41DLdep
 qwiIuXXfmcn5rHwLOHvlGpHGFpsChDcEZlOMrVF3EKhl1ROf2+LeUI1toCQ97jlxmwIQa9c0qF
 oXnidcaFI4H/cPyNbQn306w+HYFUx9FLTnCIXyJE8omVf4PK+jHxHJxXQ7X6b+KCf9gTkcKAXS
 88By02lsfpvON77xYV1v4WD2M9K8yeG3K2IaIhrgmmWac81UkYJERQ1+iC/H2GKIj3gN/qysnw
 2/oaRWyGSJMwbtL3brL4I4Vf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 02:28:47 -0800
IronPort-SDR: R+WLjIUfVJnI/Z8Tadt2QcqFSYVkeU0j7XWeur53RHplpJZmktlg4d0OpREXtaFysDEnKVHCD2
 1Apmpk9iSkIOHV4XBBaioQ0LDBIOWYzhzHqmgcEy+6qNP83FF2AjV2138jJp2rM+50A6xqWEqA
 4W1mZQ8glhWbbrrqd7RRQfKilNNbbIDiqv925+RmPgQIFlH0UYarUxkvdTjt/91BhDJhCfl58W
 PTezwyYMGnZ2563nmsbR++6/wMkFDD5Ny7wHtIercO0hkaB1944bJb5+OCjHXWxtOSg9cn9Qf3
 XYQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 10 Nov 2020 02:42:44 -0800
Received: (nullmailer pid 1897817 invoked by uid 1000);
        Tue, 10 Nov 2020 10:42:45 -0000
Date:   Tue, 10 Nov 2020 19:42:45 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 21/41] btrfs: use bio_add_zone_append_page for zoned
 btrfs
Message-ID: <20201110104245.sk635cfxu5vjqedo@naota.dhcp.fujisawa.hgst.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <ad4c16f2fff58ea4c6bd034e782b1c354521d696.1604065695.git.naohiro.aota@wdc.com>
 <0883ec98-4b59-5e74-ba81-d477ca4e185f@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0883ec98-4b59-5e74-ba81-d477ca4e185f@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:55:49AM -0500, Josef Bacik wrote:
>On 10/30/20 9:51 AM, Naohiro Aota wrote:
>>Zoned device has its own hardware restrictions e.g. max_zone_append_size
>>when using REQ_OP_ZONE_APPEND. To follow the restrictions, use
>>bio_add_zone_append_page() instead of bio_add_page(). We need target device
>>to use bio_add_zone_append_page(), so this commit reads the chunk
>>information to memoize the target device to btrfs_io_bio(bio)->device.
>>
>>Currently, zoned btrfs only supports SINGLE profile. In the feature,
>>btrfs_io_bio can hold extent_map and check the restrictions for all the
>>devices the bio will be mapped.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/extent_io.c | 37 ++++++++++++++++++++++++++++++++++---
>>  1 file changed, 34 insertions(+), 3 deletions(-)
>>
>>diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>index 17285048fb5a..764257eb658f 100644
>>--- a/fs/btrfs/extent_io.c
>>+++ b/fs/btrfs/extent_io.c
>>@@ -3032,6 +3032,7 @@ bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
>>  {
>>  	sector_t sector = logical >> SECTOR_SHIFT;
>>  	bool contig;
>>+	int ret;
>>  	if (prev_bio_flags != bio_flags)
>>  		return false;
>>@@ -3046,7 +3047,19 @@ bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
>>  	if (btrfs_bio_fits_in_stripe(page, size, bio, bio_flags))
>>  		return false;
>>-	return bio_add_page(bio, page, size, pg_offset) == size;
>>+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
>>+		struct bio orig_bio;
>>+
>>+		memset(&orig_bio, 0, sizeof(orig_bio));
>>+		bio_copy_dev(&orig_bio, bio);
>>+		bio_set_dev(bio, btrfs_io_bio(bio)->device->bdev);
>>+		ret = bio_add_zone_append_page(bio, page, size, pg_offset);
>>+		bio_copy_dev(bio, &orig_bio);
>
>Why do we need this in the first place, since we're only supporting 
>single right now?  latest_bdev should be the same, so this serves no 
>purpose, right?
>
>And if it does, we need to figure out another solution, because right 
>now this leaks references to the bio->bi_blkg, each copy inc's the 
>refcount on the blkg for that bio so we're going to leak blkg's like 
>crazy here.  Thanks,
>
>Josef

True. I just tried to make it multipe device ready as much as possible.

I'll drop this part for now, and will fix this when we add multipe device
support.
