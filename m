Return-Path: <linux-fsdevel+bounces-62933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CAFBA5EC9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 14:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4159A3BDF0C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 12:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146502BE655;
	Sat, 27 Sep 2025 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIdW4hqV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE51F541E;
	Sat, 27 Sep 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758975556; cv=none; b=QBcL2pUSMF6JBNIS+KDgp21vAoeftlq1MoYms8dTtPOtnPNWUUBrYUeZqhlw9uFf2O7pp+2Xcbpv9mHhpZJ4vkW13icDYb/0hs/MjKdeIG3sJKmZhxVpizdFrqFLX2t3AcYuHWxJ5577kLY1Xm55rEHfVnhbbcHUwxuePB1g8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758975556; c=relaxed/simple;
	bh=T18AFQPV0MqC4eP1QNbHAm7Tj9EiTL+jqR5RzMVcfw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqaJ718dMAC6OKXJ0qpw1Sa6+g/Uia/P/h9T3NwiO3PdGyd7WdOCfp7pqk/V7LqkMs+IfwRp2Qh+WGohnxminHMmY82bGgHPbChRD7wbmdLvWPd2chmBQGo1Gr0otfD4RHTYE0nWdCfxS3MoFedcndYV0twPftFe3t49sa5ChjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIdW4hqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC5BC4CEE7;
	Sat, 27 Sep 2025 12:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758975553;
	bh=T18AFQPV0MqC4eP1QNbHAm7Tj9EiTL+jqR5RzMVcfw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIdW4hqV7deZSJ9rbd4yBnHD/YIUHeDqqp12+mc6a3zvGxd/BufovKwvgW2MNiWxU
	 4D9VR+PDpyu9uglrODOzF8Qut+YBrrNZbRaLv4QSkl9L3bFCJNzO578Cd7C6uz6IGh
	 kv1m/6k7kJ3Gi1hpF4Shyd11qycDIxNapKhY9LX9bJkUapWbK0zH2TJea7rk9VLsmE
	 fwoigjdjzA2VnhrklQTlxPJZpaWbj19UAx+e8oMF7RQaDtSeYxKYoVgw19XB+WJJ6u
	 aLjbaMP7MoNo8A3zNnY8pX9Ge+/an1tBl7ZOXHE909c42qNwmEUCj+ebd5HyZY/4rl
	 laR/YGLkTF5LQ==
Date: Sat, 27 Sep 2025 08:19:12 -0400
From: Sasha Levin <sashal@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 08/12 for v6.18] core kernel
Message-ID: <aNfWQL6nLBrPNQTs@laps>
References: <20250926-vfs-618-e880cf3b910f@brauner>
 <20250926-vfs-core-kernel-eab0f97f9342@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926-vfs-core-kernel-eab0f97f9342@brauner>

On Fri, Sep 26, 2025 at 04:19:02PM +0200, Christian Brauner wrote:
>Hey Linus,
>
>/* Testing */
>This contains the changes to enable support for clone3() on nios2 which
>apparently is still a thing. The more exciting part of this is that it
>cleans up the inconsistency in how the 64-bit flag argument is passed
>from copy_process() into the various other copy_*() helpers.
>
>gcc (Debian 14.2.0-19) 14.2.0
>Debian clang version 19.1.7 (3+b1)
>
>No build failures or warnings were observed.
>
>/* Conflicts */
>
>Merge conflicts with mainline
>=============================
>
>No known conflicts.
>
>Merge conflicts with other trees
>================================
>
>No known conflicts.
>
>The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
>
>  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>
>are available in the Git repository at:
>
>  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.18-rc1.clone3

Hi Christian,

After pulling this tag, I started seeing a build failure.

a9769a5b9878 ("rv: Add support for LTL monitors") which was merged a few weeks
ago added a usage of task_newtask:

	static void handle_task_newtask(void *data, struct task_struct *task, unsigned long flags)

But commit edd3cb05c00a ("copy_process: pass clone_flags as u64 across
calltree") from this pull request modified the signature without updating rv.

./include/rv/ltl_monitor.h: In function ‘ltl_monitor_init’:
./include/rv/ltl_monitor.h:75:51: error: passing argument 1 of ‘check_trace_callback_type_task_newtask’ from incompatible pointer type [-Wincompatible-pointer-types]
    75 |         rv_attach_trace_probe(name, task_newtask, handle_task_newtask);
       |                                                   ^~~~~~~~~~~~~~~~~~~
       |                                                   |
       |                                                   void (*)(void *, struct task_struct *, long unsigned int)
./include/rv/instrumentation.h:18:48: note: in definition of macro ‘rv_attach_trace_probe’
    18 |                 check_trace_callback_type_##tp(rv_handler);                             \
       |                                                ^~~~~~~~~~

I've fixed it up by simply:

diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 67031a774e3d3..5368cf5fd623e 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -56,7 +56,7 @@ static void ltl_task_init(struct task_struct *task, bool task_creation)
         ltl_atoms_fetch(task, mon);
  }
  
-static void handle_task_newtask(void *data, struct task_struct *task, unsigned long flags)
+static void handle_task_newtask(void *data, struct task_struct *task, u64 flags)
  {
         ltl_task_init(task, true);
  }

-- 
Thanks,
Sasha

