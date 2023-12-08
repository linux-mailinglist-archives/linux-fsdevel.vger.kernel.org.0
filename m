Return-Path: <linux-fsdevel+bounces-5292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B56E809AF8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 05:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E38EAB20D7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 04:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F7525D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 04:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kiokj3Cv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FC31715
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 19:16:58 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ce4fe4ed18so204942b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 19:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702005417; x=1702610217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Rux8vsdKkM8nJouugwOO5GuiDS1SIZxc5Vu7ejUgpg=;
        b=kiokj3Cvkjuh6K6kaPMkRewYJfU3w76aX5w5wmeAVRKVmf0fG63b8As81aqJwLS8Ym
         /NU6pPAj7qvc6Y6z+bqUiMdUlNb63WQoULePOTxhnrIzSm3pWwUXUuZ47feGpdANRy6l
         d6Rm0Ahj2pUFGrINR3AJ4gSgcKopIg4zHVw+YSondoXswF1Ghn1Ro7Ay/5apnjwA0iWR
         avJmPk39lMK9S2+rEg5cP659n/hVbyR7phdrDxZAUm7Q/nH5x8YbwR5EDbZNtEXMIvRO
         fjD1db9u7IcdSj3hZxJKAcBmOXrDWE89NO7iSgk6DSN6xrfPkNyPb1v3Z5dyaOAXWzL5
         /x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702005417; x=1702610217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Rux8vsdKkM8nJouugwOO5GuiDS1SIZxc5Vu7ejUgpg=;
        b=dYC3h9JuOUCm/qOL8XzfLdDHDOph4BFnsCaXgEEfwXnr3xZgo/ZTxR+MA4Vj/ii4aJ
         yv2kgsmcvDhsS5qRNmYzw5ZoPltqVCmHhtf+6F5wKybe6oVpsVlOoss7n8VHK5ki6F8B
         PBJDFs6OAlbKufT6FhHGD3L1AFDpG0TjvNXn5YW4arGC2C5/foJeoy0fZ55io7dAJ1lb
         T6tfGiEjXa+/GkdDqSz2iZxPK6ldzh3vTbzAhD3N/tixQNrHE9iwwXPgO7wpk3IjVAtm
         OCd/EoqjXvfJmwI2P2H2L901R0GaueGj5H+ApHfx6Y9kbjwymVwk4dJ2TOIZy+wUa5eR
         yvrQ==
X-Gm-Message-State: AOJu0Yz5uAKDM6AMMswczUFJlWy+a/zMnFNLffdaleanmHIrsHbwvqu6
	GnATsuZwwgjoUHsKiPoA+dcPmQ==
X-Google-Smtp-Source: AGHT+IG9jHTBY0aV5Yr24U5BQ3/Hg69SHwR+uuZY0ZALqq+TUk7qPMqJeWLxOi0f4Ti5W5yPHBr6Gg==
X-Received: by 2002:a05:6a00:194f:b0:6ce:2de2:fe4d with SMTP id s15-20020a056a00194f00b006ce2de2fe4dmr7543886pfk.1.1702005417512;
        Thu, 07 Dec 2023 19:16:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id w4-20020aa78584000000b006ce5c583c89sm532425pfn.15.2023.12.07.19.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 19:16:56 -0800 (PST)
Message-ID: <c86faa98-937f-42e6-8c05-60112fd95966@kernel.dk>
Date: Thu, 7 Dec 2023 20:16:55 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>,
 Florian Weimer <fweimer@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <874jh3t7e9.fsf@oldenburg.str.redhat.com> <ZWjaSAhG9KI2i9NK@tycho.pizza>
 <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
 <87ttp3rprd.fsf@oldenburg.str.redhat.com>
 <20231207-entdecken-selektiert-d5ce6dca6a80@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231207-entdecken-selektiert-d5ce6dca6a80@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 3:58 PM, Christian Brauner wrote:
> [adjusting Cc as that's really a separate topic]
> 
> On Thu, Nov 30, 2023 at 08:43:18PM +0100, Florian Weimer wrote:
>> * Mathieu Desnoyers:
>>
>>>>> I'd like to offer a userspace API which allows safe stashing of
>>>>> unreachable file descriptors on a service thread.
> 
> Fwiw, systemd has a concept called the fdstore:
> 
> https://systemd.io/FILE_DESCRIPTOR_STORE
> 
> "The file descriptor store [...] allows services to upload during
> runtime additional fds to the service manager that it shall keep on its
> behalf. File descriptors are passed back to the service on subsequent
> activations, the same way as any socket activation fds are passed.
> 
> [...]
> 
> The primary use-case of this logic is to permit services to restart
> seamlessly (for example to update them to a newer version), without
> losing execution context, dropping pinned resources, terminating
> established connections or even just momentarily losing connectivity. In
> fact, as the file descriptors can be uploaded freely at any time during
> the service runtime, this can even be used to implement services that
> robustly handle abnormal termination and can recover from that without
> losing pinned resources."
> 
>>
>>>> By "safe" here do you mean not accessible via pidfd_getfd()?
>>
>> No, unreachable by close/close_range/dup2/dup3.  I expect we can do an
>> intra-process transfer using /proc, but I'm hoping for something nicer.
> 
> File descriptors are reachable for all processes/threads that share a
> file descriptor table. Changing that means breaking core userspace
> assumptions about how file descriptors work. That's not going to happen
> as far as I'm concerned.
> 
> We may consider additional security_* hooks in close*() and dup*(). That
> would allow you to utilize Landlock or BPF LSM to prevent file
> descriptors from being closed or duplicated. pidfd_getfd() is already
> blockable via security_file_receive().
> 
> In general, messing with fds in that way is really not a good idea.
> 
> If you need something that awkward, then you should go all the way and
> look at io_uring which basically has a separate fd-like handle called
> "fixed files".
> 
> Fixed file indexes are separate file-descriptor like handles that can
> only be used from io_uring calls but not with the regular system call
> interface.
> 
> IOW, you can refer to a file using an io_uring fixed index. The index to
> use can be chosen by userspace and can't be used with any regular
> fd-based system calls.
> 
> The io_uring fd itself can be made a fixed file itself
> 
> The only thing missing would be to turn an io_uring fixed file back into
> a regular file descriptor. That could probably be done by using
> receive_fd() and then installing that fd back into the caller's file
> descriptor table. But that would require an io_uring patch.

FWIW, since it was very trivial, I posted an rfc/test patch for just
that with a test case. It's here:

https://lore.kernel.org/io-uring/df0e24ff-f3a0-4818-8282-2a4e03b7b5a6@kernel.dk/

-- 
Jens Axboe


