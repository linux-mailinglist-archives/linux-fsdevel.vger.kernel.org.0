Return-Path: <linux-fsdevel+bounces-74772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJsnBptHcGnXXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 04:27:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7705064E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 04:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66CB66C796C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A427FB28;
	Wed, 21 Jan 2026 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A25MxX0J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99D329CB24
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 03:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966025; cv=none; b=AdNOPDcc1qf0okj+RRi9/81qnCnr9wQ2IqNFjNvx6YxFCmtikWDwL1n2+pgc+joMIxSB7e9z7NXVnQy0Pz4Gfupb4HCgQJGDFe+Gtj4hAavxE7GMztRvJvHs9X6HOjINBfDIJnadl+dLXg+B6RKyfiy6dx1D1weX9hJXnZ9Bc7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966025; c=relaxed/simple;
	bh=wpnHVLUImBe3S5D1AvpRLTzEhGkMm4KcVuQ3rZwvy4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIiP5Crst41jR7EkE/y8ajNTs976BlWWHX/Ti02iKsEFqWH3Blc9gnceFO0VJFMLmmCk278J+9r5H8m9z0D3WZ9ncoccffn1FozgJmo/4IuB1hFjrDidE2ZRovBvbdA4nzpb06Xaf4Rmsf6TBZ8KZlENYqw11NR/ey61RPqwwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A25MxX0J; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768966013; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i+e1O65mnnU7hycl4ztRy67aqKTlunuOzJYMMgsUUoM=;
	b=A25MxX0JiyYBxUPzSTZ7rLjJk8WCXhaPUAe7TpZVVUtQ6F4jcy6GuRWMVU3HQQ0rp9PUuoK93RthofgwXcTdd1nSzwM093Lq6ib4TxMk7rQfLaCR5TG6i5xoOTMvJiSnVKO9qOVrnnKHFYtoslG+n9anZUzdaXMLm4QVspC61Q8=
Received: from 30.221.146.111(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WxWTA5-_1768965692 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 Jan 2026 11:21:33 +0800
Message-ID: <90a1bb2f-3c21-4ab8-86e8-b94677c0976b@linux.alibaba.com>
Date: Wed, 21 Jan 2026 11:21:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] fuse: use DIV_ROUND_UP() for page count
 calculations
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
References: <20260116235606.2205801-1-joannelkoong@gmail.com>
 <20260116235606.2205801-2-joannelkoong@gmail.com>
 <2295ba7e-b830-4177-bccb-250fca11b142@linux.alibaba.com>
 <CAJnrk1Y1SkEgEjsJx9Ya4N2Nso08ic+J1PUzYySiyj=MR1ofKA@mail.gmail.com>
 <CAJnrk1YNmN1rcZ8sa8SHzBt-M1AcO9bsQv1090W=po+vFVMr5g@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1YNmN1rcZ8sa8SHzBt-M1AcO9bsQv1090W=po+vFVMr5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-8.96 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TAGGED_FROM(0.00)[bounces-74772-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7C7705064E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Joanne,

Thanks for the replying ;)

On 1/21/26 4:06 AM, Joanne Koong wrote:
> On Tue, Jan 20, 2026 at 11:10 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> On Sun, Jan 18, 2026 at 6:12 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>
>>> On 1/17/26 7:56 AM, Joanne Koong wrote:
>>>> Use DIV_ROUND_UP() instead of manually computing round-up division
>>>> calculations.
>>>>
>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>> ---
>>>>  fs/fuse/dev.c  | 6 +++---
>>>>  fs/fuse/file.c | 2 +-
>>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>>> index 6d59cbc877c6..698289b5539e 100644
>>>> --- a/fs/fuse/dev.c
>>>> +++ b/fs/fuse/dev.c
>>>> @@ -1814,7 +1814,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>>>>
>>>>               folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
>>>>               nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
>>>> -             nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
>>>> +             nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
>>>>
>>>>               err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
>>>>               if (!folio_test_uptodate(folio) && !err && offset == 0 &&
>>>
>>> IMHO, could we drop page offset, instead just update the file offset and
>>> re-calculate folio index and folio offset for each loop, i.e. something
>>> like what [1] did?
>>>
>>> This could make the code simpler and cleaner.
>>
>> Hi Jingbo,
>>
>> I'll break this change out into a separate patch. I agree your
>> proposed restructuring of the logic makes it simpler to parse.
>>
>> Thanks,
>> Joanne
>>
>>>
>>> BTW, it seems that if the grabbed folio is newly created on hand and the
>>> range described by the store notify doesn't cover the folio completely,
>>> the folio won't be set as Uptodate and thus the written data may be
>>> missed?  I'm not sure if this is in design.
> 
> (sorry, forgot to respond to this part of your email)
> 
> I think this is intentional. By "thus the written data may be missed",
> I think you're talking about the writeback path? My understanding is
> it's the dirty bit, not uptodate,

Not exactly. What I'm concerned is the uptodate bit.

In the case where "the grabbed folio is newly created on hand and the
range described by the store notify doesn't cover the folio completely,
the folio won't be set as Uptodate", the following read(2) or write(2)
on the folio will discard the content already in the folio, instead it
triggers .readpage() to fetch data from FUSE server again.

It seems that it is a deliberate constraint for FUSE_NOTIFY_STORE.

 that determines whether the written
> data gets written back. I think Darrick had the same question about
> this. AFAICT, it's by design to not have writeback triggered for this
> path since the server is the one providing the data so they already
> know the state-of-truth for the folio contents and that should already
> be reflected on their backend.
> 
-- 
Thanks,
Jingbo


