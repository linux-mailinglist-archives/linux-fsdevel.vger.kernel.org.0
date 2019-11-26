Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F00301097AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 03:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfKZCCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 21:02:03 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33649 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726970AbfKZCCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:02:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tj6VIFa_1574733719;
Received: from ali-186590e05fa3.local(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0Tj6VIFa_1574733719)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Nov 2019 10:02:00 +0800
Subject: Re: [PATCH V2 0/2] ovl: implement async IO routines
To:     miklos@szeredi.hu, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1574243126-59283-1-git-send-email-jiufei.xue@linux.alibaba.com>
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
Message-ID: <052a9b10-1cca-35d0-622a-d597421b3ecf@linux.alibaba.com>
Date:   Tue, 26 Nov 2019 10:00:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1574243126-59283-1-git-send-email-jiufei.xue@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi miklos,

Could you please kindly review this patch and give some advice?

Thanks,
Jiufei

On 2019/11/20 下午5:45, Jiufei Xue wrote:
> ovl stacks regular file operations now. However it doesn't implement
> async IO routines and will convert async IOs to sync IOs which is not
> expected.
> 
> This patchset implements overlayfs async IO routines.
> 
> Jiufei Xue (2)
> vfs: add vfs_iocb_iter_[read|write] helper functions
> ovl: implement async IO routines
> 
>  fs/overlayfs/file.c      |  116 +++++++++++++++++++++++++++++++++++++++++------
>  fs/overlayfs/overlayfs.h |    2
>  fs/overlayfs/super.c     |   12 ++++
>  fs/read_write.c          |   58 +++++++++++++++++++++++
>  include/linux/fs.h       |   16 ++++++
>  5 files changed, 188 insertions(+), 16 deletions(-)
> 
