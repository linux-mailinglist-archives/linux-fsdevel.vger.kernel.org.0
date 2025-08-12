Return-Path: <linux-fsdevel+bounces-57467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAA4B21F71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB797B1055
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 07:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F2D2DCF62;
	Tue, 12 Aug 2025 07:24:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC8A2D7803;
	Tue, 12 Aug 2025 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983483; cv=none; b=Kx7UUh7rJNtffjZv/OnLXVGYwKzmiIHEetCklBmm6owY2FpIDf/Tm7Od3epx3w3Sih4fx5pEwdj+5xC1sPLp+8X3MceEtS4NchmmSHnAy1igPdwFug/zPqrX2uii3D7oiZIFwY3tW9iYVb59s6qiCh/c1oQnTC1nOV79Mk1N7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983483; c=relaxed/simple;
	bh=F1+sEh/R9brLB1dIm7iUxPhrrN4R39Dy8Uv/ot60slI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oW8lv9c49RTOrmM4qw8pnCr5KlgKFjgSBI/2gamMbBzthKyLP4+Sxo/F2c/1JZz+pjg6bFOB/x1THz3b7cW3508ydbJwTwY2KWHi3BdDUdYrBW3zwsUlCZxJTaS0KSS4RM+IYMPfmJbAPa62UG9BkhfpPp9OyVpHR+nEg0NndnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4fc1a5e600aso1872657137.1;
        Tue, 12 Aug 2025 00:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754983476; x=1755588276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOtePJ+whO1RZk6W6FcCDIfHBFaG85SKwR/jfH7mXsk=;
        b=SUoNFS61n34YXTByb984/BURL7m8KdyItK3E062VixEs8PEhVe88Yaj0Gp2Kq1wLO6
         oWDuD9yKgpxgFmL2blGOJwK5ep4B18IRFvNjJydfeIb/TtQDZaCEST3XFejv6Rv/yzFW
         LSC1ghPJY864JIafv3cP9a41jgqkwEvSb9voytam1loibWEModmOCqazMCNKq3Tl/86W
         1sxE6xK75zZk8CsQq34BRoAdmLxbYfnM0o6Hpxq5rZ0U1+zy1IDZtU4XqPhyTJxDy6a5
         ubLORK+cUvAwVyYoQQx8mnTvHZk6mLHhRKlaW/wjDz+iH2qew/auOxzdB4A2flABIl8n
         XYIw==
X-Forwarded-Encrypted: i=1; AJvYcCURLg0UDUiW04htSRaEjEZv6xdX78dGNa/rvmXAukm+1Y8P05v0KCWdprxXXZw3p1sG0eKYjhwZJKWDWta+@vger.kernel.org, AJvYcCUl908DYraWTylU2faiA2L5OekRAdCbyVB5+LRRXNjRQ/Tr93vzdajPhOUNCwJwwWHNMGgTRl5UyZRb@vger.kernel.org, AJvYcCVX7Cxg2bXZEnyBtvFljjtki1kl6uV9u9b0j23omEQXIKB41m4X60J5EE33TF/5Yc31FKTjn2JfYcZ2ptkt@vger.kernel.org
X-Gm-Message-State: AOJu0YyQiMQ4D+Hm6BDLVktCH/4+nm0URWYAMCnHAm6y3H4urro0+s7a
	gpNGSRm8ix3Azie26fkKoLq+NdPmxuW/7OXH26moYZN/qQgvwTGSB3HJSLHD5tm2
X-Gm-Gg: ASbGncvm4iUjyhgJV+3YZA+e8dK1cUCuKEaoR+3cUaJoMUh4LWTjvmv7qOcfTLfiK2Q
	JsF54a3YWFzKFmL5cFSrbhjWimbGKAJcAaaaC25lba1oqi9OfVY0u5/gft3Jq8Qn+qzepNBoU1u
	E4WF6zMdM3MMKkMrAnFvvt0wk861qCOQA+pk65V6C+z/h3sgQehSmdYMJofb2aGQUXLZA4MpV93
	sWkoeFl2nxlP6b/9n2i9OTR6o7Bvmbqn/mq5dO5DXRUeEGWrbGHMCUrz+ZhHcOHndJzzenAvwhc
	daEriuzBNQ2O0cvFQ1Py1w9efxt54CWuEWs8zzuWfe6njccE7LZv7c8RzZOo2F8q5yr0TgftDx1
	XHQpcRgWXY4aAPxlgoKFWi5qtiU7vtxdxVol3+X6lK2K32nxAJehxGWNZC02F+aXN7YDIKnc=
X-Google-Smtp-Source: AGHT+IFc8Niv3i50vfcXctqOM9+EaZ22zdjVC0swY9qmcjEuQX8hCa12CQtuWuf4JLS0mLRf1jyUow==
X-Received: by 2002:a05:6102:809e:b0:4e6:edce:4b55 with SMTP id ada2fe7eead31-50cbcfdaf30mr985804137.4.1754983476017;
        Tue, 12 Aug 2025 00:24:36 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5062b6519e7sm2134403137.13.2025.08.12.00.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 00:24:35 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4fc18de8e1bso1720985137.0;
        Tue, 12 Aug 2025 00:24:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQ9+AhqXAYlLdeStixqoH8hsg70AGD6hWIKwvacfzPicalBC+TmxZd0C/KHXYy5YhzE6lN+neKSSPuwlly@vger.kernel.org, AJvYcCViHOCBcmIi56mcTkFyTZiVx8g2+j4lBemehmj7IKYn6tWER1GLPD6J/7RRP1Wte761HFqI+rClxRf8@vger.kernel.org, AJvYcCXcWxeDX/448yOHwoPy83mH0dnjOwlMAH/PXhIh6YJuGQHI3B/egynRFrTmZzITIkWplSAhPo5fx7/Lxhrv@vger.kernel.org
X-Received: by 2002:a05:6102:3749:b0:4e9:b899:6f4e with SMTP id
 ada2fe7eead31-50cbd4c9427mr1106337137.7.1754983475510; Tue, 12 Aug 2025
 00:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810101554.257060-1-alexjlzheng@tencent.com> <20250810101554.257060-2-alexjlzheng@tencent.com>
In-Reply-To: <20250810101554.257060-2-alexjlzheng@tencent.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Aug 2025 09:24:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUFn1aWxdgb__NY4yr1E8k_zSaaDzmkUBfyDV1mWawTMA@mail.gmail.com>
X-Gm-Features: Ac12FXxppZi-71w7rSLDFISw5f4QrRnM71zGAobEkqyavB6YoHT3FR5Y1ocCRLs
Message-ID: <CAMuHMdUFn1aWxdgb__NY4yr1E8k_zSaaDzmkUBfyDV1mWawTMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] iomap: make sure iomap_adjust_read_range() are
 aligned with block_size
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinliang Zheng <alexjlzheng@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jinliang,

On Mon, 11 Aug 2025 at 18:49, <alexjlzheng@gmail.com> wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
>
> iomap_folio_state marks the uptodate state in units of block_size, so
> it is better to check that pos and length are aligned with block_size.
>
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>

Thanks for your patch!

> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>         unsigned first = poff >> block_bits;
>         unsigned last = (poff + plen - 1) >> block_bits;
>
> +       BUG_ON(*pos & (block_size - 1));
> +       BUG_ON(length & (block_size - 1));

!IS_ALIGNED(...)

> +
>         /*
>          * If the block size is smaller than the page size, we need to check the
>          * per-block uptodate status and adjust the offset and length if needed

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

