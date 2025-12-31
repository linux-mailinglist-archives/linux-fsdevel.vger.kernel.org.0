Return-Path: <linux-fsdevel+bounces-72266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD74CEB580
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 07:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E36B3020C5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 06:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EF93101B7;
	Wed, 31 Dec 2025 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="TqFH4OyT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87914F9D6;
	Wed, 31 Dec 2025 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767162622; cv=pass; b=X3csUeh0F+j+jVqg/sSwvT9ayNLgoRkSifQr+xKIEM04k7RbGbquJkTWTzzaPjrSh+x6SWe197Vp2gTIFkFXk1SMS/htLPLcuJK624Y8Njop12e7guLuI/ppK+H9PXNQRpJHmBJB+SaNyIRUCh0wsN8cnRI8FW9JneLDGb2Odv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767162622; c=relaxed/simple;
	bh=/bMTuBTfwdUlXom2vi3ezJLrXtj7KJIJpZH7lSCprK0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKcljvXdHSdq0+OyF0HkWZ6ldFHx9w7FoCvoQjOFcpqNTfCboqWiOGYwyARio4pBmSd8HDjxoph7MSfdK+CfKaugliveaWly4fqCpjTUZJCewOcbnvxWZMcc5Y43vBVOTwXlzAZbFDtvhWKUg0v4R8cAKmXDNtLf93ZWuE649zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=TqFH4OyT; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1767162590; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hrQB5eqSwsTKw3YcGEGvWB/cQYlruo8a7Bmy1dxhxpZlYFIN5wMXnVW3orkfqA5fZs9qbdPekYmm4qM2+WEY9Q2uL0LXKlZe+s5ciARLB6/k02Ahkg1OTe+SsZtZtDe5tCOt4Yjh6vhpcZdiN5iZkrcydZod/0DAs/bOhP7Pdqo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767162590; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/bMTuBTfwdUlXom2vi3ezJLrXtj7KJIJpZH7lSCprK0=; 
	b=bUUBgDmBfKeEAtqs9L1s188nZtn6WaJlavnOysN0TNfM2lyZK1MoqLXioLLWsf6RG5guGPtMwHpnab7jkCkUqmfeqeErbqAxnRs0KtxQs36KDMU2osM+WpwrUNBIPre0mzvj70xpCMaUp875maXbbazuDS4awg4disjRJr3TlsY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767162590;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=/bMTuBTfwdUlXom2vi3ezJLrXtj7KJIJpZH7lSCprK0=;
	b=TqFH4OyTSEMeLvYcaSEH2BfnQVyqO7znegWDLucxWwMaPq5ZrTKPLQwsS0n3TGTH
	gNRGGw+tL8LkN4sUFQOnMuav8xm4XTxL+R5xfBgjQR/7Qwgu4yGabMticBdlbYQMW7H
	7KRtBRojbSwrAk09kN0ouN4IfDveiVFwg+f4PtJk=
Received: by mx.zohomail.com with SMTPS id 1767162588754117.84424966320421;
	Tue, 30 Dec 2025 22:29:48 -0800 (PST)
Message-ID: <b2b99877afef36d9c79777846d19beeb14c81159.camel@mpiricsoftware.com>
Subject: Re: [PATCH v4] lib: xarray: free unused spare node in
 xas_create_range()
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dev.jain@arm.com, david@kernel.org, janak@mpiricsoftware.com, 
	shardulsb08@gmail.com, tujinjiang@huawei.com
Date: Wed, 31 Dec 2025 11:59:42 +0530
In-Reply-To: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
References: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Matthew, Andrew,

Just a gentle ping on this one.

v4 has a Reviewed-by from David, and Dev and Jinjiang both followed up
with additional observations and ideas for related cleanups. As far as
I
can see, there are no outstanding objections to the current xas_nomem()
/
xas_create_range() spare-node fix.

If this looks good to you, could it be queued for inclusion via
whichever
tree you think is appropriate?

The separate question that Jinjiang raised about empty xa_nodes
installed
by xas_create_range() but never populated is being discussed in its own
bug-report thread here:
=20
https://lore.kernel.org/all/86834731-02ba-43ea-9def-8b8ca156ec4a@huawei.com=
/

Once this patch is accepted/taken, I plan to follow up with a small
cleanup
patch that simplifies the label usage in xas_create_range() along the
lines
David suggested.

Thanks,
Shardul



