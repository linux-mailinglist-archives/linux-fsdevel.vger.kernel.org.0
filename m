Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAEA28F7E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 19:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbgJORyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 13:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgJORyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:54:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370B8C061755;
        Thu, 15 Oct 2020 10:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UWw8rWOodDFZT2buyvbNx32Sq1dxiNIaygZ55Xvnuc0=; b=Q/zGbRxvVPMd4f0uzFNzg0bRSA
        Plngl5a5GrPiRl/zt39Ei9hsDZH0mDvkYC4dtOOUpz78WvHjyVivPiHHVgUVHEfc9bZ6APoaQYq/x
        XatmQofq9QlYWnCOcTxR7Zwl1qnjp8hUkPf4ACfGDHoyGAo67yQl0JlLhaC+Bdos2j6q54QlQd6o6
        DX5bJgBaLz3I8raM8T6G6TV6q5NLQ8BuIlHgFk13PP0oaV3omiMZNSFhzJbUa3D/rHOqE6B4ti0ij
        c66O5NIjuc1YRbWTpqnUVnZXTNpBivE9bAu09yEhfE1j39uv+RrQEfEml7eHhFOjSisth+gok2MRm
        JOQEo2rA==;
Received: from [2001:4bb8:18c:20bd:29e4:ece2:b708:aaf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT7Ry-0000st-9T; Thu, 15 Oct 2020 17:54:02 +0000
Date:   Thu, 15 Oct 2020 19:54:01 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] configfs updates for 5.10
Message-ID: <20201015175312.GA2648919@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[resent with the mailing lists in Cc]

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-5.10

for you to fetch changes up to 76ecfcb0852eb0390881a695a2f349b804d80147:

  samples: configfs: prefer pr_err() over bare printk(KERN_ERR (2020-10-07 15:46:22 +0200)

----------------------------------------------------------------
configfs updates for 5.10

 - various cleanups for the configfs samples (Bartosz Golaszewski)

----------------------------------------------------------------
Bartosz Golaszewski (9):
      MAINTAINERS: add the sample directory to the configfs entry
      samples: configfs: remove redundant newlines
      samples: configfs: drop unnecessary ternary operators
      samples: configfs: fix alignment in item struct
      samples: configfs: replace simple_strtoul() with kstrtoint()
      samples: configfs: don't reinitialize variables which are already zeroed
      samples: configfs: consolidate local variables of the same type
      samples: configfs: don't use spaces before tabs
      samples: configfs: prefer pr_err() over bare printk(KERN_ERR

 MAINTAINERS                        |  1 +
 samples/configfs/configfs_sample.c | 59 ++++++++++++--------------------------
 2 files changed, 20 insertions(+), 40 deletions(-)
