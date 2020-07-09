Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642712196D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 05:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgGIDsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 23:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgGIDsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 23:48:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE246C061A0B;
        Wed,  8 Jul 2020 20:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=flvZ17SdeYCgDzmst9WBe5pC+viP+SaP3isapAJ36bo=; b=U6G9E2dwPL6X9AOKHmbN8D1Ana
        Xg4JPwui72nhP0L/iVdT9FV8yrai+np3QJiR1EefKNKeylnJ36zU8f8YMzFP0dysE/2CFgv+sPx+e
        YFYA9vVhGsJ4AafRLTno/BB0Rt/TvDIIyYCxZ12e6lrNtYceBcDqvH9J1jDPNYPYJCgEIcsrlGmpm
        uZkfN87QsShxX+JkdLS81p44LK5k5+dHI5qQTvr169inaiUHcNNL4EQmowt3my5j044gs0lMnkbmO
        YTV/bEg8BdAFiS/t+QsC5k/PrAiYKfGejCFTccRcKWtn+Ve6uNKK6Ag3tgrBJ+OEI/y4pyr5Bf47+
        jh9z+j5g==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtNXU-000463-7T; Thu, 09 Jul 2020 03:48:00 +0000
Subject: Re: mmotm 2020-07-08-19-28 uploaded (mm/migrate.c)
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20200709022901.FTEvQ122j%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <11c5e928-1227-286d-ef7d-6d6e554747db@infradead.org>
Date:   Wed, 8 Jul 2020 20:47:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709022901.FTEvQ122j%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/8/20 7:29 PM, Andrew Morton wrote:
> The mm-of-the-moment snapshot 2020-07-08-19-28 has been uploaded to
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

on i386:

CONFIG_MIGRATION=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set

../mm/migrate.c: In function ‘migrate_pages’:
../mm/migrate.c:1528:19: error: ‘THP_MIGRATION_SUCCESS’ undeclared (first use in this function); did you mean ‘PGMIGRATE_SUCCESS’?
   count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
                   ^~~~~~~~~~~~~~~~~~~~~
                   PGMIGRATE_SUCCESS
../mm/migrate.c:1528:19: note: each undeclared identifier is reported only once for each function it appears in
../mm/migrate.c:1530:19: error: ‘THP_MIGRATION_FAILURE’ undeclared (first use in this function); did you mean ‘THP_MIGRATION_SUCCESS’?
   count_vm_events(THP_MIGRATION_FAILURE, nr_thp_failed);
                   ^~~~~~~~~~~~~~~~~~~~~
                   THP_MIGRATION_SUCCESS
../mm/migrate.c:1532:19: error: ‘THP_MIGRATION_SPLIT’ undeclared (first use in this function); did you mean ‘THP_MIGRATION_FAILURE’?
   count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
                   ^~~~~~~~~~~~~~~~~~~
                   THP_MIGRATION_FAILURE


from: mm-vmstat-add-events-for-thp-migration-without-split.patch


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
