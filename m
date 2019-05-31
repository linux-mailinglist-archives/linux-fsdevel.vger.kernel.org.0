Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7C03113C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 17:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfEaPYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 11:24:55 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38831 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaPYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 11:24:55 -0400
Received: by mail-vk1-f194.google.com with SMTP id p24so1574051vki.5;
        Fri, 31 May 2019 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEg8poyqwYtnWx2YPi+YoDckEuCKhMrzMAk4Xl/FumE=;
        b=lT63YJCOZNkcwxEJKsc1pEtErLXcqZ+AVzqOMqZMD57GWVmL+A3dQGkSkuLaTmBN9Q
         vjsSpRN2yUjVDrH4QPU6XcggEO/9hoZYvcXsG8sP38qVmwHUmemsCJOUb2Q6h0CsKMYb
         XxUF9OaXolW7uWc1mYZhh4HlTuFh5roW+ydNW4cbQu2H8DlVUb+JgRLpy+K0igEmdL47
         7z1LDyIY+G6kpFh4Loat0jtT0dzTDMDIVi6mRkpEXHqz8AeOBIm1UoTeO+4LXhDDV4u0
         nOV7Af+pBlO/CoL2BI87A0SAXN7yeeIKBOo2UW96naankv4VNcBrSiWwVgE8D+AfRAVA
         Fzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEg8poyqwYtnWx2YPi+YoDckEuCKhMrzMAk4Xl/FumE=;
        b=TJHVsrh3y7z58FYt3ixpozUR92nUPDxGenAQwYjbtwKtw6vWqUUmzbUIbiPYDbGuD/
         6VF10PrmjFQTr++Z2IGt1dfKYcTbhFoJvOExCemDIDfrKUSfS2WSdHtRP7QvJKsDcOwC
         EDoLrGBnVAI4wv3EFFSrmj9wOL7zxTXgDUIgsjO5DJJIZnc2pdIW7IOiXWUc7+/LkFVD
         qKiluUI3i/85eMbcIP+8YCKSjFmfiC0koK+Ah4WjMZp044YMBroF1edv1jtThlrBsbEb
         4iMLgfpLASC/cwQU+unJKvGJ0JzAhGI3QZTh17wy2vO5hOTgEtod4Qd3hz1aJ7W25yEl
         EKLw==
X-Gm-Message-State: APjAAAVvn458jx4ranqRuUqQ0EYanvrbQz0v4+QTq9SGuCCm4qPmLuA7
        WZmeUx1UOQ3m0zdKE433sCT8B97u3zdEwe70yI0=
X-Google-Smtp-Source: APXvYqzqrgUiCgeYr7DGvNL0vJ+We13UA9n6YH6XQRRk7isT/EMt/dUXVWSZXYRRWV+uWpUmhhsBsCLwhOh1Wzhrfwk=
X-Received: by 2002:a1f:888e:: with SMTP id k136mr4153011vkd.33.1559316293985;
 Fri, 31 May 2019 08:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190530094147.14512-1-xzhou@redhat.com> <20190530152606.GA5383@magnolia>
 <20190530155851.GB5383@magnolia>
In-Reply-To: <20190530155851.GB5383@magnolia>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 31 May 2019 11:24:42 -0400
Message-ID: <CAN-5tyFoNJrQTn1ZkNsmaBd=yn2kWpZObGe8ka6CDFxcHaXP6w@mail.gmail.com>
Subject: Re: NFS & CIFS support dedupe now?? Was: Re: [PATCH] generic/517:
 notrun on NFS due to unaligned dedupe in test
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     sfrench@samba.org, Anna Schumaker <anna.schumaker@netapp.com>,
        trond.myklebust@hammerspace.com, fengxiaoli0714@gmail.com,
        fstests@vger.kernel.org, Murphy Zhou <xzhou@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 30, 2019 at 12:02 PM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
>
> Hi everyone,
>
> Murphy Zhou sent a patch to generic/517 in fstests to fix a dedupe
> failure he was seeing on NFS:
>
> On Thu, May 30, 2019 at 05:41:47PM +0800, Murphy Zhou wrote:
> > NFSv4.2 could pass _require_scratch_dedupe, since the test offset and
> > size are aligned, while generic/517 is performing unaligned dedupe.
> > NFS does not support unaligned dedupe now, returns EINVAL.
> >
> > Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> > ---
> >  tests/generic/517 | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/generic/517 b/tests/generic/517
> > index 601bb24e..23665782 100755
> > --- a/tests/generic/517
> > +++ b/tests/generic/517
> > @@ -30,6 +30,7 @@ _cleanup()
> >  _supported_fs generic
> >  _supported_os Linux
> >  _require_scratch_dedupe
> > +$FSTYP == "nfs"  && _notrun "NFS can't handle unaligned deduplication"
>
> I was surprised to see a dedupe fix for NFS since (at least to my
> knowledge) neither of these two network filesystems actually support
> server-side deduplication commands, and therefore the
> _require_scratch_dedupe should have _notrun the test.
>
> Then I looked at fs/nfs/nfs4file.c:
>
> static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
>                 struct file *dst_file, loff_t dst_off, loff_t count,
>                 unsigned int remap_flags)
> {
>         <local variable declarations>
>
>         if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
>                 return -EINVAL;
>
>         <check alignment, lock inodes, flush pending writes>
>
>         ret = nfs42_proc_clone(src_file, dst_file, src_off, dst_off, count);
>
> The NFS client code will accept REMAP_FILE_DEDUP through remap_flags,
> which is how dedupe requests are sent to filesystems nowadays.  The nfs
> client code does not itself compare the file contents, but it does issue
> a CLONE command to the NFS server.  The end result, AFAICT, is that a
> user program can write 'A's to file1, 'B's to file2, issue a dedup
> ioctl to the kernel, and have a block of 'B's mapped into file1.  That's
> broken behavior, according to the dedup ioctl manpage.
>
> Notice how remap_flags is checked but is not included in the
> nfs42_proc_clone call?  That's how I conclude that the NFS client cannot
> possibly be sending the dedup request to the server.
>
> The same goes for fs/cifs/cifsfs.c:
>
> static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
>                 struct file *dst_file, loff_t destoff, loff_t len,
>                 unsigned int remap_flags)
> {
>         <local variable declarations>
>
>         if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
>                 return -EINVAL;
>
>         <check files, lock inodes, flush pages>
>
>         if (target_tcon->ses->server->ops->duplicate_extents)
>                 rc = target_tcon->ses->server->ops->duplicate_extents(xid,
>                         smb_file_src, smb_file_target, off, len, destoff);
>         else
>                 rc = -EOPNOTSUPP;
>
> Again, remap_flags is checked here but it has no influence over the
> ->duplicate_extents call.
>
> Next I got to thinking that when I reworked the clone/dedupe code last
> year, I didn't include REMAP_FILE_DEDUP support for cifs or nfs, because
> as far as I knew, neither protocol supports a verb for deduplication.
> The remap_flags checks were modified to allow REMAP_FILE_DEDUP in
> commits ce96e888fe48e (NFS) and b073a08016a10 (CIFS) with this
> justification (the cifs commit has a similar message):
>
> "Subject: Fix nfs4.2 return -EINVAL when do dedupe operation
>
> "dedupe_file_range operations is combiled into remap_file_range.
> "    But in nfs42_remap_file_range, it's skiped for dedupe operations.
> "    Before this patch:
> "      # dd if=/dev/zero of=nfs/file bs=1M count=1
> "      # xfs_io -c "dedupe nfs/file 4k 64k 4k" nfs/file
> "      XFS_IOC_FILE_EXTENT_SAME: Invalid argument
> "    After this patch:
> "      # dd if=/dev/zero of=nfs/file bs=1M count=1
> "      # xfs_io -c "dedupe nfs/file 4k 64k 4k" nfs/file
> "      deduped 4096/4096 bytes at offset 65536
> "      4 KiB, 1 ops; 0.0046 sec (865.988 KiB/sec and 216.4971 ops/sec)"
>
> This sort of looks like monkeypatching to make an error message go away.
> One could argue that this ought to return EOPNOSUPP instead of EINVAL,
> and maybe that's what should've happened.
>
> So, uh, do NFS and CIFS both support server-side dedupe now, or are
> these patches just plain wrong?
>
> No, they're just wrong, because I can corrupt files like so on NFS:
>
> $ rm -rf urk moo
> $ xfs_io -f -c "pwrite -S 0x58 0 31048" urk
> wrote 31048/31048 bytes at offset 0
> 30 KiB, 8 ops; 0.0000 sec (569.417 MiB/sec and 153846.1538 ops/sec)
> $ xfs_io -f -c "pwrite -S 0x59 0 31048" moo
> wrote 31048/31048 bytes at offset 0
> 30 KiB, 8 ops; 0.0001 sec (177.303 MiB/sec and 47904.1916 ops/sec)
> $ md5sum urk moo
> 37d3713e5f9c4fe0f8a1f813b27cb284  urk
> a5b6f953f27aa17e42450ff4674fa2df  moo
> $ xfs_io -c "dedupe urk 0 0 4096" moo
> deduped 4096/4096 bytes at offset 0
> 4 KiB, 1 ops; 0.0012 sec (3.054 MiB/sec and 781.8608 ops/sec)
> $ md5sum urk moo
> 37d3713e5f9c4fe0f8a1f813b27cb284  urk
> 2c992d70131c489da954f1d96d8c456e  moo
>
> (Not sure about cifs, since I don't have a Windows Server handy)
>
> I'm not an expert in CIFS or NFS, so I'm asking: do either support
> dedupe or is this a kernel bug?

NFS does not support dedupe and only supports cloning (whole) files.
