Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4856D6A1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 19:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbjDDRO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 13:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbjDDROs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:14:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7541BF1;
        Tue,  4 Apr 2023 10:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 450ED6378E;
        Tue,  4 Apr 2023 17:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8ABC433A1;
        Tue,  4 Apr 2023 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680628485;
        bh=qEU5p/rrPBMCcC0b9NygBo0CKzlLnTtdCdY5YHNjXz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7ZekHh0kNeqmVuQWe3cMaiVtL9ICvdGaufuyHnjBLAPy3EG4Jf6gOeacxzbQ4xn9
         QTLN3vKygazocZQuD6bz67l1p9bYvsCQZAYHJlFOw35kzra2NO6G33uE8wOfolwziO
         xj2ficCC1e0A9/fy64r5Y7LewDk8qhNPbg49nwMZJMp/fJTKljG3nDKPjkpWSZdtho
         abvZl57ghjk+PPSUaejv8IyCjJtYWhsS9ciQ8B3XXbSWjI+n64WX+Hxqboqjc22ttP
         ennHYz2Fk0PjdGRvcCJxw+lWV5D5mNtZv205GCv6lzOzACCpuUuMXBIGpDSPMvIi9E
         239Szkhk1pZQw==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-unionfs@vger.kernel.org,
        jack@suse.com, linux-xfs@vger.kernel.org, fdmanana@suse.com,
        ebiggers@google.com, brauner@kernel.org, amir73il@gmail.com,
        djwong@kernel.org, anand.jain@oracle.com
Subject: [PATCH 4/5] fstests/MAINTAINERS: add some specific reviewers
Date:   Wed,  5 Apr 2023 01:14:10 +0800
Message-Id: <20230404171411.699655-5-zlang@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404171411.699655-1-zlang@kernel.org>
References: <20230404171411.699655-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some people contribute to someone specific fs testing mostly, record
some of them as Reviewer.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

If someone doesn't want to be in cc list of related fstests patch, please
reply this email, I'll remove that reviewer line.

Or if someone else (who contribute to fstests very much) would like to a
specific reviewer, nominate yourself to get a review.

Thanks,
Zorro

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 620368cb..0ad12a38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -108,6 +108,7 @@ Maintainers List
 	  or reviewer or co-maintainer can be in cc list.
 
 BTRFS
+R:	Filipe Manana <fdmanana@suse.com>
 L:	linux-btrfs@vger.kernel.org
 S:	Supported
 F:	tests/btrfs/
@@ -137,16 +138,19 @@ F:	tests/f2fs/
 F:	common/f2fs
 
 FSVERITY
+R:	Eric Biggers <ebiggers@google.com>
 L:	fsverity@lists.linux.dev
 S:	Supported
 F:	common/verity
 
 FSCRYPT
+R:	Eric Biggers <ebiggers@google.com>
 L:      linux-fscrypt@vger.kernel.org
 S:	Supported
 F:	common/encrypt
 
 FS-IDMAPPED
+R:	Christian Brauner <brauner@kernel.org>
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
 F:	src/vfs/
@@ -163,6 +167,7 @@ S:	Supported
 F:	tests/ocfs2/
 
 OVERLAYFS
+R:	Amir Goldstein <amir73il@gmail.com>
 L:	linux-unionfs@vger.kernel.org
 S:	Supported
 F:	tests/overlay
@@ -174,6 +179,7 @@ S:	Supported
 F:	tests/udf/
 
 XFS
+R:	Darrick J. Wong <djwong@kernel.org>
 L:	linux-xfs@vger.kernel.org
 S:	Supported
 F:	common/dump
-- 
2.39.2

