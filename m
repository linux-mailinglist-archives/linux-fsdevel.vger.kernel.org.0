Return-Path: <linux-fsdevel+bounces-56725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CEAB1AEE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 08:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26CC27A2510
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 06:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEE6224B0D;
	Tue,  5 Aug 2025 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K9Vm9hYI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4sQn+AqT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K9Vm9hYI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4sQn+AqT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB9222562
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376902; cv=none; b=aim7JbqdDhkEsq9lkZttu7fnpMAADptIsDv5AZSL4HUCbmJY0oRyuKNKbsgKAcxDvE6kfwrSTJbK0JIiBuQQpL1NG/2jq8S0YI//pLgfAFuH+Vl8R1MCCtbM9Nyga00XU1wUJBRAZhSY4yGQ8u4CUABca0Zc9gLjEKTvVI9xDJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376902; c=relaxed/simple;
	bh=JKDKLL5GXsN/vyLB8aEuqyk5EASYOh40bqReveuJgpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBQyPnCKb87sVZIXCNE0fu5Ndqtf5MJ0Tr+TmjUykULNMpITEjjaCBQ0r41owpUn/4KK7xQbhIMM4OvhVBjmC+aD0myR6LMP4J/Fxkddhm5/6hjN4zidujLKBKKubDEXuQKoWgERA2EmuKWxMkyDcbnF6ORFLCNno4ZMGtzHsw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K9Vm9hYI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4sQn+AqT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K9Vm9hYI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4sQn+AqT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C181C1F441;
	Tue,  5 Aug 2025 06:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754376898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Brvbp7do+2hmGpcJndzJpusi2adyp2hNTe9xEr5hTis=;
	b=K9Vm9hYI3MsTVnd8DK5KtbSAXfQReveQTcbZWNFNUR38BMAip5M5wyQEx7dVCd7RGUJWSD
	cHH6qMrvS76E3gb7+nshdHBxNuK5jSNoJBfrGrrxP/0/IVhBTP1qQ/l2EzSRagsatOfeLd
	LZS8E/T1T+uGfhSqbtPCeT+zT0xGGuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754376898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Brvbp7do+2hmGpcJndzJpusi2adyp2hNTe9xEr5hTis=;
	b=4sQn+AqTM7iAyapUSuDNJwsx8h/O2IVzzr5T5cFnVJniQuoIJerEMdRLDQ7UGxUAdL6Own
	4eLlunA9eX5GfoDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=K9Vm9hYI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4sQn+AqT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754376898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Brvbp7do+2hmGpcJndzJpusi2adyp2hNTe9xEr5hTis=;
	b=K9Vm9hYI3MsTVnd8DK5KtbSAXfQReveQTcbZWNFNUR38BMAip5M5wyQEx7dVCd7RGUJWSD
	cHH6qMrvS76E3gb7+nshdHBxNuK5jSNoJBfrGrrxP/0/IVhBTP1qQ/l2EzSRagsatOfeLd
	LZS8E/T1T+uGfhSqbtPCeT+zT0xGGuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754376898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Brvbp7do+2hmGpcJndzJpusi2adyp2hNTe9xEr5hTis=;
	b=4sQn+AqTM7iAyapUSuDNJwsx8h/O2IVzzr5T5cFnVJniQuoIJerEMdRLDQ7UGxUAdL6Own
	4eLlunA9eX5GfoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7895713A50;
	Tue,  5 Aug 2025 06:54:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HLrYG8KqkWgmFwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 05 Aug 2025 06:54:58 +0000
Message-ID: <be0733c0-0ca7-4359-a979-7cc55ec24fa6@suse.de>
Date: Tue, 5 Aug 2025 08:54:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] block: align the bio after building it
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-3-kbusch@meta.com>
 <14c5a629-2169-4271-97b8-a1aba45a6e54@suse.de> <aJC-5qTTVDNjp0uk@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aJC-5qTTVDNjp0uk@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C181C1F441
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 8/4/25 16:08, Keith Busch wrote:
> On Mon, Aug 04, 2025 at 08:54:00AM +0200, Hannes Reinecke wrote:
>> On 8/2/25 01:47, Keith Busch wrote:
>>> +static int bio_align_to_lbs(struct bio *bio, struct iov_iter *iter)
>>> +{
>>> +	struct block_device *bdev = bio->bi_bdev;
>>> +	size_t nbytes;
>>> +
>>> +	if (!bdev)
>>> +		return 0;
>>> +
>>> +	nbytes = bio->bi_iter.bi_size & (bdev_logical_block_size(bdev) - 1);
>>> +	if (!nbytes)
>>> +		return 0;
>>> +
>>> +	bio_revert(bio, nbytes);
>>> +	iov_iter_revert(iter, nbytes);
>>> +	if (!bio->bi_iter.bi_size)
>>> +		return -EFAULT;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    /**
>>>     * bio_iov_iter_get_pages - add user or kernel pages to a bio
>>>     * @bio: bio to add pages to
>>> @@ -1336,6 +1355,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>>>    		ret = __bio_iov_iter_get_pages(bio, iter);
>>>    	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
>>> +	ret = bio_align_to_lbs(bio, iter);
>>>    	return bio->bi_vcnt ? 0 : ret;
>>
>> Wouldn't that cause the error from bio_align_to_lba() to be ignored
>> if bio->bi_vcnt is greater than 0?
> 
> That returns an error only if the alignment reduces the size to 0, so
> there would be a bug somewhere if bi_vcnt is not also 0 in that case.

It would, but we wouldn't be seeing it as 'ret' would be obscured
if 'bio->bi_vcnt' continues to be greater than zero and 'ret' is set.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

