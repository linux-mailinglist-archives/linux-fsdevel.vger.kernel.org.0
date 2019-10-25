Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABBC6E4B29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 14:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440232AbfJYMdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 08:33:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43893 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfJYMdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:33:05 -0400
Received: from [185.240.52.243] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iNym8-0007oa-Dt; Fri, 25 Oct 2019 12:33:04 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        fweimer@redhat.com
Cc:     jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com,
        tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [REVIEW PATCH v5 0/3] close_range()
Date:   Fri, 25 Oct 2019 14:28:48 +0200
Message-Id: <20191025122851.30182-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

I've recently been pinged by quite a few people about the state of the
close_range() patchset. I've been sitting on this for a while because
other stuff came up. Last time it was considered to be in mergeable
state and I plan to send it for v5.5 since quite a bunch of projects in
userspace have expressed interest in using this including Python and
systemd.

I've also coordinated with some FreeBSD developers who got in touch with
me. FreeBSD has expressed interest in adding the same syscall once we
merged it.

This is a resend of the close_range() patchset (cf. [1]). I'd like to
target v5.5.

[1]: https://lwn.net/Articles/789023/

Thanks!
Christian

Christian Brauner (3):
  open: add close_range()
  arch: wire-up close_range()
  tests: add close_range() tests

 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 fs/file.c                                     |  62 +++++++-
 fs/open.c                                     |  20 +++
 include/linux/fdtable.h                       |   2 +
 include/linux/syscalls.h                      |   2 +
 include/uapi/asm-generic/unistd.h             |   4 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/core/.gitignore       |   1 +
 tools/testing/selftests/core/Makefile         |   7 +
 .../testing/selftests/core/close_range_test.c | 149 ++++++++++++++++++
 27 files changed, 258 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/core/.gitignore
 create mode 100644 tools/testing/selftests/core/Makefile
 create mode 100644 tools/testing/selftests/core/close_range_test.c

-- 
2.23.0

