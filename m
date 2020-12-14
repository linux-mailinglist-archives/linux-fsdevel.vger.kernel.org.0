Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CED12D98AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 14:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407941AbgLNNXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 08:23:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407791AbgLNNX3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:23:29 -0500
Message-ID: <f325fd49b5e185cf77a906db48ed590a46c75ef6.camel@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607952168;
        bh=xjZ3pHqKzICtRPl9M4IUtDwVSELwVI8aQZwUptYA7Gg=;
        h=Subject:From:To:Cc:Date:From;
        b=KeOWG8NXyI70Zr8bnu6CKG8Cr944O9RJP0uPe4DE+P/Djuh0lxI8Si+TiraNrD6um
         gpkqYmOPHpQNZ40Y8OZ31CO7ecmwqkvhw+cBNjErPm/ILeq8wfsQk2qhAgavf10I4l
         kbaIvGIE/Bwxqwm4q+/TrOfQz+RJK4qOLtMBHOg7poNbxrNJ/hZHTaKPDaPNhcU1F2
         CEq6w6qsSxxhtrxlqqWWACAiiPHw/B2lOmG6AAI/87bY24Ua9VlXgy4/WgibSy0HGU
         JuSYFeoPIJOC+FnChpp0MuHrC4M4/Eo3e9usTg1r+a66ZUO2G0qZkkWjXSaCp3ifgg
         oBw7QE/etzlKw==
Subject: [GIT PULL] file locking fixes for 5.11
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        Luo Meng <luomeng12@huawei.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>
Date:   Mon, 14 Dec 2020 08:22:46 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git locks-v5.11

for you to fetch changes up to 8d1ddb5e79374fb277985a6b3faa2ed8631c5b4c:

  fcntl: Fix potential deadlock in send_sig{io, urg}() (2020-11-05 07:44:15 -0500)

----------------------------------------------------------------

A fix for some undefined integer overflow behavior, a typo in a comment
header, and a fix for a potential deadlock involving internal senders of
SIGIO/SIGURG.

----------------------------------------------------------------
Boqun Feng (1):
      fcntl: Fix potential deadlock in send_sig{io, urg}()

Luo Meng (1):
      locks: Fix UBSAN undefined behaviour in flock64_to_posix_lock

Mauro Carvalho Chehab (1):
      locks: fix a typo at a kernel-doc markup

 fs/fcntl.c | 10 ++++++----
 fs/locks.c |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
Jeff Layton <jlayton@kernel.org>

