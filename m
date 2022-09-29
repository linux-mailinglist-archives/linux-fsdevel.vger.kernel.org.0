Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488365EFD65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 20:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiI2Sv3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 14:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiI2Sv2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:51:28 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C9713D844;
        Thu, 29 Sep 2022 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=W0f396vANTbCmHYHj2tm2aCLaD8gO1TJTJudX2/2Tq8=; b=uAHAo37P86b6S1xYMIdkbXB2y8
        6PgzFck2eKW88WStwNlCNQUnTxbtUKYdcM6/OO33qglO4J4Fu9oXerx3sqD1f38C0fAqT0aDJCbTH
        yDFBXYEVAFD8a+spOp+ZxB53XpuxVxEvEDmuInM+hkFGhWbkZ9FuuB51AZswg+bkczsuTi2q0K4pL
        cgRRYLeX+DzyTeC+0fkYENgyorQmcEQrQo7xYKF0DmBBHT/dKovZQpHhEW3pcvab7uyMXavjCKMjO
        8uKoUHYrhYdQq1YM0n0dRsWbyljJC6bNDkFr8CmiYi5K4OBnMkkQYtKh47b4HxTdpd5CJ4cDpb/wL
        zx3z7/Hw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1odyd4-00541K-26;
        Thu, 29 Sep 2022 18:51:26 +0000
Date:   Thu, 29 Sep 2022 19:51:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] coredump fix
Message-ID: <YzXpLm049wRqYIN6@ZenIV>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 06bbaa6dc53cb72040db952053432541acb9adc7:

  [coredump] don't use __kernel_write() on kmap_local_page() (2022-09-28 14:28:40 -0400)

----------------------------------------------------------------
fix for breakage in dump_user_range()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (2):
      nfsd_splice_actor(): handle compound pages
      [coredump] don't use __kernel_write() on kmap_local_page()

 fs/coredump.c   | 38 +++++++++++++++++++++++++++++++++-----
 fs/internal.h   |  3 +++
 fs/nfsd/vfs.c   | 12 ++++++++----
 fs/read_write.c | 22 ++++++++++++++--------
 4 files changed, 58 insertions(+), 17 deletions(-)
