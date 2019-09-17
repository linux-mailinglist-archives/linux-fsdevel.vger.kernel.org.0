Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73433B44EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 02:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfIQAoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 20:44:03 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:41025 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbfIQAoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 20:44:03 -0400
Received: by mail-lj1-f170.google.com with SMTP id f5so1657132ljg.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2019 17:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CmepM7tyQZLkqWxX8WjGWF6487Y7gA06HRFKZw4di9c=;
        b=Z7LC7EB/yDzgFtDgxXqzybdaPs1rNG8sXOa8dHtngNYNASYRduTiAQWsDt0czYUlzR
         ZK1R0hWOSbijKQk3rth+OdlHrWiXk4s5uIyundZ51cOusZr/9Xyi8+vOAJpqSA+DOvZW
         ig22vd3LygvxiMI8DA1kTLgWIutt81GT4dE6EghRPodILycsLaZPQu6gK1mqHvLkNlyk
         e46KLQf+mLMbn+WunGRF8jPbaMPdkWNd0a00u9fsC/DByD42PxAK9POGfIhSGCb1iu50
         SKL3o8ZLiffn6jHdD48yR9Q3J+Ky2hnCR70th9S/MSgR9e22fd6lV+ytSerrttAXj+QP
         zAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CmepM7tyQZLkqWxX8WjGWF6487Y7gA06HRFKZw4di9c=;
        b=gMxnRzHM2JKDgALxRHFtT/o80hMRaZqQlK9MdEdcCcZ5oyFIugn4aDC9TxG5zOMBeJ
         akV7GEOQa9VabAg5w62E+mAf9zcuKxW9FQvbK+87ggC3kKgrs4qB3y5xjJtRQztfRZXY
         yJjCGQUS394k/Xily2SuqKHUCXDaDFjedWcu3M/Uek2fdinx8zmYTPJS7dEvlDspAHnG
         ZPx5spJ8eOyurv6+hzefmpCfHheaw+r7eNAUGASaElYz5ecJ3qT4urRR0fzm/zDoBMHL
         EzxoW667bfLj4VHYX+wFBywqMKCOzY31FOq6Ytg3BxjFRVtpqcwgdEvbtCWTK3CZ+VXi
         9hXQ==
X-Gm-Message-State: APjAAAXdMdYpZwImzHIFE8pX289y84U1mnTssrcuEdeXs6+C83OhQ2Ke
        LG1paWckWLhzjMQ8/U4iiLjjgt+wV+W6GCX8tPhxkA==
X-Google-Smtp-Source: APXvYqzUYF2ihRaBnVvfQlUORvkVbh1ugM2QqnaPhxQbrCPhS3VlliVQ6thpuRVctu3V2kIMmFWb9Ob5RRLdvVfBHyo=
X-Received: by 2002:a2e:9981:: with SMTP id w1mr271802lji.155.1568681041286;
 Mon, 16 Sep 2019 17:44:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:e00f:0:0:0:0:0 with HTTP; Mon, 16 Sep 2019 17:44:00
 -0700 (PDT)
In-Reply-To: <bfa92367-f96a-8a4e-71c7-885956e10d0e@sandeen.net>
References: <CAARcW+r3EvFktaw-PfxN_V-EjtU6BvT7wxNvUtFiwHOdbNn2iA@mail.gmail.com>
 <bfa92367-f96a-8a4e-71c7-885956e10d0e@sandeen.net>
From:   Daegyu Han <hdg9400@gmail.com>
Date:   Tue, 17 Sep 2019 09:44:00 +0900
Message-ID: <CAARcW+pLLABT9sq5LHykKmrcNjct8h64_6ePKeVGsOzeLgG8Tg@mail.gmail.com>
Subject: Re: Sharing ext4 on target storage to multiple initiators using NVMeoF
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It started with my curiosity.
I know this is not the right way to use a local filesystem and someone
would feel weird.
I just wanted to organize the situation and experiment like that.

I thought it would work if I flushed Node B's cached file system
metadata with the drop cache, but I didn't.

I've googled for something other than the mount and unmount process,
and I saw a StackOverflow article telling file systems to sync via
blockdev --flushbufs.

So I do the blockdev --flushbufs after the drop cache.
However, I still do not know why I can read the data stored in the
shared storage via Node B.

Thank you,

2019-09-17 4:23 GMT+09:00, Eric Sandeen <sandeen@sandeen.net>:
>
>
> On 9/16/19 9:33 AM, Daegyu Han wrote:
>> Hi linux file system experts,
>>
>> I want to share ext4 on the storage server to multiple initiators(node
>> A,B) using NVMeoF.
>> Node A will write file to ext4 on the storage server, and I will mount
>> read-only option on Node B.
>>
>> Actually, the reason I do this is for a prototype test.
>>
>> I can't see the file's dentry and inode written in Node A on Node B
>> unless remount(umount and then mount) it.
>>
>> Why is that?
>
> Caching, metadata journaling, etc.
>
> What you are trying to do will not work.
>
>> I think if there is file system cache(dentry, inode) on Node B, then
>> disk IO will occur to read the data written by Node A.
>
> why would it?  there is no coordination between the nodes.  ext4 is
> not a clustered filesystem.
>
>> Curiously, drop cache on Node B and do blockdev --flushbufs, then I
>> can access the file written by Node A.
>>
>> I checked the kernel code and found that flushbufs incurs
>> sync_filesystem() which flushes the superblock and all dirty file
>> system caches.
>>
>> Should the superblock data structure be flushed (updated) when
>> accessing the disk inode?
>
> It has nothing to do w/ the superblock.
>
>> I wonder why this happens.
>
> ext4 cannot be used for what you're trying to do.
>
> -Eric
>
