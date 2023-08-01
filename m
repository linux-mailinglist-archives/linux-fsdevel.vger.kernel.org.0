Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FE176BE34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 21:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjHAT6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 15:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjHAT6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:58:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3757BDB;
        Tue,  1 Aug 2023 12:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF04C616D1;
        Tue,  1 Aug 2023 19:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AA1C433C8;
        Tue,  1 Aug 2023 19:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690919908;
        bh=5F0E7SS1sZXdbK1ReiEDmMbcCn9yNveqdAAt78Ozz38=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YLn3SeDezk0ePCrhVMKEsWGekIHcqNp7I2TYXQyQtJUm/nq27MmbUckLH4Xz0L2FW
         X5wKpNyY7gEoijmTYnuUqXc8korK3IAQVzAXIsX9bCuDPvUkAP6xSfvZiTHefREwHy
         89JUBz68pKqKXYIC2PmH0KxqazdtCuy0cSDxHmPrnjLEUxlr/gPakdLCMmakRT1ily
         q1HCt3TgjvJLtWC1AKdGtaVaF2eSzQ6Z7teytK5+SzI1CoCOwScQEdbwMHIZY4WIuJ
         rd5iBqVnKFJ2Y3vB1un6hamV1qn8EqyZJKORrvIwu0v4ZOmN6VcTAryTbgzZ3tuMPG
         5I30Rgu61I3KA==
Subject: [PATCH 2/3] MAINTAINERS: drop me as XFS maintainer
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        chandan.babu@oracle.com, amir73il@gmail.com,
        leah.rumancik@gmail.com, zlang@kernel.org, fstests@vger.kernel.org,
        willy@infradead.org, shirley.ma@oracle.com, konrad.wilk@oracle.com
Date:   Tue, 01 Aug 2023 12:58:27 -0700
Message-ID: <169091990748.112530.4120713397724731545.stgit@frogsfrogsfrogs>
In-Reply-To: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

I burned out years ago trying to juggle the roles senior developer,
reviewer, tester, triager (crappily), release manager, and (at times)
manager liaison.  There's enough work here in this one subsystem for a
team of 20 FT, but instead we're squeezed to half that.  I thought if I
could hold on just a bit longer I could help to maintain the focus on
long term development to improve the experience for users.  I was wrong.

Nowadays, people working on XFS seem to spend most of their time on
distro kernel backports and dealing with AI-generated corner case bug
reports that aren't user reports.  Reviewing has become a nightmare of
sifting through under-documented kernel code trying to decide if this
new feature won't break all the other features.  Getting reviews is an
unpleasant process of negotiating with demands for further cleanups,
trying to figure out if a review comment is based in experience or
unfamiliarity, and wondering if the silence means anything.

For now, I will continue to review patches and will try to get online
fsck, parent pointers, and realtime volume modernisation merged.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/MAINTAINERS b/MAINTAINERS
index d232e9e36b87..d6b82aac42a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23324,7 +23324,7 @@ F:	include/xen/arm/swiotlb-xen.h
 F:	include/xen/swiotlb-xen.h
 
 XFS FILESYSTEM
-M:	Darrick J. Wong <djwong@kernel.org>
+R:	Darrick J. Wong <djwong@kernel.org>
 L:	linux-xfs@vger.kernel.org
 S:	Supported
 W:	http://xfs.org/

