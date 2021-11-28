Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB16F4603EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Nov 2021 05:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351807AbhK1EY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 23:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbhK1EW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 23:22:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B08EC061757;
        Sat, 27 Nov 2021 20:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ck+FaDnoeTtSYbJ567N4WEPz2AxsL6omNDpZ2NQqJFA=; b=afW5+8q9nlh1wdvcDjeYmoeAH1
        fX4yvxNZFTCi02bJSjeI8oiW0vCFli14y/9NIQ+2/RhTLh0CH2X1bExtej3GWFeZJpcmwIB5xfNBs
        IsZ40VmPSkz6EOQPodaMoj2zn7U1trQ9CtkM3NQ6GRUAtr2RXNAOdnoBy9B4Hp8QbAneLilW1Thfj
        hPQShpvUYTvi0X5mIgooVxCccU5ujOUtAFtZ0Dv8NQYuCWY/2+W3vXVeWT4HPhvw6kcpgRHthenTl
        GcuOi7GFHR0w9XuUISgaP5Rq0QXLCdYKFUZjEaipkMFQT4zAgUqsMvZjj3jZQjVFSJC0gm3fJIEzQ
        gejxXqlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrBVp-000afT-2n; Sun, 28 Nov 2021 04:10:01 +0000
Date:   Sun, 28 Nov 2021 04:10:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
Message-ID: <YaMBGQGNLqPd6D6f@casper.infradead.org>
References: <20211123000102.4052105-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123000102.4052105-1-almasrymina@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:01:02PM -0800, Mina Almasry wrote:
> Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
> address is currently mapped by a transparent huge page or not.  Example
> use case is a process requesting THPs from the kernel (via a huge tmpfs
> mount for example), for a performance critical region of memory.  The
> userspace may want to query whether the kernel is actually backing this
> memory by hugepages or not.

But what is userspace going to _do_ differently if the kernel hasn't
backed the memory with huge pages?
