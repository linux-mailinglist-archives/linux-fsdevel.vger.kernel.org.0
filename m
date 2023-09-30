Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA7F7B42A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 19:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjI3RXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 13:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjI3RXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:23:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B801FA;
        Sat, 30 Sep 2023 10:23:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AECC433C7;
        Sat, 30 Sep 2023 17:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696094585;
        bh=YlNSRETzZewgQmIzaK8O1JfDxjoccXt4+6tSmiu/+ys=;
        h=Date:From:To:Cc:Subject:From;
        b=WCUvhw2mOr/yxGbRvCorUaUYgo+dLGu4JKsnIhkziwEgMT9ZTmKg+CGz+ONRguUQG
         NjMctE6y3VsIfTW+O+U2ZgTZ4s+ZU1G9VHTUXK4ZXyLA56k/9N/3zWi42Z6j/jWhsK
         uypGIhDtw1be7v35J/kif8KSXtt9MhKEVef/VynsGcGMhV9j7npU2H7SsUh0p0vMz8
         pxt3f/wYgU1nw/RQg4o0O8Cjq5eH4CotUd7MvnNfwqbWvmQhKUE0tYdEiDi7y0TLfp
         9U4B8MAhsNYjTs/OkeQG+mDqhP8ahqqozIt24k2Evx2YOwlcG3PhPeu22nqYNz7xtP
         73CZwLwRtdEHg==
Date:   Sat, 30 Sep 2023 10:23:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, torvalds@linux-foundation.org
Cc:     bodonnel@redhat.com, geert+renesas@glider.be, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
Subject: [GIT PULL v2] iomap: bug fixes for 6.6-rc4
Message-ID: <169609450381.1111146.9387085958711753844.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with changes for iomap for 6.6-rc4.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any more problems.

This time with the /correct/ git repo. :(

--D

The following changes since commit a5f31a5028d1e88e97c3b6cdc3e3bf2da085e232:

iomap: convert iomap_unshare_iter to use large folios (2023-09-19 09:05:35 -0700)

are available in the Git repository at:

https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.6-fixes-4

for you to fetch changes up to 684f7e6d28e8087502fc8efdb6c9fe82400479dd:

iomap: Spelling s/preceeding/preceding/g (2023-09-28 09:26:58 -0700)

----------------------------------------------------------------
Bug fixes for 6.6-rc4:

* Handle a race between writing and shrinking block devices by
returning EIO.
* Fix a typo in a comment.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (1):
iomap: add a workaround for racy i_size updates on block devices

Geert Uytterhoeven (1):
iomap: Spelling s/preceeding/preceding/g

fs/buffer.c            | 11 ++++++++++-
fs/iomap/buffered-io.c |  2 +-
2 files changed, 11 insertions(+), 2 deletions(-)
