Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9835177253
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 10:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgCCJ0d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 04:26:33 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45530 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbgCCJ0d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:26:33 -0500
Received: by mail-il1-f193.google.com with SMTP id p8so2114271iln.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 01:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9Z8EsyPHV9U0NaiC6B9M0rvBM6gtbnKLyzu2j7BTPk=;
        b=jTYYh8x31RkzNU33Z6lQeUgOoxxpnukS+yid4FC8FJzzyyH0SDDGWJ7wmGFqxzt1U3
         ifsrEQ7nwWxkNrLVlPAYrCXiE7lSYj+WiO72qZu3u+/Oo03L4Xpoloy0eSa5/wZjMVQH
         faFgkLebRgrbn85uVDC/g5bh+gX1xho/fGSc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9Z8EsyPHV9U0NaiC6B9M0rvBM6gtbnKLyzu2j7BTPk=;
        b=lC7pA4CXCPoYvBWqkJyxoTLCyw43v7KCkTm2JJ3j9dfr7+YaY97RhVrnILykIBWrlW
         P7VyQr5F0sgjobwJ0zmHpuAskLzfM84nHCQJ2vn78KKTxSQ8+EfaFjR30mLNmwtryWmN
         CC79nPedEkVyr/0ApcyKGXbNJ3Nihe1idA9P6Sg8j8k70fREueI1KvMZkM+bxqzVeocz
         cLaHnzfB8IoVkdFHLnvT/wu8E/k1JrRoaby10IZQk1JCn/nOlG5ISQPqCsAuI5EKqjyv
         OFv/GC+Bl4sXzY05jdu/6Z8ixVnmdSnS9EgWdtmyccYsT5aK8iK71hkUOgH+8ZfRcofa
         Mdww==
X-Gm-Message-State: ANhLgQ3RV1NVhtnqeke9XXPao+l6TTcb1XHB0whSyArLH+t7zs9wB/hJ
        rj196xZastnFpQ9O2RXNATyVBc4NGAS5RuujixodRg==
X-Google-Smtp-Source: ADFU+vskIDQQ4v2+q55l4lXqoUZZbVj8UY7SarjpCJCCHM9M7LqyjVaTqkIaH0IvB20GTwnkNr3zZG8eQdj4RMYQWMA=
X-Received: by 2002:a92:8d41:: with SMTP id s62mr3559102ild.63.1583227592332;
 Tue, 03 Mar 2020 01:26:32 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com> <1509948.1583226773@warthog.procyon.org.uk>
In-Reply-To: <1509948.1583226773@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 Mar 2020 10:26:21 +0100
Message-ID: <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     David Howells <dhowells@redhat.com>
Cc:     Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 3, 2020 at 10:13 AM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > I'm doing a patch.   Let's see how it fares in the face of all these
> > preconceptions.
>
> Don't forget the efficiency criterion.  One reason for going with fsinfo(2) is
> that scanning /proc/mounts when there are a lot of mounts in the system is
> slow (not to mention the global lock that is held during the read).
>
> Now, going with sysfs files on top of procfs links might avoid the global
> lock, and you can avoid rereading the options string if you export a change
> notification, but you're going to end up injecting a whole lot of pathwalk
> latency into the system.

Completely irrelevant.  Cached lookup is so much optimized, that you
won't be able to see any of it.

No, I don't think this is going to be a performance issue at all, but
if anything we could introduce a syscall

  ssize_t readfile(int dfd, const char *path, char *buf, size_t
bufsize, int flags);

that is basically the equivalent of open + read + close, or even a
vectored variant that reads multiple files.  But that's off topic
again, since I don't think there's going to be any performance issue
even with plain I/O syscalls.

>
> On top of that, it isn't going to help with the case that I'm working towards
> implementing where a container manager can monitor for mounts taking place
> inside the container and supervise them.  What I'm proposing is that during
> the action phase (eg. FSCONFIG_CMD_CREATE), fsconfig() would hand an fd
> referring to the context under construction to the manager, which would then
> be able to call fsinfo() to query it and fsconfig() to adjust it, reject it or
> permit it.  Something like:
>
>         fd = receive_context_to_supervise();
>         struct fsinfo_params params = {
>                 .flags          = FSINFO_FLAGS_QUERY_FSCONTEXT,
>                 .request        = FSINFO_ATTR_SB_OPTIONS,
>         };
>         fsinfo(fd, NULL, &params, sizeof(params), buffer, sizeof(buffer));
>         supervise_parameters(buffer);
>         fsconfig(fd, FSCONFIG_SET_FLAG, "hard", NULL, 0);
>         fsconfig(fd, FSCONFIG_SET_STRING, "vers", "4.2", 0);
>         fsconfig(fd, FSCONFIG_CMD_SUPERVISE_CREATE, NULL, NULL, 0);
>         struct fsinfo_params params = {
>                 .flags          = FSINFO_FLAGS_QUERY_FSCONTEXT,
>                 .request        = FSINFO_ATTR_SB_NOTIFICATIONS,
>         };
>         struct fsinfo_sb_notifications sbnotify;
>         fsinfo(fd, NULL, &params, sizeof(params), &sbnotify, sizeof(sbnotify));
>         watch_super(fd, "", AT_EMPTY_PATH, watch_fd, 0x03);
>         fsconfig(fd, FSCONFIG_CMD_SUPERVISE_PERMIT, NULL, NULL, 0);
>         close(fd);
>
> However, the supervised mount may be happening in a completely different set
> of namespaces, in which case the supervisor presumably wouldn't be able to see
> the links in procfs and the relevant portions of sysfs.

It would be a "jump" link to the otherwise invisible directory.

Thanks,
Miklos
