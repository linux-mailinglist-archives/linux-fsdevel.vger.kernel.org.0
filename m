Return-Path: <linux-fsdevel+bounces-2455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8317E614D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 01:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B9D281286
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 00:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7D536D;
	Thu,  9 Nov 2023 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdTxfrx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462C363
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 00:12:29 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0FC2594;
	Wed,  8 Nov 2023 16:12:28 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507ad511315so409485e87.0;
        Wed, 08 Nov 2023 16:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699488747; x=1700093547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oxRjndTtkJZetvfezkXF/2987ikg4wY/3660b2uWMtk=;
        b=VdTxfrx41ziQy4Nz7BCYpyno8cfIsO7U76xciSyVgh5a8B23uNs3Go3k9HEj48SwVm
         8NleB38sE2fmXdqAmEKcZR+acVFCpHJywyXXtHAdqZw+X9LgqVGI5qF2fLq5Y724uZku
         fEujXwZT7I1vkZLNaYWk35UYWMHVyqvMZWywv5PTYU5RLSh90JKMQnSsV0XcRPufKrVC
         YSYo6U1E3PdNWMoIjaCErkRR1ioaHFxgy+lY75T77C5lLZbU+G3i/IFBGUMHFy9a3t8c
         8EJL7k2Z0ymCWZb8DqgE/7l0AmzStPa8vgszGR1TohOMWWAiY2V4WTfjJNgi92p0Tc6x
         q7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699488747; x=1700093547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxRjndTtkJZetvfezkXF/2987ikg4wY/3660b2uWMtk=;
        b=ZIJ0Z3/30m//Txqpj0+P+i43k0Rb9BJvYaRSE7Ml31CUFh5wxO8Id8TZbfnfeMsB3U
         WsP27Ljl+gMeyHBdrh25hussO5g+w8cj66WeuCiZy9EwpFk8arj/o7EW6l5+CsvKEaxG
         pE9PHPe6QR8AANjlb+uXCWEjLI8N5RHBIS1Eh3sylxACQB+8CjaIRWKazBO0bHOMP6Ov
         9NkHqM5gXClAUqnqcW5Tlhm98nc2uV6rq9FeVJU+8Z3rGhfYFO9VvzoPPgDyhwDG8HAP
         w1pyLD06nXunh0uswo4APjYqyByb42qZVMOYfO9CbaunYrvfGjN2Hmg+FR0Ksf9t2TuO
         ubAw==
X-Gm-Message-State: AOJu0Yw1H80Pn79WauonKupGxBfBXCWgvTEDJJ/a4fLavXcFWGfw5ZtK
	qsIphDJri4yPl6sdoiBMDgH10VpTKO57Co2AIYjeMv1UphY=
X-Google-Smtp-Source: AGHT+IGMym6s82sHBjvRZ1gVgP42jaL1JmjVcnC8voSpb7JFI9R5aRcHobWV5Dojv1Zry9WdFGNjuVaBWNGJSNkxkfg=
X-Received: by 2002:a19:6713:0:b0:508:269d:1342 with SMTP id
 b19-20020a196713000000b00508269d1342mr109419lfc.35.1699488746448; Wed, 08 Nov
 2023 16:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107212643.3490372-1-willy@infradead.org> <20231107212643.3490372-2-willy@infradead.org>
 <20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
In-Reply-To: <20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Thu, 9 Nov 2023 01:12:15 +0100
Message-ID: <CAHpGcMLU9CeX=P=718Gp=oYNnfbft_Mh1Nhdx45qWXY0DAf6Mg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: Add folio_zero_tail() and use it in ext4
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	gfs2@lists.linux.dev, 
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, linux-erofs@lists.ozlabs.org, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Andrew,

Andrew Morton <akpm@linux-foundation.org> schrieb am Do., 9. Nov. 2023, 00:06:
> > +
> > +     if (folio_test_highmem(folio)) {
> > +             size_t max = PAGE_SIZE - offset_in_page(offset);
> > +
> > +             while (len > max) {
>
> Shouldn't this be `while (len)'?  AFAICT this code can fail to clear
> the final page.

not sure what you're seeing there, but this looks fine to me.

Thanks,
Andreas

