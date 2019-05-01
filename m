Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5C91101A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 01:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfEAXFW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 19:05:22 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:32791 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfEAXFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 19:05:03 -0400
Received: by mail-qt1-f201.google.com with SMTP id n39so380428qtn.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 16:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=afBg8MXFYLPd4ElKfFZ/trSYMLXMP5LFZoVsy/mQzmY=;
        b=PS4XqgmjxFmmLNG4a7+Yce39oWOBnGeJYietXRtGGHG0s3tkKrTLVv7t3JuVJrcTc1
         KutFoAYJImIE74KhH7bcdjYmLxEqwrGbPqelhF2X00dTLnac17nc5IPrwiXTTicbz2f9
         yHnW72a+93CtmfTKR5QnGRSzt8et/Ly4ZcAVMfSHn+SCxSXzw1zkw1nB3vFldf3GmDRW
         V4jWuf1z1oJKJ/mTHNywIeCyEt6ToYpE7TZ6xlVusdVzZZyPSGv5HNpNNowdGSJw2egz
         dfdafxGTQxLWVkGcavQ+2Y+ar4k87+QhgoKGq5GA6P9r8ZHVHqdJk/unxr+39pqN5T9x
         Di2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=afBg8MXFYLPd4ElKfFZ/trSYMLXMP5LFZoVsy/mQzmY=;
        b=eyRTg0RN90afvgyrXpuxCeAx/aBkdHopylGXhCByDOuWjr/VI1qZEAIQNj771PKsey
         jADDL2xMRQsSKclatseUAsBww9LUFuBYT4MRR3XlFi0Dzp2z1dvzwyvkCSTYH92pyvIw
         Po0LOv1K8aszDQcmLnqBq4VAWbFFdtddv/dwAEcRIkzTcfWorNHxmp7HFW+jT1u4HFyy
         etElkv1n72g0ogcRZfTNzkucegemtojvEgGOEjzWRhpQSL5cuyyPwL8JZcha0LYe1KN6
         6gSwdDjKdZbGRWnRqHt/YroeBZVCC9R16J/uaggUzzjpRNTxHkszXeeB0RCDZ1k0EeIs
         U2WQ==
X-Gm-Message-State: APjAAAXdgsi0iBxqth6YRHZI6g4KQTT0hu2I9b6K+FDon1SA2XgVzX1d
        B1UKXfI12UXQOY2a9FLb07RzJ5tMVlSHBZYf+85jNg==
X-Google-Smtp-Source: APXvYqyrbTtQWB061i/IuTmGR1fZJktprQX+nOIOp8d1N9azYCgnL4QkQ8IwHRr2AUs5hUUYn4R+op23q7+ENLYHRpSNog==
X-Received: by 2002:ad4:5365:: with SMTP id e5mr604591qvv.197.1556751902442;
 Wed, 01 May 2019 16:05:02 -0700 (PDT)
Date:   Wed,  1 May 2019 16:01:24 -0700
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Message-Id: <20190501230126.229218-16-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2 15/17] MAINTAINERS: add entry for KUnit the unit testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c38f21aee787..c78ae95c56b80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8448,6 +8448,16 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/kunit/
+F:	include/kunit/
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.21.0.593.g511ec345e18-goog

