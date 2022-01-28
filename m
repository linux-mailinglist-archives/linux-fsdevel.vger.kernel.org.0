Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41D349F80A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 12:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348052AbiA1LSN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 06:18:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54686 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiA1LSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:18:12 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C5036212BB;
        Fri, 28 Jan 2022 11:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643368691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=PDtEXS06NbGGxrlBVb11B6XOIP1bsf6Uiis30lGb1Bs=;
        b=EYLv5hzbg1dxTJSqzPJLhgTyYkVNG9zAJ3bFRiFWZpQalEK9RukOLz5V+BU9HZSfm9yhI+
        0LwWHGSwdscZKXRT8WZGN43KV/I3IG5M6lVEuK5rR13YFLpR7Eu8BGKjzJf55fYOGWdrro
        m5TPopaczSi7/11Ch0w7MCVGjJZ1oPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643368691;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=PDtEXS06NbGGxrlBVb11B6XOIP1bsf6Uiis30lGb1Bs=;
        b=rW7toKAKHgVehOR7gQY0ifG8wWuYtIJbI8eV/CuBwS7QkAaNeFKTc6Gt8pbkDKZJTVfDjb
        e/E0x1l2iam/IDDw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B9D63A3B85;
        Fri, 28 Jan 2022 11:18:11 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7FA84A05E6; Fri, 28 Jan 2022 12:18:11 +0100 (CET)
Date:   Fri, 28 Jan 2022 12:18:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] udf and quota fixes for 5.17-rc2
Message-ID: <20220128111811.ijyqfq6fckxutuoi@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.17-rc2

to get fixes for crashes in UDF when inode expansion fails and one quota
cleanup.

Top of the tree is 9daf0a4d32d6. The full shortlog is:

Jan Kara (2):
      udf: Fix NULL ptr deref when converting from inline format
      udf: Restore i_lenAlloc when inode expansion fails

Tom Rix (1):
      quota: cleanup double word in comment

The diffstat is

 fs/udf/inode.c        | 9 ++++-----
 include/linux/quota.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
