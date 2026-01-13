Return-Path: <linux-fsdevel+bounces-73459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F984D1A125
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45A0E3028D4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3730E31D36D;
	Tue, 13 Jan 2026 16:04:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4103221F0A;
	Tue, 13 Jan 2026 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320243; cv=none; b=c9sUhNqDr8Ou8ewm21b8vtZ4GaKcLgauUKO3VJpQNukt/HBOY9X8pZ70bVAnul5VjkEXRHKePeHEvT2hjK+kkYRG/FpisfgsHX6KhkIgqOAzKW2c/SX3eG3bjlCcxlN0Ntqn0xABvTZCS3s/VyOPAy8TolGAxCTb4aOUmsK3ooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320243; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr5PQhcKaUCZJNfyTyotaNfRPi0BplvKxUXUB3J2hGyheDxvXA+PxpNuoLZjJ/+xlDWPOFmfL9rJWhPbeODtAmLFiOcEMlBvwwx7/IvtqSAsmLWcw7yIfGx2vbEJOWKu4o2yAa7+17H8gSuHEKd1r6Qh1PuzUGMfE4LQjWppDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 85028227AA8; Tue, 13 Jan 2026 17:03:59 +0100 (CET)
Date: Tue, 13 Jan 2026 17:03:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/11] xfs: start creating infrastructure for health
 monitoring
Message-ID: <20260113160359.GA4208@lst.de>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs> <176826412751.3493441.12925222831409584922.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176826412751.3493441.12925222831409584922.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


