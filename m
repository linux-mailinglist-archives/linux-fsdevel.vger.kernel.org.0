Return-Path: <linux-fsdevel+bounces-7663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1CE828E63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 21:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BB81F258A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 20:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB813D57D;
	Tue,  9 Jan 2024 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mMu/9PtR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2223D577
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7baf436cdf7so33889039f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 12:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704831157; x=1705435957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Migbm9OwYD2CJswvwmJTi3D+AqAu3Eiue0IQswcdB6A=;
        b=mMu/9PtRPkXCxGXQH1faNmwmXhydd+mtjsYYdhhEZEuBJUurZWReTE7j+1VZC7pYdJ
         jI6VWlOMVtoiOySIw20uzrSIYbLihGrfwgKRTBSHHfWxFz6FZMvANE/Y1EoKbGiNLEfJ
         F5kiQJLEKfqUer/BeDKRWPDkfJ6Xg85XpOXCykyXD/Ous2Xgh2DhSt5Oy9RuPiQ7siV7
         VX8UDD121IoY8Q7m4a+6wWS0DcaXlqfreSgWl7GU9sgPVSV6rtvH1UMQt+oxoUgFew7+
         6lXQLm6dWx5eg2pxsBMAOcfXhIIvCH1qzCvYnLxC6ni8zoERXkT5eEDOP5+ia24VDgGh
         y/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704831157; x=1705435957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Migbm9OwYD2CJswvwmJTi3D+AqAu3Eiue0IQswcdB6A=;
        b=U7ra7L06FudIvTneiWfd9m6mY0OaK1w7p8BZlOqRZQ3HNMZCMs8rw+OOq+RVdIoBPW
         N1EfFg2H5Oi2cgU09/5TgqxND8k5Lt8DulNt4xWCUF7G0sNq+y2UQLqOKi7ou+nsic4k
         +FLP1+Qv1z/vPiMSuEQywv46/Yht/YMozTIYGa3py753wNzLj0IGrIW78bOJiMbHUSUN
         kYKJkwGYRIOVrni0LZz+NRwtzrdrZq+D4R8B+GqxbXNvYvuo0vQWJjFPHznGguyOfbBX
         y+Q5YETe0vZInDDyqcpuMcro3CwhX7LTKnUjKE3yPRwPFLkuO7o8b0Dd2m5A5puA8Kmw
         ak+w==
X-Gm-Message-State: AOJu0YzrQQJoFIqo+4amPGeHKvUXU3mdi63eSTPArILJ0ncvPxi4zskY
	QEzEtG09RZmTWTx0dvFzhC4bgTNYfmozjiaEsWUFhqAFSyitJg==
X-Google-Smtp-Source: AGHT+IHHI32zwXTb/q9ZqjzKZPnWSnd2bIKIhncEFnO8y8m/hzpX56roqPXz5X3f2Tx3gRZ0eATH2w==
X-Received: by 2002:a05:6e02:1b8f:b0:35f:fa79:644 with SMTP id h15-20020a056e021b8f00b0035ffa790644mr10822344ili.3.1704831156931;
        Tue, 09 Jan 2024 12:12:36 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bs9-20020a056e02240900b003607db093bbsm792389ilb.76.2024.01.09.12.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 12:12:36 -0800 (PST)
Message-ID: <91797c50-d7fc-4f58-b52a-e95823b3df52@kernel.dk>
Date: Tue, 9 Jan 2024 13:12:35 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] fsnotify: optimize the case of no access event
 watchers
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org
References: <20240109194818.91465-1-amir73il@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240109194818.91465-1-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/24 12:48 PM, Amir Goldstein wrote:
> Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
> optimized the case where there are no fsnotify watchers on any of the
> filesystem's objects.
> 
> It is quite common for a system to have a single local filesystem and
> it is quite common for the system to have some inotify watches on some
> config files or directories, so the optimization of no marks at all is
> often not in effect.
> 
> Access event watchers are far less common, so optimizing the case of
> no marks with access events could improve performance for more systems,
> especially for the performance sensitive hot io path.
> 
> Maintain a per-sb counter of objects that have marks with access
> events in their mask and use that counter to optimize out the call to
> fsnotify() in fsnotify access hooks.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jens,
> 
> You may want to try if this patch improves performance for your workload
> with SECURITY=Y and FANOTIFY_ACCESS_PERMISSIONS=Y.

Ran the usual test, and this effectively removes fsnotify from the
profiles, which (as per other email) is between 5-6% of CPU time. So I'd
say it looks mighty appealing!

-- 
Jens Axboe



