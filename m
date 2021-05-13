Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164DB37F298
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 07:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhEMF3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 01:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhEMF3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 01:29:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944DEC061574;
        Wed, 12 May 2021 22:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=3/MkI0zBK9KSY7tn5DaMum2sGQADBHMyu8wks7SvDhk=; b=LLOL2fvXiZpPmx1UKjgkMPPvL4
        rCERQCNbwPu3iY/I/xEwpwl3zbgp0wU86L6yIJ940FyR85iBrcZZqk+cjipYtkpHe6nReqbzfgf0P
        zCb5oA4PBI00pC8k62OT+CTY98zO4TradqCIzKpolU4P+po5d6CgVppnAYxCzg5t3/cV9T2Lfy0gp
        P4++pFyp5iq+x0fySG+mxYGNZji1LU9xAccBhxtTDxWDXolg3Hs1YjlOlaqoLZvC98lQALJxnI/QP
        kaZjz73AY/a8jeHxb7mo9U2Fdj6S6NKxD+3LaMYb731uzNGfHIQoxKjt8kn9tHr1VUmrLKtpxHWz+
        XapgeQ+Q==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lh3tg-00B1cV-K7; Thu, 13 May 2021 05:28:32 +0000
Subject: Re: mmotm 2021-05-12-21-46 uploaded (mm/memory_failure.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
References: <20210513044710.MCXhM_NwC%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <91fd4441-b84b-ceb0-8d4c-c62e631711fc@infradead.org>
Date:   Wed, 12 May 2021 22:28:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210513044710.MCXhM_NwC%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/12/21 9:47 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2021-05-12-21-46 has been uploaded to
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

on x86_64:
# CONFIG_HUGETLBFS is not set

../mm/memory-failure.c: In function ‘__get_hwpoison_page’:
../mm/memory-failure.c:962:15: error: ‘hugetlb_lock’ undeclared (first use in this function); did you mean ‘huge_pte_lock’?
    spin_lock(&hugetlb_lock);
               ^~~~~~~~~~~~

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

