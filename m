Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1739635BABE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 09:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbhDLHVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 03:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbhDLHVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:21:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6164DC061574;
        Mon, 12 Apr 2021 00:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=2GY8B3E9p9XFXMEoh2odBgadQRN5Wiz6I5Q9Yv3e8yw=; b=u0zO3p4f/cWozEFmf3kUc73ucs
        GpMLq26ixLj+AZXZEkcljuWx0RCSOfaPWdOZndbNOCa8d7XmYcbUQTdl4nBaTWLd5gY3pgM7OtBJS
        RAQUOp9IfaZ1Amoha/+y0YFHRklIfWLWPyR5DvR8FzTeKW1RDpGwgyssOm5famY2cLNKs/lXleKlW
        +wGgPHukkQ1y2rvvG3h24UB/WSiBNhyOiI4nw0e7jHVvvucyXVNDfGJf0AWx04l4CQPbkWuP0U+/L
        ybfFH7PIGyH6BX5PQWDTBACi4IkgaT/C6DFvw3TH9p7/td00N7Kvq1NMnHwzT1TbWum9no+Zbs27v
        +yQDSK9Q==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVqsl-003vcw-R1; Mon, 12 Apr 2021 07:21:16 +0000
Subject: Re: mmotm 2021-04-11-20-47 uploaded (fs/io_uring.c)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        axboe <axboe@kernel.dk>
References: <20210412034813.EK9k9%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <34ed89e1-683e-7c12-ceb0-f5b71148a8a7@infradead.org>
Date:   Mon, 12 Apr 2021 00:21:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210412034813.EK9k9%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/11/21 8:48 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2021-04-11-20-47 has been uploaded to
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

on i386:
# CONFIG_BLOCK is not set

../fs/io_uring.c: In function ‘kiocb_done’:
../fs/io_uring.c:2766:7: error: implicit declaration of function ‘io_resubmit_prep’; did you mean ‘io_put_req’? [-Werror=implicit-function-declaration]
   if (io_resubmit_prep(req)) {


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
