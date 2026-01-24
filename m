Return-Path: <linux-fsdevel+bounces-75352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFZhBGLudGls/AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 17:08:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5CE7E15E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 17:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B97E2300491C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F12723D2AB;
	Sat, 24 Jan 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmrPinF3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF13EBF0C;
	Sat, 24 Jan 2026 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769270874; cv=none; b=O+LYy9L+WWV3d7oISsvuAp6t75+kswI+HHaFsPHRjyhAJokIeJYnBTxolHrTkY1QNdAI2AGdOF/zpw9fnvxCW/bwsYx2iQQSl2TycLIFAjMd2wLN2xDajoKt4xpcl8Ux0mDNz+YpqzQjRkGaJCYE2vRd64JoZ1zIeesctNtskZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769270874; c=relaxed/simple;
	bh=sM0x7LuafRplCO64dYy/ImhxFLrt50sQKSVagUQgaUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lM0Xt6sJwuPwsbO/G73uJMUh9q0OC0GdppFFSa5ODhyzFvExNNf9Agr0doFIcwwffZAj5K6zmechgLvYY4srd0zF48GBhk5a3Gt6CcHtgiUi1xorM/VlgitmvTMHUrdJ+Cb0lGMEtWYTb00ITvCao+Ylp+JFDn8cdRQTdZyg/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmrPinF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B89C116D0;
	Sat, 24 Jan 2026 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769270874;
	bh=sM0x7LuafRplCO64dYy/ImhxFLrt50sQKSVagUQgaUE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BmrPinF3iideNzIAJUl9uspHGXghD9dMo5tR4xoP584DXZIKNm4MxHIZEtZAzaaCu
	 0JoG/C9wgpp2vtOdCjaNE2RT1sszEzsBtbaMuUP0w1l0poWUntS/Pwam7xgEFtVcR5
	 /nVelzcfiHFDpK/LbBNvMOB+lfAIr3BPdYTle3KbF2q0nFu2r8aknjm2Py+QfniAGA
	 KQgYlS4Zb/DgYh3YxRau+bIW2PGLib9TD8Q7WMtXAcASx25Fj5Ss0YVV1OPXcHP/nO
	 lNlLjLp/N1VwtYYgyJ4Z+ncX4s/bso5QNUcQMZ4i0Cy5r3zKr3HJCdhZzyE7P144so
	 vmdd//diUP8Mw==
Message-ID: <77e7a645-66bd-4ce2-b963-2a2488595b00@kernel.org>
Date: Sat, 24 Jan 2026 11:07:47 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>,
 NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
References: <> <e545c35e-31fc-4069-8d83-1f9585e82532@app.fastmail.com>
 <176921979948.16766.5458950508894093690@noble.neil.brown.name>
 <686CBEE5-D524-409D-8508-D3D48706CC02@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <686CBEE5-D524-409D-8508-D3D48706CC02@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75352-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A5CE7E15E
X-Rspamd-Action: no action

On 1/24/26 8:58 AM, Benjamin Coddington wrote:
> Hey Chuck and Neil - Sorry to be late responding here..
> 
> On 23 Jan 2026, at 20:56, NeilBrown wrote:
> 
>> On Sat, 24 Jan 2026, Chuck Lever wrote:
>>>
>>> On Fri, Jan 23, 2026, at 6:38 PM, NeilBrown wrote:
>>>> On Sat, 24 Jan 2026, Chuck Lever wrote:
>>>>> On 1/23/26 5:21 PM, NeilBrown wrote:
>>>>>> On Sat, 24 Jan 2026, Chuck Lever wrote:
>>>>>>>
>>>>>>> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
> ...
>>>>>>>>
>>>>>>>> +#define FH_AT_NONE		0
>>>>>>>> +#define FH_AT_MAC		1
>>>>>>>
>>>>>>> I'm pleased at how much this patch has shrunk since v1.
> 
> Me too, thanks for all the help refining it.
> 
>>>>>>>
>>>>>>> This might not be an actionable review comment, but help me understand
>>>>>>> this particular point. Why do you need both a sign_fh export option
>>>>>>> and a new FH auth type? Shouldn't the server just look for and
>>>>>>> validate FH signatures whenever the sign_fh export option is
>>>>>>> present?
> 
> Its vestigial from the encrypted_fh version which required it because the
> fsid might be encrypted, so NFSD couldn't look up the export to see if it
> was set to encrypt until decrypting the fsid, and needed the auth type to
> know if it was encrypted.
> 
>>>>>> ...and also generate valid signatures on outgoing file handles.
>>>>>>
>>>>>> What does the server do to "look for" an FH signature so that it can
>>>>>> "validate" it?  Answer: it inspects the fh_auth_type to see if it is
>>>>>> FT_AT_MAC.
>>>>>
>>>>> No, NFSD checks the sign_fh export option. At first glance the two
>>>>> seem redundant, and I might hesitate to inspect or not inspect
>>>>> depending on information content received from a remote system. The
>>>>> security policy is defined precisely by the "sign_fh" export option I
>>>>> would think?
> 
> Yes, now its a bit redundant - but it could be used to still accept
> filehandles that are signed after removing a "sign_fh" from an export.  In
> other words, it might be useful to be "be liberal in what you accept from
> others".  It would be essential if future patches wanted to "drain" and
> "fill" clients with signed/plain filehandles using more permissive policies.
> *waves hands wildly*
> 
>>>> So maybe you are thinking that, when sign_fh, is in effect - nfsd
>>>> could always strip off the last 8 bytes, hash the remainder, and check
>>>> the result matches the stripped bytes.
>>>
>>> I’m wondering why there is both — the purpose of having these two
>>> seemingly redundant signals is worth documenting. There was some
>>> discussion a few days ago about whether the root FH could be signed
>>> or not. I thought for a moment or two that maybe when sign_fh is
>>> enabled, there will be one or more file handles on that export that
>>> won’t have a signature, and FT_AT_NONE would set those apart
>>> from the signed FHs. Again, I’d like to see that documented if that is
>>> the case.
> 
> Right now no, not that I know of - the root filehandle is the only one, and
> its easy to detect.
> 
>> I would document it as:
>>
>>  sign_fh is needs to configure server policy
>>  FT_AT_MAC, while technically redundant with sign_fh, is valuable
>>   whehn interpreting NFS packet captures.
> 
> Yes, it would allow a network dissector to locate and parse the MAC.
> 
>>> In addition, I’ve always been told that what comes off the network
>>> is completely untrusted. So, I want some assurance that using the
>>> incoming FH’s auth type as part of the decision to check the signature
>>> conforms with known best practices.
>>>
>>>> Another reason is that it helps people who are looking at network
>>>> packets captures to try to work out what is going wrong.
>>>> Seeing a flag to say "there is a signature" could help.
>>>
>>> Sure. But unconditionally trusting that flag is another question.
>>
>> By the time the code has reached this point it has already
>> unconditionally trusted the RPC header, the NFS opcode, the '1' in
>> fh_version, the fh_fsid_type and the fsid itself.
>>
>> Going further to trust fh_auth_type to the extent that we reject the
>> request if it is 0, and check the MAC if it is 1 - is not significant.

What I'm saying is that if it makes no difference to the security level,
then let's not bother to check it at all.


> Not a great argument, I know, but I think its nice to keep the standard that
> filehandles are independently self-describing.
> 
> We're building server systems that pass around filehandles generated by NFSD
> and it can be a useful signal to those 3rd-party systems that there's a
> signature.  Trond might know more about whether its essential - I'll ask him
> to weigh in here.

Thanks, yes, let's hear from Trond.


> All said - please let me know if the next version should keep it.

There are really two question marks:

1. If I were a security reviewer, I would say that NFSD shouldn't rely
on network input like this to decide whether or not to validate the MAC.
Either the server expects a MAC and uses it to validate, or it doesn't.
For me as a maintainer, that is a risk we probably can deal with
immediately -- would it be OK at least to change the FH verification
code to not use the auth_type to decide when to validate the FH's MAC?

2. Is setting FH_AT_MAC still useful for other reasons? I think we don't
really know whether to keep the auth_type or how to document it until
we've decided on how exactly NFSD will deal with changing the sign_fh
setting while clients have the export mounted.

So, let's leave the field in place and we'll come back to it. If you
want, add a comment like /* XXX is FH_AT_MAC still needed? */


-- 
Chuck Lever

