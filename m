Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD10720B423
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 17:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgFZPFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 11:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgFZPFC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:05:02 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C342206E9;
        Fri, 26 Jun 2020 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593183902;
        bh=p/3If5DPn1u2nlI9onpW6gMxW3c9vb7aDYcf/r+jStk=;
        h=From:To:Cc:Subject:Date:From;
        b=qe8l7G0g4avILFfCxWGviR10U4cJg0Ls+ryR+p0Glwq4ar3rpi1K8eYVoLBwePqVE
         gx3uYFm5HrBAZ8gTWytMrFN8VPtpVoLbL1BvgIe98yh8s6SMefxsZuEqb1efXDSzrd
         08xBpqOK3THHV97r2k6IBX8gSURnuXWk39Zkl0qU=
From:   Jeff Layton <jlayton@kernel.org>
To:     dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, andres@anarazel.de
Subject: [fsinfo PATCH v2 0/3] fsinfo: add error state information to fsinfo
Date:   Fri, 26 Jun 2020 11:04:57 -0400
Message-Id: <20200626150500.565417-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

I sent a draft version of these patches back in 2018. The per-sb
errseq_t tracking was just merged for v5.8, so most of the underlying
infrastructure is now in place. Wiring up the reporting of that to
fsinfo() is fairly trivial.

Can you toss these onto your fsinfo pile? If that goes in at some point
in the future, it'd be nice to have this infolevel available on day 1.
This is based on your current fsinfo-core branch. The patches are also
available here if you want to cherry-pick them instead:

    https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/log/?h=fsinfo-wberr


Thanks!

Jeff Layton (3):
  errseq: add a new errseq_scrape function
  vfs: allow fsinfo to fetch the current state of s_wb_err
  samples: add error state information to test-fsinfo.c

 fs/fsinfo.c                 | 11 +++++++++++
 include/linux/errseq.h      |  1 +
 include/uapi/linux/fsinfo.h | 13 +++++++++++++
 lib/errseq.c                | 33 +++++++++++++++++++++++++++++++--
 samples/vfs/test-fsinfo.c   | 10 ++++++++++
 5 files changed, 66 insertions(+), 2 deletions(-)

-- 
2.26.2

