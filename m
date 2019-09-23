Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2959BBB51C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 15:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439674AbfIWNTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 09:19:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51834 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2439591AbfIWNTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:19:05 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8NDIEHw002725
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 09:18:15 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7F45B420811; Mon, 23 Sep 2019 09:18:14 -0400 (EDT)
Date:   Mon, 23 Sep 2019 09:18:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, hch@infradead.org, andres@anarazel.de,
        david@fromorbit.com, riteshh@linux.ibm.com,
        linux-f2fs-devel@lists.sourceforge.net,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/3] ext4: fix inode rwsem regression
Message-ID: <20190923131814.GB6005@mit.edu>
References: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
 <20190911164517.16130-1-rgoldwyn@suse.de>
 <20190911164517.16130-3-rgoldwyn@suse.de>
 <20190923101042.GA25332@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923101042.GA25332@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 23, 2019 at 12:10:42PM +0200, Jan Kara wrote:
> On Wed 11-09-19 11:45:16, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > This is similar to 942491c9e6d6 ("xfs: fix AIM7 regression")
> > Apparently our current rwsem code doesn't like doing the trylock, then
> > lock for real scheme.  So change our read/write methods to just do the
> > trylock for the RWF_NOWAIT case.
> > 
> > Fixes: 728fbc0e10b7 ("ext4: nowait aio support")
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Thanks for fixing this! The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> BTW, I've also added Ted as ext4 maintainer to CC.

Thanks, I've been following along, and once the merge window is over
I'll start going through the patch backlog.

Cheers,

						- Ted
