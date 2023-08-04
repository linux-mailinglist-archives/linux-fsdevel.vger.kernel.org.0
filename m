Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F087705EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjHDQZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 12:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjHDQZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AEE49E8;
        Fri,  4 Aug 2023 09:25:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4D57620AA;
        Fri,  4 Aug 2023 16:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD5AC433C8;
        Fri,  4 Aug 2023 16:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691166310;
        bh=5F0E7SS1sZXdbK1ReiEDmMbcCn9yNveqdAAt78Ozz38=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X+YiyIfYuHrGPxSSywpQ+H+/X251omeaTJEp3nIDVn+/1jRxaWdXD/m7xlFWMoORD
         fCikS+AQ7gfLg5NMOY8fiekmFKJ+wTFeSV2h3k/yQZKMRNOUB/FXLBF613JlXoCo6G
         gS5X5Sjp4gXAUu5cMzMGtBPagOIO9svn/Uuogl/D09WP1yqlkrG/9AdDMRs99zLr81
         E4gKfGIw9B20NSpWz/hX6aLyDAFvLFGAjC7IEXhbEFaf8q6tM5c331enNonvnfqMBr
         pJsjtZAypEmgUJg4aD4fguUku7PKeBjAhREhX2SVp1JNPvO5CpxewceSC5M6i+tiFl
         +8R13w5wo/oaQ==
Subject: [PATCH 2/3] MAINTAINERS: drop me as XFS maintainer
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        chandan.babu@oracle.com, amir73il@gmail.com,
        leah.rumancik@gmail.com, zlang@kernel.org, fstests@vger.kernel.org,
        willy@infradead.org, shirley.ma@oracle.com, konrad.wilk@oracle.com
Date:   Fri, 04 Aug 2023 09:25:09 -0700
Message-ID: <169116630956.3243794.12991534530388405660.stgit@frogsfrogsfrogs>
In-Reply-To: <169116629797.3243794.7024231508559123519.stgit@frogsfrogsfrogs>
References: <169116629797.3243794.7024231508559123519.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
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

