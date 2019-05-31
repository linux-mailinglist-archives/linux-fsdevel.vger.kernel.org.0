Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A04A31168
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 17:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfEaPf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 11:35:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45757 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfEaPfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 11:35:55 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so8501693ioc.12;
        Fri, 31 May 2019 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1xcsN5I7JMXzyxIvwv3Zvd0oaku/MBapYLHv6XIR6I=;
        b=fIGCn/9f2KV+QHMLhlU264rsPpE+TdF8mE4LNIBM2T6XzAL4NjkVo6JKAQfeCX821M
         99RoQ/asfyXwpyNe1AyNUnqgmGZbH/wEI4q1UDGknaLbfEv9BCajJbycujVj2wocEq/+
         g7MEeC08n8iw2MY6aBv1Pv2PqAs4k2zhVwVCrV1QMnwStysxprusY9R5LEF+hriNDZSV
         tZELSy68mnIL8bgqjNQoZRGNp5OOxyXr+bJQ7tyWQ6Iggp6EpD5IGRWwGlv3mNe1L1pQ
         xHeSXTLT/Sz1IDeLiRYy9Dkag/U5/APaT0ciwmge1JA8UiZTeVcY73n04lD8E6IHQ1sW
         i98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1xcsN5I7JMXzyxIvwv3Zvd0oaku/MBapYLHv6XIR6I=;
        b=syDd5igZIwHF0BfEdHnSCma6nMpzQTE++n6BJQgI58QSwQUqi1+GRKnL8f3MTSYhhb
         jXRae9l9NWGRVYonaHzOkqUx5zwOPprcfT84pnFlqMcLrdZFTevrOmwHCJQMMFIM2SSC
         SjnQCj9QG+QZ0gK4nu599gdbGsnIwQ/+Rhr7kVcvA/qbu6DxGMnszB40+WwVITU5qZys
         TU07oFNSUfdpFOA/D7qagfp4rfGm+MqQQzCL5yz3WP2vaXk+pA5078IaxWmV2lyclHGZ
         NfviKH/V7UkBd49/sEJyJMfPh1g6Vh3/SCkSYBPK1VVJk2G38nw7tiqWuDwquTnRneGu
         kihA==
X-Gm-Message-State: APjAAAWEssVV3hVWBgp1D7RHuBgZ0vuOSoxSXPQwENHaqsBICDgg3ceY
        S+VDHurkD4WIB9AjuaJWmWnowIe+5ItyuMygBg==
X-Google-Smtp-Source: APXvYqyPQvGi2nN8Wvfm14NMf5caf30rzhZJrsSwpCAYphwwGgPEUmqhtwx+4n+pyBXddVSEi8IY8Y/EYVSwhqFJEA0=
X-Received: by 2002:a5d:851a:: with SMTP id q26mr6647916ion.246.1559316954381;
 Fri, 31 May 2019 08:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190530094147.14512-1-xzhou@redhat.com> <20190530152606.GA5383@magnolia>
 <20190530155851.GB5383@magnolia> <CAN-5tyFoNJrQTn1ZkNsmaBd=yn2kWpZObGe8ka6CDFxcHaXP6w@mail.gmail.com>
In-Reply-To: <CAN-5tyFoNJrQTn1ZkNsmaBd=yn2kWpZObGe8ka6CDFxcHaXP6w@mail.gmail.com>
From:   Trond Myklebust <trondmy@gmail.com>
Date:   Fri, 31 May 2019 11:35:43 -0400
Message-ID: <CAABAsM6OtgsWS4VVTouDfPLePWE_JAyozwzUn3O-HSMF64J7wg@mail.gmail.com>
Subject: Re: NFS & CIFS support dedupe now?? Was: Re: [PATCH] generic/517:
 notrun on NFS due to unaligned dedupe in test
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>, sfrench@samba.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        fengxiaoli0714@gmail.com, fstests@vger.kernel.org,
        Murphy Zhou <xzhou@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 31 May 2019 at 11:25, Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Thu, May 30, 2019 at 12:02 PM Darrick J. Wong
> <darrick.wong@oracle.com> wrote:
> >
> > Hi everyone,
> >
> > Murphy Zhou sent a patch to generic/517 in fstests to fix a dedupe
> > failure he was seeing on NFS:
> >
> > On Thu, May 30, 2019 at 05:41:47PM +0800, Murphy Zhou wrote:
> > > NFSv4.2 could pass _require_scratch_dedupe, since the test offset and
> > > size are aligned, while generic/517 is performing unaligned dedupe.
> > > NFS does not support unaligned dedupe now, returns EINVAL.
> > >
> > > Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> > > ---
> > >  tests/generic/517 | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tests/generic/517 b/tests/generic/517
> > > index 601bb24e..23665782 100755
> > > --- a/tests/generic/517
> > > +++ b/tests/generic/517
> > > @@ -30,6 +30,7 @@ _cleanup()
> > >  _supported_fs generic
> > >  _supported_os Linux
> > >  _require_scratch_dedupe
> > > +$FSTYP == "nfs"  && _notrun "NFS can't handle unaligned deduplication"
> >
> > I was surprised to see a dedupe fix for NFS since (at least to my
> > knowledge) neither of these two network filesystems actually support
> > server-side deduplication commands, and therefore the
> > _require_scratch_dedupe should have _notrun the test.
> >
> > Then I looked at fs/nfs/nfs4file.c:
> >
> > static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
> >                 struct file *dst_file, loff_t dst_off, loff_t count,
> >                 unsigned int remap_flags)
> > {
> >         <local variable declarations>
> >
> >         if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
> >                 return -EINVAL;
> >
> >         <check alignment, lock inodes, flush pending writes>
> >
> >         ret = nfs42_proc_clone(src_file, dst_file, src_off, dst_off, count);
> >
> > The NFS client code will accept REMAP_FILE_DEDUP through remap_flags,
> > which is how dedupe requests are sent to filesystems nowadays.  The nfs
> > client code does not itself compare the file contents, but it does issue
> > a CLONE command to the NFS server.  The end result, AFAICT, is that a
> > user program can write 'A's to file1, 'B's to file2, issue a dedup
> > ioctl to the kernel, and have a block of 'B's mapped into file1.  That's
> > broken behavior, according to the dedup ioctl manpage.
> >
> > Notice how remap_flags is checked but is not included in the
> > nfs42_proc_clone call?  That's how I conclude that the NFS client cannot
> > possibly be sending the dedup request to the server.
> >
> > The same goes for fs/cifs/cifsfs.c:
> >
> > static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
> >                 struct file *dst_file, loff_t destoff, loff_t len,
> >                 unsigned int remap_flags)
> > {
> >         <local variable declarations>
> >
> >         if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
> >                 return -EINVAL;
> >
> >         <check files, lock inodes, flush pages>
> >
> >         if (target_tcon->ses->server->ops->duplicate_extents)
> >                 rc = target_tcon->ses->server->ops->duplicate_extents(xid,
> >                         smb_file_src, smb_file_target, off, len, destoff);
> >         else
> >                 rc = -EOPNOTSUPP;
> >
> > Again, remap_flags is checked here but it has no influence over the
> > ->duplicate_extents call.
> >
> > Next I got to thinking that when I reworked the clone/dedupe code last
> > year, I didn't include REMAP_FILE_DEDUP support for cifs or nfs, because
> > as far as I knew, neither protocol supports a verb for deduplication.
> > The remap_flags checks were modified to allow REMAP_FILE_DEDUP in
> > commits ce96e888fe48e (NFS) and b073a08016a10 (CIFS) with this
> > justification (the cifs commit has a similar message):
> >
> > "Subject: Fix nfs4.2 return -EINVAL when do dedupe operation
> >
> > "dedupe_file_range operations is combiled into remap_file_range.
> > "    But in nfs42_remap_file_range, it's skiped for dedupe operations.
> > "    Before this patch:
> > "      # dd if=/dev/zero of=nfs/file bs=1M count=1
> > "      # xfs_io -c "dedupe nfs/file 4k 64k 4k" nfs/file
> > "      XFS_IOC_FILE_EXTENT_SAME: Invalid argument
> > "    After this patch:
> > "      # dd if=/dev/zero of=nfs/file bs=1M count=1
> > "      # xfs_io -c "dedupe nfs/file 4k 64k 4k" nfs/file
> > "      deduped 4096/4096 bytes at offset 65536
> > "      4 KiB, 1 ops; 0.0046 sec (865.988 KiB/sec and 216.4971 ops/sec)"
> >
> > This sort of looks like monkeypatching to make an error message go away.
> > One could argue that this ought to return EOPNOSUPP instead of EINVAL,
> > and maybe that's what should've happened.
> >
> > So, uh, do NFS and CIFS both support server-side dedupe now, or are
> > these patches just plain wrong?
> >
> > No, they're just wrong, because I can corrupt files like so on NFS:
> >
> > $ rm -rf urk moo
> > $ xfs_io -f -c "pwrite -S 0x58 0 31048" urk
> > wrote 31048/31048 bytes at offset 0
> > 30 KiB, 8 ops; 0.0000 sec (569.417 MiB/sec and 153846.1538 ops/sec)
> > $ xfs_io -f -c "pwrite -S 0x59 0 31048" moo
> > wrote 31048/31048 bytes at offset 0
> > 30 KiB, 8 ops; 0.0001 sec (177.303 MiB/sec and 47904.1916 ops/sec)
> > $ md5sum urk moo
> > 37d3713e5f9c4fe0f8a1f813b27cb284  urk
> > a5b6f953f27aa17e42450ff4674fa2df  moo
> > $ xfs_io -c "dedupe urk 0 0 4096" moo
> > deduped 4096/4096 bytes at offset 0
> > 4 KiB, 1 ops; 0.0012 sec (3.054 MiB/sec and 781.8608 ops/sec)
> > $ md5sum urk moo
> > 37d3713e5f9c4fe0f8a1f813b27cb284  urk
> > 2c992d70131c489da954f1d96d8c456e  moo
> >
> > (Not sure about cifs, since I don't have a Windows Server handy)
> >
> > I'm not an expert in CIFS or NFS, so I'm asking: do either support
> > dedupe or is this a kernel bug?
>
> NFS does not support dedupe and only supports cloning (whole) files.

That is not quite true. It does support range based cloning, and can
even support cloning parts of a file onto itself (as long as the
source and target ranges do not overlap). However it does not support
the kind of conditional cloning that I understand from Darrick is
needed for dedup.

Cheers
  Trond
