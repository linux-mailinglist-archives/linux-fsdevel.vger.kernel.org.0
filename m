Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96BC31421EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 04:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgATDWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 22:22:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgATDWz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 22:22:55 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 169FE20678;
        Mon, 20 Jan 2020 03:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579490574;
        bh=rwxJYZiONyiJT5R2boSa6GTk5OHlF/u2kz/yrQUtZ10=;
        h=From:To:Cc:Subject:Date:From;
        b=PIa5pvw9AK9Vdk/st8sssUVHH69dz6Mr5WD4j+G6MtXc2yHl8aHdYvBRN0QPzJyZx
         2lA6KO2tT+DFmCGG55T732OG9cy5A1/DV8r27o17QFNJHu2PBY7kzvtn7uhaUFvWeH
         i5z5Wmo27JfakP7qAIYwTWG9sjynEZBgwGv/SQC4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] bootconfig: tracing: Fix documentations of bootconfig and boot-time tracing
Date:   Mon, 20 Jan 2020 12:22:48 +0900
Message-Id: <157949056842.25888.12912764773767908046.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Here is the bootconfig and boot-time tracing documentation fix
and updates. These can be applied on the latest tracing tree.

Thanks for Randy about reporting and suggesting these fixes!

Thank you,

---

Masami Hiramatsu (3):
      bootconfig: Fix Kconfig help message for BOOT_CONFIG
      Documentation: bootconfig: Fix typos in bootconfig documentation
      Documentation: tracing: Fix typos in boot-time tracing documentation


 Documentation/admin-guide/bootconfig.rst |   32 ++++++++++++++++--------------
 Documentation/trace/boottime-trace.rst   |   18 ++++++++---------
 init/Kconfig                             |    4 +++-
 3 files changed, 29 insertions(+), 25 deletions(-)

--
Masami Hiramatsu <mhiramat@kernel.org>
