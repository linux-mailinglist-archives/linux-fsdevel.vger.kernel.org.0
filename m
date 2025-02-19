Return-Path: <linux-fsdevel+bounces-42072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2F8A3BFE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 14:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC5D7A2753
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947D1E5B93;
	Wed, 19 Feb 2025 13:28:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E73987D;
	Wed, 19 Feb 2025 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971737; cv=none; b=UINSa30WF3mAma0MZbCOTmrCQqr64B6/cKRABSiVjw7Cs81HmmwzjuRq59peM78GUE9XT33n13GKRq6BCW+I1l6I2QricC0MDffKfddAhv1zWHw2OoERAjpBC5uVTaMQdx8pab0G6dLj83wEecEYsTZUpNluSsWngOFG+Yp6lZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971737; c=relaxed/simple;
	bh=aGd1OrRfh3o2SSGpC7UTWcjcIPml9GvxFFf+Cw/iJAU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=oXXyw/dJBUyPsMbv7f544Zz0ke3BSr5F2ut+xBbj0tMY1/XedHGyux9Q4wJ5JfXg9it7OGhOMDPTGcJKo/8K2WcUtqdci73WNJAjVsumVSPmppKw6oQ7adpkp+grHOjhmFuFRLNtd8OPF59AGGOLXi2PYgoQB7IJYEhDhGGD0gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E1C5A342FA4;
	Wed, 19 Feb 2025 13:28:52 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: makb@juniper.net
Cc: brauner@kernel.org,ebiederm@xmission.com,jack@suse.cz,kees@kernel.org,linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,michael@stapelberg.ch,oleg@redhat.com,torvalds@linux-foundation.org,viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
In-Reply-To: <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
Organization: Gentoo
User-Agent: mu4e 1.12.7; emacs 31.0.50
Date: Wed, 19 Feb 2025 13:28:50 +0000
Message-ID: <87ldu2jc6l.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> Seeing how most popular userspace apps, with the exception of eu-stack,
> seem to work, we could also just leave it, and tell userspace apps to
> fix it on their end.

I'm not sure we do know that most work. 6.12 was released in November,
we're only getting this report about elfutils now. It's not like it's
been years with no complaints.

