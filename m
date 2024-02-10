Return-Path: <linux-fsdevel+bounces-11053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933CE850579
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 17:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D70285E70
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 16:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B3E5C918;
	Sat, 10 Feb 2024 16:55:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA5539ACA;
	Sat, 10 Feb 2024 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707584148; cv=none; b=V75KDCMZwfuUBDriT7PY/JMQeWijiQhadvpchGwIu/5A/BsYstGqIO9Rb/burj6Z/+9R0SLqtVgVsM0uoYc9yAHsiDLMfNWAL8bfyiuW3tjfivSsN0Hg/hLn3f/V9c2GMJr5Jv69i6LEyyiEAYsQiWRg5YmHqw6uKtZ9Q+xgvZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707584148; c=relaxed/simple;
	bh=/ApXomi0/8JKhyR2ADsF4R8Vy9yMVYlz+v5zz2OZtDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SadMXOo0i+jkF1gOQ9x/4k2/ZFbRt8ACXawX2JebrgCwt+0es6fnYkDD9tXisI3xRShmqRArJGv5V4b1TtJiaRYtTnG3poiFATe2dsMCrZGQ9rtmIWHQ2yRsVOB9DP8KNxWTDpRt/l6QUhDAaJ+TtKgWiZOQbG9Npz3Mz94fWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7431e702dso18183355ad.1;
        Sat, 10 Feb 2024 08:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707584146; x=1708188946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X2leUJquGAS3T/lK4j1j+pzSXbxqTub1o2Ka6/pvtPQ=;
        b=cW7A7Inb1M1jacLQJpdtJqPh5QjHU6HdUYTzGYw0bn0ADqB1UT0+7f0sszEIWXpijp
         LxEdjLWdbRx5xVQlUSQCFVinAp8BqLZqaCzQ7Tz7HO1/HAB4MZVmhFrA0DlhLUSglvQw
         YE9GxWwrCtY6KxB/c7/2YNs7iccOOKDUT6ZV0y1aqAqCFkoKnKJRZaKXt1/IoArAN05g
         lCReY5rbws+88Y89z+nJjSA2w4mdVj8Y5SYrODlHOMPXc2P0EjxhjDEofTKLRG+m5zBn
         b08LdWaKS/KYu/Pi2AyfhLXUDcyqlWDl/+f1mj9uOo32duYjk6yPBH+ZuGc8eUB/13JW
         bmvQ==
X-Gm-Message-State: AOJu0Ywd9ja2hap/9D2cMlXo9ZrIQfKI1Vjk4gPOtmccQBxT+3mFdIc5
	dmdXpyhfMOv9QXSvTfqVGOM9/Qtp5ErsTeEPFyyGFVH2hwEOyj5v
X-Google-Smtp-Source: AGHT+IG5ykGOVAchSHKQdBC8A9ytcJvwovwSiOIhuMxyUZCJwbSguGp1FMauXxpD/JBAzLcG2YXaHg==
X-Received: by 2002:a17:902:ec8f:b0:1da:e86:3d9e with SMTP id x15-20020a170902ec8f00b001da0e863d9emr3424416plg.43.1707584146353;
        Sat, 10 Feb 2024 08:55:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX50jHsg4IyXpACTu0GshmsSgXOQj7zh3wI+AhDLwpvcjBY0V6lRSwgnHV6X+CyhqA45vzvR3rlCgB/0MsuJHjeRH9j9dCXHCGo5wtAn+63UqjEl9mR+QmMipF38WVJiQmJjXnCIunZ0E5I/YCdFuqWuuh66MGh3DUt4wpm7ByL9FB96YricUZIaJPWrH9rSX5zAzcUzew0Ty4eZhgmrR2th/xY6IzpQ4Re96YisCVUZGDkHqlRsJ/nzYAuwC2j3Yqm
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902c74d00b001d9412c8318sm3264272plq.25.2024.02.10.08.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 08:55:45 -0800 (PST)
Message-ID: <e955c7c5-019a-41c6-99f7-f8e3dbee652d@acm.org>
Date: Sat, 10 Feb 2024 08:55:44 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs, USB gadget: Remove libaio I/O cancellation support
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>, Jens Axboe <axboe@kernel.dk>,
 stable@vger.kernel.org
References: <20240209193026.2289430-1-bvanassche@acm.org>
 <2024021022-ahoy-vintage-b210@gregkh>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2024021022-ahoy-vintage-b210@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/10/24 02:20, Greg Kroah-Hartman wrote:
> On Fri, Feb 09, 2024 at 11:30:26AM -0800, Bart Van Assche wrote:
>> Fixes: 63b05203af57 ("[PATCH] AIO: retry infrastructure fixes and enhancements")
> 
> I can't see this git id in Linus's tree, are you sure it is correct?

Thanks Greg for having looked this up. I had not yet realized this but that
git commit ID comes from a historic tree. Is there a standard way for referring
to patches from historic trees? See also
https://stackoverflow.com/questions/3264283/linux-kernel-historical-git-repository-with-full-history

Thanks,

Bart.


