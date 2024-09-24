Return-Path: <linux-fsdevel+bounces-30000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6778E984C24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 22:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F2E9B22C2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 20:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9213B5B4;
	Tue, 24 Sep 2024 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="FCU5pJaE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF1335C7;
	Tue, 24 Sep 2024 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209486; cv=none; b=TWnjH3Y4SUon87P1UKcyKvOxnyN4GBMEfjlIcSXQ1AIjD2APdOr3lbeF7F5gqX8YwYsUkfy5erlyW6Zk3QI9CHhJfTbej4X5ygo2j58z+l9g54+N4lbR5ws3FrohxSQmFcAjZ4igv/5mUkDq/6om/HRPjYRRVhkYDH30fMO79zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209486; c=relaxed/simple;
	bh=Tnoea/PN4yViZbUhzCIK0pG39aSqBFHoj2WqL6KK/6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1OLTGPA2paGLkss7Y4fJjNU1Xjv00IhDiukWj3sF/srvppXDuH9DEz87GoDZX11r2j9Id+tsZ6cEdLa3pdl5JB7bSdYrEOP5jAlstt0XftxuHPoj+SACwZeTAUaZ78j10jG9RxqaNAOM2c9vUOSCUYrYrSFYt+9I9RoaXdBvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=FCU5pJaE; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XCrtp3H5lz9tVp;
	Tue, 24 Sep 2024 22:24:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1727209474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kelrUBkz8MWHp6hsI6Ll1z4AsO15S9eKtXNoLkthIE=;
	b=FCU5pJaE2vj3ENQfd5r69/OyvOh//8okgHwirMVWQCfsWhDXSlEDtXca7p0vgZYQ+47G6p
	E4cmmLh4Bd2lxRMgEFN6FpiJh9On9gtUjJbzFkAnoY5CbRLIxbXFZED8llwiMlp1sJNkKo
	Wgt9OGMd1ADydSsQKS9GaflIKObS0F/aP4VQuSOmYTTYzW9nsyS6gc9QJnsSJsT1ojd87A
	aMg1oM5BumR8kLboN7X59H8RZSmJGSV3hkkdsUAV/biBK3Q0CrBEf6EQShhIhBdEwDyT7b
	eiej1E9WNYLvicy545M0x3t5VZCUyDr9AktjGPOnYSyBwy3FlBqXEx3MnQDM8g==
Message-ID: <15985138-331e-4cfc-b27a-14605ecfb0d6@pankajraghav.com>
Date: Tue, 24 Sep 2024 22:24:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] add block size > page size support to ramfs
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
 Christian Brauner <brauner@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>
References: <20240924192351.74728-1-kernel@pankajraghav.com>
 <ZvMaWrXkgZ9ZHKfS@casper.infradead.org>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <ZvMaWrXkgZ9ZHKfS@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On Tue, Sep 24, 2024 at 09:00:26PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 24, 2024 at 09:23:49PM +0200, Pankaj Raghav (Samsung) wrote:
> > Add block size > page size to ramfs as we support minimum folio order
> > allocation in the page cache. The changes are very minimal, and this is
> > also a nice way to stress test just the page cache changes for minimum
> > folio order.
>
> I don't really see the point of upstreaming this.  I'm sure it was
> useful for your testing.  And splitting the patch in two makes no sense
> to me; the combined patch is not large.

I just wanted to put it out in the wild to see if somebody found it
useful as it was pretty trivial to add the support. Also, the first
series that tried adding support for LBS in the kernel 17 years ago used
ramfs as an example :).

The only use case I could come up with was testing the folio order changes
in the page cache without having to use a more complicated FS like XFS.
In that sense it is still useful to add this feature I guess considering
the minimal changes?

--
Pankaj


