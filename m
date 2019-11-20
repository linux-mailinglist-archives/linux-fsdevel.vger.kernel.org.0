Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B591036F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 10:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfKTJpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 04:45:36 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42313 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727259AbfKTJpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:45:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TidUqEm_1574243133;
Received: from localhost(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0TidUqEm_1574243133)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Nov 2019 17:45:34 +0800
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     miklos@szeredi.hu, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 0/2] ovl: implement async IO routines 
Date:   Wed, 20 Nov 2019 17:45:24 +0800
Message-Id: <1574243126-59283-1-git-send-email-jiufei.xue@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ovl stacks regular file operations now. However it doesn't implement
async IO routines and will convert async IOs to sync IOs which is not
expected.

This patchset implements overlayfs async IO routines.

Jiufei Xue (2)
vfs: add vfs_iocb_iter_[read|write] helper functions
ovl: implement async IO routines

 fs/overlayfs/file.c      |  116 +++++++++++++++++++++++++++++++++++++++++------
 fs/overlayfs/overlayfs.h |    2
 fs/overlayfs/super.c     |   12 ++++
 fs/read_write.c          |   58 +++++++++++++++++++++++
 include/linux/fs.h       |   16 ++++++
 5 files changed, 188 insertions(+), 16 deletions(-)

