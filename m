Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A22BC5D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 14:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgKVNap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 08:30:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgKVNao (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 08:30:44 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F44620738;
        Sun, 22 Nov 2020 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606051844;
        bh=Ui9+fAg9vTpjZ7mDJtx+D82PTfYwHRUF4Gto5x3fYIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FApQXX5yCoQF7ilrazML+580A6EUDC0weaeM0D0xuzwM71B3h40mSZdgpcJumUEak
         MUrEAso1A8L+Rp9SbsM6Ips8fCa3p7bncJcSxsSPyreo6u9/JJyTRBcJnDmbUVqjYH
         kVSb9u2pp0auWa98VBPxELsK19/KxaMUP2sPsXDE=
Date:   Sun, 22 Nov 2020 15:30:30 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 21/21] mm/hugetlb: Disable freeing vmemmap if struct
 page size is not power of two
Message-ID: <20201122133030.GG8537@kernel.org>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-22-songmuchun@bytedance.com>
 <20201120082552.GI3200@dhcp22.suse.cz>
 <9b26c749-3bb6-4b16-d1fc-da7ec5d1e8a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b26c749-3bb6-4b16-d1fc-da7ec5d1e8a5@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:15:30AM +0100, David Hildenbrand wrote:
> On 20.11.20 09:25, Michal Hocko wrote:
> > On Fri 20-11-20 14:43:25, Muchun Song wrote:
> > > We only can free the unused vmemmap to the buddy system when the
> > > size of struct page is a power of two.
> > 
> > Can we actually have !power_of_2 struct pages?
> 
> AFAIK multiples of 8 bytes (56, 64, 72) are possible.

Or multiples of 4 for 32-bit (28, 32, 36). 
 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 

-- 
Sincerely yours,
Mike.
