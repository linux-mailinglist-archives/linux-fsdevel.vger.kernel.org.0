Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B21878B0F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjH1MtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjH1Msg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:48:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460E9130;
        Mon, 28 Aug 2023 05:48:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E050921AD8;
        Mon, 28 Aug 2023 12:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693226899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ONw9f/eamfuqcA1sc1l33IQBdk5tjHPSXmiVZUyb+90=;
        b=h1mWCLGoJCxiKgM+x6nEyeK/4CHJUWKmneTJ+INbvjmQRwiJWiPYhnpQOK0yphDGQiq/2v
        MDGkQ22lVQVYt2creLAU+NFmM9tGSjzLygwphOjPpjzmxRpf2k/GznC/ooVYThDYJTlrwv
        lLaxVm8LBPnOrOA1dSNejOd201f79U8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D9B512C142;
        Mon, 28 Aug 2023 12:48:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B130ADA867; Mon, 28 Aug 2023 14:41:45 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS updates for 6.6
Date:   Mon, 28 Aug 2023 14:41:41 +0200
Message-ID: <cover.1693225987.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

there are two minor updates for AFFS. Please pull, thanks.

* reimplement writepage() address space callback on top of migrate_folio()

* fix a build warning, local parameters 'toupper' collide with the
  standard ctype.h name

----------------------------------------------------------------
The following changes since commit 706a741595047797872e669b3101429ab8d378ef:

  Linux 6.5-rc7 (2023-08-20 15:02:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-6.6-tag

for you to fetch changes up to 4d4f1468a002b76fb4796985a11671d50c88e520:

  affs: rename local toupper() to fn() to avoid confusion (2023-08-22 14:20:10 +0200)

----------------------------------------------------------------
Andy Shevchenko (1):
      affs: rename local toupper() to fn() to avoid confusion

Matthew Wilcox (Oracle) (1):
      affs: remove writepage implementation

 fs/affs/file.c  | 14 +++++++++-----
 fs/affs/namei.c | 20 ++++++++++----------
 2 files changed, 19 insertions(+), 15 deletions(-)
