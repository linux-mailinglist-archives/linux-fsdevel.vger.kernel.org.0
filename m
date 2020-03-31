Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960FF199C0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgCaQso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 12:48:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbgCaQsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=iBIZjEbhUqZOtk5V18poldKYJqWr17L3xpH+eAdVvpQ=; b=VoE/pOwTmbEoLZztds+Z6FQ5Oo
        uqKJwve38PohsGjqmKA7k0xNE+sgE/Tq3j+draqv3XUq/XZ7bZl7K18U+4GiyNjDi5zTQ+quHOrTB
        5oddyo7yRn8muBXIkO5DRQ3juwcUS7bRtAKmlrQmEy6+ZYvnyLvgSJzjBfHm9PZx7T1rV6Klxm6ve
        imTPF+rxbLbqtqtxPCR4DLJxiDGD1jUab3iHF6eH6rCWrf6eF4QGt197Oxh9u5cTtKCdcg9mJfKWP
        /OTD5pQmIqLUpba7IMtZBp6X9jl9au+9LHyd86/hCnvw9AH7dyValneKa8S46/t3cQlgD54BvPoUU
        yxFbkeKA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJK4B-0001WE-2W; Tue, 31 Mar 2020 16:48:43 +0000
Subject: Re: mmotm 2020-03-30-18-46 uploaded (freesync)
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200331014748.ajL0G62jF%akpm@linux-foundation.org>
 <a266d6a4-6d48-aadc-afd7-af0eb7c2d9db@infradead.org>
 <20200331073938.GA54733@ubuntu-m2-xlarge-x86>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <710856c8-b1d9-d03d-457c-99e55a2ff274@infradead.org>
Date:   Tue, 31 Mar 2020 09:48:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331073938.GA54733@ubuntu-m2-xlarge-x86>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/31/20 12:39 AM, Nathan Chancellor wrote:
> On Mon, Mar 30, 2020 at 11:18:26PM -0700, Randy Dunlap wrote:
>> On 3/30/20 6:47 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2020-03-30-18-46 has been uploaded to
>>>
>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>> http://ozlabs.org/~akpm/mmotm/series
>>>
>>
>> on i386:
>>
>> ld: drivers/gpu/drm/amd/display/modules/freesync/freesync.o: in function `mod_freesync_build_vrr_params':
>> freesync.c:(.text+0x790): undefined reference to `__udivdi3'
>>
>>
>> Full randconfig file is attached.
>>
>> -- 
>> ~Randy
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Hi Randy,
> 
> I am guessing this should fix it since I ran into this on arm
> allyesconfig:
> 
> https://lore.kernel.org/lkml/20200330221614.7661-1-natechancellor@gmail.com/

works for me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


> FWIW, not an mmotm issue since the patch comes from the AMD tree.

Right.

-- 
~Randy
