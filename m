Return-Path: <linux-fsdevel+bounces-54917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F3AB0516F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 08:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045AC7AFEE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 05:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D032D3737;
	Tue, 15 Jul 2025 06:00:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA269D2B;
	Tue, 15 Jul 2025 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559251; cv=none; b=FbnamxasSYxJIpcfAJuBkC/8ABudStHA1FOHPAKFSrfmH75RI+Sh48pMhEZlgM23whopq+Pav6cGx1qCv+7mKR1inqNX0bCFkQu/VhqI0ZFtDck1b3UgNNUH9T+Gk7NacBzL6ApUFFVwxUSVzB1QIackVVoBnAPRQbeyJP6P07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559251; c=relaxed/simple;
	bh=UTQdv82nAnyMvPkS8LMxls/Ff7cjnteoJ6egiOBN98E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAekR7v47/eZDrA7aFFDbpC+na1Sgv9kJx1zY3o42mz+X0TWVxenRamY66m1537zIa+179ytRXd+j2GGmw5XrSps5PjxSdvHz6SpVgMJE6iA0Ph+fY7aWql7FzCXYa1MF1LngxgbXu1S+0E6cqvyMn1Jcl/N016HSK7+zOqmz/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0750D227AB8; Tue, 15 Jul 2025 08:00:46 +0200 (CEST)
Date: Tue, 15 Jul 2025 08:00:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
	John Garry <john.g.garry@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715060044.GB18349@lst.de>
References: <20250714131713.GA8742@lst.de> <20250714132407.GC41071@mit.edu> <20250714133014.GA10090@lst.de> <yq1h5ze5hq4.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1h5ze5hq4.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 14, 2025 at 11:22:43PM -0400, Martin K. Petersen wrote:
> For PCIe transport devices maybe we could consider adding an additional
> heuristic based on something like PLP or VWC?

What would you check there?  Atomic writes work perfectly fine if not
better with volatile write caches.


