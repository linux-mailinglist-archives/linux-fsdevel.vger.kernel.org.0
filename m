Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954BF375028
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 09:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhEFH3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 03:29:14 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:24435 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbhEFH3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 03:29:13 -0400
X-AuditID: 0a580157-bebff70000027901-76-60939a8d4edd
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 33.EA.30977.D8A93906; Thu,  6 May 2021 15:28:13 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 6 May 2021
 15:28:11 +0800
Date:   Thu, 6 May 2021 15:28:05 +0800
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
Message-ID: <20210506152805.13fe775e@alex-virtual-machine>
In-Reply-To: <YJOVZlFGcSG+mmIk@dhcp22.suse.cz>
References: <20210429122519.15183-1-david@redhat.com>
        <20210429122519.15183-4-david@redhat.com>
        <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
        <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
        <YJKdS+Q8CgSlgmFf@dhcp22.suse.cz>
        <20210506085611.1ec21588@alex-virtual-machine>
        <YJOVZlFGcSG+mmIk@dhcp22.suse.cz>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsXCFcHor9s7a3KCwY+rghbTG70s5qxfw2ax
        7ngXs8XX9b+AxKQLbBbXtntYLLv0mcnixsHNbBZPVm9lt9iz9ySLxdSJH9gsLu+aw2Zxb81/
        Vov7fQ4WH/cHW/z/9YrV4mLjAUaLM9OKLI6s385k0XjkPZvF28MHmS2Wn53HZnF40y0mi98/
        gBqftV5lcZD0WDNvDaPHxOZ37B47Z91l99i8Qstj06pONo9Nnyaxe5yY8ZvFY+dDS4/JN5Yz
        erTu+Mvu8eLqRhaPj09vsXi833eVzWP9lqssHmcWHAHqPF0dIBjFZZOSmpNZllqkb5fAlfF2
        8m3GgjOSFVt7NjI3MC4W7mLk5JAQMJFY9mUSYxcjF4eQwHQmicezL7BCOM8YJaZPXc8MUsUi
        oCLR/qaREcRmE1CV2HVvFiuILSKgJNG1eScbSAOzQDO7RPPPCWANwgJOEsef3wRr4BWwkmj4
        fpIFxOYU0JNoPLCFCWLDJiaJr7desIEk+AXEJHqv/AdKcADdZC/xeL0iRK+gxMmZT8B6mQV0
        JE6sOsYMYctLbH87B8wWElCUOLzkFzvEO/ISd39PZ4SwYyWaDtxim8AoPAvJqFlIRs1CMmoB
        I/MqRpbi3HTDTYyQFBG+g3Fe00e9Q4xMHIyHGCU4mJVEeAvW9icI8aYkVlalFuXHF5XmpBYf
        YpTmYFES522cOTlBSCA9sSQ1OzW1ILUIJsvEwSnVwLT1XjXLr+aDKz90PD/b0GeRYSUhIrPu
        8oSe+QcrLsZZeEW2VClH3Y3nvsD0cMqW5K6Zp2smdS7YvFE27s6CzQs2PlWRm30lomfZ0mXx
        KasnsXGqTOVg5r0ofT//UOf09GWL3HWbTPiv8Sle81v0+9AuP9fO83d+Me06kfagOc6780dw
        i7rMm+T0/7Fqz22f/V97p2zV3xzj4z933trYu/AR95NcQfbWsMtS4VtE5pteyHhyvPMf55E1
        hrVLAm7/2p5545velKYpCVc6m0yqhWMbpmtzX5cSVe7YH6e6ynBl29lYny0X5i3Kuns2c2HF
        b+7Pq06J2bH/k1+5/7Z89Fn28oDgMy1xTAeCPpV3bexUYinOSDTUYi4qTgQANETSJIADAAA=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 6 May 2021 09:06:14 +0200
Michal Hocko <mhocko@suse.com> wrote:

> On Thu 06-05-21 08:56:11, Aili Yao wrote:
> > On Wed, 5 May 2021 15:27:39 +0200
> > Michal Hocko <mhocko@suse.com> wrote:
> >   
> > > On Wed 05-05-21 15:17:53, David Hildenbrand wrote:  
> > > > On 05.05.21 15:13, Michal Hocko wrote:    
> > > > > On Thu 29-04-21 14:25:15, David Hildenbrand wrote:    
> > > > > > Commit d3378e86d182 ("mm/gup: check page posion status for coredump.")
> > > > > > introduced page_is_poisoned(), however, v5 [1] of the patch used
> > > > > > "page_is_hwpoison()" and something went wrong while upstreaming. Rename the
> > > > > > function and move it to page-flags.h, from where it can be used in other
> > > > > > -- kcore -- context.
> > > > > > 
> > > > > > Move the comment to the place where it belongs and simplify.
> > > > > > 
> > > > > > [1] https://lkml.kernel.org/r/20210322193318.377c9ce9@alex-virtual-machine
> > > > > > 
> > > > > > Signed-off-by: David Hildenbrand <david@redhat.com>    
> > > > > 
> > > > > I do agree that being explicit about hwpoison is much better. Poisoned
> > > > > page can be also an unitialized one and I believe this is the reason why
> > > > > you are bringing that up.    
> > > > 
> > > > I'm bringing it up because I want to reuse that function as state above :)
> > > >     
> > > > > 
> > > > > But you've made me look at d3378e86d182 and I am wondering whether this
> > > > > is really a valid patch. First of all it can leak a reference count
> > > > > AFAICS. Moreover it doesn't really fix anything because the page can be
> > > > > marked hwpoison right after the check is done. I do not think the race
> > > > > is feasible to be closed. So shouldn't we rather revert it?    
> > > > 
> > > > I am not sure if we really care about races here that much here? I mean,
> > > > essentially we are racing with HW breaking asynchronously. Just because we
> > > > would be synchronizing with SetPageHWPoison() wouldn't mean we can stop HW
> > > > from breaking.    
> > > 
> > > Right
> > >   
> > > > Long story short, this should be good enough for the cases we actually can
> > > > handle? What am I missing?    
> > > 
> > > I am not sure I follow. My point is that I fail to see any added value
> > > of the check as it doesn't prevent the race (it fundamentally cannot as
> > > the page can be poisoned at any time) but the failure path doesn't
> > > put_page which is incorrect even for hwpoison pages.  
> > 
> > Sorry, I have something to say:
> > 
> > I have noticed the ref count leak in the previous topic ,but  I don't think
> > it's a really matter. For memory recovery case for user pages, we will keep one
> > reference to the poison page so the error page will not be freed to buddy allocator.
> > which can be checked in memory_faulure() function.  
> 
> So what would happen if those pages are hwpoisoned from userspace rather
> than by HW. And repeatedly so?

Sorry, I may be not totally understand what you mean.

Do you mean hard page offline from mcelog?
If yes, I think it's not for one real UC error but for CE storms.
when we access this page in kernel, the access may success even it was marked hwpoison.

Thanks!
Aili Yao 
