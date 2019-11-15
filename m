Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3964FD2E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 03:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfKOC2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 21:28:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfKOC2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 21:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ISaYPON1vGFntbrhcVpZEFaBbyVPL4wL9MWKN8HpUjY=; b=ooPZ7LYNuKQhHb99nuwHdi+l9
        SAa+fsOMVzwKuwMScD+K56KNmarhjpk49l7bhWYm3a2SrR5jGVW4VP7o6iPmq0+br6/ArhoawBZOd
        Abt15t1gMobT7dxeRwNqgOto6NocFwB98jQDuyQJl5dChxksNxW6LG07lnOblqFNYx+1vtXg07orY
        +4RqopCsKZHw3eJhs80O18RKQ389aUbBMia0RGPeeUOkDtWqCmdt4srHdyyBL3Zr1e7kk/gHhJg9E
        V2zaaLz49oBJPQ3ixntnMryLQsE2iZ9stFofb9dp8W5wo7Wvlo18r/YJptJpn34kgt9JnueGu9wYM
        +BWnc2sWg==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVRLE-0001NS-9u; Fri, 15 Nov 2019 02:28:08 +0000
Subject: Re: mmotm 2019-11-14-17-24 uploaded (UML mm/vmalloc.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        richard -rw- weinberger <richard.weinberger@gmail.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>
References: <20191115012505.5C2YGloIj%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <25f8266e-bba5-d3a3-00e9-d1855e5483c6@infradead.org>
Date:   Thu, 14 Nov 2019 18:28:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191115012505.5C2YGloIj%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/14/19 5:25 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-11-14-17-24 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.

UML on i386 has build errors (defconfig):

  CC      mm/vmalloc.o
../mm/vmalloc.c: In function ‘__purge_vmap_area_lazy’:
../mm/vmalloc.c:1286:8: error: ‘SHARED_KERNEL_PMD’ undeclared (first use in this function); did you mean ‘PAGE_KERNEL_RO’?
   if (!SHARED_KERNEL_PMD && boot_cpu_has(X86_FEATURE_PTI))
        ^~~~~~~~~~~~~~~~~
        PAGE_KERNEL_RO
../mm/vmalloc.c:1286:8: note: each undeclared identifier is reported only once for each function it appears in
../mm/vmalloc.c:1286:29: error: implicit declaration of function ‘boot_cpu_has’; did you mean ‘get_cpu_mask’? [-Werror=implicit-function-declaration]
   if (!SHARED_KERNEL_PMD && boot_cpu_has(X86_FEATURE_PTI))
                             ^~~~~~~~~~~~
                             get_cpu_mask


-- 
~Randy

