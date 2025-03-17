Return-Path: <linux-fsdevel+bounces-44170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2169AA64147
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 07:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37C5189137B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 06:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050DC219A8D;
	Mon, 17 Mar 2025 06:20:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D94A32;
	Mon, 17 Mar 2025 06:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192432; cv=none; b=jypu6849mRi4Gr4mvkrWtnAVJTdXbS/6LAHB5WDhj7wdmdgKlavJuwQHa7Rg4LbtVVM/rgi/ta8sPz/N4DYqL7IlubXoNMUyCdZOGxngE4YhBxT7y1tEgJ6h7tKg0CwcU4RT9rIM22yVFP0TMIr3QZ6fG0kSDvJuaTSkifm1hDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192432; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKH1C4hHp1w/CbvRnhwKMYhx1jxFsHOb8mDfsTWGKY6myaaQibjM1LZcrZavsY0xSpE4JujanmR0fo1In4Lhn79MW7kiRa4wE0XYwXE3TQJp6WLxeiQKulBIKJfq1ouAiA7LBdmDu8kYd6zmlFWEndZVuDHSkJwMjEaABn7nnyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4340968AFE; Mon, 17 Mar 2025 07:20:27 +0100 (CET)
Date: Mon, 17 Mar 2025 07:20:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 08/13] xfs: reflink CoW-based atomic write support
Message-ID: <20250317062026.GH27019@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-9-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


