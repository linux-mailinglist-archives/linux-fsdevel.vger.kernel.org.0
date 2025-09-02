Return-Path: <linux-fsdevel+bounces-60028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92089B40F71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 23:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE925E59B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 21:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE1B35CECA;
	Tue,  2 Sep 2025 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z3ZIi4Dt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71635CEC9;
	Tue,  2 Sep 2025 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848711; cv=none; b=ZeY37mFWkhsYUboFFd3yQURiew7Rqc8XLbYTmI5i782687VRKp4OEiDuebgEkDZ0HwGVY3FtGC/gmMZ2v95tqeDwy9Q4TaMH6vC548Mb6Q+a/72CE5renn6L1foGbzLZy3MPuyfcgH6IEhzyJhzTsbop3zCkBQAizxjjaN3NhwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848711; c=relaxed/simple;
	bh=XvS2ykxSQ8D0kZJ28lamyIN3HLEbAkdHGFIfWkXEVVA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aHXSKVh2Xj1CjUtSazYoB5GprN+VG8jaoSjSQhEUM7O41Bfz3+NFJAN5sWELk79Zz6zvkX8Oy0IJJ9Vl5QvWVFdxYgvS/HaheqPQSuXsYRI+OKCFqs7CRI8WnJ0NSLGbm9O1+0IvBbwVkXKyhuiD7YRp5hxmLkNnPfUGIfsnyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z3ZIi4Dt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IwOCnvYF9S6W7nonbbt0m+MUo4fokGGgzRSWl9ZbWLY=; b=Z3ZIi4Dtxs7xAjizzQcxIyImR0
	7GhvmrCRSqsCRMBMPwv9RuAl5TabaS3XnxBCBgvT7lfVJ2w8d0/MNksj54nXzKC2vlY86fpVoYGM3
	FHiu3Mu0nAWY7DqCcwxl2PrpI9xjZd8o6uXta8bztFYhMgv7qFMu7trz1ALLZykH6JKB7P8TW30ve
	zVe5KYly5eA5QIyvEIT1gfqn1qOR4n121JNAXRGxC6S6k8RVP7M4EbQHs6E+QgDe/vqA0Cz3mmtwU
	oV79xzbtqigkpGsH9hFDTgyYpISwAHLsKPcdSU69RS/y3qwjLOxHUtJDCyqM4OD1shRtHjxyqfH8O
	JqHpzbvw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utYbT-000000027zF-2DGC;
	Tue, 02 Sep 2025 21:31:47 +0000
Message-ID: <5ff4dfe2-271f-4967-bb45-ad59614edc37@infradead.org>
Date: Tue, 2 Sep 2025 14:31:46 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] uapi/fcntl: define RENAME_* and AT_RENAME_* macros
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
Content-Language: en-US
In-Reply-To: <CAOQ4uxjXvYBsW1Nb2HKaoUg1qi8Pkq1XKtQEbnAvMUGcp7LrZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/1/25 11:58 PM, Amir Goldstein wrote:
> On Tue, Sep 2, 2025 at 1:14 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Define the RENAME_* and AT_RENAME_* macros exactly the same as in
>> recent glibc <stdio.h> so that duplicate definition build errors in
>> both samples/watch_queue/watch_test.c and samples/vfs/test-statx.c
>> no longer happen. When they defined in exactly the same way in
>> multiple places, the build errors are prevented.
>>
>> Defining only the AT_RENAME_* macros is not sufficient since they
>> depend on the RENAME_* macros, which may not be defined when the
>> AT_RENAME_* macros are used.
>>
>> Build errors being fixed:
>>
>> for samples/vfs/test-statx.c:
>>
>> In file included from ../samples/vfs/test-statx.c:23:
>> usr/include/linux/fcntl.h:159:9: warning: ‘AT_RENAME_NOREPLACE’ redefined
>>   159 | #define AT_RENAME_NOREPLACE     0x0001
>> In file included from ../samples/vfs/test-statx.c:13:
>> /usr/include/stdio.h:171:10: note: this is the location of the previous definition
>>   171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
>> usr/include/linux/fcntl.h:160:9: warning: ‘AT_RENAME_EXCHANGE’ redefined
>>   160 | #define AT_RENAME_EXCHANGE      0x0002
>> /usr/include/stdio.h:173:10: note: this is the location of the previous definition
>>   173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
>> usr/include/linux/fcntl.h:161:9: warning: ‘AT_RENAME_WHITEOUT’ redefined
>>   161 | #define AT_RENAME_WHITEOUT      0x0004
>> /usr/include/stdio.h:175:10: note: this is the location of the previous definition
>>   175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
>>
>> for samples/watch_queue/watch_test.c:
>>
>> In file included from usr/include/linux/watch_queue.h:6,
>>                  from ../samples/watch_queue/watch_test.c:19:
>> usr/include/linux/fcntl.h:159:9: warning: ‘AT_RENAME_NOREPLACE’ redefined
>>   159 | #define AT_RENAME_NOREPLACE     0x0001
>> In file included from ../samples/watch_queue/watch_test.c:11:
>> /usr/include/stdio.h:171:10: note: this is the location of the previous definition
>>   171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
>> usr/include/linux/fcntl.h:160:9: warning: ‘AT_RENAME_EXCHANGE’ redefined
>>   160 | #define AT_RENAME_EXCHANGE      0x0002
>> /usr/include/stdio.h:173:10: note: this is the location of the previous definition
>>   173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
>> usr/include/linux/fcntl.h:161:9: warning: ‘AT_RENAME_WHITEOUT’ redefined
>>   161 | #define AT_RENAME_WHITEOUT      0x0004
>> /usr/include/stdio.h:175:10: note: this is the location of the previous definition
>>   175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
>>
>> Fixes: b4fef22c2fb9 ("uapi: explain how per-syscall AT_* flags should be allocated")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: Amir Goldstein <amir73il@gmail.com>
>> Cc: Jeff Layton <jlayton@kernel.org>
>> Cc: Chuck Lever <chuck.lever@oracle.com>
>> Cc: Alexander Aring <alex.aring@gmail.com>
>> Cc: Josef Bacik <josef@toxicpanda.com>
>> Cc: Aleksa Sarai <cyphar@cyphar.com>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: David Howells <dhowells@redhat.com>
>> CC: linux-api@vger.kernel.org
>> To: linux-fsdevel@vger.kernel.org
>>
>>  include/uapi/linux/fcntl.h |    9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> --- linux-next-20250819.orig/include/uapi/linux/fcntl.h
>> +++ linux-next-20250819/include/uapi/linux/fcntl.h
>> @@ -156,9 +156,12 @@
>>   */
>>
>>  /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
>> -#define AT_RENAME_NOREPLACE    0x0001
>> -#define AT_RENAME_EXCHANGE     0x0002
>> -#define AT_RENAME_WHITEOUT     0x0004
>> +# define RENAME_NOREPLACE (1 << 0)
>> +# define AT_RENAME_NOREPLACE RENAME_NOREPLACE
>> +# define RENAME_EXCHANGE (1 << 1)
>> +# define AT_RENAME_EXCHANGE RENAME_EXCHANGE
>> +# define RENAME_WHITEOUT (1 << 2)
>> +# define AT_RENAME_WHITEOUT RENAME_WHITEOUT
>>
> 
> This solution, apart from being terribly wrong (adjust the source to match
> to value of its downstream copy), does not address the issue that Mathew
> pointed out on v1 discussion [1]:

I didn't forget or ignore this.
If the macros have the same values (well, not just values but also the
same text), then I don't see why it matters whether they are in some older
version of glibc.

> $ grep -r AT_RENAME_NOREPLACE /usr/include
> /usr/include/linux/fcntl.h:#define AT_RENAME_NOREPLACE  0x0001
> 
> It's not in stdio.h at all.  This is with libc6 2.41-10
> 
> [1] https://lore.kernel.org/linux-fsdevel/aKxfGix_o4glz8-Z@casper.infradead.org/
> 
> I don't know how to resolve the mess that glibc has created.

Yeah, I guess I don't either.

> Perhaps like this:
> 
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index f291ab4f94ebc..dde14fa3c2007 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -155,10 +155,16 @@
>   * as possible, so we can use them for generic bits in the future if necessary.
>   */
> 
> -/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> -#define AT_RENAME_NOREPLACE    0x0001
> -#define AT_RENAME_EXCHANGE     0x0002
> -#define AT_RENAME_WHITEOUT     0x0004
> +/*
> + * The legacy renameat2(2) RENAME_* flags are conceptually also
> syscall-specific
> + * flags, so it could makes sense to create the AT_RENAME_* aliases
> for them and
> + * maybe later add support for generic AT_* flags to this syscall.
> + * However, following a mismatch of definitions in glibc and since no
> kernel code
> + * currently uses the AT_RENAME_* aliases, we leave them undefined here.
> +#define AT_RENAME_NOREPLACE    RENAME_NOREPLACE
> +#define AT_RENAME_EXCHANGE     RENAME_EXCHANGE
> +#define AT_RENAME_WHITEOUT     RENAME_WHITEOUT
> +*/

Well, we do have samples/ code that uses fcntl.h (indirectly; maybe
that can be fixed).
See the build errors in the patch description.


>  /* Flag for faccessat(2). */
>  #define AT_EACCESS             0x200   /* Test access permitted for

With this patch (your suggestion above):

IF a userspace program in samples/ uses <uapi/linux/fcntl.h> without
using <stdio.h>, [yes, I created one to test this] and without using
<uapi/linux/fs.h> then the build fails with similar build errors:

../samples/watch_queue/watch_nostdio.c: In function ‘consumer’:
../samples/watch_queue/watch_nostdio.c:33:32: error: ‘RENAME_NOREPLACE’ undeclared (first use in this function)
   33 |                         return RENAME_NOREPLACE;
../samples/watch_queue/watch_nostdio.c:33:32: note: each undeclared identifier is reported only once for each function it appears in
../samples/watch_queue/watch_nostdio.c:37:32: error: ‘RENAME_EXCHANGE’ undeclared (first use in this function)
   37 |                         return RENAME_EXCHANGE;
../samples/watch_queue/watch_nostdio.c:41:32: error: ‘RENAME_WHITEOUT’ undeclared (first use in this function)
   41 |                         return RENAME_WHITEOUT;

This build succeeds with my version 1 patch (full defining of both
RENAME_* and AT_RENAME_* macros). It fails with the patch that you suggested
above.

OK, here's what I propose.

a. remove the unused and (sort of) recently added AT_RENAME_* macros
in include/uapi/linux/fcntl.h. Nothing in the kernel tree uses them.
This is:

commit b4fef22c2fb9
Author: Aleksa Sarai <cyphar@cyphar.com>
Date:   Wed Aug 28 20:19:42 2024 +1000
    uapi: explain how per-syscall AT_* flags should be allocated

These macros should have never been added here IMO.
Just putting them somewhere as examples (in comments) would be OK.

This alone fixes all of the build errors in samples/ that I originally
reported.

b. if a userspace program wants to use the RENAME_* macros, it should
#include <linux/fs.h> instead of <linux/fcntl.h>.

This fixes the "contrived" build error that I manufactured.

Note that some programs in tools/ do use AT_RENAME_* (all 3 macros)
but they define those macros locally.

-- 
~Randy


