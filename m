Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78F514E7C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 05:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgAaEH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 23:07:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbgAaEH4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 23:07:56 -0500
Received: from localhost (unknown [148.87.23.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D6E2067C;
        Fri, 31 Jan 2020 04:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580443675;
        bh=XIeaxEWK1mrLmoM0G35VztUKYFHHBWwEZ5TMhYQByAA=;
        h=Date:From:To:Cc:Subject:From;
        b=0rNPOyR8wazibZtS/ZpAm7xqwqBjKRW1XxnbUfWxlFl5vb4gd+4wleYkCz9cLfef5
         4HosjGjdO9LEikhqbVtai7z1s2N0USMA8fHRpfcJgTnCOTPDOKY6RvNmufFw83B0Tt
         UtgU6cBndE745V+qMczHEkYzp6Z16ic+qfMXiqwU=
Date:   Thu, 30 Jan 2020 20:07:53 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] iomap: new code for 5.6
Message-ID: <20200131040753.GB6869@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this set of new code for 5.6.  There's a single patch fixing
an off-by-one error when we're checking to see how far we're gotten into
an EOF page.

--D

The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.6-merge-3

for you to fetch changes up to 243145bc4336684c69f95de0a303b31f2e5bf264:

  fs: Fix page_mkwrite off-by-one errors (2020-01-06 08:58:23 -0800)

----------------------------------------------------------------
New code for 5.6:
- Fix an off-by-one error when checking if offset is within inode size

----------------------------------------------------------------
Andreas Gruenbacher (1):
      fs: Fix page_mkwrite off-by-one errors

 fs/iomap/buffered-io.c  | 18 +++++-------------
 include/linux/pagemap.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 13 deletions(-)
