Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D76668A53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 04:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjAMDnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 22:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjAMDnj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:43:39 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C6A5792D;
        Thu, 12 Jan 2023 19:43:36 -0800 (PST)
Received: from kwepemm600015.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NtRx85pJNzJqFG;
        Fri, 13 Jan 2023 11:39:24 +0800 (CST)
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 13 Jan 2023 11:43:33 +0800
Message-ID: <119e1460-26ab-7eee-4479-5c14a824b3c7@huawei.com>
Date:   Fri, 13 Jan 2023 11:43:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 0/2] initialize 'struct hfsplus_inode_info' in
 hfsplus_iget()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bvanassche@acm.org>, <gargaditya08@live.com>, <axboe@kernel.dk>,
        <willy@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <jlayton@kernel.org>, <hannes@cmpxchg.org>, <tytso@mit.edu>,
        <muchun.song@linux.dev>
References: <20221215081820.948990-1-chenxiaosong2@huawei.com>
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
In-Reply-To: <20221215081820.948990-1-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew and Viacheslav:

Do you have any suggestions for this patchset ?

在 2022/12/15 16:18, ChenXiaoSong 写道:
> ChenXiaoSong (2):
>    hfsplus: introduce hfsplus_init_inode() helper
>    hfsplus: fix uninit-value in hfsplus_delete_cat()
> 
>   fs/hfsplus/hfsplus_fs.h |  1 +
>   fs/hfsplus/inode.c      | 35 ++++++++++++++++++++---------------
>   fs/hfsplus/super.c      |  8 +-------
>   3 files changed, 22 insertions(+), 22 deletions(-)
> 
