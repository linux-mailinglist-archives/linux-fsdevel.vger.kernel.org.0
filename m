Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06DE1139418
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 15:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgAMO61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 09:58:27 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:42209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgAMO60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:58:26 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M7sYM-1inBgI1Gmw-004yL9; Mon, 13 Jan 2020 15:58:24 +0100
Received: by mail-qk1-f176.google.com with SMTP id 21so8725826qky.4;
        Mon, 13 Jan 2020 06:58:23 -0800 (PST)
X-Gm-Message-State: APjAAAUbNqze/5WHU/VQKdKP7l15iFx7vqZkQBbUtwrg2rEFOih2nvok
        8xoTEJSzGEhx8CD9OsYPc0PdMQtCxiZsT8xk8bk=
X-Google-Smtp-Source: APXvYqzX7zxX9pH9pukwYKAE1ykcYEuCeLn0zthJITtwFy7WB/faO8CKwqctjvI/3df/TsYu7rTH9XkGLixY8gA4z0M=
X-Received: by 2002:a37:2f02:: with SMTP id v2mr16183662qkh.3.1578927503022;
 Mon, 13 Jan 2020 06:58:23 -0800 (PST)
MIME-Version: 1.0
References: <20200107175927.4558-1-sargun@sargun.me> <20200107175927.4558-3-sargun@sargun.me>
In-Reply-To: <20200107175927.4558-3-sargun@sargun.me>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Jan 2020 15:58:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a10iVg6dyvGGLjjdvyUcBQhzC5zmwBzS_Bfpk0FQE4k5Q@mail.gmail.com>
Message-ID: <CAK8P3a10iVg6dyvGGLjjdvyUcBQhzC5zmwBzS_Bfpk0FQE4k5Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] pid: Implement pidfd_getfd syscall
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
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jed Davis <jld@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RBYwWIZw/kZBa5CmRIX3QhyHidRUSWlKxEfoRbEe6X188nb13TI
 ySzGcm53kIpaOZUKB9bDdys+roSq7c8k7YVLfYmFP5FFVLW+EhPZ2sIwCbKYmBw0hWYgkJa
 3MfjvuWDcQxCZ7+l50dZmyrGjEiuFbToSvMWHCYVz40cFdUOlzQMQPG9OhO1rx6o3rV+1Dv
 t9qRX/13OM4N20iNpwlBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oUvEwSvEgOU=:tr6uYQhYPG+ktVz1ywqzbD
 z7XFXvdLpjTpL+IW5Hgs6hOid8xEcNFxveuNsa4U5LCV5pkln6s4LadDOTwXyaTe4o9ugTKdr
 Ew7djvNdUej9U8y22H7NyTbYruA+KbDK44ZiHa+1ki9Ad8kx2aLvdyzaWiC2qEPxV55hm7m5V
 tW4IdAVLr70EjVxvG53zRFc/bQH5SA+vhX3mS6fZ7X5Wcd3RqycnRjnYj7uqV5v48s1nttWT9
 A62T248O7QV+2aq+2ldP62zLbnWsZsc5dwuLPhHPn+wbYxSV2OZbDLjsZQNZdi1s/gplNlrik
 5HJSwBqSdaabOzHz+awAxCpKxt5vsFFJfBQH6IRhEf4hxaY4pHUV6pMjPTeo0Mj0LriXJNV1H
 RNopgKp8ZdPqTcV6dwKKp2K7PYTRCP9uA/A+BycVeecvqqL/o8PcuQGRfmZBUM831ceG5ZRnD
 X9xPHx8OrwsNq/T/tY2wCQzcrOpK/olx8z7K+rKLIaeOw+Nqaimc4e/Ld54YWYMnBIrO+i0Kp
 ZP2G8OGrbEFY/w8tw8FUPdSwgtgazxMiyb8PVJ+5l8dmNySuR8rDJeRB+FKNmMmNwHMlzaedl
 qntm6/+a+HZuWgnwKxOGjy5ySBdD5C/tcztQp1X6Q5gP5FBWMzY53xG+pAMitXBjelRLpGw8v
 pupqfzkNXpmV0JtnCzV6TAwmG60htuZS0bSQ5LvCdbfrQ7QAReyauxjbU+91mjy8mi9/splvO
 VplgKmKbw3WqpXvPoyr3RvqB+R68Nfp8ew9hKYUY4LMCggtZYiAZu5NwcVYA8uRiOAE6RlTax
 RxCEkhDNye7XQtX+86wAx4WYsHE1OaEsDQwHQFHPExNAPM0BjK8U3485il7SS+pBNZy3VL0dV
 3zHsrnI0UrjHkA2fCSHw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 7, 2020 at 6:59 PM Sargun Dhillon <sargun@sargun.me> wrote:
> +/**
> + * sys_pidfd_getfd() - Get a file descriptor from another process
> + *
> + * @pidfd:     the pidfd file descriptor of the process
> + * @fd:                the file descriptor number to get
> + * @flags:     flags on how to get the fd (reserved)
> + *
> + * This syscall gets a copy of a file descriptor from another process
> + * based on the pidfd, and file descriptor number. It requires that
> + * the calling process has the ability to ptrace the process represented
> + * by the pidfd. The process which is having its file descriptor copied
> + * is otherwise unaffected.
> + *
> + * Return: On success, a cloexec file descriptor is returned.
> + *         On error, a negative errno number will be returned.
> + */
> +SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
> +               unsigned int, flags)

This is the most sensible definition I can see. I can not tell
whether we should or want to have it, but if everyone thinks
this is a good idea, then this ABI makes sense.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
