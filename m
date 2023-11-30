Return-Path: <linux-fsdevel+bounces-4352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5447FED06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 11:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3972B20F13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3624818E01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCd2GImu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA3110E2
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 02:07:36 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67a095fbe27so15608796d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 02:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701338855; x=1701943655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuFUAZ9yjl5PI8N+K9CR3oKMRQ/lDeYn7m/q3UNsL6w=;
        b=WCd2GImu8c9/TyJb0B/4cq5L4SYVaN62I6mZML9EgMq3V5iepJj7MuNmiDk8676UxB
         9X5bsvNLg3JfyH4n7gWd3Yel3vwBSZtzUaOXob9thjHWZZs7H/1p9ZrZcGHDblJSKpEL
         rK6Wwf3W+zjdjQoGwrzoMy85ne++AuqZJOvNlfZFjrTEmSt7F4q9ug3pJnI+ZlQQVcF0
         6Lm0+OUDSj4zj8riv+iOIef2euzMxDtD4qbRslGCrJD634guAx8eXgEzh7DjVLXV5SRQ
         I4SArcP/6rH98MB+DZc3+kYBpBN6rEEoX0SjlZIcWFSNFMaBryqdGTogD3ZNYgOEzKb2
         da0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338855; x=1701943655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuFUAZ9yjl5PI8N+K9CR3oKMRQ/lDeYn7m/q3UNsL6w=;
        b=MohGsTxynDjo1bONbY5i2MAsCYVwDZ4A3FZhnhhHcey2ZAexx66gg2BMSW6RhmqP3u
         T87ZjDaZcuiGafS66+B4Zet2ujhFRjB9bu0/V+REz2EaZ4jO+/+HadibrSpW/9reTINh
         8MKvIMtASQ3J/yW8HcEJGavCosrn/ZvpAsS5EUwxxrnmbr/H8TMDlRuWj/DHsBu2bgjA
         dwjh5HSxnj9g0Oslwx6sB4ljnnI/F3emX1gDdz+NeBWbGcJvwuScZKOd4BWMpFWz1g8T
         +8/QfRjBfy2MzDK1FSf7Cih9F7k0l6EpH5i90t8KnvVHDWALy1+XCnMMPdoRP31j1Dp4
         nmeQ==
X-Gm-Message-State: AOJu0YwL51kdnKipJe1gUWWN8dfjCUCdg1fU1eST3kxR8Dt3+wfGic7J
	hVK2MlodE66yN4YmrBv/+itJ9BkKXkVSeKTLMzU=
X-Google-Smtp-Source: AGHT+IHS0BK2rlXLb4DMQdba/5dfzSxK58ootapSd21rzq37MAbGNnEUqlWP3mnHbdJs1emw79hnIeOcUy6yFQK/70o=
X-Received: by 2002:a05:6214:5181:b0:677:f219:27e6 with SMTP id
 kl1-20020a056214518100b00677f21927e6mr33486261qvb.28.1701338855076; Thu, 30
 Nov 2023 02:07:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129200709.3154370-1-amir73il@gmail.com> <CAOQ4uxhCC+ZpULkBf_WfsyRBToNxksesBAk5nCsGYWkuNFu6JA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhCC+ZpULkBf_WfsyRBToNxksesBAk5nCsGYWkuNFu6JA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 12:07:23 +0200
Message-ID: <CAOQ4uxhcYXzaeV=gymHN3-N-Mn30+_==5KRFzyp7Xs_nuBoMZw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Avert possible deadlock with splice() and fanotify
To: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 10:32=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Wed, Nov 29, 2023 at 10:07=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> >
> > Christian,
> >
> > Josef has helped me see the light and figure out how to avoid the
> > possible deadlock, which involves:
> > - splice() from source file in a loop mounted fs to dest file in
> >   a host fs, where the loop image file is
> > - fsfreeze on host fs
> > - write to host fs in context of fanotify permission event handler
> >   (FAN_ACCESS_PERM) on the splice source file
> >
> > The first patch should not be changing any logic.
> > I only build tested the ceph patch, so hoping to get an
> > Acked-by/Tested-by from Jeff.
> >
> > The second patch rids us of the deadlock by not holding
> > file_start_write() while reading from splice source file.
> >
>
> OOPS, I missed another corner case:
> The COPY_FILE_SPLICE fallback of server-side-copy in nfsd/ksmbd
> needs to use the start-write-safe variant of do_splice_direct(),
> because in this case src and dst can be on any two fs.
> Expect an extra patch in v2.
>

For the interested, see server-side-copy patch below.
Pushed to branch start-write-safe [1], but will wait with v2 until
I get comments on v1.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/start-write-safe

Author: Amir Goldstein <amir73il@gmail.com>
Date:   Thu Nov 30 11:42:50 2023 +0200

    fs: use do_splice_direct() for nfsd/ksmbd server-side-copy

    nfsd/ksmbd call vfs_copy_file_range() with flag COPY_FILE_SPLICE to
    perform kernel copy between two files on any two filesystems.

    Splicing input file, while holding file_start_write() on the output fil=
e
    which is on a different sb, posses a risk for fanotify related deadlock=
s.

    We only need to call splice_file_range() from within the context of
    ->copy_file_range() filesystem methods with file_start_write() held.

    To avoid the possible deadlocks, always use do_splice_direct() instead =
of
    splice_file_range() for the kernel copy fallback in vfs_copy_file_range=
()
    without holding file_start_write().

    Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/read_write.c b/fs/read_write.c
index 0bc99f38e623..12583e32aa6d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1565,11 +1565,18 @@ ssize_t vfs_copy_file_range(struct file
*file_in, loff_t pos_in,
         * and which filesystems do not, that will allow userspace tools to
         * make consistent desicions w.r.t using copy_file_range().
         *
-        * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLIC=
E.
+        * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLIC=
E
+        * for server-side-copy between any two sb.
+        *
+        * In any case, we call do_splice_direct() and not splice_file_rang=
e(),
+        * without file_start_write() held, to avoid possible deadlocks rel=
ated
+        * to splicing from input file, while file_start_write() is held on
+        * the output file on a different sb.
         */
-       ret =3D generic_copy_file_range(file_in, pos_in, file_out, pos_out,=
 len,
-                                     flags);
+       file_end_write(file_out);

+       ret =3D do_splice_direct(file_in, &pos_in, file_out, &pos_out,
+                              min_t(size_t, len, MAX_RW_COUNT), 0);
 done:
        if (ret > 0) {
                fsnotify_access(file_in);
@@ -1581,8 +1588,6 @@ ssize_t vfs_copy_file_range(struct file
*file_in, loff_t pos_in,
        inc_syscr(current);
        inc_syscw(current);

-       file_end_write(file_out);
-
        return ret;
 }
 EXPORT_SYMBOL(vfs_copy_file_range);

