Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396754A714B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 14:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiBBNMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 08:12:50 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52058 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiBBNMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:12:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 32A381F3A8;
        Wed,  2 Feb 2022 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643807569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=o/Uw/o/egg5+u8Z8wjWVLIbhgk4HMO/Ck/i+7vpXKmk=;
        b=VFhx8PDuirWgNZXqiZsxMlyBFRosxL2Kv4mnFNanKi9x95iLat25zyKJaBVL+fGgAjFf4T
        cAT9sqRDOvrJ7Q+zbxxsUeTHcFdFep63m7FByMNJYO3+L9HSwRP7qhDiTcbJLe+estOnFs
        bRgmDld86uzCCvRmbDjIjhG9ONt6jGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643807569;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=o/Uw/o/egg5+u8Z8wjWVLIbhgk4HMO/Ck/i+7vpXKmk=;
        b=6Vms7LXRk8nBQMo3iA3YAzuWtHpoMoQE9XBNU0i/gF6zYDMWglkJ+Ws7Tsh0w+ghW+DqB+
        WVG4AAV/SQPUFaAQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 45E71A3B87;
        Wed,  2 Feb 2022 13:12:45 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 52FBBA05AF; Wed,  2 Feb 2022 14:12:43 +0100 (CET)
Date:   Wed, 2 Feb 2022 14:12:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fanotify fix for 5.17-rc3
Message-ID: <20220202131243.oe6w4ffjamujgnea@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.17-rc3

to get a fix for possible use-after-free issue in fanotify code.

Top of the tree is ee12595147ac. The full shortlog is:

Dan Carpenter (1):
      fanotify: Fix stale file descriptor in copy_event_to_user()

The diffstat is

 fs/notify/fanotify/fanotify_user.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
