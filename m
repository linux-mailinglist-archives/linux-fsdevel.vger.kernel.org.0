Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9F3A6AFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 17:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhFNPzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 11:55:39 -0400
Received: from verein.lst.de ([213.95.11.211]:45090 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233831AbhFNPzh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:55:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5A16968AFE; Mon, 14 Jun 2021 17:53:33 +0200 (CEST)
Date:   Mon, 14 Jun 2021 17:53:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove the implicit .set_page_dirty default
Message-ID: <20210614155333.GB2413@lst.de>
References: <20210614061512.3966143-1-hch@lst.de> <YMdKOst/Psnlxh8a@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMdKOst/Psnlxh8a@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 01:23:22PM +0100, Matthew Wilcox wrote:
> i have a somewhat similar series in the works ...
> 
> https://git.infradead.org/users/willy/pagecache.git/commitdiff/1e7e8c2d82666b55690705d5bbe908e31d437edb
> https://git.infradead.org/users/willy/pagecache.git/commitdiff/bf767a4969c0bc6735275ff7457a8082eef4c3fd
> 
> ... the other patches rather depend on the folio work.

Yes, these looks useful to me as well.
