Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835561100B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 01:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfEAXFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 19:05:08 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:53408 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfEAXFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 19:05:08 -0400
Received: by mail-yw1-f74.google.com with SMTP id v127so1087064ywb.20
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PRLXnvg3FnToIBJTwXVR7d2TK/MHZSW5pjHfdNwtr7Q=;
        b=K5TwnumODggM3WBroA2xjKir+Hf59I1szowVRTt0lzCy/25DKO4Auoy9KuasdBqFUu
         UWvBOKOTmtxVhAOl4er1T2140+nu1Bz+99TiGL9+yTK//z+jqboMkU5aijHYP0BbYsOh
         P/McaehM5toEAU772+pJGpQWNEZx5xhfrNPAJoKaW0IpWIVJaq0KjD8R8F3QXpB30i5m
         XrT04TmEJJAw/8yrNXA4XJeGyU/uVcdsIpKRYnl9kRb2X6reSvrGJiWqLpi2xAFDwIgz
         M+mClrFoRM5PxaczMRkZTVN0VXOBXS2l+ZY6dXc7xjKICM5LbtnpXVDT7unPYWdXqa7Y
         wpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PRLXnvg3FnToIBJTwXVR7d2TK/MHZSW5pjHfdNwtr7Q=;
        b=krOWYzfWY1/YOCkTBJ+8csNCZdFbrm9shDFANY0GD4jJFG4oi+TJ0IwEEAp5gto0KL
         OgyKXd+ok+O4ixkM4tQi3vv+N4D3tvUEyC7ysuPslN51oPobJooxVZOy8hN0tchYB2tN
         Sd0ByQ23Manfcf+q59a0YHyxewCp8wQRHLNhDC7NVJeZb+hH91yt2UUlu0GxcZEmrbSX
         +N2qWMwMTtSl/NWLt7+FK/K6yU2F2vzyRjk0SCHznCAJgGI2e59xgMerG4iAyu3slUdc
         tM+4qNZeSiIStv+WQe7RhNrBsKifSglQXzVBb5xbNrrsEChzT5na9jA6t5Ixmtfiq1PY
         j8sA==
X-Gm-Message-State: APjAAAUKTkM57hYnEncvE9s4/NlaTwWHhlSt/6cBX2G4BPpbiD8ey9cI
        eNzMhQHmrs1nz8ba/NKEOpBgyBOfAAXY8WPe04bJdw==
X-Google-Smtp-Source: APXvYqxSccXA/VUA/6JwG1W+T505ogTb6cCEY1XA3skvxQHV+dYiYJA75B70f0UwwhMZGG1vCcs3UYjo4MLfLh9fEqXVcw==
X-Received: by 2002:a25:aa87:: with SMTP id t7mr327533ybi.419.1556751907604;
 Wed, 01 May 2019 16:05:07 -0700 (PDT)
Date:   Wed,  1 May 2019 16:01:26 -0700
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Message-Id: <20190501230126.229218-18-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2 17/17] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
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

Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c78ae95c56b80..23cc97332c3d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12524,6 +12524,7 @@ S:	Maintained
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl.c
+F:	kernel/sysctl-test.c
 F:	tools/testing/selftests/sysctl/
 
 PS3 NETWORK SUPPORT
-- 
2.21.0.593.g511ec345e18-goog

