Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19EE392940
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 10:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbhE0IMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 04:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhE0IMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 04:12:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2B4C061574;
        Thu, 27 May 2021 01:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vT74XKRQuhUfgLTtwSOq9b0Z9WdSrSMbTGF3sw2pf4s=; b=fm1v8qYSLk//NA61Wa8uZtqNSz
        J0lO9IAJT+GN0aRGc52FJmjtq0GlQVFkBK3NA7L44OgjOgusQSJcn3PIkC9Hu2+O7uUBe6r2H1XOz
        jqHxQ+ewhbQr2dJvcd47dA0aGWjkSqz6XeK2CjAFTRadU32IDtOejSZ1JNo+emJGJrn11WdFGEOL/
        o+IJ1Wk+T/j1rm0NSFu6vTlYKTBbOc62eb2af4hqNzp/XbVD0iTENsCOj8xDX8QIlYAUkpEW+xnHp
        nOvxJilMB3cAEn/a3Pfcg6AcFLfKwRRC4L8qQ0NhtZ0+d/yEwuSzQ2S2hLTOP1ywL/49VxG1w14Py
        f3SLCeyQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lmB67-005Jn6-PC; Thu, 27 May 2021 08:10:36 +0000
Date:   Thu, 27 May 2021 09:10:31 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v10 07/33] mm: Add folio_get
Message-ID: <YK9T9xXaF6kU0nmU@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-8-willy@infradead.org>
 <88a265ab-9ecd-18b7-c150-517a5c2e5041@suse.cz>
 <YJ6IGgToV1wSv1gg@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ6IGgToV1wSv1gg@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 03:24:26PM +0100, Matthew Wilcox wrote:
> On Fri, May 14, 2021 at 01:56:46PM +0200, Vlastimil Babka wrote:
> > Nitpick: function names in subject should IMHO also end with (). But not a
> > reason for resend all patches that don't...
> 
> Hm, I thought it was preferred to not do that.  I can fix it
> easily enough when I go through and add the R-b.

I hate the pointless ().  Some maintainers insist on it.   No matter
what you do you'll make some folks happy and others not.
