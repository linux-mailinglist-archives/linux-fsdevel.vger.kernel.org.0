Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6672B15DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 07:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgKMGfi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 01:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgKMGfi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:35:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42983C0613D1;
        Thu, 12 Nov 2020 22:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=G6RtqFfqrHffqPSTAr1sy7qZDytGoAeAFWB5/2KH9jI=; b=KDNSwbmjSKN34SqQ/TZz8pduVs
        6Ydn11YPQUpUZ3L0+OYO9+xhEN1G8J+7Ky7AhYV/iGuIasKDJqjd3s7WTVsMASgNZFAm1g+XJUbJr
        dgdaX96m5sV+ZgRnb7FA5/Ssmtyx0HZCCwyHI5TQCK+dSsxvyvlluCfD+VgkXPoR12b+DwbA3Md+C
        2pgcqg4IWckbwclxa+0Ze47hqg/MDVZX1hjE+IOPNcIXx7Ym7wOfO4c6PpfTj0zzyQ1KXjejp4uUY
        bMuhyViEn3QrHoEvm56m3c5709PfUcw6faBvMOQ6UOIWhBKqDrcoPEngc3JK1kquNKh8mydb1DQvs
        zwXb/+KA==;
Received: from [2601:1c0:6280:3f0::662d]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdSgF-0001Mg-PI; Fri, 13 Nov 2020 06:35:32 +0000
Subject: Re: mmotm 2020-11-12-20-01 uploaded (mm/secretmem.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Mike Rapoport <rppt@kernel.org>
References: <20201113040226.fZi_OALm7%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fde20745-96fc-4e89-51e5-1f1620cb9ce3@infradead.org>
Date:   Thu, 12 Nov 2020 22:35:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201113040226.fZi_OALm7%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/12/20 8:02 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-11-12-20-01 has been uploaded to
> 
>    https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> https://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.

Lots of build errors like this:

when CONFIG_MEMCG is not set/enabled:

../mm/secretmem.c:72:4: error: ‘struct page’ has no member named ‘memcg_data’
../mm/secretmem.c:72:23: error: ‘struct page’ has no member named ‘memcg_data’
../mm/secretmem.c:86:4: error: ‘struct page’ has no member named ‘memcg_data’


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
