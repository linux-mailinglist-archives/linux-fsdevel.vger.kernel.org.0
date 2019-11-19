Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA8101124
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 03:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfKSCOI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 21:14:08 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:39140 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726761AbfKSCOI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:14:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TiWOCGf_1574129645;
Received: from localhost(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0TiWOCGf_1574129645)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Nov 2019 10:14:05 +0800
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     miklos@szeredi.hu, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] ovl: implement async IO routines 
Date:   Tue, 19 Nov 2019 10:14:01 +0800
Message-Id: <1574129643-14664-1-git-send-email-jiufei.xue@linux.alibaba.com>
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

 fs/overlayfs/file.c      |   97 ++++++-----------------------------------------
 fs/overlayfs/overlayfs.h |    2
 fs/overlayfs/super.c     |   12 -----
 fs/read_write.c          |   58 ----------------------------
 include/linux/fs.h       |   16 -------
 5 files changed, 16 insertions(+), 169 deletions(-)

