Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4DB11969E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 23:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgC1Wyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 18:54:46 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:39284 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbgC1Wyp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 18:54:45 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id B3BD8209BD;
        Sat, 28 Mar 2020 22:54:41 +0000 (UTC)
Date:   Sat, 28 Mar 2020 23:54:36 +0100
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
Subject: Re: [PATCH v10 8/9] proc: use human-readable values for hidehid
Message-ID: <20200328225436.m3f72nutyq352i2w@comp-core-i7-2640m-0182e6>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-9-gladkov.alexey@gmail.com>
 <202003281321.A69D9DE45@keescook>
 <20200328211453.w44fvkwleltnc2m7@comp-core-i7-2640m-0182e6>
 <202003281451.88C7CBD23C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003281451.88C7CBD23C@keescook>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Sat, 28 Mar 2020 22:54:43 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 28, 2020 at 02:52:55PM -0700, Kees Cook wrote:
> On Sat, Mar 28, 2020 at 10:14:53PM +0100, Alexey Gladkov wrote:
> > On Sat, Mar 28, 2020 at 01:28:28PM -0700, Kees Cook wrote:
> > > On Fri, Mar 27, 2020 at 06:23:30PM +0100, Alexey Gladkov wrote:
> > > > [...]
> > > > +	if (!kstrtouint(param->string, base, &result.uint_32)) {
> > > > +		ctx->hidepid = result.uint_32;
> > > 
> > > This need to bounds-check the value with a call to valid_hidepid(), yes?
> > 
> > The kstrtouint returns 0 on success and -ERANGE on overflow [1].
> 
> No, I mean, hidepid cannot be just any uint32 value. It must be in the
> enum. Is that checked somewhere else? It looked like the call to
> valid_hidepid() was removed.

The valid_hidepid() is called after parsing the hidepid parameter value.
Yes, it can be called inside this condition.

-- 
Rgrds, legion

