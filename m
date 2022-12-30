Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E97765940D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 02:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiL3BgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 20:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiL3BgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 20:36:14 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CF116487;
        Thu, 29 Dec 2022 17:36:13 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NjnsS4K5jz6FK2R;
        Fri, 30 Dec 2022 09:36:12 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 2BU1a25H073586;
        Fri, 30 Dec 2022 09:36:02 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 30 Dec 2022 09:36:03 +0800 (CST)
Date:   Fri, 30 Dec 2022 09:36:03 +0800 (CST)
X-Zmail-TransId: 2b0363ae40834f20052e
X-Mailer: Zmail v1.0
Message-ID: <202212300936031482783@zte.com.cn>
In-Reply-To: <Y63IWTOE4sNKuseL@casper.infradead.org>
References: 202212292130035747813@zte.com.cn,Y63IWTOE4sNKuseL@casper.infradead.org
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <willy@infradead.org>
Cc:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <iamjoonsoo.kim@lge.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBzd2FwX3N0YXRlOiB1cGRhdGUgc2hhZG93X25vZGVzIGZvciBhbm9ueW1vdXMgcGFnZQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2BU1a25H073586
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63AE408C.001 by FangMail milter!
X-FangMail-Envelope: 1672364172/4NjnsS4K5jz6FK2R/63AE408C.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63AE408C.001/4NjnsS4K5jz6FK2R
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Please include a description of the user-visible effect of this (I
> think I can guess, but I'd like it spelled out)

> No Fixes: line?  It doesn't need to be backported?

> .... "and swap cache.", not anonymous page.

Thanks to your reviewing! I will send patchv2 to fix those all after
further review.
