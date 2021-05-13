Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C9137FC68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhEMRVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 13:21:32 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:54509 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhEMRVb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 13:21:31 -0400
X-Greylist: delayed 628 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 May 2021 13:21:30 EDT
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fgynp0lCSz9sbh;
        Thu, 13 May 2021 19:09:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HUEn8l5Cd5ay; Thu, 13 May 2021 19:09:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fgynn6lywz9sbZ;
        Thu, 13 May 2021 19:09:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CA6438B7F5;
        Thu, 13 May 2021 19:09:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pzLVMzJYIXGI; Thu, 13 May 2021 19:09:46 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 43A7F8B76C;
        Thu, 13 May 2021 19:09:46 +0200 (CEST)
Subject: Re: mmotm 2021-05-12-21-46 uploaded (arch/x86/mm/pgtable.c)
To:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
References: <20210513044710.MCXhM_NwC%akpm@linux-foundation.org>
 <151ddd7f-1d3e-a6f7-daab-e32f785426e1@infradead.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <54055e72-34b8-d43d-2ad3-87e8c8fa547b@csgroup.eu>
Date:   Thu, 13 May 2021 19:09:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <151ddd7f-1d3e-a6f7-daab-e32f785426e1@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 13/05/2021 à 17:54, Randy Dunlap a écrit :
> On 5/12/21 9:47 PM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2021-05-12-21-46 has been uploaded to
>>
>>     https://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> https://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release (5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>> https://ozlabs.org/~akpm/mmotm/series
> 
> 
> on i386:
> 
> ../arch/x86/mm/pgtable.c:703:5: error: redefinition of ‘pud_set_huge’
>   int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
>       ^~~~~~~~~~~~
> In file included from ../include/linux/mm.h:33:0,
>                   from ../arch/x86/mm/pgtable.c:2:
> ../include/linux/pgtable.h:1387:19: note: previous definition of ‘pud_set_huge’ was here
>   static inline int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
>                     ^~~~~~~~~~~~
> ../arch/x86/mm/pgtable.c:758:5: error: redefinition of ‘pud_clear_huge’
>   int pud_clear_huge(pud_t *pud)
>       ^~~~~~~~~~~~~~
> In file included from ../include/linux/mm.h:33:0,
>                   from ../arch/x86/mm/pgtable.c:2:
> ../include/linux/pgtable.h:1391:19: note: previous definition of ‘pud_clear_huge’ was here
>   static inline int pud_clear_huge(pud_t *pud)
>                     ^~~~~~~~~~~~~~

Hum ...

Comes from my patch 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/5ac5976419350e8e048d463a64cae449eb3ba4b0.1620795204.git.christophe.leroy@csgroup.eu/

But, that happens only if x86 defines __PAGETABLE_PUD_FOLDED. And if PUD is folded, then I can't 
understand my it has pud_set_huge() and pud_clear_huge() functions.

Christophe
