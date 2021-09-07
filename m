Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A54402235
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 04:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhIGCI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 22:08:27 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:34123 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230250AbhIGCI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 22:08:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UnXJ-6m_1630980439;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UnXJ-6m_1630980439)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Sep 2021 10:07:20 +0800
Subject: Re: [PATCH 0/2] virtiofs: miscellaneous fixes
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
References: <20210812054618.26057-1-jefflexu@linux.alibaba.com>
Message-ID: <dd4c7cd8-bbf0-4e15-8ed9-d6babdc40eca@linux.alibaba.com>
Date:   Tue, 7 Sep 2021 10:07:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210812054618.26057-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping ...

On 8/12/21 1:46 PM, Jeffle Xu wrote:
> Some fixes or optimization for virtiofs, which are authored by Liu Bo.
> 
> Liu Bo (2):
>   virtio-fs: disable atomic_o_trunc if no_open is enabled
>   virtiofs: reduce lock contention on fpq->lock
> 
>  fs/fuse/file.c      | 11 +++++++++--
>  fs/fuse/virtio_fs.c |  3 ---
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 

-- 
Thanks,
Jeffle
