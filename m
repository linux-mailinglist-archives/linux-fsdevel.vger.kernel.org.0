Return-Path: <linux-fsdevel+bounces-3016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 303987EF4B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 15:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8848281292
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 14:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D8032C7E;
	Fri, 17 Nov 2023 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDCadDVZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45A7C5
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 06:44:32 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-5411d71889aso1592792a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 06:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700232271; x=1700837071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qwN/2WOIPEYb8TYshaIYfbXxHZdqG/EksP4GJgVyJM=;
        b=UDCadDVZlvh4lQbIS1dWK2lv5Y/18ygg1BEPFN854HTAp7ctxlBkbNuqooa3FLjT1v
         CyyxFYZ7KVFI+ulqN1kF56AzTsb+jFR7eL4juElKJ0uMt8ohUmzhbAzSPzQ2kFx2TOPa
         TepXvU7iAcwYTLSzCAzU2qgOAwa5kXLy1L9a5ltd7k1+lfzPomaMkcxuHPHZofKtsaLE
         S3DfTC9l9etl7x0yyLHmcbOZImiUkYhC9evOJINIMKmwhWGWo3mpOgkTkK6zYCBrDAI5
         V1WBct/69Cy0b9hUXPTLjjif7SBGinwGeJNeYmornSX1+GdG3W6qDC0X9xDY1UuBvKLP
         7Vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700232271; x=1700837071;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0qwN/2WOIPEYb8TYshaIYfbXxHZdqG/EksP4GJgVyJM=;
        b=sfCCS/CwuyJ1r3xMKi0x7le5WlJgBxdq05aHzddOf7vH+QV3w+YQt2IYbnilDVWzyB
         GIuI27LcgLSXsnN3wkfLeRD4ieE8hxecqJtWRje6wSdp9dBST4S6YR10C7cbzr9XeI1W
         YwNaZTDWhSzuUvhPwnhTE3c/+YutZf5ZNjMuidXZFehK+tWzMp7aJNKya9DIGv+9mn09
         x6uRQi+Nj+qID3YTB2P+t6FJnPEWfbHnXgpp6k+/DPWPiPPgOujj/P5Dd8/eWmpG6z16
         dleIqCgakd2APCpv1zrFuTR+JJxU7eW3MXqEYjh0EFhQi7atT8j4WvfO/6aSTwJhuyzt
         qGIQ==
X-Gm-Message-State: AOJu0Yy5748egye1ZGgGHFQXgl7js94dBdbzWWOrQC4nYJpmsEzIgdIg
	IPDQZZQ2WmdUbw3RZXah1+GWTEaOebI=
X-Google-Smtp-Source: AGHT+IH/LfyZ+tYOlVNCvgcSx5g32WmU4BDu+7JAjSW8b4tVQpjuWnQ+3DdhkqwDu2Jxr4lAfcQ9xW6jTUA=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:aa7:cb17:0:b0:543:7c94:cda6 with SMTP id
 s23-20020aa7cb17000000b005437c94cda6mr221278edt.0.1700232270919; Fri, 17 Nov
 2023 06:44:30 -0800 (PST)
Date: Fri, 17 Nov 2023 15:44:20 +0100
In-Reply-To: <20231116.haW5ca7aiyee@digikod.net>
Message-Id: <ZVd8RP01oNc5K92c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com> <20231116.haW5ca7aiyee@digikod.net>
Subject: Re: [PATCH v4 0/7] Landlock: IOCTL support
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 04:49:09PM -0500, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Nov 03, 2023 at 04:57:10PM +0100, G=C3=BCnther Noack wrote:
> > Hello!
> >=20
> > These patches add simple ioctl(2) support to Landlock.
> >=20
> > Objective
> > ~~~~~~~~~
> >=20
> > Make ioctl(2) requests restrictable with Landlock,
> > in a way that is useful for real-world applications.
> >=20
> > Proposed approach
> > ~~~~~~~~~~~~~~~~~
> >=20
> > Introduce the LANDLOCK_ACCESS_FS_IOCTL right, which restricts the use
> > of ioctl(2) on file descriptors.
> >=20
> > We attach IOCTL access rights to opened file descriptors, as we
> > already do for LANDLOCK_ACCESS_FS_TRUNCATE.
> >=20
> > If LANDLOCK_ACCESS_FS_IOCTL is handled (restricted in the ruleset),
> > the LANDLOCK_ACCESS_FS_IOCTL access right governs the use of all IOCTL
> > commands.
> >=20
> > We make an exception for the common and known-harmless IOCTL commands
> > FIOCLEX, FIONCLEX, FIONBIO and FIONREAD.  These IOCTL commands are
> > always permitted.  Their functionality is already available through
> > fcntl(2).
> >=20
> > If additionally(!), the access rights LANDLOCK_ACCESS_FS_READ_FILE,
> > LANDLOCK_ACCESS_FS_WRITE_FILE or LANDLOCK_ACCESS_FS_READ_DIR are
> > handled, these access rights also unlock some IOCTL commands which are
> > considered safe for use with files opened in these ways.
> >=20
> > As soon as these access rights are handled, the affected IOCTL
> > commands can not be permitted through LANDLOCK_ACCESS_FS_IOCTL any
> > more, but only be permitted through the respective more specific
> > access rights.  A full list of these access rights is listed below in
> > this cover letter and in the documentation.
> >=20
> > I believe that this approach works for the majority of use cases, and
> > offers a good trade-off between Landlock API and implementation
> > complexity and flexibility when the feature is used.
> >=20
> > Current limitations
> > ~~~~~~~~~~~~~~~~~~~
> >=20
> > With this patch set, ioctl(2) requests can *not* be filtered based on
> > file type, device number (dev_t) or on the ioctl(2) request number.
> >=20
> > On the initial RFC patch set [1], we have reached consensus to start
> > with this simpler coarse-grained approach, and build additional IOCTL
> > restriction capabilities on top in subsequent steps.
> >=20
> > [1] https://lore.kernel.org/linux-security-module/d4f1395c-d2d4-1860-3a=
02-2a0c023dd761@digikod.net/
> >=20
> > Notable implications of this approach
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >=20
> > * Existing inherited file descriptors stay unaffected
> >   when a program enables Landlock.
> >=20
> >   This means in particular that in common scenarios,
> >   the terminal's IOCTLs (ioctl_tty(2)) continue to work.
> >=20
> > * ioctl(2) continues to be available for file descriptors acquired
> >   through means other than open(2).  Example: Network sockets,
> >   memfd_create(2), file descriptors that are already open before the
> >   Landlock ruleset is enabled.
> >=20
> > Examples
> > ~~~~~~~~
> >=20
> > Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:
> >=20
> >   LL_FS_RO=3D/ LL_FS_RW=3D. ./sandboxer /bin/bash
> >=20
> > The LANDLOCK_ACCESS_FS_IOCTL right is part of the "read-write" rights
> > here, so we expect that newly opened files outside of $HOME don't work
> > with most IOCTL commands.
> >=20
> >   * "stty" works: It probes terminal properties
> >=20
> >   * "stty </dev/tty" fails: /dev/tty can be reopened, but the IOCTL is
> >     denied.
> >=20
> >   * "eject" fails: ioctls to use CD-ROM drive are denied.
> >=20
> >   * "ls /dev" works: It uses ioctl to get the terminal size for
> >     columnar layout
> >=20
> >   * The text editors "vim" and "mg" work.  (GNU Emacs fails because it
> >     attempts to reopen /dev/tty.)
> >=20
> > IOCTL groups
> > ~~~~~~~~~~~~
> >=20
> > To decide which IOCTL commands should be blanket-permitted we went
> > through the list of IOCTL commands mentioned in fs/ioctl.c and looked
> > at them individually to understand what they are about.  The following
> > list is for reference.
> >=20
> > We should always allow the following IOCTL commands, which are also
> > available through fcntl(2) with the F_SETFD and F_SETFL commands:
> >=20
> >  * FIOCLEX, FIONCLEX - these work on the file descriptor and
> >    manipulate the close-on-exec flag
> >  * FIONBIO, FIOASYNC - these work on the struct file and enable
> >    nonblocking-IO and async flags
> >=20
> > The following command is guarded and enabled by either of
> > LANDLOCK_ACCESS_FS_WRITE_FILE, LANDLOCK_ACCESS_FS_READ_FILE or
> > LANDLOCK_ACCESS_FS_READ_DIR (G2), once one of them is handled
> > (otherwise by LANDLOCK_ACCESS_FS_IOCTL):
> >=20
> >  * FIOQSIZE - get the size of the opened file
> >=20
> > The following commands are guarded and enabled by either of
> > LANDLOCK_ACCESS_FS_WRITE_FILE or LANDLOCK_ACCESS_FS_READ_FILE (G2),
> > once one of them is handled (otherwise by LANDLOCK_ACCESS_FS_IOCTL):
> >=20
> > These are commands that read file system internals:
> >=20
> >  * FS_IOC_FIEMAP - get information about file extent mapping
> >    (c.f. https://www.kernel.org/doc/Documentation/filesystems/fiemap.tx=
t)
> >  * FIBMAP - get a file's file system block number
> >  * FIGETBSZ - get file system blocksize
> >=20
> > The following commands are guarded and enabled by
> > LANDLOCK_ACCESS_FS_READ_FILE (G3), if it is handled (otherwise by
> > LANDLOCK_ACCESS_FS_IOCTL):
> >=20
> >  * FIONREAD - get the number of bytes available for reading (the
> >    implementation is defined per file type)
> >  * FIDEDUPRANGE - manipulating shared physical storage between files.
> >=20
> > The following commands are guarded and enabled by
> > LANDLOCK_ACCESS_FS_WRITE_FILE (G4), if it is handled (otherwise by
> > LANDLOCK_ACCESS_FS_IOCTL):
> >=20
> >  * FICLONE, FICLONERANGE - making files share physical storage between
> >    multiple files.  These only work on some file systems, by design.
> >  * FS_IOC_RESVSP, FS_IOC_RESVSP64, FS_IOC_UNRESVSP, FS_IOC_UNRESVSP64,
> >    FS_IOC_ZERO_RANGE: Backwards compatibility with legacy XFS
> >    preallocation syscalls which predate fallocate(2).
> >=20
> > The following commands are also mentioned in fs/ioctl.c, but are not
> > handled specially and are managed by LANDLOCK_ACCESS_FS_IOCTL together
> > with all other remaining IOCTL commands:
> >=20
> >  * FIFREEZE, FITHAW - work on superblock(!) to freeze/thaw the file
> >    system. Requires CAP_SYS_ADMIN.
> >  * Accessing file attributes:
> >    * FS_IOC_GETFLAGS, FS_IOC_SETFLAGS - manipulate inode flags (ioctl_i=
flags(2))
> >    * FS_IOC_FSGETXATTR, FS_IOC_FSSETXATTR - more attributes
>=20
> This looks great!
>=20
> It would be nice to copy these IOCTL descriptions to the user
> documentation too. That would help explain the rationale and let users
> know that they should not be worried about the related IOCTLs.

Added.


> > Open questions
> > ~~~~~~~~~~~~~~
> >=20
> > This is unlikely to be the last iteration, but we are getting closer.
> >=20
> > Some notable open questions are:
> >=20
> >  * Code style
> > =20
> >    * Should we move the IOCTL access right expansion logic into the
> >      outer layers in syscall.c?  Where it currently lives in
> >      ruleset.h, this logic feels too FS-specific, and it introduces
> >      the additional complication that we now have to track which
> >      access_mask_t-s are already expanded and which are not.  It might
> >      be simpler to do the expansion earlier.
>=20
> What about creating a new helper in fs.c that expands the FS access
> rights, something like this:
>=20
> int landlock_expand_fs_access(access_mask_t *access_mask)
> {
> 	if (!*access_mask)
> 		return -ENOMSG;
>=20
> 	*access_mask =3D expand_all_ioctl(*access_mask, *access_mask);
> 	return 0;
> }
>=20
>=20
> And in syscalls.c:
>=20
> 	err =3D
> 		landlock_expand_fs_access(&ruleset_attr.handled_access_fs);
> 	if (err)
> 		return err;
>=20
> 	/* Checks arguments and transforms to kernel struct. */
> 	ruleset =3D landlock_create_ruleset(ruleset_attr.handled_access_fs,
> 					  ruleset_attr.handled_access_net);

Done, this looks good.

I called the landlock_expand_fs_access function slightly differently and ma=
de it
return the resulting access_mask_t (because it does not make a performance
difference, and then there is no potential for calling it with a null point=
er,
and the function does not need to return an error).

As a consequence of doing it like this, I also moved the expansion function=
s
into fs.c, away from ruleset.h where they did not fit in. :)


> And patch the landlock_create_ruleset() helper with that:
>=20
> -	if (!fs_access_mask && !net_access_mask)
> +	if (WARN_ON_ONCE(!fs_access_mask) && !net_access_mask)
> 		return ERR_PTR(-ENOMSG);

Why would you want to warn on the case where fs_access_mask is zero?

Is it not a legitimate use case to use Landlock for the network aspect only=
?

(If a user is not handling any of the LANDLOCK_ACCESS_FS* rights, the expan=
sion
step is not going to add any.)


> >    * Rename IOCTL_CMD_G1, ..., IOCTL_CMD_G4 and give them better names.
>=20
> Why not something like LANDLOCK_ACCESS_FS_IOCTL_GROUP* to highlight that
> these are in fact (synthetic) access rights?
>=20
> I'm not sure we can find better than GROUP because even the content of
> these groups might change in the future with new access rights.

Makes sense, renamed as suggested.  TBH, IOCTL_CMD_G1...4 was more of a
placeholder anyway because I was so lazy with my typing. ;)


> >  * When LANDLOCK_ACCESS_FS_IOCTL is granted on a file hierarchy,
> >    should this grant the permission to use *any* IOCTL?  (Right now,
> >    it is any IOCTL except for the ones covered by the IOCTL groups,
> >    and it's a bit weird that the scope of LANDLOCK_ACCESS_FS_IOCTL
> >    becomes smaller when other access rights are also handled.
>=20
> Are you suggesting to handle differently this right if it is applied to
> a directory?

No - this applies to files as well.  I am suggesting that granting
LANDLOCK_ACCESS_FS_IOCTL on a file or file hierarchy should always give acc=
ess
to *all* ioctls, both the ones in the synthetic groups and the remaining on=
es.

Let me spell out the scenario:

Steps to reproduce:
  - handle: LANDLOCK_ACCESS_FS_IOCTL | LANDLOCK_ACCESS_FS_READ_FILE
  - permit: LANDLOCK_ACCESS_FS_IOCTL
            on file f
  - open file f (for write-only)
  - attempt to use ioctl(fd, FIOQSIZE, ...)

With this patch set:
  - ioctl(fd, FIOQSIZE, ...) fails,
    because FIOQSIZE is part of IOCTL_CMD_G1
    and because LANDLOCK_ACCESS_FS_READ_FILE is handled,
    IOCTL_CMD_G1 is only unlocked through LANDLOCK_ACCESS_FS_READ_FILE

Alternative proposal:
  - ioctl(fd, FIOQSIZE, ...) should maybe work,
    because LANDLOCK_ACCESS_FS_IOCTL is permitted on f

    Implementation-wise, this would mean to add

    expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_IOCTL, ioctl_groups)

    to expand_all_ioctl().

I feel that this alternative might be less surprising, because granting the
IOCTL right would grant all the things that were restricted when handling t=
he
IOCTL right, and it would be more "symmetric".

What do you think?


> If the scope of LANDLOCK_ACCESS_FS_IOCTL is well documented, that should
> be OK. But maybe we should rename this right to something like
> LANDLOCK_ACCESS_FS_IOCTL_DEFAULT to make it more obvious that it handles
> IOCTLs that are not handled by other access rights?

Hmm, I'm not convinced this is a good name.  It makes sense in the context =
of
allowing "all the other ioctls" for a file or file hierarchy, but when sett=
ing
LANDLOCK_ACCESS_FS_IOCTL in handled_access_fs, that flag turns off *all* io=
ctls,
so "default" doesn't seem appropriate to me.


> >  * Backwards compatibility for user-space libraries.
> >=20
> >    This is not documented yet, because it is currently not necessary
> >    yet.  But as soon as we have a hypothetical Landlock ABI v6 with a
> >    new IOCTL-enabled "GFX" access right, the "best effort" downgrade
> >    from v6 to v5 becomes more involved: If the caller handles
> >    GFX+IOCTL and permits GFX on a file, the correct downgrade to make
> >    this work on a Landlock v5 kernel is to handle IOCTL only, and
> >    permit IOCTL(!).
>=20
> I don't see any issue to this approach. If there is no way to handle GFX
> in v5, then there is nothing more we can do than allowing GFX (on the
> same file). Another way to say it is that in v5 we allow any IOCTL
> (including GFX ones) on the GFX files, an in v6 we *need* replace this
> IOCTL right with the newly available GFX right, *if it is handled* by
> the ruleset.
>=20
> If GFX would not be tied to a file, I think it would not be a good
> design for this access right. Currently all access rights are tied to
> objects/data, or relative to the sandbox (e.g. ptrace).

Yes, makes sense - we are aligned then.

=E2=80=94G=C3=BCnther

