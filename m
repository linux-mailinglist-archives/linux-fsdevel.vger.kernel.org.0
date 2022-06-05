Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09C653D90E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 03:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbiFEBWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jun 2022 21:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241886AbiFEBWv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jun 2022 21:22:51 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6135924F24;
        Sat,  4 Jun 2022 18:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZETB36YeZqtq8qxeHpvYEKLfw2qD71PM+UxNYMpBlwk=; b=oFrG6PKFF3ci1VYeqH/D8M2FbK
        mZu8dcawU9Th2EoinIdaTgU3l3fNJ5+bhDhXL+F5sLlczeGGjYyf9xX9GfZn9JAFMuLyrvDbF6aV8
        /eXTkBpQgBz4MFVJXAknSiQu3fdLVboGMqh+Iuinkpkz0w4Z1YtGDNgi3y+Kyj+WqsTq34d9WiPkc
        f38imFBViBoPdWKIcsChn/aFSv6m2htY3Zy8NH61QARyRiofRIiv0xyApA519ijwqCJeFwJIvR3mw
        V63P+g5bCYyaOaqZrqeddm05zFalAGHlIeMz9R43CKs9/mYVQC2OjCFPXUVSB87eoRmNJb6He+Gvg
        /yXBgHoA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxeyf-003dtO-9e; Sun, 05 Jun 2022 01:22:49 +0000
Date:   Sun, 5 Jun 2022 01:22:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] several namei cleanups
Message-ID: <YpwFac1yAziJu/z0@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-18-rc1-work.namei

for you to fetch changes up to 30476f7e6dbcb075850c6e33b15460dd4868c985:

  namei: cleanup double word in comment (2022-05-19 23:26:29 -0400)

----------------------------------------------------------------
Several cleanups in fs/namei.c.

----------------------------------------------------------------
Al Viro (2):
      fs/namei.c:reserve_stack(): tidy up the call of try_to_unlazy()
      get rid of dead code in legitimize_root()

Tom Rix (1):
      namei: cleanup double word in comment

 fs/namei.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)
