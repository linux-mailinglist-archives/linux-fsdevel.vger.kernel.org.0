Return-Path: <linux-fsdevel+bounces-397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08847CA805
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 14:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7DB1C20445
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 12:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A7C20B27;
	Mon, 16 Oct 2023 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kn8ufPOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB139273E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 12:32:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907829F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697459549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tLG//EhK9I8o7cV+2JFGlMWf+fyb5KvdWdST0xQgYhY=;
	b=Kn8ufPOSX0WXcVtmTvwSvejA8LWy4I6b5SM/fgGhPaDTzF5JN5T8rO6ZL3MSlAsrEuu6zV
	BQJw5U6f1S7fHENszupER/TXH+YrAFLA91eCtF3ZKDIz1FiK1vo494SXtKug1phCNZ44PI
	BIiyHP/6Z/PSoy175xlNMAaFVli3Rls=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-7LsdEVuMMR65QDhGrOsROQ-1; Mon, 16 Oct 2023 08:32:28 -0400
X-MC-Unique: 7LsdEVuMMR65QDhGrOsROQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9be8013f2d1so137437366b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 05:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697459547; x=1698064347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLG//EhK9I8o7cV+2JFGlMWf+fyb5KvdWdST0xQgYhY=;
        b=O6m1kSk4JcD4d/8zjG/GQz3Zzugnb/DCkr5fDtByHRX/ecXfILULBUk0iWCGM+uAOZ
         dsf7oAUV4ORXH015hLiS7x2WX7/5FmUQhdhHorKBjUW7x/ewflg7iCV2TxYss23ewBgj
         HQA2zuXGj+FdM5+P+EC55KiKdB6g89YXLnfPZVBPcY03vP5yXYLZSEMWuujo1ZsYuChz
         yn9ER2w30d77RmaejZ2eW/4bwHfzeRz1/SIcU/5pDNeENUNamUBcRZiYBZnocIRxEdtu
         /urKIvQHyHRD/2cN0yJYEqMoP9sRra5FxEVHC7VCmUqEbz2REe5ZzZci5RH+kAgeBuKp
         sxyQ==
X-Gm-Message-State: AOJu0YxHwlrLZ1p2kH3ng0mINV8PwhUjagPk5RWnI1E238LqMqDCo7Ji
	c18kQg/Nv+0TvigBy3V3SZiAXV4hHUTgNJ4EG0R3zPvIqkgbzqp6Sqx07/KZCP3r6lHA+2sJ/r5
	8AcDHSJqJm7rF7j7009Nz55IX
X-Received: by 2002:a17:907:d24:b0:9bf:697b:8f44 with SMTP id gn36-20020a1709070d2400b009bf697b8f44mr5569184ejc.6.1697459547464;
        Mon, 16 Oct 2023 05:32:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB7qmw8VW3+nswiOyGckEp+ZRTcyaKDpWkU2ZIQBuNuhNhMfbhluSMuibOxhIeC+aBVGt8lg==
X-Received: by 2002:a17:907:d24:b0:9bf:697b:8f44 with SMTP id gn36-20020a1709070d2400b009bf697b8f44mr5569163ejc.6.1697459547155;
        Mon, 16 Oct 2023 05:32:27 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id u26-20020a50951a000000b0053ecef8786asm1641132eda.75.2023.10.16.05.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 05:32:26 -0700 (PDT)
Date: Mon, 16 Oct 2023 14:32:25 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com, 
	dchinner@redhat.com
Subject: Re: [PATCH v3 11/28] iomap: pass readpage operation to read path
Message-ID: <xic2dogypvli45ku7nasuuszslvv55tadj6etpl7r3gubvw2o6@hms55yjiqsiq>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-12-aalbersh@redhat.com>
 <ZSz/FLK+tNIQzOA/@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSz/FLK+tNIQzOA/@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-16 02:15:00, Christoph Hellwig wrote:
> Looking at the entire series, it seems like the only XFS-specific
> part of the fsverity processing in iomap is the per-sb workqueue
> now that the fsverity interfaces were cleaned up.
> 
> Based on that it seems like we'd be much better just doing all the
> work inside iomap, and just allow XFS to pass the workqueue to
> iomap_read_folio and iomap_readahead.  The patch below does that
> as an untested WIP on top of your branch.
> 
> If we go down that way I suspect the better interface would be
> to allocate the iomap_readpage_ctx in the callers of these functions
> instead of passing an extra argument, but I'm not entirely sure
> about that yet.

From the discussion in v2 [1] I understood that btrfs would like to
have this bio_set/submit_io interface for iomap transition; and any
other filesystem deferrals would also be possible. Is it no more the
case with btrfs? Would fs-verity verification in iomap_read_end_io
combine both solutions (fs-verity verification in iomap +
submit_io/bio_set interface).

[1]: https://lore.kernel.org/linux-xfs/ZCxEHkWayQyGqnxL@infradead.org/#t

-- 
- Andrey


