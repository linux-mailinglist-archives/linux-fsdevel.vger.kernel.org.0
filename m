Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550D16EC45F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 06:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDXE2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 00:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXE17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 00:27:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D61E43;
        Sun, 23 Apr 2023 21:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=z4t4njBkkZahDYSDS31FO0dzlBvYxoi0okFpFfbkREg=; b=V+FuPBbuKpZFbH59fg+i2JozCH
        78H4dlxHu0uapYyUfBfBvnFlr6bTzNpiIMgqBUTUL2inMMDwcb/FiEb9utvnzjDiYyk8Zd/C7qY7+
        WrWsDKWlUkT1ZixS4hAnAlcLExXtpaX/kPtQ2kH8N/lort18HdRbdhrqSmXYT+/h3pJp6CLe31SL8
        0GmQkgc0EnnTLW6p1qM9WFzJB1Py1Un8YTUzmt1qqhXAdpgk8rVnDFAKIzNA50CsQ55IrzbNoOdyf
        LMEiyEgzSfXCzM18cmgHcXty8spee1a2aE8tPzOOYT2jlp2eYGd5/4YFCTY6aYfWrv58yOG6bGvMf
        YxEbrAAQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pqnnx-00C0JJ-0q;
        Mon, 24 Apr 2023 04:27:57 +0000
Date:   Mon, 24 Apr 2023 05:27:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] old dio cleanup
Message-ID: <20230424042757.GK3390869@ZenIV>
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

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-old-dio

for you to fetch changes up to 0aaf08de8426f823bd0e36797445222e6392e374:

  __blockdev_direct_IO(): get rid of submit_io callback (2023-03-05 20:27:41 -0500)

----------------------------------------------------------------
legacy direct-io cleanup

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      __blockdev_direct_IO(): get rid of submit_io callback

 fs/direct-io.c     | 9 ++-------
 fs/ocfs2/aops.c    | 2 +-
 include/linux/fs.h | 4 ++--
 3 files changed, 5 insertions(+), 10 deletions(-)
