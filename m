Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB736A87F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 19:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhDYRFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 13:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhDYRFj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 13:05:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44014C061574;
        Sun, 25 Apr 2021 10:04:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i3so37290222edt.1;
        Sun, 25 Apr 2021 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LcVnVaEfgzMWxDjWl7bL0XNBz6O/ihKRO1Fxm1HF9k4=;
        b=lCvFYVyfWmtgQiWa8w7ELEXwEXSeB/14+ZQkkTGOqhcfdE6qPe1M+HYdgrsg7bZgs9
         3xLBQ3x3k2oLunqRjkZAksqDbqfK+dVgaaxkygfoWTDqixm7fysSPOfK+aVkd7nYaAT2
         oucuRAvy0CrdfW8PsJK7vjqqnSSZXx03Pz3cY94XxF8RQPBsm53q8IcusgprH0QaaPnS
         LSwADeYXo2onU9PfC0H1Ua9W69M36dMlR468aB/MR1ASw409+z0MQcaCArdiT2XuSwzg
         d2vn33V95tdprSKwW/IldbUFVBeQ//Dpl0NaAVzgWEw9YubOZAzXb8nPug7kQZL8v7gD
         YUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LcVnVaEfgzMWxDjWl7bL0XNBz6O/ihKRO1Fxm1HF9k4=;
        b=B2FMj5HMh49s9+7KtBLsAn1MC4DiHnYVRbtiTFX1Zza+lNvaNDknfoBQ8LFgPYhUCB
         tHPNwy8MsXeYuSlOMqcdLRAIwzz5wMLxpdZRmudKs2YFG+Dmreo9v/16oavF5B1L2Lgw
         bq6weA0+mAzwmVbji1NsQIeLnQFXCF+eskVhW8gQTEXGrXRL8ZXW+JIg9vXaPLuT6QhW
         cckeKNbjTnYm1i/kuslIUBogogdLI+KcO47vmskAra3nWY+N0ng5Xl8PA6kTsRmPNucX
         wu0JeuQKrza5vS3uSOwFZUXxUvy6vjfg45KVkTVRdohzn6YjlWWr/CDKi3r+lEAFO7L4
         kCAw==
X-Gm-Message-State: AOAM531E+ds6UkKGrJq9iGYve40n8UGuyCBaWbhPlkeFpN3btHrFvCbm
        w9qanEQerOuVi0gi1Tp3DtHjokCVF6VNIk7NJzNCIcEAjKmwtw==
X-Google-Smtp-Source: ABdhPJzvu6Y9DdrgZAL5oXB7SDADnw1czT/1WY2torKtsK4Rs1Ag1tlQ4Pq1z/IJ57x475WTiiYp/ytI18GPxgewlSM=
X-Received: by 2002:aa7:c5c6:: with SMTP id h6mr16800019eds.136.1619370297860;
 Sun, 25 Apr 2021 10:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAFt=RON+KYYf5yt9vM3TdOSn4zco+3XtFyi3VDRr1vbQUBPZ0g@mail.gmail.com>
 <YIWd7v1U/dGivmSE@zeniv-ca.linux.org.uk>
In-Reply-To: <YIWd7v1U/dGivmSE@zeniv-ca.linux.org.uk>
From:   haosdent <haosdent@gmail.com>
Date:   Mon, 26 Apr 2021 01:04:46 +0800
Message-ID: <CAFt=RONcpvvk5=8GLTvG44=6wKwiYPH7oG4YULfcP+J=x8OW-w@mail.gmail.com>
Subject: Re: NULL pointer dereference when access /proc/net
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengyu.duan@shopee.com, Haosong Huang <huangh@sea.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Alexander, thanks a lot for your quick reply.

> Not really - the crucial part is ->d_count == -128, i.e. it's already past
> __dentry_kill().

Thanks a lot for your information, we would check this.

> Which tree is that?
> If you have some patches applied on top of that...

We use Ubuntu Linux Kernel "4.15.0-42.45~16.04.1" from launchpad directly
without any modification,  the mapping Linux Kernel should be
"4.15.18" according
to https://people.canonical.com/~kernel/info/kernel-version-map.html

On Mon, Apr 26, 2021 at 12:50 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Apr 25, 2021 at 11:22:15PM +0800, haosdent wrote:
> > Hi, Alexander Viro and dear Linux Filesystems maintainers, recently we
> > encounter a NULL pointer dereference Oops in our production.
> >
> > We have attempted to analyze the core dump and compare it with source code
> > in the past few weeks, currently still could not understand why
> > `dentry->d_inode` become NULL while other fields look normal.
>
> Not really - the crucial part is ->d_count == -128, i.e. it's already past
> __dentry_kill().
>
> > [19521409.514784] RIP: 0010:__atime_needs_update+0x5/0x190
>
> Which tree is that?  __atime_needs_update() had been introduced in
> 4.8 and disappeared in 4.18; anything of that age straight on mainline
> would have a plenty of interesting problems.  If you have some patches
> applied on top of that...  Depends on what those are, obviously.



-- 
Best Regards,
Haosdent Huang
