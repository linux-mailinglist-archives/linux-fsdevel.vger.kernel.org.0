Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7468A60C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 20:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfHLSZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 14:25:25 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:55448 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfHLSZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:25:25 -0400
Received: by mail-vs1-f74.google.com with SMTP id s72so1494821vss.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xF9O5bmycue+nV+5s3i5h7noHmCRlxc6YkqioFWCIGY=;
        b=gAMWQ0Rq8di8PJdodT5hlee8/JrnFuNFOn9CKpyZkYxConO+hEk83QI5D5n6+k+6i+
         j0b8I4ILhJznmcqU3rrbjs4jFGJOVI0aYBiq0akuO1nPcBMaWWmznfDoLTwhkyatCdEA
         c9YCcVql6VrKCVIbtdtdVUlkobrOu3R9UWzNO43ovANODpT48IxQkwpDo5jhYuvfRFsL
         IrapIf1i0x6MNbwEGnQ+3Au6uQnf5xQNefUPyKxDl8J0fJ3mJV/Y7aTsKcUmXRc87ISS
         XHXIdrXTomm9ohJ18ZDd64h92e/fcyzWZWHpYevEkb9YB6K2oK4ehj5IbdKdrEzicRYR
         VnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xF9O5bmycue+nV+5s3i5h7noHmCRlxc6YkqioFWCIGY=;
        b=g9pE6X0RmLrb2PFrx41jklBX8U78ci1z8A4HSQXiaPtRdvn6C3Sbyy6V0dEsh0Cnfn
         /Z0jCDeJZLjEaHu8a1Zet1ugPotn3MYq65keCueRBFPqRYvZ8OrjoAwvNkL19wsHHE4T
         jklywJKkiTpMc8Y0oVD8eNvzW9zYZk1TLl1HLfGmv8VrbA8Z08RVSc+4WpebJrHXq4/5
         Q0yC6SojxxR6/6U6Alshyktblohpn0hBlHLnOvczn7FfGan9fATO6vfuduCIf+hUQdc4
         3VvPeKWtTMr+3PX/Vm9MTthjRGMw+vS25C0ILJuvDByTCmIvv7tjGud4kM0xEu2HIxU4
         /oXw==
X-Gm-Message-State: APjAAAVla/b51DYZJvqs+RrNuQ6TYn/atCwpEo1iqC7FX1D1qlJgE681
        lsfrxu+APd057mhRzu1MjkE2Vx/0PWPPUjn9TCfYLQ==
X-Google-Smtp-Source: APXvYqyeAsoiYSIZDssjIlvbmVHHgRUhDoFimGkDtWsUy8Gxg5PQGoL+C6ai0yY+oGoXi0nylGBGvuiQ4FD5jyk1/IcLBg==
X-Received: by 2002:a67:c287:: with SMTP id k7mr6956688vsj.208.1565634323531;
 Mon, 12 Aug 2019 11:25:23 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:24:19 -0700
In-Reply-To: <20190812182421.141150-1-brendanhiggins@google.com>
Message-Id: <20190812182421.141150-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v12 16/18] MAINTAINERS: add entry for KUnit the unit testing framework
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
index a2c343ee3b2ca..f0bd77e8a8a2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8799,6 +8799,17 @@ S:	Maintained
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
2.23.0.rc1.153.gdeed80330f-goog

