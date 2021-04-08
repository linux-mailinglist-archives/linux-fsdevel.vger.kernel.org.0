Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5B7358B01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 19:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhDHRLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 13:11:03 -0400
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:35644 "EHLO
        elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232208AbhDHRLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:11:03 -0400
X-Greylist: delayed 1320 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Apr 2021 13:11:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1617901852; bh=bQFvbVAy17UPJCo8TddDZiuDi1m5tCJ51+HC
        FzSEF34=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:
         X-Originating-IP; b=VHKqNs/sMazeF7v88xW6O6LlbHLp8oPS6Rw6/7z2bu9jss
        qCCmyhPg1sZz7n0I5hvVFChjLvIUUmqwhofe2DtvnM22ZeOUzS6+Y53k+d75P5qhALC
        CkiSLCt2P/1crvIVUIKXLXi1bOVlvC2XJiCcrjl10Ka3KF/wrtFQNwjmU/ECzmUPqtY
        OH7Rf35VAwl0wttwC9YfeY8kEwXtjpvRnC3iWWUY3Uhz7BTBsG2sXsAG7Q3CgR1dSQh
        xB2EaifVlzuIPAnIxWL0+OYQsCMBWRM5g0WRe31kkDXLvsMRRbtsA4Ng7BJVoqotpzN
        p3tT4h6SwuQcuvXylO2MExUADPNw==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=jWNW66mnSYcgabzYKwMaEh5/8CP0us7VsFAOWOHFH41OfEzbPD284h6WiVd+kWeZsIBBgCeAOn7yoZAXmx3lYazyvsAoUvAO3EWJqY0GPirf4sMJ1OcdJ8mJ2m5NnCHHgQvyjiG0h3Tmswdd2x8Qfsf0NDze9BrtVMW1h569uqH4Q68JG6Ci9XwvrPHJRmB2CM8egEJr+OFRh3/EHflMg64XzVkObsC5R9Xo9h1FfB+PcEzvZZg1bcQfkt6w6BVZ3o58PSyqmO/FqCpGFKkKDWzBdx4Zp56g17aVk6WUBLby6Y5I2io4gDOIgd24FzX3zu6FT75Su5ymAvHMxyr0LA==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-mealy.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1lUXpk-000CpV-OP; Thu, 08 Apr 2021 12:48:44 -0400
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Amir Goldstein'" <amir73il@gmail.com>
Cc:     "'Christian Brauner'" <christian.brauner@ubuntu.com>,
        "'Jan Kara'" <jack@suse.cz>,
        "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        "'Linux API'" <linux-api@vger.kernel.org>,
        "'Miklos Szeredi'" <miklos@szeredi.hu>
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330073101.5pqvw72fxvyp5kvf@wittgenstein> <CAOQ4uxjQFGdT0xH17pm-nSKE_0--z_AapRW70MNrLJLcCB6MAg@mail.gmail.com> <CAOQ4uxiizVxVJgtytYk_o7GvG2O2qwyKHgScq8KLhq218CNdnw@mail.gmail.com> <20210331100854.sdgtzma6ifj7w5yn@wittgenstein> <CAOQ4uxjHsqZqLT-DOPS0Q0FiHZ2Ge=d3tP+3-qd+O2optq9rZg@mail.gmail.com> <20210408125530.gnv5hqcmgewklypn@wittgenstein> <20210408141504.GB25439@fieldses.org> <CAOQ4uxjkr_3d3KUkjMCtdpg===ZOPOwv41bUBkTppLmqRErHZQ@mail.gmail.com> <20210408160844.GD25439@fieldses.org>
In-Reply-To: <20210408160844.GD25439@fieldses.org>
Subject: RE: open_by_handle_at() in userns
Date:   Thu, 8 Apr 2021 09:48:42 -0700
Message-ID: <129801d72c97$09f82460$1de86d20$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHjiGW2X8wBJuoRKwYv8KHaUIoTfgHS+L1pAUFSJSIC9MC69wJifODqAY6fAV0BA8nN3wIhX2GkAmC2qi4CM0d6q6oEgc7A
Content-Language: en-us
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d686da7ba0b6815a578d96f8f8a770c38350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu, Apr 08, 2021 at 06:54:52PM +0300, Amir Goldstein wrote:
> > They are understood to me :) but I didn't want to get into it, because
> > it is complicated to explain and I wasn't sure if anyone cared...
> >
> > I started working on open_by_handle_at() in userns for fanotify and
> > fanotify mostly reports directory fhandle, so no issues with
cross-directory
> renames.
> > In any case, fanotify never reports "connectable" non-dir file handles.
> >
> > Because my proposed change ALSO makes it possible to start talking
> > about userspace nfs server inside userns (in case anyone cares), I
> > wanted to lay out the path towards a userspace "subtree_check" like
solution.
> 
> We have to support subdirectory exports and subtree checking because we
> already have, but, FWIW, if I were writing a new NFS server from scratch,
I don't
> think I would.  It's poorly understood, and the effort would be better
spent on
> more flexible storage management.

Yea, nfs-ganesha does not attempt to support subtree checking. It will allow
subtree exports, but it makes no assurance that they are secure. One option
though that turns out to work well for them is btrfs subvols since each
subvol has its own st_dev device ID, it's really as if it's a separate
filesystem (and nfs-ganesha treats it as such).

I'm curious about the userns solution. I'm not familiar with it, but we have
issues with running nfs-ganesha inside containers due to the privileges it
requires to properly run.

> > Another thing I am contemplating is, if and when idmapped mount
> > support is added to overlayfs, we can store an additional
> > "connectable" file handle in the overlayfs index (whose key is the
> > non-connectable fhandle) and fix ovl_acceptable() similar to
> > nfsd_acceptable() and then we will be able to mount an overlayfs inside
userns
> with nfs_export support.
> >
> > I've included a two liner patch on the fhandle_userns branch to allow
> > overlayfs inside userns with nfs_export support in the case that
> > underlying filesystem was mounted inside userns, but that is not such
> > an interesting use case IMO.
> >
> > Thanks,
> > Amir.

