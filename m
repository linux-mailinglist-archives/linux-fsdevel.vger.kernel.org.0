Return-Path: <linux-fsdevel+bounces-21594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988089062E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 05:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9FA7B227C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 03:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D35132123;
	Thu, 13 Jun 2024 03:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="An6aC73w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3F130ACF;
	Thu, 13 Jun 2024 03:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718250892; cv=none; b=OX7nPdXEVOf8cetP099JitcjBA0m9uHOzXjQYG1hQB06D8N4tXj+kJwb4woWC+Ck5uTwnNhCx2YEoSci9K8KXtcUPfwz/yjvhV8J3ZngjvUC0HvAf9P99ABdRIju0xg+V6a1LFHPYdCx0yNBk/+HhxbE1lsSLEFnk7wnSf98qPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718250892; c=relaxed/simple;
	bh=4IRlCB/4nUSbZwsJUsWYdboTwZ+C4w4yUEx925ojR84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHuCGAHKnmZvQ+1iH1Rq70d4vnhArf9XB0M8t/TfbDMMNrd6nuy+mjHRq45y62hdkq5u2+O79LdgRiAZLqJjHe+Bc4XYuL1ZTrsE41/1jv0AaaQVSwd+miGYidCFPCS6FBg9WSPkqgGIclbTod7GUX6d3b4ELBMYlohC2cFTI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=An6aC73w; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.83] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CF5353F2CF;
	Thu, 13 Jun 2024 03:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718250879;
	bh=xYQFrwIswvtW1GDA70qHgG50RX/kaBNY/JfSUQQLhR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=An6aC73w/ZU7OmxOvSuz+41Bk29n1RzGYRS+uRav0+cXNZDYiw0ei2+4KT0DLIQmR
	 9MPSEbJLAQuXnRU2l1p5K7g/ngtisXCiqJY7+DpIcX5gf4NxXTNZ2gQBcyTwkHaWl2
	 an0g3lTyh8FUBr/bb/bwBKK+Xtp76qqkp6BMD6e2lqrSMqPfvZYNBGaxIdZEzNL8GV
	 tBGXvU3Wtn4rdYuAH+yDwsroZEcMpfJlu5/xnvb9ExOtXOW8NG1DzWyKKjscsSy82e
	 fJk1rQRpk9QlhZcG88cuwit7OGlxxr/aGxauV5NxUS3y54lAajmfI41kRTr0kmKwzQ
	 Vl+U1To6ETOYA==
Message-ID: <ba8d88c8-a251-4c1f-8653-1082b0a101dd@canonical.com>
Date: Wed, 12 Jun 2024 20:54:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] bpf,lsm: Allow editing capabilities in BPF-LSM
 hooks
To: Paul Moore <paul@paul-moore.com>, Jonathan Calmels <jcalmels@3xx0.net>
Cc: brauner@kernel.org, ebiederm@xmission.com,
 Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, KP Singh <kpsingh@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, containers@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, apparmor@lists.ubuntu.com, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240609104355.442002-5-jcalmels@3xx0.net>
 <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com>
 <z2bgjrzeq7crqx24chdbxnaanuhczbjnq6da3xw6al6omjj5xz@mqbzzzfva5sw>
 <887a3658-2d8d-4f9e-98f2-27124bb6f8e6@canonical.com>
 <CAHC9VhQFNPJTOct5rUv3HT6Z2S20mYdW75seiG8no5=fZd7JjA@mail.gmail.com>
 <uuvwcdsy7o4ulmrdzwffr6uywfacmlkjrontmjdj44luantpok@dtatxaa6tzyv>
 <CAHC9VhRnthf8+KgfuzFHXWEAc9RShDO0G_g0kc1OJ-UTih1ywg@mail.gmail.com>
 <rgzhcsblub7wedm734n56cw2qf6czjb4jgck6l5miur6odhovo@n5tgrco74zce>
 <CAHC9VhRGJTND25MFk4gR-FGxoLhMmgUrMpz_YoMFOwL6kr28zQ@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAHC9VhRGJTND25MFk4gR-FGxoLhMmgUrMpz_YoMFOwL6kr28zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/12/24 10:29, Paul Moore wrote:
> On Wed, Jun 12, 2024 at 4:15 AM Jonathan Calmels <jcalmels@3xx0.net> wrote:
>> On Tue, Jun 11, 2024 at 06:38:31PM GMT, Paul Moore wrote:
>>> On Tue, Jun 11, 2024 at 6:15 PM Jonathan Calmels <jcalmels@3xx0.net> wrote:
> 
> ...
> 
>>>> Arguably, if we do want fine-grained userns policies, we need LSMs to
>>>> influence the userns capset at some point.
>>>
>>> One could always use, or develop, a LSM that offers additional
>>> controls around exercising capabilities.  There are currently four
>>> in-tree LSMs, including the capabilities LSM, which supply a
>>> security_capable() hook that is used by the capability-based access
>>> controls in the kernel; all of these hook implementations work
>>> together within the LSM framework and provide an additional level of
>>> control/granularity beyond the existing capabilities.
>>
>> Right, but the idea was to have a simple and easy way to reuse/trigger
>> as much of the commoncap one as possible from BPF. If we're saying we
>> need to reimplement and/or use a whole new framework, then there is
>> little value.
> 
> I can appreciate how allowing direct manipulation of capability bits
> from a BPF LSM looks attractive, but my hope is that our discussion
> here revealed that as you look deeper into making it work there are a
> number of pitfalls which prevent this from being a safe option for
> generalized systems.
> 
>> TBH, I don't feel strongly about this, which is why it is absent from
>> v1. However, as John pointed out, we should at least be able to modify
>> the blob if we want flexible userns caps policies down the road.
> 
> As discussed in this thread, there are existing ways to provide fine
> grained control over exercising capabilities that can be safely used
> within the LSM framework.  I don't want to speak to what John is
> envisioning, but he should be aware of these mechanisms, and if I
> recall he did voice a level of concern about the same worries I
> mentioned.
> 

sorry, I should have been more clear. I envision LSMs being able to
update their own state in the userns hook.

Basically the portion of the patch that removes const from the
userns hook.

An LSM updating the capset is worrysome for all the reasons you
pointed out, and I think a few more. I haven't had a chance to really
look at v2 yet, so I didn't want to speak directly on the bpf part of
the patch without first giving a good once over.

> I'm happy to discuss ways in which we can adjust the LSM hooks/layer
> to support different approaches to capability controls, but one LSM
> directly manipulating the state of another is going to be a no vote
> from me.
> 
I might not be as hard no as Paul here, I am always willing to listen
to arguments, but it would have to be a really good argument to
modify the capset, when there are multiple LSMs in play on a system.



