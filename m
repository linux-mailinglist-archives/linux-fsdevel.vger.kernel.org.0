Return-Path: <linux-fsdevel+bounces-1741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CA27DE290
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 16:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46141C20D90
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6FD13AFF;
	Wed,  1 Nov 2023 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCAA12B8A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 15:02:40 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C9DDC;
	Wed,  1 Nov 2023 08:02:38 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a7b91faf40so69489257b3.1;
        Wed, 01 Nov 2023 08:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698850958; x=1699455758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeqpghJGIn+FJig0S4AO4Z/Kq8V9fOr8ACdyqDQ8PIU=;
        b=kKmoSBrTaHJTreR6+77TQZSCf1aDxCWmyWCdQUfTDx6g7l3rzEF0+ELSixuWOw7UCM
         I9+zH1Ec99IRXEFDcaol1nFdKUnvgiv/hHU9HBVSsObb0zD8xvOX39lb4hftht6a4xci
         Su6mwQDZbybV9ov9wbr3GGxzTJOsv9FpNPHH8kVI37Bi+7Ew8rsL+zCJ31RF9T3rOf8Z
         bN+hLyr7fHPTuobnyHZhMhMt2vudUpKnq0FHcD4dcqZsciDHJcD2iVyZQga/+/REdZdO
         aot9CgPRJuHrNIR5Xu8BSRCwc/5Bj+hmbUSiCKXbIQ4TGGqHcvGWm1YMVWJppi0fnr72
         3B/w==
X-Gm-Message-State: AOJu0Yytbxa3j+g9jO6K63B90xxmDdP1tme2Xr1CxCxHHqubbrus7b3Z
	IoUrm7rkgMq0mVtoTimpuYcGZcO5/z7zRQ==
X-Google-Smtp-Source: AGHT+IG/giQJiapQlJiZ0hB6g0O2l9o3+d6JvoEPG5DoKXhxME6J+54LE5egxkmwMCEykgOJGUWANw==
X-Received: by 2002:a81:b60d:0:b0:5a7:c641:4fd2 with SMTP id u13-20020a81b60d000000b005a7c6414fd2mr15154808ywh.10.1698850957731;
        Wed, 01 Nov 2023 08:02:37 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id s5-20020a817705000000b00597e912e67esm17882ywc.131.2023.11.01.08.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 08:02:37 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a7c08b7744so69506997b3.3;
        Wed, 01 Nov 2023 08:02:37 -0700 (PDT)
X-Received: by 2002:a81:e608:0:b0:5a7:baae:329f with SMTP id
 u8-20020a81e608000000b005a7baae329fmr13801406ywl.15.1698850957231; Wed, 01
 Nov 2023 08:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
 <CAMuHMdXpwMdLuoWsNGa8qacT_5Wv-vSTz0xoBR5n_fnD9cNOuQ@mail.gmail.com>
 <20231031144505.bqnxu3pgrodp7ukp@moria.home.lan> <CAMuHMdVKi=ShPUwTHrX0CEN2f9+jRXWymnKH=BiXTpmg857AJQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVKi=ShPUwTHrX0CEN2f9+jRXWymnKH=BiXTpmg857AJQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Nov 2023 16:02:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVfj5q_06cM3dXvNyfdNZQM=M=ocbG5XFpCp2UhVjjJ9w@mail.gmail.com>
Message-ID: <CAMuHMdVfj5q_06cM3dXvNyfdNZQM=M=ocbG5XFpCp2UhVjjJ9w@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs for v6.7
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Tue, Oct 31, 2023 at 4:00=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Tue, Oct 31, 2023 at 3:45=E2=80=AFPM Kent Overstreet
> MEAN_AND_VARIANCE_UNIT_TEST should depend on BCACHEFS_FS, as the actual
> mean_and_variance code is only compiled if BCACHEFS_FS is enabled.

And I really meant "should depend on BCACHEFS_FS", not "should select
BCACHEFS_FS", like is done in today's linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
fs/bcachefs/Kconfig?h=3Dnext-20231101&id=3D487ed6712ae1bf2311197bd41ae572ff=
8da5e966

> On m68k (ARAnyM), it fails with:

[...]

> # Totals: pass:7 fail:2 skip:0 total:9
> not ok 1 mean and variance tests
>
> Haven't tried the test on any other platform yet, so this could be a
> big-endian, 32-bit, m68k-specific, or even a generic problem.

It fails in the exact same way on arm32 and arm64...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

