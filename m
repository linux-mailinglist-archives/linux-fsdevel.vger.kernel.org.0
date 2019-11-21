Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7309F105859
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 18:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKURPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 12:15:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:55688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbfKURPu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:15:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5D85B15A;
        Thu, 21 Nov 2019 17:15:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4DD471E484C; Thu, 21 Nov 2019 18:15:47 +0100 (CET)
Date:   Thu, 21 Nov 2019 18:15:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 0/2] iomap: Fix leakage of pipe pages while splicing
Message-ID: <20191121171547.GE18158@quack2.suse.cz>
References: <20191121161144.30802-1-jack@suse.cz>
 <20191121165829.GK6211@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121165829.GK6211@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-11-19 08:58:29, Darrick J. Wong wrote:
> On Thu, Nov 21, 2019 at 05:15:33PM +0100, Jan Kara wrote:
> > Hello,
> > 
> > here is a fix and a cleanup for iomap code. The first patch fixes a leakage
> > of pipe pages when iomap_dio_rw() splices to a pipe, the second patch is
> > a cleanup that removes strange copying of iter in iomap_dio_rw(). Patches
> > have passed fstests for ext4 and xfs and fix the syzkaller reproducer for
> > me.
> 
> Will have a look, but in the meantime -- do you have quick reproducer
> that can be packaged for fstests?  Or is it just the syzbot reproducer?

I have just the syzkaller reproducer but now that I understand the problem 
I might be able to write something more readable... I'll try.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
