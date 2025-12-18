Return-Path: <linux-fsdevel+bounces-71670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9582CCC6DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 16:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B1323064BE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DC225CC7A;
	Thu, 18 Dec 2025 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="WrXBq2GO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1F34BA21;
	Thu, 18 Dec 2025 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070903; cv=none; b=Vp0FBwcya2KHj2Dj2MOgF4bh2pZyqTYr0mc5gmC8M9L10YkSqVZf7//owwv2duDpx29INneVN7JBCNsLjUIRMdjHVpXUNj7e3RpF6l5HQ+ymaoBjuy4qdbpqFSuMWH+HpqP2MviJoZUjAj+VMBRezIkctnOWROEBCtUCdIzBTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070903; c=relaxed/simple;
	bh=/BwbEwPSOc2OIZA1Mnf8+XRdoiORcAKFaXF5cQRoHN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxgZg3KsQEozb2yZ1d4ovvgYTxTwhJJfeNhIls6J+u4aYQG+ivT14PdgZWG+8fAeenX9D70SMK+ppgoAjSqUDC+ItAseCybiNKWkRQIZz5aAfe/hxuEMZ919Usxx7TmXmN1lZn28GJAdHoifT4KN/+X5ih8AYToCSMUogOqqQx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=WrXBq2GO; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=nYx1Zg9NreHm8zXRg1aJvu+X2PTqLETKhbv8sypSjZ0=; b=WrXBq2GOr3jNoWsTs0xNdMOt8l
	h2UW9kMnEt/tGzY2MikrQ6qX665KFaT6BCaNkgMiFah+PdWdlMixUW0qDY90N1/4BKyun00QkedaY
	upgoGCAt16TWHTOzZ1/F32jJifgaF+cxxQgY7NwhixQO1LoxlgqM1PtEam6uuH9Slf70xfmZYlu5l
	t4Rc5po3HIrreQZ16MbO0HbQj7OiCE1yqQqc/wirFk6jJAY/P458M6hM0Q2wetKzOhuXjoJyGt/c6
	w8VyZZlC3naeGmOejP0RCIFix18gbpn22GACuoyXBuhI44zDzme3MNukmu+Z2oVGj1nWqr97Ch3sV
	AD+pqtQK2EYSNo8bxCBPS6UXjH0qdurEFQJ9bnk6xnHEoj3UesFFvbfbZHJKAjf/pD5KfIOtxuC6v
	xnc6WRCR1x7fAAHo3akjzU7w+XA6/gKT0rKbI9GPU9cnsdvf6l3g10GJNvSFnq2nGdFRqV523mHI8
	k2DzSeB+VacOyRbCiKBoh9VUzdxBYKe2RL58KMu98M5sy+hOwGAIcU3tnOMwIZVRVpGxQvImhuThQ
	kLax9q38on+t7Vh0tQnkxgOifmetfUOdInBGkGr9Uh8qh1Nulhoo43JFxUweBJJg4LU7VhAxhY8DG
	1fG49amx6rGjYFPArlAv3cVAAoMFKCt/vyyxxK+Bg=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: asmadeus@codewreck.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, Chris Arges <carges@cloudflare.com>,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter() iovec
Date: Thu, 18 Dec 2025 16:14:45 +0100
Message-ID: <8622834.T7Z3S40VBb@weasel>
In-Reply-To: <aUQN96w9qi9FAxag@codewreck.org>
References:
 <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <aUMlUDBnBs8Bdqg0@codewreck.org> <aUQN96w9qi9FAxag@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 18 December 2025 15:21:43 CET asmadeus@codewreck.org wrote:
> asmadeus@codewreck.org wrote on Thu, Dec 18, 2025 at 06:49:04AM +0900:
> > Christian Schoenebeck wrote on Wed, Dec 17, 2025 at 02:41:31PM +0100:
> >> Something's seriously messed up with 9p cache right now. With today's git
> >> master I do get data corruption in any 9p cache mode, including
> >> cache=mmap,
> >> only cache=none behaves clean.
> > 
> > Ugh...
> 
> I've updated from v6.18-rc2 + 9p pull requests to master and I can't
> reproduce any obvious corruption, booting an alpine rootfs over 9p and
> building a kernel inside (tried cache=loose and mmap)
> 
> Won't be the first time I can't reproduce, but what kind of workload are
> you testing?
> Anything that might help me try to reproduce (like VM cpu count/memory)
> will be appreciated, corruptions are Bad...

Debian Trixie guest running as 9p rootfs in QEMU, 4 cores, 16 GB.

Compiling a bunch of projects with GCC works fine without errors, but with 
clang it's very simple for me to reproduce. E.g. just a very short C++ file 
that pulls in some system headers:

#include <utility>
#include <sys/cdefs.h>
#include <limits>

Then running 3 times: clang++ -c foo.cpp -std=c++17

The first 2 clang runs succeed, the 3rd clang run then always blows up for 
anything else than cache=none, various spurious clang errors on those system 
headers like

  error: source file is not valid UTF-8
  ...
  warning: null character ignored [-Wnull-character]
  ...
  error: expected unqualified-id

and finally clang crashes.

/Christian



