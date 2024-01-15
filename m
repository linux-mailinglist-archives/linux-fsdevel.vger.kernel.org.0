Return-Path: <linux-fsdevel+bounces-8005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EFF82E21B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 22:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB317B220E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 21:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CA81B277;
	Mon, 15 Jan 2024 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O7331Njz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A11AADC;
	Mon, 15 Jan 2024 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rjA/StcP4f+ikb2aa9JgpBqJLsdOn/yigGQqtxcJ9Nk=; b=O7331NjzXPGCNr0Pf/QzmqJg69
	no5+P6eNTvf4Ou4nagbDw368nRkpl3K2AzAj3VUFJVOUgFCQmB9N+2JuKkHiIk1XWnY2u1rRLDNcX
	J8fub4N6TQRLFHw0KQqOxMfptYB7QZO2Oip2ZwssqdJ84hnyF0EL4x7RNF0le9mcQLGsf0oH9cjLs
	fJTDjkIO+fPuRnUD+6GUbZ5tcZ+Vf9gxLQzVH0+z+VQgiCHsaL7OHwi/AZFFT/FEzg6y8ZnNpcLai
	EBoJ/jvnWP9EDDt6rW6/upu5OaC0R3wwu9MEL/P3HzbWm3ZwCAhmDCB6s9Vkmllq326HeDyLhGhp2
	SjJhG1Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPUHn-00Aqo1-91; Mon, 15 Jan 2024 21:14:23 +0000
Date: Mon, 15 Jan 2024 21:14:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: dai.ngo@oracle.com
Cc: brauner@kernel.org, Jorge Mora <Jorge.Mora@netapp.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: nfstest_posix failed with 6.7 kernel (resend)
Message-ID: <ZaWgL7RxJtAHeayb@casper.infradead.org>
References: <feef41c7-b640-4616-908f-9d8eb97904aa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feef41c7-b640-4616-908f-9d8eb97904aa@oracle.com>

On Mon, Jan 15, 2024 at 01:05:37PM -0800, dai.ngo@oracle.com wrote:
> (resend with correct Jorge Mora address)
> 
> The 'open' tests of nfstest_posix failed with 6.7 kernel with these errors:
> 
>     FAIL: open - opening existent file should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
>     FAIL: open - opening symbolic link should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)

it might be helpful if you either included a source code snippet of
"nfstest_posix" or a link to where we can see what it's doing.  or an
strace of the failing call.


