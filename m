Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1554A59F437
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 09:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiHXH1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 03:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiHXH1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:27:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9F86717A;
        Wed, 24 Aug 2022 00:27:22 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MCHdf2qRVzkWf9;
        Wed, 24 Aug 2022 15:23:50 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 15:27:17 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 15:27:16 +0800
Message-ID: <3953e198-e9e5-22cc-f196-5d5aca3d7ac1@huawei.com>
Date:   Wed, 24 Aug 2022 15:27:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
CC:     <mawupeng1@huawei.com>, <corbet@lwn.net>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <yzaikin@google.com>,
        <songmuchun@bytedance.com>, <mike.kravetz@oracle.com>,
        <osalvador@suse.de>, <rppt@kernel.org>, <surenb@google.com>,
        <jsavitz@redhat.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 0/2] watermark related improvement on zone movable
To:     <akpm@linux-foundation.org>
References: <20220819093025.105403-1-mawupeng1@huawei.com>
Content-Language: en-US
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <20220819093025.105403-1-mawupeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, maintainers, kindly ping...

Thanks.
Ma.

On 2022/8/19 17:30, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> The first patch cap zone movable's min watermark to small value since no
> one can use it.
> 
> The second patch introduce a per zone watermark to replace the vanilla
> watermark_scale_factor to bring flexibility to tune each zone's
> watermark separately and lead to more efficient kswapd.
> 
> Each patch's detail information can be seen is its own changelog.
> 
> changelog since v1:
> - fix compile error if CONFIG_SYSCTL is not enabled
> - remove useless function comment
> 
> Ma Wupeng (2):
>   mm: Cap zone movable's min wmark to small value
>   mm: sysctl: Introduce per zone watermark_scale_factor
> 
>  Documentation/admin-guide/sysctl/vm.rst |  6 ++++
>  include/linux/mm.h                      |  2 +-
>  kernel/sysctl.c                         |  2 --
>  mm/page_alloc.c                         | 41 +++++++++++++++++++------
>  4 files changed, 39 insertions(+), 12 deletions(-)
> 
