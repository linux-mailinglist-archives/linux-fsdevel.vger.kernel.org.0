Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB3B15AB7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgBLO6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:58:04 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:56832 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbgBLO6E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:58:04 -0500
Received: from comp-core-i7-2640m-0182e6 (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id E4866C61AB0;
        Wed, 12 Feb 2020 14:58:00 +0000 (UTC)
Date:   Wed, 12 Feb 2020 15:57:59 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH v8 05/11] proc: add helpers to set and get proc hidepid
 and gid mount options
Message-ID: <20200212145759.7dwtgnsetk7osycw@comp-core-i7-2640m-0182e6>
Mail-Followup-To: Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-6-gladkov.alexey@gmail.com>
 <CALCETrVjv04OOdzGNf7sRmRR-KUgY7xdMXA236nHZ1arn0KwVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVjv04OOdzGNf7sRmRR-KUgY7xdMXA236nHZ1arn0KwVQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:30:45AM -0800, Andy Lutomirski wrote:
> On Mon, Feb 10, 2020 at 7:06 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> >
> > This is a cleaning patch to add helpers to set and get proc mount
> > options instead of directly using them. This make it easy to track
> > what's happening and easy to update in future.
> 
> On a cursory inspection, this looks like it obfuscates the code, and I
> don't see where it does something useful later in the series.  What is
> this abstraction for?

To be honest, this part is from Djalal Harouni. For me, these wrappers
exist for a slight increase in readability.

I will not cry if you tell me to remove them :)

-- 
Rgrds, legion

