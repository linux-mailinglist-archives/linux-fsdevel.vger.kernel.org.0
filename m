Return-Path: <linux-fsdevel+bounces-16023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD609896F18
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 14:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A431C266A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 12:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A103141991;
	Wed,  3 Apr 2024 12:43:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE25B66E;
	Wed,  3 Apr 2024 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148180; cv=none; b=HHTGNEcmptx253Le4I1YbcGUGdf1Ruof74WA1fc9mnJ7/mFP/rzMKlz0P1PPP3OXmI4MhrRbSVvDN7njam4eieDTRs7lBH8mZYRrF7+PPy1XhOUYlJ+/jMyAevEikqf57bUkc37rWVGU5YwzrFKNFSTOzsO1wD3MVZMRfJ6Zibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148180; c=relaxed/simple;
	bh=+2kamjfwtkFt0LAAmEoSTRJDAwg1G6K9WUXA14RcVnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HS8j9Rzxwf3w6lvdz7lh5cHrFDTiPA2hUoUa/x8Lc/54Xk5wkcwwhb/zSAE9d3cH8y6aFfx4fRFZ4uBoBg0LozYD3dtH12vkX7NIfpSVAM3yA4lHdnudI5dh4XRWfHxG47qPe5BQ7pV4g50h4NFZhRpHly06BDe0vfjrmI0L2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8DB5D68BFE; Wed,  3 Apr 2024 14:42:55 +0200 (CEST)
Date: Wed, 3 Apr 2024 14:42:55 +0200
From: "hch@lst.de" <hch@lst.de>
To: Dongyang Li <dongyangli@ddn.com>
Cc: "joshi.k@samsung.com" <joshi.k@samsung.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"hch@lst.de" <hch@lst.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC]
 Meta/Integrity/PI improvements
Message-ID: <20240403124255.GA19272@lst.de>
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com> <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com> <yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com> <ab32d8be16bf9fd5862e50b9a01018aa634c946a.camel@ddn.com> <0c54aed5-c1f1-ef83-9da9-626fdf399731@samsung.com> <d442fe43e7b43d9e00c168f91dcfddd5a240b366.camel@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d442fe43e7b43d9e00c168f91dcfddd5a240b366.camel@ddn.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

In kernel use is easy, we can do that as soon as the first in-kernel
user comes along.  Which one do you have in mind?


