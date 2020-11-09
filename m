Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6B62AC53C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 20:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgKITkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 14:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbgKITkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:40:55 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E506C0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 11:40:55 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id t143so11464904oif.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 11:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RYG5aRqtt1oTe5ehg+dvQZG6g+L+lFoK4HtUJA+r5KM=;
        b=S9hFOP+Ssq7NyJgZ90LPdfpgmbTnVaBk1SKVIeH1g8gjMUNx6T6NsiGHwyfXHZRZdl
         rN2R7/sUH/33WrJAZ6eJth6m0PZ8nt7gCUOJNA/+NnH+vmqeJ76NBriWvZDAWObVv7aC
         puQDLDAL0iZys7rVbPs12KY1ekzhrtKA9OKm7Q08xYn3OKfPiSGE/gXpRU+OggRL7hCD
         t9dyAUXmlUU7ZJJ1N/Vbyk0MDNYEMJeqbFDivxyIHO1gFH3oruvecsYflB/LUHhqycLA
         f86pbbJBKMhsFfwfdZ5RKifIbF3uqbaeAMYVHT/C3DiXWVL8ejpdCyZASQnrJAFpSSPH
         WOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RYG5aRqtt1oTe5ehg+dvQZG6g+L+lFoK4HtUJA+r5KM=;
        b=IqTD0lkkraxJ9oYUQ5ASM2nCg6kOB0p+rq/Chbwah8NaZgxz+S8EjtKu3+lnizbjyD
         xmyVAqEY5TlPeDPRcIzrJp4IdLp09CEOosl2QmhKsfcm5l6efnvGXVwMFGjJsTbpZwTE
         DU3ffCCLlIaRaTnnNi0AkGNnCMqOSUGyh/KMMop63wTo8bidZxjL294Y9zYN09lyxbi9
         XMMW1R7AVuUdKyUWvsTHJqHyujGDtqPsCMyulG0tAIialXDJ0xdWl/ObY24YsvHynLRp
         eq0r3MBih9IzIdOvx/W2iSU88QI/ZpbCE+qCpe5Ziujj65CWSmg1ZG32JE/nxBjTuWTr
         5FQw==
X-Gm-Message-State: AOAM532ZB4c2qJM1/XjEdRoZJ5AwKuW3wT6mnlM8QvDTTAn4ewwTb5Xy
        unIrwtozrvyofBW9GdQcWjtJiw==
X-Google-Smtp-Source: ABdhPJxQj9r/hWa4Api3frfCsBoxa7VOjekt3gZz5yrRq2nyQzcGhbWOR3ec2irEkqcm4H5r7tFXMA==
X-Received: by 2002:aca:ac06:: with SMTP id v6mr485050oie.97.1604950854672;
        Mon, 09 Nov 2020 11:40:54 -0800 (PST)
Received: from ?IPv6:2600:1700:42f0:6600:2015:92de:6a58:e331? ([2600:1700:42f0:6600:2015:92de:6a58:e331])
        by smtp.gmail.com with ESMTPSA id w21sm1052968otq.20.2020.11.09.11.40.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:40:53 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] hfsplus: remove pr_err message on ENOSPC file extend
 error
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20201106215518.390664-1-colin.king@canonical.com>
Date:   Mon, 9 Nov 2020 11:40:52 -0800
Cc:     Linux FS devel list <linux-fsdevel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C65DFC10-FEF7-4117-894D-F347310ED13E@dubeyko.com>
References: <20201106215518.390664-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 6, 2020, at 1:55 PM, Colin King <colin.king@canonical.com> =
wrote:
>=20
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently ENOSPC errors that are triggered from extending a file
> are spamming the kernel log with messages.  Since ENOSPC is being
> returned there is enough information to userspace to inform why
> the extend is failing and the error message is unnecessary and
> just more logging noise.  This is particularly noticeable when
> exercising a full hfs filesystem with stress-ng file stress tests.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> fs/hfsplus/extents.c | 6 +-----
> 1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index a930ddd15681..6cc30482c82c 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -446,13 +446,9 @@ int hfsplus_file_extend(struct inode *inode, bool =
zeroout)
> 	int res;
>=20
> 	if (sbi->alloc_file->i_size * 8 <
> -	    sbi->total_blocks - sbi->free_blocks + 8) {
> +	    sbi->total_blocks - sbi->free_blocks + 8)
> 		/* extend alloc file */
> -		pr_err("extend alloc file! (%llu,%u,%u)\n",
> -		       sbi->alloc_file->i_size * 8,
> -		       sbi->total_blocks, sbi->free_blocks);
> 		return -ENOSPC;
> -	}

Looks good and sounds reasonable.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Viacheslav Dubeyko.

>=20
> 	mutex_lock(&hip->extents_lock);
> 	if (hip->alloc_blocks =3D=3D hip->first_blocks)
> --=20
> 2.28.0
>=20

