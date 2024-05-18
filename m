Return-Path: <linux-fsdevel+bounces-19713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8158C90CF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 14:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439FFB21428
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 12:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E5F39FFD;
	Sat, 18 May 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H+O9P6ao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A938374F1;
	Sat, 18 May 2024 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716035278; cv=none; b=HIM98HEDgi0PGcIyJkzArFq46eHEjHwntK0xOuJQLs4qeaCibBeBgBGkCkRtB36+YAK9AmJFBbUxMgkV+52TSejHhgaayGOXuiZuHcWK4c7k+Q1tUneO5rOoeiZasIdalq4NcrZ3NpAZ+6lSPGKZkeRqIO7yWNA9uYmBs1cx2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716035278; c=relaxed/simple;
	bh=l9PeXp4vw/KCcUZ++53BMzuRRh0uGvhIInBJkHr67TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQV1RvTDwweMYVI96KfggH95XbdeB6N8avSkqI/89o/VvzQo3kxwquNPY6/Baffu5jL6c572f6BoucRjKxpMM+tBiBeRS9kjbwjZoT982QEySkjY/FisumxyruCH790Ko0m3cYFdo7y94u4bfE/Jh01Hp21kGzu7s66vdqS2DBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H+O9P6ao; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.8.193.2] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AAD3540ECA;
	Sat, 18 May 2024 12:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716035268;
	bh=sXZbZDLCNj22sUbcOEyEP2UEg9NrXec19kZpuJeYKrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=H+O9P6aovIWArXk0nBYi3Yp4A8SWvjGbb0JnbbTtOOBqKHcqnULlYHROssvsUWhCn
	 estnNEv+EJ6gvILDfgcU5x43YbCrZTFEQFCbDRGHkQm4dgCf0yj9ao3R34iruA02SS
	 E6VVcVvyEYeYQuunHyWnz0InyU0Ax/OeqaqpwZ8NpVtXqYWW/2mHGpov/60GVVlOaL
	 i8dD43gQ97IYXpyPeJeT9kItwmBbJmpgdar0tcO2/FiVarfDNsU2+HKSnCXIlwupA2
	 hoaiYvBIXFjK9Kw+51MufG6rhw6BGSotxh9dOI6wMXP7JKObDen+y4eSGJiJ+VyOvT
	 887wA9KlBDf+Q==
Message-ID: <7f94cb03-d573-4cc5-b288-038e44bc1318@canonical.com>
Date: Sat, 18 May 2024 05:27:27 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] capabilities: user namespace capabilities
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: brauner@kernel.org, ebiederm@xmission.com,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Joel Granados <j.granados@samsung.com>, Serge Hallyn <serge@hallyn.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 containers@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 keyrings@vger.kernel.org
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-2-jcalmels@3xx0.net>
 <641a34bd-e702-4f02-968e-4f71e0957af1@canonical.com>
 <jwuknxmitht42ghsy6nkoegotte5kxi67fh6cbei7o5w3bv5jy@eyphufkqwaap>
 <be62b80f-2e86-4cbc-82ce-c9f62098ef60@canonical.com>
 <txmrzwf2kr6devb5iqghctgvtbccjaspf44entk4fopjbaet2j@zqdfxiy6y6ej>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <txmrzwf2kr6devb5iqghctgvtbccjaspf44entk4fopjbaet2j@zqdfxiy6y6ej>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/17/24 20:50, Jonathan Calmels wrote:
> On Fri, May 17, 2024 at 04:59:41AM GMT, John Johansen wrote:
>> On 5/17/24 03:51, Jonathan Calmels wrote:
>>> This new capability set would be a universal thing that could be
>>> leveraged today without modification to userspace. Moreover, it’s a
>>> simple framework that can be extended.
>>
>> I would argue that is a problem. Userspace has to change for this to be
>> secure. Is it an improvement over the current state yes.
> 
> Well, yes and no. With those patches, I can lock down things today on my
> system and I don't need to change anything.
> 
sure, same as with the big no user ns toggle. This is finer and allows
selectively enabling on a per application basis.

> For example I can decide that none of my rootless containers started
> under SSH will get CAP_NET_ADMIN:
> 
> # echo "auth optional pam_cap.so" >> /etc/pam.d/sshd
> # echo "!cap_net_admin $USER"     >> /etc/security/capability.conf
> # capsh --secbits=$((1 << 8)) -- -c /usr/sbin/sshd
> 
> $ ssh localhost 'unshare -r capsh --current'
> Current: =ep cap_net_admin-ep
> Current IAB: !cap_net_admin
> 
> Or I can decide than I don't ever want CAP_SYS_RAWIO in my namespaces:
> 
> # sysctl -w cap_bound_userns_mask=0x1fffffdffff
> 
> This doesn't require changes to userspace.
> Now, granted if you want to have finer-grained controls, it will require
> *some* changes in *some* places (e.g. adding new systemd property like
> UserNSSet=).
> 

yep

>>> Well that’s the thing, from past conversations, there is a lot of
>>> disagreement about restricting namespaces. By restricting the
>>> capabilities granted by namespaces instead, we’re actually treating the
>>> root cause of most concerns.
>>>
>> no disagreement there. This is actually Ubuntu's posture with user namespaces
>> atm. Where the user namespace is allowed but the capabilities within it
>> are denied.
>>
>> It does however when not handled correctly result in some very odd failures
>> and would be easier to debug if the use of user namespaces were just
>> cleanly denied.
> 
> Yes but as we established it depends on the use case, both are not
> mutually exclusive.
> 
yep

>> its not so much the capabilities set as the inheritable part that is
>> problematic. Yes I am well aware of where that is required but I question
>> that capabilities provides the needed controls here.
> 
> Again, I'm not opposed to doing this with LSMs. I just think both could
> work well together. We already do that with standard capabilities vs
> LSMs, both have their strength and weaknesses.
> 
yes, don't get me wrong I am not necessarily advocating an LSM solution
as being necessary. I just want to make sure the trade-offs of the
capabilities solution get discussed to help evaluate whether extending
the current capability model is worth it.

> It's always a tradeoff, do you want a setting that's universal and
> coarse, or do you want one that's tailored to specific things but less
> ubiquitous.
> 
yep

> It's also a tradeoff on usability. If this doesn't get used in practice,
> then there is no point.
agreed

> I would argue that even though capabilities are complicated, they are
> more widely understood than LSMs. Are capabilities insufficient in
> certain scenarios, absolutely, and that's usually where LSMs come in.
> 
hrmmm, I am not sure I would agree with capabilities are better understood
than LSMs, At the base level of capability(X) to get permission yes, but
the whole permitting, bounding, ... Really I think most people are just
confused by both

>>> This is possible with the security bit introduced in the second patch.
>>> The idea of having those separate is that a service which has dropped
>>> its capabilities can still create a fully privileged user namespace.
>>
>> yes, which is the problem. Not that we don't do that with say setuid
>> applications, but the difference is that they were known to be doing
>> something dangerous and took measures around that.
>>
>> We are starting from a different posture here. Where applications have
>> assumed that user namespaces where safe and no measures were needed.
>> Tools like unshare and bwrap if set to allow user namespaces in their
>> fcaps will allow exploits a trivial by-pass.
> 
> Agreed, but we can't really walk back this decision unfortunately.

And that is partly the crux of the issue, if we can't walk back the
decision then the solution becomes more complex

> At least with this patch series system administrators have the ability
> to limit such tools.
> 
agreed

>> What I was trying to get at is two points.
>> 1. The written description wasn't clear enough, leaving room for
>>     ambiguity.
>> 2. That I quest that the behavior should be allowed given the
>>     current set of tools that use user namespaces. It reduces exploit
>>     codes ability to directly use unprivileged user namespaces but
>>     makes it all to easy to by-pass the restriction because of the
>>     behavior of the current tool set. ie. user space has to change.
> 
>> But again, I believe the fcaps behavior is wrong, because of the state of
>> current software. If this had been a proposal where there was no existing
>> software infrastructure I would be starting from a different stance.
> 
> As mentioned above, userspace doesn't necessarily have to change. I'm
> also not sure what you mean by easy to by-pass? If I mask off some
> capabilities system wide or in a given process tree, I know for a fact
> that no namespace will ever get those capabilities.

so by-pass will very much depend on the system but from a distro pov
we pretty much have to have bwrap enabled if users want to use flatpaks
(and they do), same story for several other tools. Since this basically
means said tools need to be available by default, most systems the
distro is installed on are vulnerable by default. The trivial by-pass
then becomes the exploit running its payload through one of these tools,
and yes I have tested it.

Could a distro disable these tools by default, and require the user/admin
to enable them, yes though there would be a lot of friction, push back,
and in the end most systems would still end up with them enabled.

With the capibilities approach can a user/admin make their system
more secure than the current situation, absolutely.

Note, that regardless of what happens with patch 1, and 2. I think we
either need the big sysctl toggle, or a version of your patch 3


