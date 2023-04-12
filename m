Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DADA6DF241
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 12:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDLKyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 06:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDLKyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:54:02 -0400
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Apr 2023 03:54:00 PDT
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E106A68;
        Wed, 12 Apr 2023 03:54:00 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 5E49F410B4;
        Wed, 12 Apr 2023 06:44:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1681296243;
        bh=TPNFqwLjRJ0dSpelUvGaISC1WZt9udnm/M5g6U8mfho=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=Jpb8mQX0tWPhAyC1eUZUt5p5BKcZObgs+b8rksCcYb9kgV/bhPACDz2ybdMU7fHbD
         rKc02SQyUElrSx/P2moawjLbDIcR1lPCQnl1bRJ/AM0Er82gEZn+MOIdvX6hYuHbfO
         TMaGu2Zj6hm1txK79Hfzij6tu7JDOIDSD9WthyTLuukW+fSoPSeePCYvZTyoNxrJQg
         BlIWPLhcW06CmqJPl+ZDTtX+U+HRwgQmVXsuYaqYIlz/ERk1uvYNktDW8zPHYlJH7c
         Wt72/OL8nsYim8iO4HeXtbcqqnz5lO2aG04x6BllElCSXLxUc88kqekrJZckD6hOah
         OEnLHTcj0Vryg==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 12 Apr
 2023 12:43:56 +0200
Message-ID: <50d131e3-7528-2064-fbe6-65482db46ae4@veeam.com>
Date:   Wed, 12 Apr 2023 12:43:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 02/11] block: Block Device Filtering Mechanism
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>
CC:     <axboe@kernel.dk>, <corbet@lwn.net>, <snitzer@kernel.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <kch@nvidia.com>,
        <martin.petersen@oracle.com>, <vkoul@kernel.org>,
        <ming.lei@redhat.com>, <gregkh@linuxfoundation.org>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-3-sergei.shtepa@veeam.com>
 <793db44e-9e6d-d118-3f88-cdbffc9ad018@molgen.mpg.de>
 <ZDT9PjLeQgjVA16P@infradead.org>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <ZDT9PjLeQgjVA16P@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: colmbx01.amust.local (172.31.112.31) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554647062
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/11/23 08:25, Christoph Hellwig wrote:
> Subject:
> Re: [PATCH v3 02/11] block: Block Device Filtering Mechanism
> From:
> Christoph Hellwig <hch@infradead.org>
> Date:
> 4/11/23, 08:25
> 
> To:
> Donald Buczek <buczek@molgen.mpg.de>
> CC:
> Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
> 
> 
> On Sat, Apr 08, 2023 at 05:30:19PM +0200, Donald Buczek wrote:
>> Maybe detach the old filter and attach the new one instead? An atomic replace might be usefull and it wouldn't complicate the code to do that instead. If its the same filter, maybe just return success and don't go through ops->detach and ops->attach?
> I don't think a replace makes any sense.  We might want multiple
> filters eventually, but unless we have a good use case for even just
> more than a single driver we can deal with that once needed.  The
> interface is prepared to support multiple attached filters already.
> 


Thank you Donald for your comment. It got me thinking.

Despite the fact that only one filter is currently offered for the kernel,
I think that out-of-tree filters of block devices may appear very soon.
It would be good to think about it in advance.
And, I agree with Christophe, we would not like to redo the blk-filter interface
when new filters appear in the tree.

We can consider a block device as a resource that two actor want to take over.
There are two possible behavioral strategies:
1. If one owner occupies a resource, then for other actors, the ownership
request will end with a refusal. The owner will not lose his resource.
2. Any actor can take away a resource from the owner and inform him about its
loss using a callback.

I think the first strategy is safer. When calling ioctl BLKFILTER_ATTACH, the
kernel informs the actor that the resource is busy.
Of course, there is still an option to grab someone else's occupied resource.
To do this, he will have to call ioctl BLKFILTER_DETACH, specifying the name
of the filter that needs to be detached. It is assumed that such detached
should be performed by the same actor that attached it there.

If we replace the owner at each ioctl BLKFILTER_ATTACH, then we can get a
situation of competition between two actors. At the same time, they won't
even get a message that something is going wrong.

An example from life. The user compares different backup tools. Install one,
then another. Each uses its own filter (And why not? this is technically
possible).
With the first strategy, the second tool will make it clear to the user that
it cannot work, since the resource is already occupied by another.
The user will have to experiment first with one tool, uninstall it, and then
experiment with another.
With the second strategy, both tools will unload each other's filters. In the
best case, this will lead to disruption of their work. At a minimum, blksnap,
when detached, will reset the change tracker and each backup will perform a
full read of the block device. As a result, the user will receive distorted
data, the system will not work as planned, although there will be no error
message.

