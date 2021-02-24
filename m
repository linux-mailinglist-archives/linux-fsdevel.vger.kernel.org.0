Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5D13241E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 17:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhBXQOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 11:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbhBXQLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:11:44 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598BBC061574;
        Wed, 24 Feb 2021 08:10:57 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id o1so2151788ila.11;
        Wed, 24 Feb 2021 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZrSVmIV6Jr6Xzq9w2halpbi749GnRBmns1YcidehFs=;
        b=r3dq2T5c+ijM7x/v5M2Ih6l9XYck+ODuIBBH/x/tc8VLT4NzFTAhL9D3TZ6jTzrJJq
         eugIbm+8R7AQp92iu2jisPEHOPF5prsHO22C4RidgNthdTrWu/ceOAHHfszPHMnCKcxv
         Gv4BbuarQ7HbOtkmu9tGicT/SldHKpXN6lmjQ4Uaq42vd1xz8ZJdRBNV/EK9uAsj4s7T
         k5rFhA5yK01XI5R3OMU9bbvNTJbOQ4LF1diQEiX9JocNwiTOIVOxicHR4IxcNhDAhuth
         pLD+WsER2zvUqw2fDq1pdI5bmVsw8frmULC55LYgieenK2nSB4qGm+3vGfRwLQ3SxKxY
         oNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZrSVmIV6Jr6Xzq9w2halpbi749GnRBmns1YcidehFs=;
        b=L7fWw1b68DCWXB2RbxPGCKPVoZuTAhKKIesaBuOngy0jBh9mQTV5x7e0hcQCYJ5Mmp
         jOkzIMJcMTFTvN3OycaI0PHNpwZfRkAzMFxoUfVsW5Ak8u7LOTa9q2t371bT5p6eaW/a
         ntVNA7xLp0jZFks2dFxixmvYdk9mS4ZrVm/n6jENh0hQJRXQ1LdMSGjmUtwUl8E4XTin
         BhBBOa907hNM7xiu8eLngPoFGkrIzNL8QcdBhUEqe8l31Vgij9AkKz1KfmPItsSgX1eU
         wPU2WR1cltAfDEBbdjKqa138TUVhiFg3XF1bZxNPxkfQ36Xi/+ylFnv8GSBYLwSdURtr
         2Nig==
X-Gm-Message-State: AOAM530qFcoBT/OcVOA6cyg/9XT8K1f3pZ0qMQpzdLjb0mJu06UUsEdE
        FL2RX8Z35mDs81EVz+23Go1izGiJSgUkuwcJ3lI=
X-Google-Smtp-Source: ABdhPJz4biK9u+kKEn+Yhj/dHN3DjRGLVsZYeMNfF4JnDvxaL1ZCEPjGW6kxF+q3wWlmBl3wBcd+uAy5Oim6wcaso64=
X-Received: by 2002:a92:2c08:: with SMTP id t8mr24098439ile.72.1614183056681;
 Wed, 24 Feb 2021 08:10:56 -0800 (PST)
MIME-Version: 1.0
References: <20210222102456.6692-1-lhenriques@suse.de> <20210224142307.7284-1-lhenriques@suse.de>
In-Reply-To: <20210224142307.7284-1-lhenriques@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Feb 2021 18:10:45 +0200
Message-ID: <CAOQ4uxi3-+tOgHV_GUnWtJoQXbV5ZS9qDZsLsd9sJxX5Aftyew@mail.gmail.com>
Subject: Re: [PATCH] copy_file_range.2: Kernel v5.12 updates
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
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
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 4:22 PM Luis Henriques <lhenriques@suse.de> wrote:
>
> Update man-page with recent changes to this syscall.
>
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> Hi!
>
> Here's a suggestion for fixing the manpage for copy_file_range().  Note that
> I've assumed the fix will hit 5.12.
>
>  man2/copy_file_range.2 | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
> index 611a39b8026b..b0fd85e2631e 100644
> --- a/man2/copy_file_range.2
> +++ b/man2/copy_file_range.2
> @@ -169,6 +169,9 @@ Out of memory.
>  .B ENOSPC
>  There is not enough space on the target filesystem to complete the copy.
>  .TP
> +.B EOPNOTSUPP
> +The filesystem does not support this operation.
> +.TP
>  .B EOVERFLOW
>  The requested source or destination range is too large to represent in the
>  specified data types.
> @@ -187,7 +190,7 @@ refers to an active swap file.
>  .B EXDEV
>  The files referred to by
>  .IR fd_in " and " fd_out
> -are not on the same mounted filesystem (pre Linux 5.3).
> +are not on the same mounted filesystem (pre Linux 5.3 and post Linux 5.12).

I think you need to drop the (Linux range) altogether.
What's missing here is the NFS cross server copy use case.
Maybe:

...are not on the same mounted filesystem and the source and target filesystems
do not support cross-filesystem copy.

You may refer the reader to VERSIONS section where it will say which
filesystems support cross-fs copy as of kernel version XXX (i.e. cifs and nfs).

>  .SH VERSIONS
>  The
>  .BR copy_file_range ()
> @@ -202,6 +205,11 @@ Applications should target the behaviour and requirements of 5.3 kernels.
>  .PP
>  First support for cross-filesystem copies was introduced in Linux 5.3.
>  Older kernels will return -EXDEV when cross-filesystem copies are attempted.
> +.PP
> +After Linux 5.12, support for copies between different filesystems was dropped.
> +However, individual filesystems may still provide
> +.BR copy_file_range ()
> +implementations that allow copies across different devices.

Again, this is not likely to stay uptodate for very long.
The stable kernels are expected to apply your patch (because it fixes
a regression)
so this should be phrased differently.
If it were me, I would provide all the details of the situation to
Michael and ask him
to write the best description for this section.

Thanks,
Amir.
