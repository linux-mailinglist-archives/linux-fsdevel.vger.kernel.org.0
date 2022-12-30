Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB86659F02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiL3Xzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiL3Xzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:55:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA611E3E8;
        Fri, 30 Dec 2022 15:55:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5277EB81DD1;
        Fri, 30 Dec 2022 23:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AE7C433EF;
        Fri, 30 Dec 2022 23:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444536;
        bh=yBEVPklg/o7H3DOnN+gXOPTcjM79wse51B6G8fFBW1A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rB4hcLa5SySrwSpUDLXN0ayWwiUzF9bpABF6P3rle3KzIzD4doL2JWYIcT0p+xrQa
         BYG8thrGjwdoBLaZzd0E42OcO+/eFVeKXh3D/FvZdgq/tYt4R0WMTwp9AttnPaZP5m
         2TXIvM+aCgNEr7cd8DwD9OL5XC+8Zt9Ukqa5mO24nUGaYAadGHUz5yq5BTLwoJG8uQ
         LditQf9nJXD3wfFi1d6Z2GgvJKVDTtYz/BbYwNxbFKi2ojqDP9JqhFED0LSX2jhakH
         knOOV3eXuo/X7JhNlj7J2Muuwo18kk9QrD0moOP7UNsHqakqgZuep015GbTzcXsfzB
         53PZ8qbW50F6w==
Subject: [PATCH 21/21] xfs: enable atomic swapext feature
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:58 -0800
Message-ID: <167243843830.699466.7903927007917457600.stgit@magnolia>
In-Reply-To: <167243843494.699466.5163281976943635014.stgit@magnolia>
References: <167243843494.699466.5163281976943635014.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add the atomic swapext feature to the set of features that we will
permit.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index bb8bff488017..0c457905cce5 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -393,7 +393,8 @@ xfs_sb_has_incompat_feature(
 #define XFS_SB_FEAT_INCOMPAT_LOG_XATTRS   (1 << 0)	/* Delayed Attributes */
 #define XFS_SB_FEAT_INCOMPAT_LOG_SWAPEXT  (1U << 31)	/* file extent swap */
 #define XFS_SB_FEAT_INCOMPAT_LOG_ALL \
-	(XFS_SB_FEAT_INCOMPAT_LOG_XATTRS)
+		(XFS_SB_FEAT_INCOMPAT_LOG_XATTRS | \
+		 XFS_SB_FEAT_INCOMPAT_LOG_SWAPEXT)
 #define XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN	~XFS_SB_FEAT_INCOMPAT_LOG_ALL
 static inline bool
 xfs_sb_has_incompat_log_feature(

