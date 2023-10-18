Return-Path: <linux-fsdevel+bounces-658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5848F7CDFE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418381C20D80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B221B37C8E;
	Wed, 18 Oct 2023 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/fX5rS/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C3137C96
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 14:32:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9372046A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697639564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K+hIIyolcoAhu3WZDYJvpkd8XrLzwi17lqom2zgmM7I=;
	b=J/fX5rS/qNHtFyk6fbZvE5VzQTO9E3rXfMqP0zQkF5uHgbIvuIfJFtx7tDWqJNC402Ksbj
	ru7VDsZnP3S51VPc506b/4FUK+FdxPGW3xuUJlx7GNnpL1eY4izftS7ocf1rgVniWHPWlB
	aiyEql1rPhz2eMUZ51H3MqqI+aEZl0E=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-n8_iZJd-OmKAAuWqY56suA-1; Wed, 18 Oct 2023 10:32:38 -0400
X-MC-Unique: n8_iZJd-OmKAAuWqY56suA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b2e4f3defaso1618056b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 07:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697639557; x=1698244357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+hIIyolcoAhu3WZDYJvpkd8XrLzwi17lqom2zgmM7I=;
        b=PRBF8nJn+zU0MqlbCvxTKe2La7R/fmTtRP8eWE8ZPkMMMpreX6svvd+Vmfs1EM8D42
         uIdHqsghbj8/rOM/UlfBDfv7pmHffIutwPiRN/IJBIGqc1r+7dmuKlSGw+7I5EBxH/3e
         6PeLmaVx72WmANSVOeP+jHTAOLmRurDBriqIbQE1VFe0iyoR0m1wT1E+bOVde6KxcaK3
         51dwgTdri2ioKbo7kdQsGv09end3m9YLEy63NrIYoYFDx9XmsXmUDTE6SCnfdABKZn/6
         goXSZkxEnt1OCfeZl3XYzfEZdv4w4/Zk+UjjeE/c3jA+b/lzY7neYj7xYhVzz9C8yVKX
         ow8w==
X-Gm-Message-State: AOJu0Yw/SwwlMRajkoo5iFEgFU7PYRh0xTfcdQEH2YMJR1ONjRPHrLMD
	MlCo5p0ULGUwIbkMO4MQT5ies3uRE5YWjy+3fltj9Cbp5UHXTJOdEUyqec3K1iAbzorNYY5+uyp
	3eB3jqEcKlg03l3+G9BVY8haauPuD8n0w3POR2YBanw==
X-Received: by 2002:a05:6808:df3:b0:3a4:8251:5f43 with SMTP id g51-20020a0568080df300b003a482515f43mr5134034oic.40.1697639557741;
        Wed, 18 Oct 2023 07:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJZ0HVTUp+cKIoQPyPSp/EXlm6/WaNKSXxkPslSA2R5r3Bbt7OFS5yZTlg6c13Zt/RYoAUWjid9rbi0mzRUuU=
X-Received: by 2002:a05:6808:df3:b0:3a4:8251:5f43 with SMTP id
 g51-20020a0568080df300b003a482515f43mr5134021oic.40.1697639557500; Wed, 18
 Oct 2023 07:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8762e91a210f4cc5713fce05fe5906c18513bd0a.1697617238.git.jstancek@redhat.com>
 <20231018122220.GB10751@lst.de>
In-Reply-To: <20231018122220.GB10751@lst.de>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 18 Oct 2023 16:32:19 +0200
Message-ID: <CAASaF6xHTv6iZd5ttHOJ_M=hpjaGZOnUCGSHkbGy_yLbe2G8nw@mail.gmail.com>
Subject: Re: [PATCH] iomap: fix short copy in iomap_write_iter()
To: Christoph Hellwig <hch@lst.de>
Cc: djwong@kernel.org, willy@infradead.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 2:22=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Oct 18, 2023 at 10:24:20AM +0200, Jan Stancek wrote:
> > Make next iteration retry with amount of bytes we managed to copy.
>
> The observation and logic fix look good.  But I wonder if simply
> using a goto instead of the extra variable would be a tad cleaner?
> Something like this?

Looks good to me. Would you be OK if I re-posted it as v2 with your
Signed-off-by added?


>
> ---
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 061f3d14c12001..2d491590795aa4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -881,8 +881,10 @@ static loff_t iomap_write_iter(struct iomap_iter *it=
er, struct iov_iter *i)
>                 size_t bytes;           /* Bytes to write to folio */
>                 size_t copied;          /* Bytes copied from user */
>
> +               bytes =3D iov_iter_count(i);
> +retry:
>                 offset =3D pos & (chunk - 1);
> -               bytes =3D min(chunk - offset, iov_iter_count(i));
> +               bytes =3D min(chunk - offset, bytes);
>                 status =3D balance_dirty_pages_ratelimited_flags(mapping,
>                                                                bdp_flags)=
;
>                 if (unlikely(status))
> @@ -933,10 +935,12 @@ static loff_t iomap_write_iter(struct iomap_iter *i=
ter, struct iov_iter *i)
>                          * halfway through, might be a race with munmap,
>                          * might be severe memory pressure.
>                          */
> -                       if (copied)
> -                               bytes =3D copied;
>                         if (chunk > PAGE_SIZE)
>                                 chunk /=3D 2;
> +                       if (copied) {
> +                               bytes =3D copied;
> +                               goto retry;
> +                       }
>                 } else {
>                         pos +=3D status;
>                         written +=3D status;
>


