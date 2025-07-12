Return-Path: <linux-fsdevel+bounces-54768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF126B02D82
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 01:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC7BA40FB7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 23:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5942309B2;
	Sat, 12 Jul 2025 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QRy83B1i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C522F42;
	Sat, 12 Jul 2025 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752362150; cv=none; b=ktP8hpevimy3HgO3desJXyzg/vR1kLZuq3NKv3NcAuyGuZDZ+zsTK0zf0vI0mJzzz47s61bUteXyqZWkrRHwc3u9yfJaGq/Jajcu8WtXrUImgtOgRN3s1CRqw1tt7cklACRs2WbW5TX5QxAT4u2p0qGl4tniYMULEL9wx/NcPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752362150; c=relaxed/simple;
	bh=2MJWq3RmhQmgqXM2aU0Pq/CmLUzN9TdeDAtXB6evE4M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vrkj+w+HO176svDHNhnYxFck9idLnp8kyE+NL3ogcInoocERp1VhmTJUiCinddHZGWxEp6NZr7AFQJd/msEjtM4trvumtUx7skq5cn2V+R8JmzWuzR9Oxf/Ol6TkDpOIZTtFa6HhVJ5LyNmz3lTMLt2NfqimwliInMeZW65UOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QRy83B1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6D1C4CEEF;
	Sat, 12 Jul 2025 23:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752362150;
	bh=2MJWq3RmhQmgqXM2aU0Pq/CmLUzN9TdeDAtXB6evE4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QRy83B1iBNvfnB1WaNW66DVIyBe/2/Ic4O75Wc4Z1VVoIjLXCH0dIdQZxBlbH1aNC
	 Cy26o4YsijoyL1UU7n5Ql971KyvCAAi9IbteQJ3rDAdWhq24qk9UwTzQHXbWdfb9mA
	 t4baJlRCs63k8QZSkBvv/zkD9Rhla9LyDiPDFZ70=
Date: Sat, 12 Jul 2025 16:15:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/Kconfig: Enable HUGETLBFS only if
 ARCH_SUPPORTS_HUGETLBFS
Message-Id: <20250712161549.499ec62de664904bd86ffa90@linux-foundation.org>
In-Reply-To: <20250711102934.2399533-1-anshuman.khandual@arm.com>
References: <20250711102934.2399533-1-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 15:59:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> Enable HUGETLBFS only when platform subscrbes via ARCH_SUPPORTS_HUGETLBFS.
> Hence select ARCH_SUPPORTS_HUGETLBFS on existing x86 and sparc for their
> continuing HUGETLBFS support.

Looks nice.

> While here also just drop existing 'BROKEN' dependency.

Why?

What is BROKEN for, anyway?  I don't recall having dealt with it
before.  It predates kernel git and we forgot to document it.

