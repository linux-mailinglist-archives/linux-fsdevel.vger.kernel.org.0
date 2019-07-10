Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB26423B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 09:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfGJHRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 03:17:02 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47440 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfGJHQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:16:59 -0400
Received: by mail-pf1-f201.google.com with SMTP id f25so830210pfk.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 00:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
        b=BlZBqRR1qRdimox75W2P/i8C72pSin2IGTFtfmWWoBCvv+dsuvBdZ3/5aEpQ89PXk2
         HuskMyBFp2JqOQVUUEK0hsAQ0kjZkM8S/FywQuU6p0ypQLPCs+6NoLDj1kq51PvEuYF5
         qrdgV1mMDoflgBNJCXAcSwSGNYJkMOXfQvDOfH0JYLVQXGZ1i6UKi+51vZvxngVYRCqi
         zUJQpdHTuvjJ6rn5moXv9JrV9XiIipdlgDqKiR4V1XRaP/xyAV9wQ3bDfUgimZ4sWrJO
         BOrrvDOkdcB9a2+X4Dl7x+F0dFrJO/wdly+nhX3UZItJ2/G7J+HtrefxGaobvJsGaO8S
         dzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
        b=PlLQwf4PjglBpyZVGv1kNelnu7DJJVUmatENyyXdktXQ9RKJQqYY8DFD6NKC5nwowH
         DjxeO2jAU4dK6u00wZU9VWUUNVfjs2DQAcsm/IhsHu7I5/0/PwA4i0QTZMdHnTTD3utk
         J/dul4xB2RbPyXn12DagFiEde6bkaK0klsDrwvx0TBRz6JArRONOulHDqHEJK/9j1/PL
         uf+L/W7+ZlY/bcG4Cxr9AIYBJcfCxSJQ2nEZ50hmeTx2L4CZOoxCD4PaWs/hrJvOHoe/
         0LW3Gk7nLM/uhE9HYtI01ALytZsMswPN8YCMypCHDhK5CAXhZEA7q9stKvQV/XnEc7c8
         ge2A==
X-Gm-Message-State: APjAAAV6XZPUpwclIX2/wccHv5tRA6lR5bDjDwUrOLTo8S84PSYKLWt3
        c0376pxzzTcKZ6mP45Q4cOWeGsfetitMflrNS01edg==
X-Google-Smtp-Source: APXvYqy3gEnvLtzenDeoBpvruwM86/d4R4MSA4rfrSkFPoe3MSdS+t35zDjs7EFvAtglaLFEtGooue6BA3jgPd6GRUh5Fg==
X-Received: by 2002:a63:d0:: with SMTP id 199mr35409907pga.85.1562743018345;
 Wed, 10 Jul 2019 00:16:58 -0700 (PDT)
Date:   Wed, 10 Jul 2019 00:15:06 -0700
In-Reply-To: <20190710071508.173491-1-brendanhiggins@google.com>
Message-Id: <20190710071508.173491-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190710071508.173491-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v8 16/18] MAINTAINERS: add entry for KUnit the unit testing framework
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

