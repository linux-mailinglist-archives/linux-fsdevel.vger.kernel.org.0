Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A000671CC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 13:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjARM6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 07:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjARM5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:57:33 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091C64ED19;
        Wed, 18 Jan 2023 04:18:50 -0800 (PST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NxlCl4zd6z8RV7D;
        Wed, 18 Jan 2023 20:18:27 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NxlC943kjz501Rr;
        Wed, 18 Jan 2023 20:17:57 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl1.zte.com.cn with SMTP id 30ICHpaE003447;
        Wed, 18 Jan 2023 20:17:51 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 18 Jan 2023 20:17:54 +0800 (CST)
Date:   Wed, 18 Jan 2023 20:17:54 +0800 (CST)
X-Zmail-TransId: 2b0663c7e372ffffffff8bf081dc
X-Mailer: Zmail v1.0
Message-ID: <202301182017545851044@zte.com.cn>
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
X-MAIL: mse-fl1.zte.com.cn 30ICHpaE003447
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63C7E393.000 by FangMail milter!
X-FangMail-Envelope: 1674044307/4NxlCl4zd6z8RV7D/63C7E393.000/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C7E393.000/4NxlCl4zd6z8RV7D
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> i_lock is at offset 128 of struct inode, so that matches the dump.
> I believe that swapper_spaces never have ->host set, so I don't
> believe you've tested this patch since 51b8c1fe250d went in
> back in 2021.

You are totally right. I reproduce the panic in linux-next, and fix
it by patch v4. I should be more careful, since I used Linux 5.14
to test the patch which is a mistake.

Much apologies for the time wasted.

Thanks.
