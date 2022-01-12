Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CD848C01C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 09:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351706AbiALIld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 03:41:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53690 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349400AbiALIlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:41:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D81DD1F3C0;
        Wed, 12 Jan 2022 08:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641976891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=FBrp3U3GggnuHM/LqtZScvOxZBbXusl48RRBkf0E/Qg=;
        b=fjtzYqteSTZsJrUJ3JGWHtRH0anY01e77Su7Jlv1NwT2ZExEbTEaCMmY3I1NqIzVmjjTCR
        9diW0xJGE0/TsHpZvCOfLfFOdSXCvrDohymHMmqxz9yJLXZZmCQp6Z2AdIyz8AX6n5um6X
        GBjsEci3LzI1VxBgjocf5k4C3JKVgwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641976891;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=FBrp3U3GggnuHM/LqtZScvOxZBbXusl48RRBkf0E/Qg=;
        b=oGhwrHUJZn7aJwVMk+gdG5F7AKTYRTPDApkcysU7BfHImnfVEkPNrz9dw0lqO/oU90/CNy
        7Dpu2qKTW1OIjZBg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C70F6A3B89;
        Wed, 12 Jan 2022 08:41:31 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 877C8A05DA; Wed, 12 Jan 2022 09:41:31 +0100 (CET)
Date:   Wed, 12 Jan 2022 09:41:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] UDF & reiserfs fixes for 5.17-rc1
Message-ID: <20220112084131.tqofmh4xfeh462br@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.17-rc1

To get one udf fix and one reiserfs cleanup.

Top of the tree is f05f2429eec6. The full shortlog is:

Jan Kara (1):
      udf: Fix error handling in udf_new_inode()

NeilBrown (1):
      reiserfs: don't use congestion_wait()

The diffstat is

 fs/reiserfs/journal.c | 7 +++++--
 fs/udf/ialloc.c       | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
