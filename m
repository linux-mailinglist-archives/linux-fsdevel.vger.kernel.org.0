Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BCD455974
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 11:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbhKRKz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 05:55:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36256 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343547AbhKRKzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 05:55:12 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CBE541FD29;
        Thu, 18 Nov 2021 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637232730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=CA1m8hUH1F2+qKqXAymKJds50YJgf62Qw6EQ8PWz7/4=;
        b=sxTueWnbOWtKrv+QtoJuYVK0tulk7eUd0ZtC19p3d4AyGmjG8DZjjXL6VuxKAtj3aI/6k9
        GNpe4Ivq32At8jyyeLRHLGwKetygxPORjMjSFeXjO0SioqxfvmFwnv83Eo+NxsYUd1Y8hY
        aapvCx7Xdp+0JXsYqYtx+uPL+It7pG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637232730;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=CA1m8hUH1F2+qKqXAymKJds50YJgf62Qw6EQ8PWz7/4=;
        b=8ktcn3RR+7YA2oZMQKmqkvdLjD7dDDuS7KLXfDKzKxmMjFoGohex26JIIf4IwlOgy8rZzs
        5sCmxJ/ImP1IwmCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id BB5F3A3B81;
        Thu, 18 Nov 2021 10:52:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7C7111F2C78; Thu, 18 Nov 2021 11:52:10 +0100 (CET)
Date:   Thu, 18 Nov 2021 11:52:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] UDF fix for 5.16-rc2
Message-ID: <20211118105210.GC13047@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.16-rc2

to get a fix for long-standing UDF bug where we were not properly
validating directory position inside readdir.

Top of the tree is a48fc69fe658. The full shortlog is:

Jan Kara (1):
      udf: Fix crash after seekdir

The diffstat is

 fs/udf/dir.c   | 32 ++++++++++++++++++++++++++++++--
 fs/udf/namei.c |  3 +++
 fs/udf/super.c |  2 ++
 3 files changed, 35 insertions(+), 2 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
