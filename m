Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60666533C8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 14:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbiEYMZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 08:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiEYMY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 08:24:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBCF6D3AC
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 05:24:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F35251F45E;
        Wed, 25 May 2022 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653481492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=FNgj3SLEymU35Jnzd81SZcMXIPKvRjg6wRp53GwWLoA=;
        b=pkVPTh2iUAPCe5Ez/dIkbMEZyINbSFgGVi8ShoUdVNyTaxX5BDwHcimb+DRzT4T0p2jW+j
        mW0nhVwlu4wvAduBjdo7al8gQlAR4CxYV1o+De1S0hVD700/TXq8WNWCu3AqP5QHm+oQGm
        2tT9GtnqlzNrTRkmJAbDB/GBLdkxwa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653481493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=FNgj3SLEymU35Jnzd81SZcMXIPKvRjg6wRp53GwWLoA=;
        b=93AaBLNulA7/QIybniCqiVdlHviXmRlgP0pyWuj1rdaQZj5dYfIRrrzZYI5IrBIEzjF//4
        2zI/sqTsN4oeleCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E12192C141;
        Wed, 25 May 2022 12:24:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6903CA0632; Wed, 25 May 2022 14:24:52 +0200 (CEST)
Date:   Wed, 25 May 2022 14:24:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Writeback and ext2 cleanups for 5.19-rc1
Message-ID: <20220525122452.gqkl2bmlvjym62ib@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.19-rc1

to get one small ext2 cleanup and one writeback spelling fix.

Top of the tree is 2999e1e38727. The full shortlog is:

Haowen Bai (1):
      fs: ext2: Fix duplicate included linux/dax.h

Julia Lawall (1):
      writeback: fix typo in comment

The diffstat is

 fs/ext2/inode.c   | 1 -
 fs/fs-writeback.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
