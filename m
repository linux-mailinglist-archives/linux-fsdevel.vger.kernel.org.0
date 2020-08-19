Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94452494C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 08:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHSGBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 02:01:43 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:55947 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726585AbgHSGBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 02:01:42 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 29F375800F7;
        Wed, 19 Aug 2020 02:01:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 19 Aug 2020 02:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm3; bh=
        /X+Ee45qx7ylqCNfNTjT5Zo721wJpwFCr2E6ia1inBk=; b=vXvjihyWpH2ZR6oP
        7/E2JETQWjQWzaZ0jUwdz4VdoBq3oni9pF6WkmSju+GScmq8i6XUjwj1Ab1loz13
        KI6sCHuJnFX/C+haWP2hqmbYXnweREKY81OKYaRlm+ZLWWPqBbxkMWcuUV9+jzPe
        VskabU9F3py6LPFeSuPs5D090/Te18fX2T3NEVR/lQBMWC+pbuV5pt6LlKSM1n5U
        wCOLJ6Bysb9y9sG8oREZxuKh/M2QGhG0v6C2WZycML48OG2BBNxJ9keHWZMYhFU2
        WEt0zyZBakfiSsc1BsiU6142XqUXPAUP8LgHNCRTzO0x+VVnFw7bpPTTTbFPaYVk
        IL857A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=/X+Ee45qx7ylqCNfNTjT5Zo721wJpwFCr2E6ia1in
        Bk=; b=sUsm0te25PdOnQ07lxONLMkvF9oci8khFNdkmsPuXyov77KXK+XyXOtYz
        0QV5EknuNM/duzRp+W89wMfVJbsp8N0XlGa+WUF+ED4oc0egH57tX7zmGzRd9xJj
        BI9SmasGZGv7Tnnl2wqW+S++mz6QHMzTAIUWBtoOJ3t08b7mYY7tWcpUqXKcEl9E
        6KseKvclnuL2w93JGqW21zxP/z0moix/C8dRxp5WY5VJH9tpcPsCXM4OfLpdL5lz
        0EBTtjLjx7KpF3PgQNLBW69CxFVPor+dKgBZ9GDWheJBRAnESCciZqWY/BvfzgVz
        G+VC9GCj/XZMbgXXf0qTVNB7FzbIg==
X-ME-Sender: <xms:QsA8XwhAidtBLRzDN3bXccKuhdi9qb5gHdlc_kt0cMDeRwMlCicepA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtjedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufhfffgjkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhikhho
    lhgruhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtffrrg
    htthgvrhhnpeffffefueegtdevffeuvddvtddutedthefffefgveefhfettdfhffdtudef
    vddtfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedukeehrdefrdelge
    drudelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pefpihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:QsA8X5CPTQjq6WCvkUNDqu90FIHcCCAOuyrUUPbCANn3eoS0zyeWfg>
    <xmx:QsA8X4HYIWim5I-MGHFPqX5BeC4kXY8ChV5fVIrf39ASJYz64G5DUA>
    <xmx:QsA8XxSBvHihcu5CXR2c_sU_jCWTzUmxvJ6iqfZS8kOXbUeOIH9RYw>
    <xmx:Q8A8X1CXmWiiGJZLfqksePR4FyTCLsWfOGTqB9TFXAyjHqa4Aij8pg>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id EFB2C3060067;
        Wed, 19 Aug 2020 02:01:37 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id E7F67123;
        Wed, 19 Aug 2020 06:01:36 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id BD483E06CA; Wed, 19 Aug 2020 07:01:36 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Alessio Balsini <balsini@android.com>
Cc:     Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Nikhilesh Reddy <reddyn@codeaurora.org>,
        Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] fuse: Add support for passthrough read/write
References: <20200812161452.3086303-1-balsini@android.com>
        <CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com>
        <20200813132809.GA3414542@google.com>
        <CAG48ez0jkU7iwdLYPA0=4PdH0SL8wpEPrYvpSztKG3JEhkeHag@mail.gmail.com>
        <20200818135313.GA3074431@google.com>
Mail-Copies-To: never
Mail-Followup-To: Alessio Balsini <balsini@android.com>, Jann Horn
        <jannh@google.com>, Jens Axboe <axboe@kernel.dk>, Miklos Szeredi
        <miklos@szeredi.hu>, Nikhilesh Reddy <reddyn@codeaurora.org>, Akilesh
        Kailash <akailash@google.com>, David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Paul Lawrence
        <paullawrence@google.com>, Stefano Duo <stefanoduo@google.com>, Zimuzo
        Ezeozue <zezeozue@google.com>, kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel list
        <linux-kernel@vger.kernel.org>
Date:   Wed, 19 Aug 2020 07:01:36 +0100
In-Reply-To: <20200818135313.GA3074431@google.com> (Alessio Balsini's message
        of "Tue, 18 Aug 2020 14:53:13 +0100")
Message-ID: <877dtvb2db.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alessio,

Thank you for working on this, I'm excited to see things moving again on
this front!

What I would really like to see in the long-term is the ability for FUSE
to support passthrough for specific areas of a file, i.e. the ability to
specify different passthrough fds for different regions of the FUSE
file.

I do not want to ask you to extend the patch, but I am a little worried
that the proposed interface would make a future extension more
complicated than necessary. Could you comment on that? Is there a way to
design the libfuse interface in a way that would - in the future - make
it easier to extend it along these lines?

What I have in mind is things like not coupling the setup of the
passthrough fds to open(), but having a separate notification message for
this (like what we use for invalidation of cache), and adding not just
an "fd" field but also "offset" and "length" fields (which would
currently be required to be both zero to get the "full file" semantics).

What do you think?

Best,
-Nikolaus

On Aug 18 2020, Alessio Balsini <balsini@android.com> wrote:
> Thank you both for the important feedback,
>
> I tried to consolidate all your suggestions in the new version of the
> patch, shared below.
>
> As you both recommended, that tricky ki_filp swapping has been removed,
> taking overlayfs as a reference for the management of asynchronous
> requests.
> The V7 below went again through some testing with fio (sync and libaio
> engines with several jobs in randrw), fsstress, and a bunch of kernel
> builds to trigger both the sync and async paths. Gladly everything worked
> as expected.
>
> What I didn't get from overlayfs are the temporary cred switchings, as I
> think that in the FUSE use case it is still the FUSE daemon that should
> take care of identifying if the requesting process has the right
> permissions before allowing the passthrough feature.
>
> On Thu, Aug 13, 2020 at 08:30:21PM +0200, 'Jann Horn' via kernel-team wro=
te:
>> On Thu, Aug 13, 2020 at 3:28 PM Alessio Balsini <balsini@android.com> wr=
ote:
>> [...]
>>=20
>> My point is that you can use this security issue to steal file
>> descriptors from processes that are _not_ supposed to act as FUSE
>> daemons. For example, let's say there is some setuid root executable
>> that opens /etc/shadow and then writes a message to stdout. If I
>> invoke this setuid root executable with stdout pointing to a FUSE
>> device fd, and I can arrange for the message written by the setuid
>> process to look like a FUSE message, I can trick the setuid process to
>> install its /etc/shadow fd as a passthrough fd on a FUSE file, and
>> then, through the FUSE filesystem, mess with /etc/shadow.
>>=20
>> Also, for context: While on Android, access to /dev/fuse is
>> restricted, desktop Linux systems allow unprivileged users to use
>> FUSE.
>> [...]
>> The new fuse_dev_ioctl() command would behave just like
>> fuse_dev_write(), except that the ioctl-based interface would permit
>> OPEN/CREATE replies with FOPEN_PASSTHROUGH, while the write()-based
>> interface would reject them.
>> [...]
>> I can't think of any checks that you could do there to make it safe,
>> because fundamentally what you have to figure out is _userspace's
>> intent_, and you can't figure out what that is if userspace just calls
>> write().
>> [...]
>> In this case, an error indicates that the userspace programmer made a
>> mistake. So even if the userspace programmer is not looking at kernel
>> logs, we should indicate to them that they messed up - and we can do
>> that by returning an error code from the syscall. So I think we should
>> ideally abort the operation in this case.
>
> I've been thinking about the security issue you mentioned, but I'm thinki=
ng
> that besides the extra Android restrictions, it shouldn't be that easy to
> play with /dev/fuse, also for a privileged process in Linux.
> In order for a process to successfully send commands to /dev/fuse, the
> command has to match a pending request coming from the FUSE filesystem,
> meaning that the same privileged process should have mounted the FUSE
> filesystem, actually becoming a FUSE daemon itself.
> Is this still an eventually exploitable scenario?
>
>>=20
>> No, call_write_iter() doesn't do any of the required checking and
>> setup and notification steps, it just calls into the file's
>> ->write_iter handler:
>>=20
>> static inline ssize_t call_write_iter(struct file *file, struct kiocb *k=
io,
>>       struct iov_iter *iter)
>> {
>>         return file->f_op->write_iter(kio, iter);
>> }
>>=20
>> Did you confuse call_write_iter() with vfs_iocb_iter_write(), or
>> something like that?
>
> Ops, you are right, I was referring to vfs_iocb_iter_write(), that was
> actually part of my first design, but ended up simplifying in favor of
> call_write_iter().
>
>> Requests can complete asynchronously. That means call_write_iter() can
>> return more or less immediately, while the request is processed in the
>> background, and at some point, a callback is invoked. That's what that
>> -EIOCBQUEUED return value is about. In that case, the current code
>> will change ->ki_filp while the request is still being handled in the
>> background.
>>=20
>> I recommend looking at ovl_write_iter() in overlayfs to see how
>> they're dealing with this case.
>
> That was a great suggestion, I hopefully picked the right things from
> overlayfs, without overlooking some security aspects.
>
> Thanks again,
> Alessio
>
> ---8<---
>
> From 5f0e162d2bb39acf41687ca722e15e95d0721c43 Mon Sep 17 00:00:00 2001
> From: Alessio Balsini <balsini@android.com>
> Date: Wed, 12 Aug 2020 17:14:52 +0100
> Subject: [PATCH v7] fuse: Add support for passthrough read/write
>
> Add support for filesystem passthrough read/write of files when enabled
> in userspace through the option FUSE_PASSTHROUGH.
>
> There are filesystems based on FUSE that are intended to enforce special
> policies or trigger complicate decision makings at the file operations
> level.  Android, for example, uses FUSE to enforce fine-grained access
> policies that also depend on the file contents.
> Sometimes it happens that at open or create time a file is identified as
> not requiring additional checks for consequent reads/writes, thus FUSE
> would simply act as a passive bridge between the process accessing the
> FUSE filesystem and the lower filesystem. Splicing and caching help
> reducing the FUSE overhead, but there are still read/write operations
> forwarded to the userspace FUSE daemon that could be avoided.
>
> When the FUSE_PASSTHROUGH capability is enabled, the FUSE daemon may
> decide while handling the open or create operations, if the given file
> can be accessed in passthrough mode, meaning that all the further read
> and write operations would be forwarded by the kernel directly to the
> lower filesystem rather than to the FUSE daemon. All requests that are
> not reads or writes are still handled by the userspace code.
> This allows for improved performance on reads and writes, especially in
> the case of reads at random offsets, for which no (readahead) caching
> mechanism would help.
> Benchmarks show improved performance that is close to native filesystem
> access when doing massive manipulations on a single opened file,
> especially in the case of random reads, for which the bandwidth
> increased by almost 2X or sequential writes for which the improvement is
> close to 3X.
>
> The creation of this direct connection (passthrough) between FUSE file
> objects and file objects in the lower filesystem happens in a way that
> reminds of passing file descriptors via sockets:
> - a process opens a file handled by FUSE, so the kernel forwards the
>   request to the FUSE daemon;
> - the FUSE daemon opens the target file in the lower filesystem, getting
>   its file descriptor;
> - the file descriptor is passed to the kernel via /dev/fuse;
> - the kernel gets the file pointer navigating through the opened files
>   of the "current" process and stores it in an additional field in the
>   fuse_file owned by the process accessing the FUSE filesystem.
> From now all the read/write operations performed by that process will be
> redirected to the file pointer pointing at the lower filesystem's file.
> Handling asynchronous IO is done by creating separate AIO requests for
> the lower filesystem that will be internally tracked by FUSE, that
> intercepts and propagates their completion through an internal
> ki_completed callback similar to the current implementation of
> overlayfs.
>
> Original-patch-by: Nikhilesh Reddy <reddyn@codeaurora.org>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> --
>     Performance
>
> What follows has been performed with this change [V6] rebased on top of a
> vanilla v5.8 Linux kernel, using a custom passthrough_hp FUSE daemon that
> enables pass-through for each file that is opened during both =E2=80=9Cop=
en=E2=80=9D and
> =E2=80=9Ccreate=E2=80=9D. Tests were run on an Intel Xeon E5-2678V3, 32Gi=
B of RAM, with an
> ext4-formatted SSD as the lower filesystem, with no special tuning, e.g.,=
 all
> the involved processes are SCHED_OTHER, ondemand is the frequency governo=
r with
> no frequency restrictions, and turbo-boost, as well as p-state, are activ=
e.
> This is because I noticed that, for such high-level benchmarks, results
> consistency was minimally affected by these features.
> The source code of the updated libfuse library and passthrough_hp is shar=
ed at
> the following repository:
>
>     https://github.com/balsini/libfuse/tree/fuse-passthrough-stable-v.3.9=
.4
>
> Two different kinds of benchmarks were done for this change, the first se=
t of
> tests evaluates the bandwidth improvements when manipulating a huge single
> file, the second set of tests verify that no performance regressions were
> introduced when handling many small files.
>
> The first benchmarks were done by running FIO (fio-3.21) with:
> - bs=3D4Ki;
> - file size: 50Gi;
> - ioengine: sync;
> - fsync_on_close: true.
> The target file has been chosen large enough to avoid it to be entirely l=
oaded
> into the page cache.
> Results are presented in the following table:
>
> +-----------+--------+-------------+--------+
> | Bandwidth |  FUSE  |     FUSE    |  Bind  |
> |  (KiB/s)  |        | passthrough |  mount |
> +-----------+--------+-------------+--------+
> | read      | 468897 |      502085 | 516830 |
> +-----------+--------+-------------+--------+
> | randread  |  15773 |       26632 |  21386 |
> +-----------+--------+-------------+--------+
> | write     |  58185 |      141272 | 141671 |
> +-----------+--------+-------------+--------+
> | randwrite |  59892 |       75236 |  76486 |
> +-----------+--------+-------------+--------+
>
> As long as this patch has the primary objective of improving bandwidth, a=
nother
> set of tests has been performed to see how this behaves on a totally diff=
erent
> scenario that involves accessing many small files. For this purpose, meas=
uring
> the build time of the Linux kernel has been chosen as a well-known worklo=
ad.
> The kernel has been built with as many processes as the number of logical=
 CPUs
> (-j $(nproc)), that besides being a reasonable number, is also enough to
> saturate the processor=E2=80=99s utilization thanks to the additional FUS=
E daemon=E2=80=99s
> threads, making it even harder to get closer to the native filesystem
> performance.
> The following table shows the total build times in the different
> configurations:
>
> +------------------+--------------+-----------+
> |                  | AVG duration |  Standard |
> |                  |     (sec)    | deviation |
> +------------------+--------------+-----------+
> | FUSE             |      144.566 |     0.697 |
> +------------------+--------------+-----------+
> | FUSE passthrough |      133.820 |     0.341 |
> +------------------+--------------+-----------+
> | Raw              |      109.423 |     0.724 |
> +------------------+--------------+-----------+
>
> Further testing and performance evaluations are welcome.
>
> Changes in v7:
> * Full handling of aio requests as done in overlayfs (update commit messa=
ge).
> * s/fget_raw/fget.
> * Open fails in case of passthrough errors, emitting warning messages.
>   [Proposed by Jann Horn]
> * Create new local kiocb, getting rid of the previously proposed ki_filp
>   swapping.
>   [Proposed by Jann Horn and Jens Axboe]
> * Code polishing.
>
> Changes in v6:
> * Port to kernel v5.8:
>   * fuse_file_{read,write}_iter() changed since the v5 of this patch was
>     proposed.
> * Simplify fuse_simple_request().
> * Merge fuse_passthrough.h into fuse_i.h
> * Refactor of passthrough.c:
>   * Remove BUG_ON()s.
>   * Simplified error checking and request arguments indexing.
>   * Use call_{read,write}_iter() utility functions.
>   * Remove get_file() and fputs() during read/write: handle the extra FUSE
>     references to the lower file object when the fuse_file is created/del=
eted.
>   [Proposed by Jann Horn]
>
> Changes in v5:
> * Fix the check when setting the passthrough file.
>   [Found when testing by Mike Shal]
>
> Changes in v3 and v4:
> * Use the fs_stack_depth to prevent further stacking and a minor fix.
>   [Proposed by Jann Horn]
>
> Changes in v2:
> * Changed the feature name to passthrough from stacked_io.
>   [Proposed by Linus Torvalds]
>
> ---
>  fs/fuse/Makefile          |   1 +
>  fs/fuse/dev.c             |   4 +
>  fs/fuse/dir.c             |   2 +
>  fs/fuse/file.c            |  25 +++--
>  fs/fuse/fuse_i.h          |  20 ++++
>  fs/fuse/inode.c           |  22 +++-
>  fs/fuse/passthrough.c     | 219 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fuse.h |   4 +-
>  8 files changed, 286 insertions(+), 11 deletions(-)
>  create mode 100644 fs/fuse/passthrough.c
>
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 3e8cebfb59b7..6971454a2bdf 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -8,4 +8,5 @@ obj-$(CONFIG_CUSE) +=3D cuse.o
>  obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
>=20=20
>  fuse-objs :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdi=
r.o
> +fuse-objs +=3D passthrough.o
>  virtiofs-y +=3D virtio_fs.o
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 02b3c36b3676..a99c28fd4566 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -506,6 +506,7 @@ ssize_t fuse_simple_request(struct fuse_conn *fc, str=
uct fuse_args *args)
>  		BUG_ON(args->out_numargs =3D=3D 0);
>  		ret =3D args->out_args[args->out_numargs - 1].size;
>  	}
> +	args->passthrough_filp =3D req->passthrough_filp;
>  	fuse_put_request(fc, req);
>=20=20
>  	return ret;
> @@ -1897,6 +1898,9 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *f=
ud,
>  		err =3D copy_out_args(cs, req->args, nbytes);
>  	fuse_copy_finish(cs);
>=20=20
> +	if (fuse_passthrough_setup(fc, req))
> +		err =3D -EINVAL;
> +
>  	spin_lock(&fpq->lock);
>  	clear_bit(FR_LOCKED, &req->flags);
>  	if (!fpq->connected)
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 26f028bc760b..531de0c5c9e8 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -477,6 +477,7 @@ static int fuse_create_open(struct inode *dir, struct=
 dentry *entry,
>  	args.out_args[0].value =3D &outentry;
>  	args.out_args[1].size =3D sizeof(outopen);
>  	args.out_args[1].value =3D &outopen;
> +	args.passthrough_filp =3D NULL;
>  	err =3D fuse_simple_request(fc, &args);
>  	if (err)
>  		goto out_free_ff;
> @@ -489,6 +490,7 @@ static int fuse_create_open(struct inode *dir, struct=
 dentry *entry,
>  	ff->fh =3D outopen.fh;
>  	ff->nodeid =3D outentry.nodeid;
>  	ff->open_flags =3D outopen.open_flags;
> +	ff->passthrough_filp =3D args.passthrough_filp;
>  	inode =3D fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
>  			  &outentry.attr, entry_attr_timeout(&outentry), 0);
>  	if (!inode) {
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 83d917f7e542..c3289ff0cd33 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -33,10 +33,12 @@ static struct page **fuse_pages_alloc(unsigned int np=
ages, gfp_t flags,
>  }
>=20=20
>  static int fuse_send_open(struct fuse_conn *fc, u64 nodeid, struct file =
*file,
> -			  int opcode, struct fuse_open_out *outargp)
> +			  int opcode, struct fuse_open_out *outargp,
> +			  struct file **passthrough_filp)
>  {
>  	struct fuse_open_in inarg;
>  	FUSE_ARGS(args);
> +	int ret;
>=20=20
>  	memset(&inarg, 0, sizeof(inarg));
>  	inarg.flags =3D file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
> @@ -51,7 +53,10 @@ static int fuse_send_open(struct fuse_conn *fc, u64 no=
deid, struct file *file,
>  	args.out_args[0].size =3D sizeof(*outargp);
>  	args.out_args[0].value =3D outargp;
>=20=20
> -	return fuse_simple_request(fc, &args);
> +	ret =3D fuse_simple_request(fc, &args);
> +	*passthrough_filp =3D args.passthrough_filp;
> +
> +	return ret;
>  }
>=20=20
>  struct fuse_release_args {
> @@ -144,14 +149,16 @@ int fuse_do_open(struct fuse_conn *fc, u64 nodeid, =
struct file *file,
>  	/* Default for no-open */
>  	ff->open_flags =3D FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
>  	if (isdir ? !fc->no_opendir : !fc->no_open) {
> +		struct file *passthrough_filp;
>  		struct fuse_open_out outarg;
>  		int err;
>=20=20
> -		err =3D fuse_send_open(fc, nodeid, file, opcode, &outarg);
> +		err =3D fuse_send_open(fc, nodeid, file, opcode, &outarg,
> +				     &passthrough_filp);
>  		if (!err) {
>  			ff->fh =3D outarg.fh;
>  			ff->open_flags =3D outarg.open_flags;
> -
> +			ff->passthrough_filp =3D passthrough_filp;
>  		} else if (err !=3D -ENOSYS) {
>  			fuse_file_free(ff);
>  			return err;
> @@ -281,6 +288,8 @@ void fuse_release_common(struct file *file, bool isdi=
r)
>  	struct fuse_release_args *ra =3D ff->release_args;
>  	int opcode =3D isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
>=20=20
> +	fuse_passthrough_release(ff);
> +
>  	fuse_prepare_release(fi, ff, file->f_flags, opcode);
>=20=20
>  	if (ff->flock) {
> @@ -1543,7 +1552,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
>  	if (is_bad_inode(file_inode(file)))
>  		return -EIO;
>=20=20
> -	if (!(ff->open_flags & FOPEN_DIRECT_IO))
> +	if (ff->passthrough_filp)
> +		return fuse_passthrough_read_iter(iocb, to);
> +	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
>  		return fuse_cache_read_iter(iocb, to);
>  	else
>  		return fuse_direct_read_iter(iocb, to);
> @@ -1557,7 +1568,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *i=
ocb, struct iov_iter *from)
>  	if (is_bad_inode(file_inode(file)))
>  		return -EIO;
>=20=20
> -	if (!(ff->open_flags & FOPEN_DIRECT_IO))
> +	if (ff->passthrough_filp)
> +		return fuse_passthrough_write_iter(iocb, from);
> +	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
>  		return fuse_cache_write_iter(iocb, from);
>  	else
>  		return fuse_direct_write_iter(iocb, from);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 740a8a7d7ae6..4e2ef3c436d0 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -208,6 +208,12 @@ struct fuse_file {
>=20=20
>  	} readdir;
>=20=20
> +	/**
> +	 * Reference to lower filesystem file for read/write operations
> +	 * handled in pass-through mode
> +	 */
> +	struct file *passthrough_filp;
> +
>  	/** RB node to be linked on fuse_conn->polled_files */
>  	struct rb_node polled_node;
>=20=20
> @@ -252,6 +258,7 @@ struct fuse_args {
>  	bool may_block:1;
>  	struct fuse_in_arg in_args[3];
>  	struct fuse_arg out_args[2];
> +	struct file *passthrough_filp;
>  	void (*end)(struct fuse_conn *fc, struct fuse_args *args, int error);
>  };
>=20=20
> @@ -353,6 +360,9 @@ struct fuse_req {
>  		struct fuse_out_header h;
>  	} out;
>=20=20
> +	/** Lower filesystem file pointer used in pass-through mode */
> +	struct file *passthrough_filp;
> +
>  	/** Used to wake up the task waiting for completion of request*/
>  	wait_queue_head_t waitq;
>=20=20
> @@ -720,6 +730,9 @@ struct fuse_conn {
>  	/* Do not show mount options */
>  	unsigned int no_mount_options:1;
>=20=20
> +	/** Pass-through mode for read/write IO */
> +	unsigned int passthrough:1;
> +
>  	/** The number of requests waiting for completion */
>  	atomic_t num_waiting;
>=20=20
> @@ -1093,4 +1106,11 @@ unsigned int fuse_len_args(unsigned int numargs, s=
truct fuse_arg *args);
>  u64 fuse_get_unique(struct fuse_iqueue *fiq);
>  void fuse_free_conn(struct fuse_conn *fc);
>=20=20
> +int __init fuse_passthrough_aio_request_cache_init(void);
> +void fuse_passthrough_aio_request_cache_destroy(void);
> +int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_req *req);
> +ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *=
to);
> +ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter =
*from);
> +void fuse_passthrough_release(struct fuse_file *ff);
> +
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index bba747520e9b..a8fc9e7fd82e 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -965,6 +965,12 @@ static void process_init_reply(struct fuse_conn *fc,=
 struct fuse_args *args,
>  					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
>  					max_t(unsigned int, arg->max_pages, 1));
>  			}
> +			if (arg->flags & FUSE_PASSTHROUGH) {
> +				fc->passthrough =3D 1;
> +				/* Prevent further stacking */
> +				fc->sb->s_stack_depth =3D
> +					FILESYSTEM_MAX_STACK_DEPTH;
> +			}
>  		} else {
>  			ra_pages =3D fc->max_read / PAGE_SIZE;
>  			fc->no_lock =3D 1;
> @@ -1002,7 +1008,8 @@ void fuse_send_init(struct fuse_conn *fc)
>  		FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
>  		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
>  		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
> -		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA;
> +		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
> +		FUSE_PASSTHROUGH;
>  	ia->args.opcode =3D FUSE_INIT;
>  	ia->args.in_numargs =3D 1;
>  	ia->args.in_args[0].size =3D sizeof(ia->in);
> @@ -1428,18 +1435,24 @@ static int __init fuse_fs_init(void)
>  	if (!fuse_inode_cachep)
>  		goto out;
>=20=20
> -	err =3D register_fuseblk();
> +	err =3D fuse_passthrough_aio_request_cache_init();
>  	if (err)
>  		goto out2;
>=20=20
> -	err =3D register_filesystem(&fuse_fs_type);
> +	err =3D register_fuseblk();
>  	if (err)
>  		goto out3;
>=20=20
> +	err =3D register_filesystem(&fuse_fs_type);
> +	if (err)
> +		goto out4;
> +
>  	return 0;
>=20=20
> - out3:
> + out4:
>  	unregister_fuseblk();
> + out3:
> +	fuse_passthrough_aio_request_cache_destroy();
>   out2:
>  	kmem_cache_destroy(fuse_inode_cachep);
>   out:
> @@ -1457,6 +1470,7 @@ static void fuse_fs_cleanup(void)
>  	 */
>  	rcu_barrier();
>  	kmem_cache_destroy(fuse_inode_cachep);
> +	fuse_passthrough_aio_request_cache_destroy();
>  }
>=20=20
>  static struct kobject *fuse_kobj;
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> new file mode 100644
> index 000000000000..b5eee5acd2a2
> --- /dev/null
> +++ b/fs/fuse/passthrough.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "fuse_i.h"
> +
> +#include <linux/aio.h>
> +#include <linux/fs_stack.h>
> +#include <linux/uio.h>
> +
> +static struct kmem_cache *fuse_aio_request_cachep;
> +
> +struct fuse_aio_req {
> +	struct kiocb iocb;
> +	struct kiocb *iocb_fuse;
> +};
> +
> +static void fuse_copyattr(struct file *dst_file, struct file *src_file,
> +			  bool write)
> +{
> +	struct inode *dst =3D file_inode(dst_file);
> +	struct inode *src =3D file_inode(src_file);
> +
> +	fsstack_copy_attr_times(dst, src);
> +	if (write)
> +		fsstack_copy_inode_size(dst, src);
> +}
> +
> +static void fuse_aio_cleanup_handler(struct fuse_aio_req *aio_req)
> +{
> +	struct kiocb *iocb_fuse =3D aio_req->iocb_fuse;
> +	struct kiocb *iocb =3D &aio_req->iocb;
> +
> +	if (iocb->ki_flags & IOCB_WRITE) {
> +		__sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
> +				      SB_FREEZE_WRITE);
> +		file_end_write(iocb->ki_filp);
> +		fuse_copyattr(iocb_fuse->ki_filp, iocb->ki_filp, true);
> +	}
> +
> +	iocb_fuse->ki_pos =3D iocb->ki_pos;
> +	kmem_cache_free(fuse_aio_request_cachep, aio_req);
> +}
> +
> +static void fuse_aio_rw_complete(struct kiocb *iocb, long res, long res2)
> +{
> +	struct fuse_aio_req *aio_req =3D
> +		container_of(iocb, struct fuse_aio_req, iocb);
> +	struct kiocb *iocb_fuse =3D aio_req->iocb_fuse;
> +
> +	fuse_aio_cleanup_handler(aio_req);
> +	iocb_fuse->ki_complete(iocb_fuse, res, res2);
> +}
> +
> +ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
> +				   struct iov_iter *iter)
> +{
> +	struct file *fuse_filp =3D iocb_fuse->ki_filp;
> +	struct fuse_file *ff =3D fuse_filp->private_data;
> +	struct file *passthrough_filp =3D ff->passthrough_filp;
> +	ssize_t ret;
> +
> +	if (!iov_iter_count(iter))
> +		return 0;
> +
> +	if (is_sync_kiocb(iocb_fuse)) {
> +		struct kiocb iocb;
> +
> +		kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
> +		ret =3D call_read_iter(passthrough_filp, &iocb, iter);
> +		iocb_fuse->ki_pos =3D iocb.ki_pos;
> +	} else {
> +		struct fuse_aio_req *aio_req;
> +
> +		aio_req =3D
> +			kmem_cache_zalloc(fuse_aio_request_cachep, GFP_KERNEL);
> +		if (!aio_req)
> +			return -ENOMEM;
> +
> +		aio_req->iocb_fuse =3D iocb_fuse;
> +		kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
> +		aio_req->iocb.ki_complete =3D fuse_aio_rw_complete;
> +		ret =3D vfs_iocb_iter_read(passthrough_filp, &aio_req->iocb,
> +					 iter);
> +		if (ret !=3D -EIOCBQUEUED)
> +			fuse_aio_cleanup_handler(aio_req);
> +	}
> +
> +	fuse_copyattr(fuse_filp, passthrough_filp, false);
> +
> +	return ret;
> +}
> +
> +ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
> +				    struct iov_iter *iter)
> +{
> +	struct file *fuse_filp =3D iocb_fuse->ki_filp;
> +	struct fuse_file *ff =3D fuse_filp->private_data;
> +	struct file *passthrough_filp =3D ff->passthrough_filp;
> +	struct inode *passthrough_inode =3D file_inode(passthrough_filp);
> +	struct inode *fuse_inode =3D file_inode(fuse_filp);
> +	ssize_t ret;
> +
> +	if (!iov_iter_count(iter))
> +		return 0;
> +
> +	inode_lock(fuse_inode);
> +
> +	if (is_sync_kiocb(iocb_fuse)) {
> +		struct kiocb iocb;
> +
> +		kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
> +
> +		file_start_write(passthrough_filp);
> +		ret =3D call_write_iter(passthrough_filp, &iocb, iter);
> +		file_end_write(passthrough_filp);
> +
> +		iocb_fuse->ki_pos =3D iocb.ki_pos;
> +		fuse_copyattr(fuse_filp, passthrough_filp, true);
> +	} else {
> +		struct fuse_aio_req *aio_req;
> +
> +		aio_req =3D
> +			kmem_cache_zalloc(fuse_aio_request_cachep, GFP_KERNEL);
> +		if (!aio_req)
> +			return -ENOMEM;
> +
> +		file_start_write(passthrough_filp);
> +		__sb_writers_release(passthrough_inode->i_sb, SB_FREEZE_WRITE);
> +
> +		aio_req->iocb_fuse =3D iocb_fuse;
> +		kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
> +		aio_req->iocb.ki_complete =3D fuse_aio_rw_complete;
> +		ret =3D vfs_iocb_iter_write(passthrough_filp, &aio_req->iocb,
> +					  iter);
> +		if (ret !=3D -EIOCBQUEUED)
> +			fuse_aio_cleanup_handler(aio_req);
> +	}
> +
> +	inode_unlock(fuse_inode);
> +
> +	return ret;
> +}
> +
> +int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_req *req)
> +{
> +	struct super_block *passthrough_sb;
> +	struct inode *passthrough_inode;
> +	struct fuse_open_out *open_out;
> +	struct file *passthrough_filp;
> +	unsigned short open_out_index;
> +	int fs_stack_depth;
> +
> +	req->passthrough_filp =3D NULL;
> +
> +	if (!fc->passthrough)
> +		return 0;
> +
> +	if (!(req->in.h.opcode =3D=3D FUSE_OPEN && req->args->out_numargs =3D=
=3D 1) &&
> +	    !(req->in.h.opcode =3D=3D FUSE_CREATE && req->args->out_numargs =3D=
=3D 2))
> +		return 0;
> +
> +	open_out_index =3D req->args->out_numargs - 1;
> +
> +	if (req->args->out_args[open_out_index].size !=3D sizeof(*open_out))
> +		return 0;
> +
> +	open_out =3D req->args->out_args[open_out_index].value;
> +
> +	if (!(open_out->open_flags & FOPEN_PASSTHROUGH))
> +		return 0;
> +
> +	passthrough_filp =3D fget(open_out->fd);
> +	if (!passthrough_filp) {
> +		pr_err("FUSE: invalid file descriptor for passthrough.\n");
> +		return -1;
> +	}
> +
> +	if (!passthrough_filp->f_op->read_iter ||
> +	    !passthrough_filp->f_op->write_iter) {
> +		pr_err("FUSE: passthrough file misses file operations.\n");
> +		fput(passthrough_filp);
> +		return -1;
> +	}
> +
> +	passthrough_inode =3D file_inode(passthrough_filp);
> +	passthrough_sb =3D passthrough_inode->i_sb;
> +	fs_stack_depth =3D passthrough_sb->s_stack_depth + 1;
> +	if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> +		pr_err("FUSE: maximum fs stacking depth exceeded for passthrough\n");
> +		fput(passthrough_filp);
> +		return -1;
> +	}
> +
> +	req->passthrough_filp =3D passthrough_filp;
> +	return 0;
> +}
> +
> +void fuse_passthrough_release(struct fuse_file *ff)
> +{
> +	if (ff->passthrough_filp) {
> +		fput(ff->passthrough_filp);
> +		ff->passthrough_filp =3D NULL;
> +	}
> +}
> +
> +int __init fuse_passthrough_aio_request_cache_init(void)
> +{
> +	fuse_aio_request_cachep =3D
> +		kmem_cache_create("fuse_aio_req", sizeof(struct fuse_aio_req),
> +				  0, SLAB_HWCACHE_ALIGN, NULL);
> +	if (!fuse_aio_request_cachep)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void fuse_passthrough_aio_request_cache_destroy(void)
> +{
> +	kmem_cache_destroy(fuse_aio_request_cachep);
> +}
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 373cada89815..e50bd775210a 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -283,6 +283,7 @@ struct fuse_file_lock {
>  #define FOPEN_NONSEEKABLE	(1 << 2)
>  #define FOPEN_CACHE_DIR		(1 << 3)
>  #define FOPEN_STREAM		(1 << 4)
> +#define FOPEN_PASSTHROUGH	(1 << 5)
>=20=20
>  /**
>   * INIT request/reply flags
> @@ -342,6 +343,7 @@ struct fuse_file_lock {
>  #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
>  #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
>  #define FUSE_MAP_ALIGNMENT	(1 << 26)
> +#define FUSE_PASSTHROUGH	(1 << 27)
>=20=20
>  /**
>   * CUSE INIT request/reply flags
> @@ -591,7 +593,7 @@ struct fuse_create_in {
>  struct fuse_open_out {
>  	uint64_t	fh;
>  	uint32_t	open_flags;
> -	uint32_t	padding;
> +	int32_t		fd;
>  };
>=20=20
>  struct fuse_release_in {
> --=20
> 2.28.0.220.ged08abb693-goog


--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
