Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DE026C829
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 20:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgIPSmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 14:42:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:37816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbgIPSXo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:23:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80D76AE64;
        Wed, 16 Sep 2020 10:54:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D4B8A1E12E1; Wed, 16 Sep 2020 12:54:18 +0200 (CEST)
Date:   Wed, 16 Sep 2020 12:54:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jan Kara <jack@suse.com>, reiserfs-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+187510916eb6a14598f7@syzkaller.appspotmail.com
Subject: Re: [PATCH] reiserfs: only call unlock_new_inode() if I_NEW
Message-ID: <20200916105418.GC3607@quack2.suse.cz>
References: <20200628070057.820213-1-ebiggers@kernel.org>
 <20200727165215.GI1138@sol.localdomain>
 <20200916040118.GB825@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916040118.GB825@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 15-09-20 21:01:18, Eric Biggers wrote:
> On Mon, Jul 27, 2020 at 09:52:15AM -0700, Eric Biggers wrote:
> > On Sun, Jun 28, 2020 at 12:00:57AM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > unlock_new_inode() is only meant to be called after a new inode has
> > > already been inserted into the hash table.  But reiserfs_new_inode() can
> > > call it even before it has inserted the inode, triggering the WARNING in
> > > unlock_new_inode().  Fix this by only calling unlock_new_inode() if the
> > > inode has the I_NEW flag set, indicating that it's in the table.
> > > 
> > > This addresses the syzbot report "WARNING in unlock_new_inode"
> > > (https://syzkaller.appspot.com/bug?extid=187510916eb6a14598f7).
> > > 
> > > Reported-by: syzbot+187510916eb6a14598f7@syzkaller.appspotmail.com
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > 
> > Anyone interested in taking this patch?
> 
> Jan, you seem to be taking some reiserfs patches... Any interest in
> taking this one?

Sure, the patch looks good to me so I've added it to my tree. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
