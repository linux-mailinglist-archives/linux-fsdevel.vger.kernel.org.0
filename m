Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB12722C1FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 11:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGXJUr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 05:20:47 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52941 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgGXJUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:20:46 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N3sNa-1kyONw1BNg-00zofz; Fri, 24 Jul 2020 11:20:44 +0200
Received: by mail-qk1-f176.google.com with SMTP id e13so8027966qkg.5;
        Fri, 24 Jul 2020 02:20:43 -0700 (PDT)
X-Gm-Message-State: AOAM533Xbv7VPZv6K9FbSXZLNfp32yJDDIOK2u+6hbGcPWpfxugglv6B
        bK8L0K5uL3IjUl/muzddjKdAZiwuadn3aodyC6w=
X-Google-Smtp-Source: ABdhPJwABW1YhCHM+rzhS9ETGodCvKpQaJKjnVRjhdVgBMUZcgbq2AhEaUluWQdEhha+o+dVmLq0Az5h4pnXqSPsV/o=
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr9525639qko.138.1595582443026;
 Fri, 24 Jul 2020 02:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200724001248.GC25522@altlinux.org>
In-Reply-To: <20200724001248.GC25522@altlinux.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 Jul 2020 11:20:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0JM8dytW6C8P9HoPcGksg0d5JCut1yT7JzBcUCAm-WcQ@mail.gmail.com>
Message-ID: <CAK8P3a0JM8dytW6C8P9HoPcGksg0d5JCut1yT7JzBcUCAm-WcQ@mail.gmail.com>
Subject: Re: [PATCH] fs/nsfs.c: fix ioctl support of compat processes
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?B?w4Frb3MgVXpvbnlp?= <uzonyi.akos@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:T2/vIztnhZynRsOcAXoIISvlgJgffTQCDi4EdAH6mVPwIrPBg5v
 ndVMcJ0U3z6aHd7rDquf37P43BoS9nUhNT3EbVNf8NIaAuUDOL71H8gPS5EVo0OrXiEnJVA
 bz6jY0Fnl/xzV2XYwLo28gx3w3OF/e4mP+crUmOk887ak21eK63POZ86EfCYN2aGDe4fWCU
 jp7tYZDSm/6qL4QAicQlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u15t9tA4sZE=:3QJhBrC99WeXoTxX7bhp6P
 qmZ66Qp7GzD2AcfugQCGSs+HkTPetVFGgLmTzS3D6Jv+lYgDVGb3bAZRDUtUM3aecyk6nD55l
 ZLJTD3M34O7yx2IQZt1A7IIm4LXJMEDJvWFMc4U1fI4se66X6yXdoHWiFuYCv6q7zZHzHNfEq
 jmXgSFrRf4Gf99ou+/OfWOewVzcOMD2ym6nQ76nwgODpBnjKLaQHTzlIFlZhsmItalJyjF/ZZ
 gVyLKTTrENHP38p8spf9fYj9BR4PrDE14Kyc9geeiXp3Rqvt43HJJhSmu5RAxYCU7sUpSibpo
 3VmyZ0WCLuN3ljugSU3NFPeTjsN/3+LP6y2+5yGf/lM2C8FxSY74s1b1S1fSLgH6e4kuLVDbr
 rLV5YScRa42YiOjZbII0R014RFkaJ3deVb+U3WYggCuneM8HwXOLk2UYCHpCVkIBGc/Y4Zhl2
 iML0k1O3uXIDwrHL83IWKevneyr7icDDhmYVfIXvTcYXy3aAYM9TKPDlrFRTx6unTn1mrb2E/
 0tNSyvfpHl1eDSeB8aTBb/XYmcBv14bthqT+NSHwyU4rJCO/Qrf3hilCTw4sWS8MbYyibDN//
 dbwucpHbO3ZeiWJ8cyLjXXZmgrKvxn8J19hcJ0RSSKUHYsfx93slBnZeMsxT2pALaOOkm1x7P
 Yw1ryhY2saAHNstYigRt3tbOlIgNQg52JyuP9SFjJbRaYHLD1gpLB5eJLxy83iER1nrJxBDqv
 jtzcy7R9Cox0030bPs7cFGOK7tYHWRNnZNMw95Tt0wpuOXrg0zp1DQFTCJZg9AJ6xouHRzaVI
 YvScS21dezXfV8ZJcO+bfWV0jyKJVYYG3l0YNDpJGcFqTN1WYQ8+RAFkDMeeSYbAImJlbif
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 2:12 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> According to Documentation/driver-api/ioctl.rst, in order to support
> 32-bit user space running on a 64-bit kernel, each subsystem or driver
> that implements an ioctl callback handler must also implement the
> corresponding compat_ioctl handler.  The compat_ptr_ioctl() helper can
> be used in place of a custom compat_ioctl file operation for drivers
> that only take arguments that are pointers to compatible data
> structures.
>
> In case of NS_* ioctls only NS_GET_OWNER_UID accepts an argument, and
> this argument is a pointer to uid_t type, which is universally defined
> to __kernel_uid32_t.

This is potentially dangerous to rely on, as there are two parts that
are mismatched:

- user space does not see the kernel's uid_t definition, but has its own,
  which may be either the 16-bit or the 32-bit type. 32-bit uid_t was
  introduced with linux-2.3.39 in back in 2000. glibc was already
  using 32-bit uid_t at the time in user space, but uclibc only changed
  in 2003, and others may have been even later.

- the ioctl command number is defined (incorrectly) as if there was no
  argument, so if there is any user space that happens to be built with
  a 16-bit uid_t, this does not get caught.

       Arnd

> Reported-by: Ákos Uzonyi <uzonyi.akos@gmail.com>
> Fixes: 6786741dbf99 ("nsfs: add ioctl to get an owning user namespace for ns file descriptor")
> Cc: stable@vger.kernel.org # v4.9+
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  fs/nsfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 800c1d0eb0d0..a00236bffa2c 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -21,6 +21,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  static const struct file_operations ns_file_operations = {
>         .llseek         = no_llseek,
>         .unlocked_ioctl = ns_ioctl,
> +       .compat_ioctl   = compat_ptr_ioctl,
>  };
>
>  static char *ns_dname(struct dentry *dentry, char *buffer, int buflen)
