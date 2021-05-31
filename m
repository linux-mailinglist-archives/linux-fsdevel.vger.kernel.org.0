Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84D7395936
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 12:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhEaKuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 06:50:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:46078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbhEaKuR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 06:50:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622458117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Au6ATIc7jrwz+zyh0xcbMmrkAFTygphrV8hM3Z2CSPw=;
        b=jLGgKAnR8YuXrLVOSvkeDGI4v2m1tUtyxRy5ZqdjC8BNCE0XrwQEjhyWWWX/XqR1SO6HAv
        GJQlSKHdrovxvuR9yxxSlZV6QbkM982BDas3fOyuQP6U984I2iw2V8GMYOetUyYWMCnQoz
        jsBEo9aPkzpciqlTPCyEKEhyf7Wlzvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622458117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Au6ATIc7jrwz+zyh0xcbMmrkAFTygphrV8hM3Z2CSPw=;
        b=Y7lxuXHTYlrH3V57lBhy1qg6D+FlD55WM8imIY/V6P/l4wp7Q/KwvFzowbTr3IvhYqHgBv
        /BH+zaImt92FYoBw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4C0C8B31C;
        Mon, 31 May 2021 10:48:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 152C91F2CB0; Mon, 31 May 2021 12:48:37 +0200 (CEST)
Date:   Mon, 31 May 2021 12:48:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify fixes for 5.13-rc5
Message-ID: <20210531104837.GA5349@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.13-rc5

to get a fix for permission checking with fanotify unpriviledged groups.
Also there's a small update in MAINTAINERS file for fanotify.

Top of the tree is a8b98c808eab. The full shortlog is:

Amir Goldstein (1):
      fanotify: fix permission model of unprivileged group

Jan Kara (1):
      MAINTAINERS: Add Matthew Bobrowski as a reviewer

The diffstat is

 MAINTAINERS                        |  1 +
 fs/notify/fanotify/fanotify_user.c | 30 ++++++++++++++++++++++++------
 fs/notify/fdinfo.c                 |  2 +-
 include/linux/fanotify.h           |  4 ++++
 4 files changed, 30 insertions(+), 7 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
