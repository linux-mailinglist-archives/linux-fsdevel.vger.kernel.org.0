Return-Path: <linux-fsdevel+bounces-7958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844FC82DECB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD151C22005
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C124F18B1A;
	Mon, 15 Jan 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hK2nUdml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8325C1804E;
	Mon, 15 Jan 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LOwb4W3+vxfYh5RTX/DUVEXG+wV8C4bNnq870pAU/vY=; b=hK2nUdml1IsynGjhwnfTZ/JLLR
	9Mg86i93Z2bAFKkOVOVUsPOJMpQen/zFgulVkHVbi2CBAJ9fDFRFSdDSB8p10bXnX1pbWvQ2Fu9e7
	qPXCBq6n5CgGggxbbwcgtXcE9gE1F/RkKxU/EPP7dGg+V/YMo1dYC4jFssCwRMwiIvPtvKvqMExqh
	XROIt4D87DhJ6kvB4cXv3pOLctw3aMH/wCMZnphtFlHaxn3mmpf6X3LChfxTyw58Srz7q9mnILJAA
	X5hQPpgCU9STZH9Syb6lBEAe1VSmaJFQiXc+cZgewfBEbOF1uqPybR+pwDGTg5Gvi64is/pT1HgcM
	r2eXHVFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPRH4-00AQHE-6S; Mon, 15 Jan 2024 18:01:26 +0000
Date: Mon, 15 Jan 2024 18:01:26 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: Remove usage of the deprecated ida_simple_xx() API
Message-ID: <ZaVy9r0wX8pUE10n@casper.infradead.org>
References: <f235bd25763bd530ff5508084989f63e020c3606.1705341186.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f235bd25763bd530ff5508084989f63e020c3606.1705341186.git.christophe.jaillet@wanadoo.fr>

On Mon, Jan 15, 2024 at 06:53:37PM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_max() is inclusive. So a -1 has been added when needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

