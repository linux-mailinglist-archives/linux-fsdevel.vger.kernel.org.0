Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E2E2F48E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 11:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbhAMKmT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 05:42:19 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21481 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbhAMKmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610534930; x=1642070930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1coX7kAwUe0LPk/zrUpTwwDI3hk732UpFXNIYnhsFrI=;
  b=T5niHmq15nR3G+wTtmldIWWwlqcLSSYuV/6cfEv2Rt1v47prwd5BLJpS
   Q14XBqGDR8SYV8rzpF3QJB0aqsaZyvLp5DpFP/hDU3mZ0ICKx4RRzxjke
   S/1cwABLPaiqO+X8k/jZ6Ue4NeNSSlpBjJpiH2ytzrVjHZoE07qUpePXO
   FqhjTB9MrWPfHE3lfvJ1fq6q/8ERQDsXwil/c9vNqyKXyp6XfFRBQbDRd
   wEHjcR2NuX4JE/aeTkMmJeBPlrLQCrcUIhsCT915IH6O+ScGlAJZMAUBn
   VA4fHlcgYJm2M9wKTNS/NKq/LNurV9A7wjUDu/V+urD5QBCKIJDEiGva2
   A==;
IronPort-SDR: 3YCnLwijngwxyLn7tNQjW+tmeupI1rPPFLaJTM5EQCs0veVNDkCyivPusAEFK1L7P4SEZdF/g8
 emvWnq3PDrwEh8E4AInUzjE4TpBR2iq5B6oGQUh43KVDEExBih3L2DEL5VAbjOsbEp8LmbjsX9
 B2ysNPSepK8aj1IuW4I14WXLactPJ7yiUmHsawbCb+bkjY2rpaQIDX8wbbLvgfxo0dwg+JQJVI
 KgcthkMkIn2ekN2vo1MWaC/fQQCtBJ5L7H8nDRodKMqxyiqMEG9Jlqi8XiUxiYBvlL5ujPyHWJ
 iPw=
X-IronPort-AV: E=Sophos;i="5.79,344,1602518400"; 
   d="scan'208";a="261232821"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 18:47:11 +0800
IronPort-SDR: /Dy98GsJ71+c/fWBmWGKVNLhsqw76Ho1W1Km9aLG9ojRP2BuXY4GCsgWnSkPTQoBPNa1Sf4iXq
 kcUWglTymcgUluR/xqw439Z17VMLy8i6aFo9ojwvgYyIzetXFxQmTuFhU+TITi2V8+ZYWccR5n
 ptm4x7+x0uV3CjIR/afvvCFhtN1yzd1Smpl4bljdkvRNSFYBx7Z1PIE+WijUPjC4vnq0cafRn8
 I8eLvsXsmbUoeQTAMtzvC4D6v8zfJHkcJv14sMluegb5laZAgnd4j2giAvHoSqh5VoerZeZCPU
 ApfDnZs3M2YubasUQ7jv5Xx5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 02:24:02 -0800
IronPort-SDR: A3zyPNEAp35ckAFmlUqqdZ64BkC68+8MJWGaAL/5ypBUv02WJ8AiGLzUsWSNyjwZFG2GT0LUU/
 X8d1c3YBAuRWu8ts9hABy/9ldLZXl5w9HrKGqA82YhtSY+aMT5jvED/FADX/KVJEf6fFuLIAuk
 DkwMJHF7188hmuEPV8enEPms2wS96nHQe1zs0YLU9yXQAEfJmuyqvoyslktO4H8skIY69WG9Cz
 l/84/JhvZVbR/us+xPlgvUBTp7gXkj9J5PmXWfh9P/uOQWKWWe7uYq0+8cF/PHUQIkSFnN5wDO
 WpY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 13 Jan 2021 02:41:11 -0800
Received: (nullmailer pid 503073 invoked by uid 1000);
        Wed, 13 Jan 2021 10:41:11 -0000
Date:   Wed, 13 Jan 2021 19:41:11 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v11 27/40] btrfs: introduce dedicated data write path for
 ZONED mode
Message-ID: <20210113104111.3yntypwyna3tegx6@naota.dhcp.fujisawa.hgst.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <2b4271752514c9f376b1fc6a988336ed9238aa0d.1608608848.git.naohiro.aota@wdc.com>
 <5c4596ba-06b5-e972-bf85-5a6401a4dd16@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5c4596ba-06b5-e972-bf85-5a6401a4dd16@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 02:24:09PM -0500, Josef Bacik wrote:
>On 12/21/20 10:49 PM, Naohiro Aota wrote:
>>If more than one IO is issued for one file extent, these IO can be written
>>to separate regions on a device. Since we cannot map one file extent to
>>such a separate area, we need to follow the "one IO == one ordered extent"
>>rule.
>>
>>The Normal buffered, uncompressed, not pre-allocated write path (used by
>>cow_file_range()) sometimes does not follow this rule. It can write a part
>>of an ordered extent when specified a region to write e.g., when its
>>called from fdatasync().
>>
>>Introduces a dedicated (uncompressed buffered) data write path for ZONED
>>mode. This write path will CoW the region and write it at once.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>
>This means we'll write one page at a time, no coalescing of data 
>pages.  I'm not the one with zoned devices in production, but it might 
>be worth fixing this in the future so you're not generating a billion 
>bio's for large sequential data areas.

Actually, it is already wrting multiple pages in one bio. We get a
delalloced range
that spans multiple pages from btrfs_run_delalloc_range() and write all the
pages with one bio in extent_write_locked_range().

>
>Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
>Thanks,
>
>Josef
