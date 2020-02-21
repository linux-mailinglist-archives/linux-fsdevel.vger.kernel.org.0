Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52B37167678
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 09:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbgBUIfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 03:35:14 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:57359 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgBUIfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:35:13 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mbzdn-1ja00W1B5r-00dSWR; Fri, 21 Feb 2020 09:35:11 +0100
Received: by mail-qt1-f174.google.com with SMTP id d9so707892qte.12;
        Fri, 21 Feb 2020 00:35:10 -0800 (PST)
X-Gm-Message-State: APjAAAXTd9Yo3qP11M/nKjS1oclRFXGQK78xdiuVvehz0Bo4Sf1yDBRR
        kmGtcWFBJ46Pu/ZGhnxTz+ATQpXD3hLnj1bABS4=
X-Google-Smtp-Source: APXvYqzMtKpji2kHcAwVfJDYkwxyhgoIO+eLhAK993sRWmxCI9kRi7QXQGVX8kksKrQac1lTZAK5TBBxLKggVruJ36Y=
X-Received: by 2002:ac8:1977:: with SMTP id g52mr29831842qtk.18.1582274109872;
 Fri, 21 Feb 2020 00:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-6-scott.branden@broadcom.com> <20200220075045.GB3261162@kroah.com>
 <030219dc-539a-a2db-5ab2-1de7336a811c@broadcom.com>
In-Reply-To: <030219dc-539a-a2db-5ab2-1de7336a811c@broadcom.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Feb 2020 09:34:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1v7S4Ma67vRyfSY=v9z9bt9ZrftOYhgYvsECWXykGTJg@mail.gmail.com>
Message-ID: <CAK8P3a1v7S4Ma67vRyfSY=v9z9bt9ZrftOYhgYvsECWXykGTJg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] bcm-vk: add bcm_vk UAPI
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:uKsCb7o+WwoRn2H66DIerL3UeOyZ5PMu17VhbxdEL4me0biPjB6
 o7WZmnQ0rrYrtZccp+dGHRstPYT/AL1SEm/3IYCsEAqVHCgMbQ4ksER5Jxxky8Jnoh51X2G
 /JnrA6gQfGsmJj8e1K4e9enaF7zgs4g/BCYaMmvJ3m+rCoMGhz2lndHIOExjZ86K2oepGhd
 JtCJNVmjLyn1iCoVpAc5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vx6+2EQVCCk=:3nyhniYPMKUTdjUW1WlS1X
 dizBB8ISTpfxLCiIjgNUDM13W0KZ67gyO2bh1Md9wdY/kVxGvwYn5gX55onS553yW1D/SV+Ic
 chWqDqJSktTofpps+FghQQa1v46eU7cKssNfN8Yc5x0PxCWaq+Dn/qfZO9DsbuQ8gyxIGaYZX
 vGVVHjT0SaIwbZR8VtUba1pNnpuJshQeY6oNsIEsbUL2lRa2xJZnzvD88GlgA5zM5Om437HEy
 gOaK0KA9PdAzgJOOWU90JqA1J6yt4lf74KKOKl1vCuAK94O3hnFO4F3R5G4SACx4G7udFL8ex
 GA7RPATiwpR4N1jVm2OiTuYBtfHBhc5GTADdJ5FvuoPhcku9U/0rb7kUh22ttL6NtwCWXZuAk
 tXw1kO4kCzWlqYg+iiTw8R4YCq46iHwDp/DUZk5OALtRfeEhaLhzi3F/xL8N1/gxCXoWTKA6g
 6PpoBgcNI7fvKOcpty/X070DM/shiGQidrOO7rshPTPihkdG3cZS0zqwqq8mR96G2CYmYGPw6
 i9vo7npjwiZczbygEsU+NPQc5JqzPcfnJ6Eagw8FfOhKBlLUUIof6oR45sX8I6NHqevSwKJCd
 4zcIVZ72l9Rq3yCMGY2sF0QJ/od3s04YZePgn/NksbpSbt1QLDCMweHqD6LI1q543KzCsvfp9
 bOpMBR7BXHdKcJ2lgZYXS5IiWXGGv6LiBx0GbTliLojyx0it0vRXHgAagHJx/HKaHdXGB/XJS
 NCA/yU0Pz+mb4mur480nqWi9BBWKph6RjCG4AG3QPdqHVluVN0h5FBMeycbQlbjO2/APQUko5
 6umjBaVTqYwERcD6UZfHWF1CEOUkqNWlmw+YmOH0ZTKghgBdMU=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 2:16 AM Scott Branden
<scott.branden@broadcom.com> wrote:


> >> +struct vk_access {
> >> +    __u8 barno;     /* BAR number to use */
> >> +    __u8 type;      /* Type of access */
> >> +#define VK_ACCESS_READ 0
> >> +#define VK_ACCESS_WRITE 1
> >> +    __u32 len;      /* length of data */
> > Horrible padding issues, are you sure this all works properly?
> Haven't had any issues.
> >
> >> +    __u64 offset;   /* offset in BAR */
> >> +    __u32 *data;    /* where to read/write data to */
> > Are you _SURE_ you want a pointer here?  How do you handle the compat
> > issues with 32/64 user/kernel space?
> Don't care about 32-bit user space for this driver.
> I don't think there isn't even enough memory in such systems for the
> number of streams of video buffers needed for transcoding.
> This driver is only used in high end 64-bit x86 servers.

Please see Documentation/core-api/ioctl.rst

All ioctl interfaces should be written in a portable way that works with
compat user space and avoids all padding in order to not leak kernel
data into user space.

If the driver is passing video buffers for transcoding, shouldn't the driver
use the existing drivers/media interfaces for that? If it needs features
that are not present there, they can probably be added.

        Arnd
