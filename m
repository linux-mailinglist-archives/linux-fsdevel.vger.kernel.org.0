Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3545E430D44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 03:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbhJRBL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Oct 2021 21:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbhJRBL2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Oct 2021 21:11:28 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4E3C06161C;
        Sun, 17 Oct 2021 18:09:18 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id k3so13195012ilu.2;
        Sun, 17 Oct 2021 18:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfeOjNSr14+hr9YL9DUQsshVwCDugysEM+0F+xx1LNs=;
        b=LCWXoLiFeq/6CvXKyYDIpZX75/Z6HSNEQHQN/yKd8EwdLAyfQpzjX21S4UryzIOWgz
         463zMzy/5GqP2+tE4lOB1gD+tSGH2qoq8YlF84mKq46+CRxF2RpSBpqt6z1eTCchUV9e
         B6fwq8W2z1PBKaFIvHtGCK5L1OQTd7QxksM+soX9Iso8Eg1SrU1oeS7Z+8QOlCSdzuLp
         YNcE1FFJ6hWp1KTJNUC4aTRpW3z160myslZknXu/ZWm7vIxZRfP21FU1VQygI0ynL3cP
         OZq8cYCK2L5CCiE1MnmI5Tmf4zdtxRpdgF3j7IIy5JVHhu2A87tFa2DC6n9DnUjUyPXt
         NG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfeOjNSr14+hr9YL9DUQsshVwCDugysEM+0F+xx1LNs=;
        b=heROTjJOdfqd0pTquSJk5rKla9Kdxd0CWas2tSWSsVc/VGNLKbRqk07oMa9/jlhAXT
         ub3QlEuwnGTanr1wlDe6BFR8SzlASxfCLNygJdT9EG0pTjI46T9PXQdbMCQaBCAPzRmE
         RHkIfi0Jr5eU+sGD7QudfOsuGh5YCItnR97AU1l4tWOeOz/1lfKq7KdkYo6tCEHN1DnW
         lSEdQTshmbMVESS8K0osNVrkDVLmk4ZQeydOzVAMVENuzaa/yG6Nj6W5c6xGzzeX6QV9
         AC1eHxOJ5lutO/wq7ScdyT91RgjQAXKUy99xmM49xu/DZfO87MP1dSi2Fqn3ml+R9Chh
         7p3g==
X-Gm-Message-State: AOAM531Pdylh768U8xdXXnVo/mXZaXIcnPNdb+yuCQ9tNQgLg0uiGwo2
        aCDsavHgnwmvC3w0JXrYUab4ZZDrJHVlGf5jOi8=
X-Google-Smtp-Source: ABdhPJyZSh3itSF+VXrY4OH3OZp6AdtHKiAionYTGWjW2Fk28B/StczyWg2y7en5AEMUGL5dW5S27vz4XCBz1ck8+ws=
X-Received: by 2002:a05:6e02:19c9:: with SMTP id r9mr3302469ill.98.1634519358012;
 Sun, 17 Oct 2021 18:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAOOPZo52azGXN-BzWamA38Gu=EkqZScLufM1VEgDuosPoH6TWA@mail.gmail.com>
In-Reply-To: <CAOOPZo52azGXN-BzWamA38Gu=EkqZScLufM1VEgDuosPoH6TWA@mail.gmail.com>
From:   Zhengyuan Liu <liuzhengyuang521@gmail.com>
Date:   Mon, 18 Oct 2021 09:09:06 +0800
Message-ID: <CAOOPZo4ZycbV8W2w48oD+bM8a1+WqejSjjYuheZPyxm2uE-=rA@mail.gmail.com>
Subject: Re: Problem with direct IO
To:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        mysql@lists.mysql.com, linux-ext4@vger.kernel.org,
        =?UTF-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping.

I think this problem is serious and someone may  also encounter it in
the future.


On Wed, Oct 13, 2021 at 9:46 AM Zhengyuan Liu
<liuzhengyuang521@gmail.com> wrote:
>
> Hi, all
>
> we are encounting following Mysql crash problem while importing tables :
>
>     2021-09-26T11:22:17.825250Z 0 [ERROR] [MY-013622] [InnoDB] [FATAL]
>     fsync() returned EIO, aborting.
>     2021-09-26T11:22:17.825315Z 0 [ERROR] [MY-013183] [InnoDB]
>     Assertion failure: ut0ut.cc:555 thread 281472996733168
>
> At the same time , we found dmesg had following message:
>
>     [ 4328.838972] Page cache invalidation failure on direct I/O.
>     Possible data corruption due to collision with buffered I/O!
>     [ 4328.850234] File: /data/mysql/data/sysbench/sbtest53.ibd PID:
>     625 Comm: kworker/42:1
>
> Firstly, we doubled Mysql has operating the file with direct IO and
> buffered IO interlaced, but after some checking we found it did only
> do direct IO using aio. The problem is exactly from direct-io
> interface (__generic_file_write_iter) itself.
>
> ssize_t __generic_file_write_iter()
> {
> ...
>         if (iocb->ki_flags & IOCB_DIRECT) {
>                 loff_t pos, endbyte;
>
>                 written = generic_file_direct_write(iocb, from);
>                 /*
>                  * If the write stopped short of completing, fall back to
>                  * buffered writes.  Some filesystems do this for writes to
>                  * holes, for example.  For DAX files, a buffered write will
>                  * not succeed (even if it did, DAX does not handle dirty
>                  * page-cache pages correctly).
>                  */
>                 if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
>                         goto out;
>
>                 status = generic_perform_write(file, from, pos = iocb->ki_pos);
> ...
> }
>
> From above code snippet we can see that direct io could fall back to
> buffered IO under certain conditions, so even Mysql only did direct IO
> it could interleave with buffered IO when fall back occurred. I have
> no idea why FS(ext3) failed the direct IO currently, but it is strange
> __generic_file_write_iter make direct IO fall back to buffered IO, it
> seems  breaking the semantics of direct IO.
>
> The reproduced  environment is:
> Platform:  Kunpeng 920 (arm64)
> Kernel: V5.15-rc
> PAGESIZE: 64K
> Mysql:  V8.0
> Innodb_page_size: default(16K)
>
> Thanks,
