Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B78103B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 03:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfEABgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 21:36:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54490 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEABgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 21:36:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hLeAz-0003hC-N0; Wed, 01 May 2019 01:36:49 +0000
Date:   Wed, 1 May 2019 02:36:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/4] vfs: update ->get_link() related documentation
Message-ID: <20190501013649.GO23075@ZenIV.linux.org.uk>
References: <20190411231630.50177-1-ebiggers@kernel.org>
 <20190422180346.GA22674@gmail.com>
 <20190501002517.GF48973@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501002517.GF48973@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 05:25:17PM -0700, Eric Biggers wrote:
> On Mon, Apr 22, 2019 at 11:03:47AM -0700, Eric Biggers wrote:
> > On Thu, Apr 11, 2019 at 04:16:26PM -0700, Eric Biggers wrote:
> > > Update the documentation as per the discussion at
> > > https://marc.info/?t=155485312800001&r=1.
> > > 
> > > Eric Biggers (4):
> > >   Documentation/filesystems/vfs.txt: remove bogus "Last updated" date
> > >   Documentation/filesystems/vfs.txt: document how ->i_link works
> > >   Documentation/filesystems/Locking: fix ->get_link() prototype
> > >   libfs: document simple_get_link()
> > > 
> > >  Documentation/filesystems/Locking |  2 +-
> > >  Documentation/filesystems/vfs.txt |  8 ++++++--
> > >  fs/libfs.c                        | 14 ++++++++++++++
> > >  3 files changed, 21 insertions(+), 3 deletions(-)
> > > 
> > > -- 
> > > 2.21.0.392.gf8f6787159e-goog
> > > 
> > 
> > Al, any comment on this?  Will you be taking these?
> > 
> > - Eric
> 
> Ping?

*blink*

Thought I'd replied; apparently not...  Anyway, the problem with those
is that there'd been a series of patches converting vfs.txt to new
format; I'm not sure what Jon is going to do with it, but these are
certain to conflict.  I've no objections to the contents of changes,
but if that stuff is getting massive reformatting the first two
probably ought to go through Jon's tree.  I can take the last two
at any point.

Jon, what's the status of the format conversion?
