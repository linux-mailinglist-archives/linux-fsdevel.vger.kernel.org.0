Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0834A2C3F4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 12:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgKYLsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 06:48:33 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37851 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKYLsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606304913; x=1637840913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MfXSabwWThrsQ2QJVQqO1S+jI4x3V5qHhvhNdLhM9SE=;
  b=nORazrKTveq2dMQ++eyKUWmiVx0kEdyeEzBkdU77mYsmrhoM8iRiF24n
   mwXeMtZDirEJsMOFYUsLyUBVxfUQPBx4J9JA30NL0KgyUqIfC0wTO0V9D
   pu/RNv0oa2hWKFvtKjQhxW1oE2BtE+iqYwqV4cyB27OjAkeV4rSslhPhK
   HRF1hic6BWigjmflDMs4p/PyWdTssqPEbm5WQkZE6j4f+ydZIXZ5eD/q1
   TjpmhsxwliE4lhSzv/pNmaOoLiDlkO7kv0Jxtzj2yHK0lXfiKSE3aEwzJ
   RUafsj3LI4o9hPlTABNwPaafHdJUuSWuEuTnmmXaC7DdIEtP5jUrPbYhY
   g==;
IronPort-SDR: oETn5JaPYcakU203DNCoALK/cIKTQvmJuTzzAbRvJtTj1hwfSvVsFc1RjNuIlJf6Hq6j4o5DEH
 nr/EVno4DqDqU7gTKe0nkWY1YBkvUyJOfsHEeJmQxngs8brmZ1qCfzPxm6cFs2FQ2X7RDZ7x0A
 7PGWb1bLnSGvyIgmJml1I2FE6eKGuxquDgM61Y63oKEcVNAlKWREfftXJHpaeiXhO8zZf3LZI/
 mK99pEcnxJymIv43lAIayaKJj8x8qnEu7RbmtP0LJixnxFvBd7EzLXVctkkZGPcnxm/6/LR0tj
 xSE=
X-IronPort-AV: E=Sophos;i="5.78,368,1599494400"; 
   d="scan'208";a="263523165"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2020 19:48:32 +0800
IronPort-SDR: egyu33eNVAPWqnnRJZh6pnAQ1U90gp/am1GQYOedD3D39q7g1tGgnwNrhdX8sVQ2vXVbNOVBad
 5U6kuBKaF8J4kj0GRlozmh8o2Ls5svcPY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 03:34:16 -0800
IronPort-SDR: VWCth7ybW+8usgPuSjuRt0MKm3ENNY3Tgb8NNAzQJ29AXfHTIyN2czyBAq+Z1gM89BZ7Hz+/V8
 SPat2eEMwajA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 25 Nov 2020 03:48:31 -0800
Received: (nullmailer pid 3139161 invoked by uid 1000);
        Wed, 25 Nov 2020 11:48:31 -0000
Date:   Wed, 25 Nov 2020 20:48:31 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v10 12/41] btrfs: implement zoned chunk allocator
Message-ID: <20201125114831.hsleel7zazwlaf76@naota.dhcp.fujisawa.hgst.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <e7896fe18651e3ad12a96ff3ec3255e3127c8239.1605007036.git.naohiro.aota@wdc.com>
 <9cec3af1-4f2c-c94c-1506-07db2c66cc90@oracle.com>
 <20201125015740.conrettvmrgwebus@naota.dhcp.fujisawa.hgst.com>
 <c4e78093-0518-49b2-5728-79d68dc87dc5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c4e78093-0518-49b2-5728-79d68dc87dc5@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 03:17:42PM +0800, Anand Jain wrote:
>
>
>On 25/11/20 9:57 am, Naohiro Aota wrote:
>>On Tue, Nov 24, 2020 at 07:36:18PM +0800, Anand Jain wrote:
>>>On 10/11/20 7:26 pm, Naohiro Aota wrote:
>>>>This commit implements a zoned chunk/dev_extent allocator. The zoned
>>>>allocator aligns the device extents to zone boundaries, so that a zone
>>>>reset affects only the device extent and does not change the state of
>>>>blocks in the neighbor device extents.
>>>>
>>>>Also, it checks that a region allocation is not overlapping any of the
>>>>super block zones, and ensures the region is empty.
>>>>
>>>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>>
>>>Looks good.
>>>
>>>Chunks and stripes are aligned to the zone_size. I guess zone_size won't
>>>change after the block device has been formatted with it? For testing,
>>>what if the device image is dumped onto another zoned device with a
>>>different zone_size?
>>
>>Zone size is a drive characteristic, so it never change on the same device.
>>
>>Dump/restore on another device with a different zone_size should be banned,
>>because we cannot ensure device extents are aligned to zone boundaries.
>
>Fair enough. Do we have any checks to fail such mount? Sorry if I have 
>missed it somewhere in the patch?
>Thanks.

We have a check in verify_one_dev_extent() to confirm that a device
extent's position and size are aligned to zone size (patch 13).
