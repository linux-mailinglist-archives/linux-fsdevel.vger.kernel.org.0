Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A03E1B27
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 20:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbhHESW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 14:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237370AbhHESWz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:22:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16FF761104;
        Thu,  5 Aug 2021 18:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628187761;
        bh=xf1EO6vpWlDvbR3GGuw/iY2BzuNM81ziHAaiegMS7QA=;
        h=Date:From:To:Cc:Subject:From;
        b=a2nOBjG3epNarvvavygK8sprmQtC9CE1KQmigYTgKCn/PbxM2BZ1aT+wHLo3l5Siz
         /B6+5gKz92rtfDoC1FPtksRpcQ+k6Dev733h+9700UmG2v2+Mkp8kUk7Tc22eFI0c/
         FvZCVw0wdicoGCH55+vp0HupMS0QChFdCYJje+ogDAMyM8gwkl9Z65dTGE+I9P0iL2
         gTXCZYQ3ket7UU+6g/S7CEisLlVpvPTYB1gOI0Lpr7RNLmsbONCn3wR+p70JCnxKXr
         J6mAHKJSigkVGOccACYUQSQ2ezfhoEFezp56i0AhRAxuKO25FXFgJ03c68CFpzHL7S
         icqCvCPJWhqEQ==
Date:   Thu, 5 Aug 2021 11:22:40 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-5.15-merge updated to ae44f9c286da
Message-ID: <20210805182240.GX3601443@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.15-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  Just sneaking in a couple more patches from Matthew
Wilcox so that (presumably) Christoph has a stable place to rebase the
iomap_iter series.

The new head of the iomap-5.15-merge branch is commit:

ae44f9c286da iomap: Add another assertion to inline data handling

New Commits:

Andreas Gruenbacher (1):
      [f1f264b4c134] iomap: Fix some typos and bad grammar

Christoph Hellwig (2):
      [d0364f9490d7] iomap: simplify iomap_readpage_actor
      [c1b79f11f4ec] iomap: simplify iomap_add_to_ioend

Gao Xiang (1):
      [69f4a26c1e0c] iomap: support reading inline data from non-zero pos

Matthew Wilcox (Oracle) (3):
      [b405435b419c] iomap: Support inline data with block size < page size
      [ab069d5fdcd1] iomap: Use kmap_local_page instead of kmap_atomic
      [ae44f9c286da] iomap: Add another assertion to inline data handling


Code Diffstat:

 fs/iomap/buffered-io.c | 165 +++++++++++++++++++++++++------------------------
 fs/iomap/direct-io.c   |  10 +--
 include/linux/iomap.h  |  18 ++++++
 3 files changed, 108 insertions(+), 85 deletions(-)
