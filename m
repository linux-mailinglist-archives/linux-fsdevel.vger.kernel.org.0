Return-Path: <linux-fsdevel+bounces-52-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C017C513E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 13:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C8F1C20C57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 11:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB73D1DDCF;
	Wed, 11 Oct 2023 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IH12f5m3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA41DDC1
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 11:12:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439C1C9
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 04:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697022729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kEmWjWgOxRFcJRKEBCxKJxRrv3vBV4YFppvO0WCp44=;
	b=IH12f5m3/kdFaoAxxhA28GivZN60v1gU0n9TUJGEeiGZywGVzqgLpOyINg4xmCcDj1E8Ys
	Bbiw3oaILCX474GjZPGB/xqN7V4GIbAg67qmBJKP3VMvKEdmtnOfmKlslPd+tAuKPsNB0H
	VGDjCyeDlNqZy1cBQ/CvNPcRpcRFeWM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-03yl5kr7OrG0et9TGVZbUQ-1; Wed, 11 Oct 2023 07:11:53 -0400
X-MC-Unique: 03yl5kr7OrG0et9TGVZbUQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-52310058f1eso960995a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 04:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697022712; x=1697627512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kEmWjWgOxRFcJRKEBCxKJxRrv3vBV4YFppvO0WCp44=;
        b=GOAbr802Q+mXCnMwPdLQhFnLMJjWTYxcJFQNMEEVsUjOtuhzFZiy5WuxYK2ibp7ZJk
         YZX7NxobMsQ6UwbA6uohZxwTOXPIWndjVlPeVTNMK5WoV/IpBoVYqVXHyjvQ0vYEBleh
         bhCqrRwwYCO7ulg7XQ/EoZMGqi4v/1WM+SBnBvCmAiByk0GGu1ORqr9Babh8oKFiopw5
         RDFeDEYrXqtP2yLLCWAyLJkDiZzuHm9kLp2IoyPVT1DLh2OKivhONhMBwrH7aa+Jx+fs
         pn8FyIN3ooxyPdO7IctQbu3FjgG+0XX5Crhptl1j7uVDsdOsTGp/Ifg0WTff5rwba03I
         00jw==
X-Gm-Message-State: AOJu0YzsCcsMP1ocRSKaDuZ0W3We1o+OXVvLFatyk9X0gzuG+w294jZy
	jF9f1MuQ3eEOEtfTeG+x6bdjK6JpenjWxt1hGsR25Q6fyJ8jY92UoG8KEF4ytOY1FvEVk/QWDGy
	LlR69G/NPKH9eSV+GWKROZcUB
X-Received: by 2002:a17:907:9454:b0:9ae:65d6:a51f with SMTP id dl20-20020a170907945400b009ae65d6a51fmr15512255ejc.18.1697022712101;
        Wed, 11 Oct 2023 04:11:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDgARfv/UqsKe2KQ66ychyLoGXLKXNYM7/TA5AoU9zv4vYFkvlQ37nunw7fm1lqRnWkTGQkw==
X-Received: by 2002:a17:907:9454:b0:9ae:65d6:a51f with SMTP id dl20-20020a170907945400b009ae65d6a51fmr15512240ejc.18.1697022711783;
        Wed, 11 Oct 2023 04:11:51 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id cb22-20020a170906a45600b0099ce025f8ccsm9668390ejb.186.2023.10.11.04.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:11:51 -0700 (PDT)
Date: Wed, 11 Oct 2023 13:11:50 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 06/28] fsverity: add drop_page() callout
Message-ID: <jimlghyfxeyapqcm4jomf5wkwtz3ufcarlb4j2v3kbjxusn4iq@khjabsipk6rc>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-7-aalbersh@redhat.com>
 <20231011030646.GA1185@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011030646.GA1185@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-10 20:06:46, Eric Biggers wrote:
> The changes from this patch all get superseded by the changes in patch 10 that
> make it drop_block instead.  So that puts this patch in a weird position where
> there's no real point in reviewing it alone.  Maybe fold it into patch 10?  I
> suppose you're trying not to make that patch too large, but perhaps there's a
> better way to split it up.

Yes I was trying to make it easier to review. I will try to split it
differently :)

-- 
- Andrey


