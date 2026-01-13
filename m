Return-Path: <linux-fsdevel+bounces-73466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A59FED1A246
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1CEB300F695
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3F225EF87;
	Tue, 13 Jan 2026 16:15:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC47EED8;
	Tue, 13 Jan 2026 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320959; cv=none; b=kwlJg1uOckoUj0LDHR7x8ZcXFaQHG13VfBs6GfIYDmWQ23W0ql4t/8mv46Z1CDYUfufPOI1nqzNTWDGxOLaTQkp73D5zqahpyTi23TR1EcxTw1iyMK7+aBgMM5oZI4cAiT2kc5bbNatiw5huPbDwF3OiW1icoqdnKshkU+RnSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320959; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIGfVJX3d8mdYrpic5JbBvAhQqnjDM1BhegW4aUa6R+oQ3rwrYsuA2bQYrdFHwQ3hc0RlOlgPuu7miU0954ZhhWCHtFCunHQCjP+rCtfnwk67bHenOv4e2LQaJK5nDDn1mlEJWEJwqfJ+S86+APu78yTu7x5AiJME6YdZlasz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 48BED227AA8; Tue, 13 Jan 2026 17:15:55 +0100 (CET)
Date: Tue, 13 Jan 2026 17:15:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 08/11] xfs: convey file I/O errors to the health monitor
Message-ID: <20260113161554.GB5025@lst.de>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs> <176826412878.3493441.7431621459792695153.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176826412878.3493441.7431621459792695153.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


