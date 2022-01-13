Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9444F48D733
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 13:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiAMMJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 07:09:28 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:39096 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230310AbiAMMJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:09:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V1jRj.0_1642075754;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V1jRj.0_1642075754)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jan 2022 20:09:15 +0800
Date:   Thu, 13 Jan 2022 20:09:13 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     David Howells <dhowells@redhat.com>, tao.peng@linux.alibaba.com,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
        eguan@linux.alibaba.com, gerry@linux.alibaba.com,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Subject: Re: [Linux-cachefs] [PATCH v1 05/23] netfs: add inode parameter to
 netfs_alloc_read_request()
Message-ID: <YeAWaRLdw8hTujLX@B-P7TQMD6M-0146.local>
Mail-Followup-To: JeffleXu <jefflexu@linux.alibaba.com>,
        David Howells <dhowells@redhat.com>, tao.peng@linux.alibaba.com,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
        eguan@linux.alibaba.com, gerry@linux.alibaba.com,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-6-jefflexu@linux.alibaba.com>
 <9eafb56b-809c-c340-5627-a54a6265122b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9eafb56b-809c-c340-5627-a54a6265122b@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2022 at 11:10:57AM +0800, JeffleXu wrote:
> Hi David,
> 
> What would you think about this cleanup? We need this in prep for the
> following fscache-based on-demand reading feature. It would be great if
> it could be cherry picked in advance.
> 
> I also simplify the commit message as suggested by Gao Xiang. I could
> resend a v2 patch with the updated commit message if you'd like.
> 
>     netfs: add inode parameter to netfs_alloc_read_request()
> 
>     Make the @file parameter optional, and derive inode from the @folio
>     parameter instead.
> 
>     @file parameter can't be removed completely, since it also works as
>     the private data of ops->init_rreq().
> 
>     Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Hi,

IMHO, How about the following message:

netfs: make @file optional in netfs_alloc_read_request()

Make the @file parameter optional, and derive inode from the @folio
parameter instead in order to support file system internal requests.

@file parameter can't be removed completely, since it also works as
the private data of ops->init_rreq().

Thanks,
Gao Xiang
