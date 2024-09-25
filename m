Return-Path: <linux-fsdevel+bounces-30019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2AE984F61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 02:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E591F24184
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 00:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48B91849;
	Wed, 25 Sep 2024 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ljcXerHw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FA4A00
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 00:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727223427; cv=none; b=ufffjdkI7au8MwtJQesP02FtyQw4zYekYImeDo0O1vhKnNBJ71kXySdtMOMZNkwTjUus8ad66iLZzu5NOa+h4iWXB8tzAQiWJv0SEj5HZkx1Bdwc3+lRjtqhaloZOl+XHqtvy4hvs/tQb7L/OWfXoDdS6BkEtb7fOmhHKnTD988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727223427; c=relaxed/simple;
	bh=5hsxGADZt+3cXhCh9OMkJh0BKnU54ZNs8F09pPAhWtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R37L0ttAbV1ujfAUN6IJ15unP5UeM72ekQFI608IuxkkGSFHwAUouYe+JJJbnPSz67IG1SWs4dH0je9ihmO3l8CtSgA95Iz52eWwV0wMkjr/I+qMeEDDdgiJ99cYZmaHAV80j1Fje93mnX/pz7HR8L51x2jFFb+heRNwvwulDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ljcXerHw; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727223421; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=60RWb77E7KhGEei6RFLPQQOgUZMvtWt1fiPjkJlwGt8=;
	b=ljcXerHwkCYzrIrCYjFCIrurhQJ43oqFq12RyiPVbY8+ub8y6WAHM+imWKgoUmvEVmeN9BUl8CmI4wUP6CKrgCmOstqbvd2lmk5jiHSnce17XhfOByKO+pJqpUb/fyxic8oGynwSXzwO2RCSOtBSuoi0KjG+GUq3Xxlc0/BKPEc=
Received: from 30.244.91.97(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFhOIZM_1727223418)
          by smtp.aliyun-inc.com;
          Wed, 25 Sep 2024 08:17:00 +0800
Message-ID: <e46d20c8-c201-41fd-93ea-6d5bc1e38c6d@linux.alibaba.com>
Date: Wed, 25 Sep 2024 08:16:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Fsnotify changes for 6.12-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
References: <20240923110348.tbwihs42dxxltabc@quack3>
 <CAHk-=wiE1QQ-_kTKSf4Ur6JEjMtieu7twcLqu_CH4r1daTBiCw@mail.gmail.com>
 <20240923191322.3jbkvwqzxvopt3kb@quack3>
 <CAHk-=whm4QfqzSJvBQFrCi4V5SP_iD=DN0VkxfpXaA02PKCb6Q@mail.gmail.com>
 <20240924092757.lev6mwrmhpcoyjtu@quack3>
 <CAHk-=wgzLHTi7s50-BE7oq_egpDnUqhrba+EKux0NyLvgphsEw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAHk-=wgzLHTi7s50-BE7oq_egpDnUqhrba+EKux0NyLvgphsEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

On 2024/9/25 00:33, Linus Torvalds wrote:
> On Tue, 24 Sept 2024 at 02:28, Jan Kara <jack@suse.cz> wrote:
>>
>> On Mon 23-09-24 12:36:14, Linus Torvalds wrote:
>>>
>>> Do we really want to call that horrific fsnotify path for the case
>>> where we already have the page cached? This is a fairly critical
>>> fastpath, and not giving out page cache pages means that now you are
>>> literally violating mmap coherency.
>>>
>>> If the aim is to fill in caches on first access, then if we already
>>> have a page cache page, it's by definition not first access any more!
>>
>> Well, that's what actually should be happening. do_read_fault() will do
>> should_fault_around(vmf) -> yes -> do_fault_around() and
>> filemap_map_pages() will insert all pages in the page cache into the page
>> table page before we even get to filemap_fault() calling our fsnotify
>> hooks.
> 
> That's the fault-around code, yes, and it will populate most pages on
> many filesystems, but it's still optional.
> 
> Not all filesystems have a 'map_pages' function at all (from a quick
> grep at least ceph, erofs, ext2, ocfs2 - although I didn't actually
> validate that my quick grep was right).

Just side note: I think `generic_file_vm_ops` already prepares this
feature, so generic_file_mmap users also have fault around behaviors.

Anyway..

Thanks,
Gao Xiang

