Return-Path: <linux-fsdevel+bounces-63537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 708A5BC0F00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 11:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 190F84F4349
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2492D6607;
	Tue,  7 Oct 2025 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="CAv37Md6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D407483;
	Tue,  7 Oct 2025 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831007; cv=none; b=hz7z+DBUa85lFyoiiNH82yG+G5CpYi305KMvjDyeKQhbKUjf2HFMbtHEhr+VqyJJ69WSoUTZngbHSc807ShLw0C4w637+rNSv1n2PLsXtjJ4sgtlFwtZhAd7fMwT0C41y0LhTGtRMmaEl6H/Q+KDIW5N66dlu7GEW+95xjqc8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831007; c=relaxed/simple;
	bh=G+DxoUxu8+GmNziTwmIUe3by9an3Dygxv/SIx3/3X3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7+LdUiXlF0YbpZZbXs5syqNpFA7wGJoAluAtHEtD0zad1rxq8xvfzh7lRHg5lKv3nLSeA1jMt+5K0xRXbsUVTjqQ5jc+pdnCUR2QPZSmFap7ovLEiUpPaMYxarHXrkH7Z8mflUKQohqeOcqKGdStqedfmlDqh/8r0ck1QcnX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=CAv37Md6; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cgs3s37vVz9t21;
	Tue,  7 Oct 2025 11:56:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1759831001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtIjDefiwflyhrEznLkEY1HOvumLtvPZW9x2sGlBhf8=;
	b=CAv37Md64AUcXuXeqMhCQ9HMX68A2Ah1AbMVTpZRmJA9c7jcBOEQt+u+Eg3xdlfTu9Zydy
	XGDfsHKVEmHgHAg4ZVP52/vsw1sRwo78RqWWRXiKPn4VpqRyu3aqDcBJOyh7yKv38ZzkjT
	KDcucgBmQHVZTDH0e2v0oC3/j+W4VB66yk2wvC4Kr3faFdgoS2GnxyYb5w7W4MClhlGrvq
	8YwkCg58Z93GUrv8lUNOhG24Xx6vMO+/1BZzQIgMWlZsc9FPZXy0bITr0UqbxAja9Hm+st
	Clbfzlq/6zCaAncdRVbnG07EVcw9avVb9rIpsUWDqHAxnWh+7nyEjrZq7nVPaw==
Message-ID: <46ce76f8-479f-4023-9d0f-05c749b1fdf7@pankajraghav.com>
Date: Tue, 7 Oct 2025 11:56:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] iomap: use largest_zero_folio() in iomap_dio_zero()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 mcgrof@kernel.org, gost.dev@samsung.com, linux-xfs@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>, "Darrick J . Wong" <djwong@kernel.org>
References: <20250814142137.45469-1-kernel@pankajraghav.com>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20250814142137.45469-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Christian,

   I think this patch was dropped from both the trees due to some confusion.

Could you requeue this patch given that the base patches for largest_zero_folio() are already in
linus's tree[1]?

It applies cleanly on the current master branch.


[1] https://github.com/torvalds/linux/commit/2d8bd8049e89efe42a5397de4effd899e8dd2249
--
Pankaj


