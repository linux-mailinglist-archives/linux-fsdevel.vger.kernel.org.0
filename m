Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A00DC156A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 01:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfEFXvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 19:51:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60310 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfEFXvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 19:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kzyE3K2VQXItgkqYG9TxWXHWWGuAWAvs7pEj1TfD8vs=; b=DMPJxH7bd+fSd8vsJbjZ8inlPr
        vHeZDDoAa2R9B6uWjavy5V6LPegPiMTAGtUDAeF5dYmlz6WEW1+il+iI5NsqT3ttgRYpqDjLNe3yn
        YGTulM+OROXxf8oVKvyzcBYleH8Jhf9xdChafHpEkH0VeZGsVehX8mXnGvlWJB8ZpU5G0VKCq1JTP
        5uVeDy8lua7ws9dtVDfqav/KmgZP0W8xCH6I5BWgI2OeHiLZCoyZbEluCe4i1N1pSUMnLEuZo2g9C
        NiMOUDoTIrP0u25baq7B7DaKDk5tNGlT8pWjWdosZZFm72Tij6GNz/aLS4ks59JahVPiti6FY5ho6
        vdvR+MSw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNnOE-0001rX-RK; Mon, 06 May 2019 23:51:23 +0000
Subject: Re: [RFC PATCH 2/4] scsi: ufs: UFS driver v2.1 crypto support
To:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
References: <20190506223544.195371-1-satyat@google.com>
 <20190506223544.195371-3-satyat@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9ca9b288-4fc1-030a-3898-8ec632113c44@infradead.org>
Date:   Mon, 6 May 2019 16:51:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506223544.195371-3-satyat@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/6/19 3:35 PM, Satya Tangirala wrote:
> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
> index 6db37cf306b0..c14f445a2522 100644
> --- a/drivers/scsi/ufs/Kconfig
> +++ b/drivers/scsi/ufs/Kconfig
> @@ -135,3 +135,13 @@ config SCSI_UFS_BSG
>  
>  	  Select this if you need a bsg device node for your UFS controller.
>  	  If unsure, say N.
> +
> +config SCSI_UFS_CRYPTO
> +	bool "UFS Crypto Engine Support"
> +	depends on SCSI_UFSHCD && BLK_KEYSLOT_MANAGER
> +	help
> +	Enable Crypto Engine Support in UFS.
> +	Enabling this makes it possible for the kernel to use the crypto
> +	capabilities of the UFS device (if present) to perform crypto
> +	operations on data being transferred into/out of the device.

	                        (maybe:)     to/from the device.
> +

Help text should be indented with 1 tab + 2 spaces, please.

-- 
~Randy
