Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BB8374CB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 03:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhEFBJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 21:09:17 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:3060 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229465AbhEFBJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 21:09:15 -0400
X-Greylist: delayed 719 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 May 2021 21:09:15 EDT
X-AuditID: 0a580155-c83ff700000401e3-45-6093417f4c7f
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 85.BA.00483.F7143906; Thu,  6 May 2021 09:08:15 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 6 May 2021
 09:08:13 +0800
Date:   Thu, 6 May 2021 09:08:07 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        "Steven Price" <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Jiri Bohac" <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-hyperv@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <yaoaili126@gmail.com>
Subject: Re: [PATCH v1 3/7] mm: rename and move page_is_poisoned()
Message-ID: <20210506090807.5a7b8691@alex-virtual-machine>
In-Reply-To: <YJKhi6T33UmiZ/kE@dhcp22.suse.cz>
References: <20210429122519.15183-1-david@redhat.com>
        <20210429122519.15183-4-david@redhat.com>
        <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
        <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
        <YJKdS+Q8CgSlgmFf@dhcp22.suse.cz>
        <57ac524c-b49a-99ec-c1e4-ef5027bfb61b@redhat.com>
        <YJKhi6T33UmiZ/kE@dhcp22.suse.cz>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsXCFcHor1vvODnBYNcfPYvpjV4Wc9avYbNY
        d7yL2eLr+l9AYtIFNotr2z0sll36zGRx4+BmNosnq7eyW+zZe5LFYurED2wWl3fNYbO4t+Y/
        q8X9PgeLj/uDLf7/esVqcbHxAKPFmWlFFkfWb2eyaDzyns3i7eGDzBbLz85jszi86RaTxe8f
        QI3PWq+yOEh6rJm3htFjYvM7do+ds+6ye2xeoeWxaVUnm8emT5PYPU7M+M3isfOhpcfkG8sZ
        PVp3/GX3eHF1I4vHx6e3WDze77vK5rF+y1UWjzMLjgB1nq4OEIzisklJzcksSy3St0vgynje
        m1RwjqPi3hypBsbDbF2MnBwSAiYSbzYeZu5i5OIQEpjOJDF16j92COcZo8THtU+BMhwcLAIq
        EieWRYA0sAmoSuy6N4sVxBYRUJLo2ryTDaSeWaCdXaLj+wywhLCAk8Tx5zcZQWxeASuJlTf3
        gcU5BfQkbk55zgSxYCuTxMSGxSwgCX4BMYneK/+ZQJZJCNhLPF6vCNErKHFy5hOwEmYBHYkT
        q44xQ9jyEtvfzgGzhQQUJQ4v+cUO8Y28xN3f0xkh7FiJpgO32CYwCs9CMmoWklGzkIxawMi8
        ipGlODfdaBMjJDmE7mCc0fRR7xAjEwfjIUYJDmYlEd6Ctf0JQrwpiZVVqUX58UWlOanFhxil
        OViUxHnZC7sShATSE0tSs1NTC1KLYLJMHJxSDUzLRXWXLGk6reP3V4nz66O/KW/XMMlExEm2
        yrRsTS7fWnAqv6sgZ49Lmnj20kfJYQUfNJ4JTHc0l1i5bY6vyAORj8t+SRYKbzz17LiQ0Lop
        V90t9a+evPtgG3Pynl0m6mcfCBzduzI9/ueUpGm9C9jObfb8vO3a8SeWn/9aVwqtfKQ4x+Ty
        0Vm3ZRbVy4fKagjscW/h/7urkFniRNllMVmutuNL3zJkH+oMUf/mqn1SWP+aSeztP/IH9f7s
        elSZerCsYiNvqYEA1+es1iPqKZVWHsfqxDllT7y7bxog1swSIHrvUXbmXF/x8qTtae5unAkW
        9eo+56ttDXPvPljXstZk55zwx3La6i27+K9J7FBiKc5INNRiLipOBAAQjQW8fQMAAA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 5 May 2021 15:45:47 +0200
Michal Hocko <mhocko@suse.com> wrote:

> On Wed 05-05-21 15:39:08, David Hildenbrand wrote:
> > > > Long story short, this should be good enough for the cases we actually can
> > > > handle? What am I missing?  
> > > 
> > > I am not sure I follow. My point is that I fail to see any added value
> > > of the check as it doesn't prevent the race (it fundamentally cannot as
> > > the page can be poisoned at any time) but the failure path doesn't
> > > put_page which is incorrect even for hwpoison pages.  
> > 
> > Oh, I think you are right. If we have a page and return NULL we would leak a
> > reference.
> > 
> > Actually, we discussed in that thread handling this entirely differently,
> > which resulted in a v7 [1]; however Andrew moved forward with this
> > (outdated?) patch, maybe that was just a mistake?
> > 
> > Yes, I agree we should revert that patch for now.  
> 
> OK, Let me send the revert to Andrew.
> 

Got this!
Anyway, I will try to post a new patch for this issue based on the previous patch v7.

Thanks!
Aili Yao
