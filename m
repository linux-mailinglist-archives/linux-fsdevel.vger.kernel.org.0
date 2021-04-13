Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACAD35DB1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbhDMJ0d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 05:26:33 -0400
Received: from smtp81.ord1c.emailsrvr.com ([108.166.43.81]:59102 "EHLO
        smtp81.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239308AbhDMJ0d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1618305384;
        bh=QXGo3zNi/KJgYClnZP5yTyPQTb/XfbzL7t7ZBTImJ9U=;
        h=Subject:To:From:Date:From;
        b=VLAZMi3SCjUw+2opoShtg738e7WxEt+NYuLynoqp0ozC7Fb+qdushv/ChWcvw88Ow
         tflGO9rfzLIf+ifNhVxq1G+h+QgMj3eibsFuBN5KfI97JC+ZiX30ZtTQZxNCQYWXGu
         eDuBzaCMsikmNlnlCQPcbiId0hBkNBwBmOaOOFBY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp27.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id EF079400F3;
        Tue, 13 Apr 2021 05:16:22 -0400 (EDT)
Subject: Re: mmotm 2021-04-11-20-47 uploaded (ni_routes_test.c)
To:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, Spencer Olson <olsonse@umich.edu>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
References: <20210412034813.EK9k9%akpm@linux-foundation.org>
 <9ad69f10-ef0a-548a-0928-ddb9106e3311@infradead.org>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <f2201ff8-f61e-dda7-4165-61a344def0ce@mev.co.uk>
Date:   Tue, 13 Apr 2021 10:16:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <9ad69f10-ef0a-548a-0928-ddb9106e3311@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 70b10d23-5d40-4148-8623-67b56555bf91-1-1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/04/2021 18:27, Randy Dunlap wrote:
> On 4/11/21 8:48 PM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2021-04-11-20-47 has been uploaded to
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
>>
>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>> followed by the base kernel version against which this patch series is to
>> be applied.
>>
>> This tree is partially included in linux-next.  To see which patches are
>> included in linux-next, consult the `series' file.  Only the patches
>> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
>> linux-next.
>>
>>
>> A full copy of the full kernel tree with the linux-next and mmotm patches
>> already applied is available through git within an hour of the mmotm
>> release.  Individual mmotm releases are tagged.  The master branch always
>> points to the latest release, so it's constantly rebasing.
>>
>> 	https://github.com/hnaz/linux-mm
>>
>> The directory https://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
>> contains daily snapshots of the -mm tree.  It is updated more frequently
>> than mmotm, and is untested.
>>
>> A git copy of this tree is also available at
>>
>> 	https://github.com/hnaz/linux-mm
> 
> on x86_64:
> 
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o: in function `test_ni_route_to_register':
> ni_routes_test.c:(.text+0x103): undefined reference to `ni_route_to_register'
> ld: ni_routes_test.c:(.text+0x13a): undefined reference to `ni_route_to_register'
> ld: ni_routes_test.c:(.text+0x171): undefined reference to `ni_route_to_register'
> ld: ni_routes_test.c:(.text+0x1a8): undefined reference to `ni_route_to_register'
> ld: ni_routes_test.c:(.text+0x1df): undefined reference to `ni_route_to_register'
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o:ni_routes_test.c:(.text+0x216): more undefined references to `ni_route_to_register' follow
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o: in function `test_ni_find_route_source':
> ni_routes_test.c:(.text+0x47d): undefined reference to `ni_find_route_source'
> ld: ni_routes_test.c:(.text+0x4b2): undefined reference to `ni_find_route_source'
> ld: ni_routes_test.c:(.text+0x4ec): undefined reference to `ni_find_route_source'
> ld: ni_routes_test.c:(.text+0x526): undefined reference to `ni_find_route_source'
> ld: ni_routes_test.c:(.text+0x560): undefined reference to `ni_find_route_source'
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o: in function `test_ni_get_valid_routes':
> ni_routes_test.c:(.text+0x59f): undefined reference to `ni_get_valid_routes'
> ld: ni_routes_test.c:(.text+0x5d5): undefined reference to `ni_get_valid_routes'
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o: in function `test_ni_is_cmd_dest':
> ni_routes_test.c:(.text+0x659): undefined reference to `ni_is_cmd_dest'
> ld: ni_routes_test.c:(.text+0x684): undefined reference to `ni_is_cmd_dest'
> ld: ni_routes_test.c:(.text+0x6af): undefined reference to `ni_is_cmd_dest'
> ld: ni_routes_test.c:(.text+0x6da): undefined reference to `ni_is_cmd_dest'
> ld: ni_routes_test.c:(.text+0x705): undefined reference to `ni_is_cmd_dest'
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o:ni_routes_test.c:(.text+0x730): more undefined references to `ni_is_cmd_dest' follow
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o: in function `test_ni_lookup_route_register':
> ni_routes_test.c:(.text+0x771): undefined reference to `ni_lookup_route_register'
> ld: ni_routes_test.c:(.text+0x7a8): undefined reference to `ni_lookup_route_register'
> ld: ni_routes_test.c:(.text+0x7df): undefined reference to `ni_lookup_route_register'
> ld: ni_routes_test.c:(.text+0x816): undefined reference to `ni_lookup_route_register'
> ld: ni_routes_test.c:(.text+0x84d): undefined reference to `ni_lookup_route_register'
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o:ni_routes_test.c:(.text+0x884): more undefined references to `ni_lookup_route_register' follow
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o: in function `test_ni_route_set_has_source':
> ni_routes_test.c:(.text+0xa3c): undefined reference to `ni_route_set_has_source'
> ld: ni_routes_test.c:(.text+0xa6e): undefined reference to `ni_route_set_has_source'
> ld: ni_routes_test.c:(.text+0xaa0): undefined reference to `ni_route_set_has_source'
> ld: ni_routes_test.c:(.text+0xad2): undefined reference to `ni_route_set_has_source'
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o: in function `test_ni_find_route_set':
> ni_routes_test.c:(.text+0xb0a): undefined reference to `ni_find_route_set'
> ld: ni_routes_test.c:(.text+0xb3d): undefined reference to `ni_find_route_set'
> ld: ni_routes_test.c:(.text+0xb74): undefined reference to `ni_find_route_set'
> ld: ni_routes_test.c:(.text+0xbb2): undefined reference to `ni_find_route_set'
> ld: ni_routes_test.c:(.text+0xbfa): undefined reference to `ni_find_route_set'
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o: in function `test_ni_assign_device_routes':
> ni_routes_test.c:(.text+0xc6c): undefined reference to `ni_assign_device_routes'
> ld: ni_routes_test.c:(.text+0xeb6): undefined reference to `ni_assign_device_routes'
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o: in function `test_ni_count_valid_routes':
> ni_routes_test.c:(.text+0xf9c): undefined reference to `ni_count_valid_routes'
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o: in function `ni_get_reg_value_roffs.constprop.7':
> ni_routes_test.c:(.text+0xfef): undefined reference to `ni_find_route_source'
> ld: ni_routes_test.c:(.text+0x1015): undefined reference to `ni_route_to_register'
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o: in function `test_route_is_valid':
> ni_routes_test.c:(.text+0x1074): undefined reference to `ni_route_to_register'
> ld: ni_routes_test.c:(.text+0x10ab): undefined reference to `ni_route_to_register'
> ld: ni_routes_test.c:(.text+0x10e2): undefined reference to `ni_route_to_register'
> ld: ni_routes_test.c:(.text+0x1119): undefined reference to `ni_route_to_register'
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o: in function `test_route_register_is_valid':
> ni_routes_test.c:(.text+0x115a): undefined reference to `ni_find_route_source'
> ld: ni_routes_test.c:(.text+0x118e): undefined reference to `ni_find_route_source'
> ld: ni_routes_test.c:(.text+0x11c5): undefined reference to `ni_find_route_source'
> ld: ni_routes_test.c:(.text+0x11fc): undefined reference to `ni_find_route_source'
> ld: drivers/staging/comedi/drivers/tests/ni_routes_test.o: in function `test_ni_sort_device_routes':
> ni_routes_test.c:(.text+0x16ef): undefined reference to `ni_sort_device_routes'
> 
> 
> Full randconfig file is attached.

Hi all,

That should be fixed by commit e7442ffe1cc5 ("staging: comedi: Kconfig: 
Fix COMEDI_TESTS_NI_ROUTES selections") in linux-next master.

Sorry for the trouble!

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
