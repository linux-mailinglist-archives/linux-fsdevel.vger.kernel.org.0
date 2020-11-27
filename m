Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EB92C63FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 12:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgK0LhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 06:37:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:53998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbgK0LhK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:37:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1FADABD7;
        Fri, 27 Nov 2020 11:37:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 94EFD1E1318; Fri, 27 Nov 2020 12:37:09 +0100 (CET)
Date:   Fri, 27 Nov 2020 12:37:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Writeback fis for 5.10-rc6
Message-ID: <20201127113709.GA27162@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git writeback_for_v5.10-rc6

to get a fix of possible missing string termination in writeback
tracepoints.

Top of the tree is fdeb17c70c9e. The full shortlog is:

Hui Su (1):
      trace: fix potenial dangerous pointer

The diffstat is

 include/trace/events/writeback.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
