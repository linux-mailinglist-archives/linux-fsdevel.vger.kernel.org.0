Return-Path: <linux-fsdevel+bounces-3446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 524837F4A06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 16:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFBBCB20EAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38E44E62A;
	Wed, 22 Nov 2023 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bVMz+7jE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4921A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 07:14:49 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5cc3dd21b0cso10623237b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 07:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700666089; x=1701270889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qXrN2Z+btaH3S8Seo0og7ZDAgKyAbSKX6WBPHRe3mP8=;
        b=bVMz+7jEtvmdQrbHzXtiny6y30UeMaysh6CZQ0t+lp8xdwQ06YOXiuy8aY15PElSJ/
         nFYCogzAw1PVG4oYMgz2S2Jzhmz0W99WOkJR7QIKThIKAtkK6kYOku0fjTnJVhOBwCwz
         FFjpBwjMVCDn/YZcEJh6ZX9XfkXv26kSyMEOE3DGv0pwFURXVyOyi77sBjyVVth1nGyT
         16UCxhit1Xkk5dq7qx42HKcV/X8SWtNtdAp+SLbBLyaZUC1acJEHZR1zqWOVdB6OQ/UF
         VEf9UiPH4oofvLq5PRtURITEdg3wTxpQ1srJz1BoJ62oL0Syoky2hndYtc95/lq5ra/U
         2fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700666089; x=1701270889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXrN2Z+btaH3S8Seo0og7ZDAgKyAbSKX6WBPHRe3mP8=;
        b=KqHkG9R9jxmL1tzK4tXFBzb0v7n9/BOhXahl5PfSjMCyXeN7/F1RtBEf4R1wgEti1a
         cIK4QahAr6zy2J8L1IEHH5pdGgXzDueB4KPhidwcTw7biruDmcCie8UH+Sy66Ef2hnAm
         puij1FhOPOEAEcrI5pRPaZ2t9kjq/qtS9DCqBZip2LNdeuCnH5rIHryc9gvZ0k2W9Pjn
         0mw6b0b38ZC7AbTUZhxDDRQnXOQAeL0xQdVZ3WKZuaxtCf47OsZT9dvso3A5z9b5e5qt
         EioFqZMBZZqva8XHgNdrCSq5QImaM9uBuIf0pUx7PNT/rgqsS3Q8m46b6FD6gLcWxEgT
         TZNA==
X-Gm-Message-State: AOJu0Yxlpd1AIRAUrmynJfqAbOn3TuO6pH8gIvsonAWRgu6196e6ZRfe
	dX/GdN4AY+QHEDPfryrJNDPXTg==
X-Google-Smtp-Source: AGHT+IHUSwNYmVURFV6yXQpIYf4FviEhYm4keQXR1RUq0qF8P1dbYC86rk8R+aOuwmh/85wMvxF3VQ==
X-Received: by 2002:a81:a089:0:b0:5c9:d870:cb18 with SMTP id x131-20020a81a089000000b005c9d870cb18mr2661259ywg.21.1700666088802;
        Wed, 22 Nov 2023 07:14:48 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m124-20020a0dca82000000b005cac0365acesm505351ywd.22.2023.11.22.07.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:14:48 -0800 (PST)
Date: Wed, 22 Nov 2023 10:14:47 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH 3/4] mnt_idmapping: decouple from namespaces
Message-ID: <20231122151447.GA1739682@perftesting>
References: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
 <20231122-vfs-mnt_idmap-v1-3-dae4abdde5bd@kernel.org>
 <20231122142657.GF1733890@perftesting>
 <20231122-runden-bangen-787f0a1907ca@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-runden-bangen-787f0a1907ca@brauner>

On Wed, Nov 22, 2023 at 03:34:39PM +0100, Christian Brauner wrote:
> > You accidentally put a ; here, and then fix it up in the next patch, it needs to
> > be fixed here.  Thanks,
> 
> Bah, fixed this now. Thanks!

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

