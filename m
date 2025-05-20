Return-Path: <linux-fsdevel+bounces-49540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D71DABE29C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 20:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B001F4C2871
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EA227E1AB;
	Tue, 20 May 2025 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qFA8lg0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF3A262D29
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765590; cv=none; b=M655CudKOvdXSGpAtRHQlvPUEb8WSHbF+DphBapRLv/aba+uDDGJKye08a/77ii+dTUvJB21EEWU8Mn0q5Fk+c32APkGqClA8/FL3PsThzRe5QSa8An3+jTwvOM9+xBtbjDxuE4Tvi70nmkf8sdk3eGvcCZZjFVGgGEP2AIwymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765590; c=relaxed/simple;
	bh=bXCaQrTI2i+zn9W34y3m9O2P4sfdV4wreHAf43KPX7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHAD3Dmutbap7UdLdeSIP6+XhL25g44Grkb0GTcRzOuXI8OXIMTC1KUgcATF6ZjibuWIJvC0kYQKzUsc5p+m2mOehDHiMtelHphuudc/jygAuF/8SjTyGNnol+UkJ2bacTWizWzrWhx3EnydrWwruZdDlU8M+GQpFXU880epWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qFA8lg0I; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b932c4b8-a45d-4da3-8ef9-f45055830609@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747765577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSGVVvj/o1r+R0aA03QBvXfE7OdysBvf0GHLfuZbsiY=;
	b=qFA8lg0Is+yWtccFjqKbLszDszKgr/oTFUFbImylAMRe3MzsB8Z5i+3c3xpAKQ9uVU+rMk
	Y8jfhVnqm0l87zJGVccerDPG8R0rY0CsVjJFZWtDUZA0O3sWLTDzfcg4A82hiMms4kcwdZ
	1zllIkgzmz/36zOlPYu2KSJUmdAzEDU=
Date: Tue, 20 May 2025 11:26:08 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] dcache: Define DNAME_INLINE_LEN as a number directly
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <20250520064707.31135-1-yangtiezhu@loongson.cn>
 <20250520082258.GC2023217@ZenIV>
 <CAADnVQJW+qyq9wPD6RdoaZ8nLYX8N2+4Bhxyd19h6pdqNRMc3A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJW+qyq9wPD6RdoaZ8nLYX8N2+4Bhxyd19h6pdqNRMc3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/20/25 1:04 AM, Alexei Starovoitov wrote:
> On Tue, May 20, 2025 at 1:23 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>> On Tue, May 20, 2025 at 02:47:07PM +0800, Tiezhu Yang wrote:
>>> When executing the bcc script, there exists the following error
>>> on LoongArch and x86_64:
>> NOTABUG.  You can't require array sizes to contain no arithmetics,
>> including sizeof().  Well, you can, but don't expect your requests
>> to be satisfied.
>>
>>> How to reproduce:
>>>
>>> git clone https://github.com/iovisor/bcc.git
>>> mkdir bcc/build; cd bcc/build
>>> cmake ..
>>> make
>>> sudo make install
>>> sudo /usr/share/bcc/tools/filetop
>> So fix the script.  Or report it to whoever wrote it, if it's
>> not yours.
> +1
>
>> I'm sorry, but we are NOT going to accomodate random parsers
>> poking inside the kernel-internal headers and failing to
>> actually parse the language they are written in.
>>
>> If you want to exfiltrate a constant, do what e.g. asm-offsets is
>> doing.  Take a look at e.g.  arch/loongarch/kernel/asm-offsets.c
>> and check what ends up in include/generated/asm-offsets.h - the
>> latter is entirely produced out of the former.
>>
>> The trick is to have inline asm that would spew a recognizable
>> line when compiled into assembler, with the value(s) you want
>> substituted into it.  See include/linux/kbuild.h for the macros.
>>
>> Then you pick these lines out of generated your_file.s - no need
>> to use python, sed(1) will do just fine.  See filechk_offsets in
>> scripts/Makefile.lib for that part.
> None of it is necessary.
>
> Tiezhu,
>
> bcc's tools/filetop.py is really old and obsolete.
> It's not worth fixing. I'd delete it.
> Use bcc's libbpf-tools/filetop instead.

Tiezhu, please check whether libbpf-tools/filetop satisfied your need or 
not. Thanks!


