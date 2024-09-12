Return-Path: <linux-fsdevel+bounces-29137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368349761FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 08:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E72281AE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 06:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE7718BC30;
	Thu, 12 Sep 2024 06:57:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8418BC05;
	Thu, 12 Sep 2024 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124265; cv=none; b=mzmzbIs4R+u1O0UQSCbArkLoKqAUPvRc7Gyd1P7Hay4VF1R4W9+ONFqkZtvv6VqItjiMaTN0Lh94DfT4wnotMszTS9aMOAlkJRBsPdJsg8nlFGI7SgODEX8UavQRX4YzcjINvIAhHW/jcphJ5izeLojDz1Mk9w7551jCaqGjPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124265; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlUHmKNDnVOwgA6dI55CKh2K5ivpaaS1s3VtUulGBNhOBzwMxluJKfsYsYaRnVlGvMutWvrICmW7mVF7+LDe/wQI31YOYbykYq6uEGNFhIDvgcEZx6wXz8hpdD7vZEni+a87ilbISoEyYWAlb0VvcoohvTv9Wyhr+2Ox4nObK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E793C227AAF; Thu, 12 Sep 2024 08:57:37 +0200 (CEST)
Date: Thu, 12 Sep 2024 08:57:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: ganjie <ganjie182@gmail.com>
Cc: krisman@suse.de, linux-fsdevel@vger.kernel.org, hch@lst.de,
	linux-kernel@vger.kernel.org, guoxuenan@huawei.com,
	guoxuenan@huaweicloud.com
Subject: Re: [PATCH v2] unicode: change the reference of database file
Message-ID: <20240912065737.GA7455@lst.de>
References: <20240912031932.1161-1-ganjie182@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912031932.1161-1-ganjie182@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


