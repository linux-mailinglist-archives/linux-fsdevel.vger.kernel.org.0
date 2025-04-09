Return-Path: <linux-fsdevel+bounces-46067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7EBA82295
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 12:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B95881E64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B52E25DCEC;
	Wed,  9 Apr 2025 10:46:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84825DAFD;
	Wed,  9 Apr 2025 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195561; cv=none; b=WVAxm5D+XmLqgf8b3frxboyo1IxXujsSHiNN9G5ujqtOnI1jGqeKn203i7pwgezxqMIga2BlClVBuQU/a1ywvqx5T0/e8QDr7bYTcfsZX5ZJpwrOcSaNVBeB76xlgwc7z8gGFGUTX0lfTl8lxpeQZBMm1YXVInNf0gqXkiJ7rpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195561; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmK2Ud0rm6RA6ZLkuQFEg6APZt8vtrzDjKc2zeiQJ6JZ06dfvZS3m8sU43oZ8bAsRNz+aTPJPVU82xmShtAqime4ZESWZoUZw6nGURWTsXklh75i3wfxjMrj8WZ+fXCKKSj7857vW/klX3cTEReWMEZErkV15Hmgdd1Amogx0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9413E68AA6; Wed,  9 Apr 2025 12:45:56 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:45:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v6 01/12] fs: add atomic write unit max opt to statx
Message-ID: <20250409104556.GC5359@lst.de>
References: <20250408104209.1852036-1-john.g.garry@oracle.com> <20250408104209.1852036-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408104209.1852036-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


