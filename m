Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D85E59262A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Aug 2022 21:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiHNTWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Aug 2022 15:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiHNTWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Aug 2022 15:22:50 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19041EAC2;
        Sun, 14 Aug 2022 12:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fIv76NqDast2njAn90O8GRnQzUuvqx0lJYTKZ4uwx94=; b=h0DjMEk50DI5WvkkK9w0eMWEMO
        WpH+CADq1JqZa7S3HcYrt4iB2piDgNbUAjVX5UzB9wwmJkbjA5JWhjaFjmcJclggAPH1IwLjDyAJ+
        crz1aEcu4uz9Tw2IaTZY6rmrvzK9YFxf0KhKFLfaSn3LbwJecOlgsp68q7npYXCQSlgu3re3QrI6t
        FtPgBB3/1SFbT79WwHFlrPBTANomOuhjcb1GuTh30jx4idH+gYkp85B2STfcfBDxy37pJjk6myAUh
        e7IzttPds+e6L3MElLnPrk5JH4rIwNH1VzVDWykyc9NytQzG0sgnVp/zX1pmAc60AUxh0SkrUoJYE
        HGInECZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oNJCB-004KD6-Jy;
        Sun, 14 Aug 2022 19:22:47 +0000
Date:   Sun, 14 Aug 2022 20:22:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [git pull] regression fix in lseek series
Message-ID: <YvlLh8qZnCTmACaf@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 5d6a0f4da9275f6c212de33777778673ba91241a:

  Merge tag 'for-linus-6.0-rc1b-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip (2022-08-14 09:28:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 3f61631d47f115b83c935d0039f95cb68b0c8ab7:

  take care to handle NULL ->proc_lseek() (2022-08-14 15:16:18 -0400)

----------------------------------------------------------------
Fix proc_reg_llseek() breakage.  Always had been possible if
somebody left NULL ->proc_lseek, became a practical issue now.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      take care to handle NULL ->proc_lseek()

 fs/proc/inode.c | 3 +++
 1 file changed, 3 insertions(+)
