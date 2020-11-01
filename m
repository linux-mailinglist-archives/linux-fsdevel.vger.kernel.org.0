Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529722A1D6D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 11:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKAKuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 05:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgKAKuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 05:50:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825B3C0617A6
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2020 02:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BKLQptGlG/vyOKCfzKxQioEXXd2tw8LeC8qKoHogvio=; b=ndxXGxT53VbbnK0TWUGuF0eTNI
        bXEeJnNev4DagKgX2zHi1pHJXaN/0ZGn4bGnsSnuRoc+6HyKfq3HcOUexOsopvaWAmrBI2hA4Uvh1
        8wPA7S7AufFO74z3Mg44iAAR2IsZ3guzp/TKXr6RjOSh5b4hXFnlyzKHgcnV9L5ZMo7A5TWhvoFqt
        AJLyhysk5gCB/hHyMRm4DNxLPhrOKuoayRqy/TdtcKWIYKXAdj1XE2kHI3a/lsy+eLuJhEzYZ+Acj
        FUAKTl99/mwoGScn4kS7zwqcPMWylbcyfaveeGQxJyiWp53eGRLspzN4g7hTqW7xtfdjMX6Hg6Rpk
        /WFvfZQg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZAvu-0002I6-Ts; Sun, 01 Nov 2020 10:49:59 +0000
Date:   Sun, 1 Nov 2020 10:49:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/13] mm: handle readahead in
 generic_file_buffered_read_pagenotuptodate
Message-ID: <20201101104958.GU27442@casper.infradead.org>
References: <20201031090004.452516-1-hch@lst.de>
 <20201031090004.452516-5-hch@lst.de>
 <20201031170646.GT27442@casper.infradead.org>
 <20201101103144.GC26447@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101103144.GC26447@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 01, 2020 at 11:31:44AM +0100, Christoph Hellwig wrote:
> This looks sensible, but goes beyond the simple refactoring I had
> intended.  Let me take a more detailed look at your series (I had just
> updated my existing series to to the latest linux-next) and see how
> it can nicely fit in.

I'm also working on merging our two series.  I'm just about there ...
