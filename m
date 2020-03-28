Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA3D91969F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Mar 2020 00:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgC1XAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 19:00:53 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:39934 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbgC1XAw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 19:00:52 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 4FE36209BD;
        Sat, 28 Mar 2020 23:00:49 +0000 (UTC)
Date:   Sun, 29 Mar 2020 00:00:46 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Kees Cook <keescook@chromium.org>
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
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v10 7/9] proc: move hidepid values to uapi as they are
 user interface to mount
Message-ID: <20200328230046.v3qbffmbtl4sd7tg@comp-core-i7-2640m-0182e6>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-8-gladkov.alexey@gmail.com>
 <202003281340.B73225DCC9@keescook>
 <20200328212547.xxiqxqhxzwp6w5n5@comp-core-i7-2640m-0182e6>
 <202003281453.CED94974@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003281453.CED94974@keescook>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Sat, 28 Mar 2020 23:00:49 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 28, 2020 at 02:53:49PM -0700, Kees Cook wrote:
> > > > +/* definitions for hide_pid field */
> > > > +enum {
> > > > +	HIDEPID_OFF            = 0,
> > > > +	HIDEPID_NO_ACCESS      = 1,
> > > > +	HIDEPID_INVISIBLE      = 2,
> > > > +	HIDEPID_NOT_PTRACEABLE = 4,
> > > > +};
> > > Should the numeric values still be UAPI if there is string parsing now?
> > 
> > I think yes, because these are still valid hidepid= values.
> 
> But if we don't expose the values, we can do whatever we like with
> future numbers (e.g. the "is this a value or a bit field?" question).

Alexey Dobriyan suggested to put these parameters into the UAPI and it
makes sense because these are user parameters.

-- 
Rgrds, legion

