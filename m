Return-Path: <linux-fsdevel+bounces-77717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDWzMPggl2kJvAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 15:40:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DACF15FA9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 15:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29CA13058E06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3D934028F;
	Thu, 19 Feb 2026 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrV5OvIL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t1Ux0xFC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB033FE0A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511943; cv=none; b=swT3QrrgD13I7ekPoXeY75eGca7xEPtnI0FrII0wDEffEuDTAok2C29/4I8qpZTdGQS/4VK5Z0gALrYFsp/Sesrf71y1dcN7fh6Hv3oI7TgnJMmTy1r4jVWg9ulMJX3/nlmiFCIwi4DLmRAGeymVqIVItFs0NjLw8r+DW92X31U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511943; c=relaxed/simple;
	bh=hCUdqdVshUNpKJ6Web4N76YggE/6UrANGx8QiLFPLC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFFDo7KeCHgeSN3NtPfTeiUd5gBsmYNIGz2Q/xuhx5lFcMX8xIYoYPdHx0dUlhCs7LLQu+bkAlVvdFolgZ6MBR4VlxjqvKZC0NLEazEIeB467PnXgwfw5L5lr307Mo5Nz9YEG0nvUo0ieJjwXY4M5BQNycHXrTD2mSjwWslH8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrV5OvIL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t1Ux0xFC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771511941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yOvhpaX9tHlMkNrihwcrkfHtkKySAiNqounN6tlAxUk=;
	b=UrV5OvILmUjaOV1JBoNbAbipz3KfUMi+GhSPsj7ydGMtlqrXFAk+WPa3MkxnMDjnY1vWIP
	bh1xGWRM8K1KBlBRrHnFWi2s4291JfbG/BAAzRO61F7f7zlF20MIqoURG/2i44qG6HjBRf
	OdRVx3AZaEEDmWWt6KoqYt7Jk0u1Da4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-VdSIBmunO1atdghaMIDW4w-1; Thu, 19 Feb 2026 09:39:00 -0500
X-MC-Unique: VdSIBmunO1atdghaMIDW4w-1
X-Mimecast-MFC-AGG-ID: VdSIBmunO1atdghaMIDW4w_1771511939
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837f288194so8807735e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 06:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771511939; x=1772116739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOvhpaX9tHlMkNrihwcrkfHtkKySAiNqounN6tlAxUk=;
        b=t1Ux0xFCV1rW5RTJ8+lMNe/oLz/sKTovqAUbWiR1xnyjFhcTB6suXxfPPC7AXahwEZ
         pZReHIbwUOtp2IsB3grTGBGs0ziOHgDLblPT4WQRhFlrcDig+Zj5zhi1P/0VaRT4J3Gy
         KV0yFkN63Cw3sqgqkld/xk6ADgVVKLD0NGtf15Gt+pPVy5sNr6ux7pmcWvBMBus9GIWa
         7nwKow5JoM0ru9wt6aWZqdYVcZs/LuEvMdh+nbNs8/nBVBrxd2qT9qPTU2DzXQGLCrF3
         9wrX04/ky4lth05UfAx+1xrIVkBgmK/fpVgjpDdp+LedieWaeAuCgiXZVo7zWT1gJYI9
         5lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771511939; x=1772116739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOvhpaX9tHlMkNrihwcrkfHtkKySAiNqounN6tlAxUk=;
        b=CVDmR5YVvKnIc2uIIJiowJp5LGGFop8IqDsglXUv8xlFakOeK0A01dv3YMr+48SgOS
         56RbpePSfCHMHQUdIuLytRLNrmGVyQfwzZfOnDv63F7NVRExIwf4I4g/raoH2Q6FUNTB
         A7HSoM66J01ZQkYg6hXm4qgVWyq6MXwV11PLlDW/kP+gibg33Mc/vxFq4yxPQnPVPD/k
         Fw8G8THQkZRprzVooEgx7Wo8+l5l9KjjmHKehu2indNp88Y6Q1O90hwVSl/XYDlPV6Vl
         QUCaNmhQqeeqXXfOG04SR2DxZ3rQ8zVBQ0K4UuKRpoN2DyLEgtgUpMmoaXKbq827x5To
         IeaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEcNiwEYVnOhpmT+4A1IutJDu08sbIJqSdHIpTNTVD2oZgLJ23mIr0wrw/zCGs7cmUOM7AJbEuA5iAUtOS@vger.kernel.org
X-Gm-Message-State: AOJu0YyslUCxHGuIwa9hj0pHHIiWrOJqQB3tEFJfDs8Tb4ruFd+JxEfv
	M0wkP89lnin6oF8y5qkyeLkRnfPHlj/Z1cahplxt2otDwmmbign+WLm7XHycyrl6vFfgxvTFfwN
	siRPfQYAesO9mlpmNlgHepGf6dWmlW7ny06dGFzSereHEJNpXbCc0xYa9pt/BHg47xg==
X-Gm-Gg: AZuq6aKogBpvBC0sw18uUarQzJOPGYTdc+KblVZB46gu5uQq5EnS8PTg7rOOyzgosvY
	VgyQuVvdCl88xtmcCvYABOdaJoDq4rP1kBt3o7jTkhmfJl0iSfHi5hDfkjHr7HqS/Ftr0ZkYe+S
	FNXRrjiDjEmVPj2DqJimfBwOfd9vOnaAX4PIhg/lipCVok6I2n79YlmN6R3D0Y/1lhio1etmiXI
	TsPIV3o9t3N65lPqFqcaDjilALINITBd0pEMidI+uXaL7HX3TZd4kJkT7R0A8Z/fTLPHSyB8nBA
	nCvCYap0vWCCQJKxStSjJDxbygKIKRmvUn2pROZ2XldmZo5CkOL6RnIEg6AMhiHOHpHx+v3VjSK
	5ZQ2HeBCUSG8=
X-Received: by 2002:a05:600c:3b8b:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4837104307amr424149585e9.3.1771511938925;
        Thu, 19 Feb 2026 06:38:58 -0800 (PST)
X-Received: by 2002:a05:600c:3b8b:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4837104307amr424148955e9.3.1771511938404;
        Thu, 19 Feb 2026 06:38:58 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839e82f8bfsm41235955e9.1.2026.02.19.06.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 06:38:58 -0800 (PST)
Date: Thu, 19 Feb 2026 15:38:57 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH v3 28/35] xfs: add fs-verity support
Message-ID: <5ueyigipyfwqvysmx6ejqxpclu3oiy7wwpftnfsnyanu7z2abq@dnceynnumjh3>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-29-aalbersh@kernel.org>
 <20260218064429.GC8768@lst.de>
 <mtnj4ahovgefkl4pexgwkxrreq6fm7hwpk5lgeaihxg7z5zdlz@tpzevymml5qx>
 <20260219061122.GA4091@lst.de>
 <4cmnh4lgygm4fj3fixsgy3b7xp2ayo3jirvspoma6qxusdgluu@nyamffhaurej>
 <20260219134101.GA12139@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219134101.GA12139@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77717-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DACF15FA9E
X-Rspamd-Action: no action

On 2026-02-19 14:41:01, Christoph Hellwig wrote:
> On Thu, Feb 19, 2026 at 10:51:14AM +0100, Andrey Albershteyn wrote:
> > > > fs block size < PAGE_SIZE when these tree holes are in one folio
> > > > with descriptor. Iomap can not fill them without getting descriptor
> > > > first.
> > > 
> > > Should we just simply not create tree holes for that case?  Anything
> > > involving page cache validation is a pain, so if we have an easy
> > > enough way to avoid it I'd rather do that.
> > 
> > I don't think we can. Any hole at the tree tail which gets into the
> > same folio with descriptor need to be skipped. If we write out
> > hashes instead of the holes for the 4k page then other holes at
> > lower offsets of the tree still can have holes on bigger page
> > system.
> 
> Ok.
> 
> > Adding a bit of space between tree tail and descriptor would
> > probably work but that's also dependent on the page size.
> 
> Well, I guess then the only thing we can do is writes very detailed
> comments explaining all this.
> 

I have a comment right above this function:

+/*
+ * In cases when merkle tree block (1k) == fs block size (1k) and less than
+ * PAGE_SIZE (4k) we can get the following layout in the file:
+ *
+ * [ merkle block | 1k hole | 1k hole | fsverity descriptor]
+ *
+ * These holes are merkle tree blocks which are filled by iomap with hashes of
+ * zeroed data blocks.
+ *
+ * Anything in fsverity starts with reading a descriptor. When iomap reads this
+ * page for the descriptor it doesn't know how to synthesize those merkle tree
+ * blocks. So, those are left with random data and marked uptodate.
+ *
+ * After we're done with reading the descriptor we invalidate the page
+ * containing descriptor. As a descriptor for this inode is already searchable
+ * in the hashtable, iomap can synthesize these blocks when requested again.
+ */
+static int
+xfs_fsverity_drop_descriptor_page(
+	struct inode	*inode,
+	u64		offset)

I will rephrase the first sentence to make it clear that this could
happen for larger page sizes too.

-- 
- Andrey


