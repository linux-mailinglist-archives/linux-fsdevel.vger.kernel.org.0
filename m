Return-Path: <linux-fsdevel+bounces-7164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A29D8229E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 10:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE4C1C2309C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36D218B09;
	Wed,  3 Jan 2024 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="PnTKtKz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D32D18AE8
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e7aed08f4so228165e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 01:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1704272616; x=1704877416; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d52rUVOam7Y2+Idj66TR43fT/VB+iP/aQ8VOjc5QKOE=;
        b=PnTKtKz+kQVndIbDEn5B3CIvVnJyfyB/gB496aaHH06c2XV1QeNX7FhTLJO0shexdk
         aY7wJ4sNqXHZrs9ww6uN0PBSb7S3F1hlR3+kbJ4OCwtGl0uRhzN2YPwlMrNAOnIfe1G5
         4AUJB1F/J7SgGRI1SelEdJld5N8XHiIe++xW/MwG63tagc1ykUG9kiWkfccpLWxBDbM3
         UKkUSBk0AfEH7j9qqKJ0YrMBkJq3D22XFW6mm+9kyMdWfqJDvGpq7ozqZv8QQT8hO5m9
         gwFv7CQvXDlfP5MLzw3Q1aaiJDufSh0E5Hl7bocu3+5+PXC02mP6knh0yoc0Pp7JFdmf
         Exvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704272616; x=1704877416;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d52rUVOam7Y2+Idj66TR43fT/VB+iP/aQ8VOjc5QKOE=;
        b=HKs0IUwCzRokb28jxvWfJmtcQAgiH7j1F7YVAY/bUG29qk9kCZFP9fY/ZGCYPDGEJ2
         Yi8e2rKkdsMVyUVTEHC45i6i+9SGdVzVg1X+62wr7jRRz1o/wlSdouLje9fAcYFxLORK
         Gc1eGgITwYEntTalRYS9riA2PW1S3vAasH9me9yB+WvulMV/BhL1kJC4DcIQTxj8emeZ
         PiM0G6tWh3+O6NRmvga/rPLO7SnRgNcqCstQE9GuTcrlnczEhYWgb+Gk32lgO0Adr5z8
         7tWkZEalT1PxR3bSorq3IAY92JY2bnF0FL/IpN0+IAzR+pqOEArAhHo8P/Neh6dd/MRo
         jyHQ==
X-Gm-Message-State: AOJu0Yw/L/7v/NsItgND3GXqZdwtu7WNjqOy7R923NlfUGjmMerAV+hn
	CSLHBBHfEtr55dKmvytZsOX16f42dnEzYfZFuy/El5rDImzIEA==
X-Google-Smtp-Source: AGHT+IEm48fv+G3Sd9YFNh/EXabrSlC5idoW4Bfr+EYzCDKHmC2KwNYq/f4slVBPwfI9MOLNEHeTNA==
X-Received: by 2002:ac2:5306:0:b0:50e:7b5e:285d with SMTP id c6-20020ac25306000000b0050e7b5e285dmr389944lfh.2.1704272615772;
        Wed, 03 Jan 2024 01:03:35 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:b817:c4e5:4423:6afc])
        by smtp.gmail.com with ESMTPSA id x15-20020a19e00f000000b0050e755939f1sm3268992lfg.166.2024.01.03.01.03.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2024 01:03:35 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] hfs: fix deadlock in hfs_extend_file
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <tencent_8C1ACE487B4E6C302EE56D8C95C0E8E2EF0A@qq.com>
Date: Wed, 3 Jan 2024 12:03:31 +0300
Cc: syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 syzkaller-bugs@googlegroups.com,
 willy@infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A468D14-579A-4EDF-9AFE-32A51C7101F3@dubeyko.com>
References: <0000000000004efa57060def87be@google.com>
 <tencent_8C1ACE487B4E6C302EE56D8C95C0E8E2EF0A@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)



> On Jan 2, 2024, at 3:36 PM, Edward Adam Davis <eadavis@qq.com> wrote:
>=20
> [syz report]
> syz-executor279/5059 is trying to acquire lock:
> ffff888079c100f8 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: =
hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397
>=20
> but task is already holding lock:
> ffff888079c10778 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: =
hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397
>=20
> other info that might help us debug this:
> Possible unsafe locking scenario:
>=20
>       CPU0
>       ----
>  lock(&HFS_I(tree->inode)->extents_lock);
>  lock(&HFS_I(tree->inode)->extents_lock);
>=20
> *** DEADLOCK ***
> [Analysis]=20
> hfs_extend_file()->
>   hfs_ext_read_extent()->
>     __hfs_ext_cache_extent()->
>       __hfs_ext_write_extent()->
>         hfs_bmap_reserve()->
>           hfs_extend_file()->
>=20
> When an inode has both the HFS_FLG_EXT_DIRTY and HFS_FLG_EXT_NEW =
flags, it will
> enter the above loop and trigger a deadlock.
>=20
> [Fix]
> In hfs_ext_read_extent(), check if the above two flags exist =
simultaneously,=20
> and exit the subsequent process when the conditions are met.
>=20
> Reported-and-tested-by: =
syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> fs/hfs/extent.c | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
> index 6d1878b99b30..1b02c7b6a10c 100644
> --- a/fs/hfs/extent.c
> +++ b/fs/hfs/extent.c
> @@ -197,6 +197,10 @@ static int hfs_ext_read_extent(struct inode =
*inode, u16 block)
> 	    block < HFS_I(inode)->cached_start + =
HFS_I(inode)->cached_blocks)
> 		return 0;
>=20
> +	if (HFS_I(inode)->flags & HFS_FLG_EXT_DIRTY &&=20
> +	    HFS_I(inode)->flags & HFS_FLG_EXT_NEW)=20
> +		return -ENOENT;
> +

I don=E2=80=99t think that fix can be so simple. It looks like the code =
requires significant
refactoring. Because, currently, it looks like bad recursion: =
hfs_extend_file() finally
calls hfs_extend_file(). And it smells really badly. Also, from the =
logical point of view,
hfs_ext_read_extent() method calls __hfs_ext_write_extent() that sounds =
like not
good logic. I believe we need more serious refactoring of =
hfs_extend_file() logic.

Potentially, hfs_extend_file() can check that we have HFS_FLG_EXT_DIRTY =
and
execute logic of write extent without calling himself again. But I =
haven=E2=80=99t clear picture
of necessary refactoring efforts yet.

Thanks,
Slava.


