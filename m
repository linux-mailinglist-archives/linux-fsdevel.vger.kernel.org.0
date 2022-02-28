Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D78C4C60AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 02:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiB1Bo3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 20:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiB1Bo3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 20:44:29 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F5C1C12E;
        Sun, 27 Feb 2022 17:43:51 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K6NQy2zfVzBrL1;
        Mon, 28 Feb 2022 09:42:02 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 09:43:49 +0800
Received: from [10.67.109.84] (10.67.109.84) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 28 Feb
 2022 09:43:49 +0800
Message-ID: <b07af605-ab74-a313-f8e4-da794dcde111@huawei.com>
Date:   Mon, 28 Feb 2022 09:43:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH sysctl-next] kernel/kexec_core: move kexec_core sysctls
 into its own file
To:     Luis Chamberlain <mcgrof@kernel.org>, Baoquan He <bhe@redhat.com>
CC:     <ebiederm@xmission.com>, <keescook@chromium.org>,
        <yzaikin@google.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <zengweilin@huawei.com>, <chenjianguo3@huawei.com>,
        <nixiaoming@huawei.com>, <qiuguorui1@huawei.com>,
        <young.liuyang@huawei.com>
References: <20220223030318.213093-1-yingelin@huawei.com>
 <YhXwkTCwt3a4Dn9T@MiWiFi-R3L-srv>
 <c60419f8-422b-660d-8254-291182a06cbe@huawei.com> <Yhbu6UxoYXFtDyFk@fedora>
 <YhqLnIjopfoBEBcV@bombadil.infradead.org>
From:   yingelin <yingelin@huawei.com>
In-Reply-To: <YhqLnIjopfoBEBcV@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.84]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2022/2/27 4:20, Luis Chamberlain 写道:
> On Thu, Feb 24, 2022 at 10:35:21AM +0800, Baoquan He wrote:
>> That seems to be an issue everything related to sysctl are all added to
>> kernel/sysctl.c. Do you have a pointer that someone complained about it
>> and people agree to scatter them into their own component code?
> https://lkml.kernel.org/r/20220226031054.47DF8C340E7@smtp.kernel.org
>
>> I understand your concern now, I am personally not confused by that
>> maybe because I haven't got stuff adding or changing into sysctls. My
>> concern is if we only care and move kexec knob, or we have plan to try
>> to move all of them. If there's some background information or
>> discussion with a link, that would be helpful.
> We're moving them all out. Sorry, yingelin's commit log message sucks
> and it needs to be fixed to account for the justification. All the
> filesystem sysctls are already moved out. Slowly we are moving the other
> ones out and also doing minor optimizations along the way.
I'm sorry I didn't express it clearly. I'll fix it in v2 patch.
>
>    Luis
> .
