Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82FD3B952D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 19:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhGARGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 13:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhGARGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:06:23 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE26C061764
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jul 2021 10:03:52 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w127so8008485oig.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jul 2021 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M0Yqw0xxOZEekYTg3q3CvD7YLfizNegvaHh2b9l5Vmk=;
        b=A0GIXMDUpYvWxru961gfAFBLi6EXhfck8ja0MyrGOoL7HUOgoWq4tsdGQVzLdVYxYj
         mbJIrmLQwN2eLtby/ZSs1GYs3z6nAL2Csoj7vojKmmw2iJpi3391Jqe1T1pO5JuH6xP1
         Ztw3iJ6/vzU6lnra/kmmax89ndkVyKC+AJmBZdy0Zubw0+3YLY+CWUnrKF1tQwhwlCOu
         T6+/FDxJu3dwKHhNTt5epkLhGjgjnYsp+vhz2/cAPs3h+qoiO9mbhX2jQEaF056IpjVT
         l78BNYNCOWG16pBz4B+hTsKg9TCHDZDBc9sbuDDUKzUiEpZEO3xxGHytjkhH6qDUxpS0
         eOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M0Yqw0xxOZEekYTg3q3CvD7YLfizNegvaHh2b9l5Vmk=;
        b=VS5IDkqyhdG+qGnUXpUI+Jy7NTdgS6X0kQ+ooZ3uZnEd3A90CA3I5GVbwI+yVWIMot
         c3yD75EMxOX8Qbdi3kDSu3jR/oLYcq54RHUzA+W5+Ji9uYZYuVOWlM2zGiu8uPpTSEYj
         4yFkt8kBDG+odLh8iVW1eHoKwR2V+Q6n7trgJwIC05GdF8vyxi+BvhywbenVeP30iQ2O
         iT0nIDjE5YLNockBKzFwJKeLZayH3pUFhc6nEU4LIB3Wk76Ib5+GzrGii9JxCyWf9LnR
         0+y2C5rIyY3wh2+jJV3CwZvgANS3zpvG1qBh+N94uGouE1sVX0M4LgAm6U7/y2uWvZ6Q
         aYaA==
X-Gm-Message-State: AOAM531gfChaUTHSfBTLag3XSxLaPQj65jR3i68cB32yRZ8I1OTm1NRy
        WF4pLe5u1Wzhtb+i17m/tA48gg==
X-Google-Smtp-Source: ABdhPJwhHT2pfB50RcE85YuEIDJOKFqmMwPxxC26S94fj9TqVYDaTl0XBXOspHFIsPFOPiixueZ+0A==
X-Received: by 2002:a05:6808:1144:: with SMTP id u4mr2133470oiu.133.1625159031856;
        Thu, 01 Jul 2021 10:03:51 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:4d57:e39e:c32f:13d2])
        by smtp.gmail.com with ESMTPSA id l10sm57404oti.9.2021.07.01.10.03.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jul 2021 10:03:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2 1/3] hfs: add missing clean-up in hfs_fill_super
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20210701030756.58760-2-desmondcheongzx@gmail.com>
Date:   Thu, 1 Jul 2021 10:03:50 -0700
Cc:     gustavoars@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A3F727E-8705-4164-951C-B2B99502998A@dubeyko.com>
References: <20210701030756.58760-1-desmondcheongzx@gmail.com>
 <20210701030756.58760-2-desmondcheongzx@gmail.com>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 30, 2021, at 8:07 PM, Desmond Cheong Zhi Xi =
<desmondcheongzx@gmail.com> wrote:
>=20
> Before exiting hfs_fill_super, the struct hfs_find_data used in
> hfs_find_init should be passed to hfs_find_exit to be cleaned up, and
> to release the lock held on the btree.
>=20
> The call to hfs_find_exit is missing from an error path. We add it
> back in by consolidating calls to hfs_find_exit for error paths.
>=20
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---
> fs/hfs/super.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 44d07c9e3a7f..12d9bae39363 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -420,14 +420,12 @@ static int hfs_fill_super(struct super_block =
*sb, void *data, int silent)
> 	if (!res) {
> 		if (fd.entrylength > sizeof(rec) || fd.entrylength < 0) =
{
> 			res =3D  -EIO;
> -			goto bail;
> +			goto bail_hfs_find;
> 		}
> 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, =
fd.entrylength);
> 	}
> -	if (res) {
> -		hfs_find_exit(&fd);
> -		goto bail_no_root;
> -	}
> +	if (res)
> +		goto bail_hfs_find;
> 	res =3D -EINVAL;
> 	root_inode =3D hfs_iget(sb, &fd.search_key->cat, &rec);
> 	hfs_find_exit(&fd);
> @@ -443,6 +441,8 @@ static int hfs_fill_super(struct super_block *sb, =
void *data, int silent)
> 	/* everything's okay */
> 	return 0;
>=20
> +bail_hfs_find:
> +	hfs_find_exit(&fd);
> bail_no_root:
> 	pr_err("get root inode failed\n");
> bail:
> --=20
> 2.25.1
>=20

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

