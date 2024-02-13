Return-Path: <linux-fsdevel+bounces-11492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869E9853F9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 00:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C361C26941
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52FB62810;
	Tue, 13 Feb 2024 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="wiuaYYhf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A9662807
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865272; cv=none; b=R/p+sObDcTHAjrVjFjjZYYrQF91oj2H2zJbZ+uerOX0v+o3AFMGhpg3/cdtz1df6XBOW551oPrqsFCO0NKO5GrZJ9wGeTB1MF1+SkqNbVPOV2Qd073qSKuaCEtS/t9f1jkJBN3OmMRFIm6FMrpswk9erzJh6FogfydtnaSmsXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865272; c=relaxed/simple;
	bh=II7Yq6pE93/UxXyVmz764SZ2zXpnG859g9oU1PIT0e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZeCXn0c3oDEgjpAtJeMEQlZG4pd0kipsQsHP3dMd60+CC3lGSMcEwBHrgxUXbwNuHFRQGOb70aSUico4kQlmjvM0eXlXLte8InX/TcPNCCeoH/6/9cuWgeuACcWjVnTU22842XuptyuZCosFX+0qKck2hTGQlW6k8+/6s88htLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=wiuaYYhf; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 7452F33505B;
	Tue, 13 Feb 2024 17:01:03 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 7452F33505B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1707865263;
	bh=ofLnatVxTeFKZ3NWrDfgZNKubblBOPlHsY1aqlVPQaU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wiuaYYhfqVpxD0pJfh/jV/xv+3Mk7yxVOpxYqb1rJBjOpgxJAghbrFitv1PWIBd91
	 fcv8vXpFP1OzKQMyj5akDFKieirZ8q0hzs64cNm2VMFKS+5BHQvrSkFt0uXnkMIK/h
	 7b7+wYYxNfXNR79dsHhrRUJXWIwD+BO5fQNThdlfqav/pVL6z21FwUxhnHZ1Q8Xn8/
	 ZuKsGmDhes8/UxC01Z1vRwPDLDzgth5tavmZRMJdCcVnfFVcyPu2ERcsHVobDzNElq
	 QXzG30RHoptxjwG+N7Bi9uMJlOViwbYZZMHMfKaNVmrCHV44dKcC62n3GOMbYy+MYE
	 tZtcloI0aBc5Q==
Message-ID: <2cc7c720-c8e9-4230-b267-0cf2e15e5dd7@sandeen.net>
Date: Tue, 13 Feb 2024 17:01:02 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udf: convert to new mount API
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bill O'Donnell <billodo@redhat.com>,
 David Howells <dhowells@redhat.com>
References: <739fe39a-0401-4f5d-aef7-759ef82b36bd@redhat.com>
 <20240213124933.ftbnf3inbfbp77g4@quack3>
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240213124933.ftbnf3inbfbp77g4@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 6:49 AM, Jan Kara wrote:
> On Fri 09-02-24 13:43:09, Eric Sandeen wrote:
>> Convert the UDF filesystem to the new mount API.
>>
>> UDF is slightly unique in that it always preserves prior mount
>> options across a remount, so that's handled by udf_init_options().
> Well, ext4 does this as well AFAICT. See e.g. ext4_apply_options() and how
> it does:
> 
>         sbi->s_mount_opt &= ~ctx->mask_s_mount_opt;
>         sbi->s_mount_opt |= ctx->vals_s_mount_opt;
>         sbi->s_mount_opt2 &= ~ctx->mask_s_mount_opt2;
>         sbi->s_mount_opt2 |= ctx->vals_s_mount_opt2;
>         sb->s_flags &= ~ctx->mask_s_flags;
>         sb->s_flags |= ctx->vals_s_flags;
> 
> so it really modifies the current superblock state, not overwrites it.
> 
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> Tested by running through xfstests, as well as some targeted testing of
>> remount behavior.
>>
>> NB: I did not convert i.e any udf_err() to errorf(fc, ) because the former
>> does some nice formatting, not sure how or if you'd like to handle that, Jan?

> Which one would you like to convert? I didn't find any obvious
> candidates... Or do you mean the messages in udf_fill_super() when we find
> on-disk inconsistencies or similar? I guess we can leave that for later
> because propagating 'fc' into all the validation functions will be a lot of
> churn.

Yup I was thinking about messages in fill_super. I can check w/ dhowells later
to see what the expectation is, but I had the hunch that generally any errors
encountered during mount should route through those functions now.

Happy to leave it for later ;)

-Eric

