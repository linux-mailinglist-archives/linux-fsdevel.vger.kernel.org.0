Return-Path: <linux-fsdevel+bounces-31716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5548899A572
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00A11F25804
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9621949D;
	Fri, 11 Oct 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOoYVCGz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102E218D85;
	Fri, 11 Oct 2024 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654695; cv=none; b=gJ+yp5/F4uajDXkfZt7ZMOHeuSOxEe8RvssCVLx0PzG2F6wx5P6N2ceOWycrBiIWmKIKBO/XqO2l+UXfO9HVuP69P5qYl3/xxdkikC91baqJYKnYdOcnrJFuQf/GOILqi+5/MV50lwI6TlIGKzsbzytHfyPuSevtWI7l3SjlWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654695; c=relaxed/simple;
	bh=w/9I9oR+tCtf8XejSYH+CNdH6JiviGudQ6e3P98frT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvL7K0OIKJtxA6GcnlbFFx6sAwLSYD8E7mRuVftM1XHUCbVUWLMJzGVuNZE52PHCnVzxpNj4u3GhJ8EOBeYY3AxJZrOnuXBCFIbR+XAfm4byxl1vwT9W4T9JITUj6mlFR70sNQC0l/i+lYkPXX3v9nr0dPGvDAYxoTY722wC9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOoYVCGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE97C4CEC3;
	Fri, 11 Oct 2024 13:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728654694;
	bh=w/9I9oR+tCtf8XejSYH+CNdH6JiviGudQ6e3P98frT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOoYVCGzEPmCmKDJyWEsx6T/OE8BZznnFyXiwXZqDen93w+RefmXMBpRRr1ofqp61
	 JiO+u0i2yeg3c/IDQqd9porY6ZjioS8RQGVvMhXjUDCxeAiFILPgsQxNG5YoH7dOBg
	 IauOnc3jJ8dwhMzPFuSY7pS/Y/RG3pls+5gGhJZLf9SYeHukkSci6OZK9NbLFnp1Eo
	 YfWNHj29wJQP1DnLpUww8vBDPd2eh4iCvh4j/WNwNgutEWFS21cq5HcIftrplebnN3
	 booiXbcXwVjrjLC0B/nDmxst2MQ+DE3sreBdg+DazyczQAwmHXE8oznK/6KYdD8Vo0
	 zTR34eLOz5uCw==
Date: Fri, 11 Oct 2024 09:51:32 -0400
From: Sasha Levin <sashal@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.11 48/76] fuse: allow O_PATH fd for
 FUSE_DEV_IOC_BACKING_OPEN
Message-ID: <ZwktZCHlm1G3Uh9D@sashalap>
References: <20241004181828.3669209-1-sashal@kernel.org>
 <20241004181828.3669209-48-sashal@kernel.org>
 <CAJfpegtNF6CkSsE7yWq8-4W7HP3aOjE4xnAzJp0uiU-S7Wb8pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJfpegtNF6CkSsE7yWq8-4W7HP3aOjE4xnAzJp0uiU-S7Wb8pg@mail.gmail.com>

On Mon, Oct 07, 2024 at 12:15:45PM +0200, Miklos Szeredi wrote:
>On Fri, 4 Oct 2024 at 20:19, Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Miklos Szeredi <mszeredi@redhat.com>
>>
>> [ Upstream commit efad7153bf93db8565128f7567aab1d23e221098 ]
>>
>> Only f_path is used from backing files registered with
>> FUSE_DEV_IOC_BACKING_OPEN, so it makes sense to allow O_PATH descriptors.
>>
>> O_PATH files have an empty f_op, so don't check read_iter/write_iter.
>>
>> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  fs/fuse/passthrough.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
>> index 9666d13884ce5..62aee8289d110 100644
>> --- a/fs/fuse/passthrough.c
>> +++ b/fs/fuse/passthrough.c
>> @@ -228,16 +228,13 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
>>         if (map->flags || map->padding)
>>                 goto out;
>>
>> -       file = fget(map->fd);
>> +       file = fget_raw(map->fd);
>>         res = -EBADF;
>>         if (!file)
>>                 goto out;
>>
>> -       res = -EOPNOTSUPP;
>> -       if (!file->f_op->read_iter || !file->f_op->write_iter)
>> -               goto out_fput;
>> -
>>         backing_sb = file_inode(file)->i_sb;
>> +       pr_info("%s: %x:%pD %i\n", __func__, backing_sb->s_dev, file, backing_sb->s_stack_depth);
>
>That's a stray debug line that wasn't in there when I posted the patch
>for review[1], but somehow made it into the pull...
>
>Since this isn't a bug fix, it would be easiest to just drop the patch
>from the stable queues.
>
>But I'm okay with just dropping this stray line from the backport, or
>waiting for an upstream fix which does that.

I'll just drop it, thanks!

-- 
Thanks,
Sasha

