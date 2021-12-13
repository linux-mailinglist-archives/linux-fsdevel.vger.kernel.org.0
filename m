Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E347220F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 09:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhLMID4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 03:03:56 -0500
Received: from verein.lst.de ([213.95.11.211]:46547 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhLMIDz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:03:55 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2F0D268BFE; Mon, 13 Dec 2021 09:03:53 +0100 (CET)
Date:   Mon, 13 Dec 2021 09:03:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] iov_iter support for a single kernel address
Message-ID: <20211213080353.GA21192@lst.de>
References: <Yba+YSF6mkM/GYlK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yba+YSF6mkM/GYlK@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 03:30:41AM +0000, Matthew Wilcox wrote:
> 
> When working on the vmcore conversion to iov_iter, I noticed we had a
> lot of places that construct a single kvec on the stack, and it seems a
> little wasteful.  Adding an ITER_KADDR type makes the iov_iter a little
> easier to use.
> 
> I included conversion of 9p to use ITER_KADDR so you can see whether you
> think it's worth doing.

While it does look sensible on its own, I'm rather worried about bloating
the iov_iter interface with ever more types.
