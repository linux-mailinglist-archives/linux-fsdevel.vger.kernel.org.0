Return-Path: <linux-fsdevel+bounces-12871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF9A868219
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F59C1C26AA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 20:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B19131732;
	Mon, 26 Feb 2024 20:50:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0751B130E5C
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980650; cv=none; b=jubxBfd3caqzghYPJUTW+hyyjrvN/mxJL7BL2F68qBxKdNICEX4jBPHLwFzXjZObe6JL491V8qULwu6WvDdbw8O3cMwWhrLBWo/U/YpOec8YhslTDGJzTipr2uBL8RGSaTGoLzlf8jAhbX2s6EPbDVOwFxlIMct2ixB3MbfY4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980650; c=relaxed/simple;
	bh=MouWD5lD3U3i3wnLkizDrpBje2x2T6z80RLewMkmru4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0/a68f1LFqMnevifrpNBVg+PWxkTa4gc6f7XrOJEWpkjYlnaYKj3tRATb4xauVwIkCUr3YQde/Be+q2We7cBLmWnc1O1r1b5ysjxXCKhxYrFadmJLnbVXld/+vTkPhpVByvYQ7HnOWGLwAHmovK5d09+ZrmPTAmbktur9DpJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so2208698a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 12:50:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708980648; x=1709585448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMxoRsOGxdVQ3fG2yAyXwJh/SwrWEMb8i3eSZnTmE4U=;
        b=NjnQxiFawab6d9dIpqhEoA0dOBBMFFrK67Ne485BXGbwJgIV5bO+YMZmG0WqVXpnlC
         YJlZjYVerQ2/QHgfa6iv3zxEew8ZHnpdaJ88jplmkuBPttQ4+lBO0zZmADmnnWMweR6B
         l0FOiKVAaH+f20cyNY2rGFc8or2z9K7m7bUsEzpPTi6R1wzdcDPK1lkec/hjyQJYyjLU
         h9zcykfLQjVOtffWa9NcdU3Ai0chDa4Ps0svnkCkB/7CN30/n9HyPTwwpUuHilKucuSs
         0U/Xgct1kbnWn6pZUCC3Qh7aYrmU00JPwWMxEhOKx7rQ6IjyO4ENslO/d8yJ5v6c+pzC
         AF6g==
X-Gm-Message-State: AOJu0YwIdnp5XsBas1UJMsnmqnabX23BM+1//5DxaCjY8ero3Yu4ElKX
	fid0ZrfWiLVK6hXgdTrBp6kwvsguAR5ZUzxYhK2/qoW+293Qf1SBE2VbakWC
X-Google-Smtp-Source: AGHT+IFLk1cX6u6waXKA45kIynI6vAuI2jR7KJ41kQgZgz70SUkiRf9chVS/i3pjSTjLIwQVnvI0zw==
X-Received: by 2002:a17:90b:1953:b0:29a:bd5b:380e with SMTP id nk19-20020a17090b195300b0029abd5b380emr3125221pjb.4.1708980648160;
        Mon, 26 Feb 2024 12:50:48 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:7f8:2861:5237:e7a0? ([2620:0:1000:8411:7f8:2861:5237:e7a0])
        by smtp.gmail.com with ESMTPSA id ta5-20020a17090b4ec500b0029a849e7268sm6402059pjb.28.2024.02.26.12.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 12:50:47 -0800 (PST)
Message-ID: <9a0f534d-0251-492d-b7f9-30926e037c57@acm.org>
Date: Mon, 26 Feb 2024 12:50:46 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Fix libaio cancellation support
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240221-hautnah-besonderen-e66d60bae4e6@brauner>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240221-hautnah-besonderen-e66d60bae4e6@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 01:26, Christian Brauner wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
> 
> [1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
>        https://git.kernel.org/vfs/vfs/c/34c6ea2e3aea
> [2/2] fs/aio: Make io_cancel() generate completions again
>        https://git.kernel.org/vfs/vfs/c/ee347c5af5be

Patch [1/2] ended up in Linus' tree as commit b820de741ae4, which is
great. However, I can't find patch [2/2] in any vfs branch nor in
linux-next. Did I perhaps overlook something?

$ git branch -r | grep vfs/ | while read b; do PAGER= git log 
--format=oneline origin/master..$b fs/aio.c; done
83c671617c943c7e369de96d95cc94739d42bcca eventfd: simplify eventfd_signal()
1c146b0406bddf3769705e4cd31a422a6564ab7b fs/aio: obey min_nr when doing 
wakeups
1808acc4fab22bed2f259dcdbc3138333caac676 eventfd: simplify eventfd_signal()
6e44f043186bf108c353353acc21adca4c3d73db fs: introduce fs_supers_lock

Thanks,

Bart.

