Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786903AB8A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 18:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhFQQJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 12:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhFQQJD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89130C061767
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 09:06:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id di5so4493067ejc.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=OYEGyVHYGYqRbH8ZHLSjPIgsrKkoPIlQub6xfdwZ9Ho=;
        b=VQBxzv8ElzdIYe5pHztXEAP5cel38j8srlpZLBGD/+Vol7Q1zMx7fkyCJxhI9t1P5b
         ECpQSMza4kCA9voplJ519p0gGPBl8LKKX9FRgCpcoNxIt3+pIigGzB3CP3+34RY5WehS
         v4i1SPotIfQnmXRu17gqPB+Yb1D34+bo84dodfVdHFDgjBKMzMZFgTMxLCMk9j7eZOVV
         AqFdsXdnPynaN20UscbuuVq6MHHQzjdMezLtd8RW/4BLvlfO+/5BwDGnpI+PiBZ7Do17
         GqXn+seFFs/dMlr/MsywGj771EOIli8recFFfu+YbVEWKByN8MR7/YVX13rCu66+RwSN
         si3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OYEGyVHYGYqRbH8ZHLSjPIgsrKkoPIlQub6xfdwZ9Ho=;
        b=NnBqXoMIq5K1TMHd3sF5plRvUNDipDD87ykeDnvct5lSdKSuIAIBKAVYeQubl+V42G
         4DkitXTzUz7Sy7DddrvOA5peloC/TLpc1+cWSFMi2xRdUgiSNXKSpSI84lp++m00lscv
         8/HT5u50Fug2PhoC9jprBgJE2gK2PoIuB7JFBnbUzKWrj6GWut0u7+SfnwN6b9Xgmmxa
         um86jSuz/hnZJA42OdABHPonXtYpS5aJ+z4CGi4v8jyl0UYW+UxptxFfVOyFoDMn2Zm7
         Sj0pnLQz7bZTCD5Qv8ZKQE7COFy9jVk2T99HxolQP+cVAN5Pt2/fg1m1Dz+03O8VBOSy
         KIhA==
X-Gm-Message-State: AOAM533PsP+tm7ErgyFcPpCLRLt2GQBig/Y0swIeeR6pBBs1BzFIkG/q
        SFpntDID008WIPN0gXvPI6bce9twoZosrEZXmGZvcc+1qA==
X-Google-Smtp-Source: ABdhPJx5zsn3s2F1TkP36tYK3PtdVVqKFYZoHS5d2M37Qu1HQT5bt7ty7ihlg6PO99hH4li2n7uDgAAOO2FsS6WDJAk=
X-Received: by 2002:a17:907:2bd1:: with SMTP id gv17mr5988790ejc.15.1623946012652;
 Thu, 17 Jun 2021 09:06:52 -0700 (PDT)
MIME-Version: 1.0
From:   Haiwei Li <lihaiwei.kernel@gmail.com>
Date:   Fri, 18 Jun 2021 00:06:40 +0800
Message-ID: <CAB5KdOat4A7ZP1MDKHuXra7YN8cZ1J_K5W4M+G_Ye44un79_BQ@mail.gmail.com>
Subject: Problem with xfs in an old version
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Sorry to bother. I get a xfs error on kernel 3.10.x. And i don't know how to
debug. I got nothing useful from search engines. So I sent an e-mail
here. If there
are other more suitable ways to discuss the problem, please let me know, thanks!

I have gotten a message on the console.

'-bash: /data/.my_history: Input/output error'

I tried:

# ls -l / | grep data
ls: cannot access /data: Input/output error
d?????????    ? ?    ?        ?            ? data

The mount point info is:

'/dev/vdb on /data type xfs (rw,noatime,attr2,inode64,prjquota)'

System log messages as below:

ffff882b86a34000: 31 38 38 32 30 31 36 0a 00 00 00 00 00 00 00 00
1882016.........
ffff882b86a34010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................
ffff882b86a34020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................
ffff882b86a34030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................
XFS (vdb): Internal error xfs_inode_buf_verify at line 410 of file
XXXX/fs/x[2021-06-17 18:28:51]fs/xfs_inode.c.  Caller
0xffffffffa04d410e

CPU: 0 PID: 7715 Comm: kworker/0:1H Tainted: G     U     O
3.10.107-1-tlinux2_kvm_guest-0051 #1
Hardware name: Smdbmds KVM, BIOS seabios-1.9.1-qemu-project.org 04/01/2014
Workqueue: xfslogd xfs_buf_iodone_work [xfs]
 ffff882ec52d9000 000000001a1ab7e6 ffff882efa97fd50 ffffffff819f1d23
 ffff882efa97fd68 ffffffffa047da9b ffffffffa04d410e ffff882efa97fda0
 ffffffffa047daf5 0000019a00000001 0000000000000001 ffff882b86a34000
Call Trace:
 [<ffffffff819f1d23>] dump_stack+0x19/0x1b
 [<ffffffffa047da9b>] xfs_error_report+0x3b/0x40 [xfs]
 [<ffffffffa04d410e>] ? xfs_inode_buf_read_verify+0xe/0x10 [xfs]
 [<ffffffffa047daf5>] xfs_corruption_error+0x55/0x80 [xfs]
 [<ffffffffa04d40a4>] xfs_inode_buf_verify+0x94/0xe0 [xfs]
 [<ffffffffa04d410e>] ? xfs_inode_buf_read_verify+0xe/0x10 [xfs]
 [<ffffffffa04d410e>] xfs_inode_buf_read_verify+0xe/0x10 [xfs]
 [<ffffffffa047b305>] xfs_buf_iodone_work+0xa5/0xd0 [xfs]
 [<ffffffff8106c00c>] process_one_work+0x17c/0x450
 [<ffffffff8106cebb>] worker_thread+0x11b/0x3a0
 [<ffffffff8106cda0>] ? manage_workers.isra.26+0x2a0/0x2a0
 [<ffffffff810737cf>] kthread+0xcf/0xe0
 [<ffffffff81073700>] ? insert_kthread_work+0x40/0x40
 [<ffffffff81ad5908>] ret_from_fork+0x58/0x90
 [<ffffffff81073700>] ? insert_kthread_work+0x40/0x40
XFS (vdb): Corruption detected. Unmount and run xfs_repair
ffff882b86a34100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................
ffff882b86a34110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................
ffff882b86a34120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................
ffff882b86a34130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................

I reboot and remount. It works normally. No error again. I guess data from the
wrong blocks was returned to XFS.

I have no idea how to reproduce. Our workload sometimes triggers the problem.
To data, the problem only occurs on 3.10.x in three versions 3.10.x, 4.14.x and
5.4.x.

Environment: Containers with workload are running in a kvm vm. The problem
occurs in the kvm vm.

Any ideas on how to debug? Thanks!

--
Haiwei
