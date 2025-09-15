Return-Path: <linux-fsdevel+bounces-61347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023C0B579DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EB73A5B58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF7A304BDE;
	Mon, 15 Sep 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOyYQU/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F493019A4
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937964; cv=none; b=AlGkWgH9q0rrkYVy7lErYHtIEuUsqWyyuxcXOJSgBbxuF0lKOiJX4ykmC2YClkadlvKXgckbI4oyM3tMxvI22neii34oywobIOncXhX+uHCdH89unuZ7k7giuBsMA4gxdR31B0cUs4LJBg45nkzLoi4zLad0m+O96V2iHVkKFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937964; c=relaxed/simple;
	bh=clbjX9YLgGwQ83jN9BgytmnhrOkjJOrhvmeBUcmfzzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEhp5xodgSspNKz6Qhxcs90jhOjdQs2BpnDHT0dbO8xETyFvLaqOMbOIMrxyEltMsZdtFnFIgL/zn8QlvLTUCgQVc+Cwi8xvm17g8ZohR9ZLxfxM2lCV1jTnrgb/jo6ofwoKBGKY09iPu+mAZBuyUupzuvyoKUxpdV8eulscBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOyYQU/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D57C4CEF9;
	Mon, 15 Sep 2025 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937962;
	bh=clbjX9YLgGwQ83jN9BgytmnhrOkjJOrhvmeBUcmfzzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOyYQU/xa6nsg7fWBjNYrgj4KeVZ4PrS5d9vg3ZcIFK/IHPeQCd1HnQb4k0uMkdfJ
	 62gJub1ePlx1ZvgxBlTOEGyC2zauQcrmWP9VUcCdfPAh01qljaWZtFiPI6qUF0O8hi
	 h9+lfMzZUdSaDWKOYo0kij5Jrd0tLbIEB026++GhyY02OpxD6i73zEnXJ8WHeMR30R
	 zPmdRAyCB/jkcc3UP2uH7z0A+IPsCAkeTnLFA1ooPluBVyJ6MFcaezJlZQ/w8FSkbJ
	 LLf/0dh//N8tm5R3phmm7rrIF3fvKz6qNwSHVh3Ryo7IhYyoeo9axfjLg+uFVwWGxa
	 OKYKz7boTqK8w==
Date: Mon, 15 Sep 2025 14:05:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 18/21] ovl_sync_file(): constify path argument
Message-ID: <20250915-glossar-uralt-765ca040098c@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-18-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-18-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:34AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

