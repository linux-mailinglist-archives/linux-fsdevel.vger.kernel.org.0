Return-Path: <linux-fsdevel+bounces-13037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFF286A620
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 02:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD521C23FA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 01:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C71210F3;
	Wed, 28 Feb 2024 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1prOQI2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ED3210E1;
	Wed, 28 Feb 2024 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709084959; cv=none; b=QwWA593aLPrHMuXCQ4Ez2Pn3HznQoCqMqqFYf9gOUuHv+nlvfjLhaoSpmRRXfAKThuqwhTHxhkW+X51Nl5TRIDnhfmN+PBPhOZa/XgfpBh9Ajo1kN8eB3Icdb9NhtiuZYd0d+NQoiDtQsVLfNj2W3y8u+4MeRm1tkOOiuOm2VN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709084959; c=relaxed/simple;
	bh=gjgYbrtNhxKWyS5CTNxCrQYKJsq5J+1ei+mqMlM4VEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBhcrTMNsSfR8jQWwe4rLDseoZRCmJQyhwDI5KM83iaIlCC9ntkDGWs8D6pUEfcve7IBxEAZHpVykxJFM2V6FQsN70kyYFJ2mddbSGVHPZ78hh53GG9JMqQXtyS6PZvZfycX83JB0VGRfb07F6Ikjr27NRxej1N2thgw0SubZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1prOQI2c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cms8Ef3fgwsJAymMCfxvOAd2pB9FZVDvl21gvg199Fk=; b=1prOQI2cFuXNlXlNKW6h0DpP3M
	fdaANi4aUnHS9IxP3OGBd4OaSFmaEoJmDGt0TG4yCxM/CzShaI9mZ2FLN48JHKdvdT2ODstAMNnm3
	U1XtaSIlZpGp4iOLnntuBqUzUt396h7bIgcxPsMjtn4WPgNfPzU6fvH8mIMYenDldNsnckCRUpMGY
	Y0vEL5B2V9QWgvq2oW1h+SS9RB08R0MWhPthvhIstet47AxtwSEoABFDKNGSNfMAIGq9g/0/WHnJ5
	lG6ezOo5Ggp/Yg50/fMzQf7LFwv4F0bYpqFTkT8V84q6HEibs97gC2fErgrLNZ1PXfm8d31HV8FTF
	7tjzXGXQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf94B-00000007bsH-17RP;
	Wed, 28 Feb 2024 01:49:03 +0000
Message-ID: <8bd01ff0-235f-4aa8-883d-4b71b505b74d@infradead.org>
Date: Tue, 27 Feb 2024 17:49:02 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/20] famfs: Add fs_context_operations
Content-Language: en-US
To: John Groves <John@groves.net>, Christian Brauner <brauner@kernel.org>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com,
 Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>,
 dave.hansen@linux.intel.com, gregory.price@memverge.com
References: <a645646f071e7baa30ef37ea46ea1330ac2eb63f.1708709155.git.john@groves.net>
 <20240227-mammut-tastatur-d791ca2f556b@brauner>
 <6jrtl2vc4dmi5b6db6tte2ckiyjmiwezbtlwrtmm464v65wkhj@znzv2mwjfgsk>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6jrtl2vc4dmi5b6db6tte2ckiyjmiwezbtlwrtmm464v65wkhj@znzv2mwjfgsk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/27/24 16:59, John Groves wrote:
> On 24/02/27 02:41PM, Christian Brauner wrote:
>> On Fri, Feb 23, 2024 at 11:41:55AM -0600, John Groves wrote:
>>> This commit introduces the famfs fs_context_operations and
>>> famfs_get_inode() which is used by the context operations.
>>>
>>> Signed-off-by: John Groves <john@groves.net>
>>> ---
>>>  fs/famfs/famfs_inode.c | 178 +++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 178 insertions(+)
>>>
>>> diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
>>> index 82c861998093..f98f82962d7b 100644
>>> --- a/fs/famfs/famfs_inode.c
>>> +++ b/fs/famfs/famfs_inode.c
> 
> <snip>
> 

> 
> I wasn't aware of the new fsconfig interface. Is there documentation or a
> file sytsem that already uses it that I should refer to? I didn't find an
> obvious candidate, but it might be me. If it should be obvious from the
> example above, tell me and I'll try harder.

> My famfs code above was copied from ramfs. If you point me to 
> documentation I might send you a ramfs fsconfig patch too :D.

All that I found was the commit to add fsconfig to the kernel tree:

commit ecdab150fddb
Author: David Howells <dhowells@redhat.com>
Date:   Thu Nov 1 23:36:09 2018 +0000

    vfs: syscall: Add fsconfig() for configuring and managing a context

and the lore archive for its discussion:
https://lore.kernel.org/all/153313723557.13253.9055982745313603422.stgit@warthog.procyon.org.uk/


plus David's userspace man page addition for it:
https://lore.kernel.org/linux-fsdevel/159680897140.29015.15318866561972877762.stgit@warthog.procyon.org.uk/


-- 
#Randy

