Return-Path: <linux-fsdevel+bounces-41373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5094EA2E649
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 09:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6D7188A9D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 08:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9631C07ED;
	Mon, 10 Feb 2025 08:21:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CAB1BCA0C;
	Mon, 10 Feb 2025 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175699; cv=none; b=D3XW6ey9+DHkBYAs+ynlEt6VrdYqI+C0WHZBBuMZMlCVbnTsKsYUfldvFywYjb7A0P2yTqkITk9j3v8MSk+cXEjFagPxKJBXhhFOa9exCYnhjcbtfvzJOeE+Tdwd9qxaqdhdO8p+hH9LYVjPXADDNsMOV5beuTNXIi9JPWckZng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175699; c=relaxed/simple;
	bh=KDECpLDpVXCMMIaSdKYUva9Wu6pl5LVgp0seK9uaOJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpVKfeCeZVpFZVac0AESJ7LWGEl8XLZFwKp1S4ldF5Zh2pK+91nVpjLUhX7ma717M4jXV7r2sYrN50kU1ntCy3DI+1H9Ri0Tb7qjlivSLhYHF2k/YEqZj8xc9Xxhu4x27Vj+HytEZ6KuwJsM6So25ugW9VoDgru9ka2JXJ64gU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4ba79f6c678so1172395137.3;
        Mon, 10 Feb 2025 00:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739175696; x=1739780496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhHr3SiuxYFOMdjENNAkHvqJkCQYF9wJd/gtVC6NjJk=;
        b=e31AEZqW+3bsSY56xWDTwdXx2QngxIS6ZpaYbVOu0xDJ+IX3RBM7j2ZPEy2/7UISdT
         H8e+vaJmQ34tN+b8DJHMBfNQ6LtZzUuvSxl4jj4Qg+YLYUMMqmZ5NuKBKZVPd7dzQu44
         jdC3LrppCw7Y91OMMyQgO5bLbmn5cWNQniHrfDHasu8xFzfhZGRwbwE9C4nXvZI1A/GV
         74khzMiM69k06w6YYrmw/ww90U7t3MWpUjJUZt1gQfJCUAYR5YmqGinzOyPfS4osEm4J
         xltrtZjdX5RkDAoDDDFzMFZdyujCt8ehR+yuO+X46FmaXWKsJ8NQv1f0oupKXem8lAwU
         4P6w==
X-Forwarded-Encrypted: i=1; AJvYcCVYNVVAVZR5yfHQ2UQp2oKwEy8eb2vunLSVnZ3vOK38u/GxsojFuyxvPgdZKipwA65WZJ/v0QCVHYLPG1uu@vger.kernel.org, AJvYcCXIHSpKNlJeMqP5k4LxBXygdqsgl1ZjbF2TXxsQJKFDCyAIii8TJgBEnHRGPPe8iIyzrrBk3nO0uhIZ9zmi@vger.kernel.org
X-Gm-Message-State: AOJu0YxFUOs1IRrwJ0l5V5FWBFAdX7gVkJ4g1IZijNaDA3J6tbjPSvD5
	+/24/CgSiwCP/uPR8Z2dF/iv2/NTLHWgEPF75LKNot9FRIyFUl1QBX2OoSn5
X-Gm-Gg: ASbGncu1SIFyAJEpZXbF2vZ6HWv67YWkRY6klliFqIYJZdDbTMa61YBofkRBxHeKYNW
	JmTzRCoriJLkr2ThbB2V0zNYUgCOTmf6NOdIF4rFDZvfu49yCmnwxgWVhLHCIgZG/JQVdYsgNOM
	6pOjFEKIs+dZWWu+Ho6N/eZbG3abRjVn6/SiILyNaJE8jitxWXdpxgZf7+ZE5aUSn2vApLWxEj0
	gq0kf7GvlBIKHeutEzRJ+50YIMlaXMzYHyX1jQt6y2wrGDsgtidbV7UFrIusOfJJOJlLbUlNPxf
	khqCbWDMuq2mENekabd+zVxwk/vYfV2JJ/6NlevKbjdOFMXGhDJUbA==
X-Google-Smtp-Source: AGHT+IG6xyE/4CUsMxBjwjlbsofimLS/AaxJoyqG26619oks95ZTybHYIq9tr3D2CWH//1Ie5s2zjQ==
X-Received: by 2002:a05:6102:2c8a:b0:4bb:ba51:7d47 with SMTP id ada2fe7eead31-4bbba517fb0mr3151325137.4.1739175696011;
        Mon, 10 Feb 2025 00:21:36 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bb66368bfasm827846137.28.2025.02.10.00.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 00:21:35 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86703c58149so971869241.0;
        Mon, 10 Feb 2025 00:21:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCViEFCvqf+JEufSJxt3jBriFi01Dd0HDOGrWDU8WmNSLgfnKFbI5klAQIxDhWmEau0uRc3GV1DEnP7jtI9a@vger.kernel.org, AJvYcCWtVVoMrgaT8SaQ7knNcQzcSHVCHwwIbUrnfgjGhILDH/eOHUs4r2J5Teu9RTePEgtZRDMcG2+oyDMHnwk5@vger.kernel.org
X-Received: by 2002:a05:6102:41a0:b0:4af:fa1b:d8f9 with SMTP id
 ada2fe7eead31-4ba85de2b37mr7775516137.7.1739175695144; Mon, 10 Feb 2025
 00:21:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208162611.628145-1-mjguzik@gmail.com> <20250208162611.628145-4-mjguzik@gmail.com>
In-Reply-To: <20250208162611.628145-4-mjguzik@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Feb 2025 09:21:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWgjrYVoMyLHWa6YUhrEpQ9uk6rWj30i=4sxGxXaV4zNQ@mail.gmail.com>
X-Gm-Features: AWEUYZkftlHLM3_AKYYRaeuxHA4t5IjP0PKD2pUcM0112QqENWtvcZjRBkT46cw
Message-ID: <CAMuHMdWgjrYVoMyLHWa6YUhrEpQ9uk6rWj30i=4sxGxXaV4zNQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vfs: use the new debug macros in inode_set_cached_link()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mateusz,

On Sat, 8 Feb 2025 at 17:27, Mateusz Guzik <mjguzik@gmail.com> wrote:
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Thanks for your patch!

> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -792,19 +792,8 @@ struct inode {
>
>  static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
>  {
> -       int testlen;
> -
> -       /*
> -        * TODO: patch it into a debug-only check if relevant macros show up.
> -        * In the meantime, since we are suffering strlen even on production kernels
> -        * to find the right length, do a fixup if the wrong value got passed.
> -        */
> -       testlen = strlen(link);
> -       if (testlen != linklen) {
> -               WARN_ONCE(1, "bad length passed for symlink [%s] (got %d, expected %d)",
> -                         link, linklen, testlen);
> -               linklen = testlen;

This is a (undocumented) change in behavior.

> -       }
> +       VFS_WARN_ON_INODE(strlen(link) != linklen, inode);

This change matches the one-line patch summary.

> +       VFS_WARN_ON_INODE(inode->i_opflags & IOP_CACHED_LINK, inode);

This (unrelated?) change is not described in the patch description.

>         inode->i_link = link;
>         inode->i_linklen = linklen;
>         inode->i_opflags |= IOP_CACHED_LINK;

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

