Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33157561FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 08:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfFZGEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 02:04:04 -0400
Received: from verein.lst.de ([213.95.11.211]:40364 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZGEE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:04:04 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 74653227A82; Wed, 26 Jun 2019 08:03:30 +0200 (CEST)
Date:   Wed, 26 Jun 2019 08:03:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: Move mark_inode_dirty out of __generic_write_end
Message-ID: <20190626060329.GA23666@lst.de>
References: <20190618144716.8133-1-agruenba@redhat.com> <20190624065408.GA3565@lst.de> <20190624182243.22447-1-agruenba@redhat.com> <20190625095707.GA1462@lst.de> <20190625105011.GA2602@lst.de> <20190625181329.3160-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625181329.3160-1-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 08:13:29PM +0200, Andreas Gruenbacher wrote:
> On Tue, 25 Jun 2019 at 12:50, Christoph Hellwig <hch@lst.de> wrote:
> >
> > > That seems way more complicated.  I'd much rather go with something
> > > like may patch plus maybe a big fat comment explaining that persisting
> > > the size update is the file systems job.  Note that a lot of the modern
> > > file systems don't use the VFS inode tracking for that, besides XFS
> > > that includes at least btrfs and ocfs2 as well.
> >
> > I'd suggest something like this as the baseline:
> >
> > http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/iomap-i_size
> 
> Alright, can we change this as follows?
> 
> [Also, I'm not really sure why we check for (pos + ret > inode->i_size)
> when we have already read inode->i_size into old_size.]

Yeah, you probably want to change that to old_size.  Your changes look
good to me,

Can you just take the patch over from here as you've clearly done more
work on it and resend the whole series?
