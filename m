Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29AB369AEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhDWTaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 15:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWTaR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:30:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7E7F61425;
        Fri, 23 Apr 2021 19:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1619206181;
        bh=hmXgOMfwOqJWu9RVsEL53nURi7NTe6eTVDA00J2JLGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ghs6938sRT3RY96brYK9XC67wcNBnu5gflBqZKXhDOXIpujK/eN2ORs7mZ5d0cguv
         K/jbAImScii8I8CnZTmYjJPnnLMZOrLm5GK3V1w5q7qGV2ZtCEJQA6iL9AasAKxH0R
         VE0qhRHkPJIoxR4VbrvpEWBDikog8gNYrPI8DCiY=
Date:   Fri, 23 Apr 2021 12:29:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm/filemap: fix mapping_seek_hole_data on THP &
 32-bit
Message-Id: <20210423122940.26829dc784a4b6546349dac5@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.2104231009520.18646@eggly.anvils>
References: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils>
        <alpine.LSU.2.11.2104211737410.3299@eggly.anvils>
        <20210422011631.GL3596236@casper.infradead.org>
        <alpine.LSU.2.11.2104212253000.4412@eggly.anvils>
        <alpine.LSU.2.11.2104221338410.1170@eggly.anvils>
        <alpine.LSU.2.11.2104221347240.1170@eggly.anvils>
        <20210422160410.e9014b38b843d7a6ec06a9bb@linux-foundation.org>
        <alpine.LSU.2.11.2104231009520.18646@eggly.anvils>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 23 Apr 2021 10:22:51 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> On Thu, 22 Apr 2021, Andrew Morton wrote:
> > On Thu, 22 Apr 2021 13:48:57 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> > 
> > > Andrew, I'd have just sent a -fix.patch to remove the unnecessary u64s,
> > > but need to reword the commit message: so please replace yesterday's
> > > mm-filemap-fix-mapping_seek_hole_data-on-thp-32-bit.patch
> > > by this one - thanks.
> > 
> > Actually, I routinely update the base patch's changelog when queueing a -fix.
> 
> And thank you for that, but if there's time, I think we would still
> prefer the final commit message to include corrections where Matthew
> enlightened me (that "sign-extension" claim came from my confusion):

That's my point.  When I merge a -v2 as a -fix, I replace the v1
patch's changelog with v2's changelog so everything works out after
folding.

