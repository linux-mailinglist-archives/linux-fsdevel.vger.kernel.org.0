Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68CAE10D4FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 12:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfK2Lgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 06:36:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:41936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbfK2Lgx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:36:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE3BFAD93;
        Fri, 29 Nov 2019 11:36:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BD6081E0B6A; Fri, 29 Nov 2019 12:36:51 +0100 (CET)
Date:   Fri, 29 Nov 2019 12:36:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify changes for v5.5-rc1
Message-ID: <20191129113651.GD1121@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.5-rc1

to get three fsnotify cleanups.

Top of the tree is 67e6b4ef8496. The full shortlog is:

Ben Dooks (1):
      fsnotify: move declaration of fsnotify_mark_connector_cachep to fsnotify.h

Ben Dooks (Codethink) (1):
      fsnotify/fdinfo: exportfs_encode_inode_fh() takes pointer as 4th argument

Jan Kara (1):
      fsnotify: Add git tree reference to MAINTAINERS

The diffstat is

 MAINTAINERS          | 1 +
 fs/notify/fdinfo.c   | 2 +-
 fs/notify/fsnotify.c | 2 --
 fs/notify/fsnotify.h | 2 ++
 4 files changed, 4 insertions(+), 3 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
