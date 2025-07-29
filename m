Return-Path: <linux-fsdevel+bounces-56278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F0AB154D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 23:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981954E4A21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 21:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE184279358;
	Tue, 29 Jul 2025 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="Xv9tbmhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00ED22FDE6
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753825751; cv=none; b=eVJXBYx2KsBqZs6LhIy9ALT1N8kqI8MWIvLFVyJYqp6fGwkF5C9FdD13Ht4lmo8hrWI4SFMwG7/tUEpXjZDHoC4TIZ6uUAVIK4Y+iZxtfW1jvn1WCQCziwC/9AqttQ8h4nCgvlWiMV25L8UwmDcEYVTBaAiSJIvnFX5nTwK+68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753825751; c=relaxed/simple;
	bh=geL9Ftjhdqd9egcM/lHhi25CiP49eRIwJI76CvTYyZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwYGkDXQnslE/LvWICoWLOFPCdVw6E031R7qe/vS/9HVGX1FqwvPdb9MNTdHDY0jW778eOmaAUN0mLOYaOhyXxfeTgg9opURPyW944Y6zTE8D7v59fTS5kcMZzU18turQUBZTARvGm9uZvOFxDbxmM+QttOWinuFsjJrOAysSDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=fail (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=Xv9tbmhk reason="signature verification failed"; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id fs1NZj9U34EIeUGl; Tue, 29 Jul 2025 17:49:07 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=AYKmDyN4bYXhwJrjzg9T8Cn2Ox5lAXwONinxtJCgb5o=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=Xv9tbmhk6jhNYTtkhXLz
	q+Wh6k31x8gi5fM2VMM/Suipsu8NeuQBqISUezcnE21Cc1s9YNYjmURHVVjptPaecy9ux8KZsupPt
	KtPJbI6wrCr3lgQC9MK75+uZCsm56sG7Yw8rHFmaMlPw18qlggJz+67jrzvUZmBfbyLl7PTPS0=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14114358; Tue, 29 Jul 2025 17:49:07 -0400
Message-ID: <b6af511e-9128-4775-8994-9bbaef3465a2@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Tue, 29 Jul 2025 17:49:07 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] md/raid0,raid4,raid5,raid6,raid10: fix bogus io_opt
 value
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 1/2] md/raid0,raid4,raid5,raid6,raid10: fix bogus io_opt
 value
To: yukuai@kernel.org, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-raid@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b122fa8c-f6a0-4dee-b998-bde65d212c11@cybernetics.com>
 <3660751f-e230-498c-b857-99d61fe442e6@kernel.org>
From: Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <3660751f-e230-498c-b857-99d61fe442e6@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1753825747
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1280
X-Barracuda-BRTS-Status: 1
Content-Transfer-Encoding: quoted-printable
X-ASG-Debug-ID: 1753825747-1cf43947df83540001-kl68QG

On 7/29/25 12:56, Yu Kuai wrote:
> Hi,
>
> =E5=9C=A8 2025/7/30 0:12, Tony Battersby =E5=86=99=E9=81=93:
>> md-raid currently sets io_min and io_opt to the RAID chunk and stripe
>> sizes and then calls queue_limits_stack_bdev() to combine the io_min a=
nd
>> io_opt values with those of the component devices.  The io_opt size is
>> notably combined using the least common multiple (lcm), which does not
>> work well in practice for some drives (1), resulting in overflow or
>> unreasonable values.
>>
>> dm-raid, on the other hand, sets io_min and io_opt through the
>> raid_io_hints() function, which is called after stacking all the queue
>> limits of the component drives, so the RAID chunk and stripe sizes
>> override the values of the stacking.
>>
>> Change md-raid to be more like dm-raid by setting io_min and io_opt to
>> the RAID chunk and stripe sizes after stacking the queue limits of the
>> component devies.  This fixes /sys/block/md0/queue/optimal_io_size fro=
m
>> being a bogus value like 3221127168 to being the correct RAID stripe
>> size.
> This is already discussed, and mtp3sas should fix this strange value.

Thanks, I will follow that ongoing discussion.

https://lore.kernel.org/all/ywsfp3lqnijgig6yrlv2ztxram6ohf5z4yfeebswjkvp2=
dzisd@f5ikoyo3sfq5/


