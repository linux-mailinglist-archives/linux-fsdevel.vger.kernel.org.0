Return-Path: <linux-fsdevel+bounces-6473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E68180EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 06:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B95F28452B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 05:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48016FB4;
	Tue, 19 Dec 2023 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sIiQdTvD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A85848D;
	Tue, 19 Dec 2023 05:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NPrfdD3xBw7hUE+IHG8/T4o5BO4Jpl9dBHXrfCMHZdM=; b=sIiQdTvDHb4clMvmBCt/PRrZDO
	zv4fySdAjCh2XSWJqdolt1KwZFeBhq/gZdUKuoqE6nTUFlj9ZooNmLXsnexPfHc7+P8Vu/vFY9g2k
	Yr4JrEj8RtL54FIza+pSomymYPYlNTa4XedeEsNoO57DDJ5GuMXHTCUTTjVAEb/WBIqsT5VqnLVuL
	5BXa7BzJKHkhalzjL23k+Al2oCG2q1PvKHzjcYOWLU6AgQo3XgD+gmyYrwkar9OoRuzo0hDKeAUF1
	xw7xntypNq0zZG4dLGImMW28vAwo0Cb/3UZ0JTKuMPF5MnCfHg6RZz7XWLrfr5YcW7DpVW6UKKPhz
	h9skrtrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rFSVt-000P2e-SC; Tue, 19 Dec 2023 05:19:29 +0000
Date: Tue, 19 Dec 2023 05:19:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vboxsf: Remove usage of the deprecated ida_simple_xx()
 API
Message-ID: <ZYEn4bhbIvK3SB/q@casper.infradead.org>
References: <2752888783edaed8576777e1763dc0489fd07000.1702963000.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2752888783edaed8576777e1763dc0489fd07000.1702963000.git.christophe.jaillet@wanadoo.fr>

On Tue, Dec 19, 2023 at 06:17:04AM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

