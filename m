Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320A42B7AE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 11:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgKRKC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 05:02:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52089 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKRKC1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:02:27 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kfKID-00037N-TN; Wed, 18 Nov 2020 10:02:26 +0000
Date:   Wed, 18 Nov 2020 11:02:25 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH v2 0/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
Message-ID: <20201118100225.5sdsourja7ec5fyn@wittgenstein>
References: <20201019102654.16642-1-gscrivan@redhat.com>
 <20201029153859.numo2fc42vgf3ppk@wittgenstein>
 <87mu05vv0m.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mu05vv0m.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 05:47:53PM +0100, Giuseppe Scrivano wrote:
> Hi Christian,
> 
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > On Mon, Oct 19, 2020 at 12:26:52PM +0200, Giuseppe Scrivano wrote:
> >> When the new flag is used, close_range will set the close-on-exec bit
> >> for the file descriptors instead of close()-ing them.
> >> 
> >> It is useful for e.g. container runtimes that want to minimize the
> >> number of syscalls used after a seccomp profile is installed but want
> >> to keep some fds open until the container process is executed.
> >> 
> >> v1->v2:
> >> * move close_range(..., CLOSE_RANGE_CLOEXEC) implementation to a separate function.
> >> * use bitmap_set() to set the close-on-exec bits in the bitmap.
> >> * add test with rlimit(RLIMIT_NOFILE) in place.
> >> * use "cur_max" that is already used by close_range(..., 0).
> >
> > I'm picking this up for some testing, thanks
> > Christian
> 
> thanks!  I've addressed the comments you had for v2 and pushed them
> here[1] but I've not sent yet v3 as I was waiting for a feedback from Al
> whether using bitmap_set() is fine.

Send it please.
Christian
