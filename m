Return-Path: <linux-fsdevel+bounces-1025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090ED7D502B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCFA1C20BE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 12:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121D4266BE;
	Tue, 24 Oct 2023 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeY1jSK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BDE208AF
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 12:45:34 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA72123;
	Tue, 24 Oct 2023 05:45:32 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3ae35773a04so2946609b6e.0;
        Tue, 24 Oct 2023 05:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698151532; x=1698756332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDpE4b9lrbKshRFNBmBeWLt8OGBDwzY5y8TDfJJrCF0=;
        b=XeY1jSK2+9CFCW2jWIxj1hjkzT1mC6Jvo2wPCHYuzavdkU4sfQsXOPE7rBgNij01t1
         fDxe/nPhF/GnabodEyRhcKcksCc1RmygSClWixPgqOAz5CTD5jbj4QoKmHdNMjfzqrmT
         als3CAWMVgidDrr0FAVDY9YPeTQ7+mgBcbQoVTZsYnQNmrQ5sSbg3Kj26pbb//JD6dBU
         sOBk8LXVunajxaXBn1mIxZWeag8sPUD7vumyQ1hYA46RNP79ds5B1GrNGEwZWx4PlIv8
         4WzL9nxC3imVaYFoy4ZdA51ju25Rz2EmDHGBp40qoymMrRozrrFFnwBi26bnTHI0b9Pu
         EQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698151532; x=1698756332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDpE4b9lrbKshRFNBmBeWLt8OGBDwzY5y8TDfJJrCF0=;
        b=V9I3CVgk56kYPRHtnY947MifIAQenAEsKK/Ownbr296aeMAhkp6RP0YE5Sz85LswhK
         C0eZuQSZuLt/jtNpOjCxOfuhdA6hEovlV2zVpWbLtut3V53hAxc+sPno0EoatTPslEBn
         atqFYMNoJSDfBSIxL7hLfgHFO8Hmn5wkIajy3gvNJJKtYJPa27VaxhlrmzS4vB5oPr3v
         YDPkLMRqQ0KPsncXng36wkZmgZSw1UBtgywGvIXqFgqMNu2ODf00829T9ACUJrvavy2G
         jVwV4yseq46v0bFB51CMiQnauSk0eoh3Ji8Ogbbl2x8Uc1ixDtJ8TnSMVWvrPueZ7S2W
         zT9A==
X-Gm-Message-State: AOJu0YxR9qy9VliLHDh8hYhfiktOgr4O4BqTG87+6PeBu74gIDQ6eEj6
	tphQFKoylq6DUdsxY2OfWaKnMGX6bgv909475+U=
X-Google-Smtp-Source: AGHT+IFNzKTfnCI5djyaqlxvz74BRlz1XB4g2ZcwPxS9eSiil8asvvG9OW6yi7hQhiC6NOdpmJitdvs/BUm9N15FtvY=
X-Received: by 2002:a05:6808:5c5:b0:3ae:1358:fafc with SMTP id
 d5-20020a05680805c500b003ae1358fafcmr12142750oij.58.1698151531903; Tue, 24
 Oct 2023 05:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024064416.897956-1-hch@lst.de> <20231024064416.897956-2-hch@lst.de>
 <CAOi1vP_mF_A6OmNvYPvmBcS-CHQkwOHqsZ1oAZCJXQmow3QUMw@mail.gmail.com> <ZTe0C90lRfp7nnlz@casper.infradead.org>
In-Reply-To: <ZTe0C90lRfp7nnlz@casper.infradead.org>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 24 Oct 2023 14:45:19 +0200
Message-ID: <CAOi1vP-Q9J=Kk7vnjYU7t7KPt_DXf6hAwDBWRj6WS3E45z21Vg@mail.gmail.com>
Subject: Re: [PATCH 1/3] filemap: add a per-mapping stable writes flag
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 2:09=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Oct 24, 2023 at 02:03:36PM +0200, Ilya Dryomov wrote:
> > > +static inline void mapping_clear_stable_writes(struct address_space =
*mapping)
> >
> > Hi Christoph,
> >
> > Nit: mapping_clear_stable_writes() is unused.
>
> It's used in patch 3

My apologies, I was too quick to archive it as specific to XFS.

Thanks,

                Ilya

