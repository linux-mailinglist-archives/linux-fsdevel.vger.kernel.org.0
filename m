Return-Path: <linux-fsdevel+bounces-76541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIOcJAGHhWmdDAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:15:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BFBFA962
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD1E1301494F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 06:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE5A239E9B;
	Fri,  6 Feb 2026 06:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ggSTK8Fn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C6149659
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770358524; cv=none; b=a8KkeY9yNGIYDDuew97ubLRk6RVght1Pd0UqrYs9raim+pYHeGw3nY/YCOOgowYO1b+4E9oQ85q1rRzwVWklf0e51Nr5tGQPFkGsuNn7MrYOXYu7h5GjgKf5OW04z7GUVwa23OxuPht/e0S4xOd6hHZLe4iXMG+yXYyckqOe/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770358524; c=relaxed/simple;
	bh=TIP1bLBQX9ZwVHDNjylzW4sMPtHQ0GtVkKCNhk+cBwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YF8oJ3Rtiw8x5PNAC1qhwUDVqtVKBi0loANYiTKKU6DKP61Fzc64daFBoei0XBxLGCMRheNeOStYZcyyk+a4lQqyo7VaTlETS2RRXQ/17OufQQTS+A+xxDelKQr1SqJ5k3CMfoq5JJ9iwvG5JH25rafGpKGZUuow1TSJRVVHlfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ggSTK8Fn; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770358514; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=W4mA2MhljhymmE2StcbGoCwt+KMil20c4g79EI47TOE=;
	b=ggSTK8FniIXgsAGds8Gi3HCtjl9Z6Nyjn9ra1qdXdkvuKMTpjCORw8DLcjRLV6J2s44Pb2Grq7X1XQ3ihK8zB3CzG8Qphz7DMr1qsS7T4CrENv1naUrVCc1Mri/LKAEM0cjBdvW8/ChCJQrmHa/VA49CqKGolPBA+JVjut+2hf8=
Received: from 30.221.130.105(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WydaJhn_1770358513 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Feb 2026 14:15:14 +0800
Message-ID: <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
Date: Fri, 6 Feb 2026 14:15:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, f-pc@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
 Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>,
 Horst Birthelmer <horst@birthelmer.de>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
 <20260206053835.GD7693@frogsfrogsfrogs>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260206053835.GD7693@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[szeredi.hu,lists.linux-foundation.org,vger.kernel.org,gmail.com,groves.net,bsbernd.com,igalia.com,birthelmer.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76541-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: E7BFBFA962
X-Rspamd-Action: no action

Hi Darrick,

On 2026/2/6 13:38, Darrick J. Wong wrote:
> On Thu, Feb 05, 2026 at 06:50:28AM +0800, Gao Xiang wrote:
>>
>>
>> On 2026/2/5 03:06, Darrick J. Wong wrote:
>>> On Mon, Feb 02, 2026 at 02:51:04PM +0100, Miklos Szeredi wrote:
>>
>> ...
>>
>>>
>>>    4 For defaults situations, where do we make policy about when to use
>>>      f-s-c and when do we allow use of the kernel driver?  I would guess
>>>      that anything in /etc/fstab could use the kernel driver, and
>>>      everything else should use a fuse container if possible.  For
>>>      unprivileged non-root-ns mounts I think we'd only allow the
>>>      container?
>>
>> Just a side note: As a filesystem for containers, I have to say here
>> again one of the goal of EROFS is to allow unprivileged non-root-ns
>> mounts for container users because again I've seen no on-disk layout
>> security risk especially for the uncompressed layout format and
>> container users have already request this, but as Christoph said,
>> I will finish security model first before I post some code for pure
>> untrusted images.  But first allow dm-verity/fs-verity signed images
>> as the first step.
> 
> <nod> I haven't forgotten.  For readonly root fses erofs is probably the
> best we're going to get, and it's less clunky than fuse.  There's less
> of a firewall due to !microkernel but I'd wager that most immutable
> distros will find erofs a good enough balance between performance and
> isolation.

Thanks, but I can't make decisions for every individual end user.
However, in my view, this approach is valuable for all container
users if they don't mind to try this approach (I'm building this
capabilities with several communities and people): they can achieve
nearly native performance on read-write workloads with a trusted
fs as well as the remote data source is completely isolated using
an immutable secure filesystem.

I will make signed images work first, but as the next step, I'll
definitely work on defining a clear on-disk boundary (very
likely excluding per-inode compression layouts in the beginning)
to enable most users to leverage untrusted data directly in
a totally isolated user/mount namespace.

> 
> Fuse, otoh, is for all the other weird users -- you found an old
> cupboard full of wide scsi disks; or management decided that letting
> container customers bring their own prepopulated data partitions(!) is a
> good idea; or the default when someone plugs in a device that the system
> knows nothing about.

Honestly, I've checked what Ted, Dave, and you said previously.
For generic COW filesystems, it's surely hard to guarantee
filesystem consistency at all times, mainly because of those
on-disk formats by design (lots of duplicated metadata for
different purposes, which can cause extra inconsistency compared
to archive fses.) Of course, it's not entirely impossible, but
as Ted pointed out, it becomes a matter of

1) human resources;
2) enforcing such strict consistency checks harms performance
    in general use cases which just use trusted filesystem /
    media directly like databases.

I'm not against FUSE further improvements because they are seperated
stories, I do think those items are useful for new Linux innovation,
but as for the topic of allowing "root" in non-root-user-ns to mount,
I still insist that it should be a per-filesystem policy, because
filesystems are designed for different targeted use cases:

  - either you face and address the issue (by design or by
    enginneering), or
  - find another alternative way to serve users.

But I do hope we shouldn't force some arbitary policy without any
technical reason, the feature is indeed useful for container users.

> 
>> On the other side, my objective thought of that is FUSE is becoming
>> complex either from its protocol and implementations (even from the
> 
> It already is.
> 
>> TODO lists here) and leak of security design too, it's hard to say
>> from the attack surface which is better and Linux kernel is never
>> regarded as a microkernel model. In order to phase out "legacy and
>> problematic flags", FUSE have to wait until all current users don't
>> use them anymore.
>>
>> I really think it should be a per-filesystem policy rather than the
>> current arbitary policy just out of fragment words, but I will
>> prepare more materials and bring this for more formal discussion
>> until the whole goal is finished.
> 
> Well yes, the transition from kernel to kernel-or-fuse would be
> decided on a per-filesystem basis.  When the fuse driver reaches par
> with the kernel driver on functionality and stability then it becomes a
> candidate for secure container usage.  Not before.

I respect this path, but just from my own perspective, userspace
malicious problems are usually much harder to defence since the
trusted boundary is weaker, in order to allow unpriviledged
daemons, you have to monitor if page cache or any metadata cache
or any potential/undiscovered deadlock vectors can be abused
by those malicious daemons, so that you have to find more harden
ways to limit such abused usage naturally since you never trust
those unpriviledged daemons (which is arbitary executable code
rather than a binary source) instead, which is opposed to
performance cases in principle without detailed analysis.

Just my two cents.

Thanks,
Gao Xiang

> 
> --D
> 
>> Thanks,
>> Gao Xiang
>>
>>


