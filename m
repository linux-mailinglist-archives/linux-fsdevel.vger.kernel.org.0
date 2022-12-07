Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CED96456DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Dec 2022 10:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLGJwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Dec 2022 04:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiLGJv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:51:58 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5FC2FC0D;
        Wed,  7 Dec 2022 01:51:56 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRsy25p30z4xVnZ;
        Wed,  7 Dec 2022 17:51:54 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl1.zte.com.cn with SMTP id 2B79pgNq036714;
        Wed, 7 Dec 2022 17:51:42 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 7 Dec 2022 17:51:45 +0800 (CST)
Date:   Wed, 7 Dec 2022 17:51:45 +0800 (CST)
X-Zmail-TransId: 2b04639062313ab2552a
X-Mailer: Zmail v1.0
Message-ID: <202212071751456693879@zte.com.cn>
In-Reply-To: <35cb3dad-7bae-7713-3bad-b151fa6831dd@gmail.com>
References: 202212071423496852423@zte.com.cn,35cb3dad-7bae-7713-3bad-b151fa6831dd@gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <bagasdotme@gmail.com>
Cc:     <corbet@lwn.net>, <kuba@kernel.org>, <davem@davemloft.net>,
        <hannes@cmpxchg.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XcKgZG9jczogcHJvYy5yc3Q6IGFkZMKgc29mdG5ldF9zdGF0?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B79pgNq036714
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6390623A.000 by FangMail milter!
X-FangMail-Envelope: 1670406714/4NRsy25p30z4xVnZ/6390623A.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6390623A.000/4NRsy25p30z4xVnZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/7/22 17:10, bagasdotme@gmail.com wrote:
> Add softnet_stat to what table? I have to read the actual documentation
> and found that you mean /proc/net table. Please mention that in patch
> subject.

OK, I will add this to subject.

> Regardless, this patch is from ZTE people, for which they have a
> reputation for ignoring critical code reviews and "atypical" email
> setup that needs to be fixed

Really sorry for that, We will try to avoid this.

Thanks.
