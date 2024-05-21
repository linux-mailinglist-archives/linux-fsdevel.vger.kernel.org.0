Return-Path: <linux-fsdevel+bounces-19901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE398CB082
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFD5286634
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ACD130481;
	Tue, 21 May 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mDR1yYAw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F912FF97;
	Tue, 21 May 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301799; cv=none; b=n2UKm68cjwK595Sy+fvSo45SaHQMbfgTZfa4bc8Kslij6O2fcEUQPgf9kj0fe2AvzFvcPtj3JZ4uZ73TGV78bc1GCRycVP4I9fUMNVEHOF57gS8fO93B0YOpspeGsMy2U8BRqdPiOrDSpsC0iwfjJnFWO8NWol9GXgTnzzCUcKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301799; c=relaxed/simple;
	bh=fOzx5pPgs4TLf88Kym4fSMFzoteMrSMW5sS/xigO9PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roVucNcWygHI0f4bhCUdj8hvjxllUOpNnHXeEaFIUvCnTty0IkTowavCYPXmYRiiZqZ4aLgA23uscaW21u7qkN/pvLAEJUNqJlKWIc9AsWq02K/sCKRydNF50D4oJ+8By+dXZ9rGuJnlJZUJ5Y24Gy0flE5vjrctC5E/pKZ2tXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mDR1yYAw; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 89D463F1C7;
	Tue, 21 May 2024 14:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716301795;
	bh=E+n+dPajliecQhWLmYeM1VpvL8BlnUE3CWeiaeuVm/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=mDR1yYAwtthcAxMJ3ggsqdymxw105v3cYkv9tisX4muomyBsGOnR+SBGEb9KK8On6
	 88ui9wBmRAwlYxm/Fwx3UeP3hlIvqWPEA+z30+IrzCNw2tsa2CBtd23CWbqq8rMM0T
	 Msgyf5EwGxn/ScFYH+7hNCuKbmoDnqHfXaoB+h19wD/2JvVzwPaH6lifXLRcUMqz4H
	 2COyEMl2rFn0KpdgOj/p7E/0IFFU8t+1hO6uzpzCGorcbwrze+9HVZ6/EfbsntnJSU
	 TfwHXfaaxAl6oPJerwu4DBmPxHC91zL5OB0fX8wJGCUCUZdrvbofNSDRyUksRH0UmP
	 50t7c5/9KsBww==
Message-ID: <74480773-79e7-4b4f-bd1e-1424f5110119@canonical.com>
Date: Tue, 21 May 2024 07:29:50 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
To: Serge Hallyn <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: Jonathan Calmels <jcalmels@3xx0.net>, Jarkko Sakkinen
 <jarkko@kernel.org>, brauner@kernel.org, ebiederm@xmission.com,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Joel Granados <j.granados@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>,
 containers@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 keyrings@vger.kernel.org
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>
 <D1BBFWKGIA94.JP53QNURY3J4@kernel.org>
 <D1BBI1LX2FMW.3MTQAHW0MA1IH@kernel.org>
 <D1BC3VWXKTNC.2DB9JIIDOFIOQ@kernel.org>
 <jvy3npdptyro3m2q2junvnokbq2fjlffljxeqitd55ff37cydc@b7mwtquys6im>
 <df3c9e5c-b0e7-4502-8c36-c5cb775152c0@schaufler-ca.com>
 <ZkidDlJwTrUXsYi9@serge-l-PF3DENS3>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <ZkidDlJwTrUXsYi9@serge-l-PF3DENS3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/24 05:20, Serge Hallyn wrote:
> On Fri, May 17, 2024 at 10:53:24AM -0700, Casey Schaufler wrote:
>> On 5/17/2024 4:42 AM, Jonathan Calmels wrote:
>>>>>> On Thu May 16, 2024 at 10:07 PM EEST, Casey Schaufler wrote:
>>>>>>> I suggest that adding a capability set for user namespaces is a bad idea:
>>>>>>> 	- It is in no way obvious what problem it solves
>>>>>>> 	- It is not obvious how it solves any problem
>>>>>>> 	- The capability mechanism has not been popular, and relying on a
>>>>>>> 	  community (e.g. container developers) to embrace it based on this
>>>>>>> 	  enhancement is a recipe for failure
>>>>>>> 	- Capabilities are already more complicated than modern developers
>>>>>>> 	  want to deal with. Adding another, special purpose set, is going
>>>>>>> 	  to make them even more difficult to use.
>>> Sorry if the commit wasn't clear enough.
>>
>> While, as others have pointed out, the commit description left
>> much to be desired, that isn't the biggest problem with the change
>> you're proposing.
>>
>>>   Basically:
>>>
>>> - Today user namespaces grant full capabilities.
>>
>> Of course they do. I have been following the use of capabilities
>> in Linux since before they were implemented. The uptake has been
>> disappointing in all use cases.
>>
>>>    This behavior is often abused to attack various kernel subsystems.
>>
>> Yes. The problems of a single, all powerful root privilege scheme are
>> well documented.
>>
>>>    Only option
>>
>> Hardly.
>>
>>>   is to disable them altogether which breaks a lot of
>>>    userspace stuff.
>>
>> Updating userspace components to behave properly in a capabilities
>> environment has never been a popular activity, but is the right way
>> to address this issue. And before you start on the "no one can do that,
>> it's too hard", I'll point out that multiple UNIX systems supported
>> rootless, all capabilities based systems back in the day.
>>
>>>    This goes against the least privilege principle.
>>
>> If you're going to run userspace that *requires* privilege, you have
>> to have a way to *allow* privilege. If the userspace insists on a root
>> based privilege model, you're stuck supporting it. Regardless of your
>> principles.
> 
> Casey,
> 
> I might be wrong, but I think you're misreading this patchset.  It is not
> about limiting capabilities in the init user ns at all.  It's about limiting
> the capabilities which a process in a child userns can get.
> 
> Any unprivileged task can create a new userns, and get a process with
> all capabilities in that namespace.  Always.  User namespaces were a
> great success in that we can do this without any resulting privilege
> against host owned resources.  The unaddressed issue is the expanded
> kernel code surface area.
> 
> You say, above, (quoting out of place here)
> 
>> Updating userspace components to behave properly in a capabilities
>> environment has never been a popular activity, but is the right way
>> to address this issue. And before you start on the "no one can do that,
>> it's too hard", I'll point out that multiple UNIX systems supported
> 
> He's not saying no one can do that.  He's saying, correctly, that the
> kernel currently offers no way for userspace to do this limiting.  His
> patchset offers two ways: one system wide capability mask (which applies
> only to non-initial user namespaces) and on per-process inherited one
> which - yay - userspace can use to limit what its children will be
> able to get if they unshare a user namespace.
> 
>>> - It adds a new capability set.
>>
>> Which is a really, really bad idea. The equation for calculating effective
>> privilege is already more complicated than userspace developers are generally
>> willing to put up with.
> 
> This is somewhat true, but I think the semantics of what is proposed here are
> about as straightforward as you could hope for, and you can basically reason
> about them completely independently of the other sets.  Only when reasoning
> about the correctness of this code do you need to consider the other sets.  Not
> when administering a system.
> 
> If you want root in a child user namespace to not have CAP_MAC_ADMIN, you drop
> it from your pU.  Simple as that.
> 
>>>    This set dictates what capabilities are granted in namespaces (instead
>>>    of always getting full caps).
>>
>> I would not expect container developers to be eager to learn how to use
>> this facility.
> 
> I'm a container developer, and I'm excited about it :)
> 
>>>    This brings namespaces in line with the rest of the system, user
>>>    namespaces are no more "special".
>>
>> I'm sorry, but this makes no sense to me whatsoever. You want to introduce
>> a capability set explicitly for namespaces in order to make them less
>> special?
> 
> Yes, exactly.
> 
>> Maybe I'm just old and cranky.
> 
> That's fine.
> 
>>>    They now work the same way as say a transition to root does with
>>>    inheritable caps.
>>
>> That needs some explanation.
>>
>>>
>>> - This isn't intended to be used by end users per se (although they could).
>>>    This would be used at the same places where existing capabalities are
>>>    used today (e.g. init system, pam, container runtime, browser
>>>    sandbox), or by system administrators.
>>
>> I understand that. It is for containers. Containers are not kernel entities.
> 
> User namespaces are.
> 
> This patch set provides userspace a way of limiting the kernel code exposed
> to untrusted children, which currently does not exist.
> 
theoretically, I am worried that in practice the existing utils allow
untrusted code to still access user namespaces.

In practice we have found that we need to allow a different set of capabilities
when bwrap is called from flatpak than when called on its own etc. We see the
same pattern with unshare and other utilities around launching applications
in user namespaces.

In practice at the distro level I don't see this approach actually helping.
Because we have so many uses that require exposing close to the full capabilities
set in multiple utilities that are required by many different applications.

To be clear this doesn't stop distros from doing something more, but is it
worth the added complexity if in practice it can't be used effectively.
I really don't have the answer.


