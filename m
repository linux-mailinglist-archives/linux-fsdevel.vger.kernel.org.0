Return-Path: <linux-fsdevel+bounces-5852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AF78112DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6903F1C20C88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24292D040;
	Wed, 13 Dec 2023 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rG7z3hdl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE32C870
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 13:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD7CC433C7
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 13:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702474177;
	bh=fE5ARQCDFJzsAwixZpHv72uJIODa0w/TTFKLjUBuMo4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=rG7z3hdlzfuDji8AK5b41O9W4JRm985Ke0jYOoNbiZGqaftOYKWxQXcq9F8M3R2Oo
	 t3l9eApVIyqvyKs9rUOI/Iw6aCBIOb0ckOVVVVfq9l89MH6G+PgasGE/D5vxWQnhAc
	 EJaVLEdFQb5u+EjTJTmpcNwY8EbrATSBQaFuUhh/JbCjIHgDVxpdUOkBjMsd1JHrMa
	 R1F+NJUlbnMlhebL4MarR0mxPilS2nUkzt1SGV8ls8YhISRAVqrWzLsYUAvT6HMiKF
	 8iMW1uYzbDPwhNTG0K+0bH4BIyX5KHvKDoceGreSMFnNvPVFU8OFmgQ35wEvyoVGsq
	 rUSfulw3gtClQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-20316647099so773932fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:29:37 -0800 (PST)
X-Gm-Message-State: AOJu0YySlVVMicF4oA+niQlOvkDbWIplCx+Gj9b6V7+vlTCYr6zix8NQ
	KDlGtbbKt6j+DbEEF1Jgcb4m5jLJwohiYU0v6JQ=
X-Google-Smtp-Source: AGHT+IEfYX2MxBleBLOZtxqcSi+HaPw4KQusgu4N8puk3bPfqu338v5OrE11/pN9QJUBbCYR9S9AU1K3Bp5nU9LxVPs=
X-Received: by 2002:a05:6871:7a02:b0:1fb:684:220d with SMTP id
 pc2-20020a0568717a0200b001fb0684220dmr10846152oac.48.1702474176715; Wed, 13
 Dec 2023 05:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5dc6:0:b0:507:5de0:116e with HTTP; Wed, 13 Dec 2023
 05:29:35 -0800 (PST)
In-Reply-To: <20231207234701.566133-1-sanpeqf@gmail.com>
References: <20231207234701.566133-1-sanpeqf@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 13 Dec 2023 22:29:35 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9rFNCsGE9OWPAG1hpbGHYihqEsX6Pb4_djyg0uPCsjng@mail.gmail.com>
Message-ID: <CAKYAXd9rFNCsGE9OWPAG1hpbGHYihqEsX6Pb4_djyg0uPCsjng@mail.gmail.com>
Subject: Re: [PATCH] exfat/balloc: using ffs instead of internal logic
To: John Sanpe <sanpeqf@gmail.com>
Cc: sj1557.seo@samsung.com, willy@infradead.org, linux-fsdevel@vger.kernel.org, 
	Andy.Wu@sony.com, Wataru.Aoyama@sony.com, cpgs@samsung.com
Content-Type: text/plain; charset="UTF-8"

2023-12-08 8:47 GMT+09:00, John Sanpe <sanpeqf@gmail.com>:
> Replaced the internal table lookup algorithm with ffs of
> the bitops library with better performance.
>
> Use it to increase the single processing length of the
> exfat_find_free_bitmap function, from single-byte search to long type.
>
> Signed-off-by: John Sanpe <sanpeqf@gmail.com>
Applied it to #dev.
Thanks for your patch!

