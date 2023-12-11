Return-Path: <linux-fsdevel+bounces-5518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B92380D1D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89D01F215E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBA0FC06;
	Mon, 11 Dec 2023 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpcfL6uQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE6A8E
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 08:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702312342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zf8entefDzOqQ9+sQlfmVQKb6/ZuCgvQj4+9alNyvCE=;
	b=fpcfL6uQAWQAocrfl5Xfjl5L2oL/I5kdZvCtDAmsrdqc8LgZCfWrtwT4JVqHW+1WvKTk32
	LXEyLeboEyz6C2BrneKjWowGYjR9oCV0FmAbNQuF32cgQEu22POHJb/aKq0fKj6wkSVins
	XOdTNQs7DNsBjhkroSF6AouxZzpYVpM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-_gCzQwx1M6CVaNqtRsClAg-1; Mon, 11 Dec 2023 11:32:20 -0500
X-MC-Unique: _gCzQwx1M6CVaNqtRsClAg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-333501e22caso3922817f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 08:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312339; x=1702917139;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zf8entefDzOqQ9+sQlfmVQKb6/ZuCgvQj4+9alNyvCE=;
        b=BSUNDUQu3nvU/Vr5Cca3ekR7zbjyWrqtUP+7WyQ0EqdwthvxgkVfKNUqA5YgN1ni1Z
         1hJPnqOdEdn3TtVD9YM50nlXdzVB/rp7wXyh7RoyD9SxMUXIcN3iebR3hP+gqhZee8y3
         w3PE42HUG6CIklOLp8Mw4EpfTTfAyDU2xSZGVlkab3H13OXX+MEOx0AEBy3Ig2QHeoRH
         B90ggglBSr1ufIsKi7JUZhPh16Qn2JF0wIIbuQh08EucJIajLBjz7J4OdY7CF4FgD0il
         ORZDubH5qhaNszLW8nXiY6wJEk5exvaoZSPaHg6gb9adKrVFs3hKelfiS9nmTmjXNONC
         8ong==
X-Gm-Message-State: AOJu0YzfzIZfTiKchbgM97COruDHpFgZdaSzXAPaKQiWFwVtoEEhfuP1
	8Ck9PY7+ZHEq6JJa1VqkclHQQtjEPRN3gtZXIF5t4tydJe48pdaj0Zvdd/jgt5cUIedNaX6DAd8
	6cuSEuOpMgqEVHwNgQaMxQv2YHg==
X-Received: by 2002:a5d:48ca:0:b0:333:1adc:a37b with SMTP id p10-20020a5d48ca000000b003331adca37bmr2319662wrs.5.1702312339405;
        Mon, 11 Dec 2023 08:32:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCImgJ+fdKFn2Ho8LCcXYicLPE96TwwOTSIvoc44yS2tSwvRXXt4g8MHsfBuDF4HXBbgU4Qg==
X-Received: by 2002:a5d:48ca:0:b0:333:1adc:a37b with SMTP id p10-20020a5d48ca000000b003331adca37bmr2319644wrs.5.1702312339010;
        Mon, 11 Dec 2023 08:32:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c742:ae00:6e5f:7195:98f6:3ed1? (p200300cbc742ae006e5f719598f63ed1.dip0.t-ipconnect.de. [2003:cb:c742:ae00:6e5f:7195:98f6:3ed1])
        by smtp.gmail.com with ESMTPSA id h6-20020adffd46000000b003333c9ad4d6sm8926700wrs.116.2023.12.11.08.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 08:32:18 -0800 (PST)
Message-ID: <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
Date: Mon, 11 Dec 2023 17:32:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, Mark Brown <broonie@kernel.org>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
 peterx@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, John Hubbard <jhubbard@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.12.23 17:15, Suren Baghdasaryan wrote:
> On Mon, Dec 11, 2023 at 4:24 AM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Mon, Dec 11, 2023 at 01:03:27PM +0100, David Hildenbrand wrote:
>>> On 11.12.23 12:15, Mark Brown wrote:
>>
>>>> This is linux-next.  I pasted the commands used to build and sent links
>>>> to a full build log in the original report.
>>
>>> Probably also related to "make headers-install":
>>
>>> https://lkml.kernel.org/r/20231209020144.244759-1-jhubbard@nvidia.com
>>
>>> The general problem is that some mm selftests are currently not written in
>>> way that allows them to compile with old linux headers. That's why the build
>>> fails if "make headers-install" was not executed, but it does not fail if
>>> "make headers-install" was once upon a time executed, but the headers are
>>> outdated.
>>
>> Oh, it's obviously the new headers not being installed.  The builds
>> where I'm seeing the problem (my own and KernelCI's) are all fresh
>> containers so there shouldn't be any stale headers lying around.
> 
> Ok, I was updating my headers and that's why I could not reproduce it.
> David, should the test be modified to handle old linux headers
> (disable the new tests #ifndef _UFFDIO_MOVE or some other way)?

That's an open question: do we want to be able to build selftests 
against any host headers, and not the in-tree headers that have to be 
manually installed and dirty the git tree?

One obvious drawbacks is that we'll have to deal with all that using a 
bunch of #ifdef, and the tests that will be built+run will depend on the 
host headers.

Especially the letter is relevant I think: Our upstream testing won't be 
able to build+run tests that rely on new upstream features. But that's 
what some key benefit of these selftests, and being able to run them 
automatically on a bunch of different combinations upstream.

Further, the tests are closely related to the given kernel version, they 
are not some completely separate tests.


Moving the the (MM?) selftests to a separate repository would make the 
decision easier: just like in QEMU etc, we'd simply pull in a headers 
update and only build against these archived headers.

So I see the options:

(1) Rely on installing the proper in-tree headers. Build will fail if
     that is not happening.

(2) Make the tests build with any host headers.

(3) Regularly archive the required headers in the selftest directory
     like external projects like QEMU do.


(3) avoids dirtying the tree as a "make headers_install" would, but it 
also means that each test that makes use of new uapi has to update the 
relevant headers (what people working on QEMU are used to).


-- 
Cheers,

David / dhildenb


