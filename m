Return-Path: <linux-fsdevel+bounces-11304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700EF8528D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFAC283A9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E9217573;
	Tue, 13 Feb 2024 06:23:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C7717548;
	Tue, 13 Feb 2024 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805424; cv=none; b=DyH9rE/+4P9KMt2ncdjxwm19eed6so1CDp9Rz6yH2+C6PfquMf22RtEHi6S1LpomkoHjQdGTrg3iwO2+FUkRBVbluFW5bT11pOgsDy167AE7EK6nODmEl/X8A5fsckpqTBwR1aPZXX5aby0uRZzNdIvH5VZ9M1VfqmXGyVqa+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805424; c=relaxed/simple;
	bh=IsEeikE90VXLdYJawOPuekL0OaW+Rxcr4XYKD6QABxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4tIQrDX9m7o0QlVm9KeQQRNA7pje6FEN4x8v11/NWGJuwMFK9kbWpyHLTSQQfp93vzoLj2JbqdtoHZnFnJPdqbUpZCMcoOBcVfGjzO3FYGg6pgbUA38BDh4qyhFCnQ7WwoCKFVRcnNXrK6PAbhlRB36kEVOhVp6YDqthDcSpzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73E43227A87; Tue, 13 Feb 2024 07:23:39 +0100 (CET)
Date: Tue, 13 Feb 2024 07:23:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v3 06/15] block: Pass blk_queue_get_max_sectors() a
 request pointer
Message-ID: <20240213062339.GB23128@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-7-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-7-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you move pure prep patches like this one to the beginning of the
series?

