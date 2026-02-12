Return-Path: <linux-fsdevel+bounces-77023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK17EajdjWnE8AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 15:03:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CC912E146
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 15:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0DCB301788C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 14:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723D7357A55;
	Thu, 12 Feb 2026 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agbcytX5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD23EBF1F;
	Thu, 12 Feb 2026 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904982; cv=none; b=IGijsIN4qhTSuoBFHk/WKzu9WmnRvKVkrGp4AzAyxQ1uxyWnnMGRWJYGBsSH0XkNbc3q+iQ9wetb9hjU1xFRzAMY0q+YQGpjKLP1zYvKGC9N8gUH5HWffHgyA5eWc/bN/ZvzOuX+PKmB48hd2KQTcudeEQfKWtV+CjamCDTeNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904982; c=relaxed/simple;
	bh=2JDw3awjOXd4kPpNQ/7wVykYS0LCl4AMGaJRs6Dq7zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOHeUaiuj//600AEooaYGD4PrKrkyKH61PhGJvl/rayEexNEo2cOxmZ/IKFjQccxawlmMVd40VQhWOfR3fem8WF8rdO0dOB3wJgVM/1f2tRzWyZpx1/GjkSn7i61dYW8qJYrdGikqxdqCdzCGFUiHlh1cb6zalcqvteQALSXVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agbcytX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6280C4CEF7;
	Thu, 12 Feb 2026 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770904981;
	bh=2JDw3awjOXd4kPpNQ/7wVykYS0LCl4AMGaJRs6Dq7zk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=agbcytX5cnt2ZbHh5p2zpoVa6Hqf2gG5yzq6trnkVNktylfra1qsHdi94NP6oIIGR
	 wkCWKTJUIctD1ranvX6ZkVsfvVUzFa8gY+M8c7FYgkkLwbAx2fb+Cwzvh1XLRzWhhM
	 sziuklsgBXlBcpdcAB5ZVdyN+HvzdRTizc/lc7v6iznV4ikKe2w3/0QajN5Paj/Zj0
	 ldmEMcC+7NXrRrDVQW5r0YeMvLP4KNHdDxIn8kG8n3Z7ZXY3OSBmAbmtiR3QDc8WWj
	 dYRrqbDdTAky0SXG3FPZROIVBhWgRwfsaaGwZk2XFnDpw1zf+6uXJ8BGbCAaPw6cNi
	 JO6bM+I1Kyx8A==
Message-ID: <5c6b182a-781a-47db-b7f5-f6bbf6afb1af@kernel.org>
Date: Thu, 12 Feb 2026 09:02:58 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] NFSD: Sign filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
References: <cover.1770828956.git.bcodding@hammerspace.com>
 <cb46e1aee9656be5f3692e239300148813b5c05d.1770828956.git.bcodding@hammerspace.com>
 <f75f0d1b-9feb-4a0e-8c4e-4825f59f8053@app.fastmail.com>
 <402ECD4C-8E84-4104-885E-7419A3F507B1@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <402ECD4C-8E84-4104-885E-7419A3F507B1@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77023-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3CC912E146
X-Rspamd-Action: no action

On 2/12/26 12:24 AM, Benjamin Coddington wrote:
> On 11 Feb 2026, at 17:05, Chuck Lever wrote:
> 
>> On Wed, Feb 11, 2026, at 12:09 PM, Benjamin Coddington wrote:
>>> NFS clients may bypass restrictive directory permissions by using
>>> open_by_handle() (or other available OS system call) to guess the
>>> filehandles for files below that directory.
>>
>>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>>> index 68b629fbaaeb..3bab2ad0b21f 100644
>>> --- a/fs/nfsd/nfsfh.c
>>> +++ b/fs/nfsd/nfsfh.c
>>
>>> @@ -236,13 +288,18 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
>>> *rqstp, struct net *net,
>>>  	/*
>>>  	 * Look up the dentry using the NFS file handle.
>>>  	 */
>>> -	error = nfserr_badhandle;
>>> -
>>>  	fileid_type = fh->fh_fileid_type;
>>>
>>> -	if (fileid_type == FILEID_ROOT)
>>> +	if (fileid_type == FILEID_ROOT) {
>>
>> Still need a comment here explaining why ROOT is exempt from
>> file handle signing checks.
> 
> Right on all points.
> 
> I'm really sorry Chuck, I sent the wrong patch here.  I am going to resend
> v6 with the correct 3/3 patch.

No worries, it looked to me like a tooling issue because the v6 3/3
diff was exactly the same as v5's. The other two v6 patches in the
series are ready to apply IMO, so I'll have a look at the RESEND.

-- 
Chuck Lever

