Return-Path: <linux-fsdevel+bounces-39476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D42A14E08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 11:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF05A166F1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 10:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D3A1FCFE5;
	Fri, 17 Jan 2025 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="Vw/TBJFa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3951FC0F8;
	Fri, 17 Jan 2025 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111312; cv=none; b=tua/8tVdLUUmhngoEBbGndGvPQNfIT6DtUBppBO4WjiaCx2sU2H3wR5P4HkI0xLWiObdZXjLQng4qW7KeQ4No+QJ6nuPyXDmbGIrifCkqZdmpYQwyAGUQ5gtveSS81/cJYZZ+Yba4+rE9IJsHCHRbDUSFO5vidxFfCKDdFbAxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111312; c=relaxed/simple;
	bh=FBzsdBIU6YumukfUbJWK1ggJJP5iD4qS7v04qulwPaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2//jdeg78plgblLNgmy2L1mm1liX1StFAkRuggFF1GGkW1P01aN7mmqMmTG7FbRxEpXCnhCH+x0r5phjgG1q1bAhRrpr7wQXu0kxBww8TK6JLzcg9dp9eZh7RBLk2cWUMiNxp+ZBpn5hLr85uw4HIA3a8DFyAEm1eMzZ1xAw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=Vw/TBJFa; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id D58AA1C000A;
	Fri, 17 Jan 2025 10:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1737111308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBzsdBIU6YumukfUbJWK1ggJJP5iD4qS7v04qulwPaA=;
	b=Vw/TBJFawwg898J6COZc5ljKY4LDa/TcrvcYPaMJSQETkVfnwDM8S7sbbNXySlBy9odDrq
	NDX8oPvHVqo01h6sZUtPiqxR/0ebYy/uV76ghW3S5lItDkwAi4wlH/PwDk/Eq8DKCCI0Ai
	59VIP2TxbfIRG6xzBLMmke1Wbv3+xLCRfglPbedZbaJVixtZGHawrCOtW9fCjSp3FB9weC
	cv9f2oPmtBMWQBDtXPOek+PhB6I4Ol3Qnvp/LVuraibLLt1FDskepB5wqboJPdI+rgEZxY
	WFq8SuqpLyvOECrksKAozreGD5/gru+syEtaVi4e0YrisxrBBzo5P08gpgK85Q==
Message-ID: <fa77cbf8-9f69-4dbe-8859-6ca5abbaa9f0@clip-os.org>
Date: Fri, 17 Jan 2025 11:55:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] coredump: Fixes core_pipe_limit sysctl
 proc_handler
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Luis Chamberlain <mcgrof@kernel.org>, Joel Granados
 <j.granados@samsung.com>, Andrew Morton <akpm@linux-foundation.org>,
 Neil Horman <nhorman@tuxdriver.com>, Lin Feng <linf@wangsu.com>,
 Theodore Ts'o <tytso@mit.edu>
References: <20250115132211.25400-1-nicolas.bouchinet@clip-os.org>
 <20250115132211.25400-2-nicolas.bouchinet@clip-os.org>
 <202501151630.87A0A8E7C4@keescook>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <202501151630.87A0A8E7C4@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org

On 1/16/25 1:32 AM, Kees Cook wrote:
> On Wed, Jan 15, 2025 at 02:22:08PM +0100, nicolas.bouchinet@clip-os.org wrote:
>> Any negative write or >= to INT_MAX in core_pipe_limit sysctl would
>> hypothetically allow a user to create very high load on the system by
>> running processes that produces a coredump in case the core_pattern
>> sysctl is configured to pipe core files to user space helper.
>> Memory or PID exhaustion should happen before but it anyway breaks the
>> core_pipe_limit semantic.
> Isn't this true for "0" too (the default)? I'm not opposed to the change
> since it makes things more clear, but I don't think the >=INT_MAX
> problem is anything more than "functionally identical to 0". :)
Uhm, I think your right, its seems to be functionally identical.
0 codepath slightly differs from > 0 though since it won't trigger
wait_for_dump_helpers().

Thanks for your review,

Nicolas
>
> Reviewed-by: Kees Cook <kees@kernel.org>
>

