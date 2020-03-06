Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E18D17C67A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 20:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFTtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 14:49:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60746 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725922AbgCFTtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:49:00 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 026JmhG1023168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Mar 2020 14:48:44 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8CEDB42045B; Fri,  6 Mar 2020 14:48:43 -0500 (EST)
Date:   Fri, 6 Mar 2020 14:48:43 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
Message-ID: <20200306194843.GA12490@mit.edu>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
 <20200306155611.GA167883@mit.edu>
 <72708005-0810-1957-1e58-5b70779ab6db@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72708005-0810-1957-1e58-5b70779ab6db@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 11:08:36AM -0500, Josef Bacik wrote:
> 
> I'd be down for this.  Would you leave the thing open so anybody can
> register, or would you still have an invitation system?  I really, really
> despise the invitation system just because it's inherently self limiting.
> However I do want to make sure we are getting relevant people in the room,
> and not making it this "oh shit, I forgot to register, and now the
> conference is full" sort of situations.  Thanks,

There are lots of different ways it can be done.  The Maintainer's
Summit is an invite-only half-day event.  That's mainly because it's
about development processes, and there are lots of people who have a
strong interest in that, but we want to keep it done to small number
of people so we can have real conversations.

At Plumbers, the miniconfs leads can give a list of (six?) people they
really want to be present.  A few get free registration; the others
get guaranteed registrations thus bypassing the waitlist.  One of the
problems is that the miniconf leads don't always get the list of
people to the planning committee until late in the process, which made
the waitlist management problem even more painful.  At the miniconf,
there is social pressure so that the key attendees are seated near the
front of the room, and there might be audience of a few hundred that
are in listen-mostly mode, but for most technical topics, that isn't
that much of a problem.

I've also seen other cases where the room is small, and there is a
list of people who have guaranteed access to the room, and everyone
else (up to the fire limit) might have to sit or stand against the
wall, etc.

If we have a conference with many tracks, the different tracks can
have different admittance policies, such is as the case with the
Maintainer's Summit, Kernel Summit, Miniconfs, etc.  So that's
something which I think can be negotiated.

I suspect that for most of the LSF/MM contential topics, I doubt we
would have hundreds of people clamoring to get in on a discussion
about to handle, say, clearing DAX flag on files that might still be
in use by some RDMA drive.  That is *such* a fascinating topic, but I
doubt there really will be a need to limit attendance.  :-)

      	    	   	     	     - Ted

P.S.  I do need to note that there is one big advantage to invite-only
summts such as the LSF/MM and the old-style Kernel Summit.  Companies
who really want to present about, say, dual-actuator HDD's, or the
latest NVMe / Open Channel interface, are much more likely to pay $$$
to get access to an invite-only event.  When we moved to the
process-only Maintainer's Summit, and the Kernel Summit for the
technical tracks, it most definitely hurt the amount of sponsorship
dollars that we got for the Maintainer's Summit.

That's not a bad thing, but it might mean that we will need to cut
costs by drafting behind the LF, and maybe not having as nice evening
receptions, or as nice attendee gifts like we used to do in the early
years of the Kernel Summit.  Personally, I think that's *fine*; it's
the collaboration with fellow developers which is highest on my list
of priorities, and not the opportunities for fine dining or going to
fun cities.  And if giving up on some of these amenities means that I
can bring some of the more junior engineers on my team so they can
meet other file system developers, I'm **all** for it.  But for some
folks, they may view this tradeoff as a loss.
