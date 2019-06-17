Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670AC47CC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfFQI2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 04:28:08 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:54425 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfFQI2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:28:07 -0400
Received: by mail-yb1-f202.google.com with SMTP id p79so9968405yba.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2019 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EsSBOAivkaHwi6D12Cv8eKMrxsdP+T6KPHsvwbMQYm0=;
        b=C7EmzIa5t1p3To0eH+Btt+UKnk2zWoDCRcHlxDDez+EJGzuX5/OCX+VtE4f/+IBxBU
         mGEeX0YKVsmTpTHqWxwdvH8hqIG3FELhUYhSlXikfd0094SnjH2SPp0dcm0R005htjts
         6D/xP0jMwTBwY1jE9/ZxkY0+RYLVqYuSTLbgUEKmyJPUnfix1cU3MelrOVMNgQTKcGe9
         cFGgfxb8WDzOX4wGL98vqfITN9oZvAZ6ZQuIixRxb8VtiucW8A40EeqqX9/1t6jRhzWX
         B1r5Tw0xfFTV6bdsPqlvoEcQ0Y0C9kM0VAB1WtVyge15d2r4CngkCHzpB/WflMNr6YDF
         mQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EsSBOAivkaHwi6D12Cv8eKMrxsdP+T6KPHsvwbMQYm0=;
        b=XvVbhNwVenw1dV5d8SNQIv4ej5yadCdZhWPFG1T+AbPGJ4gsbH/r4AJGFBeIvkhtEH
         Oba6VJey53HINNwoH8p3/6CXZyi0MD6y9EMwmz3S1JfOAOwXPh+/fgo1/BQveeSCuuQ7
         MHkZXLPgqkObao8PnSb3zM6Pzyd4rvPg6pu3YHwaUc6MY2GDKgteMKjvXTSuzwe0Q5Av
         L/puVl9jMIfzxk6vBus3jUmlyu/WvEBWTMj5ybO8Nuq8oTQlcqYbsLWMoaLBpMKHnWCb
         EwdWXMnJVft2Q8UdMGplrxQDl7xAMChJ3dGkZOTssEJWbGCbrQiWco4tvBuys077ESpI
         fbDQ==
X-Gm-Message-State: APjAAAWmbfY2SCD1wtC2X7YmsbVqDtQNjfV41wdqzAfQfCe3GaG8TQWs
        WAZQ+NJkVn5bzDe7P7/i8QBWiJ01k75yGXwEwKJzhg==
X-Google-Smtp-Source: APXvYqygaxiZVfos+CJ+dORKXgXbsd4xQo+Oa0IXMYwFW3jHO/QMUCpEYOoJXhDPIYS8TyQgU0luKfcb92R2UWUxnJ1x6Q==
X-Received: by 2002:a25:7642:: with SMTP id r63mr57620375ybc.253.1560760086697;
 Mon, 17 Jun 2019 01:28:06 -0700 (PDT)
Date:   Mon, 17 Jun 2019 01:26:13 -0700
In-Reply-To: <20190617082613.109131-1-brendanhiggins@google.com>
Message-Id: <20190617082613.109131-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
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
index f3fb3fc30853e..05cd8ffd33c8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12718,6 +12718,7 @@ S:	Maintained
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl.c
+F:	kernel/sysctl-test.c
 F:	tools/testing/selftests/sysctl/
 
 PS3 NETWORK SUPPORT
-- 
2.22.0.410.gd8fdbe21b5-goog

