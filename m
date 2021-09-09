Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C14C4058DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 16:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349090AbhIIOUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 10:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238519AbhIIOUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:20:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D54C10ED45;
        Thu,  9 Sep 2021 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X+DHfour2T275x2f3sXezdMkcjb30TVhGkpa3sTBYZ0=; b=QAztk8QaSIVO5r4ElpGZOeH8UC
        RMz0t6ip+owsmmNPMjscLJsTAyE9jPx3I6gf1gudWGWixgW+I0awXRmNreN3WCOmRWrhPkzV9NHRq
        GHcV8L9jtNUW4O9NeIaj+nkl6koemtFgzdhTMUVo8ioNktkgdKiKb+GSq19S+XckK/hJZiy/MHPiU
        IVFfcWLmwk5YUDD56SjilIh79c3zyK+0AcczUl9PbxMAay0vLMKZuBHNK5bJSmxfYcJiQ8ZbonXhF
        Lh3h3is9wNQia7Pe+FEXVBxky+HihOvZgLwAaqsWBUTfiO4+CdBni/TikxZmLmcBtZWQWtcHyVV9x
        WMiBzCRg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOJPJ-009rhw-DV; Thu, 09 Sep 2021 12:44:12 +0000
Date:   Thu, 9 Sep 2021 13:43:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YToBjZPEVN9Jmp38@infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSPwmNNuuQhXNToQ@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So what is the result here?  Not having folios (with that or another
name) is really going to set back making progress on sane support for
huge pages.  Both in the pagecache but also for other places like direct
I/O.
