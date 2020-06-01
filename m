Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF11E9E4B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 08:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgFAGbw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 02:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgFAGbw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:31:52 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B1612074B;
        Mon,  1 Jun 2020 06:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590993111;
        bh=zAUnY41Sgc7xpNLHu9M0CHlSS/dkDaYIV+HRhlmWnpY=;
        h=Date:From:To:Cc:Subject:From;
        b=CSFPCFQ3+RJAVJDO4ksMLGmjHP29cVIclWcjuK6+F4Ot2xJRz4+VzIz7cME+w5T/k
         XKMGsKBtOlf3e9DVbH1EixVTg6hzJY4FtRDZP/N1ybdBVTd9ZqER4G6mJR6DHs9xlo
         hFDZw+49i6TGMILwmJq3J6QlRd/w3rKhBecJHFjI=
Date:   Sun, 31 May 2020 23:31:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fsverity updates for 5.8
Message-ID: <20200601063150.GB11054@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to 9cd6b593cfc9eaa476c9a3fa768b08bca73213d0:

  fs-verity: remove unnecessary extern keywords (2020-05-12 16:44:00 -0700)

----------------------------------------------------------------

Fix kerneldoc warnings and some coding style inconsistencies.
This mirrors the similar cleanups being done in fs/crypto/.

----------------------------------------------------------------
Eric Biggers (2):
      fs-verity: fix all kerneldoc warnings
      fs-verity: remove unnecessary extern keywords

 fs/verity/enable.c           |  2 ++
 fs/verity/fsverity_private.h |  4 ++--
 fs/verity/measure.c          |  2 ++
 fs/verity/open.c             |  1 +
 fs/verity/signature.c        |  3 +++
 fs/verity/verify.c           |  3 +++
 include/linux/fsverity.h     | 19 +++++++++++--------
 7 files changed, 24 insertions(+), 10 deletions(-)
