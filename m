Return-Path: <linux-fsdevel+bounces-12272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C324885E04E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 15:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C189287AA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044157FBBC;
	Wed, 21 Feb 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="fR86PDMe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA447F7EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527157; cv=none; b=eEoQ4xAyYkRD+6yjTznfw9R9zv6G4jhJkTsZzdi7sXpNk1rWCLr95LLkPciwoe7+1yTvbF4fHx1jcP8Z0bBpj3fWx/NusFD89zhFYmD1IL2q2W4BNOrLq0RZQtrIe5bsRHAaqqSac9GEKp5t6WH91OYo0Kxs22LWFY0pkplnRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527157; c=relaxed/simple;
	bh=XpMr2CVdO4a5ptX/v2tBGSXDMcDtAcswnc3QT+w9wtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7BEIJ+256O23CVtPFAf2LZCRTIudJaOE2Z3j5WR8Oyjcd74s9HBRKTzQjskk5YOm5GsGPubgYd4o1lAYh8sByYj37pK1Li8x7rP0IOOX/HApXBwd7OGzW4Fuf0hpfyIvlxBTrfWdxbv7/VV/Rr4UnWAL6WPchEB0mZvrcl60tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=fR86PDMe; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 3B4AD1738B8;
	Wed, 21 Feb 2024 08:52:34 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 3B4AD1738B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1708527154;
	bh=pLD6bbxS3H8TXo+EpPCz3U8NICC08hzCKn47x80kYPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fR86PDMev+2219HohblgGb/D76H2jOXv87gwMbnHeMp7dQkA3w3edBRHWhqfaH2Zl
	 RCrQiGtLsd/ZQNoj2GAcklxdUyZsYoIC7JbBdO53kVN20iUvKrdG6wj5NxtIndBY2z
	 nicverfiJRj3Qb+knBBWucNWy+weQ5xOO4kIBlQQTkJNo/SNH+OHOELM8XY9qJk+fq
	 W9SMFVipoB8cuzestEY9ov9qzgqfF88+3cXV4yhNhlgMB9XxiapS5mm+Qoh4GKJm02
	 J/zpy4yYYwjLkTxX9U7JFLXNlAqUSe+TicOqfTuci1knwi47PVJcskyHEw2C/D7oYz
	 6ZKEMOENngVkg==
Message-ID: <3f5ed838-17c2-4a2f-b46c-658cb5b31718@sandeen.net>
Date: Wed, 21 Feb 2024 08:52:33 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Convert coda to use the new mount API
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Jan Harkes <jaharkes@cs.cmu.edu>, Bill O'Donnell <billodo@redhat.com>
References: <2d1374cc-6b52-49ff-97d5-670709f54eae@redhat.com>
 <20240221-kneifen-ferngeblieben-bd2d4f1f47db@brauner>
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240221-kneifen-ferngeblieben-bd2d4f1f47db@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/24 12:23 AM, Christian Brauner wrote:
>> @@ -313,18 +342,45 @@ static int coda_statfs(struct dentry *dentry, struct kstatfs *buf)
>>  	return 0; 
>>  }
>>  
>> -/* init_coda: used by filesystems.c to register coda */
>> +static int coda_get_tree(struct fs_context *fc)
>> +{
>> +	if (task_active_pid_ns(current) != &init_pid_ns)
>> +		return -EINVAL;
> Fwiw, this check is redundant since you're performing the same check in
> coda_fill_super() again.

That's an error on my part, sorry - David had it removed in his original
patch and I missed it. Would you like me to send a V2?

Thanks,
-Eric

