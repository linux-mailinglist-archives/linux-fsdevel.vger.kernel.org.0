Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645E91BC705
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 19:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgD1Rro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 13:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgD1Rrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:47:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFFCC03C1AB;
        Tue, 28 Apr 2020 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=8+I/JU8TxahQP9MLwhngUL/zVCtHvosZU/R5hbZmDh8=; b=KJRxcH+0SzP4IvHHb2Imdt/0rj
        QsKji2uge544sOVsd+IIJzl/i2bNNDnDRKumZZxCvrvVnl1sz4+3ZM7inJIn8qAtS4vpOkJ9JhkSy
        Igg/+GVvbrxqYXQ1OwoDdMtxjhh2MX3KdBctcHip+C3JF+I5tJQyzfyvHHPQb7yCEKVvonF88Wfak
        Ro00z2Drrl6NDXMdGNHlaOV9Z79sVe1Mx4FRg508PgEX9rFN0BjZ1FcIltefe3pjs6dn2O9NHDIBb
        lgERpR3WmJ9n/SSlNjFPntcLA6udND03BFVQlY85WXum7fNyIIYUXyTHnKztnfByk7/OPqENfD+4z
        7IXpUtIw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTUKa-0005i4-ES; Tue, 28 Apr 2020 17:47:40 +0000
Subject: Re: [RFC PATCH 2/5] statsfs API: create, add and remove statsfs
 sources and values
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mst@redhat.com,
        borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20200427141816.16703-1-eesposit@redhat.com>
 <20200427141816.16703-3-eesposit@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <229d83bf-1272-587b-233a-d68ad2e11cde@infradead.org>
Date:   Tue, 28 Apr 2020 10:47:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427141816.16703-3-eesposit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/20 7:18 AM, Emanuele Giuseppe Esposito wrote:
> diff --git a/fs/Kconfig b/fs/Kconfig
> index f08fbbfafd9a..824fcf86d12b 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -328,4 +328,11 @@ source "fs/unicode/Kconfig"
>  config IO_WQ
>  	bool
>  
> +config STATS_FS
> +	bool "Statistics Filesystem"
> +	default y

Not default y. We don't enable things that are not required.
Unless you have a convincing argument otherwise.

> +	help
> +	  statsfs is a virtual file system that provides counters and other
> +	  statistics about the running kernel.
> +
>  endmenu


-- 
~Randy

