Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC944125C5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 09:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLSID3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 03:03:29 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:53755 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfLSID3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:03:29 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M6lUk-1ibnpx1XRO-008KmM; Thu, 19 Dec 2019 09:03:27 +0100
Received: by mail-qk1-f174.google.com with SMTP id z14so2675913qkg.9;
        Thu, 19 Dec 2019 00:03:26 -0800 (PST)
X-Gm-Message-State: APjAAAV49yOs3eUl8ZUzbvhQ7rduRPS6YNXnz/QjcYdF2zy63nd1XpP1
        sUFjPcjrlMZnKPJLYtcRYp+y0fmax9CmfWLSdjQ=
X-Google-Smtp-Source: APXvYqxXQF6sR2skniit5JgCT5kH+gYfBPMf8t/20i/mEzMIIkYTsPQO26NNE6VO7z/gvWUC1MyADsYJWrkMuIMYl9A=
X-Received: by 2002:a37:a8d4:: with SMTP id r203mr6933223qke.394.1576742606043;
 Thu, 19 Dec 2019 00:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal>
In-Reply-To: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Dec 2019 09:03:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2eT=bHkUamyp-P3Y2adNq1KBk7UknCYBY5_aR4zJmYaQ@mail.gmail.com>
Message-ID: <CAK8P3a2eT=bHkUamyp-P3Y2adNq1KBk7UknCYBY5_aR4zJmYaQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>, gpascutto@mozilla.com,
        ealvarez@mozilla.com, Florian Weimer <fweimer@redhat.com>,
        jld@mozilla.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IiokMjtel7Ht/qXKLtr7vWPyiJm5ObDabfNBLD0croeK4+f9DuZ
 R4eTY4HQL06tF0ng7Ld5H++ri/uZgzWaJ+EmX5gMrtOQAjul7+vqHo0mIj1uuk/OYHV0LBh
 +7qV0XseDO18FgfrNaWZXF43LUBacU3SUqB3SfBKzpjQMNIOlg6flwUcPCkaK9DvkNHgnH4
 ijGS8Hl9D4poXlab8qnDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/bWUbbeESK4=:K3P5dPIBMosadcWX12v0Wf
 yecallTrqRqcbthXQiUfh7uxcJtfno+hmx6KezWAQGmF8UcFy0IAK/b7FHOTu5cajmdNdRKlS
 iwEVHS4nIze351xxRhP++RS4dtYTZAwdRFjLG8j1fZaTmyyEQu5J0Us43xbI0zC74lRdhjIZx
 EyG2A6HykJ5TH7ndEG9qVU6hcOzSsHzAMd7Ji78Qmu43GytKjbNrUAVTF/Nhvn349u+RTf79F
 DF+NTIWscDSXjxd0/T4F31m9rkB5JzBnrQgM1XCQ4+r86liyV+L5nSQos3uIl+m3GcOvJ00rf
 PqJatkAoxsDUDftTPLWXt/AOywxVAMv6dHftP1K1wHm5FM19EIHhLpFw9IJ1KwsOr8ZOG9o+B
 YLu6LHgEYSlqrujH7xGvC+5AXenIQ9KAb+9eIa/Lr4uATB/JxZz1xl/hYUKXQ+NShRlwrA1GY
 ggvS65TgSSGq5ro8jhI5zIQI+80WexLwul4jFG0mnoKXNic2I9IcNyPJjuQkOBZnfAKegP+fo
 UFpOrNGeGDuDC1SJUIkce6np4967tD05UkpunImNv5uWVIlN9dD5vnJhUj5HcBHgUGCo6RYKY
 mWqApzVcw8L0RVxeZ0CF0CV+X+HNRVEyEESSmh7pvapslmU49KgKKDjtClwOdCxYnimmZbRqG
 YDVkKWkJ5M3z5+8BH73PIERQNWfQLCsK+RkZO5gyWicPwF9D7AFA7vhFi4RLJBbh2C4yTjmxi
 jl76bxcloBA1gp1QQqGdApvLD723BVFyPAViT3vdMaDbvS3aYZ21ZVsVrkJKA3BiU3MwDQIok
 1wiQmDC0HAQGypikE+76GnqlVbWf/IXXFxQcfH4XjC8qarX1OoS1nOwiF+XYHgXSde22cbQ/n
 xfKAz6ePdJcbSD6VPc+g==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:55 AM Sargun Dhillon <sargun@sargun.me> wrote:

> +#define PIDFD_IOCTL_GETFD      _IOWR('p', 0xb0, __u32)

This describes an ioctl command that reads and writes a __u32 variable
using a pointer passed as the argument, which doesn't match the
implementation:

> +static long pidfd_getfd(struct pid *pid, u32 fd)
> +{
...
> +       return retfd;

This function passes an fd as the argument and returns a new
fd, so the command number would be

#define PIDFD_IOCTL_GETFD      _IO('p', 0xb0)

While this implementation looks easy enough, and it is roughly what
I would do in case of a system call, I would recommend for an ioctl
implementation to use the __u32 pointer instead:

static long pidfd_getfd_ioctl(struct pid *pid, u32 __user *arg)
{
         int their_fd, new_fd;
         int ret;

         ret = get_user(their_fd, arg);
         if (ret)
              return ret;

        new_fd = pidfd_getfd(pid, their_fd);
        if (new_fd < 0)
                return new_fd;

         return put_user(new_fd, arg);
}

Direct argument passing in ioctls may confuse readers because it
is fairly unusual, and it doesn't work with this:

>  const struct file_operations pidfd_fops = {
>         .release = pidfd_release,
>         .poll = pidfd_poll,
> +       .unlocked_ioctl = pidfd_ioctl,
> +       .compat_ioctl = compat_ptr_ioctl,

compat_ptr_ioctl() only works if the argument is a pointer, as it
mangles the argument to turn it from a 32-bit pointer value into
a 64-bit pointer value. These are almost always the same
(arch/s390 being the sole exception), but you should not rely
on it. For now it would be find to do '.compat_ioctl = pidfd_ioctl',
but that in turn is wrong if you ever add another ioctl command
that does pass a pointer.

       Arnd
