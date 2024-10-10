Return-Path: <linux-fsdevel+bounces-31642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D61DD99955A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 00:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C1B2176C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 22:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CFA1E6DD4;
	Thu, 10 Oct 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="myOfedcS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041331E5034;
	Thu, 10 Oct 2024 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728600084; cv=none; b=S55YOE0eW5TRNZzKNrahaLnBd0E9WyMYE3FbJyri/FT01tJzLzMANeLZktk+NBDtpH01UM3ck9iU//IekN9/vFNNQnU7hqP5OUqve6ZnDuzHHW1Wq1LPFuzbNlntWbLJPTEO63DfGb3DnhXBudlQtpV2AI5ousk4M9puCun/Dig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728600084; c=relaxed/simple;
	bh=Q95/F4p6NOJV8pRF88r7UJwYNSLh7dwgPAauwgcC1Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKHWwVsiK6a9PMx2kBDuon3OB/3zl6OpLZ82OCVdIzvWc5UZDvkR+18r+lRBpB+M1+u+eQSyk0valGm72RQDhE1DsDRbEdCAAm9ropUBZxQyf6uvGB/uvnm2oRYTUz7blmJn+MLXxNFl0efSPZFGx9EgjkjwJREHNYfhqHjmCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=myOfedcS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q95/F4p6NOJV8pRF88r7UJwYNSLh7dwgPAauwgcC1Es=; b=myOfedcSa8tNpJX5gn2W6ONbvI
	PY4lPdIQQo3p/aoFTKRXHdFctGS7PLf7+tHppSe9LrMUSPFso1oDC5EAndIxX89jKpS7Zc8ZjSkcz
	jw+6qZCrQzeXzL5PPIW7P/j+VQKQrgP7TfzODz1u1qgVSG0On0aNKLYCTBfsdsbR4PKmL+xF0FIBb
	+6Gz8xS9Pzt+6VNRFjyPV4fa7VaeWKK67je/PapVXoxfrDOo1oCisIZrfB8xx68rTl1sB72spvE7c
	wRkOhArepRySgKGVXLZRzrcDF8S7z/20io+pLrsyEc57LhNIntJavSb7F7QmoiLafDtYzV+qVd++g
	LwJvzoJw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sz1qQ-0000000908Y-3J8k;
	Thu, 10 Oct 2024 22:41:18 +0000
Date: Thu, 10 Oct 2024 23:41:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Tamir Duberstein <tamird@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] XArray: minor documentation improvements
Message-ID: <ZwhYDsBczHnS7_4r@casper.infradead.org>
References: <CAJ-ks9mz5deGSA_GNXyqVfW5BtK0+C5d+LT9y33U2OLj7+XSOw@mail.gmail.com>
 <20241010214150.52895-2-tamird@gmail.com>
 <1f10bfa9-5a49-4f9b-bbbd-05c7c791684b@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f10bfa9-5a49-4f9b-bbbd-05c7c791684b@infradead.org>

On Thu, Oct 10, 2024 at 02:50:24PM -0700, Randy Dunlap wrote:
> I'm satisfied with this change although obviously it's up to Matthew.

Matthew's on holiday and will be back on Tuesday, thanks.

