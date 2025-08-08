Return-Path: <linux-fsdevel+bounces-57140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 981C7B1EF96
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D96118872D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E372242922;
	Fri,  8 Aug 2025 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="XO+xQCAM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A7820F069;
	Fri,  8 Aug 2025 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685613; cv=none; b=P6J+Pq4yIzihLCVVm1QAP88Q68PKqG495WmcDwzuJ3NCqnlwicBXaZbROE5tEEA8Uhn2i4lJaLUb4IHu7L+66vgRlA2llCjnT3MpyvtM4HNknOINLoMWyDLx3zfpBbRQU13NkEeWuwx1Po+7WQJ2av6Dh3Mj4fh577bP1NUGwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685613; c=relaxed/simple;
	bh=EkxknFvA9Su/ko3AeYiwvdtaNkRvXjhZQuJGQSTOVdY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PG8ODfFgyqLjyN7BGc/dMg553ZTtAuqaWeCdn07I4NtL1O69smfYCOFIU6EZKG2YnOsJtiDlNcMPohrPIHXJHPks1nVVrQx9a2SHfoYEkJN9N4L+IQzIjBYU05Vcix0AfOa2Z7ZUSE03du0PodvxKu4VtthXnG1ihCENKikFcAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=XO+xQCAM; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bzG9s6MwZz9sWF;
	Fri,  8 Aug 2025 22:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754685601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CPz3upmcNdoeEOQXC+fyclwakLt6QiiHDv7SImCY6+U=;
	b=XO+xQCAMJgtaZxDfUWIQ6ZyClvtXOqckMD8cqlqQ8gmU9PIHm5ThBdBpqkjwmukkDbaSJ7
	G+ELIasvqA/L+GxWFfeaTyRWtJcqJnA2BnjuMttMNoZq3gM2RT5d3RyA8QV6mReaTMTb3h
	8DBWs0kWCf4We544BuXWWLeH7vWMb67MFcQ1a3WAoX40t4VCeNQUykSXuW8bqMl2qdXRp0
	dhI/fx9t4CCO7VSdxcYNHeSWbhIflQwten8odYxRho3rIyYpdDP3priogJII7RrsGialPx
	oHa2iBeDfQ4AfO3ixUg0voxhNhb7YDS4GmSHZOLReqEkdN58ltexf9Mtjme2Tw==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v3 00/12] man2: document "new" mount API
Date: Sat, 09 Aug 2025 06:39:44 +1000
Message-Id: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJBglmgC/13MQQ6DIBRF0a0YxqVBFKSOuo+mA8Rv/QPBgKU1x
 r0XTZq0Dt9L7llIAI8QSJ0txEPEgM6mUZwyYnptH0CxTZtwxgVTjFMLLzq4p52oHpGWhWybiyq
 7suAkNaOHDt+7d7un3WOYnJ93Pubb+5XkQYo5ZVTJSnVCGgnArmYee+3Pxg1koyL/zatjzlMuh
 NK8ahKuzF++rusH3+OibOoAAAA=
X-Change-ID: 20250802-new-mount-api-436db984f432
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8227; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=EkxknFvA9Su/ko3AeYiwvdtaNkRvXjhZQuJGQSTOVdY=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMS5jGEH1TcG3xl8jJe9fwFfpvvr8vg3/hlvDQh39eJ
 t2Q7DH27ShlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIbwsUpABNR52L4Z6Cxev+vj58elB3j
 SNDdpdAZ1R5yw2a6bv9m2TuftmhUNDH8D9nOuuC7l/vUXUZ6oiuFUk2MelTij96X5in6uO7I6Ud
 erAA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Back in 2019, the new mount API was merged[1]. David Howells then set
about writing man pages for these new APIs, and sent some patches back
in 2020[2].

Unfortunately, these patches were never merged, which meant that these
APIs were practically undocumented for many years -- arguably this has
been a contributing factor to the relatively slow adoption of these new
(far better) APIs. For instance, I have often discovered that many folks
are unaware of the read(2)-based message retrieval interface provided by
filesystem context file descriptors.

In 2024, Christian Brauner adapted David Howell's original man pages
into the easier-to-edit Markdown format and published them on GitHub[3].
These have been maintained since, including updated information on new
features added since David Howells's 2020 draft pages (such as
MOVE_MOUNT_BENEATH).

While this was a welcome improvement to the previous status quo (that
had lasted over 6 years), speaking personally my experience is that not
having access to these man pages from the terminal has been a fairly
common painpoint.

So, this is a modern version of the man pages for these APIs, in the
hopes that we can finally (6 years later) get proper documentation for
these APIs in the man-pages project.

One important thing to note is that most of these were re-written by me,
with very minimal copying from the versions available from Christian[2].
The reasons for this are two-fold:

 * Both Howells's original version and Christian's maintained versions
   contain crucial mistakes that I have been bitten by in the past (the
   most obvious being that all of these APIs were merged in Linux 5.2,
   but the man pages all claim they were merged in different versions.)

 * As the man pages appear to have been written from Howells's
   perspective while implementing them, some of the wording is a little
   too tied to the implementation (or appears to describe features that
   don't really exist in the merged versions of these APIs).

 * The original versions of the man-pages lacked bigger-picture
   explanations of the reasoning behind the API, which would make it
   easier for readers to understand what operations are doing.

I decided that the best way to resolve these issues is to rewrite them
from the perspective of an actual user of these APIs (me), and check
that we do not repeat the mistakes I found in the originals. I have also
done my best to resolve the issues raised by Michael Kerrisk on the
original patchset sent by Howells[1].

In addition, I have also included a man page for open_tree_attr(2) (as a
subsection of the new open_tree(2) man page), which was merged in Linux
6.15.

[1]: https://lore.kernel.org/all/20190507204921.GL23075@ZenIV.linux.org.uk/
[2]: https://lore.kernel.org/linux-man/159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk/
[3]: https://github.com/brauner/man-pages-md

Co-authored-by: David Howells <dhowells@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Co-authored-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Changes in v3:
- `sed -i s|Co-developed-by|Co-authored-by|g`. [Alejandro Colomar]
  - Add Signed-off-by for co-authors. [Christian Brauner]
- `sed -i s|needs-mount|awaiting-mount|g`, to match the kernel parlance.
- Fix VERSIONS/HISTORY mixup in mount_attr(2type) that was copied from
  open_how(2type). [Alejandro Colomar]
- Fix incorrect .BR usage in SYNOPSIS.
- Some more semantic newlines fixes. [Alejandro Colomar]
- Minor fixes suggested by Alejandro. [Alejandro Colomar]
- open_tree_attr(2): heavily reword everything to be better formatted
  and more explicit about its behaviour.
- open_tree(2): write proper explanatory paragraphs for the EXAMPLES.
- mount_setattr(2): fix stray doublequote in SYNOPSIS. [Askar Safin]
- fsopen(2): rework structure of the DESCRIPTION introduction.
- fsopen(2): explicitly say that read(2) errors in the message retrieval
  interface are actual errors, not return 0. [Askar Safin]
- fsopen(2): add BUGS section to describe the unfortunate -ENODATA
  message dropping behaviour that should be fixed by
  <https://lore.kernel.org/r/20250807-fscontext-log-cleanups-v3-0-8d91d6242dc3@cyphar.com/>.
- fsconfig(2): add a NOTES subsection about generic filesystem
  parameters.
- fsconfig(2): add comment about the weirdness surrounding
  FSCONFIG_SET_PATH.
- {fspick,open_tree}(2): Correct AT_NO_AUTOMOUNT description (copied
  from David, who probably copied it from statx(2)) -- AT_NO_AUTOMOUNT
  applies to all path components, not just the final one. [Christian
  Brauner]
- statx(2): fix AT_NO_AUTOMOUNT documentation.
- open_tree(2): swap open(2) reference for openat(2) when saying that
  the result is identical. [Askar Safin]
- fsmount(2): fix DESCRIPTION introduction, and rework attr_flags
  description to better reference mount_setattr(2).
- {fsopen,fspick,fsmount,open_tree}(2): don't use "attach" when talking
  about the file descriptors we return that reference in-kernel objects,
  to avoid confusing readers with mount object attachment status.
- fsconfig(2): remove pidns argument example, as it was kind of unclear
  and referenced kernel features not yet merged.
- fsconfig(2): remove rambling FSCONFIG_SET_PATH_EMPTY text (which
  mostly describes an academic issue that doesn't apply to any existing
  filesystem), and instead add a CAVEATS section which touches on the
  weird type behaviour of fsconfig(2).
- v2: <https://lore.kernel.org/r/20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>

Changes in v2:
- `make -R lint-man`. [Alejandro Colomar]
- `sed -i s|Glibc|glibc|g`. [Alejandro Colomar]
- `sed -i s|pathname|path|g` [Alejandro Colomar]
- Clean up macro usage, example code, and synopsis. [Alejandro Colomar]
- Try to use semantic newlines. [Alejandro Colomar]
- Make sure the usage of "filesystem context", "filesystem instance",
  and "mount object" are consistent. [Askar Safin]
- Avoid referring to these syscalls without an "at" suffix as "*at()
  syscalls". [Askar Safin]
- Use \% to avoid hyphenation of constants. [Askar Safin, G. Branden Robinson]
- Add a new subsection to mount_setattr(2) to describe the distinction
  between mount attributes and filesystem parameters.
- (Under protest) double-space-after-period formatted commit messages.
- v1: <https://lore.kernel.org/r/20250806-new-mount-api-v1-0-8678f56c6ee0@cyphar.com>

---
Aleksa Sarai (12):
      man/man2/statx.2: correctly document AT_NO_AUTOMOUNT
      man/man2/mount_setattr.2: fix stray quote in SYNOPSIS
      man/man2/mount_setattr.2: move mount_attr struct to mount_attr(2type)
      man/man2/fsopen.2: document "new" mount API
      man/man2/fspick.2: document "new" mount API
      man/man2/fsconfig.2: document "new" mount API
      man/man2/fsmount.2: document "new" mount API
      man/man2/move_mount.2: document "new" mount API
      man/man2/open_tree.2: document "new" mount API
      man/man2/mount_setattr.2: mirror opening sentence from fsopen(2)
      man/man2/open_tree{,_attr}.2: document new open_tree_attr() API
      man/man2/{fsconfig,mount_setattr}.2: add note about attribute-parameter distinction

 man/man2/fsconfig.2           | 681 ++++++++++++++++++++++++++++++++++++++++++
 man/man2/fsmount.2            | 220 ++++++++++++++
 man/man2/fsopen.2             | 384 ++++++++++++++++++++++++
 man/man2/fspick.2             | 309 +++++++++++++++++++
 man/man2/mount_setattr.2      |  62 +++-
 man/man2/move_mount.2         | 640 +++++++++++++++++++++++++++++++++++++++
 man/man2/open_tree.2          | 593 ++++++++++++++++++++++++++++++++++++
 man/man2/open_tree_attr.2     |   1 +
 man/man2/statx.2              |   6 +-
 man/man2type/mount_attr.2type |  61 ++++
 10 files changed, 2940 insertions(+), 17 deletions(-)
---
base-commit: e473affca7b039fd018eedb839d6c80e4fd3df17
change-id: 20250802-new-mount-api-436db984f432


Kind regards,
-- 
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/


