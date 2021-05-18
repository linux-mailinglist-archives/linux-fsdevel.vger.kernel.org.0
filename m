Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4955F38746F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 10:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbhERI4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 04:56:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:48234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241286AbhERI4l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 04:56:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3302AEB9;
        Tue, 18 May 2021 08:55:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DEE9F1F2C6E; Tue, 18 May 2021 10:55:19 +0200 (CEST)
Date:   Tue, 18 May 2021 10:55:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        hare@suse.de, tj@kernel.org, gregkh@linuxfoundation.org,
        Menglong Dong <dong.menglong@zte.com.cn>, song@kernel.org,
        neilb@suse.de, Andrew Morton <akpm@linux-foundation.org>,
        f.fainelli@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        palmerdabbelt@google.com, mcgrof@kernel.org, arnd@arndb.de,
        wangkefeng.wang@huawei.com, mhiramat@kernel.org,
        rostedt@goodmis.org, Kees Cook <keescook@chromium.org>,
        vbabka@suse.cz, pmladek@suse.com,
        Alexander Potapenko <glider@google.com>,
        Chris Down <chris@chrisdown.name>, ebiederm@xmission.com,
        jojing64@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] init/initramfs.c: add a new mount as root file system
Message-ID: <20210518085519.GA28667@quack2.suse.cz>
References: <20210517142542.187574-1-dong.menglong@zte.com.cn>
 <20210517151123.GD25760@quack2.suse.cz>
 <CADxym3ZwUQe0mQfcNxf2_kM1VXdqmtUDK076GptcsfktLWLeog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxym3ZwUQe0mQfcNxf2_kM1VXdqmtUDK076GptcsfktLWLeog@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 18-05-21 16:30:27, Menglong Dong wrote:
> Thanks!
> 
> Should I resend this patch? Seems that it does not appear
> on patchwork.

I don't think you need to resend the patch. Not sure why it is not in the
patchwork but relevant maintainers for this area don't use it anyway AFAIK.

									Honza

> On Mon, May 17, 2021 at 11:11 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Thanks for the patch! Although you've CCed a wide set of people, I don't
> > think you've addressed the most relevant ones. For this I'd CC
> > linux-fsdevel mailing list and Al Viro as a VFS maintainer - added.
> >
> >                                                                 Honza
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
