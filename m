Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62583D7525
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 14:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhG0MhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 08:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231931AbhG0MhN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:37:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97D17615E3;
        Tue, 27 Jul 2021 12:37:04 +0000 (UTC)
Date:   Tue, 27 Jul 2021 14:37:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Menglong Dong <menglong8.dong@gmail.com>
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
Message-ID: <20210727123701.zlcrrf4p2fsmeeas@wittgenstein>
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
 <20210605034447.92917-3-dong.menglong@zte.com.cn>
 <20210605115019.umjumoasiwrclcks@wittgenstein>
 <CADxym3bs1r_+aPk9Z_5Y7QBBV_RzUbW9PUqSLB7akbss_dJi_g@mail.gmail.com>
 <20210607103147.yhniqeulw4pmvjdr@wittgenstein>
 <20210607121524.GB3896@www>
 <20210617035756.GA228302@www>
 <20210617143834.ybxk6cxhpavlf4gg@wittgenstein>
 <CADxym3aLQNJaWjdkMVAjuVk_btopv6jHrVjtP+cKwH8x6R7ojQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADxym3aLQNJaWjdkMVAjuVk_btopv6jHrVjtP+cKwH8x6R7ojQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 08:24:03PM +0800, Menglong Dong wrote:
> Hello Christian,
> 
> On Thu, Jun 17, 2021 at 10:38 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> [...]
> >
> > Hey Menglong,
> >
> > Since we're very close to the next kernel release it's unlikely that
> > anything will happen before the merge window has closed.
> > Otherwise I think we're close. I haven't had the time to test yet but if
> > nothing major comes up I'll pick it up and route it through my tree.
> > We need to be sure there's no regressions for anyone using this.
> >
> 
> Seems that it has been a month, and is it ok to move a little
> further? (knock-knock :/)

Yep, sorry.
When I tested this early during the merge window it regressed booting a
regular system for me meaning if I compiled a kernel with this feature
enabled it complained about not being being able to open an initial
console and it dropped me right into initramfs instead of successfully
booting. I haven't looked into what this is caused or how to fix it for
lack of time.
