Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23004226310
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgGTPOd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 11:14:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56880 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTPOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:14:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 50A1928B855
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Unicode patches for v5.9
Date:   Mon, 20 Jul 2020 11:14:28 -0400
Message-ID: <87blkap6az.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 9c94b39560c3a013de5886ea21ef1eaf21840cb9:

  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2020-04-05 10:54:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-next-v5.9

for you to fetch changes up to c055c978bebf14dda7e72d89d7ed9c867b2e6382:

  unicode: Replace HTTP links with HTTPS ones (2020-07-08 14:06:53 -0400)

----------------------------------------------------------------
fs/unicode patches for v5.9

This includes 3 patches for the unicode system for inclusion into
Linux v5.9:

  - A patch by Ricardo Cañuelo converting the unicode tests to kunit.

  - A patch from Gabriel exporting in sysfs the most recent utf-8
    version available.

  - A patch from Gabriel fixing the build of the kunit part as a module.

  - A patch from Alexander updating documentation web links.

----------------------------------------------------------------
Alexander A. Klimov (1):
      unicode: Replace HTTP links with HTTPS ones

Gabriel Krisman Bertazi (2):
      unicode: Expose available encodings in sysfs
      unicode: Allow building kunit test suite as a module

Ricardo Cañuelo (1):
      unicode: implement utf8 unit tests as a KUnit test suite.

 Documentation/ABI/testing/sysfs-fs-unicode  |   6 +
 fs/unicode/Kconfig                          |  19 ++-
 fs/unicode/Makefile                         |   2 +-
 fs/unicode/mkutf8data.c                     |   2 +-
 fs/unicode/utf8-core.c                      |  55 ++++++++
 fs/unicode/utf8-norm.c                      |   2 +-
 fs/unicode/{utf8-selftest.c => utf8-test.c} | 199 +++++++++++++---------------
 fs/unicode/utf8n.h                          |   4 +
 8 files changed, 175 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-unicode
 rename fs/unicode/{utf8-selftest.c => utf8-test.c} (60%)

-- 
Gabriel Krisman Bertazi
