Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0E6322FB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 18:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhBWReN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 12:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhBWReB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:34:01 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772E9C061574;
        Tue, 23 Feb 2021 09:33:21 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id f7so1663075ilk.12;
        Tue, 23 Feb 2021 09:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwb87/KKG0XBkU/K3SKXkilDAjVgBCfWXWZt0XKw96g=;
        b=DRgf7YEqiSOEnBz98pKaExAtNfOvw5j27hz9N0nj1AazZoGQ2fzmKds34aRLB9hsFi
         NLjaOCBFOHuyUzGkGO7GJ/zoyA+3VlOHhHyoyNt8SzrxCQync5j7Hgs5qUv5WIaSiLnn
         AdUR/sAP5k8mDnhybxnc2KQQqM0uAaHUFyJybs4rZ+2tMDdPIYKwWcvIVaa2pcvQ5riW
         Ra6uMmbsNnSbrr4mUX5ogaPDI4AbjuHjYSSm4RBUhm+rg0fPTxfR7hj0yIadDkgadfUz
         uR3yeKhD3wopbvJDIRVkRH7NpyJKXkLrs7l3B+lKIYe8SpR9YiKkyZqM7hXL2Jscrw20
         DGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwb87/KKG0XBkU/K3SKXkilDAjVgBCfWXWZt0XKw96g=;
        b=DwQqnVN15JpIytbP36WGCryyzstOlT1wgakPUTYwZ6R3mNxbTSqcr8CHRUie5QRQ6l
         k9oMUMCOcx4rd1k8YHzjhYF+ZyyxpZdRGfBoRVTyYYK2eOgKNwZtQvfno/JemI601hnV
         S1YRAapMdxIoWv3AzV0nEK3yaQgIv42N0PcO6S9NJQWFvpL772xS1IShQqIqMM5y5qr/
         9hwb/GNyxhHHxBCQ2v5Ueo/fJFCKiYneHstCIZfi1OehsOQF5ycx+y08vJWeNZuZ3XI5
         KHWIwKxzGufoqL/s596iwsPJMhjc66Edhms7Gsp4XssVVOEjNBAIAHTTqZW+Gfie+3vm
         pxIQ==
X-Gm-Message-State: AOAM5322Ew55TQ0bengbN4s0bGoJBwl6hDciL3IUPI/fyIgZTIKNfeo2
        2/gm/c/Eir1zU8iCLZq2uQCmJd0gdinDMCf8kciEq/DRybQ=
X-Google-Smtp-Source: ABdhPJyFI+UzyvQHJAxdY+O3qNKzLXbpg7/MR197YfZS7SL+gZIrVLBQT0cub1Web4DIzl4ocHcfsO9QH2sDfCDwtuo=
X-Received: by 2002:a92:c90b:: with SMTP id t11mr21157281ilp.275.1614101600808;
 Tue, 23 Feb 2021 09:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20210221195833.23828-1-lhenriques@suse.de> <20210222102456.6692-1-lhenriques@suse.de>
 <26a22719-427a-75cf-92eb-dda10d442ded@oracle.com> <YDTZwH7xv41Wimax@suse.de>
 <7cc69c24-80dd-0053-24b9-3a28b0153f7e@oracle.com> <7c12e6a3-e4a6-5210-1b57-09072eac3270@oracle.com>
 <CAOQ4uxh2E2oJjHoOBY3GU__6UcjE67E7qR1uMus7f_xhQyM54g@mail.gmail.com>
 <72c41310-85e4-16fe-8d9c-d42abe0566a9@oracle.com> <e3eed18b-fc7e-e687-608b-7f662017329c@oracle.com>
In-Reply-To: <e3eed18b-fc7e-e687-608b-7f662017329c@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 23 Feb 2021 19:33:09 +0200
Message-ID: <CAOQ4uxg4diJwpdhUydZ4rtCo2vv0uKwXmr1QiybLt0XVFOB8Eg@mail.gmail.com>
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
To:     dai.ngo@oracle.com
Cc:     Luis Henriques <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 23, 2021 at 7:31 PM <dai.ngo@oracle.com> wrote:
>
> On 2/23/21 8:57 AM, dai.ngo@oracle.com wrote:
>
>
> On 2/23/21 8:47 AM, Amir Goldstein wrote:
>
> On Tue, Feb 23, 2021 at 6:02 PM <dai.ngo@oracle.com> wrote:
>
>
> On 2/23/21 7:29 AM, dai.ngo@oracle.com wrote:
>
> On 2/23/21 2:32 AM, Luis Henriques wrote:
>
> On Mon, Feb 22, 2021 at 08:25:27AM -0800, dai.ngo@oracle.com wrote:
>
> On 2/22/21 2:24 AM, Luis Henriques wrote:
>
> A regression has been reported by Nicolas Boichat, found while
> using the
> copy_file_range syscall to copy a tracefs file.  Before commit
> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> kernel would return -EXDEV to userspace when trying to copy a file
> across
> different filesystems.  After this commit, the syscall doesn't fail
> anymore
> and instead returns zero (zero bytes copied), as this file's
> content is
> generated on-the-fly and thus reports a size of zero.
>
> This patch restores some cross-filesystem copy restrictions that
> existed
> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy
> across
> devices").  Filesystems are still allowed to fall-back to the VFS
> generic_copy_file_range() implementation, but that has now to be done
> explicitly.
>
> nfsd is also modified to fall-back into generic_copy_file_range()
> in case
> vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
>
> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> devices")
> Link:
> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmi49dC6w$
> Link:
> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx*BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/__;Kw!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmgCmMHzA$
> Link:
> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/__;!!GqivPVa7Brio!P1UWThiSkxbjfjFQWNYJmCxGEkiLFyvHjH6cS-G1ZTt1z-TeqwGQgQmzqItkrQ$
> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> Changes since v7
> - set 'ret' to '-EOPNOTSUPP' before the clone 'if' statement so
> that the
>      error returned is always related to the 'copy' operation
> Changes since v6
> - restored i_sb checks for the clone operation
> Changes since v5
> - check if ->copy_file_range is NULL before calling it
> Changes since v4
> - nfsd falls-back to generic_copy_file_range() only *if* it gets
> -EOPNOTSUPP
>      or -EXDEV.
> Changes since v3
> - dropped the COPY_FILE_SPLICE flag
> - kept the f_op's checks early in generic_copy_file_checks,
> implementing
>      Amir's suggestions
> - modified nfsd to use generic_copy_file_range()
> Changes since v2
> - do all the required checks earlier, in generic_copy_file_checks(),
>      adding new checks for ->remap_file_range
> - new COPY_FILE_SPLICE flag
> - don't remove filesystem's fallback to generic_copy_file_range()
> - updated commit changelog (and subject)
> Changes since v1 (after Amir review)
> - restored do_copy_file_range() helper
> - return -EOPNOTSUPP if fs doesn't implement CFR
> - updated commit description
>
>     fs/nfsd/vfs.c   |  8 +++++++-
>     fs/read_write.c | 49
> ++++++++++++++++++++++++-------------------------
>     2 files changed, 31 insertions(+), 26 deletions(-)
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 04937e51de56..23dab0fa9087 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -568,6 +568,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file
> *nf_src, u64 src_pos,
>     ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos,
> struct file *dst,
>                      u64 dst_pos, u64 count)
>     {
> +    ssize_t ret;
>         /*
>          * Limit copy to 4MB to prevent indefinitely blocking an nfsd
> @@ -578,7 +579,12 @@ ssize_t nfsd_copy_file_range(struct file *src,
> u64 src_pos, struct file *dst,
>          * limit like this and pipeline multiple COPY requests.
>          */
>         count = min_t(u64, count, 1 << 22);
> -    return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> +    ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> +
> +    if (ret == -EOPNOTSUPP || ret == -EXDEV)
> +        ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
> +                          count, 0);
> +    return ret;
>     }
>     __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh
> *fhp,
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 75f764b43418..5a26297fd410 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1388,28 +1388,6 @@ ssize_t generic_copy_file_range(struct file
> *file_in, loff_t pos_in,
>     }
>     EXPORT_SYMBOL(generic_copy_file_range);
> -static ssize_t do_copy_file_range(struct file *file_in, loff_t
> pos_in,
> -                  struct file *file_out, loff_t pos_out,
> -                  size_t len, unsigned int flags)
> -{
> -    /*
> -     * Although we now allow filesystems to handle cross sb copy,
> passing
> -     * a file of the wrong filesystem type to filesystem driver
> can result
> -     * in an attempt to dereference the wrong type of
> ->private_data, so
> -     * avoid doing that until we really have a good reason.  NFS
> defines
> -     * several different file_system_type structures, but they all
> end up
> -     * using the same ->copy_file_range() function pointer.
> -     */
> -    if (file_out->f_op->copy_file_range &&
> -        file_out->f_op->copy_file_range ==
> file_in->f_op->copy_file_range)
> -        return file_out->f_op->copy_file_range(file_in, pos_in,
> -                               file_out, pos_out,
> -                               len, flags);
> -
> -    return generic_copy_file_range(file_in, pos_in, file_out,
> pos_out, len,
> -                       flags);
> -}
> -
>     /*
>      * Performs necessary checks before doing a file copy
>      *
> @@ -1427,6 +1405,25 @@ static int generic_copy_file_checks(struct
> file *file_in, loff_t pos_in,
>         loff_t size_in;
>         int ret;
> +    /*
> +     * Although we now allow filesystems to handle cross sb copy,
> passing
> +     * a file of the wrong filesystem type to filesystem driver
> can result
> +     * in an attempt to dereference the wrong type of
> ->private_data, so
> +     * avoid doing that until we really have a good reason.  NFS
> defines
> +     * several different file_system_type structures, but they all
> end up
> +     * using the same ->copy_file_range() function pointer.
> +     */
> +    if (file_out->f_op->copy_file_range) {
> +        if (file_in->f_op->copy_file_range !=
> +            file_out->f_op->copy_file_range)
> +            return -EXDEV;
> +    } else if (file_in->f_op->remap_file_range) {
> +        if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> +            return -EXDEV;
>
> I think this check is redundant, it's done in vfs_copy_file_range.
> If this check is removed then the else clause below should be removed
> also. Once this check and the else clause are removed then might as
> well move the the check of copy_file_range from here to
> vfs_copy_file_range.
>
> I don't think it's really redundant, although I agree is messy due to
> the
> fact we try to clone first instead of copying them.
>
> So, in the clone path, this is the only place where we return -EXDEV if:
>
> 1) we don't have ->copy_file_range *and*
> 2) we have ->remap_file_range but the i_sb are different.
>
> The check in vfs_copy_file_range() is only executed if:
>
> 1) we have *valid* ->copy_file_range ops and/or
> 2) we have *valid* ->remap_file_range
>
> So... if we remove the check in generic_copy_file_checks() as you
> suggest
> and:
> - we don't have ->copy_file_range,
> - we have ->remap_file_range but
> - the i_sb are different
>
> we'll return the -EOPNOTSUPP (the one set in line "ret =
> -EOPNOTSUPP;" in
> function vfs_copy_file_range() ) instead of -EXDEV.
>
> Yes, this is the different.The NFS code handles both -EOPNOTSUPP and
> -EXDEVV by doing generic_copy_file_range.  Do any other consumers of
> vfs_copy_file_range rely on -EXDEV and not -EOPNOTSUPP and which is
> the correct error code for this case? It seems to me that -EOPNOTSUPP
> is more appropriate than EXDEV when (sb1 != sb2).
>
> EXDEV is the right code for:
> filesystem supports the operation but not for sb1 != sb1.
>
> So with the current patch, for a clone operation across 2 filesystems:
>
>     . if src and dst filesystem support both copy_file_range and
>       map_file_range then the code returns -ENOTSUPPORT.
>
> Why do you say that?
> Which code are you referring to exactly?
>
>
> If the filesystems support both copy_file_range and map_file_range,
> it passes the check in generic_file_check but it fails with the
> check in vfs_copy_file_range and returns -ENOTSUPPORT (added by
> the v8 patch)
>
> Ok, I misread the code here. If it passes the check in generic_copy_file_checks
> and it fails the sb check in vfs_copy_file_range then it tries copy_file_range
> so it's ok.
>
> I think having the check in both generic_copy_file_checks and vfs_copy_file_range
> making the code hard to read. What's the reason not to do the check only in
> vfs_copy_file_range?
>

You are going in circles.
I already answered that.
Please re-read the entire thread on all patch versions before commenting.

Thanks,
Amir.
