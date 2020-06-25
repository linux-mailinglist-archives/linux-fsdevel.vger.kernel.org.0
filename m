Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6A520A4A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390218AbgFYSTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 14:19:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:55700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389648AbgFYSTt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:19:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D659B03B;
        Thu, 25 Jun 2020 18:19:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 774541E1274; Thu, 25 Jun 2020 20:19:48 +0200 (CEST)
Date:   Thu, 25 Jun 2020 20:19:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify speedup for 5.8-rc3
Message-ID: <20200625181948.GF17788@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.8-rc3

to get a performance improvement to reduce impact of fsnotify for inodes
where it isn't used.

Top of the tree is e9c15badbb7b. The full shortlog is:

Mel Gorman (1):
      fs: Do not check if there is a fsnotify watcher on pseudo inodes

The diffstat is

 fs/file_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
