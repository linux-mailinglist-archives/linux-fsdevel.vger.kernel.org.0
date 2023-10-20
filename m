Return-Path: <linux-fsdevel+bounces-839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91DA7D1237
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 17:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2EA282504
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CEF1DA43;
	Fri, 20 Oct 2023 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qzA0ywzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBC41DA38
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 15:07:34 +0000 (UTC)
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Oct 2023 08:07:31 PDT
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9F5A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 08:07:31 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SBnkc6psDzMq06D;
	Fri, 20 Oct 2023 14:57:44 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SBnkc1QKXzMpp01;
	Fri, 20 Oct 2023 16:57:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1697813864;
	bh=+E3xuq2zscvbr6YOq9c7+a3VmTvrRogs9lMHmeV5taM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzA0ywzN5ziDEy154xfSJ4qEGNj8DgZciquGG3ZrQk4LuTqFIqVqG1Tp1KG7PyGcO
	 /E1EBc1XmNxptF8Ssp4WE4he2DxcTEteUskQkmNULrJxpP3aL7vfxu2vc1ijxuGVKh
	 WA9aA5orDwzxy4fKeY+5Y8+7CzmaReH29Ib2Hjpk=
Date: Fri, 20 Oct 2023 16:57:39 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 0/5] Landlock: IOCTL support
Message-ID: <20231020.moefooYeV9ei@digikod.net>
References: <20230814172816.3907299-1-gnoack@google.com>
 <20230818.iechoCh0eew0@digikod.net>
 <ZOjCz5j4+tgptF53@google.com>
 <20230825.Zoo4ohn1aivo@digikod.net>
 <20230826.ohtooph0Ahmu@digikod.net>
 <ZPMiVaL3kVaTnivh@google.com>
 <20230904.aiWae8eineo4@digikod.net>
 <ZP7lxmXklksadvz+@google.com>
 <20230911.jie6Rai8ughe@digikod.net>
 <ZTGpIBve2LVlbt6p@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTGpIBve2LVlbt6p@google.com>
X-Infomaniak-Routing: alpha

On Fri, Oct 20, 2023 at 12:09:36AM +0200, Günther Noack wrote:
> Hello!
> 
> On Mon, Sep 11, 2023 at 05:25:31PM +0200, Mickaël Salaün wrote:
> > On Mon, Sep 11, 2023 at 12:02:46PM +0200, Günther Noack wrote:
> > > Thank you for making the algorithm that explicit -- that helps to trace down the
> > > differences.  I can follow the logic now, but I still don't understand what your
> > > underlying rationale for that is?
> > > 
> > > I believe that fundamentally, a core difference is:
> > > 
> > > For an access right R and a file F, for these two cases:
> > > 
> > >  (a) the access right R is unhandled  (nothing gets restricted)
> > >  (b) the access right R is handled, but R is granted for F in a rule.
> > > 
> > > I believe that accesses in case (a) and (b) to the file F should have the same
> > > results.
> > > 
> > > This is at least how the existing Landlock implementation works, as far as I can
> > > tell.
> > > 
> > > ("Refer" is an exceptional case, but we have documented that it was always
> > > "implicitly handled" in ABI V1, which makes it consistent again.)
> > > 
> > > 
> > > When I expand your code above to a boolean table, I end up with the following
> > > decisions, depending on whether IOCTL and READ are handled or not, and whether
> > > they are explicitly permitted for the file through a rule:
> > > 
> > > 
> > > Mickaël's        IOCTL      IOCTL      IOCTL
> > > suggestion       handled,   handled,   unhandled
> > > 2023-09-04       file       file not
> > >                  permitted  permitted
> > > --------------------------------------------------
> > > READ handled,
> > > file permitted   allow      allow      allow
> > > 
> > > READ handled,
> > > f not permitted  deny       deny       allow
> > > 
> > > READ unhandled   allow      deny       allow
> > > 
> > > 
> > > In patch set V3, this is different: Because I think that cases (a) and (b) from
> > > above should always behave the same, the first and third column and row must be
> > > symmetric and have the same entries.  So, in patch set V3, it is sufficient if
> > > *one of* the two rights IOCTL and READ_FILE are present, in order to use the
> > > FIONREAD IOCTL:
> > > 
> > > 
> > > Günther's        IOCTL      IOCTL      IOCTL
> > > patch set V3     handled,   handled,   unhandled
> > > 2023-08-14       file       file not
> > >                  permitted  permitted
> > > --------------------------------------------------
> > > READ handled,
> > > file permitted   allow      allow      allow
> > > 
> > > READ handled,
> > > f not permitted  allow      deny       allow
> > > 
> > > READ unhandled   allow      allow      allow
> > 
> > A first difference is about (READ unhandled) AND (IOCTL handled +
> > file not permitted). It will not be possible to follow the same logic
> > with new Landlock access right (e.g. LANDLOCK_ACCESS_FS_READ_METADATA
> > that should also allow FS_IOC_FSGETXATTR), and I'd like to keep it
> > consistent.
> > 
> > A second difference is about (READ handled + f not permitted) AND
> > (IOCTL handled + file permitted). The reasoning was to avoid giving too
> > much power to LANDLOCK_ACCESS_FS_IOCTL and dowgrade it as new access
> > rights are implemented. This looks quite similar to the CAP_SYS_ADMIN
> > right that can basically do anything, and new capabilites are mainly a
> > subset of this one. My proposal was to incrementally downgrade the power
> > given by LANDLOCK_ACCESS_FS_IOCTL while still being compatible. On the
> > I was thinking that, if we make a requirement to have the "new correct"
> > access right, the application update might drop the IOCTL access right.
> > I now think this reasoning is flawed.
> > 
> > Indeed, this comparaison doesn't fit well because IOCTLs are not a
> > superset of all access rights, and because nothing can force developers
> > that already gave access to all IOCTLs for a file to not just add
> > another access right (instead of swapping them).
> > 
> > Instead, I think user space libraries should manage this kind of access
> > right swapping when possible and have a fallback mechanism relying on
> > the LANDLOCK_ACCESS_FS_IOCTL right. This would be valuable because they
> > may be updated before the (stable system) kernel, and this would be
> > easier for developers to manage.
> > 
> > In a nutshell, it is about giving control for an action (e.g. FIONREAD)
> > to either a unique access right or to a set of access rights. At first,
> > I would have preferred to have a unique access right to control an
> > action, because it is simpler (e.g. for audit/debug). On the other hand,
> > we need to handle access rights that allow the same action (e.g. file
> > read OR write for FIOQSIZE). I now think your approach (i.e. set of
> > access rights to control an action) could make more sense. Another good
> > point is to not downgrade the power of LANDLOCK_ACCESS_FS_IOCTL, which
> > could in fact be difficult to understand for users. Nested Landlock
> > domains should also be easier to manage with this logic.

Hmm, in fact I think my initial reasoning was better. I still agree with
my suggestion from 2023-09-04, and I think you're now proposing the
same. Handling access right in an exclusive way (i.e. a specific IOCTL
command is always handle by only one access rigth, but this one may
depend on the handle access rights) is indeed better because it will
force developers to not use the generic IOCTL access right instead of
e.g. the GFX one once they want to use it. In practice, it can reduce
the set of IOCTL commands allowed for LANDLOCK_ACCESS_FS_IOCTL-only file
hierarchies if users only allow the new LANDLOCK_ACCESS_FS_GFX to the
appropriate (e.g. /dev/dri) files.

To summarize, the reasoning is as follow: when READ is handled, the
related IOCTL commands (e.g. FIONREAD) are delegated to the READ access
right (both for the ruleset and the related rules), and the IOCTL access
right doesn't handle at all FIONREAD. If READ is not handled, then the
IOCTL access right handles FIONREAD as well. The same logic applies to
any current or future access rights, like LANDLOCK_ACCESS_FS_GFX.

> 
> After we discussed this difficult topic briefly off-list, let me try to
> summarize my takeaways and write it up here for reference.
> 
> I think the requirements for the logic of the IOCTL right are as follows:
> 
>  (1) In the future, if a new FOO access right is introduced, this right should
>      implicitly give access to FOO-related IOCTLs on the affected same files,
>      *without requiring the LANDLOCK_ACCESS_FS_IOCTL right*.
> 
>      Example: If in Landlock version 10, we introduce LANDLOCK_ACCESS_FS_GFX for
>      graphics-related functionality, this access right should potentially give
>      access to graphics-related ioctl commands.  I'll use the "GFX" example
>      below as a stand-in for a generic future access right which should give
>      access to a set of IOCTL commands.
> 
> and then the ones which are a bit more obvious:
> 
>  (2) When stacking additional Landlock layers, the thread's available access can
>      only be restricted further (it should not accidentally be able to do more
>      than before).
> 
>  (3) Landlock usages need to stay compatible across kernel versions.
>      The Landlock usages that are in use today need to do the same thing
>      in future kernel versions.
> 
> I had indeed overlooked requirement (1) and did not realize that my proposal was
> going to be at odds with that.
> 
> 
> 
> ## Some counterexamples for approaches that don't work
> 
> So: Counterexample for why my earlier proposal (OR-combination) does not work:
> 
>   In my proposal, a GFX-related IOCTL would be permitted when *either one* of
>   the ..._GFX or the ..._IOCTL rights are available for the file.  (The READ
>   right in the tables above should work the same as the GFX or FOO rights from
>   requirement (1), for consistency).
> 
>   So a user who today uses
> 
>     handled: LANDLOCK_ACCESS_FS_IOCTL
>     allowed: (nothing)
> 
>   will expect that GFX-related IOCTL operations are forbidden.  (We do not know
>   yet whether the "GFX" access right will ever exist, therefore it is covered by
>   LANDLOCK_ACCESS_FS_IOCTL.)
> 
>   Now we introduce the LANDLOCK_ACCESS_FS_GFX right, and suddenly, GFX-related
>   IOCTL commands are checked with a new logic: You *either* need to have the
>   LANDLOCK_ACCESS_FS_IOCTL right, *or* the LANDLOCK_ACCESS_FS_GFX right.  So
>   when the user again uses
> 
>     handled: LANDLOCK_ACCESS_FS_IOCTL
>     allowed: (nothing)
> 
>   the user would according to the new logic suddenly *have* the
>   LANDLOCK_ACCESS_FS_GFX right, and these IOCTL commands would be permitted.
> 
>   This is a change of how Landlock behaves compared to the earlier version,
>   and that is at odds with rule (3).
> 
> 
> The other obvious bitwise combination (AND) does not work either -- that one
> would violate requirement (1).
> 

Good summary, thanks!

> 
> ## A new proposal
> 
> We have discussed above that one option would be to start distinguishing between
> the case where a right is "not handled" and the case where the right is
> "handled, but allowed on the file".
> 
> This is not very nice, because it would be inconsistent with the semantics which
> we had before for all other rights.
> 
> After thinking a bit more about it, one way to look at it is that we are using
> the "handled" flags to control how the IOCTLs are grouped.  I agree that we have
> to control the IOCTL grouping, but I am not sure whether the "handled" flags are
> the right place to do that. -- We could just as well pass instructions about the
> IOCTL grouping out of band, and I think it might make that logic clearer:
> 
> To put forward something concrete, how about this:
> 
> * LANDLOCK_ACCESS_FS_IOCTL: This access right controls the invocation of IOCTL
>   commands, unless these commands are controlled by another access right.
> 
>   In every layer, each IOCTL command is only controlled through one access right.

Yes, I agree with that, see the reasoning about handling access right in
an exclusive way above.

> 
> * LANDLOCK_ACCESS_FS_READ_FILE: This access right controls opening files for
>   reading, and additionally the use of the FIONREAD ioctl command.

Yes

> 
> * We introduce a flag in struct landlock_ruleset_attr which controls whether the
>   graphics-related IOCTLs are controlled through the LANDLOCK_ACCESS_FS_GFX
>   access right, rather than through LANDLOCK_ACCESS_FS_IOCTL.
> 
>   (This could potentially also be put in the "flags" argument to
>   landlock_create_ruleset(), but it feels a bit more appropriate in the struct I
>   think, as it influences the interpretation of the logic.  But I'm open to
>   suggestions.)
> 

What would be the difference with creating a
LANDLOCK_ACCESS_FS_GFX_IOCTL access right?

The main issue with this approach is that it complexifies the usage of
Landlock, and users would need to tweak more knobs to configure a
ruleset.

What about keeping my proposal (mainly the IOCTL handling and delegation
logic) for the user interface, and translate that for kernel internals
to your proposal? See the below example.


> 
> Example: Without the flag, the IOCTL groups will be:
> 
>   These are always permitted:   FIOCLEX, FIONCLEX, FIONBIO, etc.
>   LANDLOCK_ACCESS_FS_READ_FILE: controls FIONREAD
>   LANDLOCK_ACCESS_FS_IOCTL:     controls all other IOCTL commands
> 
> but when users set the flag, the IOCTL groups will be:
> 
>   These are always permitted:   FIOCLEX, FIONCLEX, FIONBIO, etc.
>   LANDLOCK_ACCESS_FS_READ_FILE: controls FIONREAD
>   LANDLOCK_ACCESS_FS_GFX:       controls (list of gfx-related IOCTLs)
>   LANDLOCK_ACCESS_FS_IOCTL:     controls all other IOCTL commands
> 

Does this mean that handling LANDLOCK_ACCESS_FS_GFX without the flag
would not allow GFX-related IOCTL commands? Thit would be inconsistent
with the way LANDLOCK_ACCESS_FS_READ_FILE is handled.

Would this flag works with non-GFX access rights as well? Would there be
potentially one new flag per new access right?

> 
> Implementation-wise, I think it would actually look very similar to what would
> be needed for your proposal of having a new special meaning for "handled".  It
> would have the slight advantage that the new flag is actually only needed at the
> time when we introduce a new way of grouping the IOCTL commands, so we would
> only burden users with the additional complexity when it's actually required.

Indeed, and burdening users with more flags would increase the cost of
(properly) using Landlock.

I'm definitely in favor to make the Landlock interface as simple as
possible, taking into account the inherent compatibilty complexity, and
pushing most of this complexity handling to user space libraries, and if
it not possible, pushing the rest of the complexity into the kernel.

> 
> One implementation approach that I find reasonable to think about is to create
> "synthetic" access rights when rulesets are enabled.  That is, we introduce
> LANDLOCK_ACCESS_FS_SYNTHETIC_GFX_IOCTL (name TBD), but we keep this constant
> private to the kernel.
> 
> * *At ruleset enablement time*, we populate the bit for this access right either
>   from the LANDLOCK_ACCESS_FS_GFX or the LANDLOCK_ACCESS_FS_IOCTL bit from the
>   same access_mask_t, depending on the IOCTL grouping which the ruleset is
>   configured with.
> 
> * *In hook_file_open*, we then check for LANDLOCK_ACCESS_FS_SYNTHETIC_GFX_IOCTL
>   for the GFX-related IOCTL commands.
> 
> I'm in favor of using the synthetic access rights, because I find it clearer to
> understand that the effective access rights for a file from different layers are
> just combined with a bitwise AND, and will give the right results.  We could
> probably also make these path walk helpers aware of the special cases and only
> have the synthetic right in layer_masks_dom, but I'd prefer not to complicate
> these helpers even further.

I like this synthetic access right approach, but what worries me is that
it will potentially double the number of access rights. This is not an
issue for the handled access right (i.e. per ruleset layer), but we
should avoid that for allowed accesses (i.e. rules). Indeed, the
layer_masks[] size is proportional to the number of potential allowed
access rights, and increasing this array could increase the kernel stack
size (see is_access_to_paths_allowed).  It would not be an issue for now
though, we have a lot of room, it is just something to keep in mind.

Because of the way we need to compare file hierarchies (cf. FS_REFER),
it seems to be safer to only rely on (synthetic) access rights. So I
think it is the right approach.

> 
> 
> Sorry for the long mail, I hope that the examples clarify it a bit. :)
> 
> In summary, it seems conceptually cleaner to me to control every IOCTL command
> with only one access right, and let users control which one that should be with
> a separate flag, so that "handled" keeps its original semantics.  It would also
> have the upside that we can delay that implementation until the time where we
> actually introduce new IOCTL-aware access rights on top of the current patch st.

I don't see how we'll not get an inconsistent logic: a first one with
old/current access rights, and another one for future access rights
(e.g. GFX).

> 
> I'd be interested to hear your thoughts on it.

Thanks for this detailed explanation, that is useful.

I'm in favor of the synthetic access right, but I'd like to not add
optional flags to the user API.  What do you think about the kernel
doing the translation to the synthetic access rights?

To make the reasoning easier for the kernel implementation, following
the synthetic access rights idea, we can create these groups:

* IOCTL_CMD_G1: FIOQSIZE
* IOCTL_CMD_G2: FS_IOCT_FIEMAP | FIBMAP | FIGETBSZ
* IOCTL_CMD_G3: FIONREAD | FIDEDUPRANGE
* IOCTL_CMD_G4: FICLONE | FICLONERANGE | FS_IOC_RESVSP | FS_IOC_RESVSP64
  | FS_IOC_UNRESVSP | FS_IOC_UNRESVSP64 | FS_IOC_ZERO_RANGE

Existing (and future) access rights would automatically get the related
IOCTL fine-grained rights *if* LANDLOCK_ACCESS_FS_IOCTL is handled:
* LANDLOCK_ACCESS_FS_WRITE_FILE: IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G4
* LANDLOCK_ACCESS_FS_READ_FILE: IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G3
* LANDLOCK_ACCESS_FS_READ_DIR: IOCTL_CMD_G1

This works with the ruleset handled access rights and the related rules
allowed accesses by simply ORing the access rights.

We should also keep in mind that some IOCTL commands may only be related
to some specific file types or filesystems, either now or in the future
(see the GFX example).

