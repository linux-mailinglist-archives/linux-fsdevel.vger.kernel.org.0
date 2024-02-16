Return-Path: <linux-fsdevel+bounces-11788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B22857270
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D691F21588
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B1A6110;
	Fri, 16 Feb 2024 00:22:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9077441F;
	Fri, 16 Feb 2024 00:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042929; cv=none; b=FNve/a3ePMDAuMERCZCEf6omFHsb6UmdvIGMdALpIssm48VtgMmD7Znjgis32yaBm3GNW/o62cDOWHzBOfWXiv/65jduheMLY03JxVWLpTN/dojAH/Gq5+iwtlCklv/DCJ6KpzpTIVybynXc23SbcgTDknm3vgdEpvOhKoj7BFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042929; c=relaxed/simple;
	bh=nalTQbTVfjoB4G4U4Iv0Pl38flllybjmyeKYUD9dEQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J08aN1UYGVP9vw0zEnpJaDxRWHFL5X9TYEAxdUZ4juewpyzN7hZEiGF0GCQ2zqDIKJ3nLCQUceLsZ93CaGbe5qFU1R/wBy6NS8/3FpXczuTM+t9DPMpd5WoEuwTCIUNev1ga20UILjpQdjvelWBUTDNe3bbBY4c/JIXYp6RvEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da9c834646so1359819b3a.3;
        Thu, 15 Feb 2024 16:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708042927; x=1708647727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nalTQbTVfjoB4G4U4Iv0Pl38flllybjmyeKYUD9dEQQ=;
        b=a5JBg48A13UrWyz7PR70ysGGF+Mqb0LGsvgUHZewbE47EFBx4Z4PUfxRKx9u0EPO1N
         q9MrM8vYxVwZHkbOIiIHaa9lCwUMwaH/InSHb9Z/QTvuOOvx9EzgOJZrL/qIwoiD+sEs
         ZdoTQRU+rIgHxHPAvWPYqk2QDmtUbk9CN6yI+IUwzzkFEkaP+nB5YnpZqDWMo6pqiAWB
         i6rh2XR8USxiR1FGobxqCWAQLB0dFld1EhcuhWn06S37aTtueQuMbEvT5Fg1PDQAy4bg
         aVod7dxLv0iaFWXFHuBwHHLi6O9TX3YgQwYm9vcoRQ7L7qUuzADjaltUiL0ybsb0ImPh
         Xibw==
X-Forwarded-Encrypted: i=1; AJvYcCVRopJd+0g80H0uohwndb/7g92xDKMZZehF4kS7Cn3QgncGU+AvwhLzvWjVRfWVUxVQ3ID33K2QjX9hstwUH77sZsPy2GwyGQZpDthRyTeQye7oL6JZrM3rinHBGNuGidDZivQMfP78t6qZ
X-Gm-Message-State: AOJu0Ywm4HCSq1Toir4E5EN44rznE37n1IW3FLvTPjaKuzP5eawubu8N
	fTItlgNPA8HNlvfA7LGZv6gPog45V4mCcBLmycmcJKZk3yKhhe30u30MknFP
X-Google-Smtp-Source: AGHT+IFchL/G43WoVIYoXIbt1nEHrqq0XvNj77xFeRiCshYs5+JhsDlF3l9UKkNcTisKFiwq74tmGg==
X-Received: by 2002:a05:6a00:3d4d:b0:6de:1e25:48e8 with SMTP id lp13-20020a056a003d4d00b006de1e2548e8mr4801967pfb.14.1708042927030;
        Thu, 15 Feb 2024 16:22:07 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id ka38-20020a056a0093a600b006e1377847bdsm357601pfb.50.2024.02.15.16.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 16:22:06 -0800 (PST)
Message-ID: <424cd3a3-dc20-420c-a478-958f1aa2f1e6@acm.org>
Date: Thu, 15 Feb 2024 16:22:04 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/19] scsi: sd: Translate data lifetime information
Content-Language: en-US
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Damien Le Moal <dlemoal@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20240130214911.1863909-1-bvanassche@acm.org>
 <20240130214911.1863909-12-bvanassche@acm.org>
 <yq1h6i9e7v7.fsf@ca-mkp.ca.oracle.com>
 <7e3662b4-30c0-496b-be19-378c5fab5f33@acm.org>
 <yq15xype6k9.fsf@ca-mkp.ca.oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq15xype6k9.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 14:00, Martin K. Petersen wrote:
> Another option would be to simply set use_16_for_rw when streams are
> supported like Damien does for ZBC.

Setting use_10_for_rw may work better since devices that support data
lifetime information will support WRITE(10) while it is not guaranteed
that these devices support WRITE(16). As an example, WRITE(10) support
is required by the UFS standard while WRITE(16) support is optional.

Thanks,

Bart.

