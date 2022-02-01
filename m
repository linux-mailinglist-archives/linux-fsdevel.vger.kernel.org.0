Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F734A552F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 03:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiBACQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 21:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiBACQQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:16:16 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3246EC061714;
        Mon, 31 Jan 2022 18:16:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7C3881F43523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643681774;
        bh=nnCU5kmokcyqChMI03TfA0GFSnCfcPdwhMJd5kTg4QU=;
        h=From:To:Cc:Subject:Date:From;
        b=XNdrjiJeSnw3Uk2Dgg39I06+R+jsKcbHoEiMDk3sf3/Lc9dS/QxocW/S1+C3q81J7
         ic/mEVKN4C+zhI0DGLD8s7dsAhVZr9EXWdg2j1dpqmfnWLug2D5DfarVwBordywJ5d
         pojShSHYHU0lmysuaXsZJqrZ9d51GxF0oy2HOll7dLqBjtAKvbJd3Xc5qoFjCOAyQi
         a0XIblMyi7c8x5nJxM4oDOq66ArBBt/Lh/Lt8NTf/plbyPeSDvaqaZ8fsugBv1jDk2
         Yv1RfYdB18ndzDgyJftAR6onTvXjswYBdZngBLwIy6m/rm4YqJ2BZv44gBbvsaAJ1+
         Jc1KqKrzeP68A==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     hch@lst.de, chao@kernel.org, tytso@mit.edu,
        linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [GIT PULL] unicode patches for 5.17-rc3
Organization: Collabora
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Mon, 31 Jan 2022 21:16:11 -0500
Message-ID: <87czk7qql0.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 6661224e66f03706daea8e27714436851cf01731:

  Merge tag 'unicode-for-next-5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode (2022-01-17 05:40:02 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-for-next-5.17-rc3

for you to fetch changes up to 5298d4bfe80f6ae6ae2777bcd1357b0022d98573:

  unicode: clean up the Kconfig symbol confusion (2022-01-20 19:57:24 -0500)

----------------------------------------------------------------
Fix from Christoph Hellwig merging the CONFIG_UNICODE_UTF8_DATA into the
previous CONFIG_UNICODE.  It is -rc material since we don't want to
expose the former symbol on 5.17.

This has been living on linux-next for the past week.

----------------------------------------------------------------
Christoph Hellwig (1):
      unicode: clean up the Kconfig symbol confusion

 fs/Makefile         |  2 +-
 fs/ext4/ext4.h      | 14 +++++++-------
 fs/ext4/hash.c      |  2 +-
 fs/ext4/namei.c     | 12 ++++++------
 fs/ext4/super.c     | 10 +++++-----
 fs/ext4/sysfs.c     |  8 ++++----
 fs/f2fs/dir.c       | 10 +++++-----
 fs/f2fs/f2fs.h      |  2 +-
 fs/f2fs/hash.c      |  2 +-
 fs/f2fs/namei.c     |  4 ++--
 fs/f2fs/recovery.c  |  4 ++--
 fs/f2fs/super.c     | 10 +++++-----
 fs/f2fs/sysfs.c     | 10 +++++-----
 fs/libfs.c          | 10 +++++-----
 fs/unicode/Kconfig  | 18 +++++-------------
 fs/unicode/Makefile |  6 ++++--
 include/linux/fs.h  |  2 +-
 17 files changed, 60 insertions(+), 66 deletions(-)


-- 
Gabriel Krisman Bertazi
