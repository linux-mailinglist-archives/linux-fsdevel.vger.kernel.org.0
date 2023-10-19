Return-Path: <linux-fsdevel+bounces-797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D37C7D04AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 00:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE198282339
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 22:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468C242924;
	Thu, 19 Oct 2023 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gp+BSd18"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A5D42909
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 22:09:43 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2246111D
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 15:09:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a60a104b6so1153942276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 15:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697753379; x=1698358179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiLWArGHWMUsvkBpolvZmmj1W0Jn76oWpRO64UKbHHc=;
        b=Gp+BSd1852cBnSucbLkFCWHz1tP3tDZoWzpydezgkF4hHAzc7/xp6g1fr7Zelgsild
         1w1t9szErwKrxhZ3nhs/gWRN8Xczw66HC6/WNr8hFpg4z4HpT9A00ykxQBSjqV5pjutO
         Sd86Lulg2fPfmJ3XYbdFim3mvhm8o1lLQPETLcOsB2mx2c+bcpibt3nf+TnSYF/zbmOS
         pgw0eDOQQy+a53zlCSBAne9Wi9bhpXwXMkSTmz2Ax+FI+7xhijM+mDNGFDLqiATPT53R
         1Xnl+FCKl1UIi3eZLTAHyrNKl4xWJiibkehiDDBRS2g1OzmrAseESHtycOzcZ7kmhjMQ
         hN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697753379; x=1698358179;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GiLWArGHWMUsvkBpolvZmmj1W0Jn76oWpRO64UKbHHc=;
        b=lYIF4EvW7RpMFU/Q49jBTVvyttWaxkTP2zHzCWmskAV6b0JsxWo7RJWIP8tGrMBb05
         OeDtmVlBB5S9+8h4TBg3L7OknhsiyFtFGnIO+Xg/0mY9xm3ZwGB/+k88hxtTkg9cFgtL
         brnAPAUMKD3BT1BWu1QhkHkZjkIhRCwOeb1enaL9zcKKZQa1DP1BoQWd7OiNdnNy17cp
         wK6GACBUbgyyxhR+zL0d7QbmoIRliVUi0zI8B1ieIbT9Fn9dPNf3J+IeHat1GjhwbxPs
         4RFPSqTLOMd5ik9FnPaE/PdsSvKMplRoyBdDQVjo3cOgBcNQ02qKHw4P/iPsis0hVby4
         VIdQ==
X-Gm-Message-State: AOJu0YxPdUFCSFIZbagR2FIQ3he33dvGUnlz4JqPRleZSBIxAdGHcUxJ
	asp7Fe/13H/gtIEs0MFxAZh5Sw3cQAs=
X-Google-Smtp-Source: AGHT+IGZMoKV3ME+TROh3HoDxkFqLdAANKMlzTlGS8+CL1GI4HqqaS57HUVnbaJz5KN6k+e6iYU5RlIiSJE=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2401:dce2:6f6a:a01d])
 (user=gnoack job=sendgmr) by 2002:a25:d244:0:b0:d9a:4cc1:b59a with SMTP id
 j65-20020a25d244000000b00d9a4cc1b59amr723ybg.1.1697753379352; Thu, 19 Oct
 2023 15:09:39 -0700 (PDT)
Date: Fri, 20 Oct 2023 00:09:36 +0200
In-Reply-To: <20230911.jie6Rai8ughe@digikod.net>
Message-Id: <ZTGpIBve2LVlbt6p@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com> <20230818.iechoCh0eew0@digikod.net>
 <ZOjCz5j4+tgptF53@google.com> <20230825.Zoo4ohn1aivo@digikod.net>
 <20230826.ohtooph0Ahmu@digikod.net> <ZPMiVaL3kVaTnivh@google.com>
 <20230904.aiWae8eineo4@digikod.net> <ZP7lxmXklksadvz+@google.com> <20230911.jie6Rai8ughe@digikod.net>
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

Hello!

On Mon, Sep 11, 2023 at 05:25:31PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Mon, Sep 11, 2023 at 12:02:46PM +0200, G=C3=BCnther Noack wrote:
> > Thank you for making the algorithm that explicit -- that helps to trace=
 down the
> > differences.  I can follow the logic now, but I still don't understand =
what your
> > underlying rationale for that is?
> >=20
> > I believe that fundamentally, a core difference is:
> >=20
> > For an access right R and a file F, for these two cases:
> >=20
> >  (a) the access right R is unhandled  (nothing gets restricted)
> >  (b) the access right R is handled, but R is granted for F in a rule.
> >=20
> > I believe that accesses in case (a) and (b) to the file F should have t=
he same
> > results.
> >=20
> > This is at least how the existing Landlock implementation works, as far=
 as I can
> > tell.
> >=20
> > ("Refer" is an exceptional case, but we have documented that it was alw=
ays
> > "implicitly handled" in ABI V1, which makes it consistent again.)
> >=20
> >=20
> > When I expand your code above to a boolean table, I end up with the fol=
lowing
> > decisions, depending on whether IOCTL and READ are handled or not, and =
whether
> > they are explicitly permitted for the file through a rule:
> >=20
> >=20
> > Micka=C3=ABl's        IOCTL      IOCTL      IOCTL
> > suggestion       handled,   handled,   unhandled
> > 2023-09-04       file       file not
> >                  permitted  permitted
> > --------------------------------------------------
> > READ handled,
> > file permitted   allow      allow      allow
> >=20
> > READ handled,
> > f not permitted  deny       deny       allow
> >=20
> > READ unhandled   allow      deny       allow
> >=20
> >=20
> > In patch set V3, this is different: Because I think that cases (a) and =
(b) from
> > above should always behave the same, the first and third column and row=
 must be
> > symmetric and have the same entries.  So, in patch set V3, it is suffic=
ient if
> > *one of* the two rights IOCTL and READ_FILE are present, in order to us=
e the
> > FIONREAD IOCTL:
> >=20
> >=20
> > G=C3=BCnther's        IOCTL      IOCTL      IOCTL
> > patch set V3     handled,   handled,   unhandled
> > 2023-08-14       file       file not
> >                  permitted  permitted
> > --------------------------------------------------
> > READ handled,
> > file permitted   allow      allow      allow
> >=20
> > READ handled,
> > f not permitted  allow      deny       allow
> >=20
> > READ unhandled   allow      allow      allow
>=20
> A first difference is about (READ unhandled) AND (IOCTL handled +
> file not permitted). It will not be possible to follow the same logic
> with new Landlock access right (e.g. LANDLOCK_ACCESS_FS_READ_METADATA
> that should also allow FS_IOC_FSGETXATTR), and I'd like to keep it
> consistent.
>=20
> A second difference is about (READ handled + f not permitted) AND
> (IOCTL handled + file permitted). The reasoning was to avoid giving too
> much power to LANDLOCK_ACCESS_FS_IOCTL and dowgrade it as new access
> rights are implemented. This looks quite similar to the CAP_SYS_ADMIN
> right that can basically do anything, and new capabilites are mainly a
> subset of this one. My proposal was to incrementally downgrade the power
> given by LANDLOCK_ACCESS_FS_IOCTL while still being compatible. On the
> I was thinking that, if we make a requirement to have the "new correct"
> access right, the application update might drop the IOCTL access right.
> I now think this reasoning is flawed.
>=20
> Indeed, this comparaison doesn't fit well because IOCTLs are not a
> superset of all access rights, and because nothing can force developers
> that already gave access to all IOCTLs for a file to not just add
> another access right (instead of swapping them).
>=20
> Instead, I think user space libraries should manage this kind of access
> right swapping when possible and have a fallback mechanism relying on
> the LANDLOCK_ACCESS_FS_IOCTL right. This would be valuable because they
> may be updated before the (stable system) kernel, and this would be
> easier for developers to manage.
>=20
> In a nutshell, it is about giving control for an action (e.g. FIONREAD)
> to either a unique access right or to a set of access rights. At first,
> I would have preferred to have a unique access right to control an
> action, because it is simpler (e.g. for audit/debug). On the other hand,
> we need to handle access rights that allow the same action (e.g. file
> read OR write for FIOQSIZE). I now think your approach (i.e. set of
> access rights to control an action) could make more sense. Another good
> point is to not downgrade the power of LANDLOCK_ACCESS_FS_IOCTL, which
> could in fact be difficult to understand for users. Nested Landlock
> domains should also be easier to manage with this logic.

After we discussed this difficult topic briefly off-list, let me try to
summarize my takeaways and write it up here for reference.

I think the requirements for the logic of the IOCTL right are as follows:

 (1) In the future, if a new FOO access right is introduced, this right sho=
uld
     implicitly give access to FOO-related IOCTLs on the affected same file=
s,
     *without requiring the LANDLOCK_ACCESS_FS_IOCTL right*.

     Example: If in Landlock version 10, we introduce LANDLOCK_ACCESS_FS_GF=
X for
     graphics-related functionality, this access right should potentially g=
ive
     access to graphics-related ioctl commands.  I'll use the "GFX" example
     below as a stand-in for a generic future access right which should giv=
e
     access to a set of IOCTL commands.

and then the ones which are a bit more obvious:

 (2) When stacking additional Landlock layers, the thread's available acces=
s can
     only be restricted further (it should not accidentally be able to do m=
ore
     than before).

 (3) Landlock usages need to stay compatible across kernel versions.
     The Landlock usages that are in use today need to do the same thing
     in future kernel versions.

I had indeed overlooked requirement (1) and did not realize that my proposa=
l was
going to be at odds with that.



## Some counterexamples for approaches that don't work

So: Counterexample for why my earlier proposal (OR-combination) does not wo=
rk:

  In my proposal, a GFX-related IOCTL would be permitted when *either one* =
of
  the ..._GFX or the ..._IOCTL rights are available for the file.  (The REA=
D
  right in the tables above should work the same as the GFX or FOO rights f=
rom
  requirement (1), for consistency).

  So a user who today uses

    handled: LANDLOCK_ACCESS_FS_IOCTL
    allowed: (nothing)

  will expect that GFX-related IOCTL operations are forbidden.  (We do not =
know
  yet whether the "GFX" access right will ever exist, therefore it is cover=
ed by
  LANDLOCK_ACCESS_FS_IOCTL.)

  Now we introduce the LANDLOCK_ACCESS_FS_GFX right, and suddenly, GFX-rela=
ted
  IOCTL commands are checked with a new logic: You *either* need to have th=
e
  LANDLOCK_ACCESS_FS_IOCTL right, *or* the LANDLOCK_ACCESS_FS_GFX right.  S=
o
  when the user again uses

    handled: LANDLOCK_ACCESS_FS_IOCTL
    allowed: (nothing)

  the user would according to the new logic suddenly *have* the
  LANDLOCK_ACCESS_FS_GFX right, and these IOCTL commands would be permitted=
.

  This is a change of how Landlock behaves compared to the earlier version,
  and that is at odds with rule (3).


The other obvious bitwise combination (AND) does not work either -- that on=
e
would violate requirement (1).



## A new proposal

We have discussed above that one option would be to start distinguishing be=
tween
the case where a right is "not handled" and the case where the right is
"handled, but allowed on the file".

This is not very nice, because it would be inconsistent with the semantics =
which
we had before for all other rights.

After thinking a bit more about it, one way to look at it is that we are us=
ing
the "handled" flags to control how the IOCTLs are grouped.  I agree that we=
 have
to control the IOCTL grouping, but I am not sure whether the "handled" flag=
s are
the right place to do that. -- We could just as well pass instructions abou=
t the
IOCTL grouping out of band, and I think it might make that logic clearer:

To put forward something concrete, how about this:

* LANDLOCK_ACCESS_FS_IOCTL: This access right controls the invocation of IO=
CTL
  commands, unless these commands are controlled by another access right.

  In every layer, each IOCTL command is only controlled through one access =
right.

* LANDLOCK_ACCESS_FS_READ_FILE: This access right controls opening files fo=
r
  reading, and additionally the use of the FIONREAD ioctl command.

* We introduce a flag in struct landlock_ruleset_attr which controls whethe=
r the
  graphics-related IOCTLs are controlled through the LANDLOCK_ACCESS_FS_GFX
  access right, rather than through LANDLOCK_ACCESS_FS_IOCTL.

  (This could potentially also be put in the "flags" argument to
  landlock_create_ruleset(), but it feels a bit more appropriate in the str=
uct I
  think, as it influences the interpretation of the logic.  But I'm open to
  suggestions.)


Example: Without the flag, the IOCTL groups will be:

  These are always permitted:   FIOCLEX, FIONCLEX, FIONBIO, etc.
  LANDLOCK_ACCESS_FS_READ_FILE: controls FIONREAD
  LANDLOCK_ACCESS_FS_IOCTL:     controls all other IOCTL commands

but when users set the flag, the IOCTL groups will be:

  These are always permitted:   FIOCLEX, FIONCLEX, FIONBIO, etc.
  LANDLOCK_ACCESS_FS_READ_FILE: controls FIONREAD
  LANDLOCK_ACCESS_FS_GFX:       controls (list of gfx-related IOCTLs)
  LANDLOCK_ACCESS_FS_IOCTL:     controls all other IOCTL commands


Implementation-wise, I think it would actually look very similar to what wo=
uld
be needed for your proposal of having a new special meaning for "handled". =
 It
would have the slight advantage that the new flag is actually only needed a=
t the
time when we introduce a new way of grouping the IOCTL commands, so we woul=
d
only burden users with the additional complexity when it's actually require=
d.

One implementation approach that I find reasonable to think about is to cre=
ate
"synthetic" access rights when rulesets are enabled.  That is, we introduce
LANDLOCK_ACCESS_FS_SYNTHETIC_GFX_IOCTL (name TBD), but we keep this constan=
t
private to the kernel.

* *At ruleset enablement time*, we populate the bit for this access right e=
ither
  from the LANDLOCK_ACCESS_FS_GFX or the LANDLOCK_ACCESS_FS_IOCTL bit from =
the
  same access_mask_t, depending on the IOCTL grouping which the ruleset is
  configured with.

* *In hook_file_open*, we then check for LANDLOCK_ACCESS_FS_SYNTHETIC_GFX_I=
OCTL
  for the GFX-related IOCTL commands.

I'm in favor of using the synthetic access rights, because I find it cleare=
r to
understand that the effective access rights for a file from different layer=
s are
just combined with a bitwise AND, and will give the right results.  We coul=
d
probably also make these path walk helpers aware of the special cases and o=
nly
have the synthetic right in layer_masks_dom, but I'd prefer not to complica=
te
these helpers even further.


Sorry for the long mail, I hope that the examples clarify it a bit. :)

In summary, it seems conceptually cleaner to me to control every IOCTL comm=
and
with only one access right, and let users control which one that should be =
with
a separate flag, so that "handled" keeps its original semantics.  It would =
also
have the upside that we can delay that implementation until the time where =
we
actually introduce new IOCTL-aware access rights on top of the current patc=
h st.

I'd be interested to hear your thoughts on it.
=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof

