Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC0C12A5A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 03:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLYCzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 21:55:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfLYCzU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 21:55:20 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D2BDB7AA5BEBD1ADFDB3;
        Wed, 25 Dec 2019 10:55:18 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 10:55:09 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <mszeredi@redhat.com>, <linux-fsdevel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 0/4] fuse: use true,false for bool variable
Date:   Wed, 25 Dec 2019 11:02:26 +0800
Message-ID: <1577242950-30981-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zhengbin (4):
  fuse: use true,false for bool variable in readdir.c
  fuse: use true,false for bool variable in file.c
  fuse: use true,false for bool variable in cuse.c
  fuse: use true,false for bool variable in inode.c

 fs/fuse/cuse.c    |  4 ++--
 fs/fuse/file.c    |  4 ++--
 fs/fuse/inode.c   | 14 +++++++-------
 fs/fuse/readdir.c |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

--
2.7.4

