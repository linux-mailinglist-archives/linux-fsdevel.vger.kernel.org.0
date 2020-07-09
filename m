Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9192196F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 05:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgGID5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 23:57:37 -0400
Received: from foss.arm.com ([217.140.110.172]:57814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgGID5h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 23:57:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2392F31B;
        Wed,  8 Jul 2020 20:57:36 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC4053F71E;
        Wed,  8 Jul 2020 20:57:32 -0700 (PDT)
Subject: Re: mmotm 2020-07-08-19-28 uploaded (mm/migrate.c)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
References: <20200709022901.FTEvQ122j%akpm@linux-foundation.org>
 <11c5e928-1227-286d-ef7d-6d6e554747db@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <dc6430f5-19e6-2957-1060-1b43c67996be@arm.com>
Date:   Thu, 9 Jul 2020 09:26:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <11c5e928-1227-286d-ef7d-6d6e554747db@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 07/09/2020 09:17 AM, Randy Dunlap wrote:
> On 7/8/20 7:29 PM, Andrew Morton wrote:
>> The mm-of-the-moment snapshot 2020-07-08-19-28 has been uploaded to
>>
>>    http://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> http://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
> 
> on i386:
> 
> CONFIG_MIGRATION=y
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
> 
> ../mm/migrate.c: In function ‘migrate_pages’:
> ../mm/migrate.c:1528:19: error: ‘THP_MIGRATION_SUCCESS’ undeclared (first use in this function); did you mean ‘PGMIGRATE_SUCCESS’?
>    count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>                    ^~~~~~~~~~~~~~~~~~~~~
>                    PGMIGRATE_SUCCESS
> ../mm/migrate.c:1528:19: note: each undeclared identifier is reported only once for each function it appears in
> ../mm/migrate.c:1530:19: error: ‘THP_MIGRATION_FAILURE’ undeclared (first use in this function); did you mean ‘THP_MIGRATION_SUCCESS’?
>    count_vm_events(THP_MIGRATION_FAILURE, nr_thp_failed);
>                    ^~~~~~~~~~~~~~~~~~~~~
>                    THP_MIGRATION_SUCCESS
> ../mm/migrate.c:1532:19: error: ‘THP_MIGRATION_SPLIT’ undeclared (first use in this function); did you mean ‘THP_MIGRATION_FAILURE’?
>    count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
>                    ^~~~~~~~~~~~~~~~~~~
>                    THP_MIGRATION_FAILURE

These events should always be available without any config dependency
including CONFIG_TRANSPARENT_HUGEPAGE. Will fix this and update the
patch.
