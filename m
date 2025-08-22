Return-Path: <linux-fsdevel+bounces-58728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CE1B30A79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0462189F0D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B44D18DB1C;
	Fri, 22 Aug 2025 00:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YFy3QMvR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B00126C1E;
	Fri, 22 Aug 2025 00:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755823475; cv=none; b=Jqm/mI5XP8Fmd6w56HgrWEUvYCUOPR7rzCoxQTkKXLBvomjbWdOZp7hPQXzI+wnyAM2UWTPGOoM4HImuA3bDZw7gqbyHJmiJJz01c1M1xx2xRg1Tw3vXZydz2XfYKnxH2RzcbAzMnaA48lEKHwOXurV0ARLkRTWMh0tcBL5nfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755823475; c=relaxed/simple;
	bh=uMC1ezpW2pO2VtZK/21zRYvhwNfw1yRfk7llACC6iYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+UU08wcJv+ePjG8VDarGx/bINqoJywwOskHhD/Hftidlx9l6Uta1P522JpT2CrxfQZwQZOyWnziEdUE9EnD5gl9ZxXBf9A3sQDEsZw3eLpdfrJ5IdsgI/Mc380EkDmY+mz0sra6+nEOD3Wp/iacMYxDjVg7/p3GrVniy2Kkgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YFy3QMvR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IZGbXBIKVnEINSWfL77Ztazh/k5cgk5rloyUoDalXc4=; b=YFy3QMvRtEzTXGLqQ1xgWFxvfh
	7Y68belj5u3TMqGpNWEK5q+kCuhRFWecRWpw6lZOPO4hlx8v5FQ2MLfKp8r1deXUlmmB+WDWBVUAx
	O07mK3wV3+OtRQIc8KHWxCt2liRj1gPDcA2F0URJxU9JSQKCQr/FWSLu/B6X2CcJEFe5ISe6/kFJe
	+Zv25yI488fl6j/uc9dMJXaASiROUxjTMuAJJmjS9mwEnkiD+nBxVZpTfiBZ+AWZY6emRNIWFuj/x
	sHsT8OrE7SsLs1CfI2a4RB3ZVE5zkntXCqQ/0SDQ6uvhnhkkK9ij5ZXpDbvpuxdjMlpI6AiycbfoA
	nI8sJ/bQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upFtP-0000000143i-1nwQ;
	Fri, 22 Aug 2025 00:44:31 +0000
Message-ID: <23072476-627c-4d2a-a8b4-e337dfca7853@infradead.org>
Date: Thu, 21 Aug 2025 17:44:29 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
To: Rob Landley <rob@landley.net>, Christian Brauner <brauner@kernel.org>,
 Lichen Liu <lichliu@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 safinaskar@zohomail.com, kexec@lists.infradead.org, weilongchen@huawei.com,
 cyphar@cyphar.com, linux-api@vger.kernel.org, zohar@linux.ibm.com,
 stefanb@linux.ibm.com, initramfs@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
References: <20250815121459.3391223-1-lichliu@redhat.com>
 <20250821-zirkel-leitkultur-2653cba2cd5b@brauner>
 <da1b1926-ba18-4a81-93e0-56cb2f85e4dd@landley.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <da1b1926-ba18-4a81-93e0-56cb2f85e4dd@landley.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rob,


On 8/21/25 12:02 PM, Rob Landley wrote:
> On 8/21/25 03:24, Christian Brauner wrote:
>> This seems rather useful but I've renamed "rootfsflags" to
> 
> I remember when bikeshedding came in the form of a question.
> 
>> "initramfs_options" because "rootfsflags" is ambiguous and it's not
>> really just about flags.
> 
> The existing config option (applying to the fallback root=/dev/blah filesystem overmounting rootfs) is called "rootflags", the new name differs for the same reason init= and rdinit= differ.
> 
> The name "rootfs" has been around for over 20 years, as evidenced in https://kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt and so on. Over the past decade least three independently authored patches have come up with the same name for this option. Nobody ever suggested a name where people have to remember whether it has _ or - in it.

Either is accepted. From Documentation/admin-guide/kernel-parameters.rst:

Special handling
----------------

Hyphens (dashes) and underscores are equivalent in parameter names, so::

	log_buf_len=1M print-fatal-signals=1

can also be entered as::

	log-buf-len=1M print_fatal_signals=1


> Technically initramfs is the name of the cpio extractor and related plumbing, the filesystem instance identifies itself as "rootfs" in
> /proc/mounts:
> 
> $ head -n 1 /proc/mounts
> rootfs / rootfs rw,size=29444k,nr_inodes=7361 0 0
> 
> I.E. rootfs is an instance of ramfs (or tmpfs) populated by initramfs.
> 
> Given that rdinit= is two letters added to init= it made sense for rootfsflags= to be two letters added to rootflags= to distinguish them.
> 
> (The "rd" was because it's legacy shared infrastructure with the old 1990s initial ramdisk mechanism ala /dev/ram0. The same reason bootloaders like grub have an "initrd" command to load the external cpio.gz for initramfs when it's not statically linked into the kernel image: the delivery mechanism is the same, the kernel inspects the file type to determine how to handle it. This new option _isn't_ legacy, and "rootfs" is already common parlance, so it seemed obvious to everyone with even moderate domain familiarity what to call it.)
> 
>> Other than that I think it would make sense to just raise the limit to
>> 90% for the root_fs_type mount. I'm not sure why this super privileged
>> code would only be allowed 50% by default.
> 
> Because when a ram based filesystem pins all available memory the kernel deadlocks (ramfs always doing this was one of the motivations to use tmpfs, but tmpfs doesn't mean you have swap), because the existing use cases for this come from low memory systems that already micromanage this sort of thing so a different default wouldn't help, because it isn't a domain-specific decision but was inheriting the tmpfs default value so you'd need extra code _to_ specify a different default, because you didn't read the answer to the previous guy who asked this question earlier in this patch's discussion...
> 
> https://lkml.org/lkml/2025/8/8/1050
> 
> Rob

Thanks for the explanations.

> P.S. It's a pity lkml.iu.edu and spinics.net are both down right now, but after vger.kernel.org deleted all reference to them I can't say I'm surprised. Neither lkml.org nor lore.kernel.org have an obvious threaded interface allowing you to find stuff without a keyword search, and lore.kernel.org somehow manages not to list "linux-kernel" in its top level list of "inboxes" at all. The wagons are circled pretty tightly...
Yep, they down for me also. :(
linux-kernel is called lkml of lore. It would be nice if they were synonyms.
If you go to https://lore.kernel.org/lkml/, you can use the search box to look for
"s:rootfsflags" or just use a browser's Search (usually Ctrl-F) to search for
"rootflags". Then the email thread is visible.
Or just do a huge $search_engine search for something close to
the $Subject -- or some text from the body of the message. But you probably
know all of this.


If you go to lkml.org and click on "Last 100 messages", then scroll down to
	Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options	Rob Landley
you can read the email thread for this message (see left side panel).
Or you can find it by date (if you have any idea what the date was).

cheers.

-- 
~Randy


