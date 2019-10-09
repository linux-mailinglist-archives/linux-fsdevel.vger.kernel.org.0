Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE9D105A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfJINkO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 09:40:14 -0400
Received: from mout02.posteo.de ([185.67.36.66]:40583 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731240AbfJINkN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:40:13 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id E55C12400FB
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2019 15:32:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1570627926; bh=s4wxqYVwGcjKOcKs6F737yArXcYvbBoMUYysMg1+JXc=;
        h=From:To:Cc:Subject:Date:From;
        b=n9ia5HKZGXePVzlEZ4nHJfyqGHsouSryzGgLc6EkQ0XAyeySI5KYYOYDV4+Ucthi5
         1QH7XXPNztMkV90J6FV2P25/3TSpTkI50M1h9EdsgfNWOS9ijGps1ToqVeqPO2oWfO
         9IcBSUqfu7URUXxphhUbQZJPLHlOFpSJEdfNFBBFnlTyY26xHyjAVS5lRGMATAy9xZ
         oSN7P62Rk89TStsBLM7Da/xkWwaRHby53aQzwL/dV+RO0BA5UjJO4V3SDc/PFaVaWG
         9dY0xarrMnjcLq/V3IIBupUHqhoPUkgYtq6BSvAApVUGBelFUqdvkBSX6nsV9bjZtp
         9YSbf3sEikjPA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 46pFW95DkDz9rxN;
        Wed,  9 Oct 2019 15:32:05 +0200 (CEST)
From:   philipp.ammann@posteo.de
To:     linux-fsdevel@vger.kernel.org
Cc:     Philipp Ammann <philipp.ammann@posteo.de>
Subject: [PATCH 0/6] Various exfat fixes
Date:   Wed,  9 Oct 2019 15:31:51 +0200
Message-Id: <20191009133157.14028-1-philipp.ammann@posteo.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Philipp Ammann <philipp.ammann@posteo.de>

These patches are not mine; they are pulled from Github:

  https://github.com/dorimanx/exfat-nofuse/pull/124

Supposedly they're from Samsung.

I've been running them on 4.19 for about over a year without issues.

I know the commit messages are not exactly stellar. Please excuse my
not improving them, but I'm no filesystem guy.

Cheers
  Philipp

Andreas Schneider (6):
  Return a valid count in count_used_clusters()
  Add missing fs_error() in sector functions
  Check that the new path while moving a file is not too long
  Add the exfat version to the module info
  Sync blocks on remount
  Add device ejected to mount options

 drivers/staging/exfat/exfat_core.c  | 19 +++++++++++++++----
 drivers/staging/exfat/exfat_super.c |  9 +++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.21.0

