Return-Path: <linux-fsdevel+bounces-61780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68895B59DAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD4B2A271D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9A8374279;
	Tue, 16 Sep 2025 16:29:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E871A9FB8
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040190; cv=none; b=dwhkeeOzaHv8ETltnE0hP9sDmXLVrtMwGK8FL+/zVw+mPa3LZAvKfd/bRqPMMOcjlycsQJcTiAoWAD8HvYHEPd8glJsdjmji64Uzg//M/jww5mR1kZXopqaZvoF+UFgSUHEW8JNrIp3AtwvYXTr2XG7EGkDbmhhzRFpQYKzXhGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040190; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzSRIChWyL3rXDhRomsbWq51CaDhwqR9joujSOc8QJIC/tUXzwv1GNmyqO5BZaSGmdqU97z19+9CENYzzfcneM0kaPFqY/p1BZaA4c4c+ckVwlQmrHOfIesj2eTzGAi2dzRh3QtwXcyZ+yR/wtSsrjuXXSSKwyvA+Ba9uEROu8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7856868AFE; Tue, 16 Sep 2025 18:29:44 +0200 (CEST)
Date: Tue, 16 Sep 2025 18:29:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 2/2] iomap: error out on file IO when there is no
 inline_data buffer
Message-ID: <20250916162944.GA3979@lst.de>
References: <175803480273.966383.16598493355913871794.stgit@frogsfrogsfrogs> <175803480324.966383.7414345025943296442.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175803480324.966383.7414345025943296442.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


