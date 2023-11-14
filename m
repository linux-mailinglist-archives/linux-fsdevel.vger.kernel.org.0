Return-Path: <linux-fsdevel+bounces-2845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E7A7EB491
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 17:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A971F2286E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1489B41A98;
	Tue, 14 Nov 2023 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASBlRdGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83CF405DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 16:15:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABE8FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699978504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qQqdDU6BkTtdEZPEXawtARsEiRxQp/2umHj4Nbx11vQ=;
	b=ASBlRdGMuUbEwPwzYk1ZYh/JK9E8gZ1rIeY++VzV2K5cDJKhaZfPN5JzIb1c+UQeMxjNFx
	Orx6Onk/WC8gtlqFm5cnq35VeicRIx5Z5jXvLOzkaz9S04NnSZDiJsaY9s3hlkR8w/eQ0l
	/LzbrrwyHWaIhUTKroGByX+PLxe5osE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-jMnaLzLPPUCAD0BretcBBA-1; Tue, 14 Nov 2023 11:15:03 -0500
X-MC-Unique: jMnaLzLPPUCAD0BretcBBA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-407f9d07b41so36866565e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 08:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699978502; x=1700583302;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQqdDU6BkTtdEZPEXawtARsEiRxQp/2umHj4Nbx11vQ=;
        b=kOyqrB2cmcridvupycu31wQOk/lycMFHeSpZBrVdRVFj2s5i/L9SjF0dtqyBUPfFnN
         lp8nUF7U0TevGLAK9vHhVqPUa2bLQAE8qIPy4ZcC8FiD1oktnz1YMxTx77jF6nO5YOi8
         ndPJgF0N9miS/TpoB4J5scVfGMYp4h5f+/tjXzkw9zsl2ubAvOFDarlhhdIi7OuXywcP
         ZerG7JvrxXZtWSU7msSee6vfyhBEsrKfqnMyp4bzoxL3pttPdJI7plJtKAXgtu0Lf5lv
         6KYVlbVoUPwdOJ+e5pG8ds/ovm3W9ep9UOOm8K1NpyO+ngoY7YuxC8j328i29JrSS1Th
         ZuqA==
X-Gm-Message-State: AOJu0Yytqxt+3wPbf2CUTq8L9YzRROOYrkO5wPhy1dJQEkKrx5+A0Q61
	g6FFDagZvr42KMCq8lgo51Z0kJojgLuhoRniTSicz/l+d6mo2oFVADOhWW4wFOUgYuVg3PX/MjS
	VeF+b73UGcV5/lZ7TTr1/nZXf+8ghHvouqA==
X-Received: by 2002:a05:600c:1986:b0:407:8e85:89ad with SMTP id t6-20020a05600c198600b004078e8589admr8467811wmq.14.1699978502005;
        Tue, 14 Nov 2023 08:15:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjgLMBVuteRAgWkzkndIX3pveFJIEqk4P2Litcso3U6qfsh4sX6A4EQnMXE2pAdfBdnoZd2g==
X-Received: by 2002:a05:600c:1986:b0:407:8e85:89ad with SMTP id t6-20020a05600c198600b004078e8589admr8467782wmq.14.1699978501516;
        Tue, 14 Nov 2023 08:15:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:8900:2d8:c9f0:f3fb:d4fd? (p200300cbc73e890002d8c9f0f3fbd4fd.dip0.t-ipconnect.de. [2003:cb:c73e:8900:2d8:c9f0:f3fb:d4fd])
        by smtp.gmail.com with ESMTPSA id j21-20020a05600c1c1500b003fee567235bsm14439647wms.1.2023.11.14.08.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 08:15:01 -0800 (PST)
Message-ID: <ee56f523-cd49-47f8-865f-3ce0ab0067a0@redhat.com>
Date: Tue, 14 Nov 2023 17:14:59 +0100
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Kees Cook <keescook@chromium.org>, sonicadvance1@gmail.com,
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
 <9f83d97e-b7a1-4142-8316-088b3854c30d@redhat.com>
 <87ttpouxgc.fsf@email.froward.int.ebiederm.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87ttpouxgc.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.11.23 17:11, Eric W. Biederman wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 13.11.23 19:29, Eric W. Biederman wrote:
>>> "Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
>>>
>>>> On 09/10/2023 14:37, Kees Cook wrote:
>>>>> On Fri, Oct 06, 2023 at 02:07:16PM +0200, David Hildenbrand wrote:
>>>>>> On 07.09.23 22:24, Guilherme G. Piccoli wrote:
>>>>>>> Currently the kernel provides a symlink to the executable binary, in the
>>>>>>> form of procfs file exe_file (/proc/self/exe_file for example). But what
>>>>>>> happens in interpreted scenarios (like binfmt_misc) is that such link
>>>>>>> always points to the *interpreter*. For cases of Linux binary emulators,
>>>>>>> like FEX [0] for example, it's then necessary to somehow mask that and
>>>>>>> emulate the true binary path.
>>>>>>
>>>>>> I'm absolutely no expert on that, but I'm wondering if, instead of modifying
>>>>>> exe_file and adding an interpreter file, you'd want to leave exe_file alone
>>>>>> and instead provide an easier way to obtain the interpreted file.
>>>>>>
>>>>>> Can you maybe describe why modifying exe_file is desired (about which
>>>>>> consumers are we worrying? ) and what exactly FEX does to handle that (how
>>>>>> does it mask that?).
>>>>>>
>>>>>> So a bit more background on the challenges without this change would be
>>>>>> appreciated.
>>>>>
>>>>> Yeah, it sounds like you're dealing with a process that examines
>>>>> /proc/self/exe_file for itself only to find the binfmt_misc interpreter
>>>>> when it was run via binfmt_misc?
>>>>>
>>>>> What actually breaks? Or rather, why does the process to examine
>>>>> exe_file? I'm just trying to see if there are other solutions here that
>>>>> would avoid creating an ambiguous interface...
>>>>>
>>>>
>>>> Thanks Kees and David! Did Ryan's thorough comment addressed your
>>>> questions? Do you have any take on the TODOs?
>>>>
>>>> I can maybe rebase against 6.7-rc1 and resubmit , if that makes sense!
>>>> But would be better having the TODOs addressed, I guess.
>>> Currently there is a mechanism in the kernel for changing
>>> /proc/self/exe.  Would that be reasonable to use in this case?
>>> It came from the checkpoint/restart work, but given that it is
>>> already
>>> implemented it seems like the path of least resistance to get your
>>> binfmt_misc that wants to look like binfmt_elf to use that mechanism.
>>
>> I had that in mind as well, but
>> prctl_set_mm_exe_file()->replace_mm_exe_file() fails if the executable
>> is still mmaped (due to denywrite handling); that should be the case
>> for the emulator I strongly assume.
> 
> Bah yes.  The sanity check that that the old executable is no longer
> mapped does make it so that we can't trivially change the /proc/self/exe
> using prctl(PR_SET_MM_EXE_FILE).

I was wondering if we should have a new file (yet have to come up witha 
fitting name) that defaults to /proc/self/exe as long as that new file 
doesn't explicitly get set via  a prctl.

So /proc/self/exe would indeed always show the emulator (executable), 
but the new file could be adjusted to something that is being executed 
by the emulator.

Just a thought ... I'd rather leave /proc/self/exe alone.

-- 
Cheers,

David / dhildenb


