Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D392C22D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgKXKYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 05:24:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:45204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgKXKYx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:24:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3B03AC48;
        Tue, 24 Nov 2020 10:24:51 +0000 (UTC)
Date:   Tue, 24 Nov 2020 11:24:45 +0100
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
        mhocko@suse.com, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 07/16] x86/mm/64: Disable PMD page mapping of vmemmap
Message-ID: <20201124102441.GA24718@linux>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
 <20201124095259.58755-8-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124095259.58755-8-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 05:52:50PM +0800, Muchun Song wrote:
> If we enable the CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, we can just
> disbale PMD page mapping of vmemmap to simplify the code. In this
> case, we do not need complex code doing vmemmap page table
> manipulation. This is a way to simply the first version of this
> patch series. In the future, we can add some code doing page table
> manipulation.

IIRC, CONFIG_HUGETLB_PAGE_FREE_VMEMMAP was supposed to be enabled by default,
right?
And we would control whether we __really__ want to this by a boot option,
which was disabled by default?

If you go for populating the memmap with basepages by checking
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, would not everybody, even the ones that
did not enable this by the boot option be affected?

-- 
Oscar Salvador
SUSE L3
