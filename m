Return-Path: <linux-fsdevel+bounces-73457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E56D1A0D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34C71300A34A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD585346A0E;
	Tue, 13 Jan 2026 16:00:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80AF346E61;
	Tue, 13 Jan 2026 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320010; cv=none; b=sXS97n+Rr0rLG/aPRQZ/6XICO4+80ALVP4Fo24jf41F2UsuP789gviTE3aC/271tHm6CJ2NFjbp4JJqarGZtVHrCBHJrULwDEeLHBB4/vSN5h32CCoXFsbqUXlFBK8isiTvbUb+mdesB4S5RL+IjRRykvD+IvU6o3hVoWp96dkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320010; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrfsLjAl17dcmmtki4Kj1L29Rw6TSf7JQ8bNeMqvY9U/IXRezaCMk+uaSwy0P9ziO7hzgoHH3TVqAZBTd5YCwCDeG3je5SIj2qKsh+cd5cHBZHJmhONjtUNtDysy53sVSv787DnFzxJ4IVj+OnRLPSEpBZjqrdwyvcWu3zdQp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B02EE227AA8; Tue, 13 Jan 2026 17:00:04 +0100 (CET)
Date: Tue, 13 Jan 2026 17:00:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/11] docs: discuss autonomous self healing in the xfs
 online repair design doc
Message-ID: <20260113160003.GA3873@lst.de>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs> <176826412730.3493441.2877993876987708286.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176826412730.3493441.2877993876987708286.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


