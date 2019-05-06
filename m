Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B5A156C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 01:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfEFXyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 19:54:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60382 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfEFXyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 19:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8JRNJiv/VbYM71AEUd80ItdkLhtYyNFmfNzyleo5x8k=; b=Z9f22nwD+1hikEnxcUVZ6/kdY6
        ceY5R7/daKmMoZyF0FZg0Qq1nOIbFA3/3Aivi1hXpVA8R4eTj42EpYmMaIDMsD2VG5MdFKk1u36qe
        l84Hn/dhZU7Ktl7tx/1a3SC2NGAMJeTqCOJfCjaONCeoYGjgrK+Bog5A2OkbTCAHLUPQLBzDqVThE
        N/iYkZjMPH7jGT1okIxtUOckG1RKtBsag2xM+tjI1trM9IoyHGio9jJ7ReE2ZMA1jmSPEBxVvvtTF
        l/NIvS/28uaXgFtXA29RHSkhfqgDXUrzCNPSpljSQVjtSVt199d4Zk9wRoRSOdUh4ey+xAAHQkeLs
        QzNtUtUw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNnRH-0001uM-Jw; Mon, 06 May 2019 23:54:32 +0000
Subject: Re: [RFC PATCH 1/4] block: Block Layer changes for Inline Encryption
 Support
To:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
References: <20190506223544.195371-1-satyat@google.com>
 <20190506223544.195371-2-satyat@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ec036543-e318-c143-d5ef-dabfa2b077b9@infradead.org>
Date:   Mon, 6 May 2019 16:54:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506223544.195371-2-satyat@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/6/19 3:35 PM, Satya Tangirala wrote:
> diff --git a/block/Kconfig b/block/Kconfig
> index 028bc085dac8..65213769d2a2 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -187,6 +187,22 @@ config BLK_SED_OPAL
>  	Enabling this option enables users to setup/unlock/lock
>  	Locking ranges for SED devices using the Opal protocol.
>  
> +config BLK_CRYPT_CTX
> +	bool
> +
> +config BLK_KEYSLOT_MANAGER
> +	bool
> +
> +config BLK_CRYPTO
> +	bool "Enable encryption in block layer"
> +	select BLK_CRYPT_CTX
> +	select BLK_KEYSLOT_MANAGER
> +	help
> +	Build the blk-crypto subsystem.
> +	Enabling this lets the block layer handle encryption,
> +	so users can take advantage of inline encryption
> +	hardware if present.

Last 4 lines should be indented with 1 tab + 2 spaces, please.


-- 
~Randy
