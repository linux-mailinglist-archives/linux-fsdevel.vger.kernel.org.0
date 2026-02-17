Return-Path: <linux-fsdevel+bounces-77364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIgxMlpilGlfDQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:43:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3503014C0F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A78BE3030E80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 12:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D385258EDB;
	Tue, 17 Feb 2026 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nd0EUNwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32242334690
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332170; cv=none; b=pMzlph1w5nNY5kGTmkHrGVUey0zqoLC7wxFXiRgpYYm1YbXTVm9eMSTdyJm0KbkiUoS9SKMU90YGggyIVDTrvDW5w0jGKoNAUMPblO4i2CDBbXB4OOr0gu0ohqUvAXvkQIoEjcYwjv9u+an21RM4SsK4s+BdaPMfERYe/eG5D2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332170; c=relaxed/simple;
	bh=HPfF9FXYIEsCzB6Gh5Ceal5kKcdQMhEjpIC03DM8Pjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fs4XcL5E1X6p9t1wN1LfEiZIaFWFo9OdM71sBQAohjAieoShao4Z/CXvaS66smYYh9ttqH/Q/BNzpiigIdnDOY3gowa6SLJyOgd1HtFHwf1/dimuSdzvRnk2yH83V0E++f0L+1rtpY9gAXyIdZlC+31mTM9yCh+sg6Ms9BXN0SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nd0EUNwq; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4627056f-2ab9-4ff1-bca0-5d80f8f0bbab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771332166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHe3ZejbOvudEwAFGp4CJMQCUggASakx2SvWy48y3WA=;
	b=nd0EUNwqwPgsrOW39DUKMqi0MAu86LgmPAc45mvnFMyfd00VVEkLVG905HJY5LjZtYOxhT
	2xV5Dft2o/QCfaaYr5jKBgtQZr11QWsPRVkswFGstncp2L532LR9+4PX7FtJzluYTGY/2b
	QU9DrWfQEvKcvV0+uS0eYFGr/IRCB1A=
Date: Tue, 17 Feb 2026 13:42:35 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
To: Jan Kara <jack@suse.cz>, Andres Freund <andres@anarazel.de>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
 john.g.garry@oracle.com, willy@infradead.org, hch@lst.de,
 ritesh.list@gmail.com, Luis Chamberlain <mcgrof@kernel.org>,
 dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>,
 gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com,
 vi.shah@samsung.com
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
 <zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s>
 <wkczfczlmstoywbmgfrxzm6ko4frjsu65kvpwquzu7obrjcd3f@6gs5nsfivc6v>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pankaj Raghav <pankaj.raghav@linux.dev>
In-Reply-To: <wkczfczlmstoywbmgfrxzm6ko4frjsu65kvpwquzu7obrjcd3f@6gs5nsfivc6v>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77364-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[linux.ibm.com,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pankaj.raghav@linux.dev,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 3503014C0F2
X-Rspamd-Action: no action

On 2/17/2026 1:06 PM, Jan Kara wrote:
> On Mon 16-02-26 10:45:40, Andres Freund wrote:
>>> Hmm, IIUC, postgres will write their dirty buffer cache by combining
>>> multiple DB pages based on `io_combine_limit` (typically 128kb).
>>
>> We will try to do that, but it's obviously far from always possible, in some
>> workloads [parts of ]the data in the buffer pool rarely will be dirtied in
>> consecutive blocks.
>>
>> FWIW, postgres already tries to force some just-written pages into
>> writeback. For sources of writes that can be plentiful and are done in the
>> background, we default to issuing sync_file_range(SYNC_FILE_RANGE_WRITE),
>> after 256kB-512kB of writes, as otherwise foreground latency can be
>> significantly impacted by the kernel deciding to suddenly write back (due to
>> dirty_writeback_centisecs, dirty_background_bytes, ...) and because otherwise
>> the fsyncs at the end of a checkpoint can be unpredictably slow.  For
>> foreground writes we do not default to that, as there are users that won't
>> (because they don't know, because they overcommit hardware, ...) size
>> postgres' buffer pool to be big enough and thus will often re-dirty pages that
>> have already recently been written out to the operating systems.  But for many
>> workloads it's recommened that users turn on
>> sync_file_range(SYNC_FILE_RANGE_WRITE) for foreground writes as well (*).
>>
>> So for many workloads it'd be fine to just always start writeback for atomic
>> writes immediately. It's possible, but I am not at all sure, that for most of
>> the other workloads, the gains from atomic writes will outstrip the cost of
>> more frequently writing data back.
> 
> OK, good. Then I think it's worth a try.
> 
>> (*) As it turns out, it often seems to improves write throughput as well, if
>> writeback is triggered by memory pressure instead of SYNC_FILE_RANGE_WRITE,
>> linux seems to often trigger a lot more small random IO.
>>
>>> So immediately writing them might be ok as long as we don't remove those
>>> pages from the page cache like we do in RWF_UNCACHED.
>>
>> Yes, it might.  I actually often have wished for something like a
>> RWF_WRITEBACK flag...
> 
> I'd call it RWF_WRITETHROUGH but otherwise it makes sense.
> 

One naive question: semantically what will be the difference between
RWF_DSYNC and RWF_WRITETHROUGH? So RWF_DSYNC will be the sync version and 
RWF_WRITETHOUGH will be an async version where we kick off writeback immediately 
in the background and return?

--
Pankaj


