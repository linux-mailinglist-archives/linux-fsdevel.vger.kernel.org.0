Return-Path: <linux-fsdevel+bounces-6505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F82818C64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 17:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5168828700D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 16:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14DB20308;
	Tue, 19 Dec 2023 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LF3T0ljI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF4820B0E;
	Tue, 19 Dec 2023 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=LPla4BPCxFuMZp7s1ug6GdCl5VcC7lT2V96cyQeZGsE=; b=LF3T0ljI6xKgd1+CdbT3Z0Oz89
	GhRtrtYsWw6W7ArHJCApfzpMhnyIKFHjyjc1eNChPSTePLUBFdjnnLoSv4QVb44u4S/TegPyJE4Vz
	tkHUkAWE58vvCaXAR1PKXNvZJIpFGfKL7uh4lfhLH4oEUtn+BL/RplI39O8aEeJDsAnns37z3MPzX
	kkgJjCWZAqFFjnmofAwlyJAxgXTYIXt/59U/evzbKVBfq2jKXs++l/pzdFjorpGekDmxS7wJZERrH
	epNwNiblQ34e6QX/pK8xafgtPoYtUzIZRzkVcPSC2YF/C47VvHU5yUl4/u9Tz8+CPkda0XmmVyRYo
	ozeCuj4A==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFd5E-0008Lv-6e; Tue, 19 Dec 2023 17:36:40 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFd5D-000QmO-GN; Tue, 19 Dec 2023 17:36:39 +0100
Subject: Re: pull-request: bpf-next 2023-12-18
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, andrii@kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, peterz@infradead.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@fb.com, linux-fsdevel@vger.kernel.org
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
 <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
 <20231219-kinofilm-legen-305bd52c15db@brauner>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8533dc25-1cfe-bc0c-98e2-3db1b1c5c72d@iogearbox.net>
Date: Tue, 19 Dec 2023 17:36:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231219-kinofilm-legen-305bd52c15db@brauner>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27128/Tue Dec 19 10:36:48 2023)

On 12/19/23 11:23 AM, Christian Brauner wrote:
> On Mon, Dec 18, 2023 at 05:11:23PM -0800, Linus Torvalds wrote:
>> On Mon, 18 Dec 2023 at 16:05, Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> 2) Introduce BPF token object, from Andrii Nakryiko.
>>
>> I assume this is why I and some other unusual recipients are cc'd,
>> because the networking people feel like they can't judge this and
>> shouldn't merge non-networking code like this.
>>
>> Honestly, I was told - and expected - that this part would come in a
>> branch of its own, so that it would be sanely reviewable.
>>
>> Now it's mixed in with everything else.
>>
>> This is *literally* why we have branches in git, so that people can
>> make more independent changes and judgements, and so that we don't
>> have to be in a situation where "look, here's ten different things,
>> pull it all or nothing".
>>
>> Many of the changes *look* like they are in branches, but they've been
>> the "fake branches" that are just done as "patch series in a branch,
>> with the cover letter as the merge message".
>>
>> Which is great for maintaining that cover letter information and a
>> certain amount of historical clarity, but not helpful AT ALL for the
>> "independent changes" thing when it is all mixed up in history, where
>> independent things are mostly serialized and not actually independent
>> in history at all.
>>
>> So now it appears to be one big mess, and exactly that "all or
>> nothing" thing that isn't great, since the whole point was that the
>> networking people weren't comfortable with the reviewing filesystem
>> side.
>>
>> And honestly, the bpf side *still* seems to be absolutely conbfused
>> and complkete crap when it comes to file descriptors.
>>
>> I took a quick look, and I *still* see new code being introduced there
>> that thinks that file descriptor zero is special, and we tols you a
>> *year* ago that that wasn't true, and that you need to fix this.
>>
>> I literally see complete garbage like tghis:
>>
>>          ..
>>          __u32 btf_token_fd;
>>          ...
>>          if (attr->btf_token_fd) {
>>                  token = bpf_token_get_from_fd(attr->btf_token_fd);
>>
>> and this is all *new* code that makes that same bogus sh*t-for-brains
>> mistake that was wrong the first time.
>>
>> So now I'm saying NAK. Enough is enough.  No more of this crazy "I
>> don't understand even the _basics_ of file descriptors, and yet I'm
>> introducing new random interfaces".
>>
>> I know you thought fd zero was something invalid. You were told
>> otherwise. Apparently you just ignored being wrong, and have decided
>> to double down on being wrong.
>>
>> We don't take this kind of flat-Earther crap.
>>
>> File descriptors don't start at 1. Deal with reality. Stop making the
>> same mistake over and over. If you ant to have a "no file descriptor"
>> flag, you use a signed type, and a signed value for that, because file
>> descriptor zero is perfectly valid, and I don't want to hear any more
>> uninformed denialism.
>>
>> Stop polluting the kernel with incorrect assumptions.
>>
>> So yes, I will keep NAK'ing this until this kind of fundamental
>> mistake is fixed. This is not rocket science, and this is not
>> something that wasn't discussed before. Your ignorance has now turned
>> from "I didn't know" to "I didn 't care", and at that point I really
>> don't want to see new code any more.
> 
> Alexei, Andrii, this is a massive breach of trust and flatout
> disrespectful. I barely reword mails and believe me I've reworded this
> mail many times. I'm furious.
> 
> Over the last couple of months since LSFMM in May 2023 until almost last
> week I've given you extensive design and review for this whole approach
> to get this into even remotely sane shape from a VFS perspective.
> 
> The VFS maintainers including Linus have explicitly NAKed this "zero is
> not a valid fd nonsense" and told you to stop doing that. We told you
> that such fundamental VFS semantics are not yours to decide.
> 
> And yet you put a patch into a series that did exactly that and then had
> the unbelievable audacity to repeatedly ask me to put my ACK under this
> - both in person and on list.
> 
> I'm glad I only gave my ACK to the two patches that I extensivly
> reviewed and never to the whole series.

Sincere apologies for this whole mess. All token series related patches
have been reverted in bpf-next now, and I'm prepping a PR for net-next
so that this is also fully removed from there.

Thanks,
Daniel

