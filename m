Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED50A3CAE2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhGOU6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGOU6w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:58:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CDBC6120A;
        Thu, 15 Jul 2021 20:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626382558;
        bh=eVa3YPxlLDd15+D66NQ0t+IiF12L8+DLPWO8dJgMn78=;
        h=Date:From:To:Cc:Subject:From;
        b=VlMi1u71FdpFIeQlkLZNMkyVMx6XDB+HTLHlbXUtExfzvd2lnLKB8ERCTjWmrVDFE
         zhkIKNwAFxiDquNZ3Q3sgzjXfkhjScyZFJJYqSqT2/UlFQ+bSz3JKxfhzBr4G4zZQc
         o5M7ruW6F6VqimT53f1L6xzyuAqe0qGsGkciCtvri7B7g3Cz33VQPxXc+u99A6LXs+
         i90rXH5FnXv3FQciRDidK2CjML+rySmLq7VBVkx63bbB5GPhz9UmRk67rLKRxjLwOI
         YH7O8yV8k0QZZmU02yJo4pumAy297P1QAPJuo2ntrKI9bFqs4ZSVVeIGvAlDuqQkaF
         +cnqIjWfaj9ig==
Date:   Thu, 15 Jul 2021 13:55:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     agruenba@redhat.com
Subject: [ANNOUNCE] xfs-linux: iomap-5.14-fixes updated to 229adf3c64db
Message-ID: <20210715205558.GW22402@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.14-fixes branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the iomap-5.14-fixes branch is commit:

229adf3c64db iomap: Don't create iomap_page objects in iomap_page_mkwrite_actor

New Commits:

Andreas Gruenbacher (3):
      [8e1bcef8e18d] iomap: Permit pages without an iop to enter writeback
      [637d3375953e] iomap: Don't create iomap_page objects for inline files
      [229adf3c64db] iomap: Don't create iomap_page objects in iomap_page_mkwrite_actor

Christoph Hellwig (2):
      [3ac1d426510f] iomap: remove the length variable in iomap_seek_data
      [49694d14ff68] iomap: remove the length variable in iomap_seek_hole


Code Diffstat:

 fs/iomap/buffered-io.c |  8 ++++----
 fs/iomap/seek.c        | 25 +++++++++----------------
 2 files changed, 13 insertions(+), 20 deletions(-)
