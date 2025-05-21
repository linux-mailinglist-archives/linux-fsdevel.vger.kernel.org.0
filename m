Return-Path: <linux-fsdevel+bounces-49568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AC1ABF020
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 11:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999601889498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 09:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C685B248F44;
	Wed, 21 May 2025 09:37:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E323504D;
	Wed, 21 May 2025 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820253; cv=none; b=fC7kobb9WAC4h6aNN7D9MZGmOTMpQ3qwTs9E5OWD4vBPzOGNWKIOYGN1UiBYAjSXpRotGHEq9YDKdW0mKDXihMHAtvCU3ZLZCmlrtS+1L6SR7N05DEbbu0vPkeo7OE0kqWJeqznQx8QpsIEZ2I0Cs69IVjip8u+uLYNH3jwxGP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820253; c=relaxed/simple;
	bh=N8yWSW5tYLd4q2UM0vWpfUGoZ8tTE6cCS0D8RWw2pbY=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JtV2DWMtDwXv9hkUV3QYyiR1uGiYSonxlVZN2dy73J4uE7VBFWeK2SVw4qUQ2rdcikieagZw532jDxfg157Fx5R5w5oRlY0cPq47x7UL7/dXt+nbNHftuTs8RamjPoNZgkKPHGvFwQR9dI9NjlemRfACpLiOIqCHvibYZrsuPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxaeDWni1oNJv0AA--.3899S3;
	Wed, 21 May 2025 17:37:26 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxzxvRni1o0QnlAA--.10296S3;
	Wed, 21 May 2025 17:37:21 +0800 (CST)
Subject: Re: [PATCH] dcache: Define DNAME_INLINE_LEN as a number directly
To: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>
References: <20250520064707.31135-1-yangtiezhu@loongson.cn>
 <20250520082258.GC2023217@ZenIV>
 <CAADnVQJW+qyq9wPD6RdoaZ8nLYX8N2+4Bhxyd19h6pdqNRMc3A@mail.gmail.com>
 <b932c4b8-a45d-4da3-8ef9-f45055830609@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9750057e-2efa-58e1-8739-290f1b2a9104@loongson.cn>
Date: Wed, 21 May 2025 17:37:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b932c4b8-a45d-4da3-8ef9-f45055830609@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxzxvRni1o0QnlAA--.10296S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFy7ZF1xKFWDWw1rXw17XFc_yoW8Zr48pa
	45KanFkr4DKFWrAr9F9wsYvFyftws3tayYgas5Xr10y3s0vF1fGF4Ig3y5uF93Cw48Cw4j
	9w1jqFy3Zr18AagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8q2NtUUUUU==

On 05/21/2025 02:26 AM, Yonghong Song wrote:
>
>
> On 5/20/25 1:04 AM, Alexei Starovoitov wrote:
>> On Tue, May 20, 2025 at 1:23 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>> On Tue, May 20, 2025 at 02:47:07PM +0800, Tiezhu Yang wrote:
>>>> When executing the bcc script, there exists the following error
>>>> on LoongArch and x86_64:
>>> NOTABUG.  You can't require array sizes to contain no arithmetics,
>>> including sizeof().  Well, you can, but don't expect your requests
>>> to be satisfied.
>>>
>>>> How to reproduce:
>>>>
>>>> git clone https://github.com/iovisor/bcc.git
>>>> mkdir bcc/build; cd bcc/build
>>>> cmake ..
>>>> make
>>>> sudo make install
>>>> sudo /usr/share/bcc/tools/filetop
>>> So fix the script.  Or report it to whoever wrote it, if it's
>>> not yours.
>> +1
>>
>>> I'm sorry, but we are NOT going to accomodate random parsers
>>> poking inside the kernel-internal headers and failing to
>>> actually parse the language they are written in.
>>>
>>> If you want to exfiltrate a constant, do what e.g. asm-offsets is
>>> doing.  Take a look at e.g.  arch/loongarch/kernel/asm-offsets.c
>>> and check what ends up in include/generated/asm-offsets.h - the
>>> latter is entirely produced out of the former.
>>>
>>> The trick is to have inline asm that would spew a recognizable
>>> line when compiled into assembler, with the value(s) you want
>>> substituted into it.  See include/linux/kbuild.h for the macros.
>>>
>>> Then you pick these lines out of generated your_file.s - no need
>>> to use python, sed(1) will do just fine.  See filechk_offsets in
>>> scripts/Makefile.lib for that part.
>> None of it is necessary.
>>
>> Tiezhu,
>>
>> bcc's tools/filetop.py is really old and obsolete.
>> It's not worth fixing. I'd delete it.
>> Use bcc's libbpf-tools/filetop instead.
>
> Tiezhu, please check whether libbpf-tools/filetop satisfied your need or
> not. Thanks!

Yes, it works well for me.


