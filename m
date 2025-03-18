Return-Path: <linux-fsdevel+bounces-44255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0113FA669C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 06:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC663BB349
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 05:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3884A1A316D;
	Tue, 18 Mar 2025 05:48:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582522B9A4;
	Tue, 18 Mar 2025 05:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276898; cv=none; b=TGKQqk41lXdXjC4MaUpQRFLt1NS82W11x5DdAkKLbpEpb7cQjLb16y8DLLNSGf6Tgsjj4iDgvI2CzHFSaI8Kq1LcCiEcDqlK79HWQpjGnTDKi1ZxNtMhXSO8PZCqTOXyfL+ye0MheRYptbLBt3bTY4qQtF7xysMno7DNZrLKRRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276898; c=relaxed/simple;
	bh=PzCTHjbY0fUQicJKKISAkxkhKKZ8hkI5yL9VcpGAeH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC39fsR3++Ky7P2mzQlmn3qZsV4BCs2KHidecxjUsmwsIumZO29zN4wyNWPfnAi+PB53Fh5grNen8Xmv/LxlhspePb5JtXqBcO2rF9eKIu2TQh/OBFo0VkYXqfRYTeymNrgbFlqBZRqYO25r0F8gYVynD88IfFF8puE8xWCyelk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2977B68AA6; Tue, 18 Mar 2025 06:48:11 +0100 (CET)
Date: Tue, 18 Mar 2025 06:48:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 00/13] large atomic writes for xfs with CoW
Message-ID: <20250318054810.GA14955@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

As said before what I'd really like to see going along with this is
a good set of test for xfstests, including exercising the worst case
of the atomic always COW writes.


