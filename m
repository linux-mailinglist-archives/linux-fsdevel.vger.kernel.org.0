Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA1E4BE1CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 18:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357584AbiBUMUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 07:20:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357838AbiBUMT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:19:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07016220DD;
        Mon, 21 Feb 2022 04:15:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B49F2B81106;
        Mon, 21 Feb 2022 12:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF84C340E9;
        Mon, 21 Feb 2022 12:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645445717;
        bh=TfWEJonqjt2pfYM6UHzVbEPwFOy7drWgg7fr3O2kv/g=;
        h=From:To:Cc:Subject:Date:From;
        b=hBtOiqe7G9QSoPqMlJqWSpjCOFKOv5rktx5PUOZQnE1QesxIAhsbs6WucNdkomaCC
         AIvJSsCmRkVjAyP74JKiqnC5uryUndxbBYQd9Opn9wyQ2XSGE5YKldzdD5BHIB2SKm
         ahZWWRlAhKFwqWXRCV3qudZ2UcfdKa/AnbUxTiqTm4SNuyBG3WugJlRicjtCxKKDsw
         tEsGqx268LjgnzKqa6loijuHlTIENYFYGBX/fQqThD7hYm/sYvaVlfesRUOCo509B9
         1EqMVJYfXjAOr8qv+J9d2WAoI2kQIznVLo9We4+pCHhlFb0pR5BF6N5Ae62pkXcCCh
         7fCXtYonrsQnw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add Xiubo Li as cephfs co-maintainer
Date:   Mon, 21 Feb 2022 07:15:15 -0500
Message-Id: <20220221121515.10443-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Xiubo has been doing stellar kernel work lately, and has graciously
volunteered to help with maintainer duties. Add him on as co-maintainer
in for ceph.ko and libceph.ko.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..cee5ffb6061f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4443,6 +4443,7 @@ F:	drivers/power/supply/cw2015_battery.c
 CEPH COMMON CODE (LIBCEPH)
 M:	Ilya Dryomov <idryomov@gmail.com>
 M:	Jeff Layton <jlayton@kernel.org>
+M:	Xiubo Li <xiubli@redhat.com>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
@@ -4453,6 +4454,7 @@ F:	net/ceph/
 
 CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)
 M:	Jeff Layton <jlayton@kernel.org>
+M:	Xiubo Li <xiubli@redhat.com>
 M:	Ilya Dryomov <idryomov@gmail.com>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
-- 
2.35.1

