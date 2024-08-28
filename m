Return-Path: <linux-fsdevel+bounces-27505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE3A961D40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C842B22178
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7A9142621;
	Wed, 28 Aug 2024 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQN+ktIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2AC69D2B;
	Wed, 28 Aug 2024 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817578; cv=none; b=MnZ09DsSPtI7k5pCjM1bMhGuGrZwH7CZKOWk3/EOsCJRUloNzFXfqzXoyn9ilzRbDWaqt8RG6in8xzP7N4PSKJBFjZeISajnKrfqjpgBOP4tYue97E+bzMEFdqRSetz2fESrtqZvyxLr2aONoB985DnF+Vpmv5/7q/DNAOjumMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817578; c=relaxed/simple;
	bh=hHgVC0XD5sliZnXU3QvgU/IJjdJWLMxWG0dr1p5eKR0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=oWowG5swKEdegFlOIoH81EMjndM0Es3gHVl7tMxpr26U+XAr/2Rmu+q7VEgjB92dnqKpry9PD8WTSaABr+MPIn9oW2NPevGDytYLKsg/KCgUzosRtfFQkFyGMLLd9KOFEJnIhLEAasPer2EsGFDQv9WuV7QcNnsO8HkfOXj4hLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQN+ktIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECD8C4AF0F;
	Wed, 28 Aug 2024 03:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724817578;
	bh=hHgVC0XD5sliZnXU3QvgU/IJjdJWLMxWG0dr1p5eKR0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=cQN+ktIxgr7aAHeczcEzT4oqVZcbjynitroqffd8bR/fKKZzav052UpIYcdRiPg9z
	 1RfWxh6u4ltE/97byJGLDN5dsIBSQwW78aT248c2wDM+YaOyUxt18VOXOpmSwelyeG
	 zn54UfUf86t6DUgdpJDSQxahSYOMssT7H9vpi9hZOvz7rzOqrPUax3l3bXNVhFsXWk
	 5M7cj0L8qXN2G/35cIWuXmWEjyuVcWOVbSfXeN32mUZKZSBvBz0FVuK/8rY1LAY1Kn
	 i6ZtG5V0UDx3+hZN7aUdzqZBNjKoeo3B6yjsZgUtkksUIPOy4Mg0gOOeZ3gftQNF3Y
	 fvFicajpdotRw==
References: <877cc2rom1.fsf@debian-BULLSEYE-live-builder-AMD64>
 <1037bb5a-a48f-47cb-ace7-5e0aba7c6195@gmail.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: Anders Blomdell <anders.blomdell@gmail.com>
Cc: dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
 kjell.m.randa@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, willy@infradead.org, wozizhi@huawei.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to a24cae8fc1f1
Date: Wed, 28 Aug 2024 09:24:03 +0530
In-reply-to: <1037bb5a-a48f-47cb-ace7-5e0aba7c6195@gmail.com>
Message-ID: <878qwhl2l5.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 27, 2024 at 05:24:36 PM +0200, Anders Blomdell wrote:
> Since 6.10 is still marked as a stable release, maybe this shold go into 6.10-fixes branch as well?
>
>   Dave Chinner (1):
>       [95179935bead] xfs: xfs_finobt_count_blocks() walks the wrong btree
>

xfs-linux git repository's xfs-6.10-fixes is not meant for collecting patches
for stable kernels.

Also, the patch mentioned above cannot be merged into 6.10.y for the following
reasons:
1. The 6.11 kernel has not been released yet.
2. No developer has signed up for backporting patches to 6.10.y.

-- 
Chandan

