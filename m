Return-Path: <linux-fsdevel+bounces-43678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0ABA5B4AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 01:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8FF1886C7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 00:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BE813C3C2;
	Tue, 11 Mar 2025 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="ifuybngy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tZLRUwIf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9138FE555;
	Tue, 11 Mar 2025 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653734; cv=none; b=RegI3I3Y3lX49mRr3KD5Is5QzAPiBDHcM5+chaPPK2cdUctmLaZGQ0Txsn/WccnWa+3fYqBl06EgJx7FSy/rsqB7wNQxK9N2o1aS9QzghThkYBV4gDDoBA4o97mShhcDij7l/itoXOZmplH0J3LFj5dQMY+SkQUT5MuYH6wkNw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653734; c=relaxed/simple;
	bh=s1i2hKvrD0j1r2rdqJhP5eswl/jqUD+b89d/0kkSXFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izfMwVSI/jVMM+sUIJTdrIxyRMAfEiUCQHF6YJyTFCHXca0/Bfv7oNlj/CJ++tgLuT1m+aio7g77Ami2q498/WNVlH1Dg1xouSwyJx1yMndU9yKyOC5JZoTcz5J3P0/vCHbEcUdPjW0IDiqEw8yW5obzKdCBnMMmkk1EVGvrFAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=ifuybngy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tZLRUwIf; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 269411D415E4;
	Mon, 10 Mar 2025 20:42:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 10 Mar 2025 20:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741653729;
	 x=1741657329; bh=zRohkIyG3dIAXTYHpjsA/KHKrEGWpeY8QeaZ3mXfp0c=; b=
	ifuybngyhKbooPQ5dJwwkN4QlZqGyKGtdEcmWVA5uRwiFpH6r3czNSdz+fFhAw/T
	EdcF6tl5h78p3aBHin9fO4xIDH5mjE41Hqp+8EaPRvTgoHGR0oZZx8QEHg6Igozk
	F2ixUlDi2arMDu3K0KvsT3PyrhX4Z+3Z24F+LG1Efu2s6xE1E4skah0mFht8hL/T
	vzoamTqhZacKeEAmUndkRmQYxvTzZR8Rt2eNnya9vWru4F+dFGvX2Uscq7I148TF
	6TeIqBm8JPNMImOjsjJ6rMVhMjFr3zTzhzyZvvntOV7szwXFuWSs97encvl4n/B0
	DW7QiAjteMQIAYfurDnjSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741653729; x=
	1741657329; bh=zRohkIyG3dIAXTYHpjsA/KHKrEGWpeY8QeaZ3mXfp0c=; b=t
	ZLRUwIfgCnbYHD3qhHwp00toLnDtVDnboGL5A6u1uBOkLoOw5Vp3Hgykbk+RPee+
	WhmFC19wg4r2CugbDar09AG/AwuOtAllL91D8UYGZ9iPV13Fnf9x5Zg2FIK7N7Lc
	CXUpDGDVkkTzediXbIvhgaUpm2EmynMkJxwdg33lfGDeO907VfoC+z1DVG++wBJE
	EGVzXKBpGv+LzSpGv+u8yKcp+1vMXEWF/thcKxPW/pkAhBcvBmI8X54N8Ue84ymc
	OrMY/j6v1rK8+T3p2NciDKx4Dbn28uIuIpqtAz4CaYz8LKUNYPG2/rxR5cCpVIaO
	T1lESJsoi2RlHVvLcDVWA==
X-ME-Sender: <xms:4IbPZzM8SFygnqFwOtJ9JPYBnRNGnKeHBIdhQ29EL3Kprfjb4QhzYg>
    <xme:4IbPZ9-P0TEl8GHKNbekhy7LiOZV_g8JQIHaYOE0Myf34B_SZyrWwwobcILi3Bp_G
    YlcpKl_GG6BXa9mIbk>
X-ME-Received: <xmr:4IbPZyT0cHiqaJmZMqT5I60GR5Sg43E0G4q8RZHDKrq3lTuEGqO3PWvkgz2NPHzytaVI-G322mnnOkOT7OJvCf-2n7icTF9KCMeWUkPRnyH-gF_h3WIhJ1en>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepleefvdfgudetleegleevtedtffeuvdejvdeiudelheet
    keffteeugfevfeeuheefnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthht
    oheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehrvghpnhhophesghhoohhglhgvrdgtohhmpdhrtghpthht
    oheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehthigthhhosehthigthhhordhpihiiiigrpdhrtghpthhtohepsghrrghunhgv
    rheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4IbPZ3u3g1GwervDb25Tz7ihv9PSolyrFAsSwGZTZo9RAkIEWxJrtQ>
    <xmx:4IbPZ7dllRdHXzB82LgxlMS6QVDYxSZ4IcvlYbrQzJjccrFWM5MMWw>
    <xmx:4IbPZz1VmTsWq-vL4ljFHac8L15ZbzSs9Y8-p-Wg51-Rnap2k7LAnw>
    <xmx:4IbPZ3-qtw9A7QN2J5U0Lxrmisj1cw5KoENXXcuWGcSk6KokzvPoCg>
    <xmx:4YbPZ51IL_Wi3lm6NNbN8kuwYRolvqztVxs-iGrs3kZ4gpPywJ5gfiRx>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 20:42:06 -0400 (EDT)
Message-ID: <1e009b28-1e6b-4b8c-9934-b768cde63c2b@maowtm.org>
Date: Tue, 11 Mar 2025 00:42:05 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
To: Amir Goldstein <amir73il@gmail.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org,
 Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org,
 Tycho Andersen <tycho@tycho.pizza>, Christian Brauner <brauner@kernel.org>,
 Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@google.com>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Francis Laniel <flaniel@linux.microsoft.com>,
 Matthieu Buffet <matthieu@buffet.re>, Song Liu <song@kernel.org>
References: <cover.1741047969.git.m@maowtm.org>
 <20250304.Choo7foe2eoj@digikod.net>
 <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org>
 <CAOQ4uxjz4tGmW3DH3ecBvXEnacQexgM86giXKqoHFGzwzT33bA@mail.gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <CAOQ4uxjz4tGmW3DH3ecBvXEnacQexgM86giXKqoHFGzwzT33bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/6/25 17:07, Amir Goldstein wrote:
[...]
> 
> w.r.t sharing infrastructure with fanotify, I only looked briefly at
> your patches
> and I have only a vague familiarity with landlock, so I cannot yet form an
> opinion whether this is a good idea, but I wanted to give you a few more
> data points about fanotify that seem relevant.
> 
> 1. There is already some intersection of fanotify and audit lsm via the
> fanotify_response_info_audit_rule extension for permission
> events, so it's kind of a precedent of using fanotify to aid an lsm
> 
> 2. See this fan_pre_modify-wip branch [1] and specifically commit
>    "fanotify: introduce directory entry pre-modify permission events"
> I do have an intention to add create/delete/rename permission events.
> Note that the new fsnotify hooks are added in to do_ vfs helpers, not very
> far from the security_path_ lsm hooks, but not exactly in the same place
> because we want to fsnotify hooks to be before taking vfs locks, to allow
> listener to write to filesystem from event context.
> There are different semantics than just ALLOW/DENY that you need,
> therefore, only if we move the security_path_ hooks outside the
> vfs locks, our use cases could use the same hooks

Hi Amir,

(this is a slightly long message - feel free to respond at your 
convenience, thank you in advance!)

Thanks a lot for mentioning this branch, and for the explanation! I've 
had a look and realized that the changes you have there will be very 
useful for this patch, and in fact, I've already tried a worse attempt 
of this (not included in this patch series yet) to create some 
security_pathname_ hooks that takes the parent struct path + last name 
as char*, that will be called before locking the parent.  (We can't have 
an unprivileged supervisor cause a directory to be locked indefinitely, 
which will also block users outside of the landlock domain)

I'm not sure if we can move security_path tho, because it takes the 
dentry of the child as an argument, and (I think at least for create / 
mknod / link) that dentry is only created after locking.  Hence the 
proposal for separate security_pathname_ hooks.  A search shows that 
currently AppArmor and TOMOYO (plus Landlock) uses the security_path_ 
hooks that would need changing, if we move it (and we will have to 
understand if the move is ok to do for the other two LSMs...)

However, I think it would still make a lot of sense to align with 
fsnotify here, as you have already made the changes that I would need to 
do anyway should I implement the proposed new hooks.  I think a sensible 
thing might be to have the extra LSM hooks be called alongside 
fsnotify_(re)name_perm - following the pattern of what currently happens 
with fsnotify_open_perm (i.e. security_file_open called first, then 
fsnotify_open_perm right after).

What's your thought on this? Do you think it would be a good idea to 
have LSM hook equivalents of the fsnotify (re)name perm hooks / fanotify 
pre-modify events?

Also, do you have a rough estimate of when you would upstream the 
fa/fsnotify changes? (asking just to get an idea of things, not trying 
to rush or anything :) I suspect this supervise patch would take a while 
anyway)

If you think the general idea is right, here are some further questions 
I have:

I think going by this approach any error return from 
security_pathname_mknod (or in fact, fsnotify_name_perm) when called in 
the open O_CREAT code path would end up becoming a -EROFS.  Can we turn 
the bool got_write in open_last_lookups into an int to store any error 
from mnt_want_write_parent, and return it if lookup_open returns -EROFS? 
  This is so that the user space still gets an -EACCESS on create 
denials by landlock (and in fact, if fanotify denies a create maybe we 
want it to return the correct errno also?). Maybe there is a better way, 
this is just my first though...

I also noticed that you don't currently have fsnotify hook calls for 
link (although it does end up invoking the name_perm hook on the dest 
with MAY_CREATE).  I want to propose also changing do_linkat to (pass 
the right flags to filename_create_srcu -> mnt_want_write_parent to) 
call the security_pathname_link hook (instead of the LSM hook it would 
normally call for a creation event in this proposal) that is basically 
like security_path_link, except passing the destination as a dir/name 
pair, and without holding vfs lock (still passing in the dentry of the 
source itself), to enable landlock to handle link requests separately. 
Do you think this is alright?  (Maybe the code would be a bit convoluted 
if written verbatim from this logic, maybe there is a better way, but 
the general idea is hopefully right)

btw, side question, I see that you added srcu read sections around the 
events - I'm not familiar with rcu/locking usage in vfs but is this for 
preventing e.g. changing the mount in some way (but still allowing 
access / changes to the directory)?

I realize I'm asking you a lot of things - big thanks in advance!  (also 
let me know if I should be pulling in other VFS maintainers)

--

For Mickaël,

Would you be on board with changing Landlock to use the new hooks as 
mentioned above?  My thinking is that it shouldn't make any difference 
in terms of security - Landlock permissions for e.g. creating/deleting 
files are based on the parent, and in fact except for link and rename, 
the hook_path_ functions in Landlock don't even use the dentry argument. 
  If you're happy with the general direction of this, I can investigate 
further and test it out etc.  This change might also reduce the impact 
of Landlock on non-landlocked processes, if we avoid holding exclusive 
inode lock while evaluating rules / traversing paths...? (Just a 
thought, not measured)

In terms of other aspects, ignoring supervisors for now, moving to these 
hooks:

- Should make no difference in the "happy" (access allowed) case

- Only when an access is disallowed, in order to know what error to
   return, we can check (within Landlock hook handler) if the target
   already exists - if yes, return -EEXIST, otherwise -EACCESS

If this is too large of a change at this point and you see / would 
prefer another way we can progress this series (at least the initial 
version), let me know.

Kind regards,
Tingmao

> 
> 3. There is a recent attempt to add BPF filter to fanotify [2]
> which is driven among other things from the long standing requirement
> to add subtree filtering to fanotify watches.
> The challenge with all the attempt to implement a subtree filter so far,
> is that adding vfs performance overhead for all the users in the system
> is unacceptable.
> 
> IIUC, landlock rule set can already express a subtree filter (?),
> so it is intriguing to know if there is room for some integration on this
> aspect, but my guess is that landlock mostly uses subtree filter
> after filtering by specific pids (?), so it can avoid the performance
> overhead of a subtree filter on most of the users in the system.
> 
> Hope this information is useful.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/linux/commits/fan_pre_modify-wip/
> [2] https://lore.kernel.org/linux-fsdevel/20241122225958.1775625-1-song@kernel.org/


