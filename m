Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7015D4E553C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 16:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbiCWPdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245216AbiCWPc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:32:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EE570F70
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 08:31:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 74E18210F6;
        Wed, 23 Mar 2022 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648049487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=9fyDNh48odEhwEZ7QO1n/uXCOKvgyq/OABgI9As1ikA=;
        b=pL8xbI9KozmdTDtTTsJK8dVvrsWY7QFfKpwV/W6VM+/xk1cZY0KATBfW1pKQhRIhfbkiL0
        YGFhzncl9xZGdQMBQW2REGn0F1owG0oQzuHrhQWK2YzMxvYsavDEhSm9wMJXYAYl+QG3uR
        87Y10N9WsXXPkSSg6AHVrApWLBTmov4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648049487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=9fyDNh48odEhwEZ7QO1n/uXCOKvgyq/OABgI9As1ikA=;
        b=4oFYyodTta1yLT7Mqqhv/vY63KeBBadYavWtqWUmDANoNODyeoTu5pSxpsMO3XhmVZB41m
        OAW1JzoKzi5f6uBg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3F7A6A3B83;
        Wed, 23 Mar 2022 15:31:27 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2D492A0610; Wed, 23 Mar 2022 16:31:25 +0100 (CET)
Date:   Wed, 23 Mar 2022 16:31:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify changes for 5.18-rc1
Message-ID: <20220323153125.p7fpgaeze6etunwa@quack3.lan>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.18-rc1

to get a few fsnotify improvements and cleanups.

Top of the tree is f92ca72b0263. The full shortlog is:

Amir Goldstein (2):
      fsnotify: fix merge with parent's ignored mask
      fsnotify: optimize FS_MODIFY events with no ignored masks

Bang Li (1):
      fsnotify: remove redundant parameter judgment

The diffstat is

 fs/notify/fanotify/fanotify_user.c | 47 ++++++++++++++++++++++++++------------
 fs/notify/fsnotify.c               | 14 ++++++------
 fs/notify/mark.c                   |  4 ++--
 include/linux/fsnotify_backend.h   | 19 +++++++++++++++
 4 files changed, 61 insertions(+), 23 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
