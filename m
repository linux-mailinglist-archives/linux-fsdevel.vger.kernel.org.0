Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F15A595AF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 13:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiHPL4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 07:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHPL4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:56:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA2A75CD5
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 04:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C514EB816A9
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 11:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4F3C433D6;
        Tue, 16 Aug 2022 11:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660649730;
        bh=udfxuMZJAk3TrYtAL71e6jqrRX2SJ7jtt3mxYMZ6L4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G2dkp8kYMhozvmWwpd/RyHoC1dflg5+rKAJZI5JYAzcAvACbK31boUk9C/3tkU0Vp
         sDsQoHtP30fHSyDjHDwL+iyGXmPY+8y0DhI6TMVfBEB/38CpeM+gTqMMZTdgAp38n1
         nq9mVYqnF5sZ4yk1hMKNxTNYQp1XVzU7T+kVZ3XWza60YJeDslWRa0wH/7oz81psQ/
         o0+ORPPg84B7eytjeE5JtTv6kUK6LWdqJlan7Zy7YS9wCJ3lqUu4Wk0WGaYzQc4fBK
         032BMV19pgb2lsAyF96taYt5Pu1UczqjETc5WOuy9NL8AHh8ezPslscSls1UdRWR60
         0ptX1t+AAAJkw==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Seth Forshee <sforshee@digitalocean.com>
Subject: [PATCH 2/2] MAINTAINERS: update idmapping tree
Date:   Tue, 16 Aug 2022 13:35:14 +0200
Message-Id: <20220816113514.43304-2-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220816113514.43304-1-brauner@kernel.org>
References: <20220816113514.43304-1-brauner@kernel.org>
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

Since Seth joined as a maintainer in ba40a57ff08b ("Add Seth Forshee as
co-maintainer for idmapped mounts") it was best to get a shared git tree
instead of using our personal repositories. So we requested and
Konstantin suggested and gave us a new "idmapping" repository under the
pre-existing but mainly unused vfs namespace. Just makes it easier for
Seth to send fixes in case I'm out or someone else ever takes over.

Cc: Seth Forshee <sforshee@digitalocean.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..a558794dddf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9780,7 +9780,7 @@ M:	Christian Brauner <brauner@kernel.org>
 M:	Seth Forshee <sforshee@kernel.org>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
+T:	git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
 F:	Documentation/filesystems/idmappings.rst
 F:	tools/testing/selftests/mount_setattr/
 F:	include/linux/mnt_idmapping.h
-- 
2.34.1

