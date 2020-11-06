Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7EF2A9B53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 18:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgKFR4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 12:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFR4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:56:38 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8868C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2020 09:56:37 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id j14so2024862ots.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2020 09:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3m3w3/fMOlXDJm+N0Zej/RJjQZ0pYPZ00tCtiQEUSdU=;
        b=fovs4N3RKV79lvUTx8jz3MnziHYdcUaz1I+/LXTF08aaL01hiRrss+ZRqyQTKh93QX
         CowdktADguXo614na/wuq7Fe6Cb+fq9tDGC50xsWjjm4QqWv9uYZILCqjUdIe3lutkY/
         zltAIoitQnvXDw9GTrf5cRkiB/rPlIIAQ3aNM0CDChoxsSdsq8MzA+M3+iTp2AkSKfJk
         mM53fD7VNawuTuq7JUgf6t8gggLz5RP2JmxnueU8TGXNxNszhEY6BVGJh5+1nQKZfmwm
         PMB/yZKferQUdqYC8VWtZyAZsi9bKT2wvzbDMfAus6p46rHH9QM2LRetmOD1xvhpupmx
         wx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3m3w3/fMOlXDJm+N0Zej/RJjQZ0pYPZ00tCtiQEUSdU=;
        b=FWXEzhPwo+CuB8OJRDAzKnvEz3OKNs8vmLSnqfIJWwrwgC26PqAWKWPVwDy6llD5Bg
         6AHfKSo9SBJQ5lMbT4BZ4mBBghYA7Xf+KHQSiXJt8TxJCRwR35o4XzbLNSkQXN7vGlok
         9quYWeukOeoHZpvtvvuvs+BwPPtFGii73gs7ei/GgoYxGRwe/oxK+s2KpdyuWZ7pi9p6
         63wYLu6eoNzoeA1HZ36CPar5LINLJmaQduGJpqf78BiSyZ50KvdZaBd48hYtkRLh2vq0
         5iBEdC1tKfydULcmBwY/y2UAc3AxyNjFQhvV9fw374EWsOs5GvDZmOLnpDD7L2l2VBjo
         zDdA==
X-Gm-Message-State: AOAM5315Fq61n/T+cA2ryBNxl9NhaTh5C4rAbju319HJv/teD0vnP0Cq
        WiGAItMtXQ04m2jQkYN1eViptw==
X-Google-Smtp-Source: ABdhPJwa2jH0nyfQTVUAb/Jl6YC01h0VQZTP9j6ZoS9GeipGQbVBWQWaGN7Xs8TLDolQKCHe1D7iGg==
X-Received: by 2002:a9d:590e:: with SMTP id t14mr1960910oth.230.1604685397160;
        Fri, 06 Nov 2020 09:56:37 -0800 (PST)
Received: from vyachessmacbook.attlocal.net ([2600:1700:42f0:6600:714b:383:8655:34f6])
        by smtp.gmail.com with ESMTPSA id u22sm466162oor.13.2020.11.06.09.56.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 09:56:36 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] fs/hfs: remove unused macro to tame gcc
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <1604634457-3954-1-git-send-email-alex.shi@linux.alibaba.com>
Date:   Fri, 6 Nov 2020 09:56:31 -0800
Cc:     Linux FS devel list <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FF53100-8B2A-4267-AB70-97D28A325F06@dubeyko.com>
References: <1604634457-3954-1-git-send-email-alex.shi@linux.alibaba.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 5, 2020, at 7:47 PM, Alex Shi <alex.shi@linux.alibaba.com> =
wrote:
>=20
> Couple macro are duplicated defined and they are not used. So
> to tame gcc, let's remove them.
>=20
> fs/hfsplus/part_tbl.c:26:0: warning: macro "HFS_DRVR_DESC_MAGIC" is =
not
> used [-Wunused-macros]
> fs/hfsplus/part_tbl.c:30:0: warning: macro "HFS_MFS_SUPER_MAGIC" is =
not
> used [-Wunused-macros]
> fs/hfsplus/part_tbl.c:21:0: warning: macro "HFS_DD_BLK" is not used
> [-Wunused-macros]
> net/l2tp/l2tp_core.c:73:0: warning: macro "L2TP_HDRFLAG_P" is not used
> [-Wunused-macros]
>=20


Sorry, but this patch doesn=E2=80=99t make sense at all, from my point =
of view.
It is the declaration of magics that could take place on the volume.
Even if these declarations haven=E2=80=99t been used in the code, then
it is important to be aware about this. I don=E2=80=99t think that it =
make sense
to follow to the compiler=E2=80=99s complains in this case. I believe =
that
it needs to keep these declarations.

Thanks,
Viacheslav Dubeyko.=20


> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: linux-fsdevel@vger.kernel.org=20
> Cc: linux-kernel@vger.kernel.org=20
> ---
> fs/hfs/hfs.h          | 2 --
> fs/hfsplus/part_tbl.c | 2 --
> 2 files changed, 4 deletions(-)
>=20
> diff --git a/fs/hfs/hfs.h b/fs/hfs/hfs.h
> index 6f194d0768b6..12a807d9dbc0 100644
> --- a/fs/hfs/hfs.h
> +++ b/fs/hfs/hfs.h
> @@ -15,11 +15,9 @@
> #define HFS_MDB_BLK		2 /* Block (w/i partition) of MDB */
>=20
> /* magic numbers for various disk blocks */
> -#define HFS_DRVR_DESC_MAGIC	0x4552 /* "ER": driver descriptor map */
> #define HFS_OLD_PMAP_MAGIC	0x5453 /* "TS": old-type partition map =
*/
> #define HFS_NEW_PMAP_MAGIC	0x504D /* "PM": new-type partition map =
*/
> #define HFS_SUPER_MAGIC		0x4244 /* "BD": HFS MDB (super =
block) */
> -#define HFS_MFS_SUPER_MAGIC	0xD2D7 /* MFS MDB (super block) */
>=20
> /* various FIXED size parameters */
> #define HFS_SECTOR_SIZE		512    /* size of an HFS sector =
*/
> diff --git a/fs/hfsplus/part_tbl.c b/fs/hfsplus/part_tbl.c
> index 63164ebc52fa..ecda671d56a8 100644
> --- a/fs/hfsplus/part_tbl.c
> +++ b/fs/hfsplus/part_tbl.c
> @@ -23,11 +23,9 @@
> #define HFS_MDB_BLK		2 /* Block (w/i partition) of MDB */
>=20
> /* magic numbers for various disk blocks */
> -#define HFS_DRVR_DESC_MAGIC	0x4552 /* "ER": driver descriptor map */
> #define HFS_OLD_PMAP_MAGIC	0x5453 /* "TS": old-type partition map =
*/
> #define HFS_NEW_PMAP_MAGIC	0x504D /* "PM": new-type partition map =
*/
> #define HFS_SUPER_MAGIC		0x4244 /* "BD": HFS MDB (super =
block) */
> -#define HFS_MFS_SUPER_MAGIC	0xD2D7 /* MFS MDB (super block) */
>=20
> /*
>  * The new style Mac partition map
> --=20
> 1.8.3.1
>=20

