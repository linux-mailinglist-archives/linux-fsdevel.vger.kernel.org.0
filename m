Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0836B4543
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 03:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391635AbfIQBhm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 21:37:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36396 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730648AbfIQBhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:37:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iA2R3-0004hi-Ee; Tue, 17 Sep 2019 01:37:41 +0000
Date:   Tue, 17 Sep 2019 02:37:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] d_path fixup
Message-ID: <20190917013741.GE1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	d_absolute_path() regression in the last cycle (felt by tomoyo,
mostly)

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache

for you to fetch changes up to f2683bd8d5bdebb929f05ae26ce6d9b578927ce5:

  [PATCH] fix d_absolute_path() interplay with fsmount() (2019-08-30 19:31:09 -0400)

----------------------------------------------------------------
Al Viro (1):
      fix d_absolute_path() interplay with fsmount()

 fs/d_path.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
