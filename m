Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B102F18427
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 05:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfEIDbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 23:31:32 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34381 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbfEIDbc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 23:31:32 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x493V03d014929
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 May 2019 23:31:01 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2CA6F420024; Wed,  8 May 2019 23:31:00 -0400 (EDT)
Date:   Wed, 8 May 2019 23:31:00 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        lsf-pc@lists.linux-foundation.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties
 contract
Message-ID: <20190509033100.GB29703@mit.edu>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu>
 <20190509014327.GT1454@dread.disaster.area>
 <20190509022013.GC7031@mit.edu>
 <20190509025845.GV1454@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509025845.GV1454@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 09, 2019 at 12:58:45PM +1000, Dave Chinner wrote:
> 
> SOMC does not defining crash consistency rules - it defines change
> dependecies and how ordering and atomicity impact the dependency
> graph. How other people have interpreted that is out of my control.

Fine; but it's a specific set of the crash consistency rules which I'm
objecting to; it's not a promise that I think I want to make.  (And
before you blindly sign on the bottom line, I'd suggest that you read
it very carefully before deciding whether you want to agree to those
consistency rules as something that XFS will have honor forever.  The
way I read it, it's goes beyond what you've articulated as SOMC.)

> A new syscall with essentially the same user interface doesn't
> guarantee that these implementation problems will be solved.

Well, it makes it easier to send all of the requests to the file
system in a single bundle.  I'd also argue that it's simpler and
easier for an application to use a fsync2() interface as I sketched
out than trying to use the whole AIO or io_uring machinery.

> So it's essentially identical to the AIO_FSYNC interface, except
> that it is synchronous.

Pretty much, yes.

> Sheesh! Did LSFMM include a free lobotomy for participants, or
> something?

Well, we missed your presence, alas.  No doubt your attendance would
have improved the discussion.

Cheers,

					- Ted
