Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC44C2482D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 12:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHRKTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 06:19:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38462 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgHRKTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:19:33 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k7yiH-0001XG-U9; Tue, 18 Aug 2020 10:19:30 +0000
Date:   Tue, 18 Aug 2020 12:19:28 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH 17/17] file: Rename __close_fd to close_fd and remove the
 files parameter
Message-ID: <20200818101928.6tbaakfpqxtlrf53@wittgenstein>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
 <20200817220425.9389-17-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817220425.9389-17-ebiederm@xmission.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 05:04:25PM -0500, Eric W. Biederman wrote:
> The function __close_fd was added to support binder[1].  Now that
> binder has been fixed to no longer need __close_fd[2] and
> get_files_struct has been removed it is no longer possible to
> correctly call __close_fd with anything current->files pass as it's
> files parameter.
> 
> Therefore transform the files parameter into a local variable
> initialized to current->files, and rename __close_fd to close_fd to
> reflect this change, and keep it in sync with the similar changes to
> __alloc_fd, and __fd_install.
> 
> This removes the need for callers to care about the extra care that
> needs to be take if anything except current->files is passed, by
> limiting the callers to only operation on current->files.
> 
> [1] 483ce1d4b8c3 ("take descriptor-related part of close() to file.c")
> [2] 44d8047f1d87 ("binder: use standard functions to allocate fds")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
