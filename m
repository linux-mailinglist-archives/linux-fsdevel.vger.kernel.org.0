Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36B0122322
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 05:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfLQE2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 23:28:40 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38038 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfLQE2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:28:40 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ih4TN-0007qD-Ik; Tue, 17 Dec 2019 04:28:38 +0000
Date:   Tue, 17 Dec 2019 04:28:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/12] vfs: don't parse "posixacl" option
Message-ID: <20191217042837.GX4203@ZenIV.linux.org.uk>
References: <20191128155940.17530-1-mszeredi@redhat.com>
 <20191128155940.17530-12-mszeredi@redhat.com>
 <20191217034252.GT4203@ZenIV.linux.org.uk>
 <CAJfpegs73zMDonGo+SmxHUqQMsXp6p8kOWj6+jdjJtJiMUgonw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs73zMDonGo+SmxHUqQMsXp6p8kOWj6+jdjJtJiMUgonw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 05:18:16AM +0100, Miklos Szeredi wrote:
> On Tue, Dec 17, 2019 at 4:42 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Nov 28, 2019 at 04:59:39PM +0100, Miklos Szeredi wrote:
> > > Unlike the others, this is _not_ a standard option accepted by mount(8).
> > >
> > > In fact SB_POSIXACL is an internal flag, and accepting MS_POSIXACL on the
> > > mount(2) interface is possibly a bug.
> > >
> > > The only filesystem that apparently wants to handle the "posixacl" option
> > > is 9p, but it has special handling of that option besides setting
> > > SB_POSIXACL.
> >
> > Huh?  For e.g. ceph having -o posixacl and -o acl are currently equivalent;
> > your patch would seem to break that, wouldn't it?
> 
> Yet again, this has nothing to do with mount(2) behavior.  Also note
> that mount(8) does *not* handle "posixacl" and does *not* ever set
> MS_POSIXACL.
> 
> So this has exactly zero chance of breaking anything.

Point.  OK, I'm crawling in direction of bed right now - it's that or grab more
coffee, and I'll have to get up before 7am tomorrow ;-/

Later...
