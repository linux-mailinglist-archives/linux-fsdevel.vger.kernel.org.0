Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A612DC8D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 23:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgLPWNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 17:13:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:57994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgLPWNd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:13:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DDFBAC90;
        Wed, 16 Dec 2020 22:12:51 +0000 (UTC)
Date:   Wed, 16 Dec 2020 23:12:47 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v9 09/11] mm/hugetlb: Introduce
 nr_free_vmemmap_pages in the struct hstate
Message-ID: <20201216221247.GB3207@localhost.localdomain>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-10-songmuchun@bytedance.com>
 <20201216134354.GD29394@linux>
 <CAMZfGtV2bYKPhyeR_pbckA6svs3qWpzmnhoeYkn=U1hw4Nwatg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtV2bYKPhyeR_pbckA6svs3qWpzmnhoeYkn=U1hw4Nwatg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 16, 2020 at 09:56:47PM +0800, Muchun Song wrote:
> The pr_info can tell the user whether the feature is enabled. From this
> point of view, it makes sense. Right?

Well, I guess so.
Anyway, it is not that we are going to flood the logs, so it is ok.


-- 
Oscar Salvador
SUSE L3
