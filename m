Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E916C3FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 03:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfGRBEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 21:04:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfGRBEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yL1QRBLgiuTEBo6M7mFjYzXgwvS+vJNgmxYl0NAvUEs=; b=mHmwAYFl8MnzVDFln77SJazjT
        oG5816qIGlCpjSZhs/9XnQCOfSYlwVtXYOW5HMdXYm9LbZGcySnZMcwgB8bWSqJhJCXVwCtDUZsZb
        iNl4jnQcWmBPS+dsT066VquHLTdR5nKRHs9iME5jtjDoWpnlMazXXDnEEQkEi/RHfLnPY+1HGDvY2
        g1UNFh1LjyLbhELEYprPFOlU3PsIU+LLzZ9aBaavDDE3oQdrkmDXC/6QIDexd6G0U3ybh7xi3vDvF
        RLXXYYXPnZKT9p1q9XVbL4vVv5yyBIBZBBrBDya9VpZqy4ZDKz0D7qTmyDdbJzpZ3IxfMdv7wCKBI
        AG37BwH1w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnuql-0002QV-HP; Thu, 18 Jul 2019 01:04:47 +0000
Subject: Re: [RFC PATCH v7 1/1] Add dm verity root hash pkcs7 sig validation.
To:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        gmazyland@gmail.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        mdsakib@microsoft.com, mpatocka@redhat.com, ebiggers@google.com
References: <20190718004615.16818-1-jaskarankhurana@linux.microsoft.com>
 <20190718004615.16818-2-jaskarankhurana@linux.microsoft.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d057b88f-0a21-0843-1212-af46f67343a2@infradead.org>
Date:   Wed, 17 Jul 2019 18:04:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718004615.16818-2-jaskarankhurana@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
Just a couple of minor nits:

On 7/17/19 5:46 PM, Jaskaran Khurana wrote:
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 3834332f4963..c2b04d226c90 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -490,6 +490,18 @@ config DM_VERITY
>  
>  	  If unsure, say N.
>  
> +config DM_VERITY_VERIFY_ROOTHASH_SIG
> +	def_bool n

It already defaults to n, so we usually try to omit that (don't repeat it).

> +	bool "Verity data device root hash signature verification support"
> +	depends on DM_VERITY
> +	select SYSTEM_DATA_VERIFICATION
> +	  help

"help" should only be indented by one tab (and not the extra 2 spaces).

> +	  The device mapper target created by DM-VERITY can be validated if the
> +	  pre-generated tree of cryptographic checksums passed has a pkcs#7
> +	  signature file that can validate the roothash of the tree.
> +
> +	  If unsure, say N.
> +
>  config DM_VERITY_FEC
>  	bool "Verity forward error correction support"
>  	depends on DM_VERITY


thanks.
-- 
~Randy
