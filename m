Return-Path: <linux-fsdevel+bounces-4578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA86800D4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 15:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E06B20C32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F286495C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIEyAoja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9111710FF
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 06:06:05 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d064f9e2a1so32133387b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 06:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701439565; x=1702044365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3RcVkJFEYiHUgvCHqc9Nf39XOlniymidgmq8tmdHJk=;
        b=cIEyAojaDqv2qYsKX4g1rtA7HWufo67D6KbbpPfj2FbxTvF/vv7mGHKCIW1um1JYNU
         n+zPFsMqgEj8eDS+4WYS1sIIK8IM54la7chYxC2IxNDfO6AzwxxS2dyTfrZCK6c6fXPz
         gjAj7b2CDXvcn2ib5muDGO58YudJC2jRjllMGu6QzP5loEX1+NItO+GX7VMGIzx0UydY
         L/WBv2lGvfCu8a3Uod8bbsnrnasdfVaa5/zZVjAfLzw0zNukxhkQ+dZN0Wu+FJiwXpwo
         8ubGtMUQysTGUn/9Uxb6ysttgRco2opHliDfsclk52xDcahEiAQ/fb8+CuzZh5pcNx8o
         A3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701439565; x=1702044365;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s3RcVkJFEYiHUgvCHqc9Nf39XOlniymidgmq8tmdHJk=;
        b=qZUlfMcz4uodxrsRIbQU9KqDnwxGBvdqOWcr0yNXyFYljS7gCTzbcRkgQkYU/UuWvw
         qpqv/g2wT9Kn4uiTKOzthJLUIoOtywwe+8Bo27ycqv3oufFRyHGsDWEtFDQnm6aY/9Uh
         26bLtOLNcW6gOiAnqGWNvh/K9OZYrzL8BCpAbXg40pY8O8jqeYH8fQL3Z4p0TNV13dTs
         Y4SprnvwQICXd7wSWc0UhpXza1NSgengs9OpAbNl05fBH/fWgoHYPlkUbVG3eArlykib
         idmyNmQ/UWaTt24QllsO5Ti5Php43jG1pfZtNF4DimIg9Yhe0BjDYXF1+SYmylv4Y2o0
         rh5A==
X-Gm-Message-State: AOJu0Yz5Pd64ti7owYZe0oBZAYCQzBFcUMnuPSXWfR7ja76HVv/3IA96
	x+ACxZpgUm+pblHxXqxWAZoaZNJ+9Ww=
X-Google-Smtp-Source: AGHT+IE9zUTAo7d77zYYleJDgkfQBYLq6ddaqe6gq0/VCKtXXQu99lt1BiEAbdkwSXgfbuavqfdlH717tXM=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:fab0:4182:b9df:bfec])
 (user=gnoack job=sendgmr) by 2002:a81:af28:0:b0:5d3:70a6:dd3 with SMTP id
 n40-20020a81af28000000b005d370a60dd3mr176963ywh.3.1701439564836; Fri, 01 Dec
 2023 06:06:04 -0800 (PST)
Date: Fri, 1 Dec 2023 15:05:56 +0100
In-Reply-To: <20231130.beetuo4Chuso@digikod.net>
Message-Id: <ZWnoREHBbcrF35PI@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231124173026.3257122-1-gnoack@google.com> <20231124173026.3257122-2-gnoack@google.com>
 <20231130.beetuo4Chuso@digikod.net>
Subject: Re: [PATCH v6 1/9] landlock: Remove remaining "inline" modifiers in
 .c files
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 10:27:18AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
>=20
> Thanks for this cleanup. Maybe add a (one-line) explanation?

Done.

=E2=80=94G=C3=BCnther

