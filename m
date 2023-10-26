Return-Path: <linux-fsdevel+bounces-1249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AAB7D8550
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 16:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173B9282079
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DFA2EB13;
	Thu, 26 Oct 2023 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WOwVvIBc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C01D52B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 14:55:43 +0000 (UTC)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [IPv6:2001:1600:4:17::190c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4874E18F
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 07:55:38 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SGTPK6J4kzMqHLt;
	Thu, 26 Oct 2023 14:55:33 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SGTPJ4MwZz3Y;
	Thu, 26 Oct 2023 16:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1698332133;
	bh=v1DNgXhNBJG7u2KQtoCD7nDJvhsY3gl0Iu2dRiowEEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WOwVvIBc1sP4PAiTkfhp6wHmFeO9C4hp1aF6kdRmVNhfCAkCCFYnSRpVKra9dTbAM
	 SRaVBIN1ZzzlTgPB2XdflL787LcxkuMFkLuGgD3F51F/HQkTbMMf/UAhdvNEofOXN3
	 Lq0aAT3PQp0NH2oXqTah3mUzW222E4GDtXlrvWhE=
Date: Thu, 26 Oct 2023 16:55:30 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 0/5] Landlock: IOCTL support
Message-ID: <20231026.oiPeosh1yieg@digikod.net>
References: <ZOjCz5j4+tgptF53@google.com>
 <20230825.Zoo4ohn1aivo@digikod.net>
 <20230826.ohtooph0Ahmu@digikod.net>
 <ZPMiVaL3kVaTnivh@google.com>
 <20230904.aiWae8eineo4@digikod.net>
 <ZP7lxmXklksadvz+@google.com>
 <20230911.jie6Rai8ughe@digikod.net>
 <ZTGpIBve2LVlbt6p@google.com>
 <20231020.moefooYeV9ei@digikod.net>
 <ZTmRoESR5eXEA_ky@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTmRoESR5eXEA_ky@google.com>
X-Infomaniak-Routing: alpha

On Thu, Oct 26, 2023 at 12:07:28AM +0200, Günther Noack wrote:
> On Fri, Oct 20, 2023 at 04:57:39PM +0200, Mickaël Salaün wrote:
> > On Fri, Oct 20, 2023 at 12:09:36AM +0200, Günther Noack wrote:
> > > * We introduce a flag in struct landlock_ruleset_attr which controls whether the
> > >   graphics-related IOCTLs are controlled through the LANDLOCK_ACCESS_FS_GFX
> > >   access right, rather than through LANDLOCK_ACCESS_FS_IOCTL.
> > > 
> > >   (This could potentially also be put in the "flags" argument to
> > >   landlock_create_ruleset(), but it feels a bit more appropriate in the struct I
> > >   think, as it influences the interpretation of the logic.  But I'm open to
> > >   suggestions.)
> > > 
> > 
> > What would be the difference with creating a
> > LANDLOCK_ACCESS_FS_GFX_IOCTL access right?
> > 
> > The main issue with this approach is that it complexifies the usage of
> > Landlock, and users would need to tweak more knobs to configure a
> > ruleset.
> > 
> > What about keeping my proposal (mainly the IOCTL handling and delegation
> > logic) for the user interface, and translate that for kernel internals
> > to your proposal? See the below example.
> 
> Yes!
> 
> I have pondered this for about a day now, and tried to break the example in
> various ways, but I believe you are right with this -- I think we can actually
> use the "handled" flags to control the IOCTL grouping, and then translate all of
> it quickly to synthetic access rights for the internal logic.  When doing the
> translation only once during ruleset enablement time, we can keep using the
> existing logic for the synthetic rights and it'll obviously work correctly when
> layers are stacked.  (I paraphrase it in more detail at the end, to make sure we
> are on the same page. -- But I think we are.)
> 
> 
> > > Example: Without the flag, the IOCTL groups will be:
> > > 
> > >   These are always permitted:   FIOCLEX, FIONCLEX, FIONBIO, etc.
> > >   LANDLOCK_ACCESS_FS_READ_FILE: controls FIONREAD
> > >   LANDLOCK_ACCESS_FS_IOCTL:     controls all other IOCTL commands
> > > 
> > > but when users set the flag, the IOCTL groups will be:
> > > 
> > >   These are always permitted:   FIOCLEX, FIONCLEX, FIONBIO, etc.
> > >   LANDLOCK_ACCESS_FS_READ_FILE: controls FIONREAD
> > >   LANDLOCK_ACCESS_FS_GFX:       controls (list of gfx-related IOCTLs)
> > >   LANDLOCK_ACCESS_FS_IOCTL:     controls all other IOCTL commands
> > > 
> > 
> > Does this mean that handling LANDLOCK_ACCESS_FS_GFX without the flag
> > would not allow GFX-related IOCTL commands? Thit would be inconsistent
> > with the way LANDLOCK_ACCESS_FS_READ_FILE is handled.
> 
> Yes, that is how I had imagined that.  It's true that it's slightly inconsistent
> in usage, and you are right that it creates some new concepts in the API which
> are maybe avoidable.  Let's try it the way you proposed and control it with the
> "handled" flags.
> 
> 
> > Would this flag works with non-GFX access rights as well? Would there be
> > potentially one new flag per new access right?
> > 
> > > 
> > > Implementation-wise, I think it would actually look very similar to what would
> > > be needed for your proposal of having a new special meaning for "handled".  It
> > > would have the slight advantage that the new flag is actually only needed at the
> > > time when we introduce a new way of grouping the IOCTL commands, so we would
> > > only burden users with the additional complexity when it's actually required.
> > 
> > Indeed, and burdening users with more flags would increase the cost of
> > (properly) using Landlock.
> > 
> > I'm definitely in favor to make the Landlock interface as simple as
> > possible, taking into account the inherent compatibilty complexity, and
> > pushing most of this complexity handling to user space libraries, and if
> > it not possible, pushing the rest of the complexity into the kernel.
> 
> Ack, sounds good.
> 
> 
> > > One implementation approach that I find reasonable to think about is to create
> > > "synthetic" access rights when rulesets are enabled.  That is, we introduce
> > > LANDLOCK_ACCESS_FS_SYNTHETIC_GFX_IOCTL (name TBD), but we keep this constant
> > > private to the kernel.
> > > 
> > > * *At ruleset enablement time*, we populate the bit for this access right either
> > >   from the LANDLOCK_ACCESS_FS_GFX or the LANDLOCK_ACCESS_FS_IOCTL bit from the
> > >   same access_mask_t, depending on the IOCTL grouping which the ruleset is
> > >   configured with.
> > > 
> > > * *In hook_file_open*, we then check for LANDLOCK_ACCESS_FS_SYNTHETIC_GFX_IOCTL
> > >   for the GFX-related IOCTL commands.
> > > 
> > > I'm in favor of using the synthetic access rights, because I find it clearer to
> > > understand that the effective access rights for a file from different layers are
> > > just combined with a bitwise AND, and will give the right results.  We could
> > > probably also make these path walk helpers aware of the special cases and only
> > > have the synthetic right in layer_masks_dom, but I'd prefer not to complicate
> > > these helpers even further.
> > 
> > I like this synthetic access right approach, but what worries me is that
> > it will potentially double the number of access rights. This is not an
> > issue for the handled access right (i.e. per ruleset layer), but we
> > should avoid that for allowed accesses (i.e. rules). Indeed, the
> > layer_masks[] size is proportional to the number of potential allowed
> > access rights, and increasing this array could increase the kernel stack
> > size (see is_access_to_paths_allowed).  It would not be an issue for now
> > though, we have a lot of room, it is just something to keep in mind.
> 
> Yes, acknowledged.
> 
> FWIW, LANDLOCK_ACCESS_FS_IOCTL is already 1 << 15, so adding the synthetic
> rights will indeed make access_mask_t go up to 32 bit.  (This was already done
> in the patch for the metadata access, but that one was not merged yet.)  I also
> feel that the stack usage is the case where this is most likely to be an issue.
> 
> 
> > Because of the way we need to compare file hierarchies (cf. FS_REFER),
> > it seems to be safer to only rely on (synthetic) access rights. So I
> > think it is the right approach.
> > 
> > > 
> > > 
> > > Sorry for the long mail, I hope that the examples clarify it a bit. :)
> > > 
> > > In summary, it seems conceptually cleaner to me to control every IOCTL command
> > > with only one access right, and let users control which one that should be with
> > > a separate flag, so that "handled" keeps its original semantics.  It would also
> > > have the upside that we can delay that implementation until the time where we
> > > actually introduce new IOCTL-aware access rights on top of the current patch st.
> > 
> > I don't see how we'll not get an inconsistent logic: a first one with
> > old/current access rights, and another one for future access rights
> > (e.g. GFX).
> > 
> > > 
> > > I'd be interested to hear your thoughts on it.
> > 
> > Thanks for this detailed explanation, that is useful.
> > 
> > I'm in favor of the synthetic access right, but I'd like to not add
> > optional flags to the user API.  What do you think about the kernel
> > doing the translation to the synthetic access rights?
> > 
> > To make the reasoning easier for the kernel implementation, following
> > the synthetic access rights idea, we can create these groups:
> > 
> > * IOCTL_CMD_G1: FIOQSIZE
> > * IOCTL_CMD_G2: FS_IOCT_FIEMAP | FIBMAP | FIGETBSZ
> > * IOCTL_CMD_G3: FIONREAD | FIDEDUPRANGE
> > * IOCTL_CMD_G4: FICLONE | FICLONERANGE | FS_IOC_RESVSP | FS_IOC_RESVSP64
> >   | FS_IOC_UNRESVSP | FS_IOC_UNRESVSP64 | FS_IOC_ZERO_RANGE
> > 
> > Existing (and future) access rights would automatically get the related
> > IOCTL fine-grained rights *if* LANDLOCK_ACCESS_FS_IOCTL is handled:
> > * LANDLOCK_ACCESS_FS_WRITE_FILE: IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G4
> > * LANDLOCK_ACCESS_FS_READ_FILE: IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G3
> > * LANDLOCK_ACCESS_FS_READ_DIR: IOCTL_CMD_G1
> > 
> > This works with the ruleset handled access rights and the related rules
> > allowed accesses by simply ORing the access rights.
> > 
> > We should also keep in mind that some IOCTL commands may only be related
> > to some specific file types or filesystems, either now or in the future
> > (see the GFX example).
> 
> I am coming around to your approach with using "handled" bits to determine the
> grouping.  Let me paraphrase some key concepts to make sure we are on the same
> page:
> 
> * The IOCTL groups are modeled as synthetic access rights, IOCTL_CMD_G1...G4 in
>   your example.  Each IOCTL command maps to exactly one of these groups.
> 
>   Because the presence of these groups is an implementation detail in the
>   kernel, we can adapt it later and make it more fine-grained if needed.
> 
> * We use "handled" bits like LANDLOCK_ACCESS_FS_WRITE_FILE to determine the
>   synthetic access rights.
> 
>   We can populate the synthetic IOCTL_CMD_G1...G4 groups depending on how the
>   "handled" bits are populated.
> 
>   In my understanding, the logic could roughly be this:
> 
>   static access_mask_t expand_ioctl(access_mask_t handled, access_mask_t am,
>                                     access_mask_t src, access_mask_t dst)
>   {

The third column "IOCTL unhandled" is not reflected here. What about
this patch?

if (!(handled & LANDLOCK_ACCESS_FS_IOCTL)) {
  return am | dst;
}

>     if (handled & src) {
>       /* If "src" access right is handled, populate "dst" from "src". */
>       return am | ((am & src) ? dst : 0);
>     } else {
>       /* Otherwise, populate "dst" flag from "ioctl" flag. */
>       return am | ((am & LANDLOCK_ACCESS_FS_IOCTL) ? dst : 0);
>     }
>   }
> 
>   static access_mask_t expand_all_ioctl(access_mask_t handled, access_mask_t am)
>   {

Instead of reapeating "am | " in expand_ioctl() and assigning am several
times in expand_all_ioctl(), you could simply do something like that:

return am |
	expand_ioctl(handled, am, ...) |
	expand_ioctl(handled, am, ...) |
	expand_ioctl(handled, am, ...);

>     am = expand_ioctl(handled, am,
>                       LANDLOCK_ACCESS_FS_WRITE_FILE,
> 		      IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G4);
>     am = expand_ioctl(handled, am,
>                       LANDLOCK_ACCESS_FS_READ_FILE,
> 		      IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G3);
>     am = expand_ioctl(handled, am,
>                       LANDLOCK_ACCESS_FS_READ_DIR,
> 		      IOCTL_CMD_G1);
>     return am;
>   }
> 
>   and then during the installing of a ruleset, we'd call
>   expand_all_ioctl(handled, access) for each specified file access, and
>   expand_all_ioctl(handled, handled) for the handled access rights,
>   to populate the synthetic IOCTL_CMD_G* access rights.

We can do these transformations directly in the new
landlock_add_fs_access_mask() and landlock_append_fs_rule().

Please base the next series on
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
This branch might be rebased from time to time, but only minor changes
will get there.

> 
>   In expand_ioctl() above, if "src" is *not* handled, we populate the associated
>   synthetic access rights "dst" from the value in LANDLOCK_ACCESS_FS_IOCTL.
>   With that, when enabling a ruleset, we map everything to the most specific
>   grouping which is available, and later on, the LSM hook can just ignore that
>   different grouping configurations are possible.
> 
> * In the ioctl LSM hook, each possible cmd is controlled by exactly one access
>   right.  The ones that you have listed are all controlled by one of the
>   IOCTL_CMD_G1...G4 access rights, and all others by LANDLOCK_ACCESS_FS_IOCTL.
> 
> I was previously concerned that the usage of "handled" to control the grouping
> would be at odds with the layer composition logic, but with this logic, we are
> now mapping these to the synthetic access rights at enablement time, and all the
> ruleset composition logic can stay working as it is (at least until we run out
> of bits in access_mask_t).
> 
> I've also been concerned before that we would break compatibility across
> versions, but this also seems less likely now that we've discussed this in all
> this detail %-)
> 
> I suspect that the normal upgrade path from one Landlock version to the next
> will be for most users to always use the full set of "handled" flags that their
> library knows about.  When we add the hypothetical "GFX" flag to that set, this
> will change the IOCTL grouping a bit, so that files which were previously listed
> as having the LANDLOCK_ACCESS_FS_IOCTL right, might now not be enabled for GFX
> ioctls.  But that is (A) probably correct anyway in most cases, and (B) users
> upgrading from one Landlock ABI version to the next have a chance to read their
> library changelog as part of that upgrade.

Yes, explicitly adding a new flag to a function argument should indeed
lead to read the related documentation, and hopefully test the code in
an up-to-date sandbox environment!

This strategy should help avoid long-term use of the generic
LANDLOCK_ACCESS_FS_IOCTL but converge to new dedicated access rights
instead.

> 
> I think this is a reasonable approach.  If you agree, I'm willing to give it a
> shot and adapt the patch set to implement that.

This looks great!

> 
> —Günther

