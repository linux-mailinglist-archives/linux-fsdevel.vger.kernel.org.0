Return-Path: <linux-fsdevel+bounces-1212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11EC7D779A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 00:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA06281C85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 22:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA28F37161;
	Wed, 25 Oct 2023 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHnlA/Nr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B732522C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 22:07:39 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D72113A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 15:07:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cb79eb417so191573276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698271656; x=1698876456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZjfm6M3ZyL4GTxC6afhaxfOainDyB0qJf3X7vDUSrY=;
        b=KHnlA/Nr2a8xeQ/T/Ax0TvkX2lzwuAlNPAyVJ2sk0b3UTQP4ijiLguRXSNnOtECyS1
         ORWMB4LnyLScJJWNjWdDDhBgI+V+mpH0mf6MgqrBZqxVsoZN8Tm/XdvKtbbGlmNCQlhU
         vVqlcA2mzclTr1pa3kP924JbgQz+XugN0chpery1wsVWZjHr4oxh6KsPgbmMdTVnjcNO
         cB1tUCX3uJA3OwETZOh9+jEedTeZEweuSQAes+r8gEKcSqNLd+4+YOpL2s/sSsQrqPz1
         qxTfwKMUIIQFbWiuNgG02FpLDRr9l+DL8yK+ZJPc1kj4SkWp0oYrI+0GrmCZWsWub4gF
         mM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698271656; x=1698876456;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PZjfm6M3ZyL4GTxC6afhaxfOainDyB0qJf3X7vDUSrY=;
        b=h4taG4Z2MKuVPp8UO0GfuqHWxPwRA/apaiOzA8zMUSqEdYOdS9tQpbloiQYXPba3XV
         zHoR+uUiSzdbuz1ux82D6AuuuB4MD3Ve6i9fgKqPOOP/fd7wJH5qQf1Q+bLR3689/Ozd
         MLRf8hFgvl6227O+t4iaTvHsK/alT73sUWNEIzWcFYfJUAJPKFyTk9yX0Flpo/vwQntv
         8pvCMNbqaBG7wmfY8LcAT1PIHM7DTRwx20L1A75J0FgKBggDwdbSB1gIP3hiUXjd6c7W
         a03HeN4Mvp3b6lV3N46MkNMC9ymKyFMTRTmtP5SZOVI4e0ZKlsxJKhwjkMDNn0kUc8y3
         U3Gg==
X-Gm-Message-State: AOJu0Yyf1ZOZ9J4Q6N61o2BOefXwx7JRD3c08aITh3rMLqIzxpiaGXCr
	RJ1yVTUTDAdikge6CoeWRbVcjJRvbzU=
X-Google-Smtp-Source: AGHT+IFAJkR9hmEUyRLLCIYpQZ04800OS1y5+OMGkFch3gaCiBDbRs3/GtVeFcygY7tLBXcYNTHnm7Afdgg=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:c5af:3ae7:e526:c7a2])
 (user=gnoack job=sendgmr) by 2002:a25:42c9:0:b0:d9a:bce6:acf3 with SMTP id
 p192-20020a2542c9000000b00d9abce6acf3mr313798yba.0.1698271656378; Wed, 25 Oct
 2023 15:07:36 -0700 (PDT)
Date: Thu, 26 Oct 2023 00:07:28 +0200
In-Reply-To: <20231020.moefooYeV9ei@digikod.net>
Message-Id: <ZTmRoESR5eXEA_ky@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230818.iechoCh0eew0@digikod.net> <ZOjCz5j4+tgptF53@google.com>
 <20230825.Zoo4ohn1aivo@digikod.net> <20230826.ohtooph0Ahmu@digikod.net>
 <ZPMiVaL3kVaTnivh@google.com> <20230904.aiWae8eineo4@digikod.net>
 <ZP7lxmXklksadvz+@google.com> <20230911.jie6Rai8ughe@digikod.net>
 <ZTGpIBve2LVlbt6p@google.com> <20231020.moefooYeV9ei@digikod.net>
Subject: Re: [PATCH v3 0/5] Landlock: IOCTL support
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 04:57:39PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Oct 20, 2023 at 12:09:36AM +0200, G=C3=BCnther Noack wrote:
> > * We introduce a flag in struct landlock_ruleset_attr which controls wh=
ether the
> >   graphics-related IOCTLs are controlled through the LANDLOCK_ACCESS_FS=
_GFX
> >   access right, rather than through LANDLOCK_ACCESS_FS_IOCTL.
> >=20
> >   (This could potentially also be put in the "flags" argument to
> >   landlock_create_ruleset(), but it feels a bit more appropriate in the=
 struct I
> >   think, as it influences the interpretation of the logic.  But I'm ope=
n to
> >   suggestions.)
> >=20
>=20
> What would be the difference with creating a
> LANDLOCK_ACCESS_FS_GFX_IOCTL access right?
>=20
> The main issue with this approach is that it complexifies the usage of
> Landlock, and users would need to tweak more knobs to configure a
> ruleset.
>=20
> What about keeping my proposal (mainly the IOCTL handling and delegation
> logic) for the user interface, and translate that for kernel internals
> to your proposal? See the below example.

Yes!

I have pondered this for about a day now, and tried to break the example in
various ways, but I believe you are right with this -- I think we can actua=
lly
use the "handled" flags to control the IOCTL grouping, and then translate a=
ll of
it quickly to synthetic access rights for the internal logic.  When doing t=
he
translation only once during ruleset enablement time, we can keep using the
existing logic for the synthetic rights and it'll obviously work correctly =
when
layers are stacked.  (I paraphrase it in more detail at the end, to make su=
re we
are on the same page. -- But I think we are.)


> > Example: Without the flag, the IOCTL groups will be:
> >=20
> >   These are always permitted:   FIOCLEX, FIONCLEX, FIONBIO, etc.
> >   LANDLOCK_ACCESS_FS_READ_FILE: controls FIONREAD
> >   LANDLOCK_ACCESS_FS_IOCTL:     controls all other IOCTL commands
> >=20
> > but when users set the flag, the IOCTL groups will be:
> >=20
> >   These are always permitted:   FIOCLEX, FIONCLEX, FIONBIO, etc.
> >   LANDLOCK_ACCESS_FS_READ_FILE: controls FIONREAD
> >   LANDLOCK_ACCESS_FS_GFX:       controls (list of gfx-related IOCTLs)
> >   LANDLOCK_ACCESS_FS_IOCTL:     controls all other IOCTL commands
> >=20
>=20
> Does this mean that handling LANDLOCK_ACCESS_FS_GFX without the flag
> would not allow GFX-related IOCTL commands? Thit would be inconsistent
> with the way LANDLOCK_ACCESS_FS_READ_FILE is handled.

Yes, that is how I had imagined that.  It's true that it's slightly inconsi=
stent
in usage, and you are right that it creates some new concepts in the API wh=
ich
are maybe avoidable.  Let's try it the way you proposed and control it with=
 the
"handled" flags.


> Would this flag works with non-GFX access rights as well? Would there be
> potentially one new flag per new access right?
>=20
> >=20
> > Implementation-wise, I think it would actually look very similar to wha=
t would
> > be needed for your proposal of having a new special meaning for "handle=
d".  It
> > would have the slight advantage that the new flag is actually only need=
ed at the
> > time when we introduce a new way of grouping the IOCTL commands, so we =
would
> > only burden users with the additional complexity when it's actually req=
uired.
>=20
> Indeed, and burdening users with more flags would increase the cost of
> (properly) using Landlock.
>=20
> I'm definitely in favor to make the Landlock interface as simple as
> possible, taking into account the inherent compatibilty complexity, and
> pushing most of this complexity handling to user space libraries, and if
> it not possible, pushing the rest of the complexity into the kernel.

Ack, sounds good.


> > One implementation approach that I find reasonable to think about is to=
 create
> > "synthetic" access rights when rulesets are enabled.  That is, we intro=
duce
> > LANDLOCK_ACCESS_FS_SYNTHETIC_GFX_IOCTL (name TBD), but we keep this con=
stant
> > private to the kernel.
> >=20
> > * *At ruleset enablement time*, we populate the bit for this access rig=
ht either
> >   from the LANDLOCK_ACCESS_FS_GFX or the LANDLOCK_ACCESS_FS_IOCTL bit f=
rom the
> >   same access_mask_t, depending on the IOCTL grouping which the ruleset=
 is
> >   configured with.
> >=20
> > * *In hook_file_open*, we then check for LANDLOCK_ACCESS_FS_SYNTHETIC_G=
FX_IOCTL
> >   for the GFX-related IOCTL commands.
> >=20
> > I'm in favor of using the synthetic access rights, because I find it cl=
earer to
> > understand that the effective access rights for a file from different l=
ayers are
> > just combined with a bitwise AND, and will give the right results.  We =
could
> > probably also make these path walk helpers aware of the special cases a=
nd only
> > have the synthetic right in layer_masks_dom, but I'd prefer not to comp=
licate
> > these helpers even further.
>=20
> I like this synthetic access right approach, but what worries me is that
> it will potentially double the number of access rights. This is not an
> issue for the handled access right (i.e. per ruleset layer), but we
> should avoid that for allowed accesses (i.e. rules). Indeed, the
> layer_masks[] size is proportional to the number of potential allowed
> access rights, and increasing this array could increase the kernel stack
> size (see is_access_to_paths_allowed).  It would not be an issue for now
> though, we have a lot of room, it is just something to keep in mind.

Yes, acknowledged.

FWIW, LANDLOCK_ACCESS_FS_IOCTL is already 1 << 15, so adding the synthetic
rights will indeed make access_mask_t go up to 32 bit.  (This was already d=
one
in the patch for the metadata access, but that one was not merged yet.)  I =
also
feel that the stack usage is the case where this is most likely to be an is=
sue.


> Because of the way we need to compare file hierarchies (cf. FS_REFER),
> it seems to be safer to only rely on (synthetic) access rights. So I
> think it is the right approach.
>=20
> >=20
> >=20
> > Sorry for the long mail, I hope that the examples clarify it a bit. :)
> >=20
> > In summary, it seems conceptually cleaner to me to control every IOCTL =
command
> > with only one access right, and let users control which one that should=
 be with
> > a separate flag, so that "handled" keeps its original semantics.  It wo=
uld also
> > have the upside that we can delay that implementation until the time wh=
ere we
> > actually introduce new IOCTL-aware access rights on top of the current =
patch st.
>=20
> I don't see how we'll not get an inconsistent logic: a first one with
> old/current access rights, and another one for future access rights
> (e.g. GFX).
>=20
> >=20
> > I'd be interested to hear your thoughts on it.
>=20
> Thanks for this detailed explanation, that is useful.
>=20
> I'm in favor of the synthetic access right, but I'd like to not add
> optional flags to the user API.  What do you think about the kernel
> doing the translation to the synthetic access rights?
>=20
> To make the reasoning easier for the kernel implementation, following
> the synthetic access rights idea, we can create these groups:
>=20
> * IOCTL_CMD_G1: FIOQSIZE
> * IOCTL_CMD_G2: FS_IOCT_FIEMAP | FIBMAP | FIGETBSZ
> * IOCTL_CMD_G3: FIONREAD | FIDEDUPRANGE
> * IOCTL_CMD_G4: FICLONE | FICLONERANGE | FS_IOC_RESVSP | FS_IOC_RESVSP64
>   | FS_IOC_UNRESVSP | FS_IOC_UNRESVSP64 | FS_IOC_ZERO_RANGE
>=20
> Existing (and future) access rights would automatically get the related
> IOCTL fine-grained rights *if* LANDLOCK_ACCESS_FS_IOCTL is handled:
> * LANDLOCK_ACCESS_FS_WRITE_FILE: IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_=
G4
> * LANDLOCK_ACCESS_FS_READ_FILE: IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G=
3
> * LANDLOCK_ACCESS_FS_READ_DIR: IOCTL_CMD_G1
>=20
> This works with the ruleset handled access rights and the related rules
> allowed accesses by simply ORing the access rights.
>=20
> We should also keep in mind that some IOCTL commands may only be related
> to some specific file types or filesystems, either now or in the future
> (see the GFX example).

I am coming around to your approach with using "handled" bits to determine =
the
grouping.  Let me paraphrase some key concepts to make sure we are on the s=
ame
page:

* The IOCTL groups are modeled as synthetic access rights, IOCTL_CMD_G1...G=
4 in
  your example.  Each IOCTL command maps to exactly one of these groups.

  Because the presence of these groups is an implementation detail in the
  kernel, we can adapt it later and make it more fine-grained if needed.

* We use "handled" bits like LANDLOCK_ACCESS_FS_WRITE_FILE to determine the
  synthetic access rights.

  We can populate the synthetic IOCTL_CMD_G1...G4 groups depending on how t=
he
  "handled" bits are populated.

  In my understanding, the logic could roughly be this:

  static access_mask_t expand_ioctl(access_mask_t handled, access_mask_t am=
,
                                    access_mask_t src, access_mask_t dst)
  {
    if (handled & src) {
      /* If "src" access right is handled, populate "dst" from "src". */
      return am | ((am & src) ? dst : 0);
    } else {
      /* Otherwise, populate "dst" flag from "ioctl" flag. */
      return am | ((am & LANDLOCK_ACCESS_FS_IOCTL) ? dst : 0);
    }
  }

  static access_mask_t expand_all_ioctl(access_mask_t handled, access_mask_=
t am)
  {
    am =3D expand_ioctl(handled, am,
                      LANDLOCK_ACCESS_FS_WRITE_FILE,
		      IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G4);
    am =3D expand_ioctl(handled, am,
                      LANDLOCK_ACCESS_FS_READ_FILE,
		      IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G3);
    am =3D expand_ioctl(handled, am,
                      LANDLOCK_ACCESS_FS_READ_DIR,
		      IOCTL_CMD_G1);
    return am;
  }

  and then during the installing of a ruleset, we'd call
  expand_all_ioctl(handled, access) for each specified file access, and
  expand_all_ioctl(handled, handled) for the handled access rights,
  to populate the synthetic IOCTL_CMD_G* access rights.

  In expand_ioctl() above, if "src" is *not* handled, we populate the assoc=
iated
  synthetic access rights "dst" from the value in LANDLOCK_ACCESS_FS_IOCTL.
  With that, when enabling a ruleset, we map everything to the most specifi=
c
  grouping which is available, and later on, the LSM hook can just ignore t=
hat
  different grouping configurations are possible.

* In the ioctl LSM hook, each possible cmd is controlled by exactly one acc=
ess
  right.  The ones that you have listed are all controlled by one of the
  IOCTL_CMD_G1...G4 access rights, and all others by LANDLOCK_ACCESS_FS_IOC=
TL.

I was previously concerned that the usage of "handled" to control the group=
ing
would be at odds with the layer composition logic, but with this logic, we =
are
now mapping these to the synthetic access rights at enablement time, and al=
l the
ruleset composition logic can stay working as it is (at least until we run =
out
of bits in access_mask_t).

I've also been concerned before that we would break compatibility across
versions, but this also seems less likely now that we've discussed this in =
all
this detail %-)

I suspect that the normal upgrade path from one Landlock version to the nex=
t
will be for most users to always use the full set of "handled" flags that t=
heir
library knows about.  When we add the hypothetical "GFX" flag to that set, =
this
will change the IOCTL grouping a bit, so that files which were previously l=
isted
as having the LANDLOCK_ACCESS_FS_IOCTL right, might now not be enabled for =
GFX
ioctls.  But that is (A) probably correct anyway in most cases, and (B) use=
rs
upgrading from one Landlock ABI version to the next have a chance to read t=
heir
library changelog as part of that upgrade.

I think this is a reasonable approach.  If you agree, I'm willing to give i=
t a
shot and adapt the patch set to implement that.

=E2=80=94G=C3=BCnther

