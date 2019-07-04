Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5375FDFB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 22:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfGDU5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 16:57:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58306 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDU5m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:57:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hj8nV-00016d-1S; Thu, 04 Jul 2019 20:57:41 +0000
Date:   Thu, 4 Jul 2019 21:57:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] do_move_mount() fix
Message-ID: <20190704205740.GJ17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Regression fix...

The following changes since commit d728cf79164bb38e9628d15276e636539f857ef1:

  fs/namespace: fix unprivileged mount propagation (2019-06-17 17:36:09 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 570d7a98e7d6d5d8706d94ffd2d40adeaa318332:

  vfs: move_mount: reject moving kernel internal mounts (2019-07-01 10:46:36 -0400)

----------------------------------------------------------------
Eric Biggers (1):
      vfs: move_mount: reject moving kernel internal mounts

 fs/namespace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
