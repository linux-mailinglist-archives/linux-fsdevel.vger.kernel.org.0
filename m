Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60CA363113
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 08:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfGIGf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 02:35:26 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:37093 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfGIGfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:35:25 -0400
Received: by mail-vs1-f73.google.com with SMTP id a23so2396607vsn.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2019 23:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
        b=roIBcnzOyuf7R7TQa9ICeWdOERx3mva+VzvJQPH4lvFXtGT2/kaulCrRX+DGEkUw/T
         gaABeFeoYW9kQskz3db7OFV4HNtBmflz65SgSe0g3j583a0QDkTeu2M2IjdseeWReTnu
         TrDqk9xeVzUpKevzfptZTPMjNp4o8paWwnEbaXlbexoDNJRrxmcbR2miDUSceJwAQzUW
         OiDTI1GoYe74vWRMGh+gPjiZUfCGJrbuUZWDUB/57YD3HaPckGPhr0n53ahltY5Y07gQ
         s2Up2b/gCSIufCs+LQW1UFhHY8rTODW6TNZCUXZVQWTlrhIMZnGwj30v9FExmKRPN9mD
         U6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
        b=meK92gcyplakIZjuatnai1UzJ6e5vr0hXSe/cH8VUN2Rc6f6Z6hCY9gKZmIwEhk0oy
         bq7kVRkpO4V0qrLMlsb6ibSMCaBttPTiujAbYwW7egpjHCIJmi8T3dThKANPmclOIGFf
         ELxjS9qLey9kr8ptRTo/72b+a4B/cvd5xxRztY4bLFVRkTSnWbmHba4BIDt/xs8LQK3C
         nP0y56A6eax6rguyKQOQswkY9ajNzX7mbb+c26QfMAOzuLqcPBFahu5WGyjioZO84cZM
         finwGAx/zOSWcj4HuUxdz0zfnN9RwBevM4Y0wc/yIhk1FMuz0BIM9gTjFmKl7TLEfT22
         94rA==
X-Gm-Message-State: APjAAAWknx0ZEbzCChY4wKpWozq1eWm0yovTgODgd/o4/EPxKViOus3I
        QNfIOttrytilz/6mT04/lba0kJea6dpylTqL5vveuA==
X-Google-Smtp-Source: APXvYqyN/Q4TgY2+UreLNPIzXV6CJf/oH33neEZZJhWC+fF5Pg7HwPEIjdljos5DJcFFXaYWCs5Nyn8SejyeztD2NxtvMw==
X-Received: by 2002:a1f:3244:: with SMTP id y65mr3749601vky.77.1562654124159;
 Mon, 08 Jul 2019 23:35:24 -0700 (PDT)
Date:   Mon,  8 Jul 2019 23:30:21 -0700
In-Reply-To: <20190709063023.251446-1-brendanhiggins@google.com>
Message-Id: <20190709063023.251446-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7 16/18] MAINTAINERS: add entry for KUnit the unit testing framework
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 677ef41cb012c..48d04d180a988 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8599,6 +8599,17 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	linux-kselftest@vger.kernel.org
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/dev-tools/kunit/
+F:	include/kunit/
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.22.0.410.gd8fdbe21b5-goog

