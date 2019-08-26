Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A26CD9C7AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfHZDRH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfHZDRH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:17:07 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E07DC2168B;
        Mon, 26 Aug 2019 03:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789427;
        bh=8RzbIez3/gV7djsGVGljsi9n/uUzLTL1tlAOyhS3Cmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4wmwFNgY+/8VTmajXrij1vDg3ji9OW113jOcdKvDeoFTZK0H8LZjUbYRlxUmuUgS
         QWCCDwqoiQKrCS8MMJp2u6JBalwG0usrcfctdpz8RmPKtNYHfYiCstVAgTU9hVnuWe
         6L9+yk59t1szGt8FJaaqASqv1AbPf6RxZpQSTh2c=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
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
Subject: [RFC PATCH v3 07/19] tracing: Expose EXPORT_SYMBOL_GPL symbol
Date:   Mon, 26 Aug 2019 12:17:00 +0900
Message-Id: <156678942047.21459.8827037624340615081.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156678933823.21459.4100380582025186209.stgit@devnote2>
References: <156678933823.21459.4100380582025186209.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since ftrace_set_clr_event is already exported by EXPORT_SYMBOL_GPL,
it should not be static.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 22cf08bd2317..c2d38048edae 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -788,7 +788,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
+int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 {
 	char *event = NULL, *sub = NULL, *match;
 	int ret;

