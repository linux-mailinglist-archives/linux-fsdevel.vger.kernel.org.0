Return-Path: <linux-fsdevel+bounces-7577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4BD827B58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 00:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C20B22ABB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 23:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B3354FA2;
	Mon,  8 Jan 2024 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mQBGoEXb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C74EB672;
	Mon,  8 Jan 2024 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9jvC0ZseLyZgnJyGaQkGzxAFiwtUf83guqMQ4grVe94=; b=mQBGoEXbf54zNBQdFS06MzrkdA
	lXxnEANfpQxtRGBUbocCKLxl3268+HSTslshaDre0Mam8GaS8v7n9LVURGM7exKr0nnUlM1LF24S5
	TqP6RanW/Hsg252imdkyEcszPkGctZs1/qPQOZCaYowXP9pYO5qAlMprjCWGYElxyhcCY9HMU1b5Q
	CmPFhwmBDXeO+9d9nZe5CWjmN4+f/6gQv6fEi6jmuL8UaqoEfTOTAaHwUIbLXwCZ/Se9crw4y/m/U
	E7ZFyiExS0o0iA/1CCvrljXMyEBZr9IjdoI9NKcguRqaryBwU1TrfXdxb6jasX0Sj2WIvvQ2iPwcX
	BOlLqjSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rMyr6-008kQd-Ve; Mon, 08 Jan 2024 23:16:29 +0000
Date: Mon, 8 Jan 2024 23:16:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-cachefs@redhat.com,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reference to non-existing CONFIG_NETFS_FSCACHE
Message-ID: <ZZyCTPz+uuvgjPIL@casper.infradead.org>
References: <CAKXUXMzXN=+hKDPP-RdHKELA_fGA6PcdCj5fXM32qh4Px0Hprg@mail.gmail.com>
 <1542013.1704750095@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542013.1704750095@warthog.procyon.org.uk>

On Mon, Jan 08, 2024 at 09:41:35PM +0000, David Howells wrote:
> netfs_writepages_begin() has the wait on the fscache folio conditional on
> CONFIG_NETFS_FSCACHE - which doesn't exist.
> 
> Fix it to be conditional on CONFIG_FSCACHE instead.

Why is it conditional at all?  Why don't we have a stub function if
CONFIG_FSCACHE is not defined?


