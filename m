Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4486D6A19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbjDDRO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 13:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbjDDROx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:14:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D6010FA;
        Tue,  4 Apr 2023 10:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B51F163790;
        Tue,  4 Apr 2023 17:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CEAC4339B;
        Tue,  4 Apr 2023 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680628492;
        bh=NBUCaONjYi40Vbcu4o/CCPE2N3ymcLwg1V2SlbPeNJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHGfLFO/6lWqvTQg3dD+ZiGLcThFJvk3b7nrRH/m3eMGcgcPfBNNFG6drzx4LOJrr
         /L6gN7acWGxiBVx7p9NtIy5ewclLB0T6z2nezlnjEKe4jCcFHpTj+cWbZfV+OPUa2n
         Iuen29mduilHjKHmQMesnJATtLYk/UwJ2N+ZcuULKiETcbcfpeRkdzP6zHKyZ13BTC
         l1QSKNjtUu7bwyO3EmM9BAGxTJOyRw/W/BmSLbpWzEP3LFtJIg1yBIIQcywBu14GE/
         x/lbszQJwhPGa/5cqaAEZXkLpxfPtRy5Ltc8ciKsMrx7HIMYtZ+fI8cOlbIdlK5RVw
         wd+gJ7j1HfZrQ==
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
Subject: [PATCH 5/5] fstests/MAINTAINERS: add a co-maintainer for btrfs testing part
Date:   Wed,  5 Apr 2023 01:14:11 +0800
Message-Id: <20230404171411.699655-6-zlang@kernel.org>
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

Darrick J. Wong would like to nominate Anand Jain to help more on
btrfs testing part (tests/btrfs and common/btrfs). He would like to
be a co-maintainer of btrfs part, will help to review and test
fstests btrfs related patches, and I might merge from him if there's
big patchset. So CC him besides send to fstests@ list, when you have
a btrfs fstests patch.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

Please btrfs list help to review this change, if you agree (or no objection),
then I'll push this change.

A co-maintainer will do:
1) Review patches are related with him.
2) Merge and test patches in his local git repo, and give the patch an ACK.
3) Maintainer will trust the ack from co-maintainer more (might merge directly).
4) Maintainer might merge from co-maintainer when he has a big patchset wait for
   merging.

Thanks,
Zorro

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ad12a38..9fc6c6b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -108,6 +108,7 @@ Maintainers List
 	  or reviewer or co-maintainer can be in cc list.
 
 BTRFS
+M:	Anand Jain <anand.jain@oracle.com>
 R:	Filipe Manana <fdmanana@suse.com>
 L:	linux-btrfs@vger.kernel.org
 S:	Supported
-- 
2.39.2

