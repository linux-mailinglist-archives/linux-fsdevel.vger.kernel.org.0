Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD64D1E01F6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 21:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbgEXTR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 15:17:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56895 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387823AbgEXTR0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 15:17:26 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04OJHDUC017213
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 May 2020 15:17:13 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 238DA420304; Sun, 24 May 2020 15:17:13 -0400 (EDT)
Date:   Sun, 24 May 2020 15:17:13 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        jack@suse.cz, adilger@dilger.ca, riteshh@linux.ibm.com,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: fiemap cleanups v4
Message-ID: <20200524191713.GA228632@mit.edu>
References: <20200523073016.2944131-1-hch@lst.de>
 <20200523155216.GZ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523155216.GZ23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 23, 2020 at 04:52:16PM +0100, Al Viro wrote:
> On Sat, May 23, 2020 at 09:30:07AM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > This series cleans up the fiemap support in ext4 and in general.
> > 
> > Ted or Al, can one of you pick this up?  It touches both ext4 and core
> > code, so either tree could work.
> > 
> > 
> > Changes since v3:
> >  - dropped the fixes that have been merged int mainline
> > 
> > Changes since v2:
> >  - commit message typo
> >  - doc updates
> >  - use d_inode in cifs
> >  - add a missing return statement in cifs
> >  - remove the filemap_write_and_wait call from ext4_ioctl_get_es_cache
> > 
> > Changes since v1:
> >  - rename fiemap_validate to fiemap_prep
> >  - lift FIEMAP_FLAG_SYNC handling to common code
> >  - add a new linux/fiemap.h header
> >  - remove __generic_block_fiemap
> >  - remove access_ok calls from fiemap and ext4
> 
> Hmmm...  I can do an immutable shared branch, no problem.  What would
> you prefer for a branchpoint for that one?

I thought we had already agreed to run these patches through the ext4
git tree, since most of the changes affect the ext4 tree (and there
aren't any other iomap fiemap changes pending as far as I know).

The v3 versions of these patches have been part of the ext4 dev tree
since May 19th.  Since the ext4 dev tree is rewinding, I can easily
update it fiemap-fixes patch to be on top of the first two patches
which Linus has already accepted, and then merge it into the ext4 dev
branch.

							- Ted

