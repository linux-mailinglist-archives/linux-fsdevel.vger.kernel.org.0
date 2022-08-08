Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C9F58CC6B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 18:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243717AbiHHQ4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 12:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiHHQ4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:56:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8CB5FF7;
        Mon,  8 Aug 2022 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=slHqIYFg93QTfH1kf4MLebz4kqBC1sdIRwv3bCzElGY=; b=M+HzHR/DTgigQxlnsUiM/cGq3/
        6OmS0sX/2gkiA9uP6J+va1IhY4sbDgvli2pHZT7uzvHJkbKNw6QLkAMh6Gdch2o9KYsKchTPhRrp8
        cfQohwIrmLlLS356vYI/pqSSoc4SGEab/JpeZ3B4F1ZLwgkGyk/e0diEyLBd2168T+EevBe/Xtkd9
        xzE3es/L/PvkMX6BQtUZ9ol+kiSJe6YVDnrkvZjgQVkaoDZHVuLV5HVRY2I55XQvsnbcC26c2SZQ2
        +efpazkcPFPMNAva6DuKXwnOUd4cx1RhJO5A1OVVCZ3Lj1t/7ZAms5hJRTwy++rKAJkAUJo2I8Fa0
        rKTEUIHw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oL636-00F3Tl-5h; Mon, 08 Aug 2022 16:56:16 +0000
Date:   Mon, 8 Aug 2022 09:56:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     keescook@chromium.org, songmuchun@bytedance.com,
        yzaikin@google.com, bh1scw@gmail.com, geert+renesas@glider.be,
        Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
        kuba@kernel.org, patches@lists.linux.dev, mcgrof@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sysctl changes for v6.0-rc1
Message-ID: <YvFAMLmwPoO14KqD@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These minor changes have been soaking in linux-next for a long time except
for the last commit but that should not break anything as its just space
cleanup.

The following changes since commit 4e23eeebb2e57f5a28b36221aa776b5a1122dde5:

  Merge tag 'bitmap-6.0-rc1' of https://github.com/norov/linux (2022-08-07 17:52:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.0-rc1

for you to fetch changes up to 374a723c7448bbea22846884ba336ed83b085aab:

  kernel/sysctl.c: Remove trailing white space (2022-08-08 09:01:36 -0700)

----------------------------------------------------------------
sysctl updates for 6.0

There isn't much for 6.0 for sysctl stuff, most of the stuff
went through the networking subsystem (Kuniyuki Iwashima's
trove of fixes using READ_ONCE/WRITE_ONCE helpe) as most of
the issues there have been identified on networking side. So
it is good we don't have much updates as we would have ended
up with tons of conflicts. I rebased my delta just now to
your tree so to avoid conflicts with that stuff. This merge
request is just minor fluff cleanups then. Perhaps for 6.1
kernel/sysctl.c will get more love than this release.

----------------------------------------------------------------
Fanjun Kong (2):
      kernel/sysctl.c: Clean up indentation, replace spaces with tab.
      kernel/sysctl.c: Remove trailing white space

Geert Uytterhoeven (1):
      sysctl: Merge adjacent CONFIG_TREE_RCU blocks

 kernel/sysctl.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)
