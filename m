Return-Path: <linux-fsdevel+bounces-2397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2D7E5A81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 16:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04EB1B210DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE9A3065E;
	Wed,  8 Nov 2023 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="P6x3gkIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AF93035F
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 15:52:24 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A7A1FF3
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 07:52:23 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d1a05b816so47729146d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 07:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699458743; x=1700063543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpSU8b6e4/5zSa52UFxV5Lqhwn5geUvXphUDenPaLtw=;
        b=P6x3gkIMpvigr15qgGDcEb/pirGVW7/O+ypiDPkpc/7/vzOegV5vMgOlHot6tmEwqL
         NSt4OP9Pw4q52ZMuzmPMNUMLa0g/8NoGtZ5MwkQgLNEm9dHwbCpTIn94elAN/CAx9Va/
         4Qy6/dszdUuEItMq6E6WgX/l69QPg1mvi4zamwzNflVonB6q3AjeugirUvGypL5VVySD
         +xIkX8IrzCYCsk0y7ozhc4cpnvSPu0G6mevvsT6WnRwL1MLk5AD5L2qlrY3rOQK5jJ8p
         +DEQkr0fv6Xg3i7SrTUaGS3iWPEd9+KocJ9aE64zxYqNz4UKxuNmtG+dlbM5ZBhzLHx/
         qCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699458743; x=1700063543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpSU8b6e4/5zSa52UFxV5Lqhwn5geUvXphUDenPaLtw=;
        b=hQIWqoq1cv0JTZAg2Y9UCMIvYTWbqOs6wAi3GZczK6tFrHPRMrXyhiY8Wr2b8G2Adr
         pmCBU1HS9RI9RFpOPm8HQDr1OAhalSYtkr66PfwpleKsJt/WamxXLP0wxfTfup84ZMFl
         2LZfy5sSa+gJ96YzQotJdEubfZmjl/5ee5Ttn72c9qVtl55a+JM1vI/A5gAqlL89R11U
         sV6eqgzgSij56BY6N/M/L0exaV7bCPRvpXaQc4H0/FK7PuLdTIVwZNjzdcbMHOhZrvf9
         aqJl9jbvtsVziwkO8U/sO8fk6/c6lzCq6cCd67d30sOfU5ZBubSDJbLkm/2g8KNIEq2k
         YD9g==
X-Gm-Message-State: AOJu0YyOJcUH+Pmai42v/KGUeP3BaRY6weyOmJARSmbIhPkNOl0r+WY8
	UNMv7UV+AbI2K+qIg4yXr2I5ig==
X-Google-Smtp-Source: AGHT+IFlCTcQbTlf3rMhvY4yZuLyhWoZ1K1k3LaIUXWbU1yQceXTZB7c8QH7IjArp1psru/DB9tIvQ==
X-Received: by 2002:a05:6214:2029:b0:66d:4a22:d7cd with SMTP id 9-20020a056214202900b0066d4a22d7cdmr2161193qvf.60.1699458742750;
        Wed, 08 Nov 2023 07:52:22 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i5-20020ad44105000000b00671248b9cfcsm1190405qvp.67.2023.11.08.07.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:52:22 -0800 (PST)
Date: Wed, 8 Nov 2023 10:52:21 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>
Subject: Re: [PATCH 06/18] btrfs: split out ro->rw and rw->ro helpers into
 their own functions
Message-ID: <20231108155221.GA458562@perftesting>
References: <cover.1699308010.git.josef@toxicpanda.com>
 <bb944da42fc7d01832f72495ec07f9a82a133376.1699308010.git.josef@toxicpanda.com>
 <1a5369c6-24e0-45dd-a867-5844e8171fb9@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a5369c6-24e0-45dd-a867-5844e8171fb9@wdc.com>

On Tue, Nov 07, 2023 at 03:16:50PM +0000, Johannes Thumshirn wrote:
> On 06.11.23 23:09, Josef Bacik wrote:
> > +	if (btrfs_super_log_root(fs_info->super_copy) != 0) {
> > +		btrfs_warn(fs_info,
> > +			   "mount required to replay tree-log, cannot remount read-write");
> > +		return -EINVAL;
> > +	}
> 
> I get that this is only a copy of the old code, but if you have to 
> re-spin the series:
> 
> 	ret = btrfs_super_log_root(fs_info->super_copy);
> 	if (ret) {
> 		/* [...] */
> 	}

This tells us the bytenr, it's not a return value.  Thanks,

Josef

