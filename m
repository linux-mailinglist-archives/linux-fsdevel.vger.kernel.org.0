Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8E96E238F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 14:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDNMo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 08:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNMo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:44:58 -0400
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Apr 2023 05:44:56 PDT
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2FF59E7;
        Fri, 14 Apr 2023 05:44:56 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 33B5011CC0A;
        Fri, 14 Apr 2023 15:34:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1681475699;
        bh=6eHJcBI5XG1X+5qba8P/84pQnzVU4oVxsQVFl2HGTl8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=vO3OQVh6xTQaXwKXhARpMn3pZp5rI4dMl5tRCqcWErkLRzQkQ/jJ54jrliKu51ztm
         QCyK1M5J8MGWe57hdsgaTGomJGfpi2UUj2DosPBYOeO8InY8rIGapOuk3oHw4RGrWa
         IMXcojxy4u5dhnoDObZGPxP0IGpfHJfHDyQRjp9DIaUvC/iQuXA8WMWuT2E/ZnHqkW
         n7DpdZmPKRf4WPhtRzLNzfIu3nzaxg/JF4rWXow4tdgeJiElBxmoy34sEIpvDQdTgT
         X5QxZCvW8RavWZKh87yXRDPBY5KD1zYkR9r5DP8STlFc04R3/5McCdhsdsMjHxINmw
         xTzMCxBDsBsHA==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 14 Apr
 2023 14:34:56 +0200
Message-ID: <86068780-bab3-2fc2-3f6f-1868be119b38@veeam.com>
Date:   Fri, 14 Apr 2023 14:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
Content-Language: en-US
To:     Donald Buczek <buczek@molgen.mpg.de>, <axboe@kernel.dk>,
        <hch@infradead.org>, <corbet@lwn.net>, <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <kch@nvidia.com>,
        <martin.petersen@oracle.com>, <vkoul@kernel.org>,
        <ming.lei@redhat.com>, <gregkh@linuxfoundation.org>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-4-sergei.shtepa@veeam.com>
 <cb0cc2f1-48cb-8b15-35af-33a31ccc922c@molgen.mpg.de>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <cb0cc2f1-48cb-8b15-35af-33a31ccc922c@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554647266
X-Veeam-MMEX: True
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/12/23 21:38, Donald Buczek wrote:
> Subject:
> Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
> From:
> Donald Buczek <buczek@molgen.mpg.de>
> Date:
> 4/12/23, 21:38
> 
> To:
> Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
> CC:
> viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
> 
> 
> I think, you can trigger all kind of user-after-free when userspace deletes a snapshot image or the snapshot image and the tracker while the disk device snapshot image is kept alive (mounted or just opened) and doing I/O.
> 
> Here is what I did to provoke that:
> 
> root@dose:~# s=$(blksnap snapshot_create -d /dev/vdb)
> root@dose:~# blksnap snapshot_appendstorage -i $s -f /scratch/local/test.dat
> device path: '/dev/block/253:2'
> allocate range: ofs=11264624 cnt=2097152
> root@dose:~# blksnap snapshot_take -i $s
> root@dose:~# mount /dev/blksnap-image_253\:16 /mnt
> root@dose:~# dd if=/dev/zero of=/mnt/x.x &
> [1] 2514
> root@dose:~# blksnap snapshot_destroy -i $s
> dd: writing to '/mnt/x.x': No space left on device
> 1996041+0 records in
> 1996040+0 records out
> 1021972480 bytes (1.0 GB, 975 MiB) copied, 8.48923 s, 120 MB/s
> [1]+  Exit 1                  dd if=/dev/zero of=/mnt/x.x
> 

Thanks!
I am very glad that the blksnap tool turned out to be useful in the review.
This snapshot deletion scenario is not the most typical, but of course it is
quite possible.
I will need to solve this problem and add such a scenario to the test suite.

