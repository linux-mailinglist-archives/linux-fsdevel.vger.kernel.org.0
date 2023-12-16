Return-Path: <linux-fsdevel+bounces-6309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F53815889
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 10:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B675B231FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 09:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C953C1429C;
	Sat, 16 Dec 2023 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QYf9LmjI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243214018
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a1f47f91fc0so170350966b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 01:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1702719242; x=1703324042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=akCr113vjYPEL3FahpJRWWCEjIHt5RGMgKFyC+h42KA=;
        b=QYf9LmjIknvdVi7D+3+oc5pJZWc44zyjM3uwGLijarebRTKWP2AvEG6DA0dz24ePGi
         UELDHOmL6FsBv/1mJ7gq7fyXpJ8wj8m4IS9sD3BjXSMl+U12T6eb31BDIJD+iDGRHFOs
         uxYT4CAJ3bhsCzukbppDq0b2neA54aiKT9pLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702719242; x=1703324042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akCr113vjYPEL3FahpJRWWCEjIHt5RGMgKFyC+h42KA=;
        b=Rw6S8uR0Gil5OUJUOjlpC64RhxyxFxHNVQvUyKDkTTIyg4G87nxHNactQq54OBdPNH
         D6Yb1BFlm7FRy43DDOV0PDnUQYd9pIpn9BPi7lGLnGnwJj1x0xYvr1DKH6MurxfeFIxx
         7uuEPojuC+oE637I3bNnXF4VYvRM65F0KxeVXMwrjG2RG/T9f/z7Lv8buVACLJkB02DF
         GbsvBffis4j/3OjYxOemE7ef4ekcBt+ZOgS16v/WES3tphANAkMMLyobbK02suOZf/j3
         JGdk7jHAQxWbhl84nhr197SzhloXLY9AAHNawGS+Z5OuZr8YEwrhcoRiE1gl/SuKjqnF
         bZYw==
X-Gm-Message-State: AOJu0YxR2bJGGbnahGoo3SAAht0w+jPtvnIj2s5BuYxwgUXUOZHl5WQ0
	YGvrvb3ar8MIAYvL3RXjSPBkoSNCr5J6Ha31SjqL2757/raYSYz3
X-Google-Smtp-Source: AGHT+IEgbzl7MVWzxMPyzP5bQn/tP4gc78urN+gLkh6LXF9c0i2XfGXFZPyr3cVxiW4EsTEyughMUD1BHiBQy3Lv5rg=
X-Received: by 2002:a17:906:73dc:b0:a19:a19b:55d5 with SMTP id
 n28-20020a17090673dc00b00a19a19b55d5mr6264952ejl.101.1702719242038; Sat, 16
 Dec 2023 01:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXz39r4SR39DmPcW@casper.infradead.org>
In-Reply-To: <ZXz39r4SR39DmPcW@casper.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 16 Dec 2023 10:33:50 +0100
Message-ID: <CAJfpegvgTG3KvbLKX75twenOSxBEk2RjMyA1o9krOedm_zZWqg@mail.gmail.com>
Subject: Re: Why doesn't FUSE use stable writes?
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Dec 2023 at 02:06, Matthew Wilcox <willy@infradead.org> wrote:
>
>
> I'm looking at fuse_writepage_locked() and it allocates a new page, then
> copies from the page cache into that page before sending that page to
> userspace.  I imagine you want to prevent torn writes, so why not set
> SB_I_STABLE_WRITES instead of having this memcpy?

It's not as simple as that.  Fuse wants to do its writes independently
of the mm's reclaim mechanisms so that it doesn't get into the sort of
deadlock that PF_MEMALLOC is supposed to prevent inside the kernel.  I
don't remember the details, but the last time I looked this issue
(which wasn't recently) there was no feasible alternative to copying
the page.

Thanks,
Miklos

