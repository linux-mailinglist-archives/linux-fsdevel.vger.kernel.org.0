Return-Path: <linux-fsdevel+bounces-3341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7247F3A14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 00:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9483E1F23123
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 23:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848DF56767;
	Tue, 21 Nov 2023 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4654BEF;
	Tue, 21 Nov 2023 23:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40055C433C7;
	Tue, 21 Nov 2023 23:10:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
	(envelope-from <rostedt@goodmis.org>)
	id 1r5Ztg-00000002dCq-1TWw;
	Tue, 21 Nov 2023 18:11:12 -0500
Message-ID: <20231121231003.516999942@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 21 Nov 2023 18:10:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/4] eventfs: Some more minor fixes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Mark Rutland reported some crashes from the latest eventfs updates.
This fixes most of them.

He still has one splat that he can trigger but I can not. Still looking
into that.


Steven Rostedt (Google) (4):
      eventfs: Use GFP_NOFS for allocation when eventfs_mutex is held
      eventfs: Move taking of inode_lock into dcache_dir_open_wrapper()
      eventfs: Do not allow NULL parent to eventfs_start_creating()
      eventfs: Make sure that parent->d_inode is locked in creating files/dirs

----
 fs/tracefs/event_inode.c | 24 ++++++++----------------
 fs/tracefs/inode.c       | 13 ++++---------
 2 files changed, 12 insertions(+), 25 deletions(-)

