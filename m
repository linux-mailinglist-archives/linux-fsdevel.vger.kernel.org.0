Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A4176BE39
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 21:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHAT6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 15:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjHAT6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA12CC;
        Tue,  1 Aug 2023 12:58:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FCD5616A4;
        Tue,  1 Aug 2023 19:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BD3C433CA;
        Tue,  1 Aug 2023 19:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690919913;
        bh=p1d/zAWkSFKPBMVsl0E1ufcUzDDhSi5Z+LL/TTyliek=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kcufKVBzhBqwDe9I/ikJifWRO3zkvI7S2aS1ajpcsHAQZEqTiefWcYXqQaKPqZS/9
         RVGh9QjcB3Ey91ukjwR1mI5HfBd0p5m9XBnyJarQ24M7LvD8XdWDRqCc3XfZf7ptCR
         gZtssLKzpk7GZd4JFLhEDmYUOkTSrJ16Xrk92OB+xM1Oj9rqS7k5sQpIHUS+/YpXXk
         Rt5IguSr5D4xXHvFUMpEppenjbmy6A9SB7tabDO0FDF0RZDQh/XjsYaYelBNjsYmP/
         jr53wj8TzfA/9ale8fSHrk4QTdOEPEB5bMJUqf43JmjJvXimDvUjufxXj5PJ92WN8j
         WsJsumjLERh3A==
Subject: [PATCH 3/3] MAINTAINERS: add Chandan Babu as XFS release manager
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        chandan.babu@oracle.com, amir73il@gmail.com,
        leah.rumancik@gmail.com, zlang@kernel.org, fstests@vger.kernel.org,
        willy@infradead.org, shirley.ma@oracle.com, konrad.wilk@oracle.com
Date:   Tue, 01 Aug 2023 12:58:33 -0700
Message-ID: <169091991331.112530.11320923699439751703.stgit@frogsfrogsfrogs>
In-Reply-To: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

I nominate Chandan Babu to take over release management for the upstream
kernel's XFS code.  He has had sufficient experience merging backports
to the 5.4 LTS tree, testing them, and sending them on to the LTS leads.

NOTE: I am /not/ nominating Chandan to take on any of the other roles I
have just dropped.  Bug triager, testing lead, and community manager are
open positions that need to be filled.  There's also maintainer for
supported LTS releases (4.14, 4.19, 5.10...).

Cc: Chandan Babu R <chandan.babu@oracle.com>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)


diff --git a/MAINTAINERS b/MAINTAINERS
index d6b82aac42a4..f059e7c30f90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23324,6 +23324,7 @@ F:	include/xen/arm/swiotlb-xen.h
 F:	include/xen/swiotlb-xen.h
 
 XFS FILESYSTEM
+M:	Chandan Babu R <chandan.babu@oracle.com>
 R:	Darrick J. Wong <djwong@kernel.org>
 L:	linux-xfs@vger.kernel.org
 S:	Supported

