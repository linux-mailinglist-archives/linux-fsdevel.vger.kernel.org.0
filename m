Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1E416CAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 22:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfEGUwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 16:52:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52264 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfEGUwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 16:52:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hO74L-0000XP-6c; Tue, 07 May 2019 20:52:09 +0000
Date:   Tue, 7 May 2019 21:52:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git several struct file-related pieces
Message-ID: <20190507205209.GM23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	A bit more of "this fget() would be better off as fdget()"
whack-a-mole + a couple of ->f_count-related cleanups
	
The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.file

for you to fetch changes up to 3b85d3028e2a0f95a8425fbfa54a04056b7cbc91:

  media: switch to fdget() (2019-05-02 02:25:54 -0400)

----------------------------------------------------------------
Al Viro (4):
      don't open-code file_count()
      amdgpu: switch to fdget()
      drm_syncobj: switch to fdget()
      media: switch to fdget()

Lukas Bulwahn (1):
      fs: drop unused fput_atomic definition

 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 23 +++++++++++------------
 drivers/gpu/drm/drm_syncobj.c             | 13 ++++++-------
 drivers/gpu/drm/i915/i915_gem.c           |  2 +-
 drivers/media/media-request.c             | 16 ++++++++--------
 include/linux/fs.h                        |  1 -
 5 files changed, 26 insertions(+), 29 deletions(-)
