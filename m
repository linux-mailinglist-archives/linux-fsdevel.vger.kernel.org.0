Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B3F54CB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfFYKuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 06:50:44 -0400
Received: from verein.lst.de ([213.95.11.211]:33726 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfFYKuo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:50:44 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2DE4968B05; Tue, 25 Jun 2019 12:50:12 +0200 (CEST)
Date:   Tue, 25 Jun 2019 12:50:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: Move mark_inode_dirty out of __generic_write_end
Message-ID: <20190625105011.GA2602@lst.de>
References: <20190618144716.8133-1-agruenba@redhat.com> <20190624065408.GA3565@lst.de> <20190624182243.22447-1-agruenba@redhat.com> <20190625095707.GA1462@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625095707.GA1462@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> That seems way more complicated.  I'd much rather go with something
> like may patch plus maybe a big fat comment explaining that persisting
> the size update is the file systems job.  Note that a lot of the modern
> file systems don't use the VFS inode tracking for that, besides XFS
> that includes at least btrfs and ocfs2 as well.

I'd suggest something like this as the baseline:

http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/iomap-i_size
