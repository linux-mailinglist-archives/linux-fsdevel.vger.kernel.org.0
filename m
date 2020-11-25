Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8A02C3F51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 12:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgKYLug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 06:50:36 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38620 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgKYLuf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606305035; x=1637841035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1528qdtQvDekfaSQWQ3/RaKGxVHeNOafHT1DPKSWueE=;
  b=ieU2i/3v+QSAR8WqxQ3xiOLMTole9ttk1bO1voTeeE2OxGIyjdg+FxfR
   dNWpHtfOISayxL3TLrLI1F2kF8FYYy9zaO8G6D2bi5shDa0C6UTkV8+8F
   EgV2Rsy8/jrd+HhVyTEGU08ow0u9viljGjMA0tWXoyN213swomaOn28Sz
   mNBmNoRMIsVmDSOCwkT3vofu1wvIaLMH1UpUm6WJWnfVok/T1vW1k/4B0
   cz3e1FDGfhYp4C06EF0qbl3eMEoLpiBZOZkWF/XLeiIED1Ol9RlIBClhj
   cGyEPthLTeer5YpF5oorlKHBWODQF8GgIg9Hm4EtTgTHEpU79qyb+Uk6Q
   A==;
IronPort-SDR: ka0fZKLiVzXW8mCgoBvwgqKQv/NTLXRG7bJ96ZqFdrwJVms4ZGlu42XJBrMKW/WgQGAAIj4i/b
 gqAV3C+z8IzclbNlFzEZ73E7nz44y1on1YP+901r4VOyiJyRh6iQYfuk7lZ+v2/A7Th1kLAwnM
 qZBKRrF1FZy5dhQbwRmhCPuNT5OwdfBhJIQp0DsZr/UVDEr7OGhr3qJBQ3GBH0iPRwNQG0ojNh
 A32NDHCcqkUVBAhirFEKXx8P80lq8KXE6MMBU91SkemNPjjQgBb0v705CT8heEFJDRoNp0Sh4W
 Cew=
X-IronPort-AV: E=Sophos;i="5.78,368,1599494400"; 
   d="scan'208";a="153380121"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2020 19:50:34 +0800
IronPort-SDR: UFq61Tze2pIMEVxZeSMBzflRk6QW8FGrfj6k1/cc5/AU7MhFFrOTO0wxrpQ3IUeI25lIbxd3gk
 0mRQr3Iz8avdsvPcLhLaKNdbmhrwKNgW8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 03:34:57 -0800
IronPort-SDR: LQBZFqJRtReuUsqkBx4x0syc6JvVzTSGes5UTo7GWh39js03mlaz3ZicGbLYsLW2QIldRlZDb1
 PI2cLecUU+Eg==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 25 Nov 2020 03:50:33 -0800
Received: (nullmailer pid 3139992 invoked by uid 1000);
        Wed, 25 Nov 2020 11:50:32 -0000
Date:   Wed, 25 Nov 2020 20:50:32 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v10 12/41] btrfs: implement zoned chunk allocator
Message-ID: <20201125115032.f4eng536pxshee5c@naota.dhcp.fujisawa.hgst.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <e7896fe18651e3ad12a96ff3ec3255e3127c8239.1605007036.git.naohiro.aota@wdc.com>
 <9cec3af1-4f2c-c94c-1506-07db2c66cc90@oracle.com>
 <20201125015740.conrettvmrgwebus@naota.dhcp.fujisawa.hgst.com>
 <a97ef4b3-4973-1078-8537-5e814a24ef32@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a97ef4b3-4973-1078-8537-5e814a24ef32@cobb.uk.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 09:59:40AM +0000, Graham Cobb wrote:
>On 25/11/2020 01:57, Naohiro Aota wrote:
>> On Tue, Nov 24, 2020 at 07:36:18PM +0800, Anand Jain wrote:
>>> On 10/11/20 7:26 pm, Naohiro Aota wrote:
>>>> This commit implements a zoned chunk/dev_extent allocator. The zoned
>>>> allocator aligns the device extents to zone boundaries, so that a zone
>>>> reset affects only the device extent and does not change the state of
>>>> blocks in the neighbor device extents.
>>>>
>>>> Also, it checks that a region allocation is not overlapping any of the
>>>> super block zones, and ensures the region is empty.
>>>>
>>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>>
>>> Looks good.
>>>
>>> Chunks and stripes are aligned to the zone_size. I guess zone_size won't
>>> change after the block device has been formatted with it? For testing,
>>> what if the device image is dumped onto another zoned device with a
>>> different zone_size?
>>
>> Zone size is a drive characteristic, so it never change on the same device.
>>
>> Dump/restore on another device with a different zone_size should be banned,
>> because we cannot ensure device extents are aligned to zone boundaries.
>
>Does this mean 'btrfs replace' is banned as well? Or is it allowed to a
>similar-enough device? What about 'add' followed by 'remove'?

Replacing is allowed if the zone size is the same. Adding a disk is the
same. This restriction is checked in btrfs_init_new_device() (patch 5).
