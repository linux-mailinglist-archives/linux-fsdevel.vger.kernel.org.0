Return-Path: <linux-fsdevel+bounces-4756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E39128030AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 11:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AA31C2036D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30D224D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pBTtMaNk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C338D7
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 01:18:26 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1a52aecc67so258318966b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 01:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701681505; x=1702286305; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qXAi5NI2MrW3Fatk16RutSorqhrUvDxDYgQUDzoTfbM=;
        b=pBTtMaNkFYJXWT8MvFNiQDVfo4JW05flMrS9IbSYHs1e8RO083Nqts+x0qd6aa/vbQ
         otyzFHXgxj00BydGqE611hGKDiArr/+gC6CVEWD1RHjwZUYFzADhrvK92+VEVIl8GTNS
         UF3mLqEBSUxFqJ/UN6WX0FPnVXFvzIGMvIx1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681505; x=1702286305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXAi5NI2MrW3Fatk16RutSorqhrUvDxDYgQUDzoTfbM=;
        b=wp/Au92zGdojW8tMV+8AHa3/Erj+1fW5VZrsa2sUdDJkp/AazWf3wN96txCctkn+09
         SabhsCXL37URfNTtBWrMi2a+DUE1rAEYT/MFzIrgNfEpKV9cTOB4iDmhmlWreynzRLZ5
         k+P6b66wtPU2ZtwVNgaurcc2tBIngYT3unJ1IHetpCOiCTeZoa54QUXF/PZv/x7oP+57
         Z4N2a4E+Z40BArtq0krvJFyyeeyiqhqzhD4b7BK0i6mqnK+YjR1+bKK/D1Anoja7iDl9
         OC2DQUUhI6nQ/8Dw8qTlidzzFENbGK85xM8+lecFkZ96UTRIyL5Mx8v0d7ooljCL0a0O
         7hMg==
X-Gm-Message-State: AOJu0YyPGQCbs/6n9kWPgeiMm9bdPBD55jf+L/ZXYt2jmCuSCp28/t3L
	L+nDZqR3xsObl2l7Uc1k0hsDzIEGCHfz6jvn000iG4n0+kFMxh1NTY0=
X-Google-Smtp-Source: AGHT+IHEEGkN1fICudbIMnSmiwiXlbJEyZRDhNcoe/EUi/R4BiPvNP6hh/8OuUPPci9oaSihwOyS1tQM2RXeEl//EYE=
X-Received: by 2002:a17:907:1719:b0:a18:a4f6:39e6 with SMTP id
 le25-20020a170907171900b00a18a4f639e6mr2909772ejc.72.1701681504683; Mon, 04
 Dec 2023 01:18:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116075726.28634-1-hbh25y@gmail.com> <CAJfpegvN5Rzy1_2v3oaf1Rp_LP_t3w6W_-Ozn1ADoCLGSKBk+Q@mail.gmail.com>
 <27ad4e0d-ba00-449b-84b9-90f3ba7e4232@gmail.com> <ZWovK12GaC-_Ya0Z@redhat.com>
In-Reply-To: <ZWovK12GaC-_Ya0Z@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 4 Dec 2023 10:18:11 +0100
Message-ID: <CAJfpegt4+W2N0UW=6JtCAhVdkJisy5Q0+=T19fkQBDcRxjAn4g@mail.gmail.com>
Subject: Re: [PATCH] fs: fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Hangyu Hua <hbh25y@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Dec 2023 at 20:08, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Dec 01, 2023 at 10:42:53AM +0800, Hangyu Hua wrote:

> > I think setting fc->dax to NULL keeps the memory allocation and release
> > functions together in fuse_fill_super_common more readable. What do you
> > think?
>
> I agree with this. fuse_fill_super_common() calls fuse_dax_conn_alloc()
> which in-turn initializes fc->dax. If fuse_fill_super_common() fails
> later after calling fuse_dax_conn_alloc(), then cleanup of fc->dax
> and other associated stuff in same function makes sense.
>
> As a code reader I would like to know how fc->dax is being freed in
> case of error and its right there in the error path (err_free_dax:).
>
> I think I set the fc->dax upon initialization. Upon failure I freed
> the data structures but did not set fc->dax back to NULL.
>
> To me, this patch looks reasonable.
>
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

Applied, thanks.

The patch is clearly correct, so I have not major issue with it.   It
just bothers me a little that we have two cleanup instances when we
only need one, but I bow to the opinion of the majority.

Thanks,
Miklos

