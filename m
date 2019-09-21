Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 721EBB9B4E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 02:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437478AbfIUATx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 20:19:53 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:37726 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437464AbfIUATw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 20:19:52 -0400
Received: by mail-vk1-f201.google.com with SMTP id f63so3451595vkf.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 17:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MYcfIKSKU50yEk2GBsBM2m5RiXljhL+2ZE7FFRNNMnA=;
        b=rYwL1vV9cAt6aW7K9UQ1TVv7Nis579iXiupkGlrJI5z1hBl5vWUe1ss1znAKVnTbtB
         SMKvA8N5qnF3S+ncfW7/2zlZrGFafD5oVhBy9vsu8P3mLLCWEjcjgc6EQJJEfD2JwVaP
         w7BO8yfXBiij6pLZQsbZTdY0iOqvQv5jzGk6XRZ+c8Lqf/6gYPE66QZjvcKApVeDqc0L
         ww9Sp4aoovE3lpLwl/WQ1l3THJquaMgBLszzK6JcU55vPYwK4rlvpxxUUtGGtCBaU4a8
         /DZg7vF11+JkeqazuvE5Qg3co4fNsX454Qm3YhNh7olmtf/8c974/6FV8CDzvwsuLetM
         6oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MYcfIKSKU50yEk2GBsBM2m5RiXljhL+2ZE7FFRNNMnA=;
        b=PW00dyoDbnaE0YnYxdCkanTujRf4NREltM2BSogXRJSmE6ccEO137FWI56JwLgpc5R
         HZR1/glUhn9Qmdkg9nXCjYqxt62rohd/nfBCHLWdO1rR5/3vF3jaX3UZE2xDCs/QsLWF
         dZZxlkfrksQIxenZ4v/5bNCkgb3GlEY2vZvX5CKckKj5yXnetJuOLE4nTk+OlZSh18ic
         YFWpt2M4uPaPrqIIlTZZZ9mmHP3CQp2o2Un9CRFNTsDlsngGjuj1aEqWlTQel1XHQVR7
         ikbPqqLbOIG2an7GjIMKJK4NRHdEwQiHq40CEgtO0+GuMsRioiYcnLQrKkOHrt5xpiHr
         18cA==
X-Gm-Message-State: APjAAAVkP2tUc9eni4kI+LLCeQ4hHmI6JILkOxPXvuG4NyL0nkLgaeGG
        otCpOA2Y40yg2XeRBjJDNaQKZL8LiZTErS2uj2y3yg==
X-Google-Smtp-Source: APXvYqzOx0clHQC670a6muPylspP6OHx1qxZmcK2LkXePQZnafFqCeM6G2+UolARC9Ywjom62MOYO4JFPeltIEhIgU6qyA==
X-Received: by 2002:ab0:2811:: with SMTP id w17mr3530779uap.111.1569025189180;
 Fri, 20 Sep 2019 17:19:49 -0700 (PDT)
Date:   Fri, 20 Sep 2019 17:18:52 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 16/19] MAINTAINERS: add entry for KUnit the unit testing framework
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
        Brendan Higgins <brendanhiggins@google.com>
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
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a50e97a63bc8..e3d0d184ae4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8802,6 +8802,17 @@ S:	Maintained
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
+F:	lib/kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.23.0.351.gc4317032e6-goog

