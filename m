Return-Path: <linux-fsdevel+bounces-19890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3F68CAFC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 15:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CFE1C2185E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C247F47B;
	Tue, 21 May 2024 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="m7zO3Zsr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17A7CF39;
	Tue, 21 May 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299892; cv=none; b=IxR1oegC5w4zrguOia1siAUkx+3jAM2OqyNBPKkRFF9Nsb7CtkTYn12sLlf6hv1H0JetXjZMt5easqykG8SkgAcGnOwmFpSwnuJUZC1uOtV1tfciWPWtk2bJlfzyoWwZaR0bigLJQcl2cU9WamthUQAfjNTi+P9t4gkHOdV4j/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299892; c=relaxed/simple;
	bh=IFxykgL4i+7OkE2HCCYJkBDbEnmNeEOyhztywlck38E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5FEMY1XuqCG2uGit1xOfwqAecxs2IDow3GPqes7YQKQE7ESvHUZPxmhmKTAzVG1iCdrOrKxbJahCy2C4Ttyt+gsMh5B3Xy13ZW7P03deDF8484jt6OOb2IFwZA0W7t+nQVHKlyvut52j8YQ9U4LmFgVva5bED0uT8gqvq6yITE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=m7zO3Zsr; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 677D23F1DF;
	Tue, 21 May 2024 13:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716299882;
	bh=dD3lJ5LEcnY8Jlr8OtzBKvvhqYyRgZu66FmZbZHw2Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=m7zO3Zsr6BufaPwLWS9yLnKNmn5u6LmiqqdPWxTiz8285beFyKlH8o7VIx1MQ/1MI
	 kHcHpD//wtQjlmT3KlFT5Q8G9ewyyXXFBNeHfdzJS26unw3zuRH3uaVKvHR0qf15z0
	 ztQAMtWvK4m2/7Gon5BWZ0fP+KnlRJFGsyqpsxsWXE/pxBC6Cpp8/DZMb2k0a02qtG
	 goypLplT0oGH58xYx8DoQC9XCON8unIWyk5k+VkwjLp3r5Clvp5GVGIvYTfCmX1U3w
	 KZu31IDlAwYI/iMZ0v7jaZ0MKsF8FfeyDgCAHOQDE+qekRXtjZfW55K3m02OL3R6pY
	 h/b3Pw9CdU2sw==
Message-ID: <1b0d222a-b556-48b0-913f-cdd5c30f8d27@canonical.com>
Date: Tue, 21 May 2024 06:57:58 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
To: Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Calmels
 <jcalmels@3xx0.net>, Casey Schaufler <casey@schaufler-ca.com>
Cc: brauner@kernel.org, ebiederm@xmission.com,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Joel Granados <j.granados@samsung.com>, Serge Hallyn <serge@hallyn.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 David Howells <dhowells@redhat.com>, containers@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>
 <D1BBFWKGIA94.JP53QNURY3J4@kernel.org>
 <D1BBI1LX2FMW.3MTQAHW0MA1IH@kernel.org>
 <D1BC3VWXKTNC.2DB9JIIDOFIOQ@kernel.org>
 <jvy3npdptyro3m2q2junvnokbq2fjlffljxeqitd55ff37cydc@b7mwtquys6im>
 <df3c9e5c-b0e7-4502-8c36-c5cb775152c0@schaufler-ca.com>
 <vhpmew3kyay3xq4h3di3euauo43an22josvvz6assex4op3gzw@xeq63mqb2lmh>
 <D1CQ1FZ72NIW.2U7ZH0GU6C5W5@kernel.org>
 <D1CQ8J60S7L4.1OVRIWBERNM5Y@kernel.org>
 <D1CQC0PTK1G0.124QCO3S041Q@kernel.org>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <D1CQC0PTK1G0.124QCO3S041Q@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/24 04:21, Jarkko Sakkinen wrote:
> On Sat May 18, 2024 at 2:17 PM EEST, Jarkko Sakkinen wrote:
>> On Sat May 18, 2024 at 2:08 PM EEST, Jarkko Sakkinen wrote:
>>> On Fri May 17, 2024 at 10:11 PM EEST, Jonathan Calmels wrote:
>>>> On Fri, May 17, 2024 at 10:53:24AM GMT, Casey Schaufler wrote:
>>>>> Of course they do. I have been following the use of capabilities
>>>>> in Linux since before they were implemented. The uptake has been
>>>>> disappointing in all use cases.
>>>>
>>>> Why "Of course"?
>>>> What if they should not get *all* privileges?
>>>
>>> They do the job given a real-world workload and stress test.
>>>
>>> Here the problem is based on a theory and an experiment.
>>>
>>> Even a formal model does not necessarily map all "unknown unknowns".
>>
>> So this was like the worst "sales pitch" ever:
>>
>> 1. The cover letter starts with the idea of having to argue about name
>> spaces, and have fun while doing that ;-) We all have our own ways to
>> entertain ourselves but "name space duels" are not my thing. Why not
>> just start with why we all want this instead? Maybe we don't want it
>> then. Maybe this is just useless spam given the angle presented?
>> 2. There's shitloads of computer science and set theory but nothing
>> that would make common sense. You need to build more understandable
>> model. There's zero "gist" in this work.
>>
>> Maybe this does make sense but the story around it sucks so far.
> 
> One tip: I think this is wrong forum to present namespace ideas in the
> first place. It would be probably better to talk about this with e.g.
> systemd or podman developers, and similar groups. There's zero evidence
> of the usefulness. Then when you go that route and come back with actual
> users, things click much more easily. Now this is all in the void.
> 
> BR, Jarkko

Jarkko,

this is very much the right forum. User namespaces exist today. This
is a discussion around trying to reduce the exposed kernel surface
that is being used to attack the kernel.



