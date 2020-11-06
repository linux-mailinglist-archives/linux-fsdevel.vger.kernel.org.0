Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E2B2A90FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 09:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgKFIIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 03:08:17 -0500
Received: from verein.lst.de ([213.95.11.211]:50527 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgKFIIR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:08:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BF3E968B05; Fri,  6 Nov 2020 09:08:15 +0100 (CET)
Date:   Fri, 6 Nov 2020 09:08:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH v2 02/18] mm/filemap: Remove dynamically allocated
 array from filemap_read
Message-ID: <20201106080815.GC31585@lst.de>
References: <20201104204219.23810-1-willy@infradead.org> <20201104204219.23810-3-willy@infradead.org> <20201104213005.GB3365678@moria.home.lan> <20201105001302.GF17076@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105001302.GF17076@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 05, 2020 at 12:13:02AM +0000, Matthew Wilcox wrote:
> I have the beginnings of a patch for that, but I got busy with other stuff
> and didn't finish it.

If we have numbers that we want larger batch sizes than the current
pagevec PAGEVEC_SIZE this is the way to go insted of special casing
it in one path.
