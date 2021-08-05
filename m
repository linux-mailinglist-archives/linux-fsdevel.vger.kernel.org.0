Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875193E1B2D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 20:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbhHESZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 14:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241011AbhHESZO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:25:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3645461104;
        Thu,  5 Aug 2021 18:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628187900;
        bh=KuKFpvZEGxVX4yyXhNxQM6HL94jrSXWw/jRqUXot0mU=;
        h=Date:From:To:Cc:Subject:From;
        b=rBY8wCG4T6pvt00O1d6WU8V7Zhq+ZpolhqMdyD0fKil7iJrkjBcRaS688+rQqklRs
         RnXVaTa/ygeBR6cMZ8XI8dTDAJdPKosxiwg2z6HdnBm/TIKcsX63FJOEw9hD9oDt9R
         +RnsD42d/LAeRlziLl2ldTXe/8c1RUzKTnoZa5ZuzA12qkl+82p5zn6S3TyxeEKEhm
         Q+wpm6FDOTfuANEgJQDzcgg9x00F3u4o7iaXRZt+iaRGy3yxeRUHHIEAOQdRsAmGW7
         U1xEQZnNljhzrn1DMLdvCTFXzk0C7gieeefGFp3upflBn5OM1xzYHa2KhYeTk1zSue
         fwklFaYd5Po6g==
Date:   Thu, 5 Aug 2021 11:24:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Cc:     Wang Shilong <wangshilong1991@gmail.com>
Subject: [ANNOUNCE] xfs-linux: vfs-5.15-merge updated to d03ef4daf33a
Message-ID: <20210805182459.GY3601443@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The vfs-5.15-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  Here's a single patch to tighten project quota id
checking.

The new head of the vfs-5.15-merge branch is commit:

d03ef4daf33a fs: forbid invalid project ID

New Commits:

Wang Shilong (1):
      [d03ef4daf33a] fs: forbid invalid project ID


Code Diffstat:

 fs/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)
