Return-Path: <linux-fsdevel+bounces-1929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB3F7E057A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 16:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337EF2821CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 15:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7181BDF3;
	Fri,  3 Nov 2023 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="coTe0LEz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9E1BDC4
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 15:22:00 +0000 (UTC)
X-Greylist: delayed 541 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Nov 2023 08:21:54 PDT
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F316FD47
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 08:21:54 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SMPPZ5Dc3zMqHwH;
	Fri,  3 Nov 2023 15:12:50 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SMPPY4lgZzMpnxX;
	Fri,  3 Nov 2023 16:12:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1699024370;
	bh=WtZqmwXUnq57o+AzLTJgU+VUoIl1dLU14BJXPCU6YEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=coTe0LEzZzUt1OyNEJfw7zEjaxThNLr+3pcCk7t+n2U974S5jx6Nt/8g0h/oLvMtQ
	 u0MS1iCP1WTdxFBLcU2WP+Q4ONEv36Q+nJ3E9MoQmo2Z/pEfZLqD4nUDfmtlZnQtcO
	 6RGuodg8zb2tzYGSi4kcP4Tc7JXCz17+xdBiZIPs=
Date: Fri, 3 Nov 2023 16:12:45 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 0/5] Landlock: IOCTL support
Message-ID: <20231103.eegh9eg2fieN@digikod.net>
References: <20230826.ohtooph0Ahmu@digikod.net>
 <ZPMiVaL3kVaTnivh@google.com>
 <20230904.aiWae8eineo4@digikod.net>
 <ZP7lxmXklksadvz+@google.com>
 <20230911.jie6Rai8ughe@digikod.net>
 <ZTGpIBve2LVlbt6p@google.com>
 <20231020.moefooYeV9ei@digikod.net>
 <ZTmRoESR5eXEA_ky@google.com>
 <20231026.oiPeosh1yieg@digikod.net>
 <ZUTwbTc6BETB1ClB@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUTwbTc6BETB1ClB@google.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 03, 2023 at 02:06:53PM +0100, Günther Noack wrote:
> Hello Mickaël!
> 
> Thanks for the review!
> 
> On Thu, Oct 26, 2023 at 04:55:30PM +0200, Mickaël Salaün wrote:
> > The third column "IOCTL unhandled" is not reflected here. What about
> > this patch?
> > 
> > if (!(handled & LANDLOCK_ACCESS_FS_IOCTL)) {
> >   return am | dst;
> > }
> 
> You are right that this needs special treatment.  The reasoning is the scenario
> where a user creates a ruleset where LANDLOCK_ACCESS_FS_READ_FILE is handled,
> but LANDLOCK_ACCESS_FS_IOCTL is not.  In that case, when a file is opened for
> which we do not have the READ_FILE access right, without your additional check,
> the IOCTLs associated with READ_FILE would be forbidden.  But this is also a
> Landlock usage that was possible before the introduction of the IOCTL handling,
> and so all IOCTLs should work in that case.
> 
> > 
> > >     if (handled & src) {
> > >       /* If "src" access right is handled, populate "dst" from "src". */
> > >       return am | ((am & src) ? dst : 0);
> > >     } else {
> > >       /* Otherwise, populate "dst" flag from "ioctl" flag. */
> > >       return am | ((am & LANDLOCK_ACCESS_FS_IOCTL) ? dst : 0);
> > >     }
> > >   }
> > > 
> > >   static access_mask_t expand_all_ioctl(access_mask_t handled, access_mask_t am)
> > >   {
> > 
> > Instead of reapeating "am | " in expand_ioctl() and assigning am several
> > times in expand_all_ioctl(), you could simply do something like that:
> > 
> > return am |
> > 	expand_ioctl(handled, am, ...) |
> > 	expand_ioctl(handled, am, ...) |
> > 	expand_ioctl(handled, am, ...);
> 
> Agreed, this is more elegant.  Will do.
> 
> 
> > >     am = expand_ioctl(handled, am,
> > >                       LANDLOCK_ACCESS_FS_WRITE_FILE,
> > > 		      IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G4);
> > >     am = expand_ioctl(handled, am,
> > >                       LANDLOCK_ACCESS_FS_READ_FILE,
> > > 		      IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G3);
> > >     am = expand_ioctl(handled, am,
> > >                       LANDLOCK_ACCESS_FS_READ_DIR,
> > > 		      IOCTL_CMD_G1);
> > >     return am;
> > >   }
> > > 
> > >   and then during the installing of a ruleset, we'd call
> > >   expand_all_ioctl(handled, access) for each specified file access, and
> > >   expand_all_ioctl(handled, handled) for the handled access rights,
> > >   to populate the synthetic IOCTL_CMD_G* access rights.
> > 
> > We can do these transformations directly in the new
> > landlock_add_fs_access_mask() and landlock_append_fs_rule().
> 
> Working on these changes, the location of these transformations is one of the
> last outstanding problems that I don't like yet.
> 
> I have added the expansion code to landlock_add_fs_access_mask() and
> landlock_append_fs_rule() as you suggested.
> 
> This works, but as a result, this (somewhat complicated) expansion logic is now
> part of the ruleset.o module, where it seems a bit too FS-specific.  I think
> that maybe we can pull this out further, but I'll probably send you a patch set
> with the current status before doing that, so that we are on the same page.

I guess we can put the expand functions in fs.c .

But at that point we need an actual patch to discuss such details.

> 
> 
> > Please base the next series on
> > https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
> > This branch might be rebased from time to time, but only minor changes
> > will get there.
> 
> OK, will do.
> 
> 
> In summary, I'll send a patch soon.
> 
> FYI, some open questions I still have are:
> 
> * Logic
>   * How will userspace libraries handle best-effort fallback,
>     when expanded IOCTL access rights come into play?
>     (Still need to think about this more.)

If users set the GFX right, the library should fallback to the IOCTL
right if GFX is not supported.

> * Internal code layout
>   * Move expansion logic out of ruleset.o module into syscalls.o?
>   * Find more appropriate names for IOCTL_CMD_G1,...,IOCTL_CMD_G4

Actually, I think these groups should be static const variables defined
in the function that uses them, so the naming would not change much.
Maybe something like ioctl_groupN?

> 
> but we can discuss these in the context of the next patch set.

Definitely

> 
> —Günther

