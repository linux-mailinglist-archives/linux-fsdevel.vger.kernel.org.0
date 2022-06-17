Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD0254F503
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 12:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381679AbiFQKLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 06:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381655AbiFQKLT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:11:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5666A044
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 03:11:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A45DC1F8F0;
        Fri, 17 Jun 2022 10:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655460676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=ZrCQT13JlCHw8gq/yVfYGmK0sI1olxa0f3iAO99U4+g=;
        b=jgFWoOnjUCzTQqeBS0uRsm9znC2DHWXi+shojBpCiH0qV9oJrAuQRJ4LZtAXGDStb5MXWj
        eAHXXK6cLqlaU3Ochbi4O2cplOGQVFh96Znfovj+GlyCeH1g6V/oiimszyTDv4ETsO/vPX
        Dr6QoD9BBVIP11XZZeyfQoEgBLZRy9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655460676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=ZrCQT13JlCHw8gq/yVfYGmK0sI1olxa0f3iAO99U4+g=;
        b=AFt/sGuBnE2zCyuisxQ84n+Epo6LZnx2JT4EdEAfGmpQER9L0o9ZikNKtFQWqQfLHl7Kkq
        sNQNRxXb8+vV9jDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6E3B72C141;
        Fri, 17 Jun 2022 10:11:15 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2F90DA0632; Fri, 17 Jun 2022 12:11:07 +0200 (CEST)
Date:   Fri, 17 Jun 2022 12:11:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] writeback and ext2 fixes for 5.19-rc3
Message-ID: <20220617101107.r6g2qnvqkhtntox7@quack3.lan>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.19-rc3

to get the fix for writeback bug which prevented machines with kdevtmpfs
from booting and also one small ext2 bugfix in IO error handling.

Please note that this tag is not signed because I'm travelling until Sunday
and I forgot my yubikey at home but I want to get the writeback fix
merged... I'm sorry for that.

Top of the tree is 4bca7e80b645. The full shortlog is:

Jan Kara (1):
      init: Initialize noop_backing_dev_info early

Ye Bin (1):
      ext2: fix fs corruption when trying to remove a non-empty directory with IO error

The diffstat is

 drivers/base/init.c         |  2 ++
 fs/ext2/dir.c               |  9 +++------
 include/linux/backing-dev.h |  2 ++
 mm/backing-dev.c            | 11 ++---------
 4 files changed, 9 insertions(+), 15 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
