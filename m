Return-Path: <linux-fsdevel+bounces-45371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563B4A76B07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 17:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A6A18933FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D31214A74;
	Mon, 31 Mar 2025 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FZNqYmJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7041E5205;
	Mon, 31 Mar 2025 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435220; cv=none; b=gVDT6Y5dF2hiU5bSEGbs9XCtlPZ6HP9eW6oviiP6FmgGp4pZFUamd1b+gyq7GUlpwW+UHxRAuxirGIss4U73zYooQwbdEe0imx2+ZLi1Y3NgjzAbJdm7pHeiGi3LXoJmCAAo6pKiXZWo3mRpzy0u3xvpjpzJ6rZQYpP9xsf/WAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435220; c=relaxed/simple;
	bh=U1UEt8P4gsroQ0BI/Y83m/YeZXG5tVrYQYGkhV0/kZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZSVSXGjHopb5MOMA3uJ7x26Cry2W/qxMSrTXWmbTWOs6SA9cwhX8YtGgwDNvwld7DBKBBS2pJMuc7zk4drtv6Xr6K9vmHCpWtPxnysn8MWMLzbcH6IQyqMtaePBcXTkFmai9RMoZZb7+HRUTdxXilV1QEiEIhYL/SETwoDLPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FZNqYmJl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7tLAyp8ahBrU8m2shGsX1HN1FCidX+yNQr00fBg+F+Y=; b=FZNqYmJlarkF20kR4rKp7ZEVOK
	eTQolOq46jPj2NFgBodKtWTCNZyxGNyTA6aJYlpKb2L29htSsS8PKkBe1MIWH+H9XFGlEb8JXhBzM
	RsGvZ7dW+Y3rSJFU9/e3sAJeb18srLb5qxgZtJVWA/wJQYjY7OWYIyB+zDn7g4+Jqv85jzU+eBKrg
	8/iz2NEYP0usd0bu/SOVptX4aU6/s7sY4c0upOBn99Ik0LuaEcko6a3bwC3mc8FDwv3UNf3q4Ph8g
	enYf0j/3++znH3Uyuze7YhVmhl/UlZvH7tqBKv4s4m7uGWNghP6GoJDw2tuAjV1Sf77At6gQ5Rj0d
	Om4dKwHA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzH8p-00000006emP-3shj;
	Mon, 31 Mar 2025 15:33:36 +0000
Message-ID: <eab400fa-22e7-4f4c-9507-0bb0421b547a@infradead.org>
Date: Mon, 31 Mar 2025 08:33:31 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: initramfs: update compression and mtime
 descriptions
To: David Disseldorp <ddiss@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250331050330.17161-1-ddiss@suse.de>
 <39c91e20-94b2-4103-8654-5a7bbb8e1971@infradead.org>
 <20250331174951.7818afb1.ddiss@suse.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250331174951.7818afb1.ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/30/25 11:49 PM, David Disseldorp wrote:
> Thanks for the feedback, Randy...
> 
> On Sun, 30 Mar 2025 22:13:19 -0700, Randy Dunlap wrote:
> 
>> Hi,
>>
>> On 3/30/25 10:03 PM, David Disseldorp wrote:
>>> Update the document to reflect that initramfs didn't replace initrd
>>> following kernel 2.5.x.
>>> The initramfs buffer format now supports many compression types in
>>> addition to gzip, so include them in the grammar section.
>>> c_mtime use is dependent on CONFIG_INITRAMFS_PRESERVE_MTIME.
>>>
>>> Signed-off-by: David Disseldorp <ddiss@suse.de>
>>> ---
>>>  .../early-userspace/buffer-format.rst         | 30 ++++++++++++-------
>>>  1 file changed, 19 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/Documentation/driver-api/early-userspace/buffer-format.rst b/Documentation/driver-api/early-userspace/buffer-format.rst
>>> index 7f74e301fdf35..cb31d617729c5 100644
>>> --- a/Documentation/driver-api/early-userspace/buffer-format.rst
>>> +++ b/Documentation/driver-api/early-userspace/buffer-format.rst
>>> @@ -4,20 +4,18 @@ initramfs buffer format
>>>  
>>>  Al Viro, H. Peter Anvin
>>>  
>>> -Last revision: 2002-01-13
>>> -
>>> -Starting with kernel 2.5.x, the old "initial ramdisk" protocol is
>>> -getting {replaced/complemented} with the new "initial ramfs"
>>> -(initramfs) protocol.  The initramfs contents is passed using the same
>>> -memory buffer protocol used by the initrd protocol, but the contents
>>> +With kernel 2.5.x, the old "initial ramdisk" protocol was complemented
>>> +with an "initial ramfs" protocol.  The initramfs contents is passed  
>>
>>                                                              are passed
>>
>>> +using the same memory buffer protocol used by initrd, but the contents
>>>  is different.  The initramfs buffer contains an archive which is  
>>
>>   are different.
> 
> I've not really changed those sentences with this patch, so I don't mind
> if they stay as is, or switch "contents" to "content" or "is" to "are".
> 

Yes, I know that you didn't make any changes there.

>>>  expanded into a ramfs filesystem; this document details the format of
>>>  the initramfs buffer format.  
>>
>> Don't use "format" 2 times above.
> 

Ditto.

> This is also not changed by the patch. I'm happy to send a v2 or have
> these clean-ups squashed in when applied. Will leave it up to the
> maintainers.
> 

Thanks.
-- 
~Randy


