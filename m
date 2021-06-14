Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868D23A6B09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhFNP5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 11:57:36 -0400
Received: from verein.lst.de ([213.95.11.211]:45105 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233222AbhFNP5f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:57:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 330D768AFE; Mon, 14 Jun 2021 17:55:30 +0200 (CEST)
Date:   Mon, 14 Jun 2021 17:55:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove the implicit .set_page_dirty default
Message-ID: <20210614155530.GA2563@lst.de>
References: <20210614061512.3966143-1-hch@lst.de> <YMdKOst/Psnlxh8a@casper.infradead.org> <20210614155333.GB2413@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614155333.GB2413@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:53:33PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 14, 2021 at 01:23:22PM +0100, Matthew Wilcox wrote:
> > i have a somewhat similar series in the works ...
> > 
> > https://git.infradead.org/users/willy/pagecache.git/commitdiff/1e7e8c2d82666b55690705d5bbe908e31d437edb
> > https://git.infradead.org/users/willy/pagecache.git/commitdiff/bf767a4969c0bc6735275ff7457a8082eef4c3fd
> > 
> > ... the other patches rather depend on the folio work.
> 
> Yes, these looks useful to me as well.


And in fact I suspect the code in __set_page_dirty_no_writeback should
really be the default if no ->set_page_dirty is set up.  It is the
same code as the no-mapping case and really makes sense as the default
case..
