Return-Path: <linux-fsdevel+bounces-23167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13D0927EA9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 23:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA4D283F7F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16751143C40;
	Thu,  4 Jul 2024 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="gUdkDthW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3334143872;
	Thu,  4 Jul 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720128901; cv=none; b=bb9SNoTw3My8b3ncwRykfG1ieMfIDDZNCL5A6oxynXEEcw9KKTQ8ACwYLCg8tSUF7ChXb9aS77XkzR5tw8c7pwackNmQHUK7s4cXK7E8aVkb34xiGekydgrILBzN5Gyrk6DfwLlienCNKnXqKbpsicg9TuSKnio9F375QNbVZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720128901; c=relaxed/simple;
	bh=4t1ZICfklUF39w7K3Bc20IHfI61xmA9iQG1ClBrC5DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2WPisOkzXclRleXJfWnYIF4RgoZGjd5vJFuB2bPbMwvJ3BhLpMVzZpGDhIS1acE7dWkxbvzBSerhXnjsY3kjEr3x5M20JKCN5TV53156Pz/D7YmEozjxCnF+bq78i8v/9Q9pyeDLk+iX75ZspYMV/JhlxXfdyRHIkdxYz5pRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=gUdkDthW; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WFVKq5gf3z9sSx;
	Thu,  4 Jul 2024 23:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720128895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4nqeguYiwGj4yC0V8xFrII7E3d9fSbG1e0CN7cOg21E=;
	b=gUdkDthWvGQFlFIBRRacgtdXClnQSaAq4fqo2xjg7JgkJ2SfkAuEuxv/KugTqBwKuyMN92
	V6TNoVnLfos+5Y9/xkfnpGHdt61pdeQQb99vEIrGLS1cnOJ3j6aOdv0Ly3MdWBnJWB/41r
	tD/SEuRnxAqtY7SKNTMHWFQ5YV9zp/j8e47jxsqK7ydxiE7WfWVDx3V659r02+PMbxV8a3
	UJC7uIBr4avY42eljdlL7M+TUwQr6aIEfVym6ZZRuJoTfgnSiXqXVQUjdJ7eHayAnH6+GD
	ZXRiqxHqV1qGUDeH0BxAvaIoQb27NJA3oFQz9tfM8WWEIKLJ3Ey6T+fXwRuk3Q==
Date: Thu, 4 Jul 2024 21:34:51 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240704213451.y2oc2f6ie5wmhmcs@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>

On Thu, Jul 04, 2024 at 01:23:20PM +0100, Ryan Roberts wrote:
> Hi,
> 
> Here are some drive-by review comments as I'm evaluating whether these patches
> can help me with what I'm trying to do at
> https://lore.kernel.org/linux-mm/20240215154059.2863126-1-ryan.roberts@arm.com/...

Just FYI, I posted the 9th version[0] today before these comments landed
and they do not your proposed changes. 

And it will also be better if you can put your comments in the latest
version just to avoid fragmentation. :)

[0]https://lore.kernel.org/linux-fsdevel/20240704112320.82104-1-kernel@pankajraghav.com/

