Return-Path: <linux-fsdevel+bounces-74939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEbdEKBncWmaGgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:56:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CD75FB89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C08EE584230
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCDB451073;
	Wed, 21 Jan 2026 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gufY6HtF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696CD43CEC1;
	Wed, 21 Jan 2026 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769039749; cv=none; b=ibHbhxwPCT486tqp8Da11fsezLH1Y1rVlWzxDiFr5zqNbcKa0oDW4/cVgP525suWaNNwmVTTKoPZxdlTpRm3yh+F2h/7d9sSMziaT08Sw7ttqWGUsNDQi1WjSpi7ZXsyRsyiPgNd0lD7mhAT1mZ+YgZuQzBqoNCH3EfCtMJWzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769039749; c=relaxed/simple;
	bh=9P+7IiT55IJ4kxGnFkkCZwaAE/q9zE1ozj+iBBZYou8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dp+ZgiHVdDFi3s9J73qDwmJJu77jgf/7Up3GTN70sScK+G6NHSHEd2x/4eptsxlzPT5eYh/25+5WuaX4FH/3/pN9daOEreYlT/5F5iQIMJxs58u5Lf1+iSH+eowSPHa1zEo8xIwqWEDVjk3/sg0nuuF5meGwRrOvcbwYyiLZbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gufY6HtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B89AC4CEF1;
	Wed, 21 Jan 2026 23:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769039748;
	bh=9P+7IiT55IJ4kxGnFkkCZwaAE/q9zE1ozj+iBBZYou8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gufY6HtFZP66BS3NA348cJtih7J9lNHCkcJn+MRBEhAXTKdNQq2NKuh7HGUcw21ry
	 1+MeWQjPS5AxWHgijLr0cBjxARj/N1Ui0X0vGObCTipLM+tQ1NOeKysrWaeF5Od3bZ
	 z0wI28tCsdkM4NcJZv96b+BJUvglR5IEHFDAzBI3HPQ70Gld1hGGNfF1xn/1JeqJrM
	 pKHc3ZMB+Z0QJ/pl+hwlMnSu3AkjncKtfi1N3ncWkeJaXk/rFmwg9Iu7znZDR/ZbbM
	 NGJ5XfmZi+1dWrC2zl3nossVdkZDvXHqCeOPMJbucqhWHTphW7RcVxI5KZe9nIMykT
	 +b/cVjk6spjqg==
Message-ID: <29aabe1c-3062-4dff-887d-805d7835912e@kernel.org>
Date: Wed, 21 Jan 2026 18:55:45 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
 <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>
 <0D5F8EA8-D77E-4F56-9EA6-8D6FC2F2CD37@hammerspace.com>
 <9c5e9e07-b370-4c71-9dd6-8b6a3efe32c7@kernel.org>
 <5EBC1684-ECA5-497A-8892-9317B44186EC@hammerspace.com>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <5EBC1684-ECA5-497A-8892-9317B44186EC@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-74939-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 30CD75FB89
X-Rspamd-Action: no action

On 1/21/26 5:56 PM, Benjamin Coddington wrote:
> On 21 Jan 2026, at 17:17, Chuck Lever wrote:
> 
>> On 1/21/26 3:54 PM, Benjamin Coddington wrote:
>>> On 21 Jan 2026, at 15:43, Chuck Lever wrote:
>>>
>>>> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
>>>>> A future patch will enable NFSD to sign filehandles by appending a Message
>>>>> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
>>>>> that can persist across reboots.  A persisted key allows the server to
>>>>> accept filehandles after a restart.  Enable NFSD to be configured with this
>>>>> key via both the netlink and nfsd filesystem interfaces.
>>>>>
>>>>> Since key changes will break existing filehandles, the key can only be set
>>>>> once.  After it has been set any attempts to set it will return -EEXIST.
>>>>>
>>>>> Link:
>>>>> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
>>>>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>>>>> ---
>>>>>  Documentation/netlink/specs/nfsd.yaml |  6 ++
>>>>>  fs/nfsd/netlink.c                     |  5 +-
>>>>>  fs/nfsd/netns.h                       |  2 +
>>>>>  fs/nfsd/nfsctl.c                      | 94 +++++++++++++++++++++++++++
>>>>>  fs/nfsd/trace.h                       | 25 +++++++
>>>>>  include/uapi/linux/nfsd_netlink.h     |  1 +
>>>>>  6 files changed, 131 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/netlink/specs/nfsd.yaml
>>>>> b/Documentation/netlink/specs/nfsd.yaml
>>>>> index badb2fe57c98..d348648033d9 100644
>>>>> --- a/Documentation/netlink/specs/nfsd.yaml
>>>>> +++ b/Documentation/netlink/specs/nfsd.yaml
>>>>> @@ -81,6 +81,11 @@ attribute-sets:
>>>>>        -
>>>>>          name: min-threads
>>>>>          type: u32
>>>>> +      -
>>>>> +        name: fh-key
>>>>> +        type: binary
>>>>> +        checks:
>>>>> +            exact-len: 16
>>>>>    -
>>>>>      name: version
>>>>>      attributes:
>>>>> @@ -163,6 +168,7 @@ operations:
>>>>>              - leasetime
>>>>>              - scope
>>>>>              - min-threads
>>>>> +            - fh-key
>>>>>      -
>>>>>        name: threads-get
>>>>>        doc: get the number of running threads
>>>>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>>>>> index 887525964451..81c943345d13 100644
>>>>> --- a/fs/nfsd/netlink.c
>>>>> +++ b/fs/nfsd/netlink.c
>>>>> @@ -24,12 +24,13 @@ const struct nla_policy
>>>>> nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
>>>>>  };
>>>>>
>>>>>  /* NFSD_CMD_THREADS_SET - do */
>>>>> -static const struct nla_policy
>>>>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] = {
>>>>> +static const struct nla_policy
>>>>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] = {
>>>>>  	[NFSD_A_SERVER_THREADS] = { .type = NLA_U32, },
>>>>>  	[NFSD_A_SERVER_GRACETIME] = { .type = NLA_U32, },
>>>>>  	[NFSD_A_SERVER_LEASETIME] = { .type = NLA_U32, },
>>>>>  	[NFSD_A_SERVER_SCOPE] = { .type = NLA_NUL_STRING, },
>>>>>  	[NFSD_A_SERVER_MIN_THREADS] = { .type = NLA_U32, },
>>>>> +	[NFSD_A_SERVER_FH_KEY] = NLA_POLICY_EXACT_LEN(16),
>>>>>  };
>>>>>
>>>>>  /* NFSD_CMD_VERSION_SET - do */
>>>>> @@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
>>>>>  		.cmd		= NFSD_CMD_THREADS_SET,
>>>>>  		.doit		= nfsd_nl_threads_set_doit,
>>>>>  		.policy		= nfsd_threads_set_nl_policy,
>>>>> -		.maxattr	= NFSD_A_SERVER_MIN_THREADS,
>>>>> +		.maxattr	= NFSD_A_SERVER_FH_KEY,
>>>>>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>>>>  	},
>>>>>  	{
>>>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>>>> index 9fa600602658..c8ed733240a0 100644
>>>>> --- a/fs/nfsd/netns.h
>>>>> +++ b/fs/nfsd/netns.h
>>>>> @@ -16,6 +16,7 @@
>>>>>  #include <linux/percpu-refcount.h>
>>>>>  #include <linux/siphash.h>
>>>>>  #include <linux/sunrpc/stats.h>
>>>>> +#include <linux/siphash.h>
>>>>>
>>>>>  /* Hash tables for nfs4_clientid state */
>>>>>  #define CLIENT_HASH_BITS                 4
>>>>> @@ -224,6 +225,7 @@ struct nfsd_net {
>>>>>  	spinlock_t              local_clients_lock;
>>>>>  	struct list_head	local_clients;
>>>>>  #endif
>>>>> +	siphash_key_t		*fh_key;
>>>>>  };
>>>>>
>>>>>  /* Simple check to find out if a given net was properly initialized */
>>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>>> index 30caefb2522f..e59639efcf5c 100644
>>>>> --- a/fs/nfsd/nfsctl.c
>>>>> +++ b/fs/nfsd/nfsctl.c
>>>>> @@ -49,6 +49,7 @@ enum {
>>>>>  	NFSD_Ports,
>>>>>  	NFSD_MaxBlkSize,
>>>>>  	NFSD_MinThreads,
>>>>> +	NFSD_Fh_Key,
>>>>>  	NFSD_Filecache,
>>>>>  	NFSD_Leasetime,
>>>>>  	NFSD_Gracetime,
>>>>> @@ -69,6 +70,7 @@ static ssize_t write_versions(struct file *file, char
>>>>> *buf, size_t size);
>>>>>  static ssize_t write_ports(struct file *file, char *buf, size_t size);
>>>>>  static ssize_t write_maxblksize(struct file *file, char *buf, size_t
>>>>> size);
>>>>>  static ssize_t write_minthreads(struct file *file, char *buf, size_t
>>>>> size);
>>>>> +static ssize_t write_fh_key(struct file *file, char *buf, size_t size);
>>>>>  #ifdef CONFIG_NFSD_V4
>>>>>  static ssize_t write_leasetime(struct file *file, char *buf, size_t
>>>>> size);
>>>>>  static ssize_t write_gracetime(struct file *file, char *buf, size_t
>>>>> size);
>>>>> @@ -88,6 +90,7 @@ static ssize_t (*const write_op[])(struct file *,
>>>>> char *, size_t) = {
>>>>>  	[NFSD_Ports] = write_ports,
>>>>>  	[NFSD_MaxBlkSize] = write_maxblksize,
>>>>>  	[NFSD_MinThreads] = write_minthreads,
>>>>> +	[NFSD_Fh_Key] = write_fh_key,
>>>>>  #ifdef CONFIG_NFSD_V4
>>>>>  	[NFSD_Leasetime] = write_leasetime,
>>>>>  	[NFSD_Gracetime] = write_gracetime,
>>>>> @@ -950,6 +953,60 @@ static ssize_t write_minthreads(struct file *file,
>>>>> char *buf, size_t size)
>>>>>  	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);
>>>>>  }
>>>>>
>>>>> +/*
>>>>> + * write_fh_key - Set or report the current NFS filehandle key, the key
>>>>> + * 		can only be set once, else -EEXIST because changing the key
>>>>> + * 		will break existing filehandles.
>>>>
>>>> Do you really need both a /proc/fs/nfsd API and a netlink API? I
>>>> think one or the other would be sufficient, unless you have
>>>> something else in mind (in which case, please elaborate in the
>>>> patch description).
>>>
>>> Yes, some distros use one or the other.  Some try to use both!  Until you
>>> guys deprecate one of the interfaces I think we're stuck expanding them
>>> both.
>>
>> Neil has said he wants to keep /proc/fs/nfsd rather indefinitely, and
>> we have publicly stated we will add only to netlink unless it's
>> unavoidable. I prefer not growing the legacy API.
> 
> Having both is more complete, and doesn't introduce any conflicts or
> problems.

That doesn't tell me why you need it. It just says you want things to
be "tidy".


>> We generally don't backport new features like this one to stable
>> kernels, so IMO tucking this into only netlink is defensible.
> 
> Why only netlink for this one besides your preference?

You might be channeling one of your kids there.

As I stated before: we have said we don't want to continue adding
new APIs to procfs. It's not just NFSD that prefers this, it's a long
term project across the kernel. If you have a clear technical reason
that a new procfs API is needed, let's hear it.


> There's a very good reason for both interfaces - there's been no work to
> deprecate the old interface or co-ordination with distros to ensure they
> have fully adopted the netlink interface.  Up until now new features have
> been added to both interfaces.

I'm not seeing how this is a strong and specific argument for including
a procfs version of this specific interface. It's still saying "tidy" to
me and not explaining why we must have the extra clutter.

An example of a strong technical reason would be "We have legacy user
space applications that expect to find this API in procfs."


>> The procfs API has the ordering requirement that Jeff pointed out. I
>> don't think it's a safe API to allow the server to start up without
>> setting the key first. The netlink API provides a better guarantee
>> there.
> 
> It is harmless to allow the server to start up without setting the
> key first.  The server will refuse to give out filehandles for "sign_fh"
> exports and emit a warning in the log, so "safety" is the wrong word.

Sounds like it will cause spurious stale file handles, which will kill
applications on NFS mounts.


>>>> Also "set once" seems to be ambiguous. Is it "set once" per NFSD
>>>> module load, one per system boot epoch, or set once, _ever_ ?
>>>
>>> Once per nfsd module load - I can clarify next time.
>>>
>>>> While it's good UX safety to prevent reseting the key, there are
>>>> going to be cases where it is both needed and safe to replace the
>>>> FH signing key. Have you considered providing a key rotation
>>>> mechanism or a recipe to do so?
>>>
>>> I've considered it, but we do not need it at this point.
>>
>> I disagree: Admins will need to know how to replace an FH key that was
>> compromised. At the very least your docs should explain how to do that
>> safely.
> 
> Ok, I can add documentation for how to replace the key.
> 
>>> The key can
>>> be replaced today by restarting the server, and you really need to know what
>>> you're doing if you want to replace it.  Writing extra code to help someone
>>> that knows isn't really going to help them.  If a need appears for this, the
>>> work can get done.
>>
>> I cleverly said "a key rotation mechanism _or_ a recipe" so if it's
>> something you prefer only to document, let's take that route.
>>
>> Ensuring all clients have unmounted and then unloading nfsd.ko before
>> setting a fresh key is a lot of juggling. That should be enough to
>> prevent an FH key change by accident.
> 
> Adding instructions to unload the nfsd module would be full of footguns,
> depend on other features/modules and config options, and guaranteed to
> quickly be out of date.  It might be enough to say the system should be
> restarted.  The only reason for replacing the key is (as you've said) that
> it was compromised.  That should be rare and serious enough to justify
> restarting the server.

Again, I disagree. There can be other long-running services on the same
system as an NFS server. A system reboot might be fine for simple cases,
but not for all cases. We get "do I really have to reboot?" questions
all of the frickin time.

It isn't necessary to explain how every distribution handles "unload
nfsd.ko". "Shut down the NFS server using the administrative mechanisms
preferred by your distribution. Ensure that nfsd.ko has been unloaded
using 'lsmod'".

Type something up. We'll help you polish it.


-- 
Chuck Lever

