Return-Path: <linux-fsdevel+bounces-4579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52470800D52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 15:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE2EB20E36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90473E478
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n8U2i/g7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD9B10F3
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 06:30:49 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-54c64c3a702so316433a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 06:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701441048; x=1702045848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MTiOWpw4mbkI96jmZgH9ZmDtOQJP3/Ahm+uC5ZzVjrM=;
        b=n8U2i/g7CT10tAwZEQpSwy624XtxPeTrj5RUc68kV0GAonpxLy4Q2LHynmN8JCiUKp
         c9c1EXRNvCfWM2eB9Om37AvHQAZGTFnoCoGdpK+PhiQ5zNQGNeF8QdCddzJNPfq6Pz3Z
         WK6MRE9T7msh+76N7Dn4YHEJhK4/xjoj411s91akJNEHIUypYS07oUYcbwu763OAAONm
         KlMfTT5mVShWS6CefhCuY9fuG83evs9MRskoXoQ3hq8gk1XYj8u2G73SjUj2MPLKyFjn
         ngMWkYhOo5UD7HjTfoL/j3bjtsGuNhXexr+9yMZH+t0klo2berqqwR3go6Fg51qy0jnq
         bpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441048; x=1702045848;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTiOWpw4mbkI96jmZgH9ZmDtOQJP3/Ahm+uC5ZzVjrM=;
        b=dfrBLbqFpcATqL/eZY/5gd+H36bGyCN1VCkUNXKPN1SCtw6ScidHCWoEzIel26/BTp
         DzmlLkpfsr7IEQXHdfVBeQATdGVSOuhynPSfOegWhAKbuA7QEcOyorJf8eou7OJEsQto
         NjR9uYa1RBiHl0XgszZ2idOQJAbi4XQhyvtACuONs73GUSrpYz9EnXrLzccie3u4jsjS
         QmniO181VAIpXwBq2nk3KUx6CcMcvaQmSjLH75WDhgG+AU1tHnSWBROmODMu51lZKdMJ
         e6e7u0SYm3U9WMMNa5a8p4oSBx/GpfUQ73jw6YkCjBd1jNqeAnz8Drwz6O9m3RWG7nPL
         nHOQ==
X-Gm-Message-State: AOJu0YytBUhc9M3CdoUVzajROYAzQx/QeyiXRlF2DSrAY3k0fhZElwrA
	XXEBwPGCi4Dvd2ceG2yMHZxc+U16vE0=
X-Google-Smtp-Source: AGHT+IFYO6JUpM7k4TfyBZNVtswNPipkHnhHiz77cFn+HElXwWFH0HXL7VF0tMP2B4wxW4YNc3n6NoSt7Lc=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:fab0:4182:b9df:bfec])
 (user=gnoack job=sendgmr) by 2002:a05:6402:1bc7:b0:54c:5e07:ea3 with SMTP id
 ch7-20020a0564021bc700b0054c5e070ea3mr19596edb.5.1701441047533; Fri, 01 Dec
 2023 06:30:47 -0800 (PST)
Date: Fri,  1 Dec 2023 15:30:33 +0100
Message-Id: <20231201143042.3276833-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v7 0/9] Landlock: IOCTL support
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

These patches add simple ioctl(2) support to Landlock.

Objective
~~~~~~~~~

Make ioctl(2) requests restrictable with Landlock,
in a way that is useful for real-world applications.

Proposed approach
~~~~~~~~~~~~~~~~~

Introduce the LANDLOCK_ACCESS_FS_IOCTL right, which restricts the use
of ioctl(2) on file descriptors.

We attach IOCTL access rights to opened file descriptors, as we
already do for LANDLOCK_ACCESS_FS_TRUNCATE.

If LANDLOCK_ACCESS_FS_IOCTL is handled (restricted in the ruleset),
the LANDLOCK_ACCESS_FS_IOCTL access right governs the use of all IOCTL
commands.

We make an exception for the common and known-harmless IOCTL commands
FIOCLEX, FIONCLEX, FIONBIO and FIONREAD.  These IOCTL commands are
always permitted.  Their functionality is already available through
fcntl(2).

If additionally(!), the access rights LANDLOCK_ACCESS_FS_READ_FILE,
LANDLOCK_ACCESS_FS_WRITE_FILE or LANDLOCK_ACCESS_FS_READ_DIR are
handled, these access rights also unlock some IOCTL commands which are
considered safe for use with files opened in these ways.

As soon as these access rights are handled, the affected IOCTL
commands can not be permitted through LANDLOCK_ACCESS_FS_IOCTL any
more, but only be permitted through the respective more specific
access rights.  A full list of these access rights is listed below in
this cover letter and in the documentation.

I believe that this approach works for the majority of use cases, and
offers a good trade-off between Landlock API and implementation
complexity and flexibility when the feature is used.

Current limitations
~~~~~~~~~~~~~~~~~~~

With this patch set, ioctl(2) requests can *not* be filtered based on
file type, device number (dev_t) or on the ioctl(2) request number.

On the initial RFC patch set [1], we have reached consensus to start
with this simpler coarse-grained approach, and build additional IOCTL
restriction capabilities on top in subsequent steps.

[1] https://lore.kernel.org/linux-security-module/d4f1395c-d2d4-1860-3a02-2=
a0c023dd761@digikod.net/

Notable implications of this approach
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Existing inherited file descriptors stay unaffected
  when a program enables Landlock.

  This means in particular that in common scenarios,
  the terminal's IOCTLs (ioctl_tty(2)) continue to work.

* ioctl(2) continues to be available for file descriptors acquired
  through means other than open(2).  Example: Network sockets,
  memfd_create(2), file descriptors that are already open before the
  Landlock ruleset is enabled.

Examples
~~~~~~~~

Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:

  LL_FS_RO=3D/ LL_FS_RW=3D. ./sandboxer /bin/bash

The LANDLOCK_ACCESS_FS_IOCTL right is part of the "read-write" rights
here, so we expect that newly opened files outside of $HOME don't work
with most IOCTL commands.

  * "stty" works: It probes terminal properties

  * "stty </dev/tty" fails: /dev/tty can be reopened, but the IOCTL is
    denied.

  * "eject" fails: ioctls to use CD-ROM drive are denied.

  * "ls /dev" works: It uses ioctl to get the terminal size for
    columnar layout

  * The text editors "vim" and "mg" work.  (GNU Emacs fails because it
    attempts to reopen /dev/tty.)

IOCTL groups
~~~~~~~~~~~~

To decide which IOCTL commands should be blanket-permitted we went
through the list of IOCTL commands mentioned in fs/ioctl.c and looked
at them individually to understand what they are about.  The following
list is for reference.

We should always allow the following IOCTL commands, which are also
available through fcntl(2) with the F_SETFD and F_SETFL commands:

 * FIOCLEX, FIONCLEX - these work on the file descriptor and
   manipulate the close-on-exec flag
 * FIONBIO, FIOASYNC - these work on the struct file and enable
   nonblocking-IO and async flags

The following command is guarded and enabled by either of
LANDLOCK_ACCESS_FS_WRITE_FILE, LANDLOCK_ACCESS_FS_READ_FILE or
LANDLOCK_ACCESS_FS_READ_DIR (G2), once one of them is handled
(otherwise by LANDLOCK_ACCESS_FS_IOCTL):

 * FIOQSIZE - get the size of the opened file

The following commands are guarded and enabled by either of
LANDLOCK_ACCESS_FS_WRITE_FILE or LANDLOCK_ACCESS_FS_READ_FILE (G2),
once one of them is handled (otherwise by LANDLOCK_ACCESS_FS_IOCTL):

These are commands that read file system internals:

 * FS_IOC_FIEMAP - get information about file extent mapping
   (c.f. https://www.kernel.org/doc/Documentation/filesystems/fiemap.txt)
 * FIBMAP - get a file's file system block number
 * FIGETBSZ - get file system blocksize

The following commands are guarded and enabled by
LANDLOCK_ACCESS_FS_READ_FILE (G3), if it is handled (otherwise by
LANDLOCK_ACCESS_FS_IOCTL):

 * FIONREAD - get the number of bytes available for reading (the
   implementation is defined per file type)
 * FIDEDUPRANGE - manipulating shared physical storage between files.

The following commands are guarded and enabled by
LANDLOCK_ACCESS_FS_WRITE_FILE (G4), if it is handled (otherwise by
LANDLOCK_ACCESS_FS_IOCTL):

 * FICLONE, FICLONERANGE - making files share physical storage between
   multiple files.  These only work on some file systems, by design.
 * FS_IOC_RESVSP, FS_IOC_RESVSP64, FS_IOC_UNRESVSP, FS_IOC_UNRESVSP64,
   FS_IOC_ZERO_RANGE: Backwards compatibility with legacy XFS
   preallocation syscalls which predate fallocate(2).

The following commands are also mentioned in fs/ioctl.c, but are not
handled specially and are managed by LANDLOCK_ACCESS_FS_IOCTL together
with all other remaining IOCTL commands:

 * FIFREEZE, FITHAW - work on superblock(!) to freeze/thaw the file
   system. Requires CAP_SYS_ADMIN.
 * Accessing file attributes:
   * FS_IOC_GETFLAGS, FS_IOC_SETFLAGS - manipulate inode flags (ioctl_iflag=
s(2))
   * FS_IOC_FSGETXATTR, FS_IOC_FSSETXATTR - more attributes

Related Work
~~~~~~~~~~~~

OpenBSD's pledge(2) [2] restricts ioctl(2) independent of the file
descriptor which is used.  The implementers maintain multiple
allow-lists of predefined ioctl(2) operations required for different
application domains such as "audio", "bpf", "tty" and "inet".

OpenBSD does not guarantee ABI backwards compatibility to the same
extent as Linux does, so it's easier for them to update these lists in
later versions.  It might not be a feasible approach for Linux though.

[2] https://man.openbsd.org/OpenBSD-7.3/pledge.2

Changes
~~~~~~~

V7:
 * in =E2=80=9Clandlock: Add IOCTL access right=E2=80=9D:
   * Make IOCTL_GROUPS a #define so that static_assert works even on
     old compilers (bug reported by Intel about PowerPC GCC9 config)
   * Adapt indentation of IOCTL_GROUPS definition
   * Add missing dots in kernel-doc comments.
 * in =E2=80=9Clandlock: Remove remaining "inline" modifiers in .c files=E2=
=80=9D:
   * explain reasoning in commit message

V6:
 * Implementation:
   * Check that only publicly visible access rights can be used when adding=
 a
     rule (rather than the synthetic ones).  Thanks Micka=C3=ABl for spotti=
ng that!
   * Move all functionality related to IOCTL groups and synthetic access ri=
ghts
     into the same place at the top of fs.c
   * Move kernel doc to the .c file in one instance
   * Smaller code style issues (upcase IOCTL, vardecl at block start)
   * Remove inline modifier from functions in .c files
 * Tests:
   * use SKIP
   * Rename 'fd' to dir_fd and file_fd where appropriate
   * Remove duplicate "ioctl" mentions from test names
   * Rename "permitted" to "allowed", in ioctl and ftruncate tests
   * Do not add rules if access is 0, in test helper

V5:
 * Implementation:
   * move IOCTL group expansion logic into fs.c (implementation suggested b=
y
     mic)
   * rename IOCTL_CMD_G* constants to LANDLOCK_ACCESS_FS_IOCTL_GROUP*
   * fs.c: create ioctl_groups constant
   * add "const" to some variables
 * Formatting and docstring fixes (including wrong kernel-doc format)
 * samples/landlock: fix ABI version and fallback attribute (mic)
 * Documentation
   * move header documentation changes into the implementation commit
   * spell out how FIFREEZE, FITHAW and attribute-manipulation ioctls from
     fs/ioctl.c are handled
   * change ABI 4 to ABI 5 in some missing places
  =20
V4:
 * use "synthetic" IOCTL access rights, as previously discussed
 * testing changes
   * use a large fixture-based test, for more exhaustive coverage,
     and replace some of the earlier tests with it
 * rebased on mic-next

V3:
 * always permit the IOCTL commands FIOCLEX, FIONCLEX, FIONBIO, FIOASYNC an=
d
   FIONREAD, independent of LANDLOCK_ACCESS_FS_IOCTL
 * increment ABI version in the same commit where the feature is introduced
 * testing changes
   * use FIOQSIZE instead of TTY IOCTL commands
     (FIOQSIZE works with regular files, directories and memfds)
   * run the memfd test with both Landlock enabled and disabled
   * add a test for the always-permitted IOCTL commands

V2:
 * rebased on mic-next
 * added documentation
 * exercise ioctl(2) in the memfd test
 * test: Use layout0 for the test

---

V1: https://lore.kernel.org/linux-security-module/20230502171755.9788-1-gno=
ack3000@gmail.com/
V2: https://lore.kernel.org/linux-security-module/20230623144329.136541-1-g=
noack@google.com/
V3: https://lore.kernel.org/linux-security-module/20230814172816.3907299-1-=
gnoack@google.com/
V4: https://lore.kernel.org/linux-security-module/20231103155717.78042-1-gn=
oack@google.com/
V5: https://lore.kernel.org/linux-security-module/20231117154920.1706371-1-=
gnoack@google.com/
V6: https://lore.kernel.org/linux-security-module/20231124173026.3257122-1-=
gnoack@google.com/

G=C3=BCnther Noack (9):
  landlock: Remove remaining "inline" modifiers in .c files
  selftests/landlock: Rename "permitted" to "allowed" in ftruncate tests
  landlock: Optimize the number of calls to get_access_mask slightly
  landlock: Add IOCTL access right
  selftests/landlock: Test IOCTL support
  selftests/landlock: Test IOCTL with memfds
  selftests/landlock: Test ioctl(2) and ftruncate(2) with open(O_PATH)
  samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
  landlock: Document IOCTL support

 Documentation/userspace-api/landlock.rst     |  74 ++-
 include/uapi/linux/landlock.h                |  58 +-
 samples/landlock/sandboxer.c                 |  13 +-
 security/landlock/fs.c                       | 202 ++++++-
 security/landlock/fs.h                       |   2 +
 security/landlock/limits.h                   |   5 +-
 security/landlock/ruleset.c                  |   7 +-
 security/landlock/ruleset.h                  |   2 +-
 security/landlock/syscalls.c                 |  19 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 523 ++++++++++++++++++-
 11 files changed, 833 insertions(+), 74 deletions(-)


base-commit: 413e638fb4dfee94933e28fd9a6a8ed294447279
--=20
2.43.0.rc2.451.g8631bc7472-goog


