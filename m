Return-Path: <linux-fsdevel+bounces-13504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C08708E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C257B25D44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9761687;
	Mon,  4 Mar 2024 17:58:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA5612F6;
	Mon,  4 Mar 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575121; cv=none; b=dybDadzhR9N+Sg2r0YHrBI/LfQvtgSREptFj+1c3I+jg4rfi3I4uhleCXm+TKaULMhJpMgB6L04m0r8HL6DNEIYM89eB6mPDAoz9658yN1WENdHnSUtKkMAJEJfnqmQy4PqSQHNSqWsmo5EX38SppnelGW5qb1a3cA5FI1IuyKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575121; c=relaxed/simple;
	bh=7Zu9zgcac4VgwpjQvrHw9a/i3AQ4qr/4jtRiPbhFdrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5jdwfo9cVEZuvUNjNNws/7c3IMu4mGuT+G+sHP1UTf7PTAEucRZeXFV+r4EwRsl9UeZO/ecxtFRVa/JXOpIG3oYRFOkOlPLBmi65QbSagXxN8+550znjifqaRs8eTdO/LJPRaq9YpEoL9P3B7owy0uAluQFKubxghkbcvnhqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e57a3bf411so2762299b3a.0;
        Mon, 04 Mar 2024 09:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575119; x=1710179919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ajt4lA5nr72NHbHG6HjtHvqols3KCbA7VNlfI59BaQ=;
        b=Q58ZYHQDVX2YukB6WmLXrCE55UJso/J1SBXpywxsvgzY8XJX5GEWxTFmMzUYIpNUVX
         Cfvuem7eq9lZJFPsOM/Kuczu/yYYSVsT/L+ybyifoSjns8hHSA7/kL8YuPeTg93pG6Bl
         /PPnx37t08YlhDL8CgBfjSgXt8943/AlkBVNZLnaydw2m4dV2dTA8KJfz1qeeXxQkbb5
         BAhuVsJTm5/l6NH0jDjFh0P9zUpU6CjAtVLt5zQubfvfOTyQYBjGp/7/k5XoOlh9tI0G
         cknGqvhYpi5kzyJEG9KOALJVBSfhVUMBc5nLDryXaMPcWlkIRv2EDAhSsWoIso+ulEBN
         o+8w==
X-Forwarded-Encrypted: i=1; AJvYcCX1FAVB7DwTP1C4xIGzQfiFnsrlTtaT4waNOTuY+KPDOLkft1OzUaIEcrE91v45OTHQmxMAy3xsg3Bsj2aAiMBDsdah8toVf2LpN5ccKD4bPngP1UD1Ytz9qQX3knVltV4KBdsj6j8ew08C7A==
X-Gm-Message-State: AOJu0YwaA6DaMybfeTRXlu+oFiIegR84EHufXEDE/EBeE1wY/Ue0x4ca
	DECi9ZQo9pgfRoCf6NySozC2VFzQsJL7Wd81x3rgJ1fO0jL+8uyb
X-Google-Smtp-Source: AGHT+IFhvikOlxrphG2KYj9gZMJrvMpgTjhCTRDIHMbditN7auCUbuV1vT9jAgXrYY12qSfNqY9/vg==
X-Received: by 2002:a05:6a00:b48:b0:6e5:4451:eb90 with SMTP id p8-20020a056a000b4800b006e54451eb90mr12616402pfo.6.1709575119043;
        Mon, 04 Mar 2024 09:58:39 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:9ba8:35e8:4ec5:44d1? ([2620:0:1000:8411:9ba8:35e8:4ec5:44d1])
        by smtp.gmail.com with ESMTPSA id x16-20020aa784d0000000b006e55d5215dbsm7502218pfn.87.2024.03.04.09.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 09:58:38 -0800 (PST)
Message-ID: <2587412f-454d-472c-84b3-d7b9776a105a@acm.org>
Date: Mon, 4 Mar 2024 09:58:37 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/aio: fix uaf in sys_io_cancel
Content-Language: en-US
To: Benjamin LaHaise <ben@communityfibre.ca>
Cc: Edward Adam Davis <eadavis@qq.com>,
 syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com, brauner@kernel.org,
 jack@suse.cz, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 viro@zeniv.linux.org.uk
References: <0000000000006945730612bc9173@google.com>
 <tencent_DC4C9767C786D2D2FDC64F099FAEFDEEC106@qq.com>
 <14f85d0c-8303-4710-b8b1-248ce27a6e1f@acm.org>
 <20240304170343.GO20455@kvack.org>
 <73949a4d-6087-4d8c-bae0-cda60e733442@acm.org>
 <20240304173120.GP20455@kvack.org>
 <5ee4df86-458f-4544-85db-81dc82c2df4c@acm.org>
 <20240304174721.GQ20455@kvack.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240304174721.GQ20455@kvack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 09:47, Benjamin LaHaise wrote:
> On Mon, Mar 04, 2024 at 09:40:35AM -0800, Bart Van Assche wrote:
>> On 3/4/24 09:31, Benjamin LaHaise wrote:
>>> A revert is justified when a series of patches is buggy and had
>>> insufficient review prior to merging.
>>
>> That's not how Linux kernel development works. If a bug can get fixed
>> easily, a fix is preferred instead of reverting + reapplying a patch.
> 
> Your original "fix" is not right, and it wasn't properly tested.  Commit
> 54cbc058d86beca3515c994039b5c0f0a34f53dd needs to be reverted.

As I explained before, the above reply is not sufficiently detailed to
motivate a revert.

Bart.

