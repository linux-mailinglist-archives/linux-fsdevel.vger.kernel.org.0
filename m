Return-Path: <linux-fsdevel+bounces-60036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77F3B41174
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 02:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71F54863B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 00:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B9628DC4;
	Wed,  3 Sep 2025 00:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mbkEH11K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D38F6F;
	Wed,  3 Sep 2025 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860377; cv=none; b=jzJj5SDfmoOX3fWBFY1dVEdUBXOD89p7hsvqJffiWillNKyQlVr8tRKoh+9ovv2ImWrQoAvjhh9m8X7Tx8jPf84Zhw5r4LAClveBjjja4MbhKYboD/P+IzgLJ3BcYRekT8mZCpl8MZ/+MIlALoARODguQDITr6KcIDZq0kmCizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860377; c=relaxed/simple;
	bh=PugH42xENIf+OCXRedlOuWbHYyYsJWj+/jdkBZIHBis=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gC/TNyoAUpyRreGY9ns0+Dwla6YFPW+2H7gtlcmHsVcdL/WAHbnZLUIlt9NekuZV3Hw1DdKyYPdI0ELFtmhXHKJZwgzNaQugzS/xsWUqAPrUjoYO5woH/W/yTtEgJEioh8W2KgDLGXKI5Xxk5yzb4r/uUAxeJO6GAPODDSdezsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mbkEH11K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7g500YtFl4xjZhoMUsfNDkWOzPzNY/Ev3Nu9ILchDjw=; b=mbkEH11KD3di6bssQbFvXcCmtq
	NMZqBFjr9rK6Ed0+2Y2dYtPzYbtLjHZxK6VVm7AcjUXgXYd1k8lPpg1G/VOIr2lIcxXMu1JuO2xV9
	LGryk7DfA5zbmTvvl2rFTjtEYsSjiLAfJin2wsBlvyCsouksUwdwv3mvrhZgHL4F5h+mhl8N6FRel
	QGmvYyFrYOkw3bCrk8N34bkUT2Yj6E1cT/W/BLAci6Li8sYVTmBUuo5/21rEvGgwGBGzsUKE60PU1
	ThODkQIaMkjhAK2U78R8UMI7bTABFnL8j2O1rG77aR3RxTCuyygdcFlJE8RNWBDPMNGJZEQ62rLAk
	y5OeYOTg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utbdX-00000002rls-4C5p;
	Wed, 03 Sep 2025 00:46:08 +0000
Message-ID: <a6246609-3ec0-4e38-8733-b2cf3b8fbd9a@infradead.org>
Date: Tue, 2 Sep 2025 17:46:06 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] uapi/fcntl: define RENAME_* and AT_RENAME_* macros
From: Randy Dunlap <rdunlap@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, David Howells <dhowells@redhat.com>,
 linux-api@vger.kernel.org
References: <20250901231457.1179748-1-rdunlap@infradead.org>
 <CAOQ4uxjXvYBsW1Nb2HKaoUg1qi8Pkq1XKtQEbnAvMUGcp7LrZA@mail.gmail.com>
 <5ff4dfe2-271f-4967-bb45-ad59614edc37@infradead.org>
Content-Language: en-US
In-Reply-To: <5ff4dfe2-271f-4967-bb45-ad59614edc37@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/2/25 2:31 PM, Randy Dunlap wrote:
> Hi,
> 
> On 9/1/25 11:58 PM, Amir Goldstein wrote:
>> On Tue, Sep 2, 2025 at 1:14 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> Define the RENAME_* and AT_RENAME_* macros exactly the same as in
>>> recent glibc <stdio.h> so that duplicate definition build errors in
>>> both samples/watch_queue/watch_test.c and samples/vfs/test-statx.c
>>> no longer happen. When they defined in exactly the same way in
>>> multiple places, the build errors are prevented.
>>>
>>> Defining only the AT_RENAME_* macros is not sufficient since they
>>> depend on the RENAME_* macros, which may not be defined when the
>>> AT_RENAME_* macros are used.
>>>
>>> Build errors being fixed:
>>>
>>> for samples/vfs/test-statx.c:
>>>
>>> In file included from ../samples/vfs/test-statx.c:23:
>>> usr/include/linux/fcntl.h:159:9: warning: ‘AT_RENAME_NOREPLACE’ redefined
>>>   159 | #define AT_RENAME_NOREPLACE     0x0001
>>> In file included from ../samples/vfs/test-statx.c:13:
>>> /usr/include/stdio.h:171:10: note: this is the location of the previous definition
>>>   171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
>>> usr/include/linux/fcntl.h:160:9: warning: ‘AT_RENAME_EXCHANGE’ redefined
>>>   160 | #define AT_RENAME_EXCHANGE      0x0002
>>> /usr/include/stdio.h:173:10: note: this is the location of the previous definition
>>>   173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
>>> usr/include/linux/fcntl.h:161:9: warning: ‘AT_RENAME_WHITEOUT’ redefined
>>>   161 | #define AT_RENAME_WHITEOUT      0x0004
>>> /usr/include/stdio.h:175:10: note: this is the location of the previous definition
>>>   175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
>>>
>>> for samples/watch_queue/watch_test.c:
>>>
>>> In file included from usr/include/linux/watch_queue.h:6,
>>>                  from ../samples/watch_queue/watch_test.c:19:
>>> usr/include/linux/fcntl.h:159:9: warning: ‘AT_RENAME_NOREPLACE’ redefined
>>>   159 | #define AT_RENAME_NOREPLACE     0x0001
>>> In file included from ../samples/watch_queue/watch_test.c:11:
>>> /usr/include/stdio.h:171:10: note: this is the location of the previous definition
>>>   171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
>>> usr/include/linux/fcntl.h:160:9: warning: ‘AT_RENAME_EXCHANGE’ redefined
>>>   160 | #define AT_RENAME_EXCHANGE      0x0002
>>> /usr/include/stdio.h:173:10: note: this is the location of the previous definition
>>>   173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
>>> usr/include/linux/fcntl.h:161:9: warning: ‘AT_RENAME_WHITEOUT’ redefined
>>>   161 | #define AT_RENAME_WHITEOUT      0x0004
>>> /usr/include/stdio.h:175:10: note: this is the location of the previous definition
>>>   175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
>>>
>>> Fixes: b4fef22c2fb9 ("uapi: explain how per-syscall AT_* flags should be allocated")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> ---
>>> Cc: Amir Goldstein <amir73il@gmail.com>
>>> Cc: Jeff Layton <jlayton@kernel.org>
>>> Cc: Chuck Lever <chuck.lever@oracle.com>
>>> Cc: Alexander Aring <alex.aring@gmail.com>
>>> Cc: Josef Bacik <josef@toxicpanda.com>
>>> Cc: Aleksa Sarai <cyphar@cyphar.com>
>>> Cc: Jan Kara <jack@suse.cz>
>>> Cc: Christian Brauner <brauner@kernel.org>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Cc: David Howells <dhowells@redhat.com>
>>> CC: linux-api@vger.kernel.org
>>> To: linux-fsdevel@vger.kernel.org
>>>
>>>  include/uapi/linux/fcntl.h |    9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> --- linux-next-20250819.orig/include/uapi/linux/fcntl.h
>>> +++ linux-next-20250819/include/uapi/linux/fcntl.h
>>> @@ -156,9 +156,12 @@
>>>   */
>>>
>>>  /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
>>> -#define AT_RENAME_NOREPLACE    0x0001
>>> -#define AT_RENAME_EXCHANGE     0x0002
>>> -#define AT_RENAME_WHITEOUT     0x0004
>>> +# define RENAME_NOREPLACE (1 << 0)
>>> +# define AT_RENAME_NOREPLACE RENAME_NOREPLACE
>>> +# define RENAME_EXCHANGE (1 << 1)
>>> +# define AT_RENAME_EXCHANGE RENAME_EXCHANGE
>>> +# define RENAME_WHITEOUT (1 << 2)
>>> +# define AT_RENAME_WHITEOUT RENAME_WHITEOUT
>>>
>>
>> This solution, apart from being terribly wrong (adjust the source to match
>> to value of its downstream copy), does not address the issue that Mathew
>> pointed out on v1 discussion [1]:
> 
> I didn't forget or ignore this.
> If the macros have the same values (well, not just values but also the
> same text), then I don't see why it matters whether they are in some older
> version of glibc.
> 
>> $ grep -r AT_RENAME_NOREPLACE /usr/include
>> /usr/include/linux/fcntl.h:#define AT_RENAME_NOREPLACE  0x0001
>>
>> It's not in stdio.h at all.  This is with libc6 2.41-10
>>
>> [1] https://lore.kernel.org/linux-fsdevel/aKxfGix_o4glz8-Z@casper.infradead.org/
>>
>> I don't know how to resolve the mess that glibc has created.
> 
> Yeah, I guess I don't either.
> 
>> Perhaps like this:
>>
>> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
>> index f291ab4f94ebc..dde14fa3c2007 100644
>> --- a/include/uapi/linux/fcntl.h
>> +++ b/include/uapi/linux/fcntl.h
>> @@ -155,10 +155,16 @@
>>   * as possible, so we can use them for generic bits in the future if necessary.
>>   */
>>
>> -/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
>> -#define AT_RENAME_NOREPLACE    0x0001
>> -#define AT_RENAME_EXCHANGE     0x0002
>> -#define AT_RENAME_WHITEOUT     0x0004
>> +/*
>> + * The legacy renameat2(2) RENAME_* flags are conceptually also
>> syscall-specific
>> + * flags, so it could makes sense to create the AT_RENAME_* aliases
>> for them and
>> + * maybe later add support for generic AT_* flags to this syscall.
>> + * However, following a mismatch of definitions in glibc and since no
>> kernel code
>> + * currently uses the AT_RENAME_* aliases, we leave them undefined here.
>> +#define AT_RENAME_NOREPLACE    RENAME_NOREPLACE
>> +#define AT_RENAME_EXCHANGE     RENAME_EXCHANGE
>> +#define AT_RENAME_WHITEOUT     RENAME_WHITEOUT
>> +*/
> 
> Well, we do have samples/ code that uses fcntl.h (indirectly; maybe
> that can be fixed).
> See the build errors in the patch description.
> 
> 
>>  /* Flag for faccessat(2). */
>>  #define AT_EACCESS             0x200   /* Test access permitted for
> 
> With this patch (your suggestion above):
> 
> IF a userspace program in samples/ uses <uapi/linux/fcntl.h> without
> using <stdio.h>, [yes, I created one to test this] and without using
> <uapi/linux/fs.h> then the build fails with similar build errors:
> 
> ../samples/watch_queue/watch_nostdio.c: In function ‘consumer’:
> ../samples/watch_queue/watch_nostdio.c:33:32: error: ‘RENAME_NOREPLACE’ undeclared (first use in this function)
>    33 |                         return RENAME_NOREPLACE;
> ../samples/watch_queue/watch_nostdio.c:33:32: note: each undeclared identifier is reported only once for each function it appears in
> ../samples/watch_queue/watch_nostdio.c:37:32: error: ‘RENAME_EXCHANGE’ undeclared (first use in this function)
>    37 |                         return RENAME_EXCHANGE;
> ../samples/watch_queue/watch_nostdio.c:41:32: error: ‘RENAME_WHITEOUT’ undeclared (first use in this function)
>    41 |                         return RENAME_WHITEOUT;
> 
> This build succeeds with my version 1 patch (full defining of both
> RENAME_* and AT_RENAME_* macros). It fails with the patch that you suggested
> above.
> 
> OK, here's what I propose.
> 
> a. remove the unused and (sort of) recently added AT_RENAME_* macros
> in include/uapi/linux/fcntl.h. Nothing in the kernel tree uses them.
> This is:
> 
> commit b4fef22c2fb9
> Author: Aleksa Sarai <cyphar@cyphar.com>
> Date:   Wed Aug 28 20:19:42 2024 +1000
>     uapi: explain how per-syscall AT_* flags should be allocated
> 
> These macros should have never been added here IMO.
> Just putting them somewhere as examples (in comments) would be OK.
> 
> This alone fixes all of the build errors in samples/ that I originally
> reported.
> 
> b. if a userspace program wants to use the RENAME_* macros, it should
> #include <linux/fs.h> instead of <linux/fcntl.h>.
> 
> This fixes the "contrived" build error that I manufactured.
> 
> Note that some programs in tools/ do use AT_RENAME_* (all 3 macros)
> but they define those macros locally.
> 

And after more testing, this is what I think works:

a. remove all of the AT_RENAME-* macros from <uapi/linux/fcntl.h>
   (as above)

b. put the AT_RENAME_* macros into <uapi/linux/fs.h> like so:

+/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
+# define AT_RENAME_NOREPLACE RENAME_NOREPLACE
+# define AT_RENAME_EXCHANGE RENAME_EXCHANGE
+# define AT_RENAME_WHITEOUT RENAME_WHITEOUT

so that they match what is in upstream glibc stdio.h, hence not
causing duplicate definition errors.


-- 
~Randy


