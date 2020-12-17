Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0E02DD382
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 16:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgLQPAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 10:00:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:48430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728529AbgLQPAo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:00:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99214AD29;
        Thu, 17 Dec 2020 15:00:02 +0000 (UTC)
Date:   Thu, 17 Dec 2020 15:59:58 +0100
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
        naoya.horiguchi@nec.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10 00/11] Free some vmemmap pages of HugeTLB page
Message-ID: <20201217145953.GA13874@linux>
References: <20201217121303.13386-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217121303.13386-1-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 08:12:52PM +0800, Muchun Song wrote:
> In this case, for the 1GB HugeTLB page, we can save 4088 pages(There are
> 4096 pages for struct page structs, we reserve 2 pages for vmemmap and 8
> pages for page tables. So we can save 4088 pages). This is a very substantial
> gain. On our server, run some SPDK/QEMU applications which will use 1024GB
> hugetlbpage. With this feature enabled, we can save ~16GB(1G hugepage)/~11GB
> (2MB hugepage, the worst case is 10GB while the best is 12GB) memory.

Is the above really true?
We no longer need to allocate pagetables, so the savings go up to 4094, right?

I will be off for a few days but I expect to get back to this and review the
missing bits when I am back.

-- 
Oscar Salvador
SUSE L3
