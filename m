Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5E4165A99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 10:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgBTJ4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 04:56:35 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16830 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgBTJ4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582192595; x=1613728595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KmavIB9/Wp/v1Et2wFcXI7Qd0b4eJQMI6Ftrc/H/gLI=;
  b=pcUmPLAZnsTF26NYZG8MwPUKFlfuNq5SaNTyq5qG/XB7rQTCnIJ28d2T
   E05AGOSadc5KkokvQ16z+KkNwERvphxxKVmgz7hWJBO+d8bP6M2thDpD/
   4V7aOQcuIWHPqIOzqVE4iYr6nUqif2MCuPTXroIiWAJuqiiJPH4vs3XCq
   4p+KLIrxBUua+F4wiAAdmwIe+3X8Nf+k3rEfA6wuzFINYUd7ZAciPivkK
   h19RhoJuNf66uEHWsA/0AChR0wbslFLtPDQ4g5xI/+/fxcA/pCZJzjbFX
   6hXDKPpS6HV/pQkB94kMJDkYlSvl9l5MR/h+UTBGOdAoaHzZxiM6yKWhf
   Q==;
IronPort-SDR: VqIBlQNRh6p3uFcnK0Rm9Iq5E50UxcZ0hidv73OvQp+9VCiakJ+32r92DuN7PwdfTBhc0FHlk5
 c/XrLLA8fhAjwV4R8i0ilLrxhWfV3PhRLWZJCE79nJOXyrN2PkeCRsmIZTP9jaFJ+1EFDNNaYy
 NltcbPk64srtpmFC9BOIL7cD0+a+ZHQFWVfQ3KwnzKvid9Ld1U5jfttENBs7V/36kBeJrFRmHq
 t8Ed+TnjvDoJPiBC0vaEbFHjiNsaKMK6G8YISQP15o25PLalLYZDZ79Nsiiqm6P2hWws77s1qT
 dxw=
X-IronPort-AV: E=Sophos;i="5.70,464,1574092800"; 
   d="scan'208";a="134632971"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2020 17:56:35 +0800
IronPort-SDR: kb9adBekLNlUZTI2vLpVJ7Sf+Piax65g7PY7fKWz3qVfEnKo6NCWrMNp4F5ZYLymM6gBSdyYai
 JBxV52+/A6PxmnekcCv1aRD0pIPZ6PO+/VBjdQu4gRW9T6aEcN5G2n2ZuP3lKCZfenQhGyMiKx
 O4WrzwO4Wjd5MSHvYxfbItClfUIoW+JIpPQziRpB+w/gCd2ybLZxoFBHxesfmOB6+xJfMuXzPj
 AyFxeW/q3ejSitP9M6YzaEh2fP6dZ8IWopwgOxFxJGGl2dV1tKWXIDcXGpJwSBSufHFWyHB9hs
 8IOR6TbIWSBaubDoLfpS8F64
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 01:49:10 -0800
IronPort-SDR: O+MgqHgyePFnjObHnBr93JFf9c1ZaOEP/D9irRkaIrSXsn41vo2rxSox70phqAEprGufymfTL/
 I4SSbLjabZRHHLub/rb06qFgOVapLIfVzxz5EiacTMS+DBUMDP/W+HirI4+eqGRAYGydtdXxY4
 WswvYXF5Eu/R5qHIz6qHSrTuF3baxM2b2pAR/dQxGxcP8iFC9+5xlFYRF0JU7JJek4xPHRrj9E
 Q5KNkV/k0sJZThRXL9gPdSm2HzV131jgkcjQM/D2SleNStdfbYU6V90wRE3O8vAM2/cZVyZ3t0
 KRk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 20 Feb 2020 01:56:32 -0800
Received: (nullmailer pid 2493929 invoked by uid 1000);
        Thu, 20 Feb 2020 09:56:31 -0000
Date:   Thu, 20 Feb 2020 18:56:31 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 20/21] btrfs: skip LOOP_NO_EMPTY_SIZE if not clustered
 allocation
Message-ID: <20200220095631.7rlk7lmnp7np4nvg@naota.dhcp.fujisawa.hgst.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-21-naohiro.aota@wdc.com>
 <b8908ae0-9e4d-5086-0d4c-768d45215695@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b8908ae0-9e4d-5086-0d4c-768d45215695@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:55:30PM -0500, Josef Bacik wrote:
>On 2/12/20 2:20 AM, Naohiro Aota wrote:
>>LOOP_NO_EMPTY_SIZE is solely dedicated for clustered allocation. So,
>>we can skip this stage and go to LOOP_GIVEUP stage to indicate we gave
>>up the allocation. This commit also moves the scope of the "clustered"
>>variable.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/extent-tree.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>>diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>index 8f0d489f76fa..3ab0d2f5d718 100644
>>--- a/fs/btrfs/extent-tree.c
>>+++ b/fs/btrfs/extent-tree.c
>>@@ -3373,6 +3373,7 @@ enum btrfs_loop_type {
>>  	LOOP_CACHING_WAIT,
>>  	LOOP_ALLOC_CHUNK,
>>  	LOOP_NO_EMPTY_SIZE,
>>+	LOOP_GIVEUP,
>
>Why do we need a new loop definition here?  Can we just return ENOSPC 
>and be done?  You don't appear to use it anywhere, so it doesn't seem 
>like it's needed.  Thanks,
>
>Josef

This is for other allocation policy to skip unnecessary loop stages
(e.g. LOOP_NO_EMPTY_SIZE) from an earlier stage. For example, zoned
allocation policy can implement the code below in
chunk_allocation_failed() to skip the following stages.

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4badfae0c932..0a18c09b078b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3775,6 +3854,10 @@ static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
                  */
                 ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
                 return 0;
+       case BTRFS_EXTENT_ALLOC_ZONED:
+               /* give up here */
+               ffe_ctl->loop = LOOP_GIVEUP;
+               return -ENOSPC;
         default:
                 BUG();
         }

But, I can keep this LOOP_GIVEUP introduction patch later with this
zoned allocator ones.

Thanks,
