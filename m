Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F8D35A050
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 15:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhDINur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhDINuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:50:44 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7B3C061760;
        Fri,  9 Apr 2021 06:50:31 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id t14so4777251ilu.3;
        Fri, 09 Apr 2021 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGJZmmcmbsbv9Z5e9Ce+SCA5Ta6SrwFKxFJMGIFXocM=;
        b=L/fZOICd2FDYOYlJ5+IACiFpQDtt/9nYKkNO2VKDV489WDZI7uMvJABgLX4n2kaGcO
         rG0B4tIgc8fY8mXDyHkIP6/xcnfK/Hr4Qta6mLLIVenLblYrJLS+ol/sJhBmV6gxNUm8
         AQKgRTaoXYzU/AfWvcapXEtNxO7y4rqFs/mnhh38u+E0PNLxoxM2YE2fbEY3/gh/gQjJ
         NIQN13qgaRtgz2xbuLy0GgaZkcSIXALXezLF3zy54G6PmKXNhfV7mqtDcrKY6MaEZIR7
         vEsbU/lSXHEh/ugwb2hpOTJ2TX2LVl515OoNbwwdZz6JWlkQzEoYy3XNYw1QPWtr2QVv
         cPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGJZmmcmbsbv9Z5e9Ce+SCA5Ta6SrwFKxFJMGIFXocM=;
        b=B4/01HJJA26iiZhXZaoyA2wwe8ner5NCR7HhMhOVukn46CMrClHbczq2BJ9rqLxc5R
         oLjgKkmffTG5ZLiFzZtaitoUfB5YA7pnF7Fvq6OFQ847PoD3GnWBT3tE+0P7+VdM4WKx
         FO/28qtN1gD+vuPIv4xrIzM5SyL0yMyuwDoNU+FBFyaghIDd4gZVWf3qW7PbU/Ru+uRK
         S9o84lcmY0qjzdaih/5KuFcSrBLEcXqca6ZC2n4iBuHiqgX0gsHVPNXx+Py+mkmPOqPC
         08RNikc+86uCmntLVEz149yzNUiSF2zm/dTArVEPMwSakd0w5OBFuPfrPi+5F54Yhg7E
         KCgw==
X-Gm-Message-State: AOAM530EaMVYD4rQp6lwV84XQoq/dfsrYVqnsohwZT3GXhgGLGsIHdFB
        EnZgy3Okle9lPeoeIDyVjuuO4c5PN1bjT5NdP4k=
X-Google-Smtp-Source: ABdhPJz2017Mp18Bm1uXNEsYU5jWFsdiPDGjYR8JPCOFQBk6CUIieYzbSBDb8lxl7shrh2bRGvzKOfREcH+f6Cbse0U=
X-Received: by 2002:a92:cd0d:: with SMTP id z13mr12023431iln.250.1617976230737;
 Fri, 09 Apr 2021 06:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210221195833.23828-1-lhenriques@suse.de> <20210222102456.6692-1-lhenriques@suse.de>
 <CAN-5tyELMY7b7CKO-+an47ydq8r_4+SOyhuvdH0qE0-JmdZ44Q@mail.gmail.com>
 <YDYpHccgM7agpdTQ@suse.de> <CANMq1KBgwEXFh8AxpPW2t1SA0NVsyR45m0paLEU4D4w80dc_fA@mail.gmail.com>
 <CANMq1KDTgnGtNxWj2XxAT3mdsNjc551uUCg6EWnh=Hd0KcVQKQ@mail.gmail.com> <8735vzfugn.fsf@suse.de>
In-Reply-To: <8735vzfugn.fsf@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Apr 2021 16:50:19 +0300
Message-ID: <CAOQ4uxjdVZywBi6=D1eRfBhRk+nobTz4N87jcejDtvzBMMMKXQ@mail.gmail.com>
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 9, 2021 at 4:39 PM Luis Henriques <lhenriques@suse.de> wrote:
>
> Nicolas Boichat <drinkcat@chromium.org> writes:
>
> > On Wed, Feb 24, 2021 at 6:44 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> >>
> >> On Wed, Feb 24, 2021 at 6:22 PM Luis Henriques <lhenriques@suse.de> wrote:
> >> >
> >> > On Tue, Feb 23, 2021 at 08:00:54PM -0500, Olga Kornievskaia wrote:
> >> > > On Mon, Feb 22, 2021 at 5:25 AM Luis Henriques <lhenriques@suse.de> wrote:
> >> > > >
> >> > > > A regression has been reported by Nicolas Boichat, found while using the
> >> > > > copy_file_range syscall to copy a tracefs file.  Before commit
> >> > > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> >> > > > kernel would return -EXDEV to userspace when trying to copy a file across
> >> > > > different filesystems.  After this commit, the syscall doesn't fail anymore
> >> > > > and instead returns zero (zero bytes copied), as this file's content is
> >> > > > generated on-the-fly and thus reports a size of zero.
> >> > > >
> >> > > > This patch restores some cross-filesystem copy restrictions that existed
> >> > > > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> >> > > > devices").  Filesystems are still allowed to fall-back to the VFS
> >> > > > generic_copy_file_range() implementation, but that has now to be done
> >> > > > explicitly.
> >> > > >
> >> > > > nfsd is also modified to fall-back into generic_copy_file_range() in case
> >> > > > vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
> >> > > >
> >> > > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> >> > > > Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> >> > > > Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> >> > > > Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> >> > > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> >> > > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> >> > >
> >> > > I tested v8 and I believe it works for NFS.
> >> >
> >> > Thanks a lot for the testing.  And to everyone else for reviews,
> >> > feedback,... and patience.
> >>
> >> Thanks so much to you!!!
> >>
> >> Works here, you can add my
> >> Tested-by: Nicolas Boichat <drinkcat@chromium.org>
> >
> > What happened to this patch? It does not seem to have been picked up
> > yet? Any reason why?
>
> Hmm... good question.  I'm not actually sure who would be picking it.  Al,
> maybe...?
>

Darrick,

Would you mind taking this through your tree in case Al doesn't pick it up?

Thanks,
Amir.
