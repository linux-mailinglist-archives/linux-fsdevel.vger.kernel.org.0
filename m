Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4601264242
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 09:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfGJHRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 03:17:05 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33421 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfGJHRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:17:05 -0400
Received: by mail-pg1-f201.google.com with SMTP id c5so931512pgq.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 00:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LDQmGV1sXKMjUeOhPKTnD5bP1+GpH11oHwNBh3L4XLs=;
        b=SWzxZhZeLl9B3ZN7KUpRnolnKVc0OJkXJr8qwulUb9s67eZjf6r3kc2Ogx/J6NFBmy
         uqmVFD7ak9Qf8Uo8aXEIMGv7YGtgPRuHX+xSuxQCpHpu8vO6QWhPhnFk65OLmSU98Mo+
         abndx4F4lNunK2LAN8X5bdTYvCw0G/l5uts0dKuU3ZLpu8KxF7vnPevzWZqEjMu7PyE6
         VfeMLPMw4Y1TpnuCapjefj7vkaiOpHNz5UIbiIVdL+S7PfmVCxTs5cgeeOlAwMRo0y8X
         qh0rs5Mg9wZHPZxBzOCF9AroydvmP+xOktJ7l+4j5selLe+O3LHZFGlyYirSiQEquBlu
         n+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LDQmGV1sXKMjUeOhPKTnD5bP1+GpH11oHwNBh3L4XLs=;
        b=EGRF0r19az4pQ4N0yeMxgoZZjKUx0+ghExkJhE8R7k+Gx2LdT4+d5IftwjQ4kzU2e7
         C7vki29ETnpVmnkOkUrgKvMtk0KcWTt2qm7BzmGHa2yZqeqTgPTXxiEvcb2oAFF5cxzU
         2zUPomJQIgx2AUPvodnr6L2a55oWjL/Ksv2JbbpaxCojAzIn/ktuqUsiLneQhD3DSgbX
         6wYFNKu6Rmjfcok3nixfrQwWMSo/nCWMzhckRnl9PA6gKu1X1uPBczZ+kUigT9CbWV0a
         b4ZnoVv10zK1racUE68gi2dYP72DbQd5VsQiWeohfa0+Y9LxVURi543eY2GJzowvDgx4
         eBpw==
X-Gm-Message-State: APjAAAXhiMfaivvlEHtDGD8qEZIUKLkdrenI46mMM7wbsSNVv1vWdlHH
        3dThFadWYHgTUu2cSvLJ23t4MZKKn7v3xGDJXdBuOQ==
X-Google-Smtp-Source: APXvYqwlEXuLFBHdrrK58SUL+5pvcKzBeJ5OszOrbsQfgRsSasvNDQkhx5yemg7ePksEVTpnjPnL52tUKDt89i4lgsAB3w==
X-Received: by 2002:a63:ad07:: with SMTP id g7mr33234528pgf.405.1562743023620;
 Wed, 10 Jul 2019 00:17:03 -0700 (PDT)
Date:   Wed, 10 Jul 2019 00:15:08 -0700
In-Reply-To: <20190710071508.173491-1-brendanhiggins@google.com>
Message-Id: <20190710071508.173491-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190710071508.173491-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v8 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>,
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
index 48d04d180a988..f8204c75114da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12721,12 +12721,14 @@ F:	Documentation/filesystems/proc.txt
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
2.22.0.410.gd8fdbe21b5-goog

