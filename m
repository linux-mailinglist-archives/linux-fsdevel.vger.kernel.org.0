Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E319C721
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbgDBQd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 12:33:26 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:43112 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732412AbgDBQd0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:33:26 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 19CEB2052E;
        Thu,  2 Apr 2020 16:32:51 +0000 (UTC)
Date:   Thu, 2 Apr 2020 18:32:46 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v10 2/9] proc: allow to mount many instances of proc in
 one pid namespace
Message-ID: <20200402163246.7kfzujkku65belrw@comp-core-i7-2640m-0182e6>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-3-gladkov.alexey@gmail.com>
 <87eet5lx97.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eet5lx97.fsf@x220.int.ebiederm.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Thu, 02 Apr 2020 16:33:23 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:31:48AM -0500, Eric W. Biederman wrote:
> 
> > diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> > index 40a7982b7285..5920a4ecd71b 100644
> > --- a/include/linux/proc_fs.h
> > +++ b/include/linux/proc_fs.h
> > @@ -27,6 +27,17 @@ struct proc_ops {
> >  	unsigned long (*proc_get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
> >  };
> >  
> > +struct proc_fs_info {
> > +	struct pid_namespace *pid_ns;
> > +	struct dentry *proc_self;        /* For /proc/self */
> > +	struct dentry *proc_thread_self; /* For /proc/thread-self */
> > +};
> 
> Minor nit.
> 
> I have not seen a patch where you remove proc_self and proc_thread_self
> from struct pid_namepace.
> 
> Ideally it would have been in this patch.  But as it won't break
> anyone's bisection can you please have a follow up patch that removes
> those fields?

Yep. I miss that. I will make v11 to address this and other nits.

-- 
Rgrds, legion

