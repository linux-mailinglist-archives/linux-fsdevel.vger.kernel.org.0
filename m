Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5A31BC711
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 19:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgD1RuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 13:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgD1RuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:50:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55657C03C1AB;
        Tue, 28 Apr 2020 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=OMzinrKyDa0rKhmOGaVXUiJgGUIohKucbMjdIZr8kDo=; b=uwJ7N+spsAywC3Q9XJofD8sB8D
        1SPBVHeOCBnvVthwkvBTFHqNJWqgh01m5fYb4agCf+JgoGyRnelzqZb7hLrAaMfNbz9dwr5FKu1pu
        RIUSZgskr2xU9WbghyLqZdINat6+sNODr0LtCPf9Fb89xejAdiq1meDvm6HI8Hx7mgEE2nD74FmGM
        psqSlbfls0fXmu9j//Js5oDMxcL4cl9UvbrrRFriJe7EL3+kdUXbomtFULrrqf9pfFJ56ARjGhyAv
        jVkql7fwUx4ojhcw2iOPBDHVX8IJehEqc5sBu4lsDBSUzvERG+SAnHf7VvAH64kXg9H6WVYW6069r
        o9U6lpOg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTUMw-0006vQ-IB; Tue, 28 Apr 2020 17:50:06 +0000
Subject: Re: [RFC PATCH 3/5] kunit: tests for statsfs API
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mst@redhat.com,
        borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20200427141816.16703-1-eesposit@redhat.com>
 <20200427141816.16703-4-eesposit@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6209404f-02a0-b89d-7503-5bbd3da2fc30@infradead.org>
Date:   Tue, 28 Apr 2020 10:50:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427141816.16703-4-eesposit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/20 7:18 AM, Emanuele Giuseppe Esposito wrote:
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 824fcf86d12b..6145b607e0bc 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -335,4 +335,10 @@ config STATS_FS
>  	  statsfs is a virtual file system that provides counters and other
>  	  statistics about the running kernel.
>  
> +config STATS_FS_TEST
> +    bool "Tests for statsfs"
> +    depends on STATS_FS && KUNIT

The 2 lines above should be indented with one tab, not spaces.

> +	help
> +	  statsfs tests for the statsfs API.
> +
>  endmenu

thanks.
-- 
~Randy

