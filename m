Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443826FCBED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjEIQ52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjEIQ5W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:57:22 -0400
Received: from out-60.mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD9F4C1E
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMx7O3Ijlmo8XgCqd75OZDA70sC2El+hm/txmwADigM=;
        b=QOYjXAVnD0h4G8wOSjSoV+jU0bZjhj4Su/rVUvjNuHn/D49MiqA89G3KDobfUgHt8sj7B9
        PAMKYmGN4x6g7SBnVXrc5Mtk32EXr7Hnp6g5a3d5LyIzgInLfBbJrvUK+XMaSBKOYKMe7n
        WYd+zugQph5ei1C/uPydSbPvSrp7EA0=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 05/32] MAINTAINERS: Add entry for six locks
Date:   Tue,  9 May 2023 12:56:30 -0400
Message-Id: <20230509165657.1735798-6-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SIX locks are a new locking primitive, shared/intent/exclusive,
currently used by bcachefs but available for other uses. Mark them as
maintained.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6545eb541..3fc37de3d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19166,6 +19166,14 @@ S:	Maintained
 W:	http://www.winischhofer.at/linuxsisusbvga.shtml
 F:	drivers/usb/misc/sisusbvga/
 
+SIX LOCKS
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+L:	linux-bcachefs@vger.kernel.org
+S:	Supported
+C:	irc://irc.oftc.net/bcache
+F:	include/linux/six.h
+F:	kernel/locking/six.c
+
 SL28 CPLD MFD DRIVER
 M:	Michael Walle <michael@walle.cc>
 S:	Maintained
-- 
2.40.1

