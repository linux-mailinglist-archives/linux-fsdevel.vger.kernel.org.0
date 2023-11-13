Return-Path: <linux-fsdevel+bounces-2808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEE27EA578
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 22:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5721C209EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 21:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5876F2D62B;
	Mon, 13 Nov 2023 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SWNKusEi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABCF2D619
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 21:27:06 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBF3D67
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 13:27:03 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso746293066b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 13:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699910822; x=1700515622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mttVMjujBnJtfA9qmPOIHfeRm+JAOLtRVgarlviBSVY=;
        b=SWNKusEikZ1DnrYVHQ0hQIr0P5xQ6d7ccHuOGHJIjnhbSRJxEpYKgjbrhrwOYU93Tz
         UXeeIK82VcqmypH86NZdLRny5x+n3RkaXs9A0Q8zejFkSAWi3wON91+UFgN0drxH7dZS
         L1I8W1/dkxAmQBmo2KMtchZsfVIPIaVscjoQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699910822; x=1700515622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mttVMjujBnJtfA9qmPOIHfeRm+JAOLtRVgarlviBSVY=;
        b=RBkkaVbFil16wEHi13E2ITZzfHCaHbPpFI4k/TS5dZRS35wDLWDBHKRqFr5CEjdsud
         36uykj7TeZbVc0bYpAlDmoDPxIGsoE8J4vOUP4T+SPyThzgwkiwK6I8TtGMBKVimeXZD
         prf1cxDX1+0q4ei9/3fClFohLj/n1WWtLp3i1PcOSUfL8dTo/DKSDxQvrCIWq+Ux/gbL
         d+H9pUrSZvr/YCYEXc8jiM0eqkEJWIMV7q942B+9ZVu0UC9JL4wnPjesiOr2fd2RnNbB
         fQ2J5lK2xHSfx2czLYrk0HXcOAERAiziAAnNhXityK8bztyodInhEj4c/NkVhdsMYLkb
         HbQw==
X-Gm-Message-State: AOJu0YwMLpI+BaNw7tNo0sP9QZZx7NpPGnu5+PP39cUkW1PLu6JEGLsN
	NWpi1gYseEuHnqaqfhaEzmbYxSon8Yi2tTL6K6/w0w==
X-Google-Smtp-Source: AGHT+IGoL4C64VRkqMMt2Ko2g8gaFMw8YCcpuwoNcjFqFlvPZKJTDjJL2Bgl7LbSUmzZ0cB+I9TezFzC6HBD0IZ7Sjs=
X-Received: by 2002:a17:906:dfca:b0:9e4:67d9:438 with SMTP id
 jt10-20020a170906dfca00b009e467d90438mr5397879ejc.56.1699910821965; Mon, 13
 Nov 2023 13:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org> <ZU7RVKJIzm8ExGGH@dread.disaster.area>
In-Reply-To: <ZU7RVKJIzm8ExGGH@dread.disaster.area>
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
Date: Mon, 13 Nov 2023 13:26:51 -0800
Message-ID: <CAG9=OMPFEV9He+ggq2mcLULnUZ2jm8fGU=4ca8kBoWtvqYcGVg@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] [PATCH v9 0/3] Introduce provisioning primitives
To: Dave Chinner <david@fromorbit.com>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 4:56=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Thu, Nov 09, 2023 at 05:01:35PM -0800, Sarthak Kukreti wrote:
> > Hi,
> >
> > This patch series is version 9 of the patch series to introduce
> > block-level provisioning mechanism (original [1]), which is useful for
> > provisioning space across thinly provisioned storage architectures (loo=
p
> > devices backed by sparse files, dm-thin devices, virtio-blk). This
> > series has minimal changes over v8[2], with a couple of patches dropped
> > (suggested by Dave).
> >
> > This patch series is rebased from the linux-dm/dm-6.5-provision-support
> > [3] on to (a12deb44f973 Merge tag 'input-for-v6.7-rc0' ...). The final
> > patch in the series is a blktest (suggested by Dave in 4) which was use=
d
> > to test out the provisioning flow for loop devices on sparse files on a=
n
> > ext4 filesystem.
>
> What happened to the XFS patch I sent to support provisioning for
> fallocate() operations through XFS?
>
Apologies, I missed out on mentioning that the XFS patches work well
with loop devices.

I might have misunderstood: were those patches only for sanity testing
or would you prefer that I send those out as a part of this series? I
can whip up a quick v10 if so!

Cheers

Sarthak


> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com

