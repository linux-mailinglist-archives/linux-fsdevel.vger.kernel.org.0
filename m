Return-Path: <linux-fsdevel+bounces-75365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sByTBAkidWmYBAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:48:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FC57EC09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 707A83012E96
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEC6241114;
	Sat, 24 Jan 2026 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxg3WGWS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6DA1400C;
	Sat, 24 Jan 2026 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769284090; cv=none; b=qMRDWFDMe8cQ61PcPdL/j0QHXM6CEW+Zzvgmnvbn1+2R/QTXt7fvDb3ZM/aZ6n6a6SAbn6oFHUqIRwa50hpUmhMRBkEfnowqQWuII5gxYWrUI2Qqmq7vJ0I05He0BuMdYZhXBBkZTp3b/kCGZYECnbgNxGBdknNnmq1UEUwvpUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769284090; c=relaxed/simple;
	bh=CiwE1c3OhStdZKUSR9Ar2ANpiMWzIFWljE9nRVBZp4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eL2KNV++UsnfIRlqosM5DtAVr+/4UDCKn9S9YHCPOTCQtmLy6sQc1rP11gAFwUSsZPF043dr6+68ZFaXP6HyflaGK8qi442BWnnLG4eHJodmc61JOCPYXgTZwSWttu9wqaT4UAOhCPVx05I1U3cT14tOgDlUFnqe9FTHZttkUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxg3WGWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A532AC116D0;
	Sat, 24 Jan 2026 19:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769284090;
	bh=CiwE1c3OhStdZKUSR9Ar2ANpiMWzIFWljE9nRVBZp4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pxg3WGWSxmZ88v29KxrQN1MDY0uuyQW39QC4XVatMhx6BjcjvT+TANNTCIPXNS2mp
	 8/ToN864BBmgIw+7hbq95bjKg6+j+xcUhzSkBpj6qfFWOX1OYaGtvYFCF/PCR4BNtW
	 tIOjMS7F/2FkIwm9/x91J6t3sCcWezhjbBC9mzwZn0DkSO2FeEMesAiA56hj0s5UGy
	 TvvJIp16Lc0VWih3WyiVCgqQMkRqZqXPaB+ViFFbRxGxrKY0IJJzJF6Oshp4bgymKV
	 gJr9Xf7FEueF2d4FL9NuODBxcjyyD1gwBtTZmljCITkKC9oiIlIgamqJ6455/CtVNr
	 bYFDTOsAV0+yA==
Message-ID: <33c02e5a-03e7-42ef-8ccd-790a9b29a763@kernel.org>
Date: Sat, 24 Jan 2026 14:48:03 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
To: Trond Myklebust <trondmy@kernel.org>,
 Benjamin Coddington <bcodding@hammerspace.com>, NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
References: <> <e545c35e-31fc-4069-8d83-1f9585e82532@app.fastmail.com>
 <176921979948.16766.5458950508894093690@noble.neil.brown.name>
 <686CBEE5-D524-409D-8508-D3D48706CC02@hammerspace.com>
 <77e7a645-66bd-4ce2-b963-2a2488595b00@kernel.org>
 <8be0a065a84bed02735141b4333e9c49a2ab0c90.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <8be0a065a84bed02735141b4333e9c49a2ab0c90.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,gmail.com,vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-75365-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 94FC57EC09
X-Rspamd-Action: no action

On 1/24/26 1:48 PM, Trond Myklebust wrote:
> On Sat, 2026-01-24 at 11:07 -0500, Chuck Lever wrote:
>> On 1/24/26 8:58 AM, Benjamin Coddington wrote:
>>> Hey Chuck and Neil - Sorry to be late responding here..
>>>
>>> On 23 Jan 2026, at 20:56, NeilBrown wrote:
>>
>>
>>> Not a great argument, I know, but I think its nice to keep the
>>> standard that
>>> filehandles are independently self-describing.
>>>
>>> We're building server systems that pass around filehandles
>>> generated by NFSD
>>> and it can be a useful signal to those 3rd-party systems that
>>> there's a
>>> signature.  Trond might know more about whether its essential -
>>> I'll ask him
>>> to weigh in here.
>>
>> Thanks, yes, let's hear from Trond.
>>
>>
>>> All said - please let me know if the next version should keep it.
>>
>> There are really two question marks:
>>
>> 1. If I were a security reviewer, I would say that NFSD shouldn't
>> rely
>> on network input like this to decide whether or not to validate the
>> MAC.
>> Either the server expects a MAC and uses it to validate, or it
>> doesn't.
>> For me as a maintainer, that is a risk we probably can deal with
>> immediately -- would it be OK at least to change the FH verification
>> code to not use the auth_type to decide when to validate the FH's
>> MAC?
>>
>> 2. Is setting FH_AT_MAC still useful for other reasons? I think we
>> don't
>> really know whether to keep the auth_type or how to document it until
>> we've decided on how exactly NFSD will deal with changing the sign_fh
>> setting while clients have the export mounted.
>>
>> So, let's leave the field in place and we'll come back to it. If you
>> want, add a comment like /* XXX is FH_AT_MAC still needed? */
>>
> 
> I fully agree with the argument that policy decisions about whether to
> check for a MAC need to be driven by the /etc/exports configuration,
> and not by the filehandle itself. The only use I can think of for a
> flag in that context would be to expedite the rejection of the
> filehandle in the case where that policy was set, however that would
> seem to be optimising for what should be a rare corner case.
> 
> I did speculate a little in some internal conversations whether or not
> a metadata server that is using knfsd as a flex files data server might
> be able to re-sign a filehandle after the secret key were changed,
> rather than having to look up the file again using its path. However
> that too is very much a corner case that we have no plans to optimise
> for at this time. Even if we did, we wouldn't need a flag in the
> filehandle to know whether or not to sign it, because we'd want to
> determine the policy through other means (if for no other reason that
> the metadata server needs to know the secret key as well).
> 
> So personally, I'm neutral about the need for that flag. I don't think
> it is harmful (provided it isn't being used by knfsd to determine MAC
> policy enforcement) however I don't see a strong argument for it being
> needed either.
> 

Thanks for clarifying.

My feeling is that if FH_AT_MAC remains, those who continue maintaining
the sign_fh feature will want to understand its purpose so they don't
break anything when updating code. So documentation is essential.

But it doesn't seem necessary to keep FH_AT_MAC for good security and
proper function.

I can't recall if Wireshark is smart enough to introspect Linux NFSD
file handles (I thought it could). It would be sensible to have some
Wireshark update code in hand before making the final decision about
keeping the new auth_type.


-- 
Chuck Lever

