Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3307A6E03C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 03:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjDMBfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 21:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDMBfC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:35:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FD25BB1;
        Wed, 12 Apr 2023 18:34:57 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pxhv62tmmzDsyr;
        Thu, 13 Apr 2023 09:34:10 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 09:34:54 +0800
Message-ID: <a01a789c-8965-d1dc-cb45-ea9901a9af34@huawei.com>
Date:   Thu, 13 Apr 2023 09:34:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] fs: fix sysctls.c built
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20230331084502.155284-1-wangkefeng.wang@huawei.com>
 <66c0e8b6-64d1-5be6-cd4d-9700d84e1b84@huawei.com>
 <20230412-sympathie-haltbar-da2d2183067b@brauner>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230412-sympathie-haltbar-da2d2183067b@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/4/12 17:19, Christian Brauner wrote:
> On Tue, Apr 11, 2023 at 12:14:44PM +0800, Kefeng Wang wrote:
>> /proc/sys/fs/overflowuid and overflowgid  will be lost without
>> building this file, kindly ping, any comments, thanks.
>>
>>
>> On 2023/3/31 16:45, Kefeng Wang wrote:
>>> 'obj-$(CONFIG_SYSCTL) += sysctls.o' must be moved after "obj-y :=",
>>> or it won't be built as it is overwrited.

...

> Given the description in
> ab171b952c6e ("fs: move namespace sysctls and declare fs base directory")
> you probably want to move this earlier.

Oh, missing that part, but the /proc/sys/fs/overflowuid and overflowgid 
are lost after it, is it expected? Luis, could you take a look? thanks.

> 
