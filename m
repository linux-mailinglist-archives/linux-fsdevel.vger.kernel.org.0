Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A882583EBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 14:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbiG1MYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 08:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbiG1MYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:24:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423966BD48
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jul 2022 05:24:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 01BB52000A;
        Thu, 28 Jul 2022 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659011062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=VkaIqSb3tgsrmOUzRmgeENuM6fgEieWVUHBALPdnSPM=;
        b=hbAJNN8UqtVnGwn+Z6FXlKNn8q60GIEaMqujK5zX3oVcWW+U3r2AzwvlpxwQqpktPHZlH9
        DDelUBon0FLldfBbSOeQCtClgtVPuOw9ZbCacR0RRok4oIARAH9IjCODLdXDJytEdIidMv
        w/NtxkxIU/qB4ySCH1fBkXGNCb5URmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659011062;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=VkaIqSb3tgsrmOUzRmgeENuM6fgEieWVUHBALPdnSPM=;
        b=IZoatTt5WBbC0Jr3ybn39hpcKnpI9+IzJHzbqNFVEun7FkiHD64YPiUE1J3WPzc9fEf1Rh
        KTQxCZkGaYxvELCA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D9B622C141;
        Thu, 28 Jul 2022 12:24:21 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3BA50A0668; Thu, 28 Jul 2022 14:24:16 +0200 (CEST)
Date:   Thu, 28 Jul 2022 14:24:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Ext2 and reiserfs fixes and cleanups for 5.20-rc1
Message-ID: <20220728122416.h4bu74ptr6l3g2ur@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.20-rc1

to get a fix of ext2 handling of corrupted fs image and a cleanups in ext2
and reiserfs.

I'm sending the pull request early as I'm on vacation next two weeks. 

Top of the tree is fa78f3369372. The full shortlog is:

Jan Kara (1):
      ext2: Add more validity checks for inode counts

Jiangshan Yi (1):
      fs/ext2: replace ternary operator with min_t()

Zeng Jingxiang (1):
      fs/reiserfs/inode: remove dead code in _get_block_create_0()

The diffstat is

 fs/ext2/super.c     | 18 ++++++++++++------
 fs/reiserfs/inode.c | 12 ++----------
 2 files changed, 14 insertions(+), 16 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
