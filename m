Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5938BB08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 02:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhEUAwN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 20:52:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:56444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235556AbhEUAwM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 20:52:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A2BE3AB6D;
        Fri, 21 May 2021 00:50:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Menglong Dong" <menglong8.dong@gmail.com>
Cc:     "Jan Kara" <jack@suse.cz>, "Jens Axboe" <axboe@kernel.dk>,
        hare@suse.de, tj@kernel.org, gregkh@linuxfoundation.org,
        "Menglong Dong" <dong.menglong@zte.com.cn>, song@kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>, f.fainelli@gmail.com,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        palmerdabbelt@google.com, mcgrof@kernel.org, arnd@arndb.de,
        wangkefeng.wang@huawei.com, mhiramat@kernel.org,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Kees Cook" <keescook@chromium.org>, vbabka@suse.cz,
        pmladek@suse.com, "Alexander Potapenko" <glider@google.com>,
        "Chris Down" <chris@chrisdown.name>, ebiederm@xmission.com,
        jojing64@gmail.com, "LKML" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, "Al Viro" <viro@zeniv.linux.org.uk>
Subject: Re: Re: [PATCH] init/initramfs.c: add a new mount as root file system
In-reply-to: <CADxym3ZEf7azG+ApRqrg+aUBSm66N5tC0Ybj9FXyHq7BV3ePmg@mail.gmail.com>
References: <20210517142542.187574-1-dong.menglong@zte.com.cn>,
 <20210517151123.GD25760@quack2.suse.cz>,
 <CADxym3ZwUQe0mQfcNxf2_kM1VXdqmtUDK076GptcsfktLWLeog@mail.gmail.com>,
 <20210518085519.GA28667@quack2.suse.cz>,
 <CADxym3ZEf7azG+ApRqrg+aUBSm66N5tC0Ybj9FXyHq7BV3ePmg@mail.gmail.com>
Date:   Fri, 21 May 2021 10:50:31 +1000
Message-id: <162155823187.19062.2652820542740740108@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 21 May 2021, Menglong Dong wrote:
> Hello!
> 
> On Tue, May 18, 2021 at 4:55 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 18-05-21 16:30:27, Menglong Dong wrote:
> > > Thanks!
> > >
> > > Should I resend this patch? Seems that it does not appear
> > > on patchwork.
> >
> > I don't think you need to resend the patch. Not sure why it is not in the
> > patchwork but relevant maintainers for this area don't use it anyway AFAIK.
> >
> 
> It has been three days, and no one reviews my patch.
> Mmm....I think I'd better resend it with linux-fsdevel CCed.
> 

"three days" is not a reasonable expectation.  Give people at least 1
week before resending or reminding people.

NeilBrown
