Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B051E4BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 19:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbgE0RVp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 13:21:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:38226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387880AbgE0RVo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 13:21:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 767F5AFCE;
        Wed, 27 May 2020 17:21:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 41B0A1E1283; Wed, 27 May 2020 19:21:43 +0200 (CEST)
Date:   Wed, 27 May 2020 19:21:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: [GIT PULL] Fanotify revert for 5.7-rc8
Message-ID: <20200527172143.GB14550@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.7-rc8

to get a patch that disables FAN_DIR_MODIFY support that was merged in
5.7-rc1. When discussing further functionality we realized it may be more
logical to guard it with a feature flag or to call things slightly
differently (or maybe not) so let's not set the API in stone for now.

Top of the tree is f17936993af0. The full shortlog is:

Amir Goldstein (1):
      fanotify: turn off support for FAN_DIR_MODIFY

The diffstat is

 fs/notify/fanotify/fanotify.c | 2 +-
 include/linux/fanotify.h      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
