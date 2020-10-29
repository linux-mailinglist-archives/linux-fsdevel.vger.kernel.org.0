Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893DD29F037
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 16:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgJ2PjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 11:39:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33837 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgJ2PjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:39:02 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kYA0y-0001lI-6a; Thu, 29 Oct 2020 15:39:00 +0000
Date:   Thu, 29 Oct 2020 16:38:59 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH v2 0/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
Message-ID: <20201029153859.numo2fc42vgf3ppk@wittgenstein>
References: <20201019102654.16642-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019102654.16642-1-gscrivan@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:26:52PM +0200, Giuseppe Scrivano wrote:
> When the new flag is used, close_range will set the close-on-exec bit
> for the file descriptors instead of close()-ing them.
> 
> It is useful for e.g. container runtimes that want to minimize the
> number of syscalls used after a seccomp profile is installed but want
> to keep some fds open until the container process is executed.
> 
> v1->v2:
> * move close_range(..., CLOSE_RANGE_CLOEXEC) implementation to a separate function.
> * use bitmap_set() to set the close-on-exec bits in the bitmap.
> * add test with rlimit(RLIMIT_NOFILE) in place.
> * use "cur_max" that is already used by close_range(..., 0).

I'm picking this up for some testing, thanks
Christian
 
