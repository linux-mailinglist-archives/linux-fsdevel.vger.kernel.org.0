Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241A93A6AF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 17:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhFNPye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 11:54:34 -0400
Received: from verein.lst.de ([213.95.11.211]:45084 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233484AbhFNPyd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:54:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 13D1068AFE; Mon, 14 Jun 2021 17:52:28 +0200 (CEST)
Date:   Mon, 14 Jun 2021 17:52:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: unexport __set_page_dirty
Message-ID: <20210614155227.GA2413@lst.de>
References: <20210614061512.3966143-1-hch@lst.de> <20210614061512.3966143-2-hch@lst.de> <YMdMaqC0DP26h+Gq@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMdMaqC0DP26h+Gq@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 01:32:42PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 14, 2021 at 08:15:10AM +0200, Christoph Hellwig wrote:
> > __set_page_dirty is only used by built-in code.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> You might also want to do the equivalent of this:
> 
> https://git.infradead.org/users/willy/pagecache.git/commitdiff/19b3bf0d1a51f41ce5450fdd863969c3d32dfe12

This looks nice, but not really directly related.  I think you
should just send it to Andrew.
