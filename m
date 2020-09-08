Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC4826220A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 23:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgIHVnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 17:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgIHVnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:43:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD135C061573
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2020 14:43:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so743760wrr.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2020 14:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UBpu6f7JPWu7mFzpAb9CHAPz8zD95yvmmkzOzZp98jA=;
        b=FiXvdqBYzB+4D+HFadNqvHjUIqtaDh3f2Zq+38whUPL7LfcZA+qPe7pg37t0bPGcGj
         MV0m3Y6Fl2Fz0e4ZAqscol/7beZvSbiPywL9sHln/qmD5r3TRd380bxbhtmggoYcEs3c
         Nl42XbqJz+2HXKNGiJinUGPoJhPpPu1DCDFOXHM85K0q3btaVu92h9eEvUfpiQi9MTsw
         M69T71KJob6PTJ4jdpc23yRkPJja6MKzmuMFcvOrpeh0GvKP69HfQ9iRd0TGJGOfB4Lx
         mvAhDWGapi0Tl5TBybAtDk+twjTe2OyagTFJBdH+7mb0IR5zlBHstWuneb5YuRhRwgyC
         iNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UBpu6f7JPWu7mFzpAb9CHAPz8zD95yvmmkzOzZp98jA=;
        b=Yb5yiSbe5ueeKH+v6eQ7h8SMbtC+WT0qk/yK1Ac+fuOU1Cc26nBMMm9z3Ad1iddK0w
         +GPiPy1wHXnpV9f7GN1eie9JBx3z8cmC1jdSxCb3Dtol2vpJSdIzojtztGgopCLKEV40
         z8MdD+QCWEmo8XmgAgdsj0TAGdRLqCxkyFR276DNMbi+tzRm8+2hzcFiMEy+bIIUqzTJ
         Geo5WM82qlZdqaiPWXCilj2h47dldIhaVJwGtM8wbtXYwVf0HdPfvShGvFVN/kHLm+4e
         5+O5zCDUvOnYmHH4PoOxV34ggU4ifVsbtuSZgEPwLFLVMoBFkhkVBwqNGQxaybnfhjlt
         GmPA==
X-Gm-Message-State: AOAM5310HoSQGDaqGjY2GmBvo2ei8WmiEPqAIqsOy7SXNUi8LTmLGej7
        xsY1ERKtTWL40tdy/XLgQhNGtQ==
X-Google-Smtp-Source: ABdhPJzC+mwvHjlxnJTdhYmXaFWp9vE0XGelWzsCK42UAx9hLwFL8JST+xTcpLXYmpO0SapmIwqUxg==
X-Received: by 2002:adf:8481:: with SMTP id 1mr447092wrg.231.1599601378751;
        Tue, 08 Sep 2020 14:42:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id l8sm1090380wrx.22.2020.09.08.14.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 14:42:58 -0700 (PDT)
Date:   Tue, 8 Sep 2020 22:42:56 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Jann Horn <jannh@google.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20200908214256.GA2526301@google.com>
References: <20200812161452.3086303-1-balsini@android.com>
 <CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com>
 <20200813132809.GA3414542@google.com>
 <CAG48ez0jkU7iwdLYPA0=4PdH0SL8wpEPrYvpSztKG3JEhkeHag@mail.gmail.com>
 <20200818135313.GA3074431@google.com>
 <CAG48ez3ZX8R9kRAQhung2_e3wjowu5cPh7WL3U866mkga-kftQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3ZX8R9kRAQhung2_e3wjowu5cPh7WL3U866mkga-kftQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Jann,

Sorry for the late reply, I wanted to better understand the problems you
mentioned and explore the ioctl solution before coming back to discussion.
I have a new patch ready which addresses the feedbacks received, and that
has been converted to using a new ioctl. And I have to say I'm happy with
this ioctl-based solution. :)
I'll finish replying to the different branches of this thread and post the
patch as soon as I'm done with testing, hopefully by tomorrow EOD.

Inline replies below.

On Wed, Aug 19, 2020 at 12:04:03PM +0200, Jann Horn wrote:
> [...]
> FYI, rw_verify_area() annoyingly calls security_file_permission(),
> which is hooked by some stuff like SELinux. This doesn't really fit
> well into the normal Linux security model, and it means that when a
> userspace process tries to read from a FUSE file with passthrough
> enabled, SELinux will actually perform access checks against *both*
> the FUSE file itself and the backing file. That's kinda stupid, but
> SELinux does it. If this ends up being a problem, switching
> credentials would help. (Changing rw_verify_area() to not call
> security_file_permission() would also help, but some of the LSM folks
> might disagree with my opinion that that check is silly and should be
> removed.)
> 
> But for now, I guess it might be fine to leave things as-is and not do
> the extra credential switching.

I would be happy to leave this simplified access as-is too, or in the case
something bad comes out, to implement the credential switching solution.
Let's see if also Miklos or Jens have an opinion on this.

> 
> > On Thu, Aug 13, 2020 at 08:30:21PM +0200, 'Jann Horn' via kernel-team wrote:
> [...]
> There are setuid root binaries that will print attacker-controlled
> data to stdout, or stuff like that. An attacker could set up a normal
> FUSE filesystem, read an OPEN request from the /dev/fuse file
> descriptor, construct a reply that would install a passthrough fd (but
> NOT actually send it), and then invoke a setuid root binary with the
> /dev/fuse fd as stderr and with some arguments that trick it into
> writing the attacker-constructed reply to stderr. For example, you can
> make "su" write a string starting with attacker-controlled data like
> this:
> 
> $ cat blah.c
> #include <unistd.h>
> #include <err.h>
> int main(void) {
>   execlp("su", "ATTACKER-CONTROLLED STRING", "-BLAH", NULL);
>   err(1, "execlp");
> }
> $ gcc -o blah blah.c
> $ ./blah
> ATTACKER-CONTROLLED STRING: invalid option -- 'B'
> Try 'ATTACKER-CONTROLLED STRING --help' for more information.
> $
> 
> And yes, sure, I know, you can't write nullbytes with this specific
> example; but in principle, you have to assume that a privileged victim
> process might be writing arbitrary attacker-controlled data to
> attacker-supplied file descriptors.

Now I see your point! The ioctl-based solution is on the way.

> [...]
> > +ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
> > +                                  struct iov_iter *iter)
> > +{
> > +       struct file *fuse_filp = iocb_fuse->ki_filp;
> > +       struct fuse_file *ff = fuse_filp->private_data;
> > +       struct file *passthrough_filp = ff->passthrough_filp;
> > +       ssize_t ret;
> > +
> > +       if (!iov_iter_count(iter))
> > +               return 0;
> > +
> > +       if (is_sync_kiocb(iocb_fuse)) {
> > +               struct kiocb iocb;
> > +
> > +               kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
> > +               ret = call_read_iter(passthrough_filp, &iocb, iter);
> > +               iocb_fuse->ki_pos = iocb.ki_pos;
> > +       } else {
> > +               struct fuse_aio_req *aio_req;
> > +
> > +               aio_req =
> > +                       kmem_cache_zalloc(fuse_aio_request_cachep, GFP_KERNEL);
> > +               if (!aio_req)
> > +                       return -ENOMEM;
> > +
> > +               aio_req->iocb_fuse = iocb_fuse;
> > +               kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
> > +               aio_req->iocb.ki_complete = fuse_aio_rw_complete;
> > +               ret = vfs_iocb_iter_read(passthrough_filp, &aio_req->iocb,
> > +                                        iter);
> > +               if (ret != -EIOCBQUEUED)
> > +                       fuse_aio_cleanup_handler(aio_req);
> > +       }
> > +
> > +       fuse_copyattr(fuse_filp, passthrough_filp, false);
> 
> This copies timestamps from the passthrough_filp to the fuse_filp
> without any locking I can see - which means that depending on the
> architecture and the compiler's decisions, the copied timestamps can
> end up getting corrupted to some degree. On 64-bit platforms, in
> practice, you might e.g. end up with a timestamp where the tv_nsec
> part is from an older timestamp while tv_sec is from a newer one,
> yielding an overall timestamp that might e.g. be almost a second in
> the future; and on 32-bit platforms, the results could even be much
> worse. In theory, this is a data race, which should generally be
> avoided.
> 
> The same thing applies to some of the other places where
> fuse_copyattr() is used.

I'm not too confident in this RCU domain, so what do you think about
changing the fuse_copyattr() code into:

static void fuse_copyattr(struct file *dst_file, struct file *src_file,
                          bool write)
{
        struct inode *dst = file_inode(dst_file);
        struct inode *src = file_inode(src_file);
        struct timespec64 i_atime, i_mtime, i_ctime;

        spin_lock(&src->i_lock);
        i_atime = src->i_atime;
        i_mtime = src->i_mtime;
        i_ctime = src->i_ctime;
        spin_unlock(&src->i_lock);
        spin_lock(&dst->i_lock);
        dst->i_atime = i_atime;
        dst->i_mtime = i_mtime;
        dst->i_ctime = i_ctime;
        spin_unlock(&dst->i_lock);

        if (write)
                fsstack_copy_inode_size(dst, src);
}

The i_*time copy behavior is similar to fsstack_copy_inode_size().
IIRC I didn't add any locking because a comment at the top of fs_stack.h
mentions that the functions declared there do not require i_mutex to be
held, and since fsstack_copy_inode_size() has its own lockings, I probably
assumed that i_*time were special. But actually, not requiring i_mutex
doesn't mean not requiring any locking. Oops! :P

> 
> From a higher-level perspective, are you sure that you even want to do
> this timestamp-copying at all, given that the userspace fuse daemon
> will also be supplying its own timestamps? Especially considering that
> the timestamps are at the inode level while the passthrough logic is
> at the file level, that seems pretty wonky.

Yeah, that looks wonky... :)
But while testing I noticed that the system was misbehaving when the FUSE
stats were not manually updated with the lower filesystem.
My understanding is that being the FUSE passthrough read/write operations
transparent to the FUSE daemon, if stats caching is enabled the kernel
would return the cached stats without forwarding the request to the FUSE
daemon, and this may produce inconsistencies with the lower filesystem.
This copying solution prevents forcing the daemon to disable stats caching.

This reminds me that I should update the commit message mentioning the
reasoning behind these stats updates.

> [...]
> > +       if (!(req->in.h.opcode == FUSE_OPEN && req->args->out_numargs == 1) &&
> > +           !(req->in.h.opcode == FUSE_CREATE && req->args->out_numargs == 2))
> > +               return 0;
> > +
> > +       open_out_index = req->args->out_numargs - 1;
> > +
> > +       if (req->args->out_args[open_out_index].size != sizeof(*open_out))
> > +               return 0;
> 
> Can this ever legitimately happen, or would that indicate a kernel
> bug? If it indicates a kernel bug, please write WARN_ON() around the
> condition, like this: "if
> (WARN_ON(req->args->out_args[open_out_index].size !=
> sizeof(*open_out)))".

Will be chopped in the next patch with ioctl().

> > +       if (!passthrough_filp->f_op->read_iter ||
> > +           !passthrough_filp->f_op->write_iter) {
> > +               pr_err("FUSE: passthrough file misses file operations.\n");
> > +               fput(passthrough_filp);
> > +               return -1;
> > +       }
> 
> (Just as a non-actionable comment: This means that passthrough files
> won't work with files that use ->read and ->write handlers instead of
> ->read_iter and ->write_iter. But that's probably actually a good
> thing - ->read and ->write are mostly used by weird pseudo-files, and
> I don't see any legitimate reason why anyone would want to use those
> things with FUSE passthrough.)
> 

I like this checking because if on the one hand, as you mentioned, this
represents a restriction for those pseud-files not implementing
{read,write}_iter operations, on the other hand vfs automatically falls back to
the {read,write}_iter counterpart if a filesystem doesn't implement the
original read/write. So, why not?

> > +       passthrough_inode = file_inode(passthrough_filp);
> > +       passthrough_sb = passthrough_inode->i_sb;
> > +       fs_stack_depth = passthrough_sb->s_stack_depth + 1;
> > +       if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> > +               pr_err("FUSE: maximum fs stacking depth exceeded for passthrough\n");
> > +               fput(passthrough_filp);
> > +               return -1;
> > +       }
> > +
> > +       req->passthrough_filp = passthrough_filp;
> > +       return 0;
> > +}
> [...]
> > +int __init fuse_passthrough_aio_request_cache_init(void)
> > +{
> > +       fuse_aio_request_cachep =
> > +               kmem_cache_create("fuse_aio_req", sizeof(struct fuse_aio_req),
> > +                                 0, SLAB_HWCACHE_ALIGN, NULL);
> > +       if (!fuse_aio_request_cachep)
> > +               return -ENOMEM;
> > +
> > +       return 0;
> > +}
> > +
> > +void fuse_passthrough_aio_request_cache_destroy(void)
> > +{
> > +       kmem_cache_destroy(fuse_aio_request_cachep);
> > +}
> 
> I think you don't have to make your own slab cache for this; it should
> be fine to just use kmalloc() instead. Using a dedicated cache will be
> more space-efficient if you have tons of allocations, but you won't
> have a huge number of these allocations existing simultaneously, so
> that shouldn't matter much. And if you only have a very small number
> of allocations, you'll probably actually end up using more memory.

I fell into an overkill trying to do the right thing.
Jumping back to kmalloc/kfree.

Thanks again,
Alessio
