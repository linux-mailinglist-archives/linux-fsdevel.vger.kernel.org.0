Return-Path: <linux-fsdevel+bounces-19663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812A98C8619
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 14:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37EF1286A72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 12:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACC841C87;
	Fri, 17 May 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ECINu236"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB05FDA5;
	Fri, 17 May 2024 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947187; cv=none; b=Zb7I0mOVofy2OzP8j/Wh8PzwHeZxIk8yNu1YPwx++Ba9mVOtoo6cCTvX/HpJM6EkMVYY9JuWEl4NW3bE3m28WnayuiaLwp1mXxzSlui6fGIDSAJipiKj/6z2YsictySreKMgHLm6GLDyJuCm6g8UMQHyFOchghuTf0/PUJdor5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947187; c=relaxed/simple;
	bh=TvBGTTdVnDV+b4Yl5iLq0qnZcplU/ybcNrcwUEiKzbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNGSBT7MyFewiPvla+nYVp9uLGbXF/He9CEZA8CAJcSSiPziJoeFvFFfx32YG+gkiSDC4BsTPGMvsxtGkL2s7GmsY5ueIpynsQsA+bPValzLBgFK2qntjs/qvLwMDswzeSs8MTT8C6YcLc1vheaFSUW3zbf/QQdxiwJbZi7QV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ECINu236; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.55.0.156] (unknown [149.11.192.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 301E83F764;
	Fri, 17 May 2024 11:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715947183;
	bh=bxYKAh9DncLSWIwt/nYavWMG6zn2ybxfgSMkcb9j328=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ECINu236ay7xBFBlcVmlIC1CgdSi1M4l4lYbYap+wZHovT8tQshlPPOG0CVdzKzoi
	 OkUEpJj/Yw4/3qYL6xhLAQwjyGg5tDmNrgX/Ok30KFWImXulxHmVao6JuaVJZtKIn1
	 09aktOgrmwqJNe/crDjO2WArcPfFYraPZXIparu72+PIdLFsUBStuEnRiCPAQTDGTy
	 rnx7he7GUB0nYZYNGetqeR+RwRFleUkx3PiSXa44mLpK0qL9dvC8qFnbGkwz6aZnJI
	 dlZlwDiOio6x+A08xjckndaIhar7btulg86/vj6MMCFc6a7BHfT0UazPOsUs+F64Zb
	 VyebFN8ATw7yQ==
Message-ID: <be62b80f-2e86-4cbc-82ce-c9f62098ef60@canonical.com>
Date: Fri, 17 May 2024 04:59:41 -0700
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
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <jwuknxmitht42ghsy6nkoegotte5kxi67fh6cbei7o5w3bv5jy@eyphufkqwaap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/17/24 03:51, Jonathan Calmels wrote:
> On Thu, May 16, 2024 at 03:07:28PM GMT, John Johansen wrote:
>> agreed, though it really is application dependent. Some applications handle
>> the denial at userns creation better, than the capability after. Others
>> like anything based on QTWebEngine will crash on denial of userns creation
>> but handle denial of the capability within the userns just fine, and some
>> applications just crash regardless.
> 
> Yes this is application specific, but I would argue that the latter is
> much more preferable. For example, having one application crash in a
> container is probably ok, but not being able to start the container in
> the first place is probably not. Similarly, preventing the network
> namespace creation breaks services which rely on systemd’s
> PrivateNetwork, even though they most likely use it to prevent any
> networking from being done.
> 
Agred the solution has to be application/usage model specific. Some of
them are easy, and others not so much.

>> The userns cred from the LSM hook can be modified, yes it is currently
>> specified as const but is still under construction so it can be safely
>> modified the LSM hook just needs a small update.
>>
>> The advantage of doing it under the LSM is an LSM can have a richer policy
>> around what can use them and tracking of what is allowed. That is to say the
>> LSM has the capability of being finer grained than doing it via capabilities.
> 
> Sure, we could modify the LSM hook to do all sorts of things, but
> leveraging it would be quite cumbersome, will take time to show up in
> userspace, or simply never be adopted.
> We’re already seeing it in Ubuntu which started requiring Apparmor profiles.
> 

yes, I would argue that is a metric of adoption.

> This new capability set would be a universal thing that could be
> leveraged today without modification to userspace. Moreover, it’s a
> simple framework that can be extended.

I would argue that is a problem. Userspace has to change for this to be
secure. Is it an improvement over the current state yes.

> As you mentioned, LSMs are even finer grained, and that’s the idea,
> those could be used hand in hand eventually. You could envision LSM
> hooks controlling the userns capability set, and thus enforce policies
> on the creation of nested namespaces without limiting the other tasks’
> capabilities.
> 
>> I am not opposed to adding another mechanism to control user namespaces,
>> I am just not currently convinced that capabilities are the right
>> mechanism.
> 
> Well that’s the thing, from past conversations, there is a lot of
> disagreement about restricting namespaces. By restricting the
> capabilities granted by namespaces instead, we’re actually treating the
> root cause of most concerns.
> 
no disagreement there. This is actually Ubuntu's posture with user namespaces
atm. Where the user namespace is allowed but the capabilities within it
are denied.

It does however when not handled correctly result in some very odd failures
and would be easier to debug if the use of user namespaces were just
cleanly denied.

> Today user namespaces are "special" and always grant full caps. Adding a
> new capability set to limit this behavior is logical; same way it's done
> for usual process transitions.
> Essentially this set is to namespaces what the inheritable set is to
> root.
> 
its not so much the capabilities set as the inheritable part that is
problematic. Yes I am well aware of where that is required but I question
that capabilities provides the needed controls here.

>> this should be bounded by the creating task's bounding set, other wise
>> the capability model's bounding invariant will be broken, but having the
>> capabilities that the userns want to access in the task's bounding set is
>> a problem for all the unprivileged processes wanting access to user
>> namespaces.
> 
> This is possible with the security bit introduced in the second patch.
> The idea of having those separate is that a service which has dropped
> its capabilities can still create a fully privileged user namespace.

yes, which is the problem. Not that we don't do that with say setuid
applications, but the difference is that they were known to be doing
something dangerous and took measures around that.

We are starting from a different posture here. Where applications have
assumed that user namespaces where safe and no measures were needed.
Tools like unshare and bwrap if set to allow user namespaces in their
fcaps will allow exploits a trivial by-pass.

> For example, systemd’s machined drops capabilities from its bounding set,
> yet it should be able to create unprivileged containers.
> The invariant is sound because a child userns can never regain what it
> doesn’t have in its bounding set. If it helps you can view the userns
> set as a “namespace bounding set” since it defines the future bounding
> sets of namespaced tasks.
> 
sure I get it, some of the use cases work, some not so well

>> If I am reading this right for unprivileged processes the capabilities in
>> the userns are bounded by the processes permitted set before the userns is
>> created?
> 
> Yes, unprivileged processes that want to raise a capability in their
> userns set need it in their permitted set (as well as their bounding
> set). This is similar to inheritable capabilities.

Right.

> Recall that processes start with a full set of userns capabilities, so
> if you drop a userns capability (or something else did, e.g.
> init/pam/sysctl/parent) you will never be able to regain it, and
> namespaces you create won't have it included.

sure, that part of the behavior is fine

> Now, if you’re root (or cap privileged) you can always regain it.
> 
yes

What I was trying to get at is two points.
1. The written description wasn't clear enough, leaving room for
    ambiguity.
2. That I quest that the behavior should be allowed given the
    current set of tools that use user namespaces. It reduces exploit
    codes ability to directly use unprivileged user namespaces but
    makes it all to easy to by-pass the restriction because of the
    behavior of the current tool set. ie. user space has to change.

>> This is only being respected in PR_CTL, the user mode helper is straight
>> setting the caps.
> 
> Usermod helper requires CAP_SYS_MODULE and CAP_SETPCAP in the initns so
> the permitted set is irrelevant there. It starts with a full set but from
> there you can only lower caps, so the invariant holds.
> 
sure, I get what is happening. Again the description needs work. It was
ambiguous as to whether it was applying to the fcaps or only the pcaps.

But again, I believe the fcaps behavior is wrong, because of the state of
current software. If this had been a proposal where there was no existing
software infrastructure I would be starting from a different stance.

