Return-Path: <linux-fsdevel+bounces-22770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6AD91BFE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 15:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4FA1C21505
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 13:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D751991DF;
	Fri, 28 Jun 2024 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="oqFrqm1u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CF9155CAE
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582477; cv=none; b=oo/wICR5mM0jWr0dZVGgiCNYokdPM/AkQrZQM4cCT8O04O0zair4mq9uyt1zCCyrBUlO+DxqVytifrOnQrtloCCUcoQPMmQVXhNprYh0/PZvuisJCZ0BOpl6PUS0SHCLr9kHSrZ7l39+77VHhcPUPPFAKftAsfRTub82HtRZs4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582477; c=relaxed/simple;
	bh=mXZozb5UVuMc1pGGAvpXYhjSbN3nNqKHh/Bw4deQbYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQG/h0DqFrW5FlFOa5+xBpvZAaiZHcrBZEUK8Vb6bgMNTewjjO6COnNNlEVrJTYoPeMkOQfUPWS9GmiL81QTXntzR78V7QoV8Syz4XI2VGcA1wooS0DUEAB+lGiSuNgKz2pJp//nxoR9gCrT+5o7X6AE1tTKK2Nt5Sjxoh2tk0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=oqFrqm1u; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id CDAE07888;
	Fri, 28 Jun 2024 08:41:25 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net CDAE07888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1719582085;
	bh=FOfCB41VfBiylSyY2RVS+3McNWpuiX70HVSwPiDukmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oqFrqm1uDn7rwJVJVXlKoADNg0pZwlCrARdfkrvlfhntHeu53Fhn8jLkUXS4knMch
	 kda3xP0/AAP7l75D/dtP1ovXTkhm/7RuwxPj2KpyjTfHBFaMMQMpMkkpo6LcrBXSs9
	 SpjaXIeabrSMHDkQgiCZm8IjCxezCWvayboKI84tOR0dlripc/RH99u5DP6za6jPcS
	 ykiUAAFgY8SUS54+y6G+16HWcnL8XZtxEytcGfzdnOXFwqjL18bdPKsgt0wPOXlh9H
	 k2vAncv1gW0+TeTBUqIf4BJWgCC+kkjuZtJiWgJsPaohmGhvRPehnqfRvRwdO9O22x
	 x1a725zKSghJw==
Message-ID: <e85866ed-2a70-41ec-9845-9bf01380bbcb@sandeen.net>
Date: Fri, 28 Jun 2024 08:41:24 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] fuse: Convert to new uid/gid option parsing helpers
To: Christian Brauner <brauner@kernel.org>, Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Bernd Schubert <bschubert@ddn.com>, Amir Goldstein <amir73il@gmail.com>,
 Seth Forshee <sforshee@kernel.org>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
 <02670c04-2449-443f-bf44-68c927685a1c@redhat.com>
 <20240628-anbrechen-warnschilder-c8607ec1c881@brauner>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240628-anbrechen-warnschilder-c8607ec1c881@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/24 7:07 AM, Christian Brauner wrote:
> I think you accidently Cced the wrong Miklos. :)
> 
> On Thu, Jun 27, 2024 at 07:33:43PM GMT, Eric Sandeen wrote:
>> Convert to new uid/gid option parsing helpers
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>  fs/fuse/inode.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 99e44ea7d875..1ac528bcdb3c 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -740,8 +740,8 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
>>  	fsparam_string	("source",		OPT_SOURCE),
>>  	fsparam_u32	("fd",			OPT_FD),
>>  	fsparam_u32oct	("rootmode",		OPT_ROOTMODE),
>> -	fsparam_u32	("user_id",		OPT_USER_ID),
>> -	fsparam_u32	("group_id",		OPT_GROUP_ID),
>> +	fsparam_uid	("user_id",		OPT_USER_ID),
>> +	fsparam_gid	("group_id",		OPT_GROUP_ID),
>>  	fsparam_flag	("default_permissions",	OPT_DEFAULT_PERMISSIONS),
>>  	fsparam_flag	("allow_other",		OPT_ALLOW_OTHER),
>>  	fsparam_u32	("max_read",		OPT_MAX_READ),
>> @@ -799,16 +799,12 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
>>  		break;
>>  
>>  	case OPT_USER_ID:
>> -		ctx->user_id = make_kuid(fsc->user_ns, result.uint_32);
>> -		if (!uid_valid(ctx->user_id))
>> -			return invalfc(fsc, "Invalid user_id");
>> +		ctx->user_id = result.uid;
> 
> So fsc->user_ns will record the namespaces at fsopen() time which can be
> different from the namespace used at fsconfig() time. This was done when
> fuse was ported to the new mount api.
> 
> It has the same potential issues that Seth pointed out so I think your
> patch is correct. But I also think we might need the same verification
> that tmpfs is doing to verify that the uid/gid we're using can actually
> be represented in the fsc->user_ns.

Hm yeah, so that's a current bug in fuse, right? (it /would/ be really
nice to be able to spot FS_USERNS_MOUNT in the helper, and do the right
thing in all cases) 

> So maybe there should be a separate patch that converts fuse to rely on
> make_k*id(current_user_ns()) + k*id_has_mapping() and then these patches
> on top?

Ok, I guess the idea is that that patch could land more quickly than this
treewide-ish change (and would be cherry-pickable -stable material), to fix
the bug, and then make this change later. Seems fair.

Thanks,
-Eric


