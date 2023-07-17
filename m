Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FAB7566A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 16:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjGQOkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 10:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjGQOkO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:40:14 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADB210DF;
        Mon, 17 Jul 2023 07:40:11 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 55C5741D18;
        Mon, 17 Jul 2023 10:40:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1689604808;
        bh=Pwh+6BKATXlzMY/0vs5/6BSZ4BXrZSlQNcFaAamt3eU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=Adq03v/jALeVIjYIT0f7+HUydl+LQABSjOpd1ZRRqWEflsvaQqDTH3HXaIoeR1wdd
         9/BWuq6Q5UJsTXskcJwbtKxqDxgUVxZ73zXINy7uEZg/bH2Erb1PKPgs3sAvIOjgL8
         Z8ZzUWeajvsygdgqOSelPoqbyL2NTpWotf0WmkL7lspgFrgSJsRpAUe9pYAf88bNSd
         ueYVJVkjRGjGB0yL3fhsm8LEIhJZzUYqQOhQc+NMFEj++3YOs0g5hputoTUW4+5W+G
         m018T4ShEQn44ZF2q8ASes4XifNIkdi1vKtpe1ltZj6VDONFfCM1Cnf5Ltypp87h4p
         DnZceBUr5c8Bg==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Mon, 17 Jul
 2023 16:40:01 +0200
Message-ID: <90f79cf3-86a2-02c0-1887-d3490f9848bb@veeam.com>
Date:   Mon, 17 Jul 2023 16:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, <axboe@kernel.dk>,
        <hch@infradead.org>, <corbet@lwn.net>, <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <dchinner@redhat.com>, <willy@infradead.org>, <dlemoal@kernel.org>,
        <linux@weissschuh.net>, <jack@suse.cz>, <ming.lei@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-3-sergei.shtepa@veeam.com>
 <f935840e-12a7-c37b-183c-27e2d83990ea@huaweicloud.com>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <f935840e-12a7-c37b-183c-27e2d83990ea@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: colmbx01.amust.local (172.31.112.31) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A292403155B677461
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/11/23 04:02, Yu Kuai wrote:
> bdev_disk_changed() is not handled, where delete_partition() and
> add_partition() will be called, this means blkfilter for partiton will
> be removed after partition rescan. Am I missing something?

Yes, when the bdev_disk_changed() is called, all disk block devices
are deleted and new ones are re-created. Therefore, the information
about the attached filters will be lost. This is equivalent to
removing the disk and adding it back.

For the blksnap module, partition rescan will mean the loss of the
change trackers data. If a snapshot was created, then such
a partition rescan will cause the snapshot to be corrupted.

There was an idea to do filtering at the disk level,
but I abandoned it.
