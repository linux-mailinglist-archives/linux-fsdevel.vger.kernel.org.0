Return-Path: <linux-fsdevel+bounces-70992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06743CAE7E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 01:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0CE83068D77
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 00:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FEB2FFDE2;
	Tue,  9 Dec 2025 00:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CBQGyH+4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7930225788;
	Tue,  9 Dec 2025 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239880; cv=none; b=h/ZAR9oT3DJbPNXM+zKSZcP0ZTeKc0xR7uWM/PGf4Vwgzrfq1OBTiq9iltsJmn1r5DjH8LlxX/NraRpDh6nbS9oNgeVaWbuCOPMvQogWHf+ey8MZvrYBNAiZETWzllIBdOdUkn0JzE20wV9KuSxJjE2ZZ+ZWPUzkVk6+DCdpVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239880; c=relaxed/simple;
	bh=6EAoFCaLiAZ23lU8uKbWD5l6AUc+q8XEx2gdqRVxjyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebFro7I/8nKWad5dO5nd806N+dOX9F0r6BJx7rmni7JC91/GGs86Xen/OuotQBfgJAn1NdjefMWkFWpJfzKw71g4bAvKxGDSlxzlflX3DlLuokJCqVm0/vm5Du5lf/eu82uIRhLiS2UOEIo4P243UZ/6DqhiYbXIAdbGKqdKFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CBQGyH+4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9483:a28:93fb:4548:76d8] ([IPv6:2601:646:8081:9483:a28:93fb:4548:76d8])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5B90LkqE2671385
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 8 Dec 2025 16:21:50 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5B90LkqE2671385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025112201; t=1765239716;
	bh=/PN2q3gAcxqsjSCT1U+SiAYHPRh75N5ahP7Iqy6qq4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CBQGyH+4TJ+S9e7CsuCUT+2b3Gb07quVI5rQ/L42lI5BQzdH73zeJ6NdB0wB3qoKX
	 xLHQHctsuxlAyiKFZZXisIbuxY0gbl7jroEICspisq3d+PL3IWkVMVXUCpyqoSKbGB
	 hhOCEOWZ0VSixAJpCwaFX99ak7qcKQzIcdYK+ijHeC+OoLRLN/3oQhp7BwQzA1kNxY
	 Wrjtzm47jdJ3T3i6Fk8LMwExatbMCePyBrlKUjSJUTEMBp9crJ1K4KGoWMrDPWdr+i
	 vJhlhJ2FnOlALZbTqdau6FTtpRnu22IQrmhw1FNGBnaf5n24+uvw2z4RB8uKR4uhbF
	 /ZiC6wqAMXUYw==
Message-ID: <ee693efe-5b7b-4d38-a12c-3cea6681f610@zytor.com>
Date: Mon, 8 Dec 2025 16:21:40 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, pr-tracker-bot@kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
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
        Jir i Olsa <jolsa@kernel.org>,
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
        Yu feng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org,
        virtualization@lists.linux.dev, x86@kernel.org
References: <20251208235528.3670800-1-hpa@zytor.com>
 <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
 <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-12-08 16:20, Linus Torvalds wrote:
> Hmm. I think pr-tracker-bot is being confused. This one just came in,
> and hasn't been merged yet.
> 
> That merge commit link is for the hwmon pull.
> 
>                  Linus

Yeah, it commented on the master branch, which is of course ... yours.

	-hpa


