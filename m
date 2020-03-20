Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CDB18CB69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 11:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgCTKUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 06:20:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:54670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbgCTKUn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:20:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3FA44B310;
        Fri, 20 Mar 2020 10:20:41 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 8/8] MAINTAINERS: perf: Add pattern that matches ppc perf to the perf entry.
Date:   Fri, 20 Mar 2020 11:20:19 +0100
Message-Id: <4b150d01c60bd37705789200d9adee9f1c9b50ce.1584699455.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1584699455.git.msuchanek@suse.de>
References: <20200225173541.1549955-1-npiggin@gmail.com> <cover.1584699455.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While at it also simplify the existing perf patterns.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v10: new patch
V12: remove redundant entries
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1a99197fb34..578429d22220 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13080,7 +13080,7 @@ R:	Namhyung Kim <namhyung@kernel.org>
 L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
 S:	Supported
-F:	kernel/events/*
+F:	kernel/events/
 F:	include/linux/perf_event.h
 F:	include/uapi/linux/perf_event.h
 F:	arch/*/kernel/perf_event*.c
@@ -13088,8 +13088,8 @@ F:	arch/*/kernel/*/perf_event*.c
 F:	arch/*/kernel/*/*/perf_event*.c
 F:	arch/*/include/asm/perf_event.h
 F:	arch/*/kernel/perf_callchain.c
-F:	arch/*/events/*
-F:	arch/*/events/*/*
+F:	arch/*/events/
+F:	arch/*/perf/
 F:	tools/perf/
 
 PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
-- 
2.23.0

