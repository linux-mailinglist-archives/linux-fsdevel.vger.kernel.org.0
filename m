Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE9A207701
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 17:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404473AbgFXPO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 11:14:58 -0400
Received: from verein.lst.de ([213.95.11.211]:44721 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404271AbgFXPO6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:14:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1839968B02; Wed, 24 Jun 2020 17:14:55 +0200 (CEST)
Date:   Wed, 24 Jun 2020 17:14:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: move block bits out of fs.h
Message-ID: <20200624151454.GB17344@lst.de>
References: <20200620071644.463185-1-hch@lst.de> <c2fba635-b2ce-a2b5-772b-4bfcb9b43453@kernel.dk> <20200624151211.GA17344@lst.de> <216bcea4-a38d-8a64-bc0f-be61b2f26e79@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216bcea4-a38d-8a64-bc0f-be61b2f26e79@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 09:14:11AM -0600, Jens Axboe wrote:
> On 6/24/20 9:12 AM, Christoph Hellwig wrote:
> > On Wed, Jun 24, 2020 at 09:09:42AM -0600, Jens Axboe wrote:
> >> Applied for 5.9 - I kept this in a separate topic branch, fwiw. There's the
> >> potential for some annoying issues with this, so would rather have it in
> >> a branch we can modify easily, if we need to.
> > 
> > Hmm, I have a bunch of things building on top of this pending, so that
> > branch split will be interesting to handle.
> 
> We can stuff it in for-5.9/block, but then I'd rather just rebase that
> on 5.8-rc2 now since it's still early days. If we don't, we already
> have conflicts...

I'll happily rebase.  rc1 also has funny ext4 warnings which are
pretty annoying.
