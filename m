Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CFD46BFB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 16:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhLGPsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 10:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbhLGPsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:48:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68522C061574;
        Tue,  7 Dec 2021 07:45:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B52CBCE19FA;
        Tue,  7 Dec 2021 15:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7173C341D1;
        Tue,  7 Dec 2021 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638891904;
        bh=g79tkc/a+Li5BdZaeuK+ZFDVc5mc9Hy5yd/urszLIjY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b/o07wXvn9scK9L/0XbEe3ESpzVniuQqpX7m2hqBrhK9LrG6UyTvvaOs5qYetNj3G
         blxSRKe8CxJc9RkEfPjYIkAc10oXVzQQmDCo0zA7LQTYcKosbQ7+ZScZp66vADvuVx
         nn0cse+bXmpP3CS76l/UidEmb4OwIa9y/rZtqU0d0QnQmixMYf1XFNiuQnocCbMjsB
         uZKEjRZ1OzUMaRG+JY3y5XYXmq1vAaMUUznIyJham4OsQc5SMOgoZNTwxsBrkNMhqf
         GWhM6MQ/JOFsS8Bh0TRoZ6QP3tkjQsYogxhC8MI14s8j1kK9VfGI5uI1pAO362v7EJ
         UVWR5G0E7izCA==
Received: by mail-wr1-f47.google.com with SMTP id d24so30538049wra.0;
        Tue, 07 Dec 2021 07:45:04 -0800 (PST)
X-Gm-Message-State: AOAM530KzmAN8bEAUUlBH7cXWz3F2IVWCeBqGTzfihXu6VXuMGklibkd
        eIgFAPMyVNMlXSMe0PTAMkJAywZ9fV5h2zVC9Bo=
X-Google-Smtp-Source: ABdhPJwSjluaVW946SNUj9vmslHGrDrlZH11Hx32c+bZFjNzQOKfgQhzJkCPBop9NKH1wyvBiaVtudSZnKvhS0MQeEw=
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr52657201wri.137.1638891903239;
 Tue, 07 Dec 2021 07:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20211207150927.3042197-1-arnd@kernel.org> <20211207150927.3042197-2-arnd@kernel.org>
 <Ya979Hh0V2CdhNSU@casper.infradead.org>
In-Reply-To: <Ya979Hh0V2CdhNSU@casper.infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 7 Dec 2021 16:44:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2gsdbiQoH_82Nm97DeENzJMUZn99m0LHE4Rt-0pd2d6w@mail.gmail.com>
Message-ID: <CAK8P3a2gsdbiQoH_82Nm97DeENzJMUZn99m0LHE4Rt-0pd2d6w@mail.gmail.com>
Subject: Re: [RFC 1/3] headers: add more types to linux/types.h
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, kernelci@groups.io,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 7, 2021 at 4:21 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Dec 07, 2021 at 04:09:25PM +0100, Arnd Bergmann wrote:
> > +struct list_lru {
> > +     struct list_lru_node    *node;
> > +#ifdef CONFIG_MEMCG_KMEM
> > +     struct list_head        list;
> > +     int                     shrinker_id;
> > +     bool                    memcg_aware;
> > +#endif
> > +};
>
> This is the only one that gives me qualms.  While there are other
> CONFIG options mentioned in types.h they're properties of the platform,
> eg CONFIG_HAVE_UID16, CONFIG_64BIT, CONFIG_ARCH_DMA_ADDR_T_64BIT, etc.
> I dislike it that changing this CONFIG option is going to result in
> rebuilding the _entire_ kernel.  CONFIG_MEMCG_KMEM just isn't that
> central to how everything works.

I included this one because 'struct list_lru' is used in 'struct
super_block', which I move
into 'linux/fs_types.h' in the third patch. It is otherwise not used a
lot though, and
'struct super_block' is rarely much outside of file system code. If we
leave super_block
in fs.h or in a separate header, it should be fine.

        Arnd
