Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EABB4CE4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 15:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbfFTNG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 09:06:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:38244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731940AbfFTNG0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:06:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D8DDAC66;
        Thu, 20 Jun 2019 13:06:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 287AF1E434F; Thu, 20 Jun 2019 15:06:25 +0200 (CEST)
Date:   Thu, 20 Jun 2019 15:06:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Two fixes for 5.2-rc6
Message-ID: <20190620130625.GB30243@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.2-rc6

to get one small quota fix fixing spurious EDQUOT errors and one fanotify fix
fixing a bug in the new fanotify FID reporting code.

Top of the tree is c285a2f01d69. The full shortlog is:

Amir Goldstein (1):
      fanotify: update connector fsid cache on add mark

yangerkun (1):
      quota: fix a problem about transfer quota

The diffstat is

 fs/notify/fanotify/fanotify.c    |  4 ++++
 fs/notify/mark.c                 | 14 +++++++++++---
 fs/quota/dquot.c                 |  4 ++--
 include/linux/fsnotify_backend.h |  4 +++-
 4 files changed, 20 insertions(+), 6 deletions(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
