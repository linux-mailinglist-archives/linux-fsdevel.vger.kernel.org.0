Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4DF212F4D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 08:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgACHIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 02:08:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbgACHIu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 02:08:50 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 64011AD2A04F99D07C71;
        Fri,  3 Jan 2020 15:08:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 3 Jan 2020
 15:08:43 +0800
Subject: Re: [PATCH 0/3] erofs: remove tags of pointers stored in a radix tree
To:     Vladimir Zapolskiy <vladimir@tuxera.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
CC:     Anton Altaparmakov <anton@tuxera.com>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-fsdevel@vger.kernel.org>
References: <20200102120118.14979-1-vladimir@tuxera.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c21314f0-1061-5683-4775-280629275c7b@huawei.com>
Date:   Fri, 3 Jan 2020 15:08:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200102120118.14979-1-vladimir@tuxera.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/1/2 20:01, Vladimir Zapolskiy wrote:
> The changeset simplifies a couple of internal interfaces and removes
> excessive tagging and untagging of workgroup pointers stored in a radix
> tree.
> 
> All the changes in the series are non-functional.
> 
> Vladimir Zapolskiy (3):
>   erofs: remove unused tag argument while finding a workgroup
>   erofs: remove unused tag argument while registering a workgroup
>   erofs: remove void tagging/untagging of workgroup pointers
> 
>  fs/erofs/internal.h |  4 ++--
>  fs/erofs/utils.c    | 15 ++++-----------
>  fs/erofs/zdata.c    |  5 ++---
>  3 files changed, 8 insertions(+), 16 deletions(-)
> 

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
