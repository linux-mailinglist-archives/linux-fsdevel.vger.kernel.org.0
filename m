Return-Path: <linux-fsdevel+bounces-13498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F6D87086E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A47B239A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 17:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D116612F6;
	Mon,  4 Mar 2024 17:40:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76845942;
	Mon,  4 Mar 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574038; cv=none; b=TAZqSr8DBndGaHQIETl6zvhrEqO8046Jl6hEaHryyex5+2qVGeedHIq28PnCVms8umqSoKuxpihwbqayvePKbRNiqZqtTQTxgDREcueHXWz/jcrQSLsPTxoZe00vdT+OXUwIig4PTFkhyrVF8D/S3MZTv39Qy80GbFN6AtdmkNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574038; c=relaxed/simple;
	bh=X/Ethjfe+JY3oNLWV/PNylcKo8ikihPe+TaMsAbUXVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuTZLqrsGX3+ypHQlPMeD0GNoe/lBLWlcws5OcWkWk/hpShzURXVsTHJxkhhLgFEtpkAel8NltJdCSzVcrUYHgaBoRgyptHV/5blyC7sQz2zMuuwpiYnkBqcgvXGg7DHfvRzRVSYF7iL/O4Dtni7OSrpvAD9bi99nySWjCt7Cxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dd0d46ecc3so9920605ad.2;
        Mon, 04 Mar 2024 09:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574037; x=1710178837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/Ethjfe+JY3oNLWV/PNylcKo8ikihPe+TaMsAbUXVw=;
        b=ZwlJBBDD2On4AUgBIC4qx2I5Yw8o356to/ijyueE79Ardk4LgcHzsVGg6AS377WA5L
         nfkVpQ54YhzoJJbRL1B4j67Y1qpEAQPOfL16ef4zXvo8tGetyYGNR6Ulz8nS669ndtys
         DxLugOiLqlq+UKOGSjrwRS9ygG6AHJ2fxcIwqpoDcktxT4r1pCEY74SZft9qef8Q9aSE
         Spgp0jj6IMcl8B0OHydZcouOXtW3yAFxkCrxyymZ/b+ML5uMJzBQ2W6oytx3VeVh4XQj
         mwfX4PtmDTFkc/duFj0vX66Er0rcUnzAfB0kPwyDZyZVfn47y3Fx0xvoghVwIFiyW4Vf
         yv0g==
X-Forwarded-Encrypted: i=1; AJvYcCV1wkmz7LHIfUOo0IEcMbUnE2hnanQ3hOuv2z9RCOQEq307D+ycmIApROeJbQUSb8ZGQj/+6XjTG30xuTn4OmOWrKQ4ctGkoDPtJnGdDQ3eRxOPSynvZ7UGtlfacscr7w+LjNLl3F4tq/zrhQ==
X-Gm-Message-State: AOJu0YzZmpnNYGtteHi9J/tyumW+AStTusvPQcEn4gXF+GLqqWaup5NT
	EFvl2qpKx8n/h8ELXC4i24nEpXU84BiSq+Cdyt0nlFs6ZrPgH9UNb4PFQzGO
X-Google-Smtp-Source: AGHT+IGu3LDThYeYk4PX+avPOIf1uV1UhQlneWUKBbsMXYIPqC+Zl7ZPTjFlYIhMhWIO6PhHXDbB7Q==
X-Received: by 2002:a17:902:e5cb:b0:1dd:138:4e0b with SMTP id u11-20020a170902e5cb00b001dd01384e0bmr7646451plf.40.1709574036633;
        Mon, 04 Mar 2024 09:40:36 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:9ba8:35e8:4ec5:44d1? ([2620:0:1000:8411:9ba8:35e8:4ec5:44d1])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b001dca68b97d3sm8778640plh.44.2024.03.04.09.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 09:40:36 -0800 (PST)
Message-ID: <5ee4df86-458f-4544-85db-81dc82c2df4c@acm.org>
Date: Mon, 4 Mar 2024 09:40:35 -0800
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
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240304173120.GP20455@kvack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 09:31, Benjamin LaHaise wrote:
> A revert is justified when a series of patches is buggy and had
> insufficient review prior to merging.

That's not how Linux kernel development works. If a bug can get fixed
easily, a fix is preferred instead of reverting + reapplying a patch.

> Using the "a kernel warning hit" approach for work on cancellation is
> very much a sign that the patches were half baked.
Is there perhaps a misunderstanding? My patches fix a kernel warning and
did not introduce any new WARN*() statements.

> Why are you touching the kiocb after ownership has already been
> passed on to another entity?
Touching the kiocb after ownership has been passed is the result of an
oversight. Whether or not kiocb->ki_cancel() transfers ownership depends
on the I/O type. The use-after-free was not introduced on purpose.

Bart.


