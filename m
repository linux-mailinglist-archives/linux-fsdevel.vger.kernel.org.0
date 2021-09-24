Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2655E41704F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 12:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhIXK2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 06:28:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36484 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhIXK2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:28:38 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id 93BF3223F3;
        Fri, 24 Sep 2021 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632479224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=FmSzy+FazphKfQvxXzbH3THJND1SOlFWBDZPvzN7pX0=;
        b=P6IU17Zz/SJ8MqJmnGVAXEiLwlVbLl9OPkV6dAKqwB1GpS9Kcb3ZucFpkMor9lC7T2racS
        vMqUeQNHzynbQQk0COif9RKK6wy91PMwkY8L12EVMhE/fM6lGrkBw7g+VWiXgwssIaoP3b
        Pd769rtvnefX1iF3sFaUXVzaBaEuzaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632479224;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=FmSzy+FazphKfQvxXzbH3THJND1SOlFWBDZPvzN7pX0=;
        b=yIbGonTJgjC7JFakVAKg/oidslfgEr+JZ8Ozjt05nu9AqBQOWLICBgj9JTNYlOlyj9Favt
        UDh66kHLsLltV6Bg==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay1.suse.de (Postfix) with ESMTP id 853A125D44;
        Fri, 24 Sep 2021 10:27:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 38A5B1E0BF0; Fri, 24 Sep 2021 12:27:04 +0200 (CEST)
Date:   Fri, 24 Sep 2021 12:27:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: [GIT PULL] Two fixes for 5.15-rc3
Message-ID: <20210924102703.GA19744@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.15-rc3

to get a fix for ext2 sleep in atomic context in case of some fs problems
and a cleanup of an invalidate_lock initialization.

Top of the tree is 372d1f3e1bfe. The full shortlog is:

Dan Carpenter (1):
      ext2: fix sleeping in atomic bugs on error

Sebastian Andrzej Siewior (1):
      mm: Fully initialize invalidate_lock, amend lock class later

The diffstat is

 fs/ext2/balloc.c | 14 ++++++--------
 fs/inode.c       |  6 ++++--
 2 files changed, 10 insertions(+), 10 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
