Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47364343CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 05:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhJTDXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 23:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTDXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 23:23:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210B5C06161C;
        Tue, 19 Oct 2021 20:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b+qTJxNsHthexDLm6qY3jEJp4Sy4sxKMBU1dqyGdWI0=; b=RefDNgpJldhRgveeNjD/KqFwYa
        2OTYXNNgh7YDgxaFWRaWfskXqejipz+nAe/tvmqNDO9vX48rL6iodwhqNQWK3JUb+TGlUPoMAoT+b
        bQ5SG7AHMPKImbY0/tW2B/S7X3atqlaV2vaKSwLNuBoy93xXAVBOxR9Lk2dXphElKKuvXzOYd7k5a
        +Ouizj7gA3hxSEz60Mb3I2C13WGjhjBR4nkrgY+tAMOirFZL0ryolBRgCd47JgInMYc3/YyT9y81s
        FoMGX4NzCG8P2+wnqnhXnjfxIQEFWMopixCm+hTSOauJSwlfS55entvwdrR9JtpgK6pSgiaR3iq4n
        8nlDtrpA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md28Y-00CD8L-KF; Wed, 20 Oct 2021 03:19:42 +0000
Date:   Wed, 20 Oct 2021 04:19:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YW+KwgzaIj+hG8d7@casper.infradead.org>
References: <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW7hQlny+Go1K3LT@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 11:16:18AM -0400, Johannes Weiner wrote:
> My only effort from the start has been working out unanswered
> questions in this proposal: Are compound pages the reliable, scalable,
> and memory-efficient way to do bigger page sizes? What's the scope of
> remaining tailpages where typesafety will continue to lack? How do we
> implement code and properties shared by folios and non-folio types
> (like mmap/fault code for folio and network and driver pages)?

I don't think those questions need to be answered before proceeding
with this patchset.  They're interesting questions, to be sure, but
to a large extent they're orthogonal to the changes here.  I look
forward to continuing to work on those problems while filesystems
and the VFS continue to be converted to use folios.

> I'm not really sure how to exit this. The reasons for my NAK are still
> there. But I will no longer argue or stand in the way of the patches.

Thank you.  I appreciate that.
