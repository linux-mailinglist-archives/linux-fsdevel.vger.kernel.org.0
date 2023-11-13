Return-Path: <linux-fsdevel+bounces-2805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0207EA3A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 20:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CBC1C20954
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060A523749;
	Mon, 13 Nov 2023 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYdtCNUB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372C6ABC
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 19:17:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E7846BF
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 11:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699903014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QI+OFjhz2/q8YuzQGF/7kt5ZmFWZ0Ih26v8XHGpxDAg=;
	b=RYdtCNUBBQ3TgMQ3iUx6g3FXGr2tJqwaRnQ51LvEZOQnGbTzIXux4OUlzkXr2iTtmRW5Nu
	sx0yXrfKRTOl8VYZTEYzWxUtwt2x0E4aW+8iI8LwIPhCL295Iyb6mthDneVouhyBiAdkz/
	hJavRiNhrescodYhqS/jQK/9+toRlnU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-pE8BHV1VOMealx8SmicRvw-1; Mon, 13 Nov 2023 14:16:53 -0500
X-MC-Unique: pE8BHV1VOMealx8SmicRvw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-408524e2368so31927635e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 11:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699903012; x=1700507812;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QI+OFjhz2/q8YuzQGF/7kt5ZmFWZ0Ih26v8XHGpxDAg=;
        b=QIaZ7xZAbRiKObsefSbAHf25RWF2FzppCgBnB1jHJ6PMz4B7/+RKaJULAsXKPnGQh9
         wuQMPhBCrI28wFHNwsclqINgpUs9swDV8Ga420mbmqYWQacK9H6je9x+pWbLMXyMYac2
         egQdQbWnW2A2nRIWieT+w1tPxSbMHbZXnJurN7hf2z83eBkk5jKhwpPc9+rSJH276d9f
         9o7obNK34sIbJLcz/noEpsKMLtEi4jvO+1UUSW59DRevFb+7CBQbGiLjyc2CiayqHe+6
         l3z6dPhiGtGt01FM7HJEs45aB0GUBIE4VnvUtF93zIUfWhtVfjXPyLPkOk4es1ChgsDf
         tYwg==
X-Gm-Message-State: AOJu0YyUEfolw0tdSc4zJeAkHFSp9AgE3tIKkdQYSB2AdWPTIyoWxjaU
	p8ZA9JGYiYK2FpebpESnP6IHRWmkeHYudOD9AiYieVULoOSEIZqsWK+sYzy0MH7OKH88X4vKAnN
	NP/+zx7CgFizIH/7SegufRslzwQ==
X-Received: by 2002:a5d:5847:0:b0:32f:7d5a:87ab with SMTP id i7-20020a5d5847000000b0032f7d5a87abmr6576524wrf.53.1699903012063;
        Mon, 13 Nov 2023 11:16:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHePviOiZUmhfcxNssCAgAnAuSKXuz27fg99dUJ3dKUcuVnbQ/fIU7ew3IR4gby02/E8lMFlQ==
X-Received: by 2002:a5d:5847:0:b0:32f:7d5a:87ab with SMTP id i7-20020a5d5847000000b0032f7d5a87abmr6576498wrf.53.1699903011617;
        Mon, 13 Nov 2023 11:16:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c73a:400:892e:7ff0:87:a52c? (p200300cbc73a0400892e7ff00087a52c.dip0.t-ipconnect.de. [2003:cb:c73a:400:892e:7ff0:87:a52c])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d544c000000b0031aef72a021sm6020406wrv.86.2023.11.13.11.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 11:16:51 -0800 (PST)
Message-ID: <9f83d97e-b7a1-4142-8316-088b3854c30d@redhat.com>
Date: Mon, 13 Nov 2023 20:16:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Introduce a way to expose the interpreted file
 with binfmt_misc
Content-Language: en-US
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <keescook@chromium.org>, sonicadvance1@gmail.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
 oleg@redhat.com, yzaikin@google.com, mcgrof@kernel.org,
 akpm@linux-foundation.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
 willy@infradead.org, dave@stgolabs.net, joshua@froggi.es
References: <20230907204256.3700336-1-gpiccoli@igalia.com>
 <e673d8d6-bfa8-be30-d1c1-fe09b5f811e3@redhat.com>
 <202310091034.4F58841@keescook>
 <8dc5069f-5642-cc5b-60e0-0ed3789c780b@igalia.com>
 <871qctwlpx.fsf@email.froward.int.ebiederm.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <871qctwlpx.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.11.23 19:29, Eric W. Biederman wrote:
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
> 
>> On 09/10/2023 14:37, Kees Cook wrote:
>>> On Fri, Oct 06, 2023 at 02:07:16PM +0200, David Hildenbrand wrote:
>>>> On 07.09.23 22:24, Guilherme G. Piccoli wrote:
>>>>> Currently the kernel provides a symlink to the executable binary, in the
>>>>> form of procfs file exe_file (/proc/self/exe_file for example). But what
>>>>> happens in interpreted scenarios (like binfmt_misc) is that such link
>>>>> always points to the *interpreter*. For cases of Linux binary emulators,
>>>>> like FEX [0] for example, it's then necessary to somehow mask that and
>>>>> emulate the true binary path.
>>>>
>>>> I'm absolutely no expert on that, but I'm wondering if, instead of modifying
>>>> exe_file and adding an interpreter file, you'd want to leave exe_file alone
>>>> and instead provide an easier way to obtain the interpreted file.
>>>>
>>>> Can you maybe describe why modifying exe_file is desired (about which
>>>> consumers are we worrying? ) and what exactly FEX does to handle that (how
>>>> does it mask that?).
>>>>
>>>> So a bit more background on the challenges without this change would be
>>>> appreciated.
>>>
>>> Yeah, it sounds like you're dealing with a process that examines
>>> /proc/self/exe_file for itself only to find the binfmt_misc interpreter
>>> when it was run via binfmt_misc?
>>>
>>> What actually breaks? Or rather, why does the process to examine
>>> exe_file? I'm just trying to see if there are other solutions here that
>>> would avoid creating an ambiguous interface...
>>>
>>
>> Thanks Kees and David! Did Ryan's thorough comment addressed your
>> questions? Do you have any take on the TODOs?
>>
>> I can maybe rebase against 6.7-rc1 and resubmit , if that makes sense!
>> But would be better having the TODOs addressed, I guess.
> 
> Currently there is a mechanism in the kernel for changing
> /proc/self/exe.  Would that be reasonable to use in this case?
> 
> It came from the checkpoint/restart work, but given that it is already
> implemented it seems like the path of least resistance to get your
> binfmt_misc that wants to look like binfmt_elf to use that mechanism.

I had that in mind as well, but 
prctl_set_mm_exe_file()->replace_mm_exe_file() fails if the executable 
is still mmaped (due to denywrite handling); that should be the case for 
the emulator I strongly assume.

-- 
Cheers,

David / dhildenb


