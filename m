Return-Path: <linux-fsdevel+bounces-48442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86851AAF28A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 07:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F450188E2EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 05:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5A623643F;
	Thu,  8 May 2025 05:02:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6E218ADC
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680550; cv=none; b=B8bUjZTGWwmYCcDXdot4wol5XyGIdeoBOpArrjy5Z1FVAwX2V/p9dZGWMN4EJm39Vi55+RhGJbN1Z0+H88i631BID0YgbyyQhFGef1uEJk+lSqiL7Lb4R+wuXtJeybw5tEyDi9hZ97PPBbjD0CyKFPuz8MsiL1QZaPYwnKPYJKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680550; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpJoEAfmr/C1GCnl0jG2UCJ4QgclRsolMxSSdAmpIO0q0G2o8YraXXphnWFv3qpEQs2wamKQIweSBhMMSD8cqqKDbsPoOoTEJICFV0pZqVeLEaLKs4d7OWSNFdIybz8N0o1RenPLH1JxTovDuwHpBo5IlX3NCNhm5yf1NWQiYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AEE0C68B05; Thu,  8 May 2025 07:02:24 +0200 (CEST)
Date: Thu, 8 May 2025 07:02:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Bongio <jbongio@google.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: Remove redundant errseq_set call in
 mark_buffer_write_io_error.
Message-ID: <20250508050224.GB26916@lst.de>
References: <20250507123010.1228243-1-jbongio@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507123010.1228243-1-jbongio@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


