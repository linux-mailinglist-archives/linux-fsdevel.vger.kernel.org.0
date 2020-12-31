Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E675F2E8209
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Dec 2020 21:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgLaUua (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Dec 2020 15:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgLaUua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Dec 2020 15:50:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E08C061575;
        Thu, 31 Dec 2020 12:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=uRKoJvU7TdaCONZ8ed5/ubeZ6GnkrfHObj5AFY5rUu0=; b=X8vzhElJYLFHKKG/lqG6qK4gIy
        Hp1g3z2rjL0mhK8KIm7S5lO+nr2gaPez7Kq/YIo4f+QB/+q+BwgDaYVNuEQ2EUuuDmbRujByU8x7R
        S0ke8wr/44V4DJ2icDuqUZDtkmiwfZBpPTO6Rk5o2++JQXjP1c9oT77JDglbZ30NE9nZTMZ2573mh
        MlJt782VR7Jy8P7aDt7Cb+qy3NnhBZxq+RrpxrVdwIx0DmmUVatbTvKs79hEKZbHPX4/YBOcF65pN
        M3CmfeQBabzYxF5PZx5VZCPQV+yphDo2rIjR17isIzKWulLs/xOpf+uynu1ywfEpIOZhpzyZodCzm
        7qUIghsA==;
Received: from [2601:1c0:6280:3f0::2c43]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kv4tG-00160z-DR; Thu, 31 Dec 2020 20:49:47 +0000
Subject: Re: mmotm 2020-12-31-11-52 uploaded (mm/cma.c)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
References: <20201231195330.PHhcH%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <75e72a00-8758-7d67-388a-55dc6b35be57@infradead.org>
Date:   Thu, 31 Dec 2020 12:49:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201231195330.PHhcH%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/31/20 11:53 AM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-12-31-11-52 has been uploaded to
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

../mm/cma.c: In function ‘cma_declare_contiguous_nid’:
../mm/cma.c:347:5: warning: "CONFIG_PHYS_ADDR_T_64BIT" is not defined, evaluates to 0 [-Wundef]
 #if CONFIG_PHYS_ADDR_T_64BIT
     ^~~~~~~~~~~~~~~~~~~~~~~~


s/#if/#ifdef/


-- 
~Randy

