Return-Path: <linux-fsdevel+bounces-59933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8995B3F4AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 07:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471321734C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 05:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40BD2E1EE1;
	Tue,  2 Sep 2025 05:42:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349412D593E;
	Tue,  2 Sep 2025 05:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791726; cv=none; b=TXWJW3Zg+wCKy6QVCR0AynTof44JsHT/s103geyhIDPTgXa3ihq13d3YpAt/jJjMAkFLEKI9Ec98XQK+XozVM2mfsdT8EDU0JzsxZDwNVtgPZYRqavLg0I/4kCWicPb4jV8a7B2/FzFSIshJuYremyc3e1nyxZI/S92hso9HlbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791726; c=relaxed/simple;
	bh=7/bfXO6QsTBpWtwR3vgXpTKEiK/2OEf207jQmoCshtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+g1m1U87zvid/qBBDYn/JJOY6wYU9KoGhgi6fCMO/yL39sInOwPJqdq2q5g1KbxOQ2AIWNFuAaeusCQbbhoE8bPV4z8srEy3fZCKn39l5zt8Bxs2uIR/+Bvi+EHmN70NZvJF7K87P6P5aX8a8+t518WeMQ8FuKmPgVRZQPsZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C495768AA6; Tue,  2 Sep 2025 07:42:01 +0200 (CEST)
Date: Tue, 2 Sep 2025 07:42:01 +0200
From: hch <hch@lst.de>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] xfs: adjust the hint based zone allocation policy
Message-ID: <20250902054201.GC11431@lst.de>
References: <20250901105128.14987-1-hans.holmberg@wdc.com> <20250901105128.14987-4-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901105128.14987-4-hans.holmberg@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 01, 2025 at 10:52:05AM +0000, Hans Holmberg wrote:
> As we really can't make any general assumptions about files that don't
> have any life time hint set or are set to "NONE", adjust the allocation
> policy to avoid co-locating data from those files with files with a set
> life time.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


