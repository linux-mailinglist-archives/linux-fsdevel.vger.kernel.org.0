Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A8D3230E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 19:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhBWSkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 13:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhBWSkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:40:02 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C6C061574;
        Tue, 23 Feb 2021 10:39:21 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id o16so59642607ljj.11;
        Tue, 23 Feb 2021 10:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/dQXAMhErQFcRRic9fceFXsYd4MlrVmyK0wct060mNk=;
        b=rlzPzfrapjnCOS5qgF1o4BIHsbdajD23mpRwqNg8yX8jhg9zt0YLmx7MrSP8pj99Fx
         dYZ0f693+NOFJudqrypWjZRsMv63DMO9AxJswLW7TbIUlVckQC/y4wBz44/azL+SKz6j
         cfxFngUwm+6Faz/C7c+KiHGrJXyp3cL7BNkNvun5ujBCJ5kl7w0R/NSh8sgJVNXXTCFv
         plKmd7yQHmJQo20RBrTEWrbVJeBu5Hpvh29u5g7JRuvY8xC1t8cG2RnyqgMQsAEUOjKQ
         dEkRWeW8iDRS7VRshaorEK8XWQSDf51fg0mMONBMK7ySWwxRRmrOH9auEH76DW2kahIQ
         4aZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/dQXAMhErQFcRRic9fceFXsYd4MlrVmyK0wct060mNk=;
        b=KFfAltbJg6qx7AAumNHiJHID4NhQ8zkajKf2sOlxLXJVAICuDQ2iAfQUgUdNtXrcG2
         IiE07ZG0V+2rLNYWViySN8TNPKaswnLb/d1wAoIwwOXBerTJONi80pu14rB83xaoXTm0
         KwC2K4F9RkZDdqLwB3wNZ09VgYbZ7gcfcCSwIArW7SrdzMtP2zoia48Fxj6ZOuB3XhOh
         a3bxhRaF7vGhctZmlRWBxm1bi0UUsTTdyVneD3CpzVTnVlTqTW0J/WI2cJqy6620py19
         zVZrSMnj4EUL1JDsErNIErSLdefEqrDk12HIGRk3+RxvfQK1UZL5v7ni0tc6xAMrDX9k
         Mb/w==
X-Gm-Message-State: AOAM5315vyXhdbkhY4LDg1HVhUl2CMT8PVzEqMq86Qgg8rKVCF9WFgxk
        BmLsQKkffkb5pGDGcadjNYa5/mov/UYpy9C2gQnlkButEOM=
X-Google-Smtp-Source: ABdhPJzJJC4HP+w+ZoCJWy7EJcF2+ktQ3WjfswK8JMeAiFq2VEXwpOaCPuW0JIzaED8eqmYffj6AOoaZgZ9W8RWpQ4Y=
X-Received: by 2002:a2e:a36d:: with SMTP id i13mr4788221ljn.148.1614105560304;
 Tue, 23 Feb 2021 10:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20210223182726.31763-1-aaptel@suse.com>
In-Reply-To: <20210223182726.31763-1-aaptel@suse.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 23 Feb 2021 12:39:09 -0600
Message-ID: <CAH2r5mvsWr6F7yZmVQw_b9EegH13y6eOiky-LPxe-_0sKup8dQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: ignore FL_FLOCK locks in read/write
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Would be great if we had some simple reproducer like this in xfstests.

On Tue, Feb 23, 2021 at 12:27 PM Aur=C3=A9lien Aptel <aaptel@suse.com> wrot=
e:
>
> From: Aurelien Aptel <aaptel@suse.com>
>
> flock(2)-type locks are advisory, they are not supposed to prevent IO
> if mode would otherwise allow it. From man page:
>
>    flock()  places  advisory  locks  only; given suitable permissions on =
a
>    file, a process is free to ignore the use of flock() and perform I/O o=
n
>    the file.
>
> Simple reproducer:
>
>         #include <stdlib.h>
>         #include <stdio.h>
>         #include <errno.h>
>         #include <sys/file.h>
>         #include <sys/types.h>
>         #include <sys/wait.h>
>         #include <unistd.h>
>
>         int main(int argc, char** argv)
>         {
>                 const char* fn =3D argv[1] ? argv[1] : "aaa";
>                 int fd, status, rc;
>                 pid_t pid;
>
>                 fd =3D open(fn, O_RDWR|O_CREAT, S_IRWXU);
>                 pid =3D fork();
>
>                 if (pid =3D=3D 0) {
>                         flock(fd, LOCK_SH);
>                         exit(0);
>                 }
>
>                 waitpid(pid, &status, 0);
>                 rc =3D write(fd, "xxx\n", 4);
>                 if (rc < 0) {
>                         perror("write");
>                         return 1;
>                 }
>
>                 puts("ok");
>                 return 0;
>         }
>
> If the locks are advisory the write() call is supposed to work
> otherwise we are trying to write with only a read lock (aka shared
> lock) so it fails.
>
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> ---
>  fs/cifs/file.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 6d001905c8e5..3e351a534720 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -3242,6 +3242,7 @@ cifs_writev(struct kiocb *iocb, struct iov_iter *fr=
om)
>         struct inode *inode =3D file->f_mapping->host;
>         struct cifsInodeInfo *cinode =3D CIFS_I(inode);
>         struct TCP_Server_Info *server =3D tlink_tcon(cfile->tlink)->ses-=
>server;
> +       struct cifsLockInfo *lock;
>         ssize_t rc;
>
>         inode_lock(inode);
> @@ -3257,7 +3258,7 @@ cifs_writev(struct kiocb *iocb, struct iov_iter *fr=
om)
>
>         if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(=
from),
>                                      server->vals->exclusive_lock_type, 0=
,
> -                                    NULL, CIFS_WRITE_OP))
> +                                    &lock, CIFS_WRITE_OP) || (lock->flag=
s & FL_FLOCK))
>                 rc =3D __generic_file_write_iter(iocb, from);
>         else
>                 rc =3D -EACCES;
> @@ -3975,6 +3976,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_it=
er *to)
>         struct cifsFileInfo *cfile =3D (struct cifsFileInfo *)
>                                                 iocb->ki_filp->private_da=
ta;
>         struct cifs_tcon *tcon =3D tlink_tcon(cfile->tlink);
> +       struct cifsLockInfo *lock;
>         int rc =3D -EACCES;
>
>         /*
> @@ -4000,7 +4002,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_it=
er *to)
>         down_read(&cinode->lock_sem);
>         if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(=
to),
>                                      tcon->ses->server->vals->shared_lock=
_type,
> -                                    0, NULL, CIFS_READ_OP))
> +                                    0, &lock, CIFS_READ_OP) || (lock->fl=
ags & FL_FLOCK))
>                 rc =3D generic_file_read_iter(iocb, to);
>         up_read(&cinode->lock_sem);
>         return rc;
> --
> 2.30.0
>


--=20
Thanks,

Steve
