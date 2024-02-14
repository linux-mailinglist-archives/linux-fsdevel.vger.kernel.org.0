Return-Path: <linux-fsdevel+bounces-11564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E7854C59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCD31F26A18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705D15C8F8;
	Wed, 14 Feb 2024 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="TCST81R5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264605B5A2;
	Wed, 14 Feb 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923635; cv=none; b=UiQHmDM1huA4LVt4xdZz7vAWdmbYDa+HANE9+RNeVsLgf4dPi50uwjy4Lp94QZ70HdRBAnz1rowmRDtO77kc07XpUcW3Ni7jpuwveDxUExt7HGAdwFAy2fjzlAUqFC+2hNHk056R2zceBnbf+8Na77Ro2jn+mvYfl6Zc34eA7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923635; c=relaxed/simple;
	bh=YZrvOoG/MWcP62QG5dmiEaqmC7ESHEdG/3cRjHuGR0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PO7uoBc8UrCmeCfHhe3lDYIjGubqqd8oZLfQZVa8nhYsg3kDs3X9UcO9ioZFzMuK6qsyntjKeRlQKLTZTh0B9B7+VYEU38zY7l6YjMdw2k3GaTjhaO2IObXVY8bECnsBd5fyUhe3nqEpX/+dHGi+WcYSZlcgksYPFhwHMRloPVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=TCST81R5; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TZhYB29bRz9snY;
	Wed, 14 Feb 2024 16:13:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707923630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ldsA1Vur6Y4loIv9sQgO0jyO815Ajgwq7+6DjRp+Xg=;
	b=TCST81R51nCEVYyQelZwuEoqgU7t10RyTjU6uTLiX8Za7PYnoUlK/AesCjUOa2WSuZsVlc
	IKtZhPyCmW329c5lWs8EBfLWk6RLCQNO6ME1J4VkjKbI/QphUHB/UcUwSYIknOWyUYhbkr
	gpeBGMRkf8hsqc/Oo4E9dIrji9Px1YhMnB/ri66eFqaNGzjZrHQUCeN9AGnaGYsqV+23nv
	+yq77nD5D3pSN3OOMQsCvofCxOOTJ3Fyj8K/fnfhsH3gxxVND9Q91w4IW/89iU2mPRlXFK
	F/k6j8An9WstBRoX5zHxLmhq31JXcysbNYYhvy/A+6I+VUFw/BnSV7CF3xRNfg==
Date: Wed, 14 Feb 2024 16:13:46 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org, linux-mm@kvack.org, 
	david@fromorbit.com, brauner@kernel.org
Subject: Re: [RFC v2 10/14] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ffm6v5ngsocxuyq6menwkdyjdxnukt7ehykij3e424hhigj43v@lnemlh5xazuj>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-11-kernel@pankajraghav.com>
 <20240213163037.GR6184@frogsfrogsfrogs>
 <5kodxnrvjq5dsjgjfeps6wte774c2sl75bn3fg3hh46q3wkwk5@2tru4htvqmrq>
 <20240213213040.GX616564@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213213040.GX616564@frogsfrogsfrogs>

> 
> In that case I'll throw it on the testing pile and let's ask brauner to
> merge this for 6.9 if nothing blows up.
> 
Sounds good. Thanks.

> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 

