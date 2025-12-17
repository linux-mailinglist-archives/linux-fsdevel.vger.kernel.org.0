Return-Path: <linux-fsdevel+bounces-71504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C45EECC5C91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 03:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4F9C3027FD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 02:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562742765D7;
	Wed, 17 Dec 2025 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZWncn4m1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B0C2494F0
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765939054; cv=none; b=EtYA1O5P1mIMTAiHG569976okmgCsiArrJf2PB1NQNcPQ3sJXz5gAC0ozG3GlnBKYnJ4DIxR6zY1d/FttJcdthWDdEiiTfzdbj6Pq7Lbsw4o/POpAMpR9xPPmxs7J1tuX+ug2ZPdT+29Ac+WZvUrasbG7NZ04MDZcaJL53SGz5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765939054; c=relaxed/simple;
	bh=1Isj4mX6Vyt9m69TWfVdj//SpgR8fxG2ZGl1Vfa4+eo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fIiCFjRyfmyXeoVi6wSJqG5OYrEy6DyWgWJTlUaEJZYCMT7/c8fB69MBYlGArAmA+4mkJgcI5LM4wW9/FFiPGi8FGhW3rcSL1BjQ6ZxSdyCOVT6UeX99WFj65JKN9MNvovox1zxoyBW4vy95ULCtbGy9fAqOH0fjIWxX37zBzQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZWncn4m1; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765939034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5aRivHaTbegQNkRt7bHX8ZRS4dbuKQr87Iksclf1c8=;
	b=ZWncn4m1nKlhB2q2NeXXjVUPEqo3LHLgiYib/MIZ1Gbk4OBpS9K68rPlZbf4/9xswMRNQG
	0K/GPQHpFYx6KDuOny8ADJHoZzGAMgBpbWmwi1umOBGsMBad+mDHZh8dwTXvdjzuyAjSrt
	rxfpVSVI/usHCBNT7NYRgpjtfn52Hv8=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH] sysctl: Remove unused ctl_table forward declarations
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20251215-jag-sysctl_fw_decl-v1-1-2a9af78448f8@kernel.org>
Date: Wed, 17 Dec 2025 10:36:24 +0800
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-hams@vger.kernel.org,
 netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8975859D-F82B-4829-9744-171B7EBEE749@linux.dev>
References: <20251215-jag-sysctl_fw_decl-v1-1-2a9af78448f8@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Dec 15, 2025, at 23:25, Joel Granados <joel.granados@kernel.org> wrote:
> 
> Remove superfluous forward declarations of ctl_table from header files
> where they are no longer needed. These declarations were left behind
> after sysctl code refactoring and cleanup.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

For HugeTLB.

Thanks.


