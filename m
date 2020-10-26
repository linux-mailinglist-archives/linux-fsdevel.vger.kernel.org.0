Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4544229917C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 16:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784502AbgJZPy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 11:54:26 -0400
Received: from casper.infradead.org ([90.155.50.34]:44094 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422551AbgJZPy0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vyhHgvG7q8mR9uMvZeYLk5NHZwVRptJfoJ1pJf94u/w=; b=rJeT0U00ikfNjcJQtqCRsa7hOt
        ivtgVTTtgl9kExGOJKtB+fnr1jwocDyAMRTBrHLj3PqfTPNX9b98nvCY9DAgh3rLcYZeexA4/ZqfY
        3mlAR//t9KiagQl4WI6SHv+024l4eQ1sZxbXYxTUDArjJzaqnvuRblbwfVKGWkKZ/lPnGNER597k/
        eJ39O0iHRxpCkmutShHNp12crRXubSmEg1dVWZk+zttJM00+w9do7Y32oOG0U0f9X9MjJR8OFmSZS
        oa0m8qgXc2SzfJIB+ciMuBL8b8JOGt+3bv0/n0M9GJkGXY23IcT8PIvaRjbA+pCUTTGQmIDD4CmVq
        r3ISWBeA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX4oh-0008HP-62; Mon, 26 Oct 2020 15:53:51 +0000
Date:   Mon, 26 Oct 2020 15:53:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/19] Free some vmemmap pages of hugetlb page
Message-ID: <20201026155351.GS20115@casper.infradead.org>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:50:55PM +0800, Muchun Song wrote:
> For tail pages, the value of compound_dtor is the same. So we can reuse

compound_dtor is only set on the first tail page.  compound_head is
what you mean here, I think.

