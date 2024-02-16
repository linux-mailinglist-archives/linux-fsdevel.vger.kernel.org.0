Return-Path: <linux-fsdevel+bounces-11874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4579B8583BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 18:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A6128366A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00D5131E30;
	Fri, 16 Feb 2024 17:11:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD43130E4F;
	Fri, 16 Feb 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103509; cv=none; b=CQpoAPCfKdNfQXAO1BdxNRMV02lMDl6g4wXWcpPmaddoO9gHctGXqtEmuDnoUyZPC7LarBORhtGU9PSvyAyU+H3Dx+ROBsxc9o6btv362XSDdO5K9O4513HWwFJPc5gZabF6Qu5N2aK3NEHFK+U0B8qPJ2cRmPIbXYnJhrUOUn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103509; c=relaxed/simple;
	bh=kyrFySfD33DfjMotSRjE71WBERyw/qE/LQ5gGoYlAJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQN1RjRIqf9DbfOJZSnY0xgH436LFHEgRGdbmls5ZWr+Y/gGMcKKU+trFcfKmWxfFOgrsX0UJS0VSyaAswGRaUTcWcbWBy453LqkUDamCYR+LfxUJHNfxoRcMOkVvFf+QsQaRct/xTBmMbEulaeiLUnJfNBzSmDi3nabDg1lh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d94323d547so8540345ad.3;
        Fri, 16 Feb 2024 09:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103507; x=1708708307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSuzb8DqbcddqazNcXeQYXhIgH29Q4MURStfPcjLULA=;
        b=v/Nmk8WJk3BlJuRXJt/Ds3QCxfejv3ln/K/W80r4ULoqQt5rFkbrgWSgPiD74HPUKO
         n1n4epdsm9cf3YLx9wYUCzWVp0jDcNidPO5uO8U2hwOWt9iRu9uFgUfHza4T3wGqXX7j
         AG46r7sr6hSZIVaevTojJngyKVRA5qcZZz3rVNY6M/7QIGOVZGSsG7l7ZN3cPsDF1JNm
         chBbhkKg7bT52bofdq6Gi3PqZjoX65bWVfBwu17jSmm12fXGW6SUcTbubzRYY9SgUf4Y
         U1Yf2MJNd+CjW7G8kXYAYHBk0oQnm94yiI0lwis1PQJh5Z7rzhM031ooLuvt8mBPVShe
         9OHw==
X-Forwarded-Encrypted: i=1; AJvYcCWw8GCnbfjSh9CZtvLaC4qDG4fEXNURAN2ELz/JYTIrYx6MrLOe0K6V/L+x5T+voIHdjwGNaP1v417I0TgwNlAID0P4KGezycGNcn/Af9qwbZxycc0Ru2NkdavD5mNFYYFQaLQuVA==
X-Gm-Message-State: AOJu0Yxf0zSGy9NA3OCwy8BZjChlYn2aCCpYIJLEe0YvLZofjHDl3ibU
	APj6TAh5U4rFqaqR7QfileEX54lvAoqRh29Bf1PLM1hd07knnUTY
X-Google-Smtp-Source: AGHT+IG331XjoMtNRThXXnRDunQFRUpE1MOOB8nfLq5iNWvlJsUs8AfBgaFdVPSmrQfnRelEw/AJEQ==
X-Received: by 2002:a17:90a:b887:b0:299:4ac2:1514 with SMTP id o7-20020a17090ab88700b002994ac21514mr544771pjr.6.1708103507206;
        Fri, 16 Feb 2024 09:11:47 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id mt4-20020a17090b230400b002991a647c8fsm262224pjb.10.2024.02.16.09.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 09:11:46 -0800 (PST)
Message-ID: <9d3138e1-3ac0-47c0-b768-a285eb38d224@acm.org>
Date: Fri, 16 Feb 2024 09:11:43 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] fs/aio: Make io_cancel() generate completions
 again
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
 Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Kent Overstreet <kent.overstreet@linux.dev>,
 stable@vger.kernel.org
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240215204739.2677806-3-bvanassche@acm.org> <20240216071325.GA10830@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240216071325.GA10830@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 23:13, Christoph Hellwig wrote:
> On Thu, Feb 15, 2024 at 12:47:39PM -0800, Bart Van Assche wrote:
>> The following patch accidentally removed the code for delivering
>> completions for cancelled reads and writes to user space: "[PATCH 04/33]
>> aio: remove retry-based AIO"
>> (https://lore.kernel.org/all/1363883754-27966-5-git-send-email-koverstreet@google.com/)
> 
> Umm, that was more than 10 years ago.  What code do you have that
> is this old, and only noticed that it needs the completions now?

USB cancellation is being used and still works. It's only the completions
that are missing.

This patch was submitted less than two years ago and fixes a bug in the adb
daemon: "adbd: Dequeue pending USB write requests upon receiving CNXN"
(https://android.googlesource.com/platform/packages/modules/adb/+/4dd4da41e6b004fa0d49575ac87e8db877f3a116).
My questions about that patch are as follows (I have not yet found an adbd
expert who can help me with answering these questions):
* Are the io_cancel() calls racy? If the io_cancel() calls are delayed, will
   this break the fix for the bug described in the patch description?
* Should the reported bug perhaps be fixed by improving the adb protocol,
   e.g. by including a session ID in the adb protocol header?

Thanks,

Bart.

