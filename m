Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561DC20B5E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgFZQ3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 12:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgFZQ3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:29:02 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2060DC03E979;
        Fri, 26 Jun 2020 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=aX0k6r1YJ4CEqGeB4aFf2H+m6osTQrznTYtFPosh1II=; b=IVDK+YvYyu/wRs4g7LpfEBP8g1
        FcErEcse6PE7u7TIr9XAJ8rivGYSHmNaVZpFRQRAAWhTjC6A3YGvnfo694KRxA7LrD5DW13mRPpJq
        D0O1w14UcJbKgqDoFLyWTZ59L5i7hmRqKGoQp3rowyjgEGlcj9DVUDfHUu5P5aqNnO5sd2eCC237K
        s+XjYFp7MKFCi28ctkbT2VQL0c6LKOsNGobFD7rwbV1ZlWORCh491F1QHSx30x4j49kO8xxIU6NR7
        2i7Gl/PXDHzBlZwtQMMb5maN6aonslLOgOhDlhhHp2XbUyLRwCEAh03yQbHVfSobzfpBa0i/+t9ze
        WExSqWXg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jorDV-0007Ca-3A; Fri, 26 Jun 2020 16:28:42 +0000
Subject: Re: mmotm 2020-06-25-20-36 uploaded (mm/slab.c)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20200626033744.URfGO%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7ff248c7-d447-340c-a8e2-8c02972aca70@infradead.org>
Date:   Fri, 26 Jun 2020 09:28:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626033744.URfGO%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/25/20 8:37 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-06-25-20-36 has been uploaded to
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


when CONFIG_NUMA is not set/enabled:

../mm/slab.c: In function ‘___cache_free’:
../mm/slab.c:3471:2: error: implicit declaration of function ‘__free_one’; did you mean ‘__free_page’? [-Werror=implicit-function-declaration]
  __free_one(ac, objp);
  ^~~~~~~~~~


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
