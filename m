Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C41531A07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 22:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbiEWR3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 13:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242075AbiEWR1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 13:27:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1B57A804;
        Mon, 23 May 2022 10:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC0B1B81214;
        Mon, 23 May 2022 17:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1755BC385AA;
        Mon, 23 May 2022 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653326531;
        bh=LO40krAf3CjqGdVoOgmqxS8lQDlzPZcG7PI29kga/u8=;
        h=From:To:Cc:Subject:Date:From;
        b=cs9xm3JJAPW9pVoxV0L/WV7g9ErGuWYesW6Y2QB7gsAkd5KYGpxgf9hxGfsxRBCXs
         RzISWfBbY35cw49euMCN3+cKvFsQvzJ7aGY3tMZcV/oTUTvzOtmYQhZVgptsZoA375
         iH5QFCG38vLTkBs/ONSlVmXxj9GgC7fRIGPXUAyZpNc3YRTJJ7rnTWYvyVKLPuEUiF
         xEpUZHl8Va+AgTkiR4Iumpsn8ZB2u6OBVBcF0F5q9dFHdCM2eXfAzmCqhABSsWgIf1
         9fc5M4tfSdDgr6Xa8lvuv344MoCoj8G/Yip6vWbTyJMcuGXNkcBRBA+E/ml3ZKnBu4
         P1qQFs30B2OrQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: move myself from ceph "Maintainer" to "Reviewer"
Date:   Mon, 23 May 2022 13:22:09 -0400
Message-Id: <20220523172209.141504-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Xiubo has graciously volunteered to take over for me as the Linux cephfs
client maintainer. Make it official by changing myself to be a
"Reviewer" for libceph and ceph.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6d879cb0afd..39ec8fd2e996 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4547,8 +4547,8 @@ F:	drivers/power/supply/cw2015_battery.c
 
 CEPH COMMON CODE (LIBCEPH)
 M:	Ilya Dryomov <idryomov@gmail.com>
-M:	Jeff Layton <jlayton@kernel.org>
 M:	Xiubo Li <xiubli@redhat.com>
+R:	Jeff Layton <jlayton@kernel.org>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
@@ -4558,9 +4558,9 @@ F:	include/linux/crush/
 F:	net/ceph/
 
 CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)
-M:	Jeff Layton <jlayton@kernel.org>
 M:	Xiubo Li <xiubli@redhat.com>
 M:	Ilya Dryomov <idryomov@gmail.com>
+R:	Jeff Layton <jlayton@kernel.org>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
-- 
2.36.1

