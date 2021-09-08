Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E284038BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 13:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351482AbhIHL3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 07:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351478AbhIHL3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:29:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B7EC061575;
        Wed,  8 Sep 2021 04:27:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s25so2475423edw.0;
        Wed, 08 Sep 2021 04:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T8Mklz6VAwUy6oZgIvPmDqGWckAlnrdzULeYme94/4Q=;
        b=lkZxAaIGGHzgZlPLjUj8F2g/w4kqVFboovx1cwljnc6aG9d+053WJpn5h7J1mOG/hL
         dtsv95/oTcFq5WD049sZPSukw1181KcSYaBAbljNxQb0icgMraGga+TTsOtvgzlY6SKB
         OqGjH6T8o07JALS2uJBbJkrbW+ZKzfDIe5Kt2IaBwqPBoqAWuSmuoBOFEMzTmApUTnHh
         hDkAuI+bIdj1fv7990JlGAOKAEWSN0mMF9rrEDnxPEiNnt5GNaceLh5Yy10Y7Q/oBoVZ
         65jq4NpT9cyxvBnxLqRJfMoGjB/yuiQHP+Ei9zSrxWiLIf/dBBRNvhz3feewJTCCGxrH
         F7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8Mklz6VAwUy6oZgIvPmDqGWckAlnrdzULeYme94/4Q=;
        b=I3r3BT5r5ZCMycP7IK9c17nUI+3f8kYFNyc7DrQtfJN91NZ5fVXSCPWUayTgDgVZdW
         8DKGEcw5RGc7m6AZafSyaxxFlxXOnNnxxfDKSPgG4akOKNPgECOOY7qUpBLjBQBQeIUG
         p68ojgVjleKvj5x/mmmCip1p/DPoILmZuZDFiaixRQ8sdLpOrLOVZ2BIUhx+aOcc+QI9
         FhggFjfw+o+/l2f90UgAl4vZHB0zurEglv90JSgG7TWz/mmvAosPoLd2jlOZy/y0zzID
         St8wQ3nN7HCHaTsE/4KlKi30NR4TDe7sPiQxS04NEwBDd9hygVQQGckfiv84WbO9aANv
         dFlw==
X-Gm-Message-State: AOAM531op85Tq7sK6KVx0g3+Khu2cwfxBmzRm6xpVnoWzTroIEUUyema
        5ACUn7QN1ytHf86Ij7d2QS2Op2Jl2k9KGU72BEw=
X-Google-Smtp-Source: ABdhPJwGfD+i+VdCkJZ7IUmEUFHZnxm9TsQnDXHp+8EbX5wzCKF44hHkvqZBfYGx8AevvBsZcCM3G11fKO55WACtnZo=
X-Received: by 2002:a05:6402:4389:: with SMTP id o9mr3325324edc.306.1631100477257;
 Wed, 08 Sep 2021 04:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLhqSpaTm3u4kFsnuZ0PLDKuX8wsxuF=vUJ1TEG0EP+L1g@mail.gmail.com>
 <alpine.LRH.2.02.2107200737510.19984@file01.intranet.prod.int.rdu2.redhat.com>
 <CAOuPNLhh_LkLQ8mSA4eoUDLCLzHo5zHXsiQZXUB_-T_F1_v6-g@mail.gmail.com>
 <alpine.LRH.2.02.2107211300520.10897@file01.intranet.prod.int.rdu2.redhat.com>
 <CAOuPNLi-xz_4P+v45CHLx00ztbSwU3_maf4tuuyso5RHyeOytg@mail.gmail.com>
 <CAOuPNLg0m-Q7Vhp4srbQrjXHsxVhOr-K2dvnNqzdR6Dr4kioqA@mail.gmail.com>
 <20210830185541.715f6a39@windsurf> <CAOuPNLhTidgLNWUbtUgdESYcKcE1C4SOdzKeQVhFGQvEoc0QEg@mail.gmail.com>
 <20210830211224.76391708@windsurf> <CAOuPNLgMd0AThhmSknbmKqp3_P8PFhBGr-jW0Mqjb6K6NchEMg@mail.gmail.com>
 <CAOuPNLiW10-E6F_Ndte7U9NPBKa9Y_UuLhgdwAYTc0eYMk5Mqg@mail.gmail.com>
In-Reply-To: <CAOuPNLiW10-E6F_Ndte7U9NPBKa9Y_UuLhgdwAYTc0eYMk5Mqg@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 8 Sep 2021 16:57:45 +0530
Message-ID: <CAOuPNLj2Xmx52Gtzx5oEKif4Qz-Tz=vaxhRvHQG-5emO7ewRhg@mail.gmail.com>
Subject: Re: Kernel 4.14: Using dm-verity with squashfs rootfs - mounting issue
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>, dm-devel@redhat.com,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>, agk@redhat.com,
        snitzer@redhat.com, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Mon, 6 Sept 2021 at 21:58, Pintu Agarwal <pintu.ping@gmail.com> wrote:

> On Tue, 31 Aug 2021 at 18:49, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> > > No, but you can backport it easily. Back at
> > > http://lists.infradead.org/pipermail/openwrt-devel/2019-November/025967.html
> > > I provided backports of this feature to OpenWrt, for the 4.14 and 4.19
> > > kernels.

Can you please let me know where to get the below patches for
backporting to our kernel:
 create mode 100644
target/linux/generic/backport-4.14/390-dm-add-support-to-directly-boot-to-a-mapped-device.patch
 create mode 100644
target/linux/generic/backport-4.14/391-dm-init-fix-max-devices-targets-checks.patch
 create mode 100644
target/linux/generic/backport-4.14/392-dm-ioctl-fix-hang-in-early-create-error-condition.patch
 create mode 100644
target/linux/generic/backport-4.14/393-Documentation-dm-init-fix-multi-device-example.patch
