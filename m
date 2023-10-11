Return-Path: <linux-fsdevel+bounces-54-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7307C5176
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 13:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF401C20F53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 11:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B371DDF5;
	Wed, 11 Oct 2023 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMqpUlEa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A851DDEA
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 11:17:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C9E5
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 04:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697023060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zlo0/ziFMNgNYF1FEOPe0SVTb/Xnel6cZPY+1Ns248c=;
	b=YMqpUlEaN8q69LP2ABFX/e5f19hcocs1bKjddXJdKprwmc2oyui9kDdn9cOrWyLifDcm6v
	8TeiB2Hr2SNgZ4d0gWqpDuoe/exmMZLgoY+ywIdHXd5uY9J8lK0fNQj85IIuJikGANISQ1
	33TwR9hyKyPFHzPQJoAysA+SN6xHmh0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-XEniNH5fMlCi3KzNOGxwEA-1; Wed, 11 Oct 2023 07:17:39 -0400
X-MC-Unique: XEniNH5fMlCi3KzNOGxwEA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b2c1159b0aso518392266b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 04:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023058; x=1697627858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zlo0/ziFMNgNYF1FEOPe0SVTb/Xnel6cZPY+1Ns248c=;
        b=ccorru5doFZTxqA40zKLGPtDyNlKs8/Dr5UGbo7GacqJ1Sw+aYuIXhcqQ4u5Qp6PsF
         vvm/kMANTIOHI9SsAeDpRn6FPvp5Hqq81x9JNW9SPoJX9x2j4mTLV56RnR0jvbdOEIzv
         XJg7TkOhvq/SzUlCz6KZfv0pxAR+4F08/qRla0Oka6O82LzSHjcKrpWky1HqSHI8jir0
         X2hCTsL78zTY3AeG3eeRnQ7/fi9kM8aP48y6V6hav7zepblPVE97TO3YFNxX59v6+W17
         TP34I6LAnVGXXtz4Y2s+2Xh40tPJLkhqw7Uo2mKS2pF/NCzeNQEh43cYP2YaWpu0h2R6
         Qq/w==
X-Gm-Message-State: AOJu0YyYr0sI8sZMoUdQP/7VrF5jSTY+jn/PfF4IOL+Pig6/KYrtlLUx
	9wozbFiDSquS/tlLhPxAli9fI+Zv+Y3Jx6b6RS2o6TGAY3mWHGf3j4f+NgOTWxF9jBMR8SIXZbC
	eNSC34tKYZktV2TnROJubgVzP
X-Received: by 2002:aa7:c549:0:b0:531:1241:3e98 with SMTP id s9-20020aa7c549000000b0053112413e98mr18033180edr.9.1697023057998;
        Wed, 11 Oct 2023 04:17:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZZ+YnNUe9yjYU4VsUgPkzYbFo3mygztYN0VRUFnAXJzd2X2vpYfGz2QCoVKm8w94kwwpTtA==
X-Received: by 2002:aa7:c549:0:b0:531:1241:3e98 with SMTP id s9-20020aa7c549000000b0053112413e98mr18033170edr.9.1697023057687;
        Wed, 11 Oct 2023 04:17:37 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id cy7-20020a0564021c8700b0053de19620b9sm462255edb.2.2023.10.11.04.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:17:37 -0700 (PDT)
Date: Wed, 11 Oct 2023 13:17:36 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 09/28] fsverity: pass log_blocksize to
 end_enable_verity()
Message-ID: <bwwev42i7ahrbdl4kvl7sc27zwrg7btmwf2j5h2grxp25mxxpl@4loq5hqs43gv>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-10-aalbersh@redhat.com>
 <20231011031906.GD1185@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011031906.GD1185@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-10 20:19:06, Eric Biggers wrote:
> On Fri, Oct 06, 2023 at 08:49:03PM +0200, Andrey Albershteyn wrote:
> > diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> > index 252b2668894c..cac012d4c86a 100644
> > --- a/include/linux/fsverity.h
> > +++ b/include/linux/fsverity.h
> > @@ -51,6 +51,7 @@ struct fsverity_operations {
> >  	 * @desc: the verity descriptor to write, or NULL on failure
> >  	 * @desc_size: size of verity descriptor, or 0 on failure
> >  	 * @merkle_tree_size: total bytes the Merkle tree took up
> > +	 * @log_blocksize: log size of the Merkle tree block
> >  	 *
> >  	 * If desc == NULL, then enabling verity failed and the filesystem only
> >  	 * must do any necessary cleanups.  Else, it must also store the given
> > @@ -65,7 +66,8 @@ struct fsverity_operations {
> >  	 * Return: 0 on success, -errno on failure
> >  	 */
> >  	int (*end_enable_verity)(struct file *filp, const void *desc,
> > -				 size_t desc_size, u64 merkle_tree_size);
> > +				 size_t desc_size, u64 merkle_tree_size,
> > +				 u8 log_blocksize);
> 
> Maybe just pass the block_size itself instead of log2(block_size)?

XFS will still do `index << log2(block_size)` to get block's offset.
So, not sure if there's any difference.

-- 
- Andrey


