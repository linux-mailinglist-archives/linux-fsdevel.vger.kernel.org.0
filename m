Return-Path: <linux-fsdevel+bounces-10684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C6884D5C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37149B2259C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBEF149E02;
	Wed,  7 Feb 2024 22:23:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688A149DED;
	Wed,  7 Feb 2024 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707344617; cv=none; b=T5RILniLnhDn3ZdAmcdQLRUwTmPG8HRHCv914/FdOk+4/JbA2RGC9opzUiPPdOA3IeS4Z6DfnnJ1wzEqCRSCj0ZA+4Lq+FEGUGRnfJ1UMnXxbc6ukin0yvwHCHg62kXx+N8cMqntS5S/DWmnf1ebZ545nQ6cLYmf+JX3asMEBsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707344617; c=relaxed/simple;
	bh=XwikaQ6+ius76AbMgM536A/XK9118cZuO9+91lyE5wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5hzriESyOVK+sBAdEAanVc5HSg80NIGG7BUWvxnHybWBfjbDhBuUl6Lu7yKV8x5kW8T4NBWlEZRw9A58pdL35/c06pEb0nnBIiqYlmN1vjbpioQQfCR6AAJ3M8/+u7nE5FxZA1Wr0qezzPsbiF8VdCpqwkiSIbU8wHJ9MdZ1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 417MN1Lq031045;
	Thu, 8 Feb 2024 07:23:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Thu, 08 Feb 2024 07:23:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 417MN0Tr031037
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 8 Feb 2024 07:23:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <824bbb77-588b-4b64-b0cd-85519c16a3fb@I-love.SAKURA.ne.jp>
Date: Thu, 8 Feb 2024 07:22:57 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>
Cc: Kees Cook <keescook@chromium.org>, Eric Biederman
 <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook>
 <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
 <202402070740.CFE981A4@keescook>
 <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
 <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/08 2:57, Linus Torvalds wrote:
> On Wed, 7 Feb 2024 at 16:45, Paul Moore <paul@paul-moore.com> wrote:
>>
>> Okay, let's get confirmation from Tetsuo on the current state of
>> TOMOYO in Linus' tree.  If it is currently broken [..]
> 
> As far as I understand, the current state is working, just the horrid
> random flag.

Yes, the current state is working.

> 
> So I think the series is a cleanup and worth doing, but also not
> hugely urgent. But it would probably be good to just get this whole
> thing over and done with, rather than leave it lingering for another
> release for no reason.

Right.


