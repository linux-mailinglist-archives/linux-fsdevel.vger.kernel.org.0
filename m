Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A9C37511E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 10:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhEFIxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 04:53:36 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:24439 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhEFIxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 04:53:32 -0400
X-AuditID: 0a580157-bebff70000027901-b8-6093ae4f6513
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 07.4C.30977.F4EA3906; Thu,  6 May 2021 16:52:31 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 6 May 2021
 16:52:29 +0800
Date:   Thu, 6 May 2021 16:52:29 +0800
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
Message-ID: <20210506165229.320e950f@alex-virtual-machine>
In-Reply-To: <YJOhBxiXIpaJpq+K@dhcp22.suse.cz>
References: <20210429122519.15183-1-david@redhat.com>
        <20210429122519.15183-4-david@redhat.com>
        <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
        <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
        <YJKdS+Q8CgSlgmFf@dhcp22.suse.cz>
        <20210506085611.1ec21588@alex-virtual-machine>
        <YJOVZlFGcSG+mmIk@dhcp22.suse.cz>
        <20210506152805.13fe775e@alex-virtual-machine>
        <YJOhBxiXIpaJpq+K@dhcp22.suse.cz>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsXCFcHor+u/bnKCQddeS4vpjV4Wc9avYbNY
        d7yL2eLr+l9AYtIFNotr2z0sll36zGRx4+BmNosnq7eyW+zZe5LFYurED2wWl3fNYbO4t+Y/
        q8X9PgeLj/uDLf7/esVqcbHxAKPFmWlFFkfWb2eyaDzyns3i7eGDzBbLz85jszi86RaTxe8f
        QI3PWq+yOEh6rJm3htFjYvM7do+ds+6ye2xeoeWxaVUnm8emT5PYPU7M+M3isfOhpcfkG8sZ
        PVp3/GX3eHF1I4vHx6e3WDze77vK5rF+y1UWjzMLjgB1nq4OEIzisklJzcksSy3St0vgynj0
        yadgimDFt09PWBsYe3m7GDk5JARMJDpnTGbuYuTiEBKYziTRs38DO4TzjFFi+q6pTF2MHBws
        AioSJ5qVQBrYBFQldt2bxQpiiwgoSXRt3skGUs8s0Mwu0fxzAjNIQljASeL485uMIDavgJVE
        47YORpA5nAJ6Eh+PKUDMb2eWmHDsGdggfgExid4r/8F2SQjYSzxerwjRKihxcuYTFhCbWUBH
        4sSqY8wQtrzE9rdzwGwhAUWJw0t+sUM8Iy9x9/d0Rgg7VqLpwC22CYzCs5CMmoVk1CwkoxYw
        Mq9iZCnOTTfcxAhJDuE7GOc1fdQ7xMjEwXiIUYKDWUmE9/SiyQlCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeRtnAqUE0hNLUrNTUwtSi2CyTBycUg1M3rlRn+8xObiteCq0te8lX7P/o/eTfd0O
        nc9wqzRbvXy59vl30fGchx4ZP2c8/rSzyoNxX8FdfxtZqcXfm2/Lf30u1tERv/IMT/HC+urS
        6l3Hl6zgz7Jx33Xr+9qA9xM1y75P48pSb1HhS7/eZay/mbt/6ZnNNa0qSyY7223ND2Bie1r6
        xa5Q6ebnb/2sDLpZ26xX7qpfMeX/+mWWN9lua9Tx+udonzLbuKbeasakFa1zNJeeFWUXenSo
        ebuaYph9/wbz3O1+qUI3jgjOMUrWTc//LcOjJTFFR6vksN3TD+xLy8MWnVEzXfE5bVvFMbHH
        op7z3FsMZTLTp9WZ5F47ea/2i4Emn/bbxTGNKuuUWIozEg21mIuKEwE2i6YafQMAAA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 6 May 2021 09:55:51 +0200
Michal Hocko <mhocko@suse.com> wrote:

> On Thu 06-05-21 15:28:05, Aili Yao wrote:
> > On Thu, 6 May 2021 09:06:14 +0200
> > Michal Hocko <mhocko@suse.com> wrote:
> >   
> > > On Thu 06-05-21 08:56:11, Aili Yao wrote:  
> > > > On Wed, 5 May 2021 15:27:39 +0200
> > > > Michal Hocko <mhocko@suse.com> wrote:  
> [...]
> > > > > I am not sure I follow. My point is that I fail to see any added value
> > > > > of the check as it doesn't prevent the race (it fundamentally cannot as
> > > > > the page can be poisoned at any time) but the failure path doesn't
> > > > > put_page which is incorrect even for hwpoison pages.    
> > > > 
> > > > Sorry, I have something to say:
> > > > 
> > > > I have noticed the ref count leak in the previous topic ,but  I don't think
> > > > it's a really matter. For memory recovery case for user pages, we will keep one
> > > > reference to the poison page so the error page will not be freed to buddy allocator.
> > > > which can be checked in memory_faulure() function.    
> > > 
> > > So what would happen if those pages are hwpoisoned from userspace rather
> > > than by HW. And repeatedly so?  
> > 
> > Sorry, I may be not totally understand what you mean.
> > 
> > Do you mean hard page offline from mcelog?  
> 
> No I mean soft hwpoison from userspace (e.g. by MADV_HWPOISON but there
> are other interfaces AFAIK).
> 
> And just to be explicit. All those interfaces are root only
> (CAP_SYS_ADMIN) so I am not really worried about any malitious abuse of
> the reference leak. I am mostly concerned that this is obviously broken
> without a good reason. The most trivial fix would have been to put_page
> in the return path but as I've mentioned in other email thread the fix
> really needs a deeper thought and consider other things.
> 
> Hope that clarifies this some more.

Thanks, got it!
Yes, there are some test scenarios that should be covered.

But for test, the default SIGBUS handlers is usually replaced, and the test process
may not hit the coredump code.

Anyway, there is a ref leak in the normal enviorments and better to be fixed.

Thanks!
Aili Yao
