Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5AF591D40
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Aug 2022 02:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbiHNAXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Aug 2022 20:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHNAXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Aug 2022 20:23:05 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1280F6580A;
        Sat, 13 Aug 2022 17:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BVjxzt76zxQEttpxFmyMqSEX+gSQjgPlDDnBcFWjjOY=; b=teagfuILIPLlNHDoD+J+krW7yX
        KAnhdD/u5WaqaLxoUNUH2h8ssq6bQ89mMc/6FFe9iO9SRXXSspxL+5s55Hn+fjzqpXHzjWsjAZX+s
        F1bghBaCDCk2QlV72ucAzjdwRPBmmRTsNRzj2dP5Zp7lQV09GkOtWKoU4CkDy2/7QfrQ2Kjp0E3Cc
        2abk/09BoozyBA2wvaz+nKG3VOFBHx6HWHI+k/1XTkQakloukEXO9+UYcyNgvbWm/WZWN2COYvxSX
        1cXdzHdQm5doUEuwO4sU9kPehsKeJ+/PH5m3X4AvzlcootmCexjnvoMfbUbMExZK61GLaiOyaSs+A
        GyTxIUxg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oN1PB-0047xI-C6;
        Sun, 14 Aug 2022 00:23:01 +0000
Date:   Sun, 14 Aug 2022 01:23:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git #work.misc
Message-ID: <YvhAZYm1T4ni+y01@ZenIV>
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

[the last bit from -next]
The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.misc

for you to fetch changes up to ed5fce76b5ea40c87b44cafbe4f3222da8ec981a:

  vfs: escape hash as well (2022-06-28 13:58:05 -0400)

----------------------------------------------------------------
fix for /proc/mounts escaping

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Siddhesh Poyarekar (1):
      vfs: escape hash as well

 fs/proc_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
