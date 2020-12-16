Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699A12DC1CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 15:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgLPOE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 09:04:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:41898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgLPOE0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:04:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC352AC7F;
        Wed, 16 Dec 2020 14:03:44 +0000 (UTC)
Date:   Wed, 16 Dec 2020 15:03:40 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, song.bao.hua@hisilicon.com, david@redhat.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 10/11] mm/hugetlb: Gather discrete indexes of tail page
Message-ID: <20201216140340.GE29394@linux>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-11-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213154534.54826-11-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 13, 2020 at 11:45:33PM +0800, Muchun Song wrote:
> For HugeTLB page, there are more metadata to save in the struct page.
> But the head struct page cannot meet our needs, so we have to abuse
> other tail struct page to store the metadata. In order to avoid
> conflicts caused by subsequent use of more tail struct pages, we can
> gather these discrete indexes of tail struct page. In this case, it
> will be easier to add a new tail page index later.
> 
> There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
> page structs can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, so
"that can be..."

> add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

I think this makes the current situation with metadata usage in sub-pages
easier to track.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
