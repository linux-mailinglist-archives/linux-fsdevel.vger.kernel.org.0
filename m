Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4392D5E4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 15:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391559AbgLJOpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 09:45:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:51040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403831AbgLJOpO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:45:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49E94ADCD;
        Thu, 10 Dec 2020 14:44:33 +0000 (UTC)
Date:   Thu, 10 Dec 2020 15:44:19 +0100
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
Subject: Re: [PATCH v8 04/12] mm/hugetlb: Free the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20201210144419.GC8538@localhost.localdomain>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-5-songmuchun@bytedance.com>
 <20201210144256.GB8538@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210144256.GB8538@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 03:42:56PM +0100, Oscar Salvador wrote:
> On Thu, Dec 10, 2020 at 11:55:18AM +0800, Muchun Song wrote:
> > The free_vmemmap_pages_per_hpage() which indicate that how many vmemmap
> > pages associated with a HugeTLB page that can be freed to the buddy
> > allocator just returns zero now, because all infrastructure is not
> > ready. Once all the infrastructure is ready, we will rework this
> > function to support the feature.
> 
> I would reword the above to:
> 
> "free_vmemmap_pages_per_hpage(), which indicates how many vmemmap
>  pages associated with a HugeTLB page can be freed, returns zero for
>  now, which means the feature is disabled.
>  We will enable it once all the infrastructure is there."
> 
>  Or something along those lines.
> 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Overall this looks good to me, and it has seen a considerable
> simplification, which is good.
> Some nits/questions below:

And as I said, I would merge patch#3 with this one.


-- 
Oscar Salvador
SUSE L3
