Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A41F28B148
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 11:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgJLJRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 05:17:48 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29060 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgJLJRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602494492; x=1634030492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W++OrlzE97qwBvZF64ZDGrRiVg45COERqUhZpScC4tg=;
  b=UpfZOENJlM/aEt+pSvwsocYCH//T7xXlSq4ErcFv+Mq/zN3ct4SoLo04
   9A3MMqXBIyCyx/CYCVTeyOlq9jB41z+rvuwFUd2NuEiPpL8yY0ututVCD
   +DeWz3nTGjRXRHXxDf2NzcCt2aACEyBg2wnHqZVhHLC27zF56TZFt35md
   ZLe3oNpXaaLdvyKllqiWc7HZ4oA6SQac6HnBB9Xebek/Vpo+E1CQX+282
   hQisIeQsAXqr11OC25ZaGupESvfSHLwVcaS8cuLnvBXreojzQX5oimgic
   xTkuRwpXH4W69hZXEOjZDQ2UpAZ9Sm8RPj4MhqIBEk2El0kzEDv1CvMbo
   g==;
IronPort-SDR: 5Q+n37NTfKCw72j3tg1/le2mytT7OkGOrTB943LChdufhHWbTTJpBUPBR2k653VdTAycjtNa5m
 sdVSIDBGEgnRS8nCd86kedFYoPRvpa+yvoZt1vwmqN6s2WQfwAyXNalDCNd3gGA1Mtbg0gs8BN
 4urWF2OGKwtGpuDus8WzZkrCyVgrEN8I6VDO/1stjHKGwP6O6dgGGcyWPKUewlvQGlGyLmROx+
 VUyQlxQIyc/KYx3guqDwITsVx6NorvgIgfKrSQhHxXxKuZz9HrJYU1dNRIIjOAOAfGfUH1UVED
 XRQ=
X-IronPort-AV: E=Sophos;i="5.77,366,1596470400"; 
   d="scan'208";a="253073073"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2020 17:21:31 +0800
IronPort-SDR: E74Qok3XHuHvoskjDpJGBZXXgyBmr8wAdvDGivCSwH8Z+oQfrHua+8Li0k+Jm1g7DUMKKWlZpF
 nVDOaIT/e2qUH1xmfF9Oi6S6bZNymWvZxA9H3+YsgxPdKMXwQ3KRau98pfIl25aGcvoBre/s07
 KHrZz0EHIwc5Fxnibx7Q54pZKOGFJUY2chpgvhRKoi1ZdcAklNT1LwUWVpLmtXYF0bKLxKoFSI
 oHGw36Kh/NmdRtJzkBUzctp6txGnHGvwt0MMBgQumzsEMt2kqyg4uO1plZKGUqLehtB/Qiwb9M
 9M/Ryscp3wnaVFWsGOaF3SDD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 02:04:22 -0700
IronPort-SDR: /3Tjbs8ony8g/+g7phg0fIfsb1DmZtaeRxvKDJJlC4v+D0Mxxp7KfRwPmF9qVmi1ZqPCRQDTdQ
 QECPiraivwxB7KVjIMeDqJe20wWH4jJI/GhGrVPX4XkhHEpvCh4xTAXA2BaFOvEkAR1+VNs35g
 Ey2gry3QWuJ4dQAZZxOrzq1Ttbp9pbMpE3D9bMZVwITorvJbKOmk+hymneQPFg2EVfY/MdxTUr
 dVx6C0lchJw1ZmCTn8Q5SUE0uvpoTl+zAvDYt2HJvBA5U+I+WETTuqmpEg8YT3hf7S0Cq5JmBU
 8/4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 12 Oct 2020 02:17:46 -0700
Received: (nullmailer pid 829325 invoked by uid 1000);
        Mon, 12 Oct 2020 09:17:45 -0000
Date:   Mon, 12 Oct 2020 18:17:45 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 00/41] btrfs: zoned block device support
Message-ID: <20201012091745.pgqm3lctkjgxbwpb@naota.dhcp.fujisawa.hgst.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
 <8a20cbf8-9049-6e6f-b618-9b4be7633f82@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8a20cbf8-9049-6e6f-b618-9b4be7633f82@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 09, 2020 at 11:40:36AM -0400, Josef Bacik wrote:
>On 10/1/20 2:36 PM, Naohiro Aota wrote:
>>This series adds zoned block device support to btrfs.
>>
>>Changes from v7:
>>  - Use bio_add_hw_page() to build up bio to honor hardware restrictions
>>    - add bio_add_zone_append_page() as a wrapper of the function
>>  - Split file extent on submitting bio
>>    - If bio_add_zone_append_page() fails, split the file extent and send
>>      out bio
>>    - so, we can ensure one bio == one file extent
>>  - Fix build bot issues
>>  - Rebased on misc-next
>>
>
>This is too big of a patch series for it to not conflict with some 
>change to misc-next after a few days.  I finally sat down to run this 
>through xfstests locally and I couldn't get the patches to apply 
>cleanly.  Could you push this to a git branch publicly somewhere so I 
>can just pull from that branch to do the xfstests testing I want to do 
>while I'm reviewing it?  Thanks,
>
>Josef

Indeed. I pushed zoned btrfs kernel & userland tools to the branches below.

I also prepared pre-compiled userland binaries because they require patched
util-linux (libblkid) to deal with the log-structured superblock.

kernel https://github.com/naota/linux/tree/btrfs-zoned
userland https://github.com/naota/btrfs-progs/tree/btrfs-zoned
pre-compiled userland https://wdc.app.box.com/s/fnhqsb3otrvgkstq66o6bvdw6tk525kp

Thanks,
Naohiro
