Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9F52B58C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 05:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgKQEUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 23:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgKQEUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 23:20:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53C4C0613CF;
        Mon, 16 Nov 2020 20:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=VJ/8WYCytLsitHhMZNrjI6xJw+7NDmdyC47TyOP1Bss=; b=l3+xTcuopylvTuEGmi4iZmy6xj
        tN7JrXmI1Z8PooKGQaqatc9m1hH4HazWhVyxH9wnyjhxiazUlzIj0Yg16pDP5rAhj0hIC9gxASLxd
        lgr+EJOrTWV04jutNYtx0PcVhk1yw/FqPtyKS2kCdPLiNApt9hWhGCHb7CVQfNGKzk2Web1QVavyg
        GExq2P0Ug5XttjxL2l8xSni/9bWtbgNmmTiGDoauwMGfBnPF/iyXIaCZClx26Pl8SO+rytKvZazfA
        dyzbPMJqEA4N68HXTF5v5ayMS4W3lOw5aN4n9eENTL0U1aP7SCGa6XlGhgXwPNVpndOlK7yrANcD7
        md48QyPg==;
Received: from [2601:1c0:6280:3f0::f32]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kesTZ-0001CQ-M5; Tue, 17 Nov 2020 04:20:18 +0000
Subject: Re: mmotm 2020-11-16-16-47 uploaded (m/secretmem.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Mike Rapoport <rppt@kernel.org>
References: <20201117004837.VMxSd_ozW%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e7cc79ce-2448-98bc-6ae9-306f6991986f@infradead.org>
Date:   Mon, 16 Nov 2020 20:20:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117004837.VMxSd_ozW%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/20 4:48 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-11-16-16-47 has been uploaded to
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
> 
> 
> A full copy of the full kernel tree with the linux-next and mmotm patches
> already applied is available through git within an hour of the mmotm
> release.  Individual mmotm releases are tagged.  The master branch always
> points to the latest release, so it's constantly rebasing.
> 
> 	https://github.com/hnaz/linux-mm
> 
> The directory https://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
> contains daily snapshots of the -mm tree.  It is updated more frequently
> than mmotm, and is untested.
> 


on x86_64:

as reported on 2020-11-12:

when CONFIG_MEMCG is not set:

../mm/secretmem.c: In function ‘secretmem_memcg_charge’:
../mm/secretmem.c:72:4: error: ‘struct page’ has no member named ‘memcg_data’
   p->memcg_data = page->memcg_data;
    ^~
../mm/secretmem.c:72:23: error: ‘struct page’ has no member named ‘memcg_data’
   p->memcg_data = page->memcg_data;
                       ^~
../mm/secretmem.c: In function ‘secretmem_memcg_uncharge’:
../mm/secretmem.c:86:4: error: ‘struct page’ has no member named ‘memcg_data’
   p->memcg_data = 0;
    ^~


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
