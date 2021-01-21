Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D14C2FF749
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 22:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbhAUV36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 16:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbhAUV3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:29:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFA4C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 13:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z9XQotONVTpasWnTASx1CpS6wHolZ/YHd3IpBnAnbew=; b=QAjV0AXyq8nOc6B1325pwZpqf7
        aNR1ahgiWmXt2nWbG7fu2CiXy2UgQkm0i3zz6Xh2Mo6mXVOvCB/rdtMYOL5MfcqyoXOZVqyisJ/Tn
        Cp4/keveTLDcEVFEzYztIPexMSS9h4Klc/IrcA7mEjMwcEPlZz6TrH+26g/NOEeA/j1dMWxlpL89b
        hQlv0GuOQ+5Ug1JT60BIIRyBXmC2SrhMgdmnYu6XYvtN0oIJybzVgZ2MVLoFZOhG5vKHdtu9686dv
        QKON24iMZdcZkZIGlGmBupC0tYz0cjbpr8Fj/Mr+5nMMVdy6pltZsaySBNDDmDyoCn5IOJRWJcf/K
        cPsdB+WA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2hLJ-00HXfF-Lc; Thu, 21 Jan 2021 21:18:15 +0000
Date:   Thu, 21 Jan 2021 21:18:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce and use mapping_empty
Message-ID: <20210121211813.GD4127393@casper.infradead.org>
References: <20201026151849.24232-1-willy@infradead.org>
 <20201026151849.24232-2-willy@infradead.org>
 <YAnnN1pnZAPse5X+@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAnnN1pnZAPse5X+@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 03:42:31PM -0500, Johannes Weiner wrote:
> On Mon, Oct 26, 2020 at 03:18:46PM +0000, Matthew Wilcox (Oracle) wrote:
> > Instead of checking the two counters (nrpages and nrexceptional), we
> > can just check whether i_pages is empty.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Tested-by: Vishal Verma <vishal.l.verma@intel.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Heh, I was looking for the fs/inode.c hunk here, because I remember
> those BUG_ONs in the inode free path. Found it in the last patch - I
> guess they escaped grep but the compiler let you know? :-)

Heh, I forget now!  I think I did it that way on purpose, but now I
forget what that purpose was!
