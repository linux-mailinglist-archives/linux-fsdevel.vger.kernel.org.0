Return-Path: <linux-fsdevel+bounces-7806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501B382B346
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 17:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754151C26BA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB951004;
	Thu, 11 Jan 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Hth6fwN7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28958524D2
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-360576be804so3341875ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704991570; x=1705596370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZPcHTcItQjzr4WGB8fZNqvF0vIuFiWGljs4FO68GSw=;
        b=Hth6fwN7/2tuWuOy6+55B0RsHGTxg8dJV77e+h2OrdQJ4bhz2zyg+vKJBU9lFtNf3F
         2YinD3bMyywXqSmhoByVV92vhxdQI997tewnGUhoetLex/Gbw8tk7/LIfUMAnB/UrSEW
         8lJrrL70gAESbz2I6pDz7q066ggzFsVHsRT/az3gXbXfEsNM0OvbtBSpWeMNmu+1+YIb
         tUkeD4LY53ujWlCgY5DnG8llxbQKWN+LXVp0NSaWp3oKf5k0ovxsiKsnL7LskQ+5Bz39
         AMTSB0xeDVKsjI1CoCP+n1t0PWau5PL05dmuNd4YxRE0rF3a7cWcX0JUx0vmy7YuuGjD
         +0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704991570; x=1705596370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZPcHTcItQjzr4WGB8fZNqvF0vIuFiWGljs4FO68GSw=;
        b=TmqTogvJXVx16LR3V39ska81et9b2NxWAgm3ngx19AxzUL3VbltLV8u5ykbFlwDeMK
         XjAZlhRVx4fHCqi9A3HvDDtdVFp9vmUeArI3fvSYgXcKKb6wFv4beY7y6Dx/BoxmZ0mF
         oCcHfpxiXA5+F8T3mhQnMcBU5ncksR9mVb96NgJIWPdKGjvNuDs9iJQcfsegp0SNbFBc
         KGf7MDdrdYLa2fxnOz1dnRuV85p4zUqU62F7ezc+FqzpE6+Mywwvmgi54JW8m9IGMZje
         Bsy882CtMFoihOL55GbbG3XBMg2fOMsSwWXSYzFT4I5Ec2EOzFLGdYI2g7ZpIvH+uaFw
         zM/g==
X-Gm-Message-State: AOJu0YyhJgFqseJ7h7xRXIqySueGU8HzQM2B2hIYOhVZT/f6lYsAw+U6
	anJL59aFnEb47O0ZS6rAhV6FMOS9AVJlOykLjSaBf+OsUQM12w==
X-Google-Smtp-Source: AGHT+IFLyOsPiRC1dMm1y21fDCbR4LfnBKhm7E7HU5FD4A8p1qzCcxKggorRsZe9PFrx3kFCgLHxDw==
X-Received: by 2002:a05:6e02:20ee:b0:35f:f59f:9f4c with SMTP id q14-20020a056e0220ee00b0035ff59f9f4cmr3087697ilv.1.1704991570106;
        Thu, 11 Jan 2024 08:46:10 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8-20020a056e020ca800b0035f75e80d1esm391301ilg.52.2024.01.11.08.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 08:46:09 -0800 (PST)
Message-ID: <7be392ea-a622-4195-980f-9edc5497802b@kernel.dk>
Date: Thu, 11 Jan 2024 09:46:08 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2] fsnotify: optimize the case of no content event
 watchers
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20240111152233.352912-1-amir73il@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240111152233.352912-1-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 8:22 AM, Amir Goldstein wrote:
> Jens,
> 
> Can you take v2 for a spin with your workloads?

Still looks good from a performance POV, same as v1. No 6-8% of fsnotify
and parent CPU wastage.

-- 
Jens Axboe


