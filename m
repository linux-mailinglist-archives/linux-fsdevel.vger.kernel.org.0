Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EDA3FCB7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbhHaQYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 12:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239964AbhHaQYv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:24:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD886610CC;
        Tue, 31 Aug 2021 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630427036;
        bh=3CBp1rvnjRLq+ik6Z1JLX8BGifdRSVjyPCQ/sJLco80=;
        h=Date:From:To:Cc:Subject:From;
        b=GJDt8FZiuX6BwPq8ZneIBQYR7/55jsZG3CALHsYjMPVq62nclr45gyns+NNlAa8Qq
         tnSATmOv1NJ9M+ylEXUMCGciXq5sWAQX3qXP6SO6VsImSo3KAAh/8V3YLRd6efOylv
         TBNZU3nIi9Xk94jVOmVqByqQ8nOiWAVqXgEu3e0t4VnTa6M46N8nzidH7sDzGxlnun
         TTGkZicia1PDQA+cECjev18ns/N1BhkJATV7IlUkK5m/VFQ1W5Rh39+vTzR2WbVxSQ
         7dPlBOIE3YAY6M+R6iG2Jqgv2ToDR8g15q+YgogsjBR2rSEhP4Us6nqGi9yv+2Q0Nn
         NMlL3Y+mRJeMg==
Date:   Tue, 31 Aug 2021 09:23:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wang Shilong <wangshilong1991@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Wang Shilong <wshilong@ddn.com>
Subject: [GIT PULL] vfs: new code for 5.15
Message-ID: <20210831162355.GA9959@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this single VFS patch that prevents userspace from setting
project quota ids on files that the VFS considers invalid.

This branch merges cleanly against your upstream branch as of a few
minutes ago, and does not introduce any fstests regressions for ext4 or
xfs.

--D

The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.15-merge-1

for you to fetch changes up to d03ef4daf33a33da8d7c397102fff8ae87d04a93:

  fs: forbid invalid project ID (2021-08-03 09:48:04 -0700)

----------------------------------------------------------------
New code for 5.15:
 - Strengthen parameter checking for project quota ids.

----------------------------------------------------------------
Wang Shilong (1):
      fs: forbid invalid project ID

 fs/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)
