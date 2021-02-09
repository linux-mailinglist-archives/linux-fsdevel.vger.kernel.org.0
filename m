Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D34D31474C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 05:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhBIEFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 23:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhBIEFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 23:05:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E536EC061788;
        Mon,  8 Feb 2021 20:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=bMQrY5xxsyDu8SQKzHqPdOnXD4jQMrGQMm3kjadDQRg=; b=h8azyEwsxshv+2rXTvkoXaEOel
        lvrShDE2SrJmZUpDB4xlX60rrU8yrEUB3ABc6E7NpyWJK0r8xeZbWak3N1/yiW5hoRmFQErLB+OcW
        GLn92E1W00bgpx4W11hCXw2aicT/wso3KTDCJbQVjzVzBHUfmsXwA+bXYjlhlIVrnsb5YWjq3g+gu
        3rWejYtMXGdZZMJwaKFzQTdGYhmzjooANexaXIjiW23Aa2AngBmklT37UuFOT/59/FNoQIj0Mka/V
        nRZeWcqrjCffYuvKUqpiU5C7afVAbX0YWpx6HYxzSvOoPARSThCmJAmyx+R0ltqb2bdpvZGiCLxY5
        vJtFbdaQ==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9KF8-0002fr-Gv; Tue, 09 Feb 2021 04:03:14 +0000
Subject: Re: mmotm 2021-02-08-15-44 uploaded
 (mm-cma-print-region-name-on-failure.patch)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Patrick Daly <pdaly@codeaurora.org>
References: <20210208234508.iCc6kmL1z%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c85a7dba-2f2a-c518-ab9d-26a0c934adda@infradead.org>
Date:   Mon, 8 Feb 2021 20:03:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208234508.iCc6kmL1z%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/8/21 3:45 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2021-02-08-15-44 has been uploaded to
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
> 
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.

mm-cma-print-region-name-on-failure.patch:

This causes a printk format warning on i386 (these used to be readable):

In file included from ../include/linux/printk.h:7:0,
                 from ../include/linux/kernel.h:16,
                 from ../include/asm-generic/bug.h:20,
                 from ../arch/x86/include/asm/bug.h:93,
                 from ../include/linux/bug.h:5,
                 from ../include/linux/mmdebug.h:5,
                 from ../include/linux/mm.h:9,
                 from ../include/linux/memblock.h:13,
                 from ../mm/cma.c:24:
../mm/cma.c: In function ‘cma_alloc’:
../include/linux/kern_levels.h:5:18: warning: format ‘%zu’ expects argument of type ‘size_t’, but argument 4 has type ‘long unsigned int’ [-Wformat=]
 #define KERN_SOH "\001"  /* ASCII Start Of Header */
                  ^
../include/linux/kern_levels.h:11:18: note: in expansion of macro ‘KERN_SOH’
 #define KERN_ERR KERN_SOH "3" /* error conditions */
                  ^~~~~~~~
../include/linux/printk.h:343:9: note: in expansion of macro ‘KERN_ERR’
  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         ^~~~~~~~
../mm/cma.c:503:3: note: in expansion of macro ‘pr_err’
   pr_err("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
   ^~~~~~
../mm/cma.c:503:45: note: format string is defined here
   pr_err("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
                                           ~~^
                                           %lu

because the type of count is not the same as the type of cma->count.

Furthermore, are you sure that cma->count is the same value as count?
I'm not.


(also s/convienience/convenience/ in the patch description)

thanks.
-- 
~Randy

