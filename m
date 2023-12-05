Return-Path: <linux-fsdevel+bounces-4877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1205F805767
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 15:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CD41C2091D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 14:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4F554FB3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ks2ogx33"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF2B12C
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 05:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701784308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqwroJrGTHefUhDWiBCdA2J4vAuymH0bz+Axm1qiXbE=;
	b=Ks2ogx33pVMFv1Mq8ARU5VZDCrPgMulgEejFQYZ3cUj1O10xuc8UsumHYbWIrANiG+uaiv
	XFEKHpHvzQXKlhAuf0rx//JUj/gsWlnvq0GbcQ/a7Or87bCSDmIOnp9dW+M18HOlR5qhdB
	pr9qpXxbWytrGcF5CmxCTvps/5yXQCo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-jiLj4XoAND-86Hw5yllNGw-1; Tue, 05 Dec 2023 08:51:47 -0500
X-MC-Unique: jiLj4XoAND-86Hw5yllNGw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d0b944650bso9201515ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 05:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784306; x=1702389106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqwroJrGTHefUhDWiBCdA2J4vAuymH0bz+Axm1qiXbE=;
        b=KKxvDqyBNuwdcdWDmJo6avT0cUJmEFayHzWCw1YSf4sYetBUw1zYXlMiMmJ8Y835we
         T+uNwMfkCTvaFDidx3WhTwGVMiBGY3rgCoD83rJAAdugm1gsOOfb7qfnjA0BMPlyU//j
         buLxR6ZA4MnsLuMw7jSYYCCm+JUGGCpSVH5xcaNAM6MRWoZtjZ9apHzIhrIb2zVmvQmf
         0TbvmFz+4N53KpM4Kfc9hEhytIOViLZGA8zVJSDfI6rGXLx9Ap8GiWwfxHarOY5VdC/q
         TYfGLzvdhKpXUmJqTuDFsgMPd+BXA9Jby7kQHL29kgeYZ7AtJ+EZl2n+7t7/La0hEtxd
         lQHw==
X-Gm-Message-State: AOJu0YzsaLVfIFPD0osdmXA/I3wfKfj0ax3hqyzE9y4RGST4au7f9+8i
	37vPJQyGS4XmUnWA51hLjKD+6khswX8roo9QWFEayiuoGU6tJQHTZZKrvQWtVE1iAcIBBdEAwEk
	6rTzHtkkpNiZIhejJQcH/w9m0wwshGeCxoRDX6uOVpA==
X-Received: by 2002:a17:902:e741:b0:1d0:8555:a1bc with SMTP id p1-20020a170902e74100b001d08555a1bcmr3325799plf.13.1701784306639;
        Tue, 05 Dec 2023 05:51:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz6qoVMl9eTDZiTRuQ7GXnKYIuL8zYPdZOJYvdGQGzFFqt7PvtFFUulBhuNSWU8a3LTp27fh5Kz0Th3mHZFuQ=
X-Received: by 2002:a17:902:e741:b0:1d0:8555:a1bc with SMTP id
 p1-20020a170902e74100b001d08555a1bcmr3325793plf.13.1701784306367; Tue, 05 Dec
 2023 05:51:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000737829060b7b8775@google.com> <tencent_FCCCB879B66D7C2C2D6E4C97F4E972EE3A0A@qq.com>
In-Reply-To: <tencent_FCCCB879B66D7C2C2D6E4C97F4E972EE3A0A@qq.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 5 Dec 2023 14:51:34 +0100
Message-ID: <CAHc6FU4XREidNxwtW8m2YnsBGfANdH4W8b56KOeMNLjEEU_WGQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix kernel BUG in gfs2_quota_cleanup
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 10:34=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> =
wrote:
> [Analysis]
> When the task exits, it will execute cleanup_mnt() to recycle the mounted=
 gfs2
> file system, but it performs a system call fsconfig(4, FSCONFIG_CMD_RECON=
FIGURE,
> NULL, NULL, 0) before executing the task exit operation.
>
> This will execute the following kernel path to complete the setting of
> SDF_JOURNAL_LIVE for sd_flags:
>
> SYSCALL_DEFINE5(fsconfig, ..)->
>         vfs_fsconfig_locked()->
>                 vfs_cmd_reconfigure()->
>                         gfs2_reconfigure()->
>                                 gfs2_make_fs_rw()->
>                                         set_bit(SDF_JOURNAL_LIVE, &sdp->s=
d_flags);
>
> [Fix]
> Add SDF_NORECOVERY check in gfs2_quota_cleanup() to avoid checking
> SDF_JOURNAL_LIVE on the path where gfs2 is being unmounted.

Thanks for this fix, I've applied it and added the following tag:

Fixes: f66af88e3321 ("gfs2: Stop using gfs2_make_fs_ro for withdraw")

>
> Reported-and-tested-by: syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail=
.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/gfs2/quota.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 95dae7838b4e..af32dd8a72fa 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -1505,7 +1505,8 @@ void gfs2_quota_cleanup(struct gfs2_sbd *sdp)
>         LIST_HEAD(dispose);
>         int count;
>
> -       BUG_ON(test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));
> +       BUG_ON(!test_bit(SDF_NORECOVERY, &sdp->sd_flags) &&
> +               test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));
>
>         spin_lock(&qd_lock);
>         list_for_each_entry(qd, &sdp->sd_quota_list, qd_list) {
> --
> 2.43.0

Thanks,
Andreas


