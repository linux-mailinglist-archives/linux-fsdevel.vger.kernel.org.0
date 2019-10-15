Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADADD771D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 15:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfJONLF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 09:11:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33416 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729773AbfJONLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:11:05 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9FDA5N0018119
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Oct 2019 09:10:06 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CA393420287; Tue, 15 Oct 2019 09:10:04 -0400 (EDT)
Date:   Tue, 15 Oct 2019 09:10:04 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>, Jan Kara <jack@suse.cz>,
        Pingfan Liu <kernelfans@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>, Jan Kara <jack@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: introduce "metasync" api to sync metadata to fsblock
Message-ID: <20191015131004.GA7456@mit.edu>
References: <1570977420-3944-1-git-send-email-kernelfans@gmail.com>
 <20191013163417.GQ13108@magnolia>
 <20191014083315.GA10091@mypc>
 <20191014094311.GD5939@quack2.suse.cz>
 <d3ffa114-8b73-90dc-8ba6-3f44f47135d7@sandeen.net>
 <20191014200303.GF5939@quack2.suse.cz>
 <5796090e-6206-1bd7-174e-58798c9af052@sandeen.net>
 <20191015080102.GB3055@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015080102.GB3055@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 01:01:02AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 14, 2019 at 03:09:48PM -0500, Eric Sandeen wrote:
> > We're in agreement here.  ;)  I only worry about implementing things like this
> > which sound like guarantees, but aren't, and end up encouraging bad behavior
> > or promoting misconceptions.
> > 
> > More and more, I think we should reconsider Darrick's "bootfs" (ext2 by another
> > name, but with extra-sync-iness) proposal...
> 
> Having a separate simple file system for the boot loader makes a lot of
> sense.  Note that vfat of EFI is the best choice, but at least it is
> something.  SysV Unix from the 90s actually had a special file system just
> for that, and fs/bfs/ in Linux supports that.  So this isn't really a new
> thing either.

Did you mean to say "vfaat of EFI isn't the best choice"?

If we were going to be doing something like "bootfs", what sort of
semantics would be sufficient?  Is doing an implied fsync() on every
close(2) enough, or do we need to do something even more conservative?

	 	       	       	     - Ted
