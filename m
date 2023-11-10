Return-Path: <linux-fsdevel+bounces-2728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3307E7D63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 16:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483641C20A95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E4C1CAA3;
	Fri, 10 Nov 2023 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONmg828A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C001C6BF
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 15:23:58 +0000 (UTC)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385483A886
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 07:23:57 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7bac330d396so868526241.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 07:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699629836; x=1700234636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HL+JX3U7OhquHqDKbaAlO31MPv1AOeAfBieIdS6H7i4=;
        b=ONmg828ApZxGBjr7h3ZsDqXSZBUDrQfEn7KbBtn/vyCQN6uK3qyxsxL1MkX2bglSXv
         IrmDpyXA//C8O3QiQyIdN9UatFnD2tHcnl7hQpB1p4ZetLt9a21D4pT4fwzMWPoslQTD
         Nq8s+Azr7Et0NyRng11bFeX+Hw9ZV7HQ+iveJTA8QJTmTHqKqGNnhi34JSEy1y2MSTnG
         FATd/ODRfFT3I0imhZRl8y0yhNo95wxUEMr+Cu/TPFiheZx8xgVSiwaSOLZ3A1ZF83Kt
         E9yRknb6FY7Mk2w5T94EbwkQzFGsIE6bmkQwJogUl9HlphDIzW8IEOojuV8uS5SE0nDF
         vYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699629836; x=1700234636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL+JX3U7OhquHqDKbaAlO31MPv1AOeAfBieIdS6H7i4=;
        b=BYSGyTWrzfUdMt3db1DRyryUge6lBYyL7++GRzxYB0+l01UJP6ZAvIN9ISL0cs8aL7
         ZX42F/8nKrgND3YG15DNYm4Ks7xwxhqQ/F8nTlnhWEs4IA1w9iZKIrAIQ4V0oPU4d3wr
         eDEYLl3oBB5SQxeLW9o5uKHczpFHusFw0eF22yFB8v+9rRTmO0VtqPgshe1D7Tud3PMF
         MPJu3ELldh4+A03WcnapwHG2C1f8u9iy/hujtdgu+UgmuF5WvsYhmOjPI/BEkOMbo78v
         UI3vXks+Yf7S1QCyYNsdBYr3DW/kRLMSieZM/qqPYDZ8ojBatcyoDASdwG6KSbELtutP
         93iA==
X-Gm-Message-State: AOJu0YzlA5l7H1OcQauh10dAX92MQviveRhuNq2W7krovDiCu5nSFdun
	rL9F6tPZrsUCgzZtcquqe8cHSqoAy6BA8/1t+Jo=
X-Google-Smtp-Source: AGHT+IGTiz/64icETSz9hFpLN/EaDzvQyMct9izcwEQecvNOdXLrA6gz35HEEwQIw+lbJSOJiPpo3Jr0HdcWywbhNfM=
X-Received: by 2002:a05:6102:160d:b0:45d:9223:9532 with SMTP id
 cu13-20020a056102160d00b0045d92239532mr9432041vsb.19.1699629836262; Fri, 10
 Nov 2023 07:23:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109210608.2252323-1-willy@infradead.org> <20231109210608.2252323-6-willy@infradead.org>
 <CAKFNMokuZFWqoX_1uWm0-vTcbo_gESkNpv8J8Pw1G-Vwd=-D+w@mail.gmail.com> <ZU4x3IAGmLx457p0@casper.infradead.org>
In-Reply-To: <ZU4x3IAGmLx457p0@casper.infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sat, 11 Nov 2023 00:23:39 +0900
Message-ID: <CAKFNMomdqigLAQ_17KaBJzBkzv7wrmAgHs8KA5nJWTcAGc76MQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] buffer: Fix various functions for block size > PAGE_SIZE
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hannes Reinecke <hare@suse.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 10:36=E2=80=AFPM Matthew Wilcox wrote:
>
> On Fri, Nov 10, 2023 at 04:48:02PM +0900, Ryusuke Konishi wrote:
> > On Fri, Nov 10, 2023 at 6:06=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
> > > +++ b/fs/buffer.c
> > > @@ -199,7 +199,7 @@ __find_get_block_slow(struct block_device *bdev, =
sector_t block)
> > >         int all_mapped =3D 1;
> > >         static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
> > >
> > > -       index =3D block >> (PAGE_SHIFT - bd_inode->i_blkbits);
> > > +       index =3D ((loff_t)block << bd_inode->i_blkbits) / PAGE_SIZE;
> >
> > Multiple 64-bit divisions are used in this patch, but why not use two
> > stage shifts as shown below if there is no left shift overflow and the
> > sign bit will not be set ?
> >
> >        index =3D ((loff_t)block << bd_inode->i_blkbits) >> PAGE_SHIFT;
>
> Here's what the compiler turns that into:
>
>     3223:       49 8b 86 80 00 00 00    mov    0x80(%r14),%rax
>     322a:       4c 89 ee                mov    %r13,%rsi
>     322d:       ba 01 00 00 00          mov    $0x1,%edx
>     3232:       0f b6 88 c2 00 00 00    movzbl 0xc2(%rax),%ecx
> ^ this is where we load i_blkbits into ecx
>     3239:       48 89 45 d0             mov    %rax,-0x30(%rbp)
>     323d:       4c 8b 60 30             mov    0x30(%rax),%r12
>     3241:       48 d3 e6                shl    %cl,%rsi
> ^ shift left by %cl (the bottom byte of ecx)
>     3244:       31 c9                   xor    %ecx,%ecx
>     3246:       48 c1 ee 0c             shr    $0xc,%rsi
> ^ shift right by 12
>     324a:       4c 89 e7                mov    %r12,%rdi
>     324d:       e8 00 00 00 00          call   3252 <__find_get_block+0x8=
2>
>                         324e: R_X86_64_PLT32    __filemap_get_folio-0x4

Ah, similarly in my environment, these divisions by constant are
optimized (and no link errors happen even on a 32-bit machine).
Sorry for taking up your time with unnecessary comments along with
that for patch 3/7.

Regards,
Ryusuke Konishi

