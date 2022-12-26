Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C77065638F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiLZOtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiLZOs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:48:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DB8113A;
        Mon, 26 Dec 2022 06:48:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11D4260EA3;
        Mon, 26 Dec 2022 14:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A06BC433D2;
        Mon, 26 Dec 2022 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672066137;
        bh=km72hStlCyvSVnDwcaySpzGtg6S8p8geBbOhyy/FiPk=;
        h=From:To:Subject:Date:From;
        b=KfPuiBmHHkNvAjThtDoz60+nQQey6KhN8feVSUQltSnkkwlPYFGf8AzkcIvCClnce
         9ESRtTVZFerzaTFzhg6UBZLDdRxPCCjDjXrfi5okNy0FHH6J81wW1D1pteKrzitVb7
         VPC1jrcZtNbUTea3kU+JsYB/MHnXD3Ihk7xYPWFi6u+LUSonv4SrZue5zMeY/PQWnT
         1uWnCdn7Wtvhb0ZtdZCx67/haESWKlz/R2AwFOswD93h7TYIoFJc5n3gXIKz7RawBs
         yRlf2o9oCarhs/O2OMG5w9Yzum88KL5VIG4wsltWd7tyNqSFKV547xZhdAfCzQTQ1i
         zVg49GRuHw84g==
Received: by pali.im (Postfix)
        id 3778B9D7; Mon, 26 Dec 2022 15:48:54 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH 0/3] fs: nls: Simplification of ASCII and ISO-8859-1
Date:   Mon, 26 Dec 2022 15:42:58 +0100
Message-Id: <20221226144301.16382-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is RFC patch series which simplify ASCII and ISO-8859-1 tables.
I'm not sure what is the direction of the nls code and duplicated
default/iso88591 tables, so I'm sending this series as RFC.

Pali Rohár (3):
  nls: Simplify ASCII implementation
  nls: Simplify ISO-8859-1 implementation
  nls: Replace default nls table by correct iso8859-1 table

 fs/nls/Kconfig         |  21 ++--
 fs/nls/Makefile        |   1 -
 fs/nls/nls_ascii.c     |  85 ++------------
 fs/nls/nls_base.c      | 187 +++++++-----------------------
 fs/nls/nls_iso8859-1.c | 257 -----------------------------------------
 5 files changed, 57 insertions(+), 494 deletions(-)
 delete mode 100644 fs/nls/nls_iso8859-1.c

-- 
2.20.1

