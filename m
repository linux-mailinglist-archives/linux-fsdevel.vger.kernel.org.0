Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4D189D1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 14:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCRNg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 09:36:57 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:35565 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgCRNg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:36:57 -0400
Received: by mail-il1-f177.google.com with SMTP id v6so12454945ilq.2;
        Wed, 18 Mar 2020 06:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOa1wjQr90ahh8o3G0Q0d26hwJPvvcel6LlNVGh6TME=;
        b=Jww7hBgQbvYQdK3vSQORjjpmOQ4mf8FX6Y1Gucj+mc36olb3q5cGyrWrC79lHFWbG4
         Qhsl0jFhdcoNjE7GyR5R9fJZtsytDDQW5PDVPQWSp4k/Dmvcnv3HYEffjw+rrdEemUnt
         pt45SyPfi8aAnn9lJjxUWFNXHDsC6dWpLu+5dDDsbaNu9p7fBTglZujuuVpSihDT8ncp
         /5T7tADvIzqVhG9tfHxocta8JTvKp9tNrCWR+BuTXE6DI4jW3LqQQos4wNKHnLHDQMOk
         9uiAo6LOOyMctKoyX+iqCLggzBFbaDQgUzRTblzDHXFHfBRWbPRfhavGZS0z7eIAqseK
         MkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOa1wjQr90ahh8o3G0Q0d26hwJPvvcel6LlNVGh6TME=;
        b=KZUZHE3SkCutA3lvxyxbe5KkpvLpJeQdhnxB6Z0PG2vJqhGYr3yIDd4AysLVRYe3Fd
         Cb6SrGzHtaH4FkWI8E+Gs8/pSRNrrxDJVUhZcJGqz04m3fX85jnjzCk8s4DMEGMG6Beu
         xN1pYxjdhNONWpfh0EY23yjZmn7rA0zS86IT5Nka2bl9bcPn8pD0mrNqCIrWTC+t8cM7
         E7Wyjblkn5lQeL/hwj4PT+n6XaHL3RTCTPTvWljtH1GiK2EQyYLk5ADIa0e9LhCsJlNe
         TyERkm2W8St5+CnlXZKiaWxi1mPpPqCtcUh0pd9IRa3YgonvgSWPyZjHQ1F9mPSAZJxH
         MdRg==
X-Gm-Message-State: ANhLgQ2/Jy7iU54avfET+NsgeqPr4M3DyzuvV8joWSnbq/DRRylNao+x
        WtcoprnMjO9MNnGcPjY6Zgr8t0tTYmXImwB0Ex8=
X-Google-Smtp-Source: ADFU+vuSm/R9YPj8QRZNx1Vx4lqoj5FR3PJp2aZFIxvLESq6TfsNiHARXSiUvP29xgOIjdBwfwMB5bRWCbD133ZsBq0=
X-Received: by 2002:a92:5b51:: with SMTP id p78mr3955852ilb.250.1584538616142;
 Wed, 18 Mar 2020 06:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-5-mszeredi@redhat.com>
 <20200204145951.GC11631@redhat.com> <CAJfpegtq4A-m9vOPwUftiotC_Xv6w-dnhCi9=E0t-b1ZPJXPGw@mail.gmail.com>
 <CAOQ4uxj_pVp9-EN2Gmq9j6G3xozzpK_zQiRO-brx6PZ9VpgD0Q@mail.gmail.com>
 <CAOQ4uxjFYO28r+0pY+pKxK-dDJcQF2nf2EivnOUBgrgkYTFjPQ@mail.gmail.com>
 <CAOQ4uxhZ8a2ObfB9sUtrc=95mM70qurLtXkaNyHOXYxGEKvxFw@mail.gmail.com>
 <CAOQ4uxhkd5FkN5ynpQxQ0m1MR9MgzTBbvzjkoHfSRA2umb-JTA@mail.gmail.com>
 <20200316175453.GB4013@redhat.com> <CAOQ4uxgfTJwE2O1GGt-TY+6ijjKE13+ATTarijFGLiM69jk8HA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgfTJwE2O1GGt-TY+6ijjKE13+ATTarijFGLiM69jk8HA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 18 Mar 2020 15:36:44 +0200
Message-ID: <CAOQ4uxhWLjsxy21MMKUOvMsWmWTWhKP0hwLQoD99xVcWbbmFmA@mail.gmail.com>
Subject: Re: unionmount testsuite with upper virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I also wanted to run either overlay xfstests or unionmount-testsuite. But
> > none of these seem to give me enough flexibility where I can specify
> > that overlayfs needs to be mounted on top of virtiofs.
> >
> > I feel that atleast for unionmount-testsuite, there should be an
> > option where we can simply give a target directory and tests run
> > on that directory and user mounts that directory as needed.
> >
>
> Need to see how patches look.
> Don't want too much configuration complexity, but I agree that some
> flexibly is needed.
> Maybe the provided target directory should be the upper/work basedir?
>

Vivek,

I was going to see what's the best way to add the needed flexibility,
but then I realized I had already implemented this undocumented
feature.

I have been using this to test overlay over XFS as documented here:
https://github.com/amir73il/overlayfs/wiki/Overlayfs-testing#Setup_overlayfs_mount_over_XFS_with_reflink_support

That's an example of how to configure a custom /base mount for
--samefs to be xfs.
Similar hidden feature exists for configuring a custom /lower and
/upper mounts via fstab, but I don't think I ever tested those, so not
sure if they work as expected. unionmount testsuite will first try to
mount the entry from fstab and fallback to mounting tmpfs.

I admit this a lousy configuration method, but we could make it
official using env vars or something. I also never liked the fact
that unionmount testsuite hard codes the /lower /upper /mnt paths.

The reason we 'need' the instructions how to mount the fs as opposed
to an already mounted dir is that unmounting the underlying fs exposes
dentry/inode reference leaks by overlayfs.
But it is nice to have and xfstests has support for configuring an already
mounted overlayfs for the generic tests.

So if you think that you cannot use the existing hack and that pointing
to an already mounted /upper or mounted overlay is needed, I suggest
that you experiment with patches to make that change.

Thanks,
Amir.
