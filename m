Return-Path: <linux-fsdevel+bounces-36990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557C99EBBA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 22:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3A91887A89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 21:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3378223027E;
	Tue, 10 Dec 2024 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ks6wF4WD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D55A153BF6;
	Tue, 10 Dec 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733865135; cv=none; b=nwGJJ7xiqZYddqyGlqeOB7LfdguCv9K4fF8BkOWl4sJdVC6N6OgqmeHVCWv8U0am7rR0p0OiwZjQzViNFSAuSN8ZQEPumze8x2FhHV8DWUY98JC7UDooibD9FzE9GGBJHRCFh8Gf7KLjJQ+QSVdvPqj2kxWKQ3SUlXmZhjlQZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733865135; c=relaxed/simple;
	bh=dyZtB26aExN1AXnqAq5HefDzn3mHyrfChTdtCAd/lK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d/Qr01vo7zcxIbPiyRH3cqIDOroCYbGGZ4kxxEeJOL0oR5ZhIdvzsYwG0oOchextjqEuQIsENS54SQO5GrkNVUZ9L2qTfWooTkPpI1ul3syt/T8uPIylCfdNZKdDWsT5k4P0zn5I4qn+OjjEP+n4ZgN1/PpnG5+bvkuYEwj+uoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ks6wF4WD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=pWl+DoLp0B19v+ccbH7KTwZvEdcgO1RiPrIKqvG36yw=; b=Ks6wF4WDIa88ZrBviT77i64QEP
	z0/eIDYnsI/5C9SnKcBLOIaEsQptBDTNSppYZBTHejy7xYSX3Ko/R/9Rdyyog2GMaAXjJKFi1ih3t
	Bx1OW6DQKGu5atLQyau93Jk8XFWygjeYMJ1jd3nT3qvQOAAf//2ylD4vCJZkBGQqQiqHE5sXCBDCt
	9MWkT609GGtB8kgRbGx6eg4MEQLvimXloVYVdwAsW1NwRrUj0pFc8P/MKty0M/tafxIC5ZXt3/6Bp
	9KgR+NKrouP6tI8wSUpeEvw+fYF+R1lmH79NgQ3hO/jr6r5G6PXKSJsGhQy+ZYOB/6/eKtdsD8P/q
	kx7tzKdg==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tL7WZ-00000003jG4-3hSc;
	Tue, 10 Dec 2024 21:12:08 +0000
Message-ID: <391b9d5f-ec3a-4c90-8345-5dab929917f7@infradead.org>
Date: Tue, 10 Dec 2024 13:12:01 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/19] fsnotify: generate pre-content permission event
 on page fault
To: Klara Modin <klarasmodin@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
 amir73il@gmail.com, brauner@kernel.org, torvalds@linux-foundation.org,
 viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
References: <cover.1731684329.git.josef@toxicpanda.com>
 <aa56c50ce81b1fd18d7f5d71dd2dfced5eba9687.1731684329.git.josef@toxicpanda.com>
 <5d0cd660-251c-423a-8828-5b836a5130f9@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5d0cd660-251c-423a-8828-5b836a5130f9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/8/24 8:58 AM, Klara Modin wrote:
>> +/**
>> + * filemap_fsnotify_fault - maybe emit a pre-content event.
>> + * @vmf:    struct vm_fault containing details of the fault.
>> + * @folio:    the folio we're faulting in.
>> + *
>> + * If we have a pre-content watch on this file we will emit an event for this
>> + * range.  If we return anything the fault caller should return immediately, we
>> + * will return VM_FAULT_RETRY if we had to emit an event, which will trigger the
>> + * fault again and then the fault handler will run the second time through.
>> + *
>> + * This is meant to be called with the folio that we will be filling in to make
>> + * sure the event is emitted for the correct range.
>> + *
>> + * Return: a bitwise-OR of %VM_FAULT_ codes, 0 if nothing happened.
>> + */
>> +vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf)
> 
> The parameters mentioned above do not seem to match with the function.


which causes a warning:

mm/filemap.c:3289: warning: Excess function parameter 'folio' description in 'filemap_fsnotify_fault'


-- 
~Randy


