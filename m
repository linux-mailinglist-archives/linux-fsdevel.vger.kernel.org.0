Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62BBA1C272
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 07:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfENFqm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 01:46:42 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:39407 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfENFqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 01:46:38 -0400
Received: by mail-yw1-f73.google.com with SMTP id h186so29408447ywc.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 22:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NNCnVCTAATMxlDMarLLJ67yqDDVFt+vwrBh9wh5mNVQ=;
        b=ogDQD8ZjbQ6rQB/cWAayl+9VthgdTRB4N9+9GyMbHO4DiRsdRDrdV4hPILgY7Dd+L0
         I2RHu02OyvKeDL+lm6hCGMoAmOxcXp1iclHCDygBWy5BFLe5GT+edQ82hOKLR/JJ9KdQ
         11b1p3QAxEdg7lXAO1lNroEn+qdvSJWt3iw3DL5AYhMjgqkE31tSGZQfrWeGG6OKTYPS
         afsxa8QMIeJn+iGaVG/JH2h1LJjJKyL47IF09+kVKczWp9X/zQGgRpH1Zc1iYBbEn+oS
         scXx1DItvS3mhp2+j2MbNl8vNbIJweBsYUaOnaq+FaUIBk4qrqEB0Zys9RYKfXBLRZW1
         bh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NNCnVCTAATMxlDMarLLJ67yqDDVFt+vwrBh9wh5mNVQ=;
        b=edhyS4srj+acGFwXkgl40Kipr3Xp2Q2/rFiouuZa5atEZbSAHq0dr7FPhitSxKDqX7
         sdBoCaL4VsvYW6G92vgDEfI1d6pitSwbghmqmp8nLXIv5pdfuFnEZ9vN84NhYHKQR7C1
         HJqBR/3qe6xXetcx4B6BQWe4kzlqGDSp5epCpItFn1oTatEQLZQHzHi67K18vLDgQtXH
         2RcCy0/stSUF+zhpI3jDiztVV0tYW8laBmDNrl8EejKQCg87cCwWhMqJUVLYtZVREc55
         A/4hA+Obh/wmLaar12ID3Q8VJ69wB0JPFlDhczvYBs5jOwjMSA+BeWrPCPfAdDlCLuKV
         qsSQ==
X-Gm-Message-State: APjAAAWTIW8hwM6D2fVqfiVQMAxPwzuWgy3AMOfPj4SmHwb9lQzN56LE
        kMDnfO6lLHeOnqMujJKlCDGmz99a7g6foZsjAQ5RAA==
X-Google-Smtp-Source: APXvYqzDnMJ4szPxIA4N77qJLw1e3aRJqDLenWVgRY3sM/QbVOHbh8x+6bBUoK7BNggbwfl2r5XHp/gCvYGW7uZKqd8+nw==
X-Received: by 2002:a81:9b17:: with SMTP id s23mr15952402ywg.503.1557812797962;
 Mon, 13 May 2019 22:46:37 -0700 (PDT)
Date:   Mon, 13 May 2019 22:42:52 -0700
In-Reply-To: <20190514054251.186196-1-brendanhiggins@google.com>
Message-Id: <20190514054251.186196-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514054251.186196-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
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
        pmladek@suse.com, rdunlap@infradead.org, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a91887c8d541..2e539647589fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12526,6 +12526,7 @@ S:	Maintained
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl.c
+F:	kernel/sysctl-test.c
 F:	tools/testing/selftests/sysctl/
 
 PS3 NETWORK SUPPORT
-- 
2.21.0.1020.gf2820cf01a-goog

