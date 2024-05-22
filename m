Return-Path: <linux-fsdevel+bounces-19980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5218CBB20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 08:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6E61F218F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 06:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4299278C9A;
	Wed, 22 May 2024 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BlUpopu7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="USJvkhZ0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BlUpopu7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="USJvkhZ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7D76405;
	Wed, 22 May 2024 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716358960; cv=none; b=J3qEqm07kYNsm/O+EgBTf6uNE3P8VEuOW53S7zGzJIRdFQ4JaIpR16DrNrUdYw8uNSbVpFMrxJzB8kAd/C4iynhgP7o8yOzyEi1sK7HzQTmF+CRnux39SD7hOXmzN1xwqP0rHXlDsrgukQLQ7qzikyj5vsBwdRBVpAWeXk/gUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716358960; c=relaxed/simple;
	bh=dWFbD0hyjBTnHZSjDxti4iwBSEqTJCgP6oKdO+DHDtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZOQrolNsIVhkS3GOD3qtuDAXKd6v9hcJMxL4U/iiHenjpBVc1vJosaC6jnGb3A2QbFlAuLm//9kb2hCj7Cwux05LIL4C0malcAVbdtIjVDLX8nj1uEKlJFIF79bdHCUGUONksrYzxZWwFgUDmf12Y+i4MsueDD1AXPL3FrWqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BlUpopu7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=USJvkhZ0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BlUpopu7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=USJvkhZ0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 43DE65C678;
	Wed, 22 May 2024 06:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716358957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxcsE1xFuEdCcsKm6YBMU0O/FCyQsR2TEf5Wkf0+zNc=;
	b=BlUpopu7lfFzGuVYtey10hAI09jmAuC31yfW6GvvmDn9RQMWyaubtSHkaVrj5Bej4Weexg
	uDE4uRzvaJwypMdbUPGEQ3yUhK1muvUiKd5ArSLeWLy9NLdwHl8+VkfOVlaOGwUOrzuQxZ
	FxjncxhnRRYHDzf74v+5jq7Yml+KHFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716358957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxcsE1xFuEdCcsKm6YBMU0O/FCyQsR2TEf5Wkf0+zNc=;
	b=USJvkhZ0rAe5SKW+Hevkq3gRvCInKHPvDgudvGa0YY9rv3HIinKlhd8tE5ei4I/5cDSgp3
	XqEXzO025UO1QGCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716358957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxcsE1xFuEdCcsKm6YBMU0O/FCyQsR2TEf5Wkf0+zNc=;
	b=BlUpopu7lfFzGuVYtey10hAI09jmAuC31yfW6GvvmDn9RQMWyaubtSHkaVrj5Bej4Weexg
	uDE4uRzvaJwypMdbUPGEQ3yUhK1muvUiKd5ArSLeWLy9NLdwHl8+VkfOVlaOGwUOrzuQxZ
	FxjncxhnRRYHDzf74v+5jq7Yml+KHFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716358957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxcsE1xFuEdCcsKm6YBMU0O/FCyQsR2TEf5Wkf0+zNc=;
	b=USJvkhZ0rAe5SKW+Hevkq3gRvCInKHPvDgudvGa0YY9rv3HIinKlhd8tE5ei4I/5cDSgp3
	XqEXzO025UO1QGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62EE213A1E;
	Wed, 22 May 2024 06:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NKF0FiyPTWY+AQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 22 May 2024 06:22:36 +0000
Message-ID: <0f29bcc1-e708-47cc-a562-0d1e69be6b03@suse.de>
Date: Wed, 22 May 2024 08:22:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 09/12] dm: Add support for copy offload
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, martin.petersen@oracle.com, bvanassche@acm.org,
 david@fromorbit.com, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520103004epcas5p4a18f3f6ba0f218d57b0ab4bb84c6ff18@epcas5p4.samsung.com>
 <20240520102033.9361-10-nj.shetty@samsung.com>
 <41228a01-9d0c-415d-9fef-a3d2600b1dfa@suse.de>
 <20240521140850.m6ppy2sxv457gxgs@green245>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240521140850.m6ppy2sxv457gxgs@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,lwn.net,redhat.com,kernel.org,lst.de,grimberg.me,nvidia.com,zeniv.linux.org.uk,suse.cz,oracle.com,acm.org,fromorbit.com,opensource.wdc.com,samsung.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhytspa9b8ghbrab87o1fjg5u)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]

On 5/21/24 16:08, Nitesh Shetty wrote:
> On 21/05/24 09:11AM, Hannes Reinecke wrote:
>> On 5/20/24 12:20, Nitesh Shetty wrote:
>>> Before enabling copy for dm target, check if underlying devices and
>>> dm target support copy. Avoid split happening inside dm target.
>>> Fail early if the request needs split, currently splitting copy
>>> request is not supported.
>>>
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>> ---
>>> @@ -397,6 +397,9 @@ struct dm_target {
>>>       * bio_set_dev(). NOTE: ideally a target should _not_ need this.
>>>       */
>>>      bool needs_bio_set_dev:1;
>>> +
>>> +    /* copy offload is supported */
>>> +    bool copy_offload_supported:1;
>>>  };
>>>  void *dm_per_bio_data(struct bio *bio, size_t data_size);
>>
>> Errm. Not sure this will work. DM tables might be arbitrarily, 
>> requiring us to _split_ the copy offload request according to the 
>> underlying component devices. But we explicitly disallowed a split in 
>> one of the earlier patches.
>> Or am I wrong?
>>
> Yes you are right w.r.to split, we disallow split.
> But this flag indicates whether we support copy offload in dm-target or
> not. At present we support copy offload only in dm-linear.
> For other dm-target, eventhough underlaying device supports copy
> offload, dm-target based on it wont support copy offload.
> If the present series get merged, we can test and integrate more
> targets.
> 
But dm-linear can be concatenated, too; you can easily use dm-linear
to tie several devices together.
Which again would require a copy-offload range to be split.
Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


