Return-Path: <linux-fsdevel+bounces-1824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9367DF366
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 14:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26132281ABA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B4712B87;
	Thu,  2 Nov 2023 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Kem/UYOn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8E79EF
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 13:13:50 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B6FD7
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 06:13:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d2e6c8b542so135283566b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698930824; x=1699535624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=95PFVOIkXqnYZ/SCfhZoiqXQ1+uwDV3bDGyodIUSrpU=;
        b=Kem/UYOngpekeWlxkMHsyeNS7RREt/L+iE6z9P6nvtNDJY9meAAZw0HC1Il4UEjoLy
         D9sT7UiWbcshuVmlzVtwfPXy1StlXFfe0XU9/bpfwGPhLDxFDepjOdqAgVd7oell9rga
         PeVu8YWNxhUeE/MTxB3JzAvXcprHeszABhuAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698930824; x=1699535624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95PFVOIkXqnYZ/SCfhZoiqXQ1+uwDV3bDGyodIUSrpU=;
        b=pVpxySU5Yj+9OuPShA78Wi9Zyh3w3/PVEOwHKX9mJ62bOQ5P+AfWR0OSFOCoz/l4dC
         23uCJMvqwbKRhRgo1NhFotPHPVQ5bJkXLF1A1/0ITT9WANGSz5m1BCx8JLlRX4h+TUn+
         6aXwfkoMDFXFZgbHLVL2kXYKtOe4kZopRhsLZj8cPEg5FiK4Gy7/WyULtJc9CWZEMgOC
         lb9E0LglryHG9E0JO0hWcTaQHyMsDNoo1oKtIvVIvGGg9WhUAuf3XPFeb9WpgCQbbb2l
         xRQd/bSo2ui5ikJg5Jr3T6zkUnMnLH1BIjulg5SpHOQZ+5mHVXNEbAywkptmRV7EpJPu
         zRhQ==
X-Gm-Message-State: AOJu0YwwcEvAfgBHKl5QzKC8ALKiGbQdszYfNC7/ulxx/I4H/buDDQ0N
	aUo3xUdJhoEv/B38lEK+e+aUzSSPZRiManjUUeJlkA==
X-Google-Smtp-Source: AGHT+IFXYrUdCv6sbA3tu0dHhKgZl2TEDOa2BIlaydwCH74noXkSn+JEp1vUTGBdVxrM2OyA6wm6VcQpP6Jc4Y+iUIs=
X-Received: by 2002:a17:907:2cc3:b0:9bd:7f40:caa5 with SMTP id
 hg3-20020a1709072cc300b009bd7f40caa5mr3537361ejc.77.1698930824456; Thu, 02
 Nov 2023 06:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
 <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com>
 <CAOQ4uxjYLta7_fJc90C4=tPUxTw-WR2v9du8JHTVdsy_iZnFmA@mail.gmail.com>
 <CAJfpegufvtaBaK8p+Q3v=9Qoeob3WamWBye=1BwGniRsvO5HZg@mail.gmail.com>
 <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com>
 <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com>
 <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com>
 <CAJfpegtr1yOYKOW0GLkow_iALMc_A0+CUaErZasQunAfJ7NFzw@mail.gmail.com>
 <CAOQ4uxjbj4fQr9=wxRR8a5vNp-vo+_JjK6uHizZPyNFiN1jh4w@mail.gmail.com>
 <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com>
 <CAOQ4uxja2G2M22bWSi_kDE2vdxs+sJ0ua9JgD-e7LEGsTcNGXw@mail.gmail.com>
 <CAJfpegt3mEii075roOTk6RKeNKGc89pGMkWrvVM0uLyrpg7Ebg@mail.gmail.com>
 <CAOQ4uxipyZOSMcko+V+ZxGZwAgKVwWTUeoH79zqtMqbcKSnOoA@mail.gmail.com>
 <CAJfpegs5m-7QapX86CEiyy5oDzJQox6QsWjcLeegMV9OMbkBrg@mail.gmail.com> <CAOQ4uxjc6B2kXvbnbYPNCr8+ysFCoH24s+3fFa_Xkapyb9ueKA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjc6B2kXvbnbYPNCr8+ysFCoH24s+3fFa_Xkapyb9ueKA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 2 Nov 2023 14:13:33 +0100
Message-ID: <CAJfpegsoHtp_VthZRGfcoBREZ0pveb4wYYiKVEnCxaTgGEaeWw@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Nov 2023 at 14:08, Amir Goldstein <amir73il@gmail.com> wrote:

> Just to be clear, at the last close for an inode, we would check
> if attribute cache needs to be invalidate and the inode will return
> to "neutral" mode, when server could legally switch between
> caching and passthrough mode.

Exactly.

> EIO works for me.
> Just as simple.
> Will try to get this ready for early 6.8 cycle.

Sounds great.

Thanks,
Miklos

