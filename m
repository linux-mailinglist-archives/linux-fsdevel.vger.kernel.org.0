Return-Path: <linux-fsdevel+bounces-47763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEBCAA5671
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AAE1C02D7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D010A26AA83;
	Wed, 30 Apr 2025 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bm7AUtyf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58251DE891
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746047212; cv=none; b=UtnEmo2uyL38ce6OoNmb74I3QE9lNSRmuvS7tTMl1hYBZLS/iUqb587QAidlQj81rSHk5YpYnaKz24o2iUb4mmanzFhR1z3pAlJZQwb4Sh4p/LXOYqMmMf4HOx/kfuju9hqZlBJMAtaCpmHG1CmKrjf9cjoNm7GAczkb/9S08/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746047212; c=relaxed/simple;
	bh=mTyJDEtXg9QplZ+sAVFBykImRpGaev1FnKVSq5MyJOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0G/TUdIkR+lrVFX08ZyhUNQkdjew4EP/pm7C1FrDy8oiB1evbYKA+wF/Mep2Z7KVQLKGdsOEBoISfQIrnJJqh0wcHDV9EQrmWWQG7RE3PzMWk6rTfuptGImLj9cYIy/BgSECM1xPtBbRGqUy3HHZMXDgLIwDWFeHM4C4KtaFhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bm7AUtyf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746047211; x=1777583211;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mTyJDEtXg9QplZ+sAVFBykImRpGaev1FnKVSq5MyJOk=;
  b=Bm7AUtyfQS+sgMuPuJdr/STwaOLsiChPTIymjZID5awWUfm5ZsdyzeeZ
   IYht8qSPNDK4pqZL6SfKf9U7mI6bETxR2sKFk2u19GmY8ClVSZY9n70or
   taUdcOg6rgxS4WVdE57C7O+rbUQqi6/RtlHvAdfZ4Y2UjccpEzsmyDIE1
   vbfGlc9+BSg0XO66hrj3d2ncBXHLDrg7fXBbNFvxUKnucMnUzKMom8jUs
   K89zkmiwF4aA9K1YrwHqjqNzKPmQLT2DA+8f/BUS/CuEK81wPL+BMxiF8
   tUdizrsBmtlJaSZA1Wj1PDhSp9eRAVM4JnmRagyeEqlR8TKpEus2sUjsy
   Q==;
X-CSE-ConnectionGUID: X2oLgUUTQSq3fb/lvGiIpQ==
X-CSE-MsgGUID: dnHKZgE6RuKC9NIIhpcnFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="65256248"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="65256248"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 14:06:49 -0700
X-CSE-ConnectionGUID: dIJ5/3RgQz67iopru3HvMQ==
X-CSE-MsgGUID: EMMPyNccRtiXNCpu8mI+Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="139200525"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.124.223.193]) ([10.124.223.193])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 14:06:46 -0700
Message-ID: <86a9656f-211c-4af5-9d19-9565e83fb56d@intel.com>
Date: Wed, 30 Apr 2025 14:06:43 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] orangefs: page writeback problem in 6.14 (bisected
 to 665575cf)
To: Mike Marshall <hubcap@omnibond.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, devel@lists.orangefs.org
References: <CAOg9mSTLUOEobom72-MekLpdH-FuF0S+JkU4E13PK6KzNqT1pw@mail.gmail.com>
 <2040f153-c50e-49ea-acb6-72914c62fecb@intel.com>
 <CAOg9mSRPok2NR5UNkkyBb8nGgZxQo36dfvL0ZWSpMZ3pT5884Q@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAOg9mSRPok2NR5UNkkyBb8nGgZxQo36dfvL0ZWSpMZ3pT5884Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/25 13:43, Mike Marshall wrote:
> [ 1991.319111] orangefs_writepage_locked: wr->pos:0: len:4080:
> [ 1991.319450] service_operation: file_write returning: 0 for 0000000018e1923a.
> [ 1991.319457] orangefs_writepage_locked: wr->pos:4080: len:4080:

Is that consistent with an attempt to write 4080 bytes that failed,
returned a 0 and then encountered the WARN_ON()?

While I guess it's possible that userspace might be trying to write
4080 bytes twice, the wr->pos:4080 looks suspicious. Is it possible
that wr->pos inadvertently got set to 4080 during the write _failure_?
Then, the write (aiming to write the beginning of the file) retries
but pos==4080 and not 0.

> [ 1991.319581] Call Trace:
> [ 1991.319583]  <TASK>
...
> [ 1991.319613]  orangefs_launder_folio+0x2e/0x50 [orangefs]
> [ 1991.319619]  orangefs_write_begin+0x87/0x150 [orangefs]
> [ 1991.319624]  generic_perform_write+0x81/0x280
> [ 1991.319627]  generic_file_write_iter+0x5e/0xe0
> [ 1991.319629]  orangefs_file_write_iter+0x44/0x50 [orangefs]
> [ 1991.319633]  vfs_write+0x240/0x410
> [ 1991.319636]  ksys_write+0x52/0xc0
> [ 1991.319638]  do_syscall_64+0x62/0x180
> [ 1991.319640]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 1991.319643] RIP: 0033:0x7f218b134f44

This is the path I was expecting. Note that my hackish patch will just
lift the old (pre-regression) faulting from generic_file_write_iter()
up to its caller: orangefs_file_write_iter().

So now I'm doubly curious if that also hides the underlying bug.

