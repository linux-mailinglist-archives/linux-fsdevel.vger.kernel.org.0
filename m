Return-Path: <linux-fsdevel+bounces-79409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM16DhpOqGmvsgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 16:22:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 930602028C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 16:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F4803099159
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC27F315D5D;
	Wed,  4 Mar 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7mD8yPW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1C1A6819;
	Wed,  4 Mar 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637331; cv=none; b=NuaYKuYiK5ncA/IE81JVm6GmuDrUAZNF3nLFjTQBRrHM4pldxgZNt+ZNFAGf/vMCNj90LTXDX4rp8YU/XkKjhLLe+KI+0QXZhaHC6xf7JjC2qJ4kJZI2Ecs1s1d5v85je0bnRm8HvIcz150hoZO+6nELUhu7K8MA1X+IE+XOUEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637331; c=relaxed/simple;
	bh=pbOvXCEKkljl0nZLh4tnepkT3i2IOCwHhGwSKDWqiJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tghLzR/7cb429YZGaFEr5X0RPBi8zjeHimOhQplINhROPkt465sEcj1xL9m5QAFBWfvCkN8p8/bTtCDg4prSEBxg98bPSxiOxV4fJi5ZF5/M40vHly11hqf4wyCVH7Mo4llZK04Ut+AlgPE5r4zvW+R2i3UXY3tZPKXbbSt3ULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7mD8yPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F185C4CEF7;
	Wed,  4 Mar 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772637331;
	bh=pbOvXCEKkljl0nZLh4tnepkT3i2IOCwHhGwSKDWqiJE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P7mD8yPWVmoBcNL+ijGmQzbYjbp7FqU4magnqIBXvJoCeyZU9cTHUF2mRPSq7rQLw
	 Kzn809Nb7227Gan1PVM5fON3v3kN5P2idvbwzIOdxozk0H5PUGmkDCdmGWuJXzzknO
	 XQ0aQP6nx3mRujkArqadY9BSKdYE6Q6r+EuvwGKrMEW6hD7rTX5f6QLAF71Zs5SFRp
	 JO96Z+QXzMTCDrTZJ1SzBLlmiT6HA2VDPvsenBbEpQ53JfQdKLx0kRBSD5tFX9r1Od
	 XyGPIjxehi0YQG8ealSNWQuipLT9R7EmjqYg6/ldfpuXSRUcjoQZ0UTrJNACGc3808
	 ppevVtBViPbnA==
Message-ID: <09872553-f271-4d7f-99d0-1defbd99db81@kernel.org>
Date: Wed, 4 Mar 2026 10:15:29 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
To: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>,
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.com>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>
 <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>
 <177242454307.7472.11164903103911826962@noble.neil.brown.name>
 <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>
 <3r5imygq5ah4khza5fsbgam6ss6ohla24p4ikmbpfpjoj4qmns@f6bw344w4axz>
 <74db1cb73ef8571e2e38187b668a83d28e19933b.camel@kernel.org>
 <2fdaxflmm7hottalnc3wbyzvjp4i5cd6etyvgzq4v3oktfwuuf@spgdoi45urqd>
 <d65b010cec3df6d999becf8afb3186d2a101a369.camel@kernel.org>
 <20260304-lagebericht-narrte-a85cfc96fffd@brauner>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20260304-lagebericht-narrte-a85cfc96fffd@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 930602028C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.cz,brown.name,gmail.com,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-79409-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/26 8:17 AM, Christian Brauner wrote:
> On Mon, Mar 02, 2026 at 12:53:17PM -0500, Jeff Layton wrote:
>> On Mon, 2026-03-02 at 18:37 +0100, Jan Kara wrote:
>>> On Mon 02-03-26 12:10:52, Jeff Layton wrote:
>>>> On Mon, 2026-03-02 at 16:26 +0100, Jan Kara wrote:
>>>>> On Mon 02-03-26 08:57:28, Chuck Lever wrote:
>>>>>> On 3/1/26 11:09 PM, NeilBrown wrote:
>>>>>>> On Mon, 02 Mar 2026, Chuck Lever wrote:
>>>>>>>> On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
>>>>>>>>> On Sun, Mar 1, 2026 at 6:21 PM Chuck Lever <cel@kernel.org> wrote:
>>>>>>>>>> Perhaps that description nails down too much implementation detail,
>>>>>>>>>> and it might be stale. A broader description is this user story:
>>>>>>>>>>
>>>>>>>>>> "As a system administrator, I'd like to be able to unexport an NFSD
>>>>>>>>>
>>>>>>>>> Doesn't "unexporting" involve communicating to nfsd?
>>>>>>>>> Meaning calling to svc_export_put() to path_put() the
>>>>>>>>> share root path?
>>>>>>>>>
>>>>>>>>>> share that is being accessed by NFSv4 clients, and then unmount it,
>>>>>>>>>> reliably (for example, via automation). Currently the umount step
>>>>>>>>>> hangs if there are still outstanding delegations granted to the NFSv4
>>>>>>>>>> clients."
>>>>>>>>>
>>>>>>>>> Can't svc_export_put() be the trigger for nfsd to release all resources
>>>>>>>>> associated with this share?
>>>>>>>>
>>>>>>>> Currently unexport does not revoke NFSv4 state. So, that would
>>>>>>>> be a user-visible behavior change. I suggested that approach a
>>>>>>>> few months ago to linux-nfs@ and there was push-back.
>>>>>>>>
>>>>>>>
>>>>>>> Could we add a "-F" or similar flag to "exportfs -u" which implements the
>>>>>>> desired semantic?  i.e.  asking nfsd to release all locks and close all
>>>>>>> state on the filesystem.
>>>>>>
>>>>>> That meets my needs, but should be passed by the linux-nfs@ review
>>>>>> committee.
>>>>>>
>>>>>> -F could probably just use the existing "unlock filesystem" API
>>>>>> after it does the unexport.
>>>>>
>>>>> If this option flies, then I guess it is the most sensible variant. If it
>>>>> doesn't work for some reason, then something like ->umount_begin sb
>>>>> callback could be twisted (may possibly need some extension) to provide
>>>>> the needed notification? At least in my naive understanding it was created
>>>>> for usecases like this...
>>>>>
>>>>> 								Honza
>>>>
>>>> umount_begin is a superblock op that only occurs when MNT_FORCE is set.
>>>> In this case though, we really want something that calls back into
>>>> nfsd, rather than to the fs being unmounted.
>>>
>>> I see OK.
>>>
>>>> You could just wire up a bunch of umount_begin() operations but that
>>>> seems rather nasty. Maybe you could add some sort of callback that nfsd
>>>> could register that runs just before umount_begin does?
>>>
>>> Thinking about this more - Chuck was also writing about the problem of
>>> needing to shutdown the state only when this is the last unmount of a
>>> superblock but until we grab namespace_lock(), that's impossible to tell in
>>> a race-free manner? And how about lazy unmounts? There it would seem to be
>>> extra hard to determine when NFS needs to drop it's delegations since you
>>> need to figure out whether all file references are NFS internal only? It
>>> all seems like a notification from VFS isn't the right place to solve this
>>> issue...
>>>
>>
>> The issue is that traditionally, "exportfs -u" is what unexports the
>> filesystem and at that point you can (usually) unmount it. We'd ideally
>> like to have a solution that doesn't create extra steps or change this,
>> since there is already a lot of automation and muscle memory around
>> these commands.
>>
>> This method mostly works with v3, since there is no long term state
>> (technically lockd can hold some, but that's only for file locking).
>> With v4 that changed and nfsd holds files open for much longer.
>>
>> We can't drop all the state when fs is unexported, as it's not uncommon
>> for it to be reexported soon afterward, and we can't force a grace
>> period at that point to allow reclaim.
>>
>> Unmounting seems like the natural place for this. At the point where
>> you're unmounting, there can be no more state and the admin's intent is
>> clear. Tearing down nfsd state at that point seems pretty safe.
>>
>> If we can't add some sort of hook to the umount path, then I'll
>> understand, but it would be a nice to have for this use-case.
> 
> At first glance, umount seems like a natural place for a lot of things.
> 
> The locking and the guarantees that we have traditionally given to
> userspace make it a very convoluted codepath and I'm very hesitant to
> add more complexity in this part of the code.
> 
> Now I suggested the fsnotify mechanism because it's already there and if
> it is _reasonably_ easy to provide the notification that nfs needs to
> clean up whatever it needs to clean up than this is probably fine. What
> I absolutely don't want is to have another custom notification
> mechanism in the VFS layer.
> 
> But if we can solve this in userspace then it is absolutely the
> preferred variant and what we should do.

No problem with that line of reasoning. Right now it looks like we can
do this with changes to exportfs, so I will pursue that.


-- 
Chuck Lever

