Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D534660E8F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 05:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGFDDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 23:03:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49182 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGFDDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 23:03:41 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hjazD-0001H5-9d; Sat, 06 Jul 2019 03:03:39 +0000
Date:   Sat, 6 Jul 2019 04:03:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] fix bogus default y in Kconfig (VALIDATE_FS_PARSER)
Message-ID: <20190706030339.GN17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	That thing should not be turned on by default, especially since
it's not quiet in case it finds no problems.  Geert has sent the obvious
fix quite a few times, but it fell through the cracks.

The following changes since commit 570d7a98e7d6d5d8706d94ffd2d40adeaa318332:

  vfs: move_mount: reject moving kernel internal mounts (2019-07-01 10:46:36 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 75f2d86b20bf6aec0392d6dd2ae3ffff26d2ae0e:

  fs: VALIDATE_FS_PARSER should default to n (2019-07-05 11:22:11 -0400)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      fs: VALIDATE_FS_PARSER should default to n

 fs/Kconfig | 1 -
 1 file changed, 1 deletion(-)
