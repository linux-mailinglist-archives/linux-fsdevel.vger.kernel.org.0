Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7F1EEFAE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 04:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgFEC52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 22:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgFEC52 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 22:57:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5CCC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2020 19:57:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v24so3043983plo.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2020 19:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M6PVatvjkL7a6G4MGddno9KRoekuNJtQ7P4X7N6VgLs=;
        b=SgPDRouYyABJao/ElZNxU2CQu52ywW3AcyEHdC73jFg9bXVwlnLIPc+qjQ1b8MEGSP
         An0XvIZ7g+iBWiBEA+sC4IjT9kbhoSfvkEeGc1Ir+U+CIcyg4xku8rxRqB+mpB84FooX
         ntEenJkjqE6o7O8gFeVY9SWf9Hxt82ScDjTjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M6PVatvjkL7a6G4MGddno9KRoekuNJtQ7P4X7N6VgLs=;
        b=Ogrs4bCKJKe76w31/18C09DEyhaFye3W+BMq9U5oOSaOm/LhlaVcqz04vCZ9lrTgGz
         QYWKsz2PrQqdjhybfMV0jvpJNAily4Y5L4qGcay2AMl5u/RmgJ/VlBJHaZepSnnX/8v9
         wAUSZRkgsbVQ+WmS7k8mOvpn+uiYEqPhj84t5d+gd8Ib7Q0gejNwDaNehaXq96Nyhzkc
         wzKwyV6M5KVsA2nQ0ilgdEU4XoEjLDBfnHhZYFNNt2ym0TgD2B1Fs4uqXaS3dXC5EFSm
         47FFgz6nXzdeJvFd+qBbEgEM7H/+/y9LTHFcqnfdG9RcaP/m1M5gcClsW19aFPywgrx/
         Tw2A==
X-Gm-Message-State: AOAM532BU/SXWRDbG7COlxnsKxdn8bhatQ8fsdZswAb+dqKBngh7o9rv
        ql7EIjjtEzMp8O00m9wCh8pTsg==
X-Google-Smtp-Source: ABdhPJy0qMxESQBukihzzGPV2cie3mmiE0CISaHFY+TLH/IcWrnRnBDv5cy6nkyJxmFy0ptWApJV/w==
X-Received: by 2002:a17:90a:c17:: with SMTP id 23mr520400pjs.160.1591325845626;
        Thu, 04 Jun 2020 19:57:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g29sm5957851pfr.47.2020.06.04.19.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 19:57:24 -0700 (PDT)
Date:   Thu, 4 Jun 2020 19:57:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        kernel test robot <rong.a.chen@intel.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org, ltp@lists.linux.it
Subject: Re: [exec] 166d03c9ec: ltp.execveat02.fail
Message-ID: <202006041910.9EF0C602@keescook>
References: <20200518055457.12302-3-keescook@chromium.org>
 <20200525091420.GI12456@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525091420.GI12456@shao2-debian>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 25, 2020 at 05:14:20PM +0800, kernel test robot wrote:
> execveat02.c:64: PASS: execveat() fails as expected: EBADF (9)
> execveat02.c:64: PASS: execveat() fails as expected: EINVAL (22)
> execveat02.c:61: FAIL: execveat() fails unexpectedly, expected: ELOOP: EACCES (13)
> execveat02.c:64: PASS: execveat() fails as expected: ENOTDIR (20)

tl;dr: I think this test is correct, and I think I see a way to improve
the offending patch series to do the right thing.


Okay, the LTP is checking for ELOOP on trying to exec a symlink:

...
 *    3) execveat() fails and returns ELOOP if the file identified by dirfd and
 *       pathname is a symbolic link and flag includes AT_SYMLINK_NOFOLLOW.
...
#define TESTDIR "testdir"
#define TEST_APP "execveat_errno"
...
#define TEST_SYMLINK "execveat_symlink"
...
#define TEST_ERL_SYMLINK TESTDIR"/"TEST_SYMLINK
...
        sprintf(app_sym_path, "%s/%s", cur_dir_path, TEST_ERL_SYMLINK);
...
        SAFE_SYMLINK(TEST_REL_APP, TEST_ERL_SYMLINK);

        fd = SAFE_OPEN(TEST_REL_APP, O_PATH);
...
static struct tcase {
        int *fd;
        char *pathname;
        int flag;
        int exp_err;
} tcases[] = {
...
        {&fd, app_sym_path, AT_SYMLINK_NOFOLLOW, ELOOP},
...
};
...
                TEST(execveat(*tc->fd, tc->pathname, argv, environ, tc->flag));

This is testing the exec _of_ a symlink under AT_SYMLINK_NOFOLLOW.

The execve(2) manpage says:

       ELOOP  Too many symbolic links were encountered in resolving
              pathname or  the  name  of  a script or ELF interpreter.

       ELOOP  The maximum recursion limit was reached during recursive
	      script interpretation (see "Interpreter scripts", above).
	      Before Linux 3.8, the error produced for this case was ENOEXEC.

Which actually doesn't mention this case. open(2) says:

       ELOOP  Too many symbolic links were encountered in resolving pathname.

       ELOOP  pathname was a symbolic link, and flags specified O_NOFOLLOW
	      but not O_PATH.

(but O_NOFOLLOW is limited to file creation. linkat(2) lists the AT_*
flags, and applied to openat, this seems to track: attempting to
execat where the final element is a symlink should fail with ELOOP,
though the manpage does warn that this makes it indistinguishable from
symlink loops -- the first item listed in the execve manpage for
ELOOP...)

Regardless, this does seem to be the "correct" result, as opening for
exec or opening just normally should really get the same error code.

The call path for execve looks like this:

    do_open_execat()
        struct open_flags open_exec_flags = {
            .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
	    .acc_mode = MAY_READ | MAY_EXEC,
	    ...
        do_filp_open(dfd, filename, open_flags)
            path_openat(nameidata, open_flags, flags)
                file = alloc_empty_file(open_flags, current_cred());
		open_last_lookups(nd, file, open_flags)
		    step_into(nd, ...)
		        /* stop on symlink without LOOKUP_FOLLOW */
                do_open(nameidata, file, open_flags)
                    /* new location of FMODE_EXEC vs S_ISREG() test */
                    may_open(path, acc_mode, open_flag)
			/* test for S_IFLNK */
                        inode_permission(inode, MAY_OPEN | acc_mode)
                            security_inode_permission(inode, acc_mode)
                    vfs_open(path, file)
                        do_dentry_open(file, path->dentry->d_inode, open)
                            /* old location of FMODE_EXEC vs S_ISREG() test */
                            security_file_open(f)
                            open()

The step_into() is what kicks back out without LOOKUP_FOLLOW, so we're
left holding a symlink (S_IFMT inode). In do_open(), there is a set of
checks via may_open() which checks for S_IFMT and rejects it:

        switch (inode->i_mode & S_IFMT) {
        case S_IFLNK:
                return -ELOOP;

So that's the case LTP was testing for.

The patch in -next ("exec: relocate S_ISREG() check")[1], moves the regular
file requirement up before may_open(), for all the reasons mentioned in
the commit log (and the next patch[2]).

When I was originally trying to determine the best place for where the
checks should live, may_open() really did seem like the right place, but I
recognized that it was examining path characteristics (which was good) but
it didn't have the file, and that seemed to be an intentional separation.

What is needed in may_open() would be the "how was this file opened?"
piece of information: file->f_mode & FMODE_EXEC. However, in looking at
this again now, I wonder if it might be possible to use the MAY_EXEC
from the acc_mode? It seems the old check (in do_dentry_open() had no
access to the acc_mode, so it was forced to use the FMODE_EXEC signal
instead.

(I actually think this remains a bit of a design problem: path-based LSMs,
which see the opened file in security_file_open(), also don't have access
to acc_mode and must depend on the FMODE_* flags...)

I will respin the series to use acc_mode and move the tests into
may_open().

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=vfs/fmode_exec/v1&id=36aaecef88b472ad5e0a408ffdb5b2e46f1478f6
[2] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=vfs/fmode_exec/v1&id=a2f303b9f24ae2ecdc57f3db93e49b2b869893aa

-- 
Kees Cook
