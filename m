Return-Path: <linux-fsdevel+bounces-57329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B18CCB2081D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858AE1894A59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536D72D29D8;
	Mon, 11 Aug 2025 11:46:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C711E5219;
	Mon, 11 Aug 2025 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912769; cv=none; b=VB5UnCSgjcaINOkul7diZeI4pNOtuykD3vC7xwGGHMQn2Bqu1ajPy3HYD4WClfWjy3KVlpKZ+qpQl+B38TiGiMqg39FjWK1d8frwW+wLn5U+4MpjFgi7lI1Ocdt50fgG1XBV0G96SW5Tc7K3VIEf67kh64PvxBDGokhpsAW+KFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912769; c=relaxed/simple;
	bh=AGj83JSmx4WTFFvosyP53U7jrIvk/cdStHsWay2F2no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3Gti8iilmVyFK6JCXF/68uld7loUq3ODK5X4zfUCvJTT9HhGZRrisOpsQvJq6evoZ53Kl4dZFfc0y8UoOB+SGQ+EJuvYZ4Z/4yOgPGBMk9gttoocZ7cfPL0/DwhaRfsUp84Za2IX7v8/tuT7kzv/oVXTHssO8LJX+7G9NjN6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F9C4227A87; Mon, 11 Aug 2025 13:46:04 +0200 (CEST)
Date: Mon, 11 Aug 2025 13:46:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org,
	ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH RFC 06/29] fsverity: report validation errors back to
 the filesystem
Message-ID: <20250811114603.GB8969@lst.de>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org> <20250728-fsverity-v1-6-9e5443af0e34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-fsverity-v1-6-9e5443af0e34@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 28, 2025 at 10:30:10PM +0200, Andrey Albershteyn wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Provide a new function call so that validation errors can be reported
> back to the filesystem.

This feels like an awfull generic name for a very specific error
condition.

> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Btw, this is missing a signoff from Andrey as the series submitter
needs to sign off after the author.


