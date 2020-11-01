Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6B2A1D6E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 11:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgKAKvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 05:51:16 -0500
Received: from verein.lst.de ([213.95.11.211]:58350 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgKAKvQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 05:51:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2CCDF6736F; Sun,  1 Nov 2020 11:51:13 +0100 (CET)
Date:   Sun, 1 Nov 2020 11:51:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/13] mm: handle readahead in
 generic_file_buffered_read_pagenotuptodate
Message-ID: <20201101105112.GA26860@lst.de>
References: <20201031090004.452516-1-hch@lst.de> <20201031090004.452516-5-hch@lst.de> <20201031170646.GT27442@casper.infradead.org> <20201101103144.GC26447@lst.de> <20201101104958.GU27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101104958.GU27442@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 01, 2020 at 10:49:58AM +0000, Matthew Wilcox wrote:
> On Sun, Nov 01, 2020 at 11:31:44AM +0100, Christoph Hellwig wrote:
> > This looks sensible, but goes beyond the simple refactoring I had
> > intended.  Let me take a more detailed look at your series (I had just
> > updated my existing series to to the latest linux-next) and see how
> > it can nicely fit in.
> 
> I'm also working on merging our two series.  I'm just about there ...

Heh, same here.
