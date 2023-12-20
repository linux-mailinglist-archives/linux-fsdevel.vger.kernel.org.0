Return-Path: <linux-fsdevel+bounces-6579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EDD819D9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 12:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78AA91F21D82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 11:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76DF210F6;
	Wed, 20 Dec 2023 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdnh2nqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C930E20DDD
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4b6de25993cso627557e0c.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 03:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703070250; x=1703675050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VcbHzJt15L0qb+G8TjK9OtpQ158sGn0qEnv30Rom+o8=;
        b=jdnh2nqiL0eJVRH6LSo0X4AJqkLKjsENOx0U3e2LlDTqicWIZZ5BLyPM3Hwr8gG9yu
         lnSL1wbp2rCl1RXUD9fv4NV5ZQy+5+fJqXE+mzspr/5aQnJxbxLOXlynMylOxkdvACMz
         8ydmbigkcN26FSRoOzbwCjcQrQTxF2h+MWyTSobXXyxUNcwjP6jvjwVnl/RAWNTAT2+t
         +z0PReB2pFGBRX3qCB3kqBLMwv6Tneg6KZswAiX9r8qD6TZQUVp0bmB6EcE0OWgvN1lQ
         nJpwlPTplmMSwTwF/lPqDbjMFuFtBueWba4uICwRzOFNUFvhh3i6RPynng9PfmuuM/wr
         3MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703070250; x=1703675050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcbHzJt15L0qb+G8TjK9OtpQ158sGn0qEnv30Rom+o8=;
        b=qZ6hAvX77wyImMBNj7pCRw8kriYboSF1SsXRsK1+X0V2cCRM6QN17/Oax5zx3x/mWs
         S+H+qZOVx0tGzOv9vCTbfqKf86yi/gtBIY9LrpjY665ozVlFDeliYOfOCwulqMiQoLAX
         O4/WLNIWa+MlHT+J67OyaBC+ElTK7o/FePP9RbznmXry+LNoGXD4nLZeYH2/OyjI1wmn
         wKUfkJvZUPZDDNuN+i7Jo4ZwY54iLjM2XNmPavWS7EcW3HH3NQG6L94Q8pp339Pes6Yg
         63HlP/8szm7zPSQjUSoJjh0e6xLgWqVsSb74Nbwny+rPcPOAwoV+NDwXTFRXugoXXELr
         Yffg==
X-Gm-Message-State: AOJu0Yy8HQ5thkrWwAaeFrYrdnGy8sSgr/WjTb7eZqIcihy1BFeqGmfv
	Vp9uCmHvPjdP7UNL3znNWtjfhj/HFpazLHBcV8+X/Vxh
X-Google-Smtp-Source: AGHT+IG3u3+dQKNP2Gyh1mK01wPOa5LqOuOICmzNGopxTwkHTImaHFNoUH50C5XG3Tr0pmIkjq+orTpnILcc46+d2bE=
X-Received: by 2002:a05:6122:1281:b0:4b6:e73d:7203 with SMTP id
 i1-20020a056122128100b004b6e73d7203mr1174379vkp.14.1703070250501; Wed, 20 Dec
 2023 03:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220051348.GY1674809@ZenIV> <20231220052536.GL1674809@ZenIV>
In-Reply-To: <20231220052536.GL1674809@ZenIV>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Wed, 20 Dec 2023 11:03:59 +0000
Message-ID: <CAK+_RL=cGSmxb8hwb3ayyjwf4OENq6_sYYqgepoZJFYPDfVNvA@mail.gmail.com>
Subject: Re: [PATCH 13/22] bfs_add_entry(): get rid of pointless ->d_name.len checks
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Al and All,

On Wed, 20 Dec 2023 at 05:25, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> First of all, any dentry getting here would have passed bfs_lookup(),
> so it it passed ENAMETOOLONG check there, there's no need to
> repeat it.  And we are not going to get dentries with zero name length -
> that check ultimately comes from ext2 and it's as pointless here as it
> used to be there.

Yes, you are absolutely right, of course -- I must have looked at ext3
(I think it was ext3, not ext2) code at the time I wrote this and
assumed that it was necessary.

Kind regards,
Tigran

Acknowledged-by: Tigran Aivazian <aivazian.tigran@gmail.com>

>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/bfs/dir.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
> index fbc4ae80a4b2..c375e22c4c0c 100644
> --- a/fs/bfs/dir.c
> +++ b/fs/bfs/dir.c
> @@ -275,11 +275,6 @@ static int bfs_add_entry(struct inode *dir, const struct qstr *child, int ino)
>
>         dprintf("name=%s, namelen=%d\n", name, namelen);
>
> -       if (!namelen)
> -               return -ENOENT;
> -       if (namelen > BFS_NAMELEN)
> -               return -ENAMETOOLONG;
> -
>         sblock = BFS_I(dir)->i_sblock;
>         eblock = BFS_I(dir)->i_eblock;
>         for (block = sblock; block <= eblock; block++) {
> --
> 2.39.2
>

