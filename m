Return-Path: <linux-fsdevel+bounces-44112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D86FBA629D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 10:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BDE19C16A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7563F1F4725;
	Sat, 15 Mar 2025 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CX05PYP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB902192B8F;
	Sat, 15 Mar 2025 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742030309; cv=none; b=uAkShor3tF/BUFVMwWqexpPtw5aegZrrYiH0g1xVpoC87pRge4u7i3tPZfbo50ESlKRf5CHN5gm2gJlxf5HoZ6DrQzNqPupEfqJQ5lyiWjZNtd2LZ/IR8klr1yykNTZo7Ys+2FajBx1r3STQK9KNPCOp9LZnj1enHExgxgFzgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742030309; c=relaxed/simple;
	bh=GQv7KvCAU+uRzf9Qmza7d1ZWo/zd5O/jTmQDRbkK0qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hej7T+uycmkjoZU6SvYoIIcaWEa49HnD/roEUvZAKqhTLm4MLWBD/M02sNQ6mk2lFA1KeO2X+xwxJvx2HoLuNAtBpXrVUMdXJiGWduPcqkoX1h0/WxVcI1RQW6ZzplmWbThhcVxs6dQCEN73pcr9ff5yxInrEGqytnrf/W2mccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CX05PYP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6954FC4CEE5;
	Sat, 15 Mar 2025 09:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742030309;
	bh=GQv7KvCAU+uRzf9Qmza7d1ZWo/zd5O/jTmQDRbkK0qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CX05PYP8R9cXWXee/zocaBxw/blDQiuKyUg8AuA5lnbbfka7z4acloZ36UJH2uKDG
	 Y24/s8GuJBFojC//l/ipCkKw7Bbog8YFsT/etHESchUdP0x+d1mYklpSETorzZMHSl
	 WNGPdzjj6wax7baiFHlCP1Nl9PgJfETVmSVjB6A8rZVsNEajFqwCb5ca/zZTGSca6U
	 xgZFW2Rb88DhuMaf0ZG/S9lK2Gt/Jcz6AvEwJ9eo90yxBHph2r8pRLUhRO4bHWNbtF
	 u67F3IehFkZwS3DOq0CwdOxqLABM9SssFi7HKgz+Ne59sKZIH2200cc9VNHFrlcsaE
	 V1zUvYpcBsJ1Q==
Date: Sat, 15 Mar 2025 10:18:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>, tytso@mit.edu, 
	ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org, sven@svenpeter.dev, 
	ernesto@corellium.com, gargaditya08@live.com, willy@infradead.org, 
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 0/8] staging: apfs: init APFS module
Message-ID: <20250315-gruft-evidenz-d2054ba2f684@brauner>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
 <2025031529-greedless-jingle-1f3b@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025031529-greedless-jingle-1f3b@gregkh>

> But I'll wait for an ACK from the filesystem developers before doing it
> as having filesystem code in drivers/staging/ feels odd, and they kind
> of need to know what's going on here for when they change api stuff.

Sorry, I don't want new filesystems going through the generic staging
tree. Next week during LSFMM we can discuss a filesystem specific
staging tree that is directly maintained as part of fs so it's tightly
integrated. We're going to talk about two new filesystems anyway.

Thanks!
Christian

