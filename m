Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA13243AC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 15:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHMN2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 09:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMN2O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 09:28:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1252CC061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 06:28:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so5292768wrl.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 06:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uBROLMHeoGTEwY2TO05pBSVi0pDnF8JEtl1FXcW9nZw=;
        b=JlBUfoFOT+0f5lEkuRSUpXKd89R75VtGyxTsIICqAhatND/BsO+UDg1l5kwNNrtHY1
         9vwF+Bo9/AbLdNErzEKy8l+u/WzSFmB9bJ2FYOEJ5bklGYL9YCi9kWgxCXITLPTuh6vM
         zj1u/byeXdQ71KGkn1HvN+pgsVDFg0NUgwv0L4feWVwhyYz7mriV1FhnfZccrHqloZJY
         jHYH73JSkFH6zvFX1AtfoViNt4Ol2f5R9LnZ7bM0xeyOPJl2zjjRMX+Nk98TDSYxeCP7
         nF+y1/7y5Opy3WSSHeW/9KwPCDIm3HxKXTEezFJjv0kArhuo5x15vQ6m06TXLfP3E8Us
         7USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uBROLMHeoGTEwY2TO05pBSVi0pDnF8JEtl1FXcW9nZw=;
        b=ZNb2hGoii2PQw2qqxGHVgrSvzu1Y8dKyAOdaHo+Kl1hNwMgWkzGyWtXA84cuKfVnrV
         EOsEalei5/ATbQiaOT6TQih5rfu0rdlcqtS+NT7jsnQ1/OY2hxN7kPQI4iiHDFyE6uEd
         QBOxeryl6/nU/zg2FGPv7HWK8mfi7dwkdJzztk3nZ5PYU7x5e/TXJY96UxLQAOv0SEiI
         Xs2/Sgcpbu6me9aeMzpMj+/+6FvCp43OKO4vpgsiejvpRP+jTttrmnaTOI3MStkLBn88
         put2OfbhlYZaaez5Tr7owesnKq0SrH+eZ6LXvh7zkeIj1VP9SpQYUmhqZ6rBGs1Kd0MY
         dxFA==
X-Gm-Message-State: AOAM530aFmc6RGvbGoNKUEgyGqL2dNO4lAX9D6Os6i8sr6w4qipd4hH/
        n8eBSoYFm3HehS8XSuuRIklRHYFU425b6lCm
X-Google-Smtp-Source: ABdhPJzn89xoxT+OG+s2vCxhgGquEIJ/eC7HnYdeJ6JRhLQJTGLYfXfAAsBu+Sq7RK64c1WIf9GErA==
X-Received: by 2002:adf:a106:: with SMTP id o6mr4073706wro.1.1597325291327;
        Thu, 13 Aug 2020 06:28:11 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id i14sm12581252wrc.19.2020.08.13.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 06:28:10 -0700 (PDT)
Date:   Thu, 13 Aug 2020 14:28:09 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Jann Horn <jannh@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
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
Message-ID: <20200813132809.GA3414542@google.com>
References: <20200812161452.3086303-1-balsini@android.com>
 <CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jann,

Thank you for looking into this.

On Wed, Aug 12, 2020 at 08:29:58PM +0200, 'Jann Horn' via kernel-team wrote:
> [+Jens: can you have a look at that ->ki_filp switcheroo in
> fuse_passthrough_read_write_iter() and help figure out whether that's
> fine? This seems like your area of expertise.]
> 
> On Wed, Aug 12, 2020 at 6:15 PM Alessio Balsini <balsini@android.com> wrote:
> > Add support for filesystem passthrough read/write of files when enabled in
> > userspace through the option FUSE_PASSTHROUGH.
> 
> Oh, I remember this old series... v5 was from 2016? Nice to see
> someone picking this up again, I liked the idea quite a bit.
> 

Yes, it's been a while since the last iteration.
The idea of the original series is as interesting as simple and I think is
a good tradeoff between the flexibility of FUSE and the speed performance
of SDCardFS, that Android has been using for a few years.

> [...]
> Unfortunately, this step isn't really compatible with how the current
> FUSE API works. Essentially, the current FUSE API is reached via
> operations like the write() syscall, and reaches FUSE through either
> ->write_iter or ->splice_write in fuse_dev_operations. In that
> context, operations like fget_raw() that operate on the calling
> process are unsafe.
> 
> The reason why operations like fget() are unsafe in this context is
> that the security model of Linux fundamentally assumes that if you get
> a file descriptor from an untrusted process, and you write stuff into
> it, anything that happens will be limited to things that the process
> that gave you the file descriptor would've been able to do on its own.
> Or in other words, an attacker shouldn't be able to gain anything by
> convincing a privileged process to write attacker-controlled data into
> an attacker-supplied file descriptor. With the current design, an
> attacker may be able to trick a privileged process into installing one
> of its FDs as a passthrough FD into an attacker-controlled FUSE
> instance (while the privileged process thinks that it's just writing
> some opaque data into some file), and thereby make it possible for an
> attacker to indirectly gain the ability to read/write that FD.
> 

This is a great explanation.

I've been thinking about this before posting the patch and my final thought
was that being the FUSE daemon already responsible for handling file ops
coming from untrusted processes, and the privileges of these ops are anyway
escalated to the daemon's, if the FUSE daemon has vulnerabilities to
exploit, there's not much we can do to avoid an attacker to mess with files
at the same permission level as the FUSE daemon. And this is true also
without this patch, right?
IOW, the feature introduced here is something that I agree should be
handled with care, but is there something that can go wrong if the FUSE
daemon is written properly? If we cannot trust the FUSE daemon, then we
should also not trust what it would be able to access, so isn't it enough
to prove that an attacker wouldn't be able to get more privileges than the
FUSE daemon? Sorry if I missed something.

> The only way I see to fix this somewhat cleanly would be to add a new
> command to fuse_dev_ioctl() that can be used to submit replies as an
> alternative to the write()-based interface. (That should probably be a
> separate patch in this patch series.) Then, you could have a flag
> argument to fuse_dev_do_write() that tells it whether the ioctl
> interface was used, and use that information to decide whether
> fuse_setup_passthrough() is allowed.
> (An alternative approach would be to require userspace to set some
> flag on the write operation that says "I am intentionally performing
> an operation that depends on caller identity" and pass that through -
> e.g. by using pwritev2()'s flags argument. But I think historically
> the stance has been that stuff like write() simply should not be
> looking at the calling process.)
> 

I'm not sure I got it right. Could you please elaborate on what is the
purpose of the new fuse_dev_ioctl() command?
Do you mean letting the kernel decide whether a FUSE daemon is allowed to
run fuse_setup_passthrough() or to decide if passthrough should be allowed
on a specific file?
In general, I prefer to avoid as much as I can API changes, let's see if
there is a way to leave them untouched. :)
What do you think about adding some extra checkings in
fuse_setup_passthrough() to let the kernel decide if passthrough is doable?
Do you think this would make things better regarding what you mentioned?

> > +       if (open_out->fd < 0)
> > +               return;
> 
> What is the intent here? fget() will fail anyway if the fd is invalid.

Right, I think I forgot this extra check when I was still unsure about how
to communicate from the FUSE daemon that something was wrong with the given
fd, but you are right, I'll remove this useless check.

> > +       passthrough_filp = fget_raw(open_out->fd);
> 
> This should probably be a normal fget()? fget_raw() is just necessary
> if you want to permit using O_PATH file descriptors, and read/write
> operations don't work on those.
> 

Fair enough. Testing and adding to v7.

> > +       if (!passthrough_filp)
> > +               return;
> 
> This error path can only be reached if the caller supplied invalid
> data. IMO this should bail out with an error.

As you can see I switched from the BUG_ON() approach of the previous patch
to the extreme opposite of transparent, graceful error handling.
Do you think we should abort the whole open operation, or adding a few
warning messages may suffice?

> 
> > +       passthrough_inode = file_inode(passthrough_filp);
> > +       passthrough_sb = passthrough_inode->i_sb;
> > +       fs_stack_depth = passthrough_sb->s_stack_depth + 1;
> > +       if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> > +               fput(passthrough_filp);
> > +               return;
> > +       }
> 
> This is an error path that silently ignores the error and continues to
> open the file normally as if FOPEN_PASSTHROUGH hadn't been set. Is
> this an intentional fallback? If so, maybe you could add a comment on
> top of fuse_setup_passthrough() like: "If setting up passthrough fails
> due to incompatibility, we ignore the error and continue setting up
> the file as normal."

This is intentional behavior, but I'll be glad to add _at least_ a comment,
or as before, a warning message.

> 
> > +       req->passthrough_filp = passthrough_filp;
> > +}
> > +
> > +static inline ssize_t fuse_passthrough_read_write_iter(struct kiocb *iocb,
> > +                                                      struct iov_iter *iter,
> > +                                                      bool write)
> > +{
> > +       struct file *fuse_filp = iocb->ki_filp;
> > +       struct fuse_file *ff = fuse_filp->private_data;
> > +       struct file *passthrough_filp = ff->passthrough_filp;
> > +       struct inode *passthrough_inode;
> > +       struct inode *fuse_inode;
> > +       ssize_t ret = -EIO;
> > +
> > +       fuse_inode = fuse_filp->f_path.dentry->d_inode;
> 
> I think this could just use file_inode(fuse_filp)?

Nice catch! I think I lost this bit in a rebase, thanks!

> 
> 
> > +       passthrough_inode = file_inode(passthrough_filp);
> > +
> > +       iocb->ki_filp = passthrough_filp;
> 
> Hmm... so we're temporarily switching out the iocb's ->ki_filp here? I
> wonder whether it is possible for some other code to look at ->ki_filp
> concurrently... maybe Jens Axboe knows whether that could plausibly
> happen?
> 
> Second question about this switcheroo below...
> 
> > +       if (write) {
> > +               if (!passthrough_filp->f_op->write_iter)
> > +                       goto out;
> > +
> > +               ret = call_write_iter(passthrough_filp, iocb, iter);
> 
> Hmm, I don't think we can just invoke
> call_write_iter()/call_read_iter() like this. If you look at something
> like vfs_writev(), you can see that normally, there are a bunch of
> other things that happen:
> 
>  - file_start_write() before the write
>  - check whether the file's ->f_mode permits writing with FMODE_WRITE
> and FMODE_CAN_WRITE
>  - rw_verify_area() for stuff like mandatory locking and LSM security
> checks (although admittedly this LSM security check is pretty useless)
>  - fsnotify_modify() to trigger inotify watches and such that notify
> userspace of file modifications
>  - file_end_write() after the write
> 
> You should probably try to use vfs_iocb_iter_write() here, and figure
> out how to properly add file_start_write()/file_end_write() calls
> around this. Perhaps ovl_write_iter() from fs/overlayfs/file.c can
> help with this? Note that you can't always just call file_end_write()
> synchronously, since the request may complete asynchronously.

Answering here both the two previous questions, that are strictly related.
I couldn't find any racy path for a specific iocp->ki_filp. Glad to be
proven wrong, let's see if Jens can bring some light here.

Jumping back to vfs with call_{read,write}_iter(), this looked to me as the
most elegant solution, and I find it handy that they also perform extra
checks on the target file. I was worried at the beginning about this vfs
nesting weirdness, but the nesting unrolls just fine, and with visual
inspection I couldn't spot any dangerous situations.
Are you just worried about write operations or reads as well? Maybe Jens
can give some extra advice here too.

> > +out:
> > +       iocb->ki_filp = fuse_filp;
> 
> Also a question that I hope Jens can help with: If this is an
> asynchronous request, would something bad happen if the request
> completes before we reach that last ->ki_filp write (if that is even
> possible)? Or could an asynchronous request blow up because this
> ->ki_filp write happens before the request has completed?

I cannot think of a scenario where we don't complete the request before
restoring the original ki_filp. Jens again to prove me wrong.

> Overall, I wonder whether it would be better to copy overlayfs'
> approach of creating a new iocb instead of trying to switch out parts
> of the existing iocb (see ovl_write_iter()). That would simplify this
> weirdness a lot, at the cost of having to allocate slab memory to
> store the copied iocb.

I'm not familiar with the internals of overlayfs, I will surely give it a
look, seeking for ideas.

Thanks a lot for all the hints!

Cheers,
Alessio

