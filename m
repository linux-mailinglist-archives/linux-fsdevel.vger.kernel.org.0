Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BB23AA9BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 05:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhFQEAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 00:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhFQEAJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 00:00:09 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E590C061574;
        Wed, 16 Jun 2021 20:58:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x73so3888365pfc.8;
        Wed, 16 Jun 2021 20:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cxWXLIC61oKCERyqp7QLugpZ6EYeQ1OEiIHcPume/1I=;
        b=VEKUgBQL6ITgAPzzvV2wGPGXEDMprWzlLQFY9fBYWUQLUB6f98AS4Axj59oViTps/C
         Y3veMj805ev6q+BFXjsYJRlrMYnFEyAmiwH4L4MRSJjyAmzsgGGDwaErHpQh9i9ehxdi
         M667HuAD4SWGMgVn28PTngcI3BGokzEY3Non4ASl44PBLnyuXwVSGxSlWLvcMLWaRtTA
         PQp/3Yn7FOV+RsNSc48SLaly6hbUZOlVsEd8UhINKhGftdwMp+j+qu96BOilrvm46KOp
         tr+UorT7riTYX3EmHSN4Bc85E+ydvHEtWttrvF15z0LJFYwR2EyjBiJjNKTta2mcF85K
         ZyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cxWXLIC61oKCERyqp7QLugpZ6EYeQ1OEiIHcPume/1I=;
        b=JhN5cI68AHmDRUXeuTDsDw+Irt/QtY08m7DyIg69vXsENIHwgAA1Fuhhblc2wATmKg
         8rLsPh6sbrBqtWCnm5mz3Pmj9AP2/L15e4oRKPhPS8/swbXDe+HM/S9lM88ly0MLIGKc
         snpD5/60p6KF0Mn7u9AC/SuhdFekv6thEYtKJlGcvs+m5h052XT01MYiV5jhE7pAY1zb
         GfaWZm1x/EmHdx2BmGPgvuN0TIDhMTTtN4RdRUr77fZ9tUXf5c83RP+OM+8DSkwPUO7+
         2TG7fyJwnOLwQL7ObQlHGZQo6KsFAv+wNWH2VS80KNgfwyDZkhXWLYruT+IAkdAQe2h5
         G7Og==
X-Gm-Message-State: AOAM533k1vy4jHU7dnrXcAw5L5TtXWG0WDTYJt4iD3oByzOG2nnpcgh6
        iSLAVJnZCVCBNyzqxajUDKw=
X-Google-Smtp-Source: ABdhPJzUE7aa/FMk1kTnGV53mXzMSOybd6DrbRa1fQR+Tce9clK1GoFWOQCeTxwktUjgwZRYoBfKmw==
X-Received: by 2002:a63:ff20:: with SMTP id k32mr3082392pgi.82.1623902281426;
        Wed, 16 Jun 2021 20:58:01 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id gk21sm3500477pjb.22.2021.06.16.20.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 20:58:00 -0700 (PDT)
Date:   Wed, 16 Jun 2021 20:57:56 -0700
From:   Menglong Dong <menglong8.dong@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, johan@kernel.org,
        ojeda@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        joe@perches.com, Jan Kara <jack@suse.cz>, hare@suse.de,
        Jens Axboe <axboe@kernel.dk>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Barret Rhoden <brho@google.com>, f.fainelli@gmail.com,
        palmerdabbelt@google.com, wangkefeng.wang@huawei.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        Alexander Potapenko <glider@google.com>, pmladek@suse.com,
        johannes.berg@intel.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, jojing64@gmail.com,
        terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, arnd@arndb.de,
        Chris Down <chris@chrisdown.name>, mingo@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v6 2/2] init/do_mounts.c: create second mount for
 initramfs
Message-ID: <20210617035756.GA228302@www>
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
 <20210605034447.92917-3-dong.menglong@zte.com.cn>
 <20210605115019.umjumoasiwrclcks@wittgenstein>
 <CADxym3bs1r_+aPk9Z_5Y7QBBV_RzUbW9PUqSLB7akbss_dJi_g@mail.gmail.com>
 <20210607103147.yhniqeulw4pmvjdr@wittgenstein>
 <20210607121524.GB3896@www>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607121524.GB3896@www>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Mon, Jun 07, 2021 at 05:15:24AM -0700, menglong8.dong@gmail.com wrote:
> On Mon, Jun 07, 2021 at 12:31:47PM +0200, Christian Brauner wrote:
> > On Sat, Jun 05, 2021 at 10:47:07PM +0800, Menglong Dong wrote:
> [...]
> > > 
> > > I think it's necessary, as I explained in the third patch. When the rootfs
> > > is a block device, ramfs is used in init_mount_tree() unconditionally,
> > > which can be seen from the enable of is_tmpfs.
> > > 
> > > That makes sense, because rootfs will not become the root if a block
> > > device is specified by 'root' in boot cmd, so it makes no sense to use
> > > tmpfs, because ramfs is more simple.
> > > 
> > > Here, I make rootfs as ramfs for the same reason: the first mount is not
> > > used as the root, so make it ramfs which is more simple.
> > 
> > Ok. If you don't mind I'd like to pull and test this before moving
> > further. (Btw, I talked about this at Plumbers before btw.)
> > What did you use for testing this? Any way you can share it?
> 

I notice that it have been ten days, and is it ok to move a little
further? (knock-knock :/)

Thanks!
Menglong Dong

> Ok, no problem definitely. I tested this function in 3 way mainly:
> 
> 1. I debug the kernel with qemu and gdb, and trace the the whole
>    process, to ensure that there is no abnormal situation.
> 2. I tested pivot_root() in initramfs and ensured that it can be
>    used normally. What's more, I also tested docker and ensured
>    container can run normally without 'DOCKER_RAMDISK=yes' set in
>    initramfs.
> 3. I tried to enable and disable CONFIG_INITRAMFS_MOUNT, and
>    ensured that the system can boot successfully from initramfs, initrd
>    and sda.
> 
> What's more, our team is going to test it comprehensively, such as
> ltp, etc.
> 
> Thanks!
> Menglong Dong                                                                                                                                                         
> 
