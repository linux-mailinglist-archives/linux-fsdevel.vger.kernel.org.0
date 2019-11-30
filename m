Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7816210DF67
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 22:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfK3VZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 16:25:51 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39601 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfK3VZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 16:25:51 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so10589209ioh.6;
        Sat, 30 Nov 2019 13:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xN2NEYgLxOLt/H9lUAJjUJ5JSxlsQ1fRNDxtHYCIblE=;
        b=ly0yRe+o3kS13C86HWT4bTLzDRbrg56nDLSbbJgI5RE8dwkXyz7RlJQLBX1Y3PSiFH
         kHUgmAQxTf7UN8cq3EGVKyrwTyW1JsrnzELs2A73ijoOWxiQk2AmV2JMpEubzu7t9dFx
         itjAjf0evgPqLvZcJ4lEh3YntgyHDM+2Wu4rA9mDATcib4sdSq8Xn7Ska484rEuY5z40
         nnoAr+QnQosoM/JTBfKp/sICBrzkMQ127tH/8AwrnVL8MI86MqXoFA4iDpoHDeOaJg2f
         7p0AT5THqyylqPy5oknuLRYy7EB3HPon5/rlT8s8LGznyDaEFcxOK36BtJlWaupGFcLd
         /pXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xN2NEYgLxOLt/H9lUAJjUJ5JSxlsQ1fRNDxtHYCIblE=;
        b=pMgM0PpNi1T2O68XteZubh2gOEnTNfEBGtvK+jWwhNO+h0VMyDnGHNm+hnmGY93DUb
         9ZGyk5D7tBMAFdnjBMz6lbkoVOunwiuxvD04kQXOpbl4SE0bDKW1en34BLyIsMKfrXlS
         5RYVQU4D+OZ6XEdlFauaQ5yvjUPwEkOp7OZU++4fZYm09NerCS8DZqIdKUJHT5HKACZT
         w2jZq6jVM0oJIQmZpjBEwR5Ilwl3LlJ8Jr8lUl58L2TJNDKr/3axLJRmBeTkRfNOD0mN
         f8qY5QW/Z64WBM0bYunIcw4T8i7s86OV8k9ldyBV4YHy7HrqeR5fzU+a56sDLzu5T3wY
         n81g==
X-Gm-Message-State: APjAAAXl6DQRm8LfTzFLbnTD7C0LHcD2Wy6nM64hQrbjqH2W84VpWswy
        /086SqNrjporP40Qh4Jh6N21egfnin8lVKJ9NolrZw==
X-Google-Smtp-Source: APXvYqzUJmvy9Gmi9HiG+HIP45gcXxN9IhfEILjc3pjvRqFTaaUvdE5JM6DbKzVXAosomlkXF8r6wIJBuSEYss1HXTM=
X-Received: by 2002:a5d:83c9:: with SMTP id u9mr5646687ior.272.1575149150175;
 Sat, 30 Nov 2019 13:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20191130053030.7868-1-deepa.kernel@gmail.com> <20191130053030.7868-4-deepa.kernel@gmail.com>
In-Reply-To: <20191130053030.7868-4-deepa.kernel@gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 30 Nov 2019 15:25:39 -0600
Message-ID: <CAH2r5msrqokxHGr6c4N8=mOw6v1h9ZXDQFSVMRPHnTmV1n0L=w@mail.gmail.com>
Subject: Re: [PATCH 3/7] fs: cifs: Delete usage of timespec64_trunc
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steve French <stfrench@microsoft.com>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Is this intended to merge separately or do you want it merged through
the cifs git tree?

On Fri, Nov 29, 2019 at 11:33 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> timestamp_truncate() is the replacement api for
> timespec64_trunc. timestamp_truncate() additionally clamps
> timestamps to make sure the timestamps lie within the
> permitted range for the filesystem.
>
> Truncate the timestamps in the struct cifs_attr at the
> site of assignment to inode times. This
> helps us use the right fs api timestamp_trucate() to
> perform the truncation.
>
> Also update the ktime_get_* api to match the one used in
> current_time(). This allows for timestamps to be updated
> the same way always.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: stfrench@microsoft.com
> Cc: linux-cifs@vger.kernel.org
> ---
>  fs/cifs/inode.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> index ca76a9287456..026ed49e8aa4 100644
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -113,6 +113,7 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
>         }
>
>          /* revalidate if mtime or size have changed */
> +       fattr->cf_mtime = timestamp_truncate(fattr->cf_mtime, inode);
>         if (timespec64_equal(&inode->i_mtime, &fattr->cf_mtime) &&
>             cifs_i->server_eof == fattr->cf_eof) {
>                 cifs_dbg(FYI, "%s: inode %llu is unchanged\n",
> @@ -162,6 +163,9 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
>         cifs_revalidate_cache(inode, fattr);
>
>         spin_lock(&inode->i_lock);
> +       fattr->cf_mtime = timestamp_truncate(fattr->cf_mtime, inode);
> +       fattr->cf_atime = timestamp_truncate(fattr->cf_atime, inode);
> +       fattr->cf_ctime = timestamp_truncate(fattr->cf_ctime, inode);
>         /* we do not want atime to be less than mtime, it broke some apps */
>         if (timespec64_compare(&fattr->cf_atime, &fattr->cf_mtime) < 0)
>                 inode->i_atime = fattr->cf_mtime;
> @@ -329,8 +333,7 @@ cifs_create_dfs_fattr(struct cifs_fattr *fattr, struct super_block *sb)
>         fattr->cf_mode = S_IFDIR | S_IXUGO | S_IRWXU;
>         fattr->cf_uid = cifs_sb->mnt_uid;
>         fattr->cf_gid = cifs_sb->mnt_gid;
> -       ktime_get_real_ts64(&fattr->cf_mtime);
> -       fattr->cf_mtime = timespec64_trunc(fattr->cf_mtime, sb->s_time_gran);
> +       ktime_get_coarse_real_ts64(&fattr->cf_mtime);
>         fattr->cf_atime = fattr->cf_ctime = fattr->cf_mtime;
>         fattr->cf_nlink = 2;
>         fattr->cf_flags = CIFS_FATTR_DFS_REFERRAL;
> @@ -609,10 +612,8 @@ cifs_all_info_to_fattr(struct cifs_fattr *fattr, FILE_ALL_INFO *info,
>
>         if (info->LastAccessTime)
>                 fattr->cf_atime = cifs_NTtimeToUnix(info->LastAccessTime);
> -       else {
> -               ktime_get_real_ts64(&fattr->cf_atime);
> -               fattr->cf_atime = timespec64_trunc(fattr->cf_atime, sb->s_time_gran);
> -       }
> +       else
> +               ktime_get_coarse_real_ts64(&fattr->cf_atime);
>
>         fattr->cf_ctime = cifs_NTtimeToUnix(info->ChangeTime);
>         fattr->cf_mtime = cifs_NTtimeToUnix(info->LastWriteTime);
> --
> 2.17.1
>


-- 
Thanks,

Steve
