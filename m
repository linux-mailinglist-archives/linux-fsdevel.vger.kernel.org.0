Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E6F64D71A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 08:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiLOHPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 02:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiLOHOm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:14:42 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6573830F79;
        Wed, 14 Dec 2022 23:14:37 -0800 (PST)
Received: from kwepemm600015.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NXk3j1gCrzJqRQ;
        Thu, 15 Dec 2022 15:13:37 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 15:14:31 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <bvanassche@acm.org>, <slava@dubeyko.com>,
        <akpm@linux-foundation.org>, <gargaditya08@live.com>,
        <axboe@kernel.dk>, <chenxiaosong2@huawei.com>,
        <willy@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <jlayton@kernel.org>, <hannes@cmpxchg.org>, <tytso@mit.edu>,
        <muchun.song@linux.dev>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] initialize 'struct hfsplus_inode_info' in hfsplus_iget()
Date:   Thu, 15 Dec 2022 16:18:18 +0800
Message-ID: <20221215081820.948990-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ChenXiaoSong (2):
  hfsplus: introduce hfsplus_init_inode() helper
  hfsplus: fix uninit-value in hfsplus_delete_cat()

 fs/hfsplus/hfsplus_fs.h |  1 +
 fs/hfsplus/inode.c      | 35 ++++++++++++++++++++---------------
 fs/hfsplus/super.c      |  8 +-------
 3 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.31.1

