Return-Path: <linux-fsdevel+bounces-47594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D15AA0B71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 14:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BC0465081
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF92C377F;
	Tue, 29 Apr 2025 12:22:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F82C17A7;
	Tue, 29 Apr 2025 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929341; cv=none; b=cez+BQFQVswv0thvBhVIHMNpgGyF88TI5tWmQwVk7i/IglasNNd6CDPmSRZ0fffOYUQiYjkBHR5UuhlrtcGRPdurVzEz1iAUj6NY56J2Qk1eZbIITjXArnx9cHLnrYvbU3LBZzIphM+kxD8f6efEZgsspwPEvBhCBSSIKPMt300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929341; c=relaxed/simple;
	bh=R+p9xek5Bi/dyUtmYQzFny6c22QnYWCVJZGIGmRmAk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz+bYVe8wLcalcX0J/QUkH69qwaKrPykm3j4w6U3AU+0iXGEnOqfQdsUHXYEXH+f6reVSlD4i98LOMVZkF2R29pa87vr++6KW0Dr1xAyH+66F3OnySnL9zNi42w0CunxaxBT42aXBTJX/3fQrGFkEdHNJzYxFVRBfRXy6jRi47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A372F68AA6; Tue, 29 Apr 2025 14:22:12 +0200 (CEST)
Date: Tue, 29 Apr 2025 14:22:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v9 15/15] xfs: allow sysadmins to specify a maximum
 atomic write limit at mount time
Message-ID: <20250429122211.GB12603@lst.de>
References: <20250425164504.3263637-1-john.g.garry@oracle.com> <20250425164504.3263637-16-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425164504.3263637-16-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

So I guess the property variant didn't work out based on the replies
from Darrick last round?

