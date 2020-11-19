Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE692B9ADD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 19:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgKSSqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 13:46:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:53674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbgKSSqM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:46:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10D35AC2D;
        Thu, 19 Nov 2020 18:46:11 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id CB9E4603F9; Thu, 19 Nov 2020 19:46:10 +0100 (CET)
Date:   Thu, 19 Nov 2020 19:46:10 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] eventfd: convert to ->write_iter()
Message-ID: <20201119184610.sxc7utcsfwsqvwu5@lion.mk-sys.cz>
References: <ed4484a3dc8297296bfcd16810f7dc1976d6f7d0.1605808477.git.mkubecek@suse.cz>
 <20201119180315.GB24054@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119180315.GB24054@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 06:03:15PM +0000, Christoph Hellwig wrote:
> On Thu, Nov 19, 2020 at 07:00:19PM +0100, Michal Kubecek wrote:
> > While eventfd ->read() callback was replaced by ->read_iter() recently by
> > commit 12aceb89b0bc ("eventfd: convert to f_op->read_iter()"), ->write()
> > was not replaced.
> > 
> > Convert also ->write() to ->write_iter() to make the interface more
> > consistent and allow non-blocking writes from e.g. io_uring. Also
> > reorganize the code and return value handling in a similar way as it was
> > done in eventfd_read().
> 
> But this patch does not allow non-blocking writes.  I'm really
> suspicious as you're obviously trying to hide something from us.

I already explained what my original motivation was and explained that
it's no longer the case as the third party module that inspired me to
take a look at this can be easily patched not to need kernel_write() to
eventfd - and that it almost certainly will have to be patched that way
anyway. BtW, the reason I did not mention out of tree modules in the
commit message was exactly this: I suspected that any mention of them
could be a red flag for some people.

I believed - and I still believe - that this patch is useful for other
reasons and Jens added another. Therefore I resubmitted with commit
message rewritten as requested, even if I don't need it personally. I'm
not hiding anything and I don't have time for playing your political
games and suffer your attacks. If they are more important than improving
kernel code, so be it. I'm annoyed enough and I don't care any more.

Michal Kubecek
