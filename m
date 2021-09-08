Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63820403980
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 14:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351661AbhIHMJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 08:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234758AbhIHMJV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:09:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B86D96109F;
        Wed,  8 Sep 2021 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631102893;
        bh=+2qr6IIO/UXLiJjbyRAgzuQXiygiL06LUjfWuxvrq7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcs7nucfDWnXMYxo5ee/D0ZZAPqmOq3Gvtv+E0miyvRG+OwrIE8sOqA4FK3hT4+wi
         atyLzSEjCkXrJl+bnpyYiVY1FZkXaUHxOKCkF/CqzLfbFz3j2oqiUMCBU5lTdOrIFa
         OxQTgGQ4h74+Oz78PjpHrzODtGnMgkj+tyADOD5M=
Date:   Wed, 8 Sep 2021 14:08:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sami Tolvanen <samitolvanen@google.com>, snitzer@redhat.com,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        open list <linux-kernel@vger.kernel.org>, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>, agk@redhat.com
Subject: Re: Kernel 4.14: Using dm-verity with squashfs rootfs - mounting
 issue
Message-ID: <YTinqiH9h+Q9bYsr@kroah.com>
References: <CAOuPNLhh_LkLQ8mSA4eoUDLCLzHo5zHXsiQZXUB_-T_F1_v6-g@mail.gmail.com>
 <alpine.LRH.2.02.2107211300520.10897@file01.intranet.prod.int.rdu2.redhat.com>
 <CAOuPNLi-xz_4P+v45CHLx00ztbSwU3_maf4tuuyso5RHyeOytg@mail.gmail.com>
 <CAOuPNLg0m-Q7Vhp4srbQrjXHsxVhOr-K2dvnNqzdR6Dr4kioqA@mail.gmail.com>
 <20210830185541.715f6a39@windsurf>
 <CAOuPNLhTidgLNWUbtUgdESYcKcE1C4SOdzKeQVhFGQvEoc0QEg@mail.gmail.com>
 <20210830211224.76391708@windsurf>
 <CAOuPNLgMd0AThhmSknbmKqp3_P8PFhBGr-jW0Mqjb6K6NchEMg@mail.gmail.com>
 <CAOuPNLiW10-E6F_Ndte7U9NPBKa9Y_UuLhgdwAYTc0eYMk5Mqg@mail.gmail.com>
 <CAOuPNLj2Xmx52Gtzx5oEKif4Qz-Tz=vaxhRvHQG-5emO7ewRhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLj2Xmx52Gtzx5oEKif4Qz-Tz=vaxhRvHQG-5emO7ewRhg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 08, 2021 at 04:57:45PM +0530, Pintu Agarwal wrote:
> Hi,
> 
> On Mon, 6 Sept 2021 at 21:58, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> 
> > On Tue, 31 Aug 2021 at 18:49, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > > > No, but you can backport it easily. Back at
> > > > http://lists.infradead.org/pipermail/openwrt-devel/2019-November/025967.html
> > > > I provided backports of this feature to OpenWrt, for the 4.14 and 4.19
> > > > kernels.
> 
> Can you please let me know where to get the below patches for
> backporting to our kernel:
>  create mode 100644
> target/linux/generic/backport-4.14/390-dm-add-support-to-directly-boot-to-a-mapped-device.patch
>  create mode 100644
> target/linux/generic/backport-4.14/391-dm-init-fix-max-devices-targets-checks.patch
>  create mode 100644
> target/linux/generic/backport-4.14/392-dm-ioctl-fix-hang-in-early-create-error-condition.patch
>  create mode 100644
> target/linux/generic/backport-4.14/393-Documentation-dm-init-fix-multi-device-example.patch

If you are stuck on an older kernel version, then you need to get
support from the vendor that is forcing you to be on that kernel
version, as you are already paying them for support.  Please take
advantage of that, as no one knows what is really in "your kernel".

thanks,

greg k-h
