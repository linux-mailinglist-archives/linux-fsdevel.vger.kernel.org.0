Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9F0374CC7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 03:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhEFBMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 21:12:18 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:24364 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhEFBMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 21:12:17 -0400
X-AuditID: 0a580155-c83ff700000401e3-d7-60933eaed698
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id BE.AA.00483.EAE33906; Thu,  6 May 2021 08:56:14 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 6 May 2021
 08:56:12 +0800
Date:   Thu, 6 May 2021 08:56:11 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Roman Gushchin" <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Wei Liu" <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-hyperv@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <yaoaili126@gmail.com>
Subject: Re: [PATCH v1 3/7] mm: rename and move page_is_poisoned()
Message-ID: <20210506085611.1ec21588@alex-virtual-machine>
In-Reply-To: <YJKdS+Q8CgSlgmFf@dhcp22.suse.cz>
References: <20210429122519.15183-1-david@redhat.com>
        <20210429122519.15183-4-david@redhat.com>
        <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
        <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
        <YJKdS+Q8CgSlgmFf@dhcp22.suse.cz>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsXCFcHor7vObnKCQfN0JovpjV4Wc9avYbNY
        d7yL2eLr+l9AYtIFNotr2z0sll36zGRx4+BmNosnq7eyW+zZe5LFYurED2wWl3fNYbO4t+Y/
        q8X9PgeLj/uDLf7/esVqcbHxAKPFmWlFFkfWb2eyaDzyns3i7eGDzBbLz85jszi86RaTxe8f
        QI3PWq+yOEh6rJm3htFjYvM7do+ds+6ye2xeoeWxaVUnm8emT5PYPU7M+M3isfOhpcfkG8sZ
        PVp3/GX3eHF1I4vHx6e3WDze77vK5rF+y1UWjzMLjgB1nq4OEIzisklJzcksSy3St0vgyth8
        dwJrwTaxiuNzD7E0MG4X7GLk4JAQMJF49Sy7i5GLQ0hgOpPEmf//mboYOYGcZ4wSq09YgNgs
        AioSh35dAIuzCahK7Lo3ixXEFhFQkujavJMNpJlZoJldovnnBGaQhLCAk8Tx5zcZQWxeASuJ
        q8ffgNmcAnoSB+ZfZ4XYdpdR4k77DbBJ/AJiEr1XQDaDXGQv8Xi9IkSvoMTJmU9YQGxmAR2J
        E6uOMUPY8hLb385hhjhUUeLwkl/sILYEUPzu7+mMEHasRNOBW2wTGIVnIRk1C8moWUhGLWBk
        XsXIUpybbrSJEZIeQncwzmj6qHeIkYmD8RCjBAezkghvwdr+BCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK87IVdCUIC6YklqdmpqQWpRTBZJg5OqQYmngff/NI6OLyu1RzY/mjunat8m+ZsYJ7u
        cy59a0XvYen+rYvWBD0IMUh++tHARml99imXvEOS61+n7YydEWt69WWSvIeG/bH7LeapHLdt
        TxfUqu6R2v+mW1yias7tY+G1Prsjc5ZwClrVvH2fWJS28f6JwGd2/59sfHFbc8nCuIMxge8F
        evm3v7maKvX3iLq/wdxisxyb6ZcvH+BuP+f47NbeI3bykfaZ5iHLpQ6YrV206dwFH2H9HTM2
        z4r0nHunqsx38uJYrUSpEhH3e0zpF0rm7aid0DjhB8t6pg9hNZMzdP77BZeVr1yiFK8j/v10
        1u56nYyFHtqPRRJLLcplBa/sKtsTMfHh8vf/501crcRSnJFoqMVcVJwIAPTMT+t+AwAA
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 5 May 2021 15:27:39 +0200
Michal Hocko <mhocko@suse.com> wrote:

> On Wed 05-05-21 15:17:53, David Hildenbrand wrote:
> > On 05.05.21 15:13, Michal Hocko wrote:  
> > > On Thu 29-04-21 14:25:15, David Hildenbrand wrote:  
> > > > Commit d3378e86d182 ("mm/gup: check page posion status for coredump.")
> > > > introduced page_is_poisoned(), however, v5 [1] of the patch used
> > > > "page_is_hwpoison()" and something went wrong while upstreaming. Rename the
> > > > function and move it to page-flags.h, from where it can be used in other
> > > > -- kcore -- context.
> > > > 
> > > > Move the comment to the place where it belongs and simplify.
> > > > 
> > > > [1] https://lkml.kernel.org/r/20210322193318.377c9ce9@alex-virtual-machine
> > > > 
> > > > Signed-off-by: David Hildenbrand <david@redhat.com>  
> > > 
> > > I do agree that being explicit about hwpoison is much better. Poisoned
> > > page can be also an unitialized one and I believe this is the reason why
> > > you are bringing that up.  
> > 
> > I'm bringing it up because I want to reuse that function as state above :)
> >   
> > > 
> > > But you've made me look at d3378e86d182 and I am wondering whether this
> > > is really a valid patch. First of all it can leak a reference count
> > > AFAICS. Moreover it doesn't really fix anything because the page can be
> > > marked hwpoison right after the check is done. I do not think the race
> > > is feasible to be closed. So shouldn't we rather revert it?  
> > 
> > I am not sure if we really care about races here that much here? I mean,
> > essentially we are racing with HW breaking asynchronously. Just because we
> > would be synchronizing with SetPageHWPoison() wouldn't mean we can stop HW
> > from breaking.  
> 
> Right
> 
> > Long story short, this should be good enough for the cases we actually can
> > handle? What am I missing?  
> 
> I am not sure I follow. My point is that I fail to see any added value
> of the check as it doesn't prevent the race (it fundamentally cannot as
> the page can be poisoned at any time) but the failure path doesn't
> put_page which is incorrect even for hwpoison pages.

Sorry, I have something to say:

I have noticed the ref count leak in the previous topic ,but  I don't think
it's a really matter. For memory recovery case for user pages, we will keep one
reference to the poison page so the error page will not be freed to buddy allocator.
which can be checked in memory_faulure() function.

For the case here, the reference count for error page may be greater than one as it's not
unmmapped successfully and may shared. we take a reference for that page will not result some
really mattering issue.

The only break I can think for this leak is that we will fail to unpoison the error page for test purpose.

Thanks!
Aili Yao
