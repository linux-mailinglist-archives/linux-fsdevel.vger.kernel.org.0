Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB143BA317
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhGBQMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 12:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBQMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 12:12:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7199DC061762;
        Fri,  2 Jul 2021 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9Su4+fIhHOamI8mtHJM3TOapkHzMKdzYKZYFYT0F6/k=; b=K9zdDZH+4wmo0a9A8QGcXJgE8v
        wyDKfCUhhDDdXkwJHCyGxvtrj2lXeWpUA5BIfAjJeiQJmAyLHRX+ZIRTCLBHtLmkDJY6kzpm+CeIN
        cPk9cP1CvViIdA32cEXh+U1YnwUxh3qJK9YdSwwpqUgoNIyMXGa20nJZJGrGkWScYjp4kUV6poxPK
        IeuixZ1XRGVWvJVqAJ93fScsGfnls47bpY3TGeJEi6BuxmF5/GxjGP6YoqbHLpOf15SgboZRKq6XX
        etz8vVzLV2hTR98DMz/J3s4j0D1PIHNQ1NUx9Kc+MFmbRJVQZzxu3SA0I7/MDPnbr8tJuDt3LO8he
        iPL9dOeg==;
Received: from [2001:4bb8:180:285:6928:4a94:34bd:6961] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzLjW-007qgB-P3; Fri, 02 Jul 2021 16:09:46 +0000
Date:   Fri, 2 Jul 2021 18:09:37 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Joel Becker <jlbec@evilplan.org>
Subject: [GIT PULL] configfs updates for Linux 5.13
Message-ID: <YN86Qdthbzfa5wfY@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-5.13

for you to fetch changes up to c886fa3cf6ffbe13006053ceb27c93d41928de30:

  configfs: simplify configfs_release_bin_file (2021-06-22 09:46:28 +0200)

----------------------------------------------------------------
configfs updates for Linux 5.13

 - fix a memleak in configfs_release_bin_file (Chung-Chiang Cheng)
 - implement the .read_iter and .write_iter (Bart Van Assche)
 - minor cleanups (Bart Van Assche, me)

----------------------------------------------------------------
Bart Van Assche (2):
      configfs: fix the kerneldoc comment for configfs_create_bin_file
      configfs: implement the .read_iter and .write_iter methods

Christoph Hellwig (2):
      configfs: drop pointless kerneldoc comments
      configfs: simplify configfs_release_bin_file

Chung-Chiang Cheng (1):
      configfs: fix memleak in configfs_release_bin_file

 fs/configfs/file.c | 181 +++++++++++++++--------------------------------------
 1 file changed, 51 insertions(+), 130 deletions(-)
