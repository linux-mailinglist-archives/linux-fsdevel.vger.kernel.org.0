Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E2096D7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 01:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfHTXVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 19:21:47 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:36528 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfHTXVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:21:46 -0400
Received: by mail-pl1-f202.google.com with SMTP id a5so277294pla.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 16:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wKRiEgRg+/DU2DEnW3JXAo2ALm03Zt5EFSXAgxYeqSQ=;
        b=BFgC57EX5wNdOQeCPRvrkh94WwexKb08vmyjsrJYYbSvIPMVtFNt0v7lMY+yRZgSz5
         oipoLw5Xfl6v4PwsrckLZfwZgE+j41FjO9gfguvyeEoWUjr80Lp1xi4tWE7l3R9tPISY
         eDySOP8l0zqaHCiVre3eM0d83K8JTZAmnC7SAVBFQ1zcNvupC/ftjS4ePbli9gfQHh+S
         onygslKzC00E5mdUOcPr6G94dCN68feD11yxMzgKCuJmp4lHBeeZynaVoyNM8JGrzQ6m
         Jll+36t+qhbi/zn7MTmSl2mo18NrRtJTZxG0GKBzOcDk/wstf4agP9aE9EebO0R21bYD
         RepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wKRiEgRg+/DU2DEnW3JXAo2ALm03Zt5EFSXAgxYeqSQ=;
        b=UXdZMvoWckurrrcf2KU30wbFBZaKbu1DngbYm9LusFEAb5osn1aVSy73ps1bS5BHQf
         ykaVUNiL+tFAAp6V2TXcwHo5WzXuT+Ekd4vPvD7Wt+tpIPRW5+MBr9a1kRN6lWcR9lmR
         iHqOETPGThBpzQURMZM4efsDZSEc0tVNZ7Z4bsZD/4VExfyYGa50XjTfGiUbXb1oidkC
         qd79FTFgcNvvfd/wavLtxGyS9ncAa+8aQRB4OhcQ1iYXwuDvFC/ODHpJdro7wq9hu+Ry
         +/VYxumXKO9ajr/lUX3tuLhLCUkn72qhA+R1+sTsFY+5AiUPOUsylXMgVOcTR7Xepc0E
         uK/w==
X-Gm-Message-State: APjAAAUebxsscN1QexNprI6+x/GtQ6Qkc5/VEHDAlSci9JbMx2lty8C9
        JZBJoOIQr4lkwsgsX9brDLnhqljtHEfFcNbmCWaYGw==
X-Google-Smtp-Source: APXvYqxEgOhZD3PGSn1+kT2I99YeG1HucF3rfBzgNXbSwxMoFoKzl7eYRx6lZPZGhCgAiM9akAkguErs7fj6mhP+rzIR0Q==
X-Received: by 2002:a63:4042:: with SMTP id n63mr16008379pga.75.1566343304518;
 Tue, 20 Aug 2019 16:21:44 -0700 (PDT)
Date:   Tue, 20 Aug 2019 16:20:46 -0700
In-Reply-To: <20190820232046.50175-1-brendanhiggins@google.com>
Message-Id: <20190820232046.50175-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190820232046.50175-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v14 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
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
index f0bd77e8a8a2f..0cac78807137b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12965,12 +12965,14 @@ F:	Documentation/filesystems/proc.txt
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
2.23.0.rc1.153.gdeed80330f-goog

