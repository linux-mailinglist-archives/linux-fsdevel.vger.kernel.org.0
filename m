Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71C83938D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 00:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhE0WzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 18:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233203AbhE0WzG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 18:55:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0978F6135C;
        Thu, 27 May 2021 22:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622156012;
        bh=7MdWtmWeLlou3ty7YEAv5zFviKE2shm6r6htgP6Nn9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IcJP0OI0FtMTbahWzdvfxcck32sUMoliVtZZyoCP2Utt0oTLZFGLuJKp3MNQk4VV3
         5ZxiTd26MyZsJfu/MiV3rXmjxuUI/BFg7MtHbZ5WZkGL4s6QDJlj+VxotxZUWXweij
         eclWsB/xlwobMugfIx6S+aRLLIYZ5g+KGnwQDmMM=
Date:   Thu, 27 May 2021 15:53:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v10 07/33] mm: Add folio_get
Message-Id: <20210527155331.3d96fca84dd25705f5c9897f@linux-foundation.org>
In-Reply-To: <YK9T9xXaF6kU0nmU@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
        <20210511214735.1836149-8-willy@infradead.org>
        <88a265ab-9ecd-18b7-c150-517a5c2e5041@suse.cz>
        <YJ6IGgToV1wSv1gg@casper.infradead.org>
        <YK9T9xXaF6kU0nmU@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 May 2021 09:10:31 +0100 Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, May 14, 2021 at 03:24:26PM +0100, Matthew Wilcox wrote:
> > On Fri, May 14, 2021 at 01:56:46PM +0200, Vlastimil Babka wrote:
> > > Nitpick: function names in subject should IMHO also end with (). But not a
> > > reason for resend all patches that don't...
> > 
> > Hm, I thought it was preferred to not do that.  I can fix it
> > easily enough when I go through and add the R-b.
> 
> I hate the pointless ().  Some maintainers insist on it.   No matter
> what you do you'll make some folks happy and others not.

I prefer it.  It succinctly says "this identifier is a function" which
is useful info.

I get many changelogs saying "the foo function" or "the function foo". 
"foo()" is better.
