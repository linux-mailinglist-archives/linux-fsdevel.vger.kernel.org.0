Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E4613572
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 13:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiJaMNa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 08:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJaMN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:13:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C110AD;
        Mon, 31 Oct 2022 05:13:26 -0700 (PDT)
Received: from canpemm100007.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N1Bkd1xjjz15M6K;
        Mon, 31 Oct 2022 20:08:25 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100007.china.huawei.com (7.192.105.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 20:13:24 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031;
 Mon, 31 Oct 2022 20:13:24 +0800
From:   zhaogongyi <zhaogongyi@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>
Subject: Re: [PATCH -next 2/2] selftests/mincore: Optimize
 TEST(check_file_mmap) accoring to filemap read around
Thread-Topic: [PATCH -next 2/2] selftests/mincore: Optimize
 TEST(check_file_mmap) accoring to filemap read around
Thread-Index: AdjtH7Yic788mfv6SlqD4b0WiQhS3g==
Date:   Mon, 31 Oct 2022 12:13:24 +0000
Message-ID: <325990f3395e47c8bc04f628152dcbf8@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

> On Mon, Oct 31, 2022 at 07:22:11AM +0000, zhaogongyi wrote:
> > Hi!
> >
> > +to linux-fsdevel@vger.kernel.org
> > +cc willy@infradead.org
> >
> > Regards,
> > Gongyi
> 
> what?

I have submitted tow patches reference to the testing of page cache, please see: https://patchwork.kernel.org/project/linux-kselftest/patch/20221021071052.143393-2-zhaogongyi@huawei.com/

The patches have not responded for a while, so I'm guessing that's the reason for my lack of cc to linux-fsdevel or page cache maintainer?

Best Regards,
Gongyi
