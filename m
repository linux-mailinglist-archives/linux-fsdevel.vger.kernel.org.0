Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF9E4B05F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 07:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbiBJF6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 00:58:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBJF6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:58:19 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4391C5;
        Wed,  9 Feb 2022 21:58:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V42eJYQ_1644472693;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V42eJYQ_1644472693)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Feb 2022 13:58:15 +0800
Date:   Thu, 10 Feb 2022 13:58:13 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        gregkh@linuxfoundation.org, tao.peng@linux.alibaba.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
        gerry@linux.alibaba.com, torvalds@linux-foundation.org
Subject: Re: [Linux-cachefs] [PATCH v3 00/22] fscache,  erofs: fscache-based
 demand-read semantics
Message-ID: <YgSpdW1LjK2901ix@B-P7TQMD6M-0146.local>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        gregkh@linuxfoundation.org, tao.peng@linux.alibaba.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
        gerry@linux.alibaba.com, torvalds@linux-foundation.org
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Wed, Feb 09, 2022 at 02:00:46PM +0800, Jeffle Xu wrote:

...

> 
> 
> Jeffle Xu (22):
>   fscache: export fscache_end_operation()
>   fscache: add a method to support on-demand read semantics
>   cachefiles: extract generic function for daemon methods
>   cachefiles: detect backing file size in on-demand read mode
>   cachefiles: introduce new devnode for on-demand read mode

...

> 
>  Documentation/filesystems/netfs_library.rst |  18 +
>  fs/cachefiles/Kconfig                       |  13 +
>  fs/cachefiles/daemon.c                      | 243 +++++++++--
>  fs/cachefiles/internal.h                    |  12 +
>  fs/cachefiles/io.c                          |  60 +++
>  fs/cachefiles/main.c                        |  27 ++
>  fs/cachefiles/namei.c                       |  60 ++-

Would you mind taking a review at this version? We follow your previous
advices written in v2 and it reuses almost all cachefiles code except
that it has slightly different implication of cachefile file size and
a new daemon node.

I think it could be as the first step to implement fscache-based
on-demand read.

Thanks,
Gao Xiang

