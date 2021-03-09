Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E92133209D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 09:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCIIdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 03:33:12 -0500
Received: from foss.arm.com ([217.140.110.172]:49386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhCIIct (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:32:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32FEED6E;
        Tue,  9 Mar 2021 00:32:49 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCE853F71B;
        Tue,  9 Mar 2021 00:32:44 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] mm: some config cleanups
Date:   Tue,  9 Mar 2021 14:03:04 +0530
Message-Id: <1615278790-18053-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series contains config cleanup patches which reduces code duplication
across platforms and also improves maintainability. There is no functional
change intended with this series. This has been boot tested on arm64 but
only build tested on some other platforms.

This applies on 5.12-rc2

Cc: x86@kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-sh@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (6):
  mm: Generalize ARCH_HAS_CACHE_LINE_SIZE
  mm: Generalize SYS_SUPPORTS_HUGETLBFS (rename as ARCH_SUPPORTS_HUGETLBFS)
  mm: Generalize ARCH_ENABLE_MEMORY_[HOTPLUG|HOTREMOVE]
  mm: Drop redundant ARCH_ENABLE_[HUGEPAGE|THP]_MIGRATION
  mm: Drop redundant ARCH_ENABLE_SPLIT_PMD_PTLOCK
  mm: Drop redundant HAVE_ARCH_TRANSPARENT_HUGEPAGE

 arch/arc/Kconfig                       |  9 ++------
 arch/arm/Kconfig                       | 10 ++-------
 arch/arm64/Kconfig                     | 30 ++++++--------------------
 arch/ia64/Kconfig                      |  8 ++-----
 arch/mips/Kconfig                      |  6 +-----
 arch/parisc/Kconfig                    |  5 +----
 arch/powerpc/Kconfig                   | 11 ++--------
 arch/powerpc/platforms/Kconfig.cputype | 16 +++++---------
 arch/riscv/Kconfig                     |  5 +----
 arch/s390/Kconfig                      | 12 +++--------
 arch/sh/Kconfig                        |  7 +++---
 arch/sh/mm/Kconfig                     |  8 -------
 arch/x86/Kconfig                       | 29 ++++++-------------------
 fs/Kconfig                             |  5 ++++-
 mm/Kconfig                             |  9 ++++++++
 15 files changed, 48 insertions(+), 122 deletions(-)

-- 
2.20.1

