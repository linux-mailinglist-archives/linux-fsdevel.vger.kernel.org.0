Return-Path: <linux-fsdevel+bounces-4786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DE5803A81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 17:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B243E1C20A77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1862E62E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXg7MdK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE8FA4
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 08:20:10 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-2868605fa4aso889900a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 08:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701706810; x=1702311610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5v9fiKvNxrHxTZifMWEDjJNTmIvNH4ds/WobwnfZFg=;
        b=CXg7MdK0ps90XQr4PsSbfSbn4FbvIBNRfIA3ubypIsKuCut+PBOLthLg+2xj11XwGz
         ZY7kMTSgXpTugImJwMsKHS6quREy6Lh91QWob1eXy4xJFiZXHGdcC3gre8knIDLXDgjN
         5FfvXglEZBvWN8t0rK3O8YB6f5fwHiS0Tq40lWjECv8OMbVcdzGoC+R4WuiFoFfFzwmM
         i4NzUlv+4cSTmQjeCcnDqrG5dve5oh2wB2DnMB0tvgbUoptxIbv2WkyA8sUs+Z+Dqm8g
         iUqpcoGkFX7Z7bXfM6Uy6aZwOYXlcluTkyJGDzlYSKz4JO1p83yl0NJeWbN4lSK1IwgT
         ewVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706810; x=1702311610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5v9fiKvNxrHxTZifMWEDjJNTmIvNH4ds/WobwnfZFg=;
        b=DX91bIy9MDLqyxcNNxTrpvpImLL3YprdZ/GHiInPdaH5JyxwZXAujU7xB02PoPvFm4
         l1nrLMsy70qrU4B7Wf2VvibVU01NinJQtbhImjwRS4PZsZv0BIA6JvWVGkjCqhPXKPo8
         yqV4JOILCGdx53blA9Wq1Sve9RKY4JPnJEN6fkALDzRVLdHUh/2QiU2ttAhkE/KDVPqv
         rqlg+RksavsDhwg7avqPyVimcUf5+fTBdjOFrA9UQkmCFZx1+4IbN1PZZgR9LOdAhN4X
         AIXMIc9GIm7K3IyRn+nFZaALyEgRU8/ZcdoIcLHDM1i6kAbVB3sY1KG13CD3n/9fOWm2
         FiMA==
X-Gm-Message-State: AOJu0Yzl68365wI9AbXpnk3J0eQA5ZPkzz+YEJzSkCXCZHW49K8NE3uc
	f6Z8WdrGx1HQ+9dTkE1qKLoWDuLQwBtPDK5erxU=
X-Google-Smtp-Source: AGHT+IHWyXNpxuR/7lsRKGW5hFbdvOJupqSZSqjuBnRqrfrr4T/1m60650fkojKZqw9/1r+P9Xvcvop1HYhmwYVO3RU=
X-Received: by 2002:a17:90b:5109:b0:286:6cc0:b925 with SMTP id
 sc9-20020a17090b510900b002866cc0b925mr1548610pjb.92.1701706810206; Mon, 04
 Dec 2023 08:20:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204022258.1297277-1-sanpeqf@gmail.com> <ZW3V1fmY0R2uD6tH@casper.infradead.org>
In-Reply-To: <ZW3V1fmY0R2uD6tH@casper.infradead.org>
From: Fredrik Anderson <sanpeqf@gmail.com>
Date: Tue, 5 Dec 2023 00:19:58 +0800
Message-ID: <CADi8-=qk=1kzPhzBDPNhD5J39HwjwTJx3K7=yHy-izFGf5iW3w@mail.gmail.com>
Subject: Re: [PATCH] exfat/balloc: using hweight instead of internal logic
To: Matthew Wilcox <willy@infradead.org>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, 
	linux-fsdevel@vger.kernel.org, Andy.Wu@sony.com, Wataru.Aoyama@sony.com, 
	cpgs@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your suggestion, I think I will be able to complete the
modification and test soon.

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=884=E6=
=97=A5=E5=91=A8=E4=B8=80 21:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Dec 04, 2023 at 10:22:58AM +0800, John Sanpe wrote:
> > Replace the internal table lookup algorithm with the hweight
> > library, which has instruction set acceleration.
>
> This is undeniably better, but why stop here?  Instead of working one
> byte at a time, you could work an entire word at a time and use
> hweight_long().
>
> Also, if you're in the mood for a second patch, free_bit[] is clearly
> an open-coding of ffz().

