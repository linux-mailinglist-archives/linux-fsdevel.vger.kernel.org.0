Return-Path: <linux-fsdevel+bounces-26830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D35295BE33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 20:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468211F24E78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9987F1CFED2;
	Thu, 22 Aug 2024 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qI4ufQf9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC0F1CDFC7;
	Thu, 22 Aug 2024 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351066; cv=none; b=fienu2XN3P+ecr10eMSmBRPaJWSFvlJ86MxtfEB/TJ+5oJhk6f47KysGzbXZtR1PEwiCSCl0vMuJJWsyRapf5AJDOx7evmMM1KPts/YcuZwqlNMUHK0q8n3zRca1Bg9Bv1TXkym0uEv4xDZzayQsd2dUw20CX546pY/MERr5r5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351066; c=relaxed/simple;
	bh=fJM8piWVycxfuxwymCBX3W2I6CarLyDPpGzo3FoWl5E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ncVHCN85zm7vsRdSfpXu0b5KJq37R2dI3ZsxdA447Z+PB7qSC2VHDwjhMHB1v7yThL1sAzvTkhVOlCa9AOZimZiFh/CKyJCzWZGArrYBQes7ZoB+3KVFQCwGXu1nUtyfNx/7qZi4Wo8SDwSBE6zos6s43crr30uXZ94aqCHRO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qI4ufQf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C33FC32782;
	Thu, 22 Aug 2024 18:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724351065;
	bh=fJM8piWVycxfuxwymCBX3W2I6CarLyDPpGzo3FoWl5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qI4ufQf90WzhlhOoY7xd4/swuBjwWHbLwaIH4u6Z8aU7NmKZM5cOKHELyDntV77y8
	 LhZkkk5akTG2PErYY2S1M+Eh+qQfvSAJUSj9KBcx7dx0zcoNqMmjvETYiPJwNYPnks
	 kB1MQ3ScRh5274nvr7eZRcOf2ootyAcKi5wbcsWo=
Date: Thu, 22 Aug 2024 11:24:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 oe-kbuild-all@lists.linux.dev, Linux Memory Management List
 <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 01/10] mm: Remove PageActive
Message-Id: <20240822112424.281245ba8874b4b39ce25c37@linux-foundation.org>
In-Reply-To: <202408222044.zZMToCKk-lkp@intel.com>
References: <20240821193445.2294269-2-willy@infradead.org>
	<202408222044.zZMToCKk-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 21:22:43 +0800 kernel test robot <lkp@intel.com> wrote:

>    arch/powerpc/mm/pgtable-frag.c: In function 'pte_free_defer':
> >> arch/powerpc/mm/pgtable-frag.c:142:9: error: implicit declaration of function 'SetPageActive' [-Wimplicit-function-declaration]
>      142 |         SetPageActive(page);
>          |         ^~~~~~~~~~~~~

this, I assume?

--- a/arch/powerpc/mm/pgtable-frag.c~mm-remove-pageactive-fix
+++ a/arch/powerpc/mm/pgtable-frag.c
@@ -136,10 +136,10 @@ void pte_fragment_free(unsigned long *ta
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 {
-	struct page *page;
+	struct folio *folio;
 
-	page = virt_to_page(pgtable);
-	SetPageActive(page);
+	folio = virt_to_folio(pgtable);
+	folio_set_active(folio);
 	pte_fragment_free((unsigned long *)pgtable, 0);
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
_


