Return-Path: <linux-fsdevel+bounces-22769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC08591BFDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 15:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C271F23863
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99E41BF304;
	Fri, 28 Jun 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="qrx9Vpyh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB66E1E889;
	Fri, 28 Jun 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582301; cv=none; b=Y4bJR6vNqlfeOzTQOBAGNuj8vlE4p8+9FkbFCfYcTQcJqyn581E487DdQmHrqUCgAFvrOTFuZaYD1jmZHdVXXtv6yyosNL4Rzbu/zAyJFUoKgxTn+ZkzhUF7tJBJq/jvXLooeXrsF6J71RCOHxyb2vkgFk+0WcJ4SbmVPasSTdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582301; c=relaxed/simple;
	bh=77BI7tguWHgEq99xWrc6gnoboZnF1lacf05CuU7G42c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ragWPTPd+fUr5/cI87r0NX7dtEcNcvqO7C1+FmwJyTDXnULo7vSWLyTCIHleKOBWpDjLKq7k413Tw5FVBV9LujgBE2Tfs9Ut1BBqKhMT0s8N9Ep7JgGIsmBmPYY4a7rVPDr2LoygrnQtarbhv8qBooxQPfALsR4kM8Y5DF5mfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=qrx9Vpyh; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id B8504479AE7;
	Fri, 28 Jun 2024 08:44:57 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net B8504479AE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1719582297;
	bh=Wm0ob2liKwaqVbn00ikDKfK69kD3HD4g+HnBrpsBtW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qrx9Vpyhxcf6Ccxu1nuAmtF93uW/ueFYWzOccKUh54TalNBQ4t63BP5oUyWlboQhC
	 WX+PUV2Brzf30rbzUiP594AXcjW3QoOLhz3z+XQQQWuRssk79igSO2coEA6/JvL6bf
	 BTNwcp6VJJqsWJEZ3EbAWEh/xCJlB7Lf/ONSJtCBE97BxFAWjQA9bdLHG1KDnltvdT
	 0+RFws1BZFMMBR0ickPmjzBuqw4WAT0BG53yvl+IW8OXJCu7NGrVSBWc8pGmx+Y18r
	 24NKBfo0ZsCxWTtD9jxdMbrx9h+VqakxBVi/gbrwKM/r6xSc6gKvi9JHqtHgszm9vJ
	 DhHGFwa2Bx1/Q==
Message-ID: <7c90924d-b023-4fa7-801d-ea0a53a5e5ed@sandeen.net>
Date: Fri, 28 Jun 2024 08:44:57 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] fs_parse: add uid & gid option option parsing
 helpers
To: Jan Kara <jack@suse.cz>, Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 autofs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-efi@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-ext4@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 linux-mm@kvack.org, ntfs3@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Hans Caniullan <hcaniull@redhat.com>,
 Alexander Viro <aviro@redhat.com>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
 <de859d0a-feb9-473d-a5e2-c195a3d47abb@redhat.com>
 <20240628094517.ifs4bp73nlggsnxz@quack3>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240628094517.ifs4bp73nlggsnxz@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/24 4:45 AM, Jan Kara wrote:
> On Thu 27-06-24 19:26:24, Eric Sandeen wrote:
>> Multiple filesystems take uid and gid as options, and the code to
>> create the ID from an integer and validate it is standard boilerplate
>> that can be moved into common helper functions, so do that for
>> consistency and less cut&paste.
>>
>> This also helps avoid the buggy pattern noted by Seth Jenkins at
>> https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com/
>> because uid/gid parsing will fail before any assignment in most
>> filesystems.
>>
>> Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
> 
> I like the idea since this seems like a nobrainer but is actually
> surprisingly subtle...
> 
>> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
>> index a4d6ca0b8971..24727ec34e5a 100644
>> --- a/fs/fs_parser.c
>> +++ b/fs/fs_parser.c
>> @@ -308,6 +308,40 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
>>  }
>>  EXPORT_SYMBOL(fs_param_is_fd);
>>  
>> +int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p,
>> +		    struct fs_parameter *param, struct fs_parse_result *result)
>> +{
>> +	kuid_t uid;
>> +
>> +	if (fs_param_is_u32(log, p, param, result) != 0)
>> +		return fs_param_bad_value(log, param);
>> +
>> +	uid = make_kuid(current_user_ns(), result->uint_32);
> 
> But here is the problem: Filesystems mountable in user namespaces need to use
> fc->user_ns for resolving uids / gids (e.g. like fuse_parse_param()).
> Having helpers that work for some filesystems and are subtly broken for
> others is worse than no helpers... Or am I missing something?

Yeah, I should have pointed that out. tmpfs still does that check after the
initial trivial parsing after this change to use the basic helper:

        case Opt_uid:
                kuid = result.uid;
        
                /*
                 * The requested uid must be representable in the
                 * filesystem's idmapping.
                 */
                if (!kuid_has_mapping(fc->user_ns, kuid))
                        goto bad_value;
        
                ctx->uid = kuid;
                break;

I can see your point about risks of a helper that doesn't cover all cases
though.
 
> And the problem with fc->user_ns is that currently __fs_parse() does not
> get fs_context as an argument... So that will need some larger work.

Yup, this was discussed a little when I sent this idea as an RFC, and the
(brief/small) consensus was that it was worth going this far for now.

Getting fc back into __fs_parse looks rather tricky and Al was not keen
on the idea, for some reason.

Thanks,
-Eric
> 								Honza


