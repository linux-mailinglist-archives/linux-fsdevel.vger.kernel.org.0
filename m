Return-Path: <linux-fsdevel+bounces-17866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9B08B31BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 09:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C59E1F2326E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E52B13C8F5;
	Fri, 26 Apr 2024 07:56:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8613B298
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118170; cv=none; b=G4VG8RDhBWy4kDrnhrn9bwBYog6fYlbo/WBGEeXVjClP3ZGueXP1aIW2yVIrCHo/Fn9qEoX6QPk+hCGYZfvyM1fPaG4U4f/0uGPa9pSdF53hQyjDpaxDhzKakI6CIljsVz1pDqA5r1PlWC/ZMA240MhYOBWoOK2yHqdX6FX6P6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118170; c=relaxed/simple;
	bh=DJ4d6uQ2lUpMe9dLYSa9H2uov508pcaTKIH3NDDWG7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksP+CyDu0gUyhNrjua7vbfV1bAK+fQgGdMAUvcJc0Voir6AffsSHa+S7d+l1FFuxNCkQyTEysiTPhzi8W1/RWVfX0TPD6Z68G4WaHWSrGPJaGncYlaXlSmyLRMVbCi3LUmpvZYQShKiwoW+w1syWR0kLa3vOKhI5Jrqyctf7y58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski; spf=none smtp.mailfrom=osuchow.ski; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osuchow.ski
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4VQlQk03Rjz9sZ5;
	Fri, 26 Apr 2024 09:55:58 +0200 (CEST)
Message-ID: <68af7942-918d-47d7-a22a-6e95b90ebeee@osuchow.ski>
Date: Fri, 26 Apr 2024 09:55:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] fs: Create anon_inode_getfile_fmode()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
References: <20240425215803.24267-1-linux@osuchow.ski>
 <20240425220329.GM2118490@ZenIV>
 <022a152f-11c8-404c-8d7f-f7f788f17471@osuchow.ski>
 <20240425223138.GO2118490@ZenIV>
Content-Language: en-US
From: Dawid Osuchowski <linux@osuchow.ski>
In-Reply-To: <20240425223138.GO2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 00:31, Al Viro wrote:

> linux/types.h, if anything.

Thanks, will address in next revision.

-- Dawid

