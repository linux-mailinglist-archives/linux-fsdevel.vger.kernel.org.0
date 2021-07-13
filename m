Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15833C77C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 22:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhGMUVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 16:21:14 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33114 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhGMUVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:21:14 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3OrF-000NQg-Hw; Tue, 13 Jul 2021 20:18:21 +0000
Date:   Tue, 13 Jul 2021 20:18:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <YO31DWtFMZuqF8tm@zeniv-ca.linux.org.uk>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
 <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
 <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 13, 2021 at 08:14:04PM +0000, Al Viro wrote:
> On Tue, Jul 13, 2021 at 12:15:13PM -0700, Linus Torvalds wrote:
> > On Tue, Jul 13, 2021 at 3:45 AM Hans de Goede <hdegoede@redhat.com> wrote:
> > >
> > > Linus, sorry for sending this directly through you, instead of going
> > > through some other tree, but trying to get this upstream through the
> > > linux-fsdevel list / patch-review simply is not working.
> > 
> > Well, the filesystem maintainer sending their patches to me as a pull
> > request is actually the norm rather than the exception when it comes
> > to filesystems.
> > 
> > It's a bit different for drivers, but that's because while we have
> > multiple filesystems, we have multiple _thousand_ drivers, so on the
> > driver side I really don't want individual driver maintainers to all
> > send me their individual pull requests - that just wouldn't scale.
> > 
> > So for individual drivers, we have subsystem maintainers, but for
> > individual filesystems we generally don't.
> > 
> > (When something then touches the *common* vfs code, that's a different
> > thing - but something like this vboxsf thing this pull request looks
> > normal to me).
> 
> To elaborate a bit - there's one case when I want it to go through
> vfs.git, and that's when there's an interference between something
> going on in vfs.git and the work done in filesystem.

Example: if there's a series changing calling conventions for some method
brewing in vfs.git and changes to filesystem's instance of that method
in the filesystem tree.  Then I'd rather it coordinated before either
gets merged.  It might be an invariant branch in either tree pulled by
both, it might be a straight pull into vfs.git and sorting the things out
there - depends upon the situation.
