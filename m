Return-Path: <linux-fsdevel+bounces-34228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D299C3F02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 14:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CEB1F23CF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8216219F48D;
	Mon, 11 Nov 2024 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="NJu89gx2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794719F47E;
	Mon, 11 Nov 2024 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329746; cv=none; b=HRTAOWtUY3HxiiBjWtOAPOwtUXRFViDtNtsmTZSMbykqV50NAtmFhiykDSEFZFZdXSOdm4uQ+NcMHRgHafrTA0LvH3N1mE8bl/jF7+PGwtEMDpVm/SFakNPWsv7biEVGxEDG8M/bhJdjQItiLMiPC+UXjaB5M/g0RboCCJO2jlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329746; c=relaxed/simple;
	bh=qRe/F76H/58frwLfvI3LBKbI4uSiq7qspmyH+LRyX1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHGVzkCzPxvDbzZi7EPKdiHTswzQGaHYTck6xbELVEuD8WZ2beCJKOpUqpJub+SD7VwrOgvINFJp8J7HAxu6gqTvXuqgAC93DUbgDUSS5emnsw/o0XbRsWnM+/xQxDu0t+VK3YqnfOKgzMiCQu9djjRYWezOwR6qgSaxqAl6BKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=NJu89gx2; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=qRe/F76H/58frwLfvI3LBKbI4uSiq7qspmyH+LRyX1Q=; b=NJu89gx2+QbjuwtdHd17k4ai9q
	+/mCnxFmT47or1dA7jWHUZtWJsdX0PD0TFI4RN9AQVDtJuehuwynkaT5lM5Tjtm6nQPno5t+AxXD6
	8E4jRIL4ctIwjby6fPZSHSoutH12csjdrVU9xG/6NRYYyOVYx/X+VmPy/FiigqWkE3GJqv2h1SWFu
	xk6GqjOEz15jdGReWm2REPD8WgFQ9Am/z2oimu01PcuAs4+v92ep08qVtSKauUGVWxsOSylE0CMO9
	XOgfC1p3Pf9/+4LJOYJ8LLAfbUxqwnbsHVMXpd8YEYYgOrKjlfvE8tIKxGClb/xzPkRsYow/uFtEm
	WmpPDA6tAat3EyrLykEb2AaOvibgdP8ah0Edq+uP2ELa1sU0K/1fHVsFfMgr9j2JRcnv6N+sCXcGh
	8ek1kyBccTH7aSzZaTbmdRVQB5WmEIQXYstU4fKthxdbLw62gsv/RD2h1tvZTMoTOpuL2D/rwF3xC
	LPLF2mfvZHvnALrG9qjr/g2e;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1tATxD-00A3CN-1S;
	Mon, 11 Nov 2024 12:55:39 +0000
Message-ID: <63af3bba-c824-4b2c-a670-6329eeb232aa@samba.org>
Date: Mon, 11 Nov 2024 13:55:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v4] Uncached buffered IO
To: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
Content-Language: en-US, de-DE
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20241108174505.1214230-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jens,

I'm wondering about the impact on memory mapped files.

Let's say one (or more) process(es) called mmap on a file in order to
use the content of the file as persistent shared memory.
As far as I understand pages from the page cache are used for this.

Now another process uses RWF_UNCACHED for a read of the same file.
What happens if the pages are removed from the page cache?
Or is the removal deferred based on some refcount?

Thanks!
metze


