Return-Path: <linux-fsdevel+bounces-78435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAxfEua6n2n5dQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 04:15:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B03B81A067A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 04:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E243230659DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 03:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541AC385531;
	Thu, 26 Feb 2026 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Pt3QESqe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9932D94B5
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 03:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075733; cv=none; b=lsJoHscEhjXmTmCuT59xqCpVspoCjU6XFb99IjbfMy0vXUnpDnW9/K0NLmZ1Ds1ScM40V/rsMqJECInRXmDv8ZrLpK+IkGSnQlm1p5Rn6CbBRYCuoV9GCX2bCtKPTnOhO1+X209sMpSq08GRVKDH0ITfZR1yDzljgiBxPvT69WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075733; c=relaxed/simple;
	bh=3Uj98JRcjkXg45L932sgBQ4jyAOkKnrA4eVXq0Mc2RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iT1aEv/XURsa5QOIexzww8RSBXljwHfKJd204Ha/6f0RvPgCKT5XbMN4+Fasoi18+6gFJUHQmBhrobWoZgzMM1EHuo0lm8gJk8Fx4GJ4QWeVTsaGZzBGn23qj8fkNRxzs6ajU/FH9Lu6S9BMMGFHapjOzD+IabNpBglkAoTViCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Pt3QESqe; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-463a0e14b4dso156096b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 19:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772075731; x=1772680531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myOpzKKufRrzTXzkKkTioHHnRh1Fxba9oHbsZ8bSehI=;
        b=Pt3QESqeGYGEyfcbtu599/TaELTldNHt9ng7MdkbQscEZnkRuSh25I41b9c9dvwbs0
         pbRiegVYVhXxN6kv/Eg0EFcqolSkF8sW2dHcoxou+89/W6wTpoKs3MeS5dRmlnq0QHLz
         beD0NKXnUFkxdzpurznywZsv0jcAXSFUEZlDVEaGEZX/fH8nT2ZLRuRzU4wRZYWgAJYK
         HjXy/ScGA0aB6TeNRft1Dvn6Qb35HEKMPwb1Y7g7J2FWEhFtSj7eArl0e01dC8zPx26E
         xYJnhHsEiybj+rxDtRCtjALwF7rqZEnbad8aUzCkCd2gR90/cfeFhG91HuY5K4g9N7cT
         grQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772075731; x=1772680531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myOpzKKufRrzTXzkKkTioHHnRh1Fxba9oHbsZ8bSehI=;
        b=UuL5D4lWixHm7wqtZ8Ik+96TGew3wIyjGCasUThAVoRL8EnTz0Q0n/8F14+vwNpp2x
         7W1eCGAiwI/qBUZMBuXPa/l5GmBmBMbBx1E+lWIE5xActZab3IULPuHsZYGLn7+CyW0+
         hgs1H8vrxl+AYZUO8D955++uHYqrqRxxVtZeTUy2zfJvjnKypeH2WHUivM1iPuGdNw0V
         7mmJuNmFb1VZU6FBjog2REoFe6/gt8wvAvL9KuDH6JPBu4Iw1FHKnEGnzUKZ3ixvvmAD
         rRadDTSvCN8B+72qi+4E6pY5fAim+5LH8Ceyx2aHgNLheHaiZJgq20NRNqpHoorxY4ih
         q5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZjRH3p402bRxrILNqnf0Et05Vre7xhfG1hsI6ezB1dOXYSRDqhBgfEd51393Y1DMH/13D2x0hw8iVyHL/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs51NqdUHJtxngfsruHKMPHSY/HOMep7NXL7WJ1at3hYUct24B
	HyVr0OACwdcYQ6KBl5vcGAsJE/WUBeasPKy/EumZOg23V1I5ZW6A01iPWIRqeUinPx0=
X-Gm-Gg: ATEYQzzrHgCU8GWsu47cmHXis8XmlNrUe1yxuDln7nafRgb8j2ecBsq8sNGWT6oMl40
	eB0yP8aQxStmXqMEkzN2gBEkI2HRCJHf6dca5EGTC+lZOgl2OEYAb9ayE2KFWkxP3PZ7Y/cUrH6
	0cLnRLvLp3zafJNxFGApL4WSaOudxD/jLNtNdK7Xh2FxmNU6UiRhvBhCp4RWJxeuDkyox0xzzA2
	C0wvOyF1ZMsVy2fMswP24LPLc2muSQnFh7T698C11SZREStpzcHVkm3CMzs+3vsagC8hq9zvWek
	yExuTfXs4UhlpJcAlqVUo84Q1CSbbvNyKWJ7CTfaM+uVyX4ZXDAvW3DXcykWW82XV1rdTgHoeQC
	P0AVBHLi795ND9SBTlBjOceNaOI7vsWC6iq40LeOBN+xRUUqrBzohudMP7Ml2GvB5fk5HkwA6OB
	shj39gWnUTqk/2TiykJxI6DumC9vJnKeZiGiHDOsbyOdRWj0TdAKXS+t6Z+MDLZSvT0cd30S+ln
	99K6uWYjA==
X-Received: by 2002:a05:6808:320b:b0:462:d9a2:84e1 with SMTP id 5614622812f47-464463ef61fmr8794809b6e.60.1772075731397;
        Wed, 25 Feb 2026 19:15:31 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf9b240sm786090fac.8.2026.02.25.19.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 19:15:30 -0800 (PST)
Message-ID: <44e3e9ea-350b-4357-ba50-726e506feab5@kernel.dk>
Date: Wed, 25 Feb 2026 20:15:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/2] filemap: defer dropbehind invalidation from
 IRQ context
To: Matthew Wilcox <willy@infradead.org>
Cc: Tal Zussman <tz2294@columbia.edu>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Bob Copeland <me@bobcopeland.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu>
 <20260225-blk-dontcache-v2-1-70e7ac4f7108@columbia.edu>
 <c8078a80-f801-4f8a-b3cd-e2ccbfca1def@kernel.dk>
 <aZ-2G_6lDZePLSyx@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aZ-2G_6lDZePLSyx@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78435-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[columbia.edu,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com,linux-foundation.org,vger.kernel.org,lists.sourceforge.net,lists.linux.dev,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B03B81A067A
X-Rspamd-Action: no action

On 2/25/26 7:55 PM, Matthew Wilcox wrote:
> On Wed, Feb 25, 2026 at 03:52:41PM -0700, Jens Axboe wrote:
>> How well does this scale? I did a patch basically the same as this, but
>> not using a folio batch though. But the main sticking point was
>> dropbehind_lock contention, to the point where I left it alone and
>> thought "ok maybe we just do this when we're done with the awful
>> buffer_head stuff". What happens if you have N threads doing IO at the
>> same time to N block devices? I suspect it'll look absolutely terrible,
>> as each thread will be banging on that dropbehind_lock.
>>
>> One solution could potentially be to use per-cpu lists for this. If you
>> have N threads working on separate block devices, they will tend to be
>> sticky to their CPU anyway.
> 
> Back in 2021, I had Vishal look at switching the page cache from using
> hardirq-disabling locks to softirq-disabling locks [1].  Some of the
> feedback (which doesn't seem to be entirely findable on the lists ...)
> was that we'd be better off punting writeback completion from interrupt
> context to task context and going from spin_lock_irq() to spin_lock()
> rather than going to spin_lock_bh().
> 
> I recently saw something (possibly XFS?) promoting this idea again.
> And now there's this.  Perhaps the time has come to process all
> write-completions in task context, rather than everyone coming up with
> their own workqueues to solve their little piece of the problem?

Perhaps, even though the punting tends to suck... One idea I toyed with
but had to abandon due to fs freezeing was letting callers that process
completions in task context anyway just do the necessary work at that
time. There's literally nothing worse than having part of a completion
happen in IRQ, then punt parts of that to a worker, and need to wait for
the worker to finish whatever it needs to do - only to then wake the
target task. We can trivially do this in io_uring, as the actual
completion is posted from the task itself anyway. We just need to have
the task do the bottom half of the completion as well, rather than some
unrelated kthread worker.

I'd be worried a generic solution would be the worst of all worlds, as
it prevents optimizations that happen in eg iomap and other spots, where
only completions that absolutely need to happen in task context get
punted. There's a big difference between handling a completion inline vs
needing a round-trip to some worker to do it.

-- 
Jens Axboe

