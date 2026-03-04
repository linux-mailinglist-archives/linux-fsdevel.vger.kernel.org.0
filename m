Return-Path: <linux-fsdevel+bounces-79301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGxEEsx4p2kshwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 01:11:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B19F21F8C19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 01:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0645F3002795
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 00:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709311ACEDE;
	Wed,  4 Mar 2026 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhRD4nXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C111339A4
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583068; cv=none; b=X9iOWLkB5df8VdGspXiR/BUs0OwnZhJyXzh/WWbzS/yICummrHsU2fxjE7h2mLW6S9087AFU73AQ7FBzSmWHkHfHKnIDmVHSDSnQS8xkr/2OeeuXrN0y/tLfrhlJaeB9AiFPryEGh3gP1uPN690bH2TA/KWLkC8D4Q3JR9Gsgc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583068; c=relaxed/simple;
	bh=vxuKa56hx0dy22zNYtgkGdAy8LJn7W/SH+7/86ijiAc=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=sq3kKwgmHUxeTpmXHxwxv+dvLPwMvcJf7EPTI3sI+yLMQL+DfXwIc5Zj23bgaM4vSGUy07ucPFjJ735abG2Lj0bWPom0/4KLFtgXZb0bTdPWq9ONFYIxt55UQuwlcOOPL7aFf6EvEA8DQCaD4xTd//eZQfRxpvMQxqlIYFnR/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhRD4nXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88508C116C6;
	Wed,  4 Mar 2026 00:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772583067;
	bh=vxuKa56hx0dy22zNYtgkGdAy8LJn7W/SH+7/86ijiAc=;
	h=Date:Subject:From:To:Cc:From;
	b=lhRD4nXAXhBHUpe4Wv+zuB3G06xvY2RvSZT0q2DG2gjNJJf/ZNNWuS4cQPmiE9KbR
	 YkM3VUYp7TKwYEFnI/6ekkWCxp0o67epdMJ9Am1olc1vDXg/4fF9kOBz3RXZatD9GA
	 OtkLmJfMSwiat/t4Jh+35ovnrPrjDCeaTjUhR1XnjrnktWSKQ4QxMwzUrXMNXD84lk
	 TbgWh/LVJY9tcH8TPVs5eY6cSYpjCXJFA5lAjWlrvdHj2M25xLmlNH0AoVCBfzPzmL
	 euQ+FVR25WeIM6XFYxEXPIaY8nNu09cR1Ifmwx0qrm4XeqWSzsscNnncKxjRpZ7SvW
	 sdYYDK7jAIwoA==
Date: Tue, 03 Mar 2026 16:11:07 -0800
Subject: [GIT PULL] libfuse: run fuse servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: bernd@bsbernd.com, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <177258294351.1167732.4543535509077707738.stg-ugh@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B19F21F8C19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,gmail.com,vger.kernel.org,szeredi.hu,gompa.dev];
	TAGGED_FROM(0.00)[bounces-79301-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Bernd,

Please pull this branch with changes for libfuse.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 73db1b26a4c759ecf6cfce495d8be85d5e5085f4:

fix: add assert to prevent NULL pointer dereference in try_get_path (2026-03-03 15:39:48 +0100)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container-3.19_2026-03-03

for you to fetch changes up to d686733ac24a50e957cfd1117cc3315cce510bf3:

example/service_ll: create a sample systemd service fuse server (2026-03-03 15:41:58 -0800)

----------------------------------------------------------------
libfuse: run fuse servers as a contained service [v8]

This patchset defines the necessary communication protocols and library
code so that users can mount fuse servers that run in unprivileged
systemd service containers.  That in turn allows unprivileged untrusted
mounts, because the worst that can happen is that a malicious image
crashes the fuse server and the mount dies, instead of corrupting the
kernel.

Bernd indicated that he might be interested in looking at the fuse
system service containment patches sooner than later, so I've separated
them from the iomap stuff and here we are.  With this patchset, we can
at least shift fuse servers to contained systemd services, albeit
without any of the performance improvements of iomap.

With a bit of luck, this should all go splendidly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (3):
libfuse: add systemd/inetd socket service mounting helper
libfuse: integrate fuse services into mount.fuse3
example/service_ll: create a sample systemd service fuse server

include/fuse_service.h       |  180 +++++++
include/fuse_service_priv.h  |  118 +++++
lib/fuse_i.h                 |    5 +
util/mount_service.h         |   41 ++
doc/fuservicemount3.8        |   32 ++
doc/meson.build              |    3 +
example/meson.build          |    7 +
example/service_ll.c         |  823 ++++++++++++++++++++++++++++++++
example/service_ll.socket.in |   16 +
example/service_ll@.service  |   99 ++++
include/meson.build          |    4 +
lib/fuse_service.c           |  859 ++++++++++++++++++++++++++++++++++
lib/fuse_service_stub.c      |   91 ++++
lib/fuse_versionscript       |   15 +
lib/helper.c                 |   53 +++
lib/meson.build              |   14 +-
lib/mount.c                  |   57 ++-
meson.build                  |   37 ++
meson_options.txt            |    6 +
util/fuservicemount.c        |   66 +++
util/meson.build             |   13 +-
util/mount.fuse.c            |   58 ++-
util/mount_service.c         | 1056 ++++++++++++++++++++++++++++++++++++++++++
23 files changed, 3617 insertions(+), 36 deletions(-)
create mode 100644 include/fuse_service.h
create mode 100644 include/fuse_service_priv.h
create mode 100644 util/mount_service.h
create mode 100644 doc/fuservicemount3.8
create mode 100644 example/service_ll.c
create mode 100644 example/service_ll.socket.in
create mode 100644 example/service_ll@.service
create mode 100644 lib/fuse_service.c
create mode 100644 lib/fuse_service_stub.c
create mode 100644 util/fuservicemount.c
create mode 100644 util/mount_service.c


