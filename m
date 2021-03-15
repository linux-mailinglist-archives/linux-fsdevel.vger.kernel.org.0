Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC1633C689
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 20:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhCOTKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 15:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhCOTKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:10:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC23C06174A;
        Mon, 15 Mar 2021 12:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mkpF9omMUUFgPhO7wM2oolIv2L3IwnCTiRJGLYj/QNo=; b=m+fRbbsfcHaiqSu+dUQambcli/
        ayhSDuAmTMfgav8aX4P6JUjk2UJMjfrhSSVInwiDYtTmQxyp2LuXKNZkV09fswCHEPBjWuSH3bA2m
        kw7a7sJDLRbm+EJ7comRFCaOHYRkn3XUtgaY3jrPctWZMWbE6z59Ix5nvs/L/ynPTX2t4sHtWqZBn
        hEYBcI24VItDXo8c6KddZqLKi1r1xMhVm0hS6T0LGrd+xXaVwZs/YJooBaLz9fsWlCJJHQCdDGjNU
        suEBhlzf3181euFSUmfd2uuXPNZDjtfp5u99R441myZp9pbxLsVwgWZXhpZFuh7klOeWsPWIRHnZF
        J5kENouA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLsaO-000dXn-R4; Mon, 15 Mar 2021 19:09:09 +0000
Date:   Mon, 15 Mar 2021 19:09:04 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/25] Page folios
Message-ID: <20210315190904.GB150808@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210313123658.ad2dcf79a113a8619c19c33b@linux-foundation.org>
 <alpine.LSU.2.11.2103131842590.14125@eggly.anvils>
 <20210315115501.7rmzaan2hxsqowgq@box>
 <YE9VLGl50hLIJHci@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE9VLGl50hLIJHci@dhcp22.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 01:38:04PM +0100, Michal Hocko wrote:
> I tend to agree here as well. The level compoud_head has spread out
> silently is just too large. There are people coming up with all sorts of
> optimizations to workaround that, and they are quite right that this is
> somehing worth doing, but last attempts I have seen were very focused on
> specific page flags handling which is imho worse wrt maintainability
> than a higher level and type safe abstraction. I find it quite nice that
> this doesn't really have to be a flag day conversion but it can be done
> incrementally.
> 
> I didn't get review the series yet and I cannot really promise anything
> but from what I understand the conversion should be pretty
> straightforward, albeit noisy.
> 
> One thing that was really strange to me when seeing the concept for the
> first time was the choice of naming (no I do not want to start any
> bikeshedding) because it hasn't really resonated with the udnerlying
> concept. Maybe just me as a non native speaker... page_head would have
> been so much more straightforward but not something I really care about.

That pretty much summarizes my opinion as well.  I'll need to find some
time to review the series as well.
