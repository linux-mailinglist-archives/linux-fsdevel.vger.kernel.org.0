Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB4D1C496F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 00:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgEDWLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 18:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726338AbgEDWLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 18:11:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669A7C061A0E;
        Mon,  4 May 2020 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Ke6Is75zTSCuovFahCnc7BTlhzg10jNaHS1gn8ns//o=; b=JDybFtusCmGEq91bmNnwoWCj+a
        N0xxIbsYu5lQxZkzPmNDuU07PGvTPGCdW0vbPRO5yL9CyEBvYR1vtbAgXrtqw0hBFSByZmuXy1eOa
        BV13lTYReOQhwPBCt6oCwd0okqW34ZMeppO7ul+DxlMT9qEZya+kLv/fyY5XjjSJAr4+XskBbUHkP
        mPhZXNr8NsQlQubgAbiO0erlNn5pHycINxr2ibFLT8cB20zuIsAzAh/rYn7lMK6nibeLoyUg72TaC
        rhhs1ncVZ9Po/A7mh6tw7ETaxX3a6Mq6QjZeYirrDtXuot86KgWihjeGnL68mEPitegVqvhOr0bO8
        9WIr0pFg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVjIz-0001BJ-5H; Mon, 04 May 2020 22:11:17 +0000
Subject: Re: [PATCH v2 2/5] stats_fs API: create, add and remove stats_fs
 sources and values
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200504110344.17560-1-eesposit@redhat.com>
 <20200504110344.17560-3-eesposit@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9a4e7489-bac4-23dc-b612-73eb91babb6f@infradead.org>
Date:   Mon, 4 May 2020 15:11:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504110344.17560-3-eesposit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/4/20 4:03 AM, Emanuele Giuseppe Esposito wrote:
> diff --git a/fs/Kconfig b/fs/Kconfig
> index f08fbbfafd9a..1b0de0f19e96 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -328,4 +328,10 @@ source "fs/unicode/Kconfig"
>  config IO_WQ
>  	bool
>  
> +config STATS_FS
> +	bool "Statistics Filesystem"
> +	help
> +	  stats_fs is a virtual file system that provides counters and
> +	  other statistics about the running kernel.
> +
>  endmenu

Hi,

This kconfig entry should be under (inside) "Pseudo filesystems",
i.e., between 'menu "Pseudo filesystems"' and its corresponding
"endmenu".

Thanks.
-- 
~Randy

