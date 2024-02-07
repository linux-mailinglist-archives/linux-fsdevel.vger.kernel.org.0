Return-Path: <linux-fsdevel+bounces-10596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64F784C943
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 12:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764972830FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A742318EA1;
	Wed,  7 Feb 2024 11:11:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0817BD6;
	Wed,  7 Feb 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304266; cv=none; b=A89A3kzTyZM4iRb3rpmMJW3D377NaEnyy+q2XEQ7jCI8mRIECFPhmByhaoF87oTdzc7/9wyNUGMtNHu/WI9diofBCnM6fMPuWIX92YdT1+7U5Y9e6XKdaHlL4I/sLRhXFHhf6JS4Wb/qlA3LOgW3aOePeFN8BKwsJV6L9zeEIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304266; c=relaxed/simple;
	bh=bSbwSNh4jw6Hlml5ZP+MdMI2o7ktMWvwYImN2GhPc7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBnoZP4YMPXXA3wNmjraMahLd4NuRbh2moOZ/iZiP7c2Mk+5fIHmH7spXcC1iEWW4fsYxwHnjBn3ahlh8J7qqOEa6UnqN1uxv0NXK1YbwBnVgdt7LWIKHVLCO2tGOAHvp6KC11rdaKBvvnTH8w4/Id/yfi/rDQRqwh/h1vtL/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 417BAuAe067452;
	Wed, 7 Feb 2024 20:10:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Wed, 07 Feb 2024 20:10:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 417BAuf0067445
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 7 Feb 2024 20:10:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>
Date: Wed, 7 Feb 2024 20:10:55 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
 <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/07 9:00, Paul Moore wrote:
>> @@ -1223,6 +1223,17 @@ void security_bprm_committed_creds(const struct linux_binprm *bprm)
>>  	call_void_hook(bprm_committed_creds, bprm);
>>  }
>>  
>> +/**
>> + * security_execve_abort() - Notify that exec() has failed
>> + *
>> + * This hook is for undoing changes which cannot be discarded by
>> + * abort_creds().
>> + */
>> +void security_execve_abort(void)
>> +{
>> +	call_void_hook(execve_abort);
>> +}
> 
> I don't have a problem with reinstating something like
> security_bprm_free(), but I don't like the name security_execve_abort(),
> especially given that it is being called from alloc_bprm() as well as
> all of the execve code.  At the risk of bikeshedding this, I'd be much
> happier if this hook were renamed to security_bprm_free() and the
> hook's description explained that this hook is called when a linux_bprm
> instance is being destroyed, after the bprm creds have been released,
> and is intended to cleanup any internal LSM state associated with the
> linux_bprm instance.
> 
> Are you okay with that?

Hmm, that will bring us back to v1 of this series.

v3 was based on Eric W. Biederman's suggestion

  If you aren't going to change your design your new hook should be:
          security_execve_revert(current);
  Or maybe:
          security_execve_abort(current);

  At least then it is based upon the reality that you plan to revert
  changes to current->security.  Saying anything about creds or bprm when
  you don't touch them, makes no sense at all.  Causing people to
  completely misunderstand what is going on, and making it more likely
  they will change the code in ways that will break TOMOYO.

at https://lkml.kernel.org/r/8734ug9fbt.fsf@email.froward.int.ebiederm.org .


