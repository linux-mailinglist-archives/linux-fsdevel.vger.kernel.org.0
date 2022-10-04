Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56F85F47E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 18:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJDQv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJDQvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:51:55 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432A34D240;
        Tue,  4 Oct 2022 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=O+CRJ06/SQgdwNjx9C07Afubw8m5EtZ+PPErbqLDzxQ=; b=LoXcs7ThW6N7jyoXMRLtcMSlAe
        r6YmNjQxmuZuiFQkPWGyo64sMuhQ5GQ4Ag1mbY6tEScKILH7nJlQ+oNPUbHltVWZ5iaj94XBdpJ6D
        +ZOxGMnT/yra6kpPp6D09u5E9hGk4kARHD37edN3gmzjGu/tYQ4EHje+oklFyUcqUcLvF2jw8Pmgq
        s562LUPSZBKKRbEPMaQf4CJMtJ3aMbYAEaaY39Jf6eQV8gBziqJsII7jz70Rf8dUzo5Pqg+sONBXW
        B+zzUE7Do6fIq6/rqFGzCK6q36WwEuzgEyErIvvB5HYJFoWnfRP0HukWfPV0kvkB/zuX1DH+8xlY2
        Tq0s1I0g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ofl94-0072D3-13;
        Tue, 04 Oct 2022 16:51:50 +0000
Date:   Tue, 4 Oct 2022 17:51:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git pile 1 (inode)
Message-ID: <Yzxkpi7JBteYzQMt@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-inode

for you to fetch changes up to 2e488f13755ffbb60f307e991b27024716a33b29:

  fs: fix UAF/GPF bug in nilfs_mdt_destroy (2022-09-01 17:30:24 -0400)

----------------------------------------------------------------
saner inode_init_always()

----------------------------------------------------------------
Dongliang Mu (1):
      fs: fix UAF/GPF bug in nilfs_mdt_destroy

 fs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)
