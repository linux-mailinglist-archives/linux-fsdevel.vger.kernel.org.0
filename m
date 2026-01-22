Return-Path: <linux-fsdevel+bounces-75055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AzvDMs8cmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:05:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D59368567
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69A9F7ACCAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15468355048;
	Thu, 22 Jan 2026 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUguQ99j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72905352947;
	Thu, 22 Jan 2026 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093417; cv=none; b=nVx2KHNAaLmdPBivVy8Fj7rL0KkOLv7UOW20H4r/KJ9o/CGPuifisnMN35NRby0fUzwOCZRKGfKU9iv9oqCiEIOwVP67CSAp9SlZUe/zk1ms2GLrb4BUKv7hkqag7NqEo1p3hRfCX2dYU1gC+nwiS8n0tQLyVrMSbd1t8AJbOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093417; c=relaxed/simple;
	bh=ZT42RIX1B+CQYsgkMuQ+fTvfPdPrToYET9KTLXqi7Ug=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XtwuBHvpHk+XqgIeLriyF8pFaviNqDhoPIaflB1cd1l6xfNnxfsPA+yID1lRJ+ZesLUcp9arTBQpr2yJuD77jPuQvqO0Gk6m9k0tXjwMGp44huGg+OtvaGf+hLMpZm468j/IymlBzTSp+xVvzBh3qZK+dMqTYo/ydJQcej1m7SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUguQ99j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D46C116D0;
	Thu, 22 Jan 2026 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769093417;
	bh=ZT42RIX1B+CQYsgkMuQ+fTvfPdPrToYET9KTLXqi7Ug=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VUguQ99jGsFd0NguIMbqmd5zouwvzuuQM3seFIDdYugZ1ME4T3R4OlInoF2/8hdq1
	 jKTO2WksEXiTeS6jvXni4bCY1Qym4KPc0u2wHiN5aovK6SWGrmVPkHGQFHzh8zCunV
	 3MIevQNP7WWh6CCOTn/t7pIsR11lHiAsmY5oZHSeJuz+9+02rOjknxG9S4XrWNKuyQ
	 cDaQPkt11l9XtAUgSNKGFdwFrGuThv/8yYwcr+X7bH627/vyHAZlw8JGJwn+XCosd3
	 f1FywIf1H3/4435i4uYhrDG7xKPQ4z7FjiWB+DS1oZcXtPfoaRZhajxCHRQt3cFuyI
	 XvYxdOJpdfPnA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7ADFEF4006A;
	Thu, 22 Jan 2026 09:50:15 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 22 Jan 2026 09:50:15 -0500
X-ME-Sender: <xms:Jzlyab93qVvSKtrmL2e_GJZv2_iz_sdgMF9LroPb3dj1c5Yjdzv5qQ>
    <xme:JzlyaShqYCp1wb6C4ttO1-qAABBFaYmb0I1ikR3ZDY9mTE6eBt-Dy2LfYgqh9GzV0
    AWFxxwSDrH8eyYBVNjnTOz2TVbQerZ3cXghoDdMxn6E91GMHADbNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejvefhudehleetvdejhfejvefghfelgeejvedvgfduuefffeegtdejuefhiedukeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrd
    hnrghmvgdprhgtphhtthhopehrihgtkhdrmhgrtghklhgvmhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomhdprhgtph
    htthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuh
    igqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JzlyaUEQRvMWU8NA06ijiQo5FE6WOGis-yNsvuocBbW6RePClfhhLw>
    <xmx:JzlyaZK8jJ5LfaeceOYAjOsK-pVBPqoxtJ_ZaVO4G0YfPLC_2qndDw>
    <xmx:JzlyaZivQC4syENGMVAyb2xJursekD_4YGgl_YKbzaabCg2Bmpl6uw>
    <xmx:JzlyafmQG7KU0NAMVsrqfEYTi-Rccr6Rkp9ctbzEkNBz6LpJw0-_-g>
    <xmx:JzlyaYUGE3T3Qb3QUzl_ExiiG5QcxorQCPqVPEjxE6tYVbCAEFz9tmY5>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 54D48780070; Thu, 22 Jan 2026 09:50:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1vGOqVGteog
Date: Thu, 22 Jan 2026 09:49:33 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Message-Id: <3080c6d6-4734-41e9-81a6-8ad9fc8a1061@app.fastmail.com>
In-Reply-To: <DC80A9CE-C98B-4D03-889F-90F477065FB1@hammerspace.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
 <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>
 <0D5F8EA8-D77E-4F56-9EA6-8D6FC2F2CD37@hammerspace.com>
 <9c5e9e07-b370-4c71-9dd6-8b6a3efe32c7@kernel.org>
 <5EBC1684-ECA5-497A-8892-9317B44186EC@hammerspace.com>
 <29aabe1c-3062-4dff-887d-805d7835912e@kernel.org>
 <DC80A9CE-C98B-4D03-889F-90F477065FB1@hammerspace.com>
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.45 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75055-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,app.fastmail.com:mid,hammerspace.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9D59368567
X-Rspamd-Action: no action



On Wed, Jan 21, 2026, at 8:22 PM, Benjamin Coddington wrote:
> On 21 Jan 2026, at 18:55, Chuck Lever wrote:
>
>> On 1/21/26 5:56 PM, Benjamin Coddington wrote:
>>> On 21 Jan 2026, at 17:17, Chuck Lever wrote:
>>>
>>>> On 1/21/26 3:54 PM, Benjamin Coddington wrote:
>>>>> On 21 Jan 2026, at 15:43, Chuck Lever wrote:
>>>>>
>>>>>> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
>>>>>>> A future patch will enable NFSD to sign filehandles by appending a Message
>>>>>>> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
>>>>>>> that can persist across reboots.  A persisted key allows the server to
>>>>>>> accept filehandles after a restart.  Enable NFSD to be configured with this
>>>>>>> key via both the netlink and nfsd filesystem interfaces.
>>>>>>>
>>>>>>> Since key changes will break existing filehandles, the key can only be set
>>>>>>> once.  After it has been set any attempts to set it will return -EEXIST.
>>>>>>>
>>>>>>> Link:
>>>>>>> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
>>>>>>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>>>>>>> ---
>>>>>>>  Documentation/netlink/specs/nfsd.yaml |  6 ++
>>>>>>>  fs/nfsd/netlink.c                     |  5 +-
>>>>>>>  fs/nfsd/netns.h                       |  2 +
>>>>>>>  fs/nfsd/nfsctl.c                      | 94 +++++++++++++++++++++++++++
>>>>>>>  fs/nfsd/trace.h                       | 25 +++++++
>>>>>>>  include/uapi/linux/nfsd_netlink.h     |  1 +
>>>>>>>  6 files changed, 131 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/netlink/specs/nfsd.yaml
>>>>>>> b/Documentation/netlink/specs/nfsd.yaml
>>>>>>> index badb2fe57c98..d348648033d9 100644
>>>>>>> --- a/Documentation/netlink/specs/nfsd.yaml
>>>>>>> +++ b/Documentation/netlink/specs/nfsd.yaml
>>>>>>> @@ -81,6 +81,11 @@ attribute-sets:
>>>>>>>        -
>>>>>>>          name: min-threads
>>>>>>>          type: u32
>>>>>>> +      -
>>>>>>> +        name: fh-key
>>>>>>> +        type: binary
>>>>>>> +        checks:
>>>>>>> +            exact-len: 16
>>>>>>>    -
>>>>>>>      name: version
>>>>>>>      attributes:
>>>>>>> @@ -163,6 +168,7 @@ operations:
>>>>>>>              - leasetime
>>>>>>>              - scope
>>>>>>>              - min-threads
>>>>>>> +            - fh-key
>>>>>>>      -
>>>>>>>        name: threads-get
>>>>>>>        doc: get the number of running threads
>>>>>>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>>>>>>> index 887525964451..81c943345d13 100644
>>>>>>> --- a/fs/nfsd/netlink.c
>>>>>>> +++ b/fs/nfsd/netlink.c
>>>>>>> @@ -24,12 +24,13 @@ const struct nla_policy
>>>>>>> nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
>>>>>>>  };
>>>>>>>
>>>>>>>  /* NFSD_CMD_THREADS_SET - do */
>>>>>>> -static const struct nla_policy
>>>>>>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] = {
>>>>>>> +static const struct nla_policy
>>>>>>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] = {
>>>>>>>  	[NFSD_A_SERVER_THREADS] = { .type = NLA_U32, },
>>>>>>>  	[NFSD_A_SERVER_GRACETIME] = { .type = NLA_U32, },
>>>>>>>  	[NFSD_A_SERVER_LEASETIME] = { .type = NLA_U32, },
>>>>>>>  	[NFSD_A_SERVER_SCOPE] = { .type = NLA_NUL_STRING, },
>>>>>>>  	[NFSD_A_SERVER_MIN_THREADS] = { .type = NLA_U32, },
>>>>>>> +	[NFSD_A_SERVER_FH_KEY] = NLA_POLICY_EXACT_LEN(16),
>>>>>>>  };
>>>>>>>
>>>>>>>  /* NFSD_CMD_VERSION_SET - do */
>>>>>>> @@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
>>>>>>>  		.cmd		= NFSD_CMD_THREADS_SET,
>>>>>>>  		.doit		= nfsd_nl_threads_set_doit,
>>>>>>>  		.policy		= nfsd_threads_set_nl_policy,
>>>>>>> -		.maxattr	= NFSD_A_SERVER_MIN_THREADS,
>>>>>>> +		.maxattr	= NFSD_A_SERVER_FH_KEY,
>>>>>>>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>>>>>>  	},
>>>>>>>  	{
>>>>>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>>>>>> index 9fa600602658..c8ed733240a0 100644
>>>>>>> --- a/fs/nfsd/netns.h
>>>>>>> +++ b/fs/nfsd/netns.h
>>>>>>> @@ -16,6 +16,7 @@
>>>>>>>  #include <linux/percpu-refcount.h>
>>>>>>>  #include <linux/siphash.h>
>>>>>>>  #include <linux/sunrpc/stats.h>
>>>>>>> +#include <linux/siphash.h>
>>>>>>>
>>>>>>>  /* Hash tables for nfs4_clientid state */
>>>>>>>  #define CLIENT_HASH_BITS                 4
>>>>>>> @@ -224,6 +225,7 @@ struct nfsd_net {
>>>>>>>  	spinlock_t              local_clients_lock;
>>>>>>>  	struct list_head	local_clients;
>>>>>>>  #endif
>>>>>>> +	siphash_key_t		*fh_key;
>>>>>>>  };
>>>>>>>
>>>>>>>  /* Simple check to find out if a given net was properly initialized */
>>>>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>>>>> index 30caefb2522f..e59639efcf5c 100644
>>>>>>> --- a/fs/nfsd/nfsctl.c
>>>>>>> +++ b/fs/nfsd/nfsctl.c
>>>>>>> @@ -49,6 +49,7 @@ enum {
>>>>>>>  	NFSD_Ports,
>>>>>>>  	NFSD_MaxBlkSize,
>>>>>>>  	NFSD_MinThreads,
>>>>>>> +	NFSD_Fh_Key,
>>>>>>>  	NFSD_Filecache,
>>>>>>>  	NFSD_Leasetime,
>>>>>>>  	NFSD_Gracetime,
>>>>>>> @@ -69,6 +70,7 @@ static ssize_t write_versions(struct file *file, char
>>>>>>> *buf, size_t size);
>>>>>>>  static ssize_t write_ports(struct file *file, char *buf, size_t size);
>>>>>>>  static ssize_t write_maxblksize(struct file *file, char *buf, size_t
>>>>>>> size);
>>>>>>>  static ssize_t write_minthreads(struct file *file, char *buf, size_t
>>>>>>> size);
>>>>>>> +static ssize_t write_fh_key(struct file *file, char *buf, size_t size);
>>>>>>>  #ifdef CONFIG_NFSD_V4
>>>>>>>  static ssize_t write_leasetime(struct file *file, char *buf, size_t
>>>>>>> size);
>>>>>>>  static ssize_t write_gracetime(struct file *file, char *buf, size_t
>>>>>>> size);
>>>>>>> @@ -88,6 +90,7 @@ static ssize_t (*const write_op[])(struct file *,
>>>>>>> char *, size_t) = {
>>>>>>>  	[NFSD_Ports] = write_ports,
>>>>>>>  	[NFSD_MaxBlkSize] = write_maxblksize,
>>>>>>>  	[NFSD_MinThreads] = write_minthreads,
>>>>>>> +	[NFSD_Fh_Key] = write_fh_key,
>>>>>>>  #ifdef CONFIG_NFSD_V4
>>>>>>>  	[NFSD_Leasetime] = write_leasetime,
>>>>>>>  	[NFSD_Gracetime] = write_gracetime,
>>>>>>> @@ -950,6 +953,60 @@ static ssize_t write_minthreads(struct file *file,
>>>>>>> char *buf, size_t size)
>>>>>>>  	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);
>>>>>>>  }
>>>>>>>
>>>>>>> +/*
>>>>>>> + * write_fh_key - Set or report the current NFS filehandle key, the key
>>>>>>> + * 		can only be set once, else -EEXIST because changing the key
>>>>>>> + * 		will break existing filehandles.
>>>>>>
>>>>>> Do you really need both a /proc/fs/nfsd API and a netlink API? I
>>>>>> think one or the other would be sufficient, unless you have
>>>>>> something else in mind (in which case, please elaborate in the
>>>>>> patch description).
>>>>>
>>>>> Yes, some distros use one or the other.  Some try to use both!  Until you
>>>>> guys deprecate one of the interfaces I think we're stuck expanding them
>>>>> both.
>>>>
>>>> Neil has said he wants to keep /proc/fs/nfsd rather indefinitely, and
>>>> we have publicly stated we will add only to netlink unless it's
>>>> unavoidable. I prefer not growing the legacy API.
>>>
>>> Having both is more complete, and doesn't introduce any conflicts or
>>> problems.
>>
>> That doesn't tell me why you need it. It just says you want things to
>> be "tidy".
>>
>>
>>>> We generally don't backport new features like this one to stable
>>>> kernels, so IMO tucking this into only netlink is defensible.
>>>
>>> Why only netlink for this one besides your preference?
>>
>> You might be channeling one of your kids there.
>
> That's unnecessary.

Is it? There's no point in asking that question other than as the
kind of jab a kid makes when trying to catch a parent in a
contradiction (which is exactly what you continue with below).

It doesn't make a difference whether it's my preference or not, and
frankly, as a contributor, it's not your role to decide whether an
interface goes in procfs or not. Don't argue with me. Just answer
my questions. All I'm asking here is why are you adding it.


>> As I stated before: we have said we don't want to continue adding
>> new APIs to procfs. It's not just NFSD that prefers this, it's a long
>> term project across the kernel. If you have a clear technical reason
>> that a new procfs API is needed, let's hear it.
>
> You've just added one to your nfsd-testing branch two weeks ago that you
> asked me to rebase onto.

Sorry for being human. Sometimes I don't notice things. That one doesn't
belong there either. But each one of these is decided on a case-by-case
basis. It's not appropriate for you to compare your procfs addition to
any other as a basis for "permission to add the API".

Again, this is argumentative, not constructive. You're not answering
a direct question from a reviewer/maintainer. What is the reason you
need this API?


>>> There's a very good reason for both interfaces - there's been no work to
>>> deprecate the old interface or co-ordination with distros to ensure they
>>> have fully adopted the netlink interface.  Up until now new features have
>>> been added to both interfaces.
>>
>> I'm not seeing how this is a strong and specific argument for including
>> a procfs version of this specific interface. It's still saying "tidy" to
>> me and not explaining why we must have the extra clutter.
>>
>> An example of a strong technical reason would be "We have legacy user
>> space applications that expect to find this API in procfs."
>
> The systemd startup for the nfs-server in RHEL falls back to rpc.nfsd on
> nfsdctl failure.  Without the additional interface you can have systems that
> start the nfs-server via rpc.nfsd without setting the key - exactly the
> situation you're so adamant should never happen in your below argument..

If your intention is to get distributions to backport signed FHs
to kernels that do not have the NFSD netlink interface, you need
to have stated that up front. That is the rationale I'm looking
for here, and I really should not have to work this hard getting
that answer from you.

I might have deleted this while editing my reply yesterday, but
as a policy, LTS kernels do not get new features like this. So
it was never my intention to plan to target upstream backports
for this feature.

If this is part of your vision for this feature, you will need
to make a similar case to the stable@ folks.


-- 
Chuck Lever

