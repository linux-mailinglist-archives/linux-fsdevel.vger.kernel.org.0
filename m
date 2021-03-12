Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0170E3396B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 19:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhCLSfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 13:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbhCLSf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:35:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2F0C061574;
        Fri, 12 Mar 2021 10:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=piRB9Z0CGXusZGzLJ8gLByzrA0NYuSQrO7tVIHfyTkA=; b=ctNskBep2VPlvpANIQTQE40mn6
        rtw7KDz2HlZK5nR4hQ1b1/zECGDDmPGhOnMjyMb82gIJ5Trj82hIB0HnzI0CNI0nhAOm64sEYa35L
        /8oGdgf3aMCFy2O6SdKCtp/8qdtH50mRUxJ3X+J6Alpp3XLUbyBHOgcfvaCJl1r1ItJncMOY6I+rT
        5sbNDT5gEoeNXiyi2HucR2f0sCzF51ZFJ0CncsXQNnd4IHv0P1FpQlQ3/wgXUBz88ZK5AGsqCycqE
        /gYA97rrIEm2n4rrU/QpAzhs5dmmtNNGpF0tjX3IW3gS8c7TQNax5sAQ+FkLq2U1XcKYrsV8xE4Ag
        Jpppr8wA==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKmcn-00BP85-T9; Fri, 12 Mar 2021 18:35:06 +0000
Date:   Fri, 12 Mar 2021 19:35:01 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] configfs fix for 5.12
Message-ID: <YEu0VSxxvvCZorin@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit a74e6a014c9d4d4161061f770c9b4f98372ac778:

  Merge tag 's390-5.12-3' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2021-03-10 13:15:16 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.12

for you to fetch changes up to 14fbbc8297728e880070f7b077b3301a8c698ef9:

  configfs: fix a use-after-free in __configfs_open_file (2021-03-11 12:13:48 +0100)

----------------------------------------------------------------
configfs fix for 5.12

 - fix a use-after-free in __configfs_open_file
   (Daiyue Zhang)

----------------------------------------------------------------
Daiyue Zhang (1):
      configfs: fix a use-after-free in __configfs_open_file

 fs/configfs/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
