Return-Path: <linux-fsdevel+bounces-49813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714FEAC3221
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 04:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33403178034
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 02:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3917262D;
	Sun, 25 May 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HnSqQaZ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C083596F
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748139608; cv=none; b=HkJOn9tkF9utviMp0TWeGTXAFNe9y713EcgKS5EWYliILX+czU1mknI75lnV60P+VUZP7fKDrY6t5hRUfBvTUdSHtFW3X+CgnBwgvMtEO43U89Dhv/omkviT8DXses6C59CGvaZyacKtdHDhpEh6jcqDVl5bpkw1exnox2eO7Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748139608; c=relaxed/simple;
	bh=WwiA0RVvpCAR/9OcjdEg2wCEm8r3t9KZqiKU1YxZNoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1a/jddn8KytSp2XGAxzoEGHG3zjXSsR6OEt9U7IrN/00Wr4biq1MFD6ixRQd47Oqjke0xukEQ7olDnpf9jy9FgpML6mSjwBVDOJ+iUinsCe/Z2CT5PxQetJzRu9WmJgVtiY8B3xSYTfCqRMOcubgTKWsN5GWf+6XTzywAIoKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HnSqQaZ2; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 24 May 2025 22:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748139593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unYxqcHTjdMQNtlPEZKhFscFLUMaUxMeQWTbJQV5L6Q=;
	b=HnSqQaZ2tUoeLy8UbKs8Yo2zwmnUwrK18SNN+CO+rWKauGTYK3QRp7q5dxHWjNTuNz5Qht
	Fmdzs2+kB8j7Ty6U0+/vbq/km2aXIn49/BJvl8rNeQtTUdsOmZAnPu+GfNnHoPmbFnMDxI
	apwas6V4zfE0PWmi/Ee9FCjAaZEMJJM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.16
Message-ID: <dmfrgqor3rfvjfmx7bp4m7h7wis4dt5m3kc2d3ilgkg4fb4vem@wytvcdifbcav>
References: <oxkibsokaa3jw2flrbbzb5brx5ere724f3b2nyr2t5nsqfjw4u@23q3ardus43h>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oxkibsokaa3jw2flrbbzb5brx5ere724f3b2nyr2t5nsqfjw4u@23q3ardus43h>
X-Migadu-Flow: FLOW_OUT

There was a feature request I forgot to mention - 

New option, 'rebalance_on_ac_only'. Does exactly what the name suggests,
quite handy with background compression.

