Return-Path: <linux-fsdevel+bounces-62884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AD0BA41A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580331B24E54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CD41F560B;
	Fri, 26 Sep 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEsAgEjC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4700A1F3B96;
	Fri, 26 Sep 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896353; cv=none; b=BpATgW4xyzJXOcJGUBW7Y9BLVOouw6LqFFjmOyHQX91Q8oUMfpSK01weby3nHMrDMTIPM5lRqqGUbe1M3YCk2SN4Q00OPooFgTfVkXNaddeLiN9xZNe5ltOCvs4+3xjuym2rwpWXP5RLu+UdGdZM2xFh9NW2CCJxhwxIvmOfO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896353; c=relaxed/simple;
	bh=7eAb32lzdg5kcHibY18/XR/QfS9mak7v55u02GbNN94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8IuyOWecSJ3b5SB/2nhysxy9ocSUTkOwMynJUevhu4paFd9bfH5A8lKDO/xVKIAA0f0E/uY2lrXCze76fIeZXLUMkPz3JwjHedvRR9hvA4YzHCZUZ6+LevPMr7qAAveR55++yH/oMVO98pAtWWjdfJVwp5eIMuKDla5+USxX5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEsAgEjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57BBC4CEF4;
	Fri, 26 Sep 2025 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896351;
	bh=7eAb32lzdg5kcHibY18/XR/QfS9mak7v55u02GbNN94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEsAgEjCfVvgK8OFkkHMWS3UkINpnxyWK5IXUItNCSrjBbgAJLh41deoYHcHTx/7N
	 ePManyxxPt60U4cFP4lznt7GqUksIwvDz5DsqJIK9nK4lpvYM9frMoLs6WOvQ8OExK
	 lOSo4qgpgLkIJ4lAnE+wmBJ74iWqUkF+FbfT562VeLfUiMTDpmwD7SlKB/lkBCt1JW
	 2TkU01kTNheu/6BzxT5jMEb+0Y7kRiM4cTucCIW7kPu652U/JWvS/irh2bm3U0rijm
	 3zK2UW69AjKEmuD/NYiKmV5kMXQkOBeRCJ+o+BcVcjyNYweyCj3SvD8FrSLSBnVoIr
	 /NVJMTYAnCRcQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 05/12 for v6.18] pidfs
Date: Fri, 26 Sep 2025 16:18:59 +0200
Message-ID: <20250926-vfs-pidfs-3e8a52b6f08b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926-vfs-618-e880cf3b910f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=brauner@kernel.org; h=from:subject:message-id; bh=7eAb32lzdg5kcHibY18/XR/QfS9mak7v55u02GbNN94=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcW3Bh1aQqZcdcEZsTL7z8kicfik0VDPrxtzJ0Zcy9s 41XJr6T6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIzipGhus+ok6C36fIZuqV Z1mcyxQuE3vhNeFtG/Oz1+ZH9gZPqmNkuFq052vUT/HTgq2///5dlib1R0fh6eU824e2C3ctmal /lQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This just contains a few changes to pid_nr_ns() to make it more robust
and cleanups or improves a few users that ab- or misuse it currently.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.pidfs

for you to fetch changes up to da664c6db895f70c2be8c3dd371c273b6f8b920f:

  Merge patch series "Improve pid_nr_ns()" (2025-08-19 13:38:26 +0200)

Please consider pulling these changes from the signed vfs-6.18-rc1.pidfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.18-rc1.pidfs

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Improve pid_nr_ns()"

Oleg Nesterov (3):
      pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers
      pid: change bacct_add_tsk() to use task_ppid_nr_ns()
      pid: change task_state() to use task_ppid_nr_ns()

gaoxiang17 (1):
      pid: Add a judgment for ns null in pid_nr_ns

 fs/proc/array.c | 4 +---
 kernel/pid.c    | 5 +++--
 kernel/tsacct.c | 3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

