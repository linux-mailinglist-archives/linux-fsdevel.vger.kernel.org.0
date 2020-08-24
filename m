Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016E62506FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 19:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgHXRyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 13:54:51 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3976 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgHXRyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:54:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43fe720000>; Mon, 24 Aug 2020 10:52:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 10:54:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 24 Aug 2020 10:54:49 -0700
Received: from [10.2.58.8] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 17:54:48 +0000
Subject: Re: [PATCH 5/5] fs/ceph: use pipe_get_pages_alloc() for pipe
To:     Jeff Layton <jlayton@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <ceph-devel@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
 <20200822042059.1805541-6-jhubbard@nvidia.com>
 <048e78f2b440820d936eb67358495cc45ba579c3.camel@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c943337b-1c1e-9c85-4ded-39931986c6a3@nvidia.com>
Date:   Mon, 24 Aug 2020 10:54:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <048e78f2b440820d936eb67358495cc45ba579c3.camel@kernel.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598291570; bh=CWuYw5dH/VtBpvI19yHqq86doR7B2zJKPzasfKT65u4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ZFQsTjXMbeI3odHvWyyv+avDBH8AbQfdk/U759B5HohE1mwGHvlrewSpb+kAzQUcn
         qpiBh79ZgoT3BgBaR/4K0luta3Fhw12TGTDKBytzb3xqjfW20BFGBgoOHfJpD6V6pl
         RQQdVWIB+0HeeHIGKU1yGgj3CT15cw/Oy4hmHeaC4JeB57jy8gOWrl5eFh0BGw2J1N
         /hHEDha+UU+2OIE8uS2UiYiUVAvev6rDInJrCQUDmMu07atPRtlsbaFICCCuiZUrJc
         nlCtkrPZVDxFy+ch0xB2yJGUibXU4EjwgOxn1J1wNNPSFwA4NNat5nH5siKxTScwDt
         BZdUfY32nEviA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/24/20 3:53 AM, Jeff Layton wrote:
> 
> This looks fine to me. Let me know if you need this merged via the ceph
> tree. Thanks!
> 
> Acked-by: Jeff Layton <jlayton@kernel.org>
> 

Yes, please! It will get proper testing that way, and it doesn't have
any prerequisites, despite being part of this series. So it would be
great to go in via the ceph tree.

For the main series here, I'll send a v2 with only patches 1-3, once
enough feedback has happened.

thanks,
-- 
John Hubbard
NVIDIA
