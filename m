Return-Path: <linux-fsdevel+bounces-77274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKtFBU0Zk2nD1QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:19:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A95143C28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED793014646
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FF82FFDEA;
	Mon, 16 Feb 2026 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p48jLXCy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A39424BBFD
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771247908; cv=none; b=CD161dPyWMgrONJdcsH/tXgsZFxy3RLPRhOukw+dNuCAjs5dXd0pkgH/rX8WkDgPmMpDKesiAr1TVCb+nzfP2vmBGmRC6wqChK+zkD2ehXr5reZsNX0GdMwrICZoYe9rHJbtfisS6FWU9HbA8W3LmMoUPjp1ZaoadCqxHzkcF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771247908; c=relaxed/simple;
	bh=vZEGwyLXtwS50t+qseTk7VEoyijqYlIwNiT1NUT/MaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4cpfPs/rkzZPhCyZQDBx1W27EaK867DyVDFsXi0RguUWWi27qKdfdgpLQq1nB38XxhZcRCjcOph6qKp400ZUYp9/L5vPNn+ijWpN7MBN+upg9ASgsNp8+0vjxCAAGLxXT5yRaMbj0//amjvVsdE1VXLndm0BPisiCmA6QSHNU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p48jLXCy; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c29d36eb-0706-4f3c-aaed-de7d9ef74bed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771247894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V05ejPvopLo9DRbeUi1eZlG4ZZP00I4HL4AVm44w2ig=;
	b=p48jLXCyB4VQIxa8U3Gdq7k8wKO8XyymBq6W8BKSRkDN7UxEod2Qo9XWM6In41SsmVr+1X
	6bxBpYh3sSb2Zy2qbVUyeFagIxBxAeBh7JjAaEUhiDSJL47UcvZlEFoNMF1POC5KagDyAC
	gKbYB0/kLVuZKWkLCLWUh1bnjRK+ODA=
Date: Mon, 16 Feb 2026 14:18:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
To: Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
 Andres Freund <andres@anarazel.de>, djwong@kernel.org,
 john.g.garry@oracle.com, willy@infradead.org, hch@lst.de,
 ritesh.list@gmail.com, Luis Chamberlain <mcgrof@kernel.org>,
 dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>,
 gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com,
 vi.shah@samsung.com
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <w3vwdaygcz3prsxwv43blo4co666mragpdwaxihbirt5stl4vr@agyz4mnaxghj>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pankaj Raghav <pankaj.raghav@linux.dev>
In-Reply-To: <w3vwdaygcz3prsxwv43blo4co666mragpdwaxihbirt5stl4vr@agyz4mnaxghj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77274-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux-foundation.org,anarazel.de,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pankaj.raghav@linux.dev,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	HAS_WP_URI(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68A95143C28
X-Rspamd-Action: no action



On 2/16/2026 12:38 PM, Jan Kara wrote:
> Hi!
> 
> On Fri 13-02-26 19:02:39, Ojaswin Mujoo wrote:
>> Another thing that came up is to consider using write through semantics
>> for buffered atomic writes, where we are able to transition page to
>> writeback state immediately after the write and avoid any other users to
>> modify the data till writeback completes. This might affect performance
>> since we won't be able to batch similar atomic IOs but maybe
>> applications like postgres would not mind this too much. If we go with
>> this approach, we will be able to avoid worrying too much about other
>> users changing atomic data underneath us.
>>
>> An argument against this however is that it is user's responsibility to
>> not do non atomic IO over an atomic range and this shall be considered a
>> userspace usage error. This is similar to how there are ways users can
>> tear a dio if they perform overlapping writes. [1].
> 
> Yes, I was wondering whether the write-through semantics would make sense
> as well. Intuitively it should make things simpler because you could
> practially reuse the atomic DIO write path. Only that you'd first copy
> data into the page cache and issue dio write from those folios. No need for
> special tracking of which folios actually belong together in atomic write,
> no need for cluttering standard folio writeback path, in case atomic write
> cannot happen (e.g. because you cannot allocate appropriately aligned
> blocks) you get the error back rightaway, ...
> 
> Of course this all depends on whether such semantics would be actually
> useful for users such as PostgreSQL.

One issue might be the performance, especially if the atomic max unit is in the 
smaller end such as 16k or 32k (which is fairly common). But it will avoid the 
overlapping writes issue and can easily leverage the direct IO path.

But one thing that postgres really cares about is the integrity of a database 
block. So if there is an IO that is a multiple of an atomic write unit (one 
atomic unit encapsulates the whole DB page), it is not a problem if tearing 
happens on the atomic boundaries. This fits very well with what NVMe calls 
Multiple Atomicity Mode (MAM) [1].

We don't have any semantics for MaM at the moment but that could increase the 
performance as we can do larger IOs but still get the atomic guarantees certain 
applications care about.


[1] 
https://nvmexpress.org/wp-content/uploads/NVM-Express-NVM-Command-Set-Specification-Revision-1.1-2024.08.05-Ratified.pdf 


