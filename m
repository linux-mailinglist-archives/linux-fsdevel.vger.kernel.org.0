Return-Path: <linux-fsdevel+bounces-55488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF84FB0AC06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 00:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837CC4E7712
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 22:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422D2221FC4;
	Fri, 18 Jul 2025 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="khFAFbSc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478812206B1;
	Fri, 18 Jul 2025 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752876772; cv=none; b=Tbld2BJWvzSK6D0ek37b6bpZJ+X28feJTR7OgTPqeR1eH/opUpcmLxCnr27q0kD40COGBJz4VgM9W5x6Pe68AxQD3r40sePzvxbHOmpjzJ0XRF3tiE2+3Io77vZMqogpz+5wKT2FwdKNu2gpe3xQzkxkgvj6dq+mRS8q1WbZmAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752876772; c=relaxed/simple;
	bh=qzVuvkfAQQqtpak8j7vWQvsEeX5h7ioyRGvKq72N9U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDEqNRpvPFgm5DaENNnzVTvwt5InJi29awIJ2NQp0XZTLpgMvhlhCWe1fYg2yM729nUG/F6Z1svOz6wLRcjiv/5NbCNyYgQXYGRKRpVQBufIy4MaWlXkxlD8l4mTeXiSOAUJjCEysYwzK7sGYhL1gpNoDBfov8cAy4JEQeIx3tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=khFAFbSc; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9482:197f:c1e5:8ae9:2d06] ([IPv6:2601:646:8081:9482:197f:c1e5:8ae9:2d06])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56IMBIs32809490
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 18 Jul 2025 15:11:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56IMBIs32809490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752876686;
	bh=u3adsmw2raiz193Cp3Ip0T4zuSrb0ygShqiBU7iriLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=khFAFbScCZJHVCx2iCaQ/z1I13MQx2fEe4vN7kjiySbR87BC1QYYKAH6Qo4dLOvND
	 wYzZxTi6mA/p9YGAoW38GfQDMozSOsYTA+GA6AHvqyFcYXssYSZ+QYA39g893LN561
	 8k3fvC8WujrEKRGYTw2jXgpP0Pi0kILbZW2Na1NqIQJkJ+qoL3kv9meHntuuMbdQnm
	 xqsCV9hLQMO9Lg8+QwGCz54/nLsjuhkoMrUAnjuoKrd9iBo7s8MG+3a1ylVItbx8ws
	 zRINg5Jiq27watVpljC8QAWIg4HXrCFpM2WpV1nPngLS4rVIgYPTxgZQQgnyGzZYZv
	 jeIi6qwmD5kRw==
Message-ID: <62cfe957-56bb-43de-91d9-9f64d8100a62@zytor.com>
Date: Fri, 18 Jul 2025 15:11:13 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
        David Lechner
 <dlechner@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Gatlin Newhouse <gatlin.newhouse@gmail.com>,
        Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Kees Cook <kees@kernel.org>,
        Luc Van Oostenryck
 <luc.vanoostenryck@gmail.com>,
        Marc Herbert <Marc.Herbert@linux.intel.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>,
        Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        NeilBrown <neil@brown.name>, Peter Zijlstra <peterz@infradead.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Blum
 <thorsten.blum@linux.dev>,
        Uros Bizjak <ubizjak@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org,
        virtualization@lists.linux.dev, x86@kernel.org
References: <20250718213252.2384177-1-hpa@zytor.com>
 <20250718213252.2384177-5-hpa@zytor.com>
 <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-07-18 14:49, Linus Torvalds wrote:
> 
> Side note: I think some coccinelle (or sed) script that replaces that
> older form of
> 
>        typeof(x) Y = (typeof(x))(Z);
> 
> or
> 
>         typeof(Z) Y = Z;
> 
> 
> with just
> 
>         auto Y = Z;
> 
> is also worthwhile at some point.
> 
> We have more of those, because that's the really traditional gcc way
> to do things that predates __auto_type.
> 

Agreed.  And I think that this, indeed is a job more for Coccinelle than
for sed, because the patterns can be rather complex and we don't want
false positives.

	-hpa


