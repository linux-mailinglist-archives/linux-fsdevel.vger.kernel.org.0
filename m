Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E844A66D3CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 02:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjAQB1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 20:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjAQB1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 20:27:37 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3B321A10;
        Mon, 16 Jan 2023 17:27:35 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Nwrq97001z501Zn;
        Tue, 17 Jan 2023 09:27:33 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl2.zte.com.cn with SMTP id 30H1RUoE039328;
        Tue, 17 Jan 2023 09:27:30 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 17 Jan 2023 09:27:30 +0800 (CST)
Date:   Tue, 17 Jan 2023 09:27:30 +0800 (CST)
X-Zmail-TransId: 2b0663c5f982ffffffffef3fda09
X-Mailer: Zmail v1.0
Message-ID: <202301170927309483808@zte.com.cn>
In-Reply-To: <Y8Wq3apsJh7keUVA@casper.infradead.org>
References: 202301131736452546903@zte.com.cn,Y8Wq3apsJh7keUVA@casper.infradead.org
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <willy@infradead.org>
Cc:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <bagasdotme@gmail.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <iamjoonsoo.kim@lge.com>, <ran.xiaokai@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IHYzXSBzd2FwX3N0YXRlOiB1cGRhdGUgc2hhZG93X25vZGVzIGZvciBhbm9ueW1vdXMgcGFnZQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 30H1RUoE039328
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C5F985.000/4Nwrq97001z501Zn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> What testing did you do of this?  I have this crash in today's testing:

My test is this: 
1.Configure zram for swap.
2.Run some program malloc and access large memory, make sure they
can cause swap.
3.Watch count_shadow_nodes() and shadow_lru_isolate() to make sure
that shadow_nodes are really shrinking by adding printk().

Really sorry for inadequate test, I will try more tests include drop_caches
by sysctl.
