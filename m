Return-Path: <linux-fsdevel+bounces-74773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDZBARdMcGnXXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 04:46:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A34D8508CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 04:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8241F5E3DF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F4232D435;
	Wed, 21 Jan 2026 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p1qZ/DvX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C932D0E3;
	Wed, 21 Jan 2026 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966905; cv=none; b=E5TNxBJ4Cn5xXceI7Z4Rj4FJnUgj9gGh9pFjhN+8pmOxdqYkpfAe4ksXk6UF3LDu1L0+/th2WvXv3rcd2obS5HBtuVt0yl/I4kWaP71l7Lz06P5IBd62Vlh/tb8rYK1BRvqut06hgSvZwW4d5iI8OsHQ13k2lm61dN3eLbgJ3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966905; c=relaxed/simple;
	bh=Q0YLy8iPJ7tVfivWPaHkARsYpoSr26DbyCC5bjP2WVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g87Wg9aU3ED09gJRAN8gUcZSdhUOvEGLgS2qqCaC5phb5ePX4EMQxr7PM6TA8Rm7SVVV3235IG6aYuN/5FkvodmP3/5xoB45nzx0Zu+cSMmjvB39+1PGYF38OSrAgA2JN5ljgHhm8HtFU3B/cArhTe1gMvv4WRreccTX7D4mEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p1qZ/DvX; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=T/
	5NlwaPxjViS1OBICnOwJUUvT0oDr9Iwn/0hG6IUMg=; b=p1qZ/DvX39+6avtk8z
	eutJjp9m4zUD4zGbjgDbyZ8cTGz2OwmoBR3H6NE4o6BcbSy/xXCPzq3nMK8OmRxH
	emTbAeaiVLa5ADKiDhNu59KSfipYOi0QDn6i/5HZxaNBMuVR2ymiYDZgl+z7/zeQ
	825BpLixLrfDY+aonCSAXOBAo=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnN8iQSnBp8StLHQ--.46491S2;
	Wed, 21 Jan 2026 11:40:02 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: shakeel.butt@linux.dev
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	david@kernel.org,
	hannes@cmpxchg.org,
	harry.yoo@oracle.com,
	jackzxcui1989@163.com,
	jannh@google.com,
	kuba@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@kernel.org,
	riel@surriel.com,
	vbabka@suse.cz,
	weixugc@google.com,
	willy@infradead.org,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com
Subject: Re: [PATCH] mm: vmscan: add skipexec mode not to reclaim pages with VM_EXEC vma flag
Date: Wed, 21 Jan 2026 11:40:00 +0800
Message-Id: <20260121034000.51915-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aW__D24ZrpeSPKZN@linux.dev>
References: <aW__D24ZrpeSPKZN@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN8iQSnBp8StLHQ--.46491S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw43uFWfAr4xKFW8uF1ftFb_yoW8WFyxpr
	WfGa4jkayrXr17ZFs2qa109r1Fy3yrCrW5JFyYk34xC34rWryv9F4Sk340kF1kuwsrAa4j
	qrsFvr95Xwn8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pENVy3UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC6BItN2lwSpITEQAA3j
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,google.com,kernel.org,cmpxchg.org,163.com,vger.kernel.org,kvack.org,surriel.com,suse.cz,infradead.org,bytedance.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-74773-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackzxcui1989@163.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: A34D8508CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 14:20:23 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 1. The reclaimed code segments are often those that handle exceptional
> > scenarios, which are not frequently executed. When memory pressure
> > increases, the entire system can become sluggish, leading to execution of
> > these seldom-used exception-handling code segments. Since these segments
> > are more likely to be reclaimed from memory, this exacerbates system
> > sluggishness.
> > 
> > 2. The reclaimed code segments used for exception handling are often
> > shared by multiple tasks, causing these tasks to wait on the folio's
> > PG_locked bit, further increasing I/O wait.
> > 
> > 3. Under memory pressure, the reclamation of code segments is often
> > scattered and randomly distributed, slowing down the efficiency of block
> > device reads and further exacerbating I/O wait.
> > 
> > While this issue could be addressed by preloading a library mlock all
> > executable segments, it would lead to many code segments that are never
> > used being locked, resulting in memory waste.
> > 
> > In systems where code execution is relatively fixed, preventing currently
> > in-use code segments from being reclaimed makes sense. This acts as a
> > self-adaptive way for the system to lock the necessary portions, which
> > saves memory compared to locking all code segments with mlock.
> 
> Have you tried mlock2(MLOCK_ONFAULT) for your application? It will not
> bring in unaccessed segments into memory and only mlocks which is
> already in memory or accessed in future?

It's a good idea :)  Thanks.
We may also try this solution in our project later.

--
Xin Zhao


