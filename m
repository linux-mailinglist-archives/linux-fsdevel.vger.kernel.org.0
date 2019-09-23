Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B42BB08F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 11:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439263AbfIWJDr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 05:03:47 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53226 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439243AbfIWJDp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:03:45 -0400
Received: by mail-pg1-f201.google.com with SMTP id e15so8906892pgh.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2019 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GL8bIr8dLG5/Kc/Y8WKLabBIaZO7WJH2uwuCEH7n76U=;
        b=IK3lUhPXkzXhSvQIu+QuD9wg5OjRhXIx6R/1B72oWK2uJ0Nc49oBemxVDpO6gZkWRz
         r5Q+L670bXmCW3zMVAf3oMGaNtrGBuzg9HJNjTzgL1sBfwbcKO118nwQm0rJpddQednM
         KpNWZzKb0DUsUERs4XdcPVCF/89zqyiQ+dnDkgvo5ltfnBmV+HvyblX09P4dgdQPw2u0
         17yNFekR+X0MNh7fo92DkFObENGEJcH0ryjhE0Bm0qQeRMUt17q/Uq7kMA2sQZjESqQ1
         RQ+yW4hX3SAZxma4mXg0sDXgS2AFiXtg1oGzOgnvsob1BdP2nTD+FIzUrQah22RLTY5F
         9YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GL8bIr8dLG5/Kc/Y8WKLabBIaZO7WJH2uwuCEH7n76U=;
        b=MABTicWJCi7/Xnwy0C8yoYpBbnEJifcXUkeAJjxMjHDRQeoBSdac89gcG7vmS6R10x
         RozNyfPnuS6ktpVDq32q6ymNASSXA/UwNTqUspRTg3Bavd2NvKcjyE/8CjHk5654D1jf
         mGZNNPr9b1ERZ89cwSJ+8i7SS7JtND3RxqRS7V68VL21hHWBQsm0csUeyxtcUwxYVZYd
         dLWHwsDcEji1A0S3wesE0fRwveESwoe8ceZR9QrPZp89r9dZOunbyfWYUYVpPOmFOG7V
         fi4NGi5iVdcfob6kQMqM72IlwQKK9blJtZcCsJRaHIv//dLQZwQNefRP8WNtqAIjYpUq
         XXYg==
X-Gm-Message-State: APjAAAUmXC2J6Xqa0+F7rRczevknXHWWgS07leQIbmiUxz0A+By8O98n
        46UE44jR4ChE/9w1yIlp90BcssQJ8tVykbYwtoBM3A==
X-Google-Smtp-Source: APXvYqxHEgGNTtObJUfhRvTo0FGBMpt3QEn24wQykdFVcS3XLsFIcn8xjDZXfPIdHz3/ajFW+XsHHvIjGJVlc4qOgSQ11Q==
X-Received: by 2002:a63:1a5a:: with SMTP id a26mr28561962pgm.178.1569229424351;
 Mon, 23 Sep 2019 02:03:44 -0700 (PDT)
Date:   Mon, 23 Sep 2019 02:02:48 -0700
In-Reply-To: <20190923090249.127984-1-brendanhiggins@google.com>
Message-Id: <20190923090249.127984-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v18 18/19] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section,
and add Iurii as a maintainer.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Iurii Zaikin <yzaikin@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3d0d184ae4e..6663d4accd36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12983,12 +12983,14 @@ F:	Documentation/filesystems/proc.txt
 PROC SYSCTL
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Kees Cook <keescook@chromium.org>
+M:	Iurii Zaikin <yzaikin@google.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl.c
+F:	kernel/sysctl-test.c
 F:	tools/testing/selftests/sysctl/
 
 PS3 NETWORK SUPPORT
-- 
2.23.0.351.gc4317032e6-goog

