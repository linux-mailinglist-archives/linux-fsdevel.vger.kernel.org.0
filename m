Return-Path: <linux-fsdevel+bounces-46221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F9CA84B98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 19:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E53A7A04CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 17:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE91D28EA5C;
	Thu, 10 Apr 2025 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="MgKhBiI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258B28D84C;
	Thu, 10 Apr 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307174; cv=pass; b=TRdD2Dcd5PFdG+0A0LmZ8WBAo8Y7lj55t1psklGezT2ndtV2WePOX8L3Faa9tBx3cXetI6SLsQ3FPr4nLyhuDjZmSirbSvGf6NqnYk2LdUMeK5VBr0vxFIV8pfv+AGk8i7u1K+2cGMNqMJ6HhH8gKDhs2Po8IM3Uu9/top2ONPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307174; c=relaxed/simple;
	bh=uEbZwlPPg9IYz3mZAudwa/jYFoeS2LSfxPaSdvkbwXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkOOXkm78otWRcnrbOBJeZMNjh8knyg6HZmWx4cDrJWXCbx2/SPKlt1gE1sPR1fOhjUlmQuJNzK6i8FEOIT0iA5Ec0/aFHW09yYq/W5GJomWZxxR4EFt9EL0NQ7+x/ImFCk51RDOjolbB9Qdi/mDoIQtjjpTaxM9b3+eklh/9dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=MgKhBiI6; arc=pass smtp.client-ip=23.83.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0834621D96;
	Thu, 10 Apr 2025 17:38:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (100-99-62-49.trex-nlb.outbound.svc.cluster.local [100.99.62.49])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 352DB220B6;
	Thu, 10 Apr 2025 17:38:30 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744306710; a=rsa-sha256;
	cv=none;
	b=uhV8s97LeM90FJZx7fYvLZ2aM3MkjQvCNxSWJu5cPzWrEoybpyobLCBPSw0TcVB3Ym53dG
	BPPAmqwSSW9bwADMTpWdf+GMES5ZIExkItSKQ+QGOqr1R2ZMOuZcMg5MMsDoIDhSIFIZap
	0r3WFd8XbOp/hjl1OkN192IBL4742gSxUkKN97TJ5KJTujgYnWd+s+GQYda8zpAwskXdMS
	Kv0n7nD9b98vSKamED8RB/SFXS/0MNcmlHtdH0fXjE9K8DFYJxTQQ0T/7sxJXHAWM8r0Zm
	iQngS/sxpZ5jJ0vRRcVRoVKTJHkhz99h9VALfEVXxNeqU0aLeWrXhixuH18o+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744306710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YwxaJTg4VJbIYIQ6s+Ic7Nv7sEsm9q3MKFC0yNU64hU=;
	b=9T3qi4BdQ6ZKv4yqRKboQHeAH7oB08KMi1elDhXEW0rN5l0gAbNgd4H1mGec0yaeqoEobA
	D46cYxDqie/rDibiSw4m9PEYkCIiB13JECatTB6dWRC6jp9v/qk2aSZ3XSTepdan0C8kSB
	vIYydl3q/pP9haoVdAnTFHXd56N0XAMJBcGoyYM9DtkFKFqR0cOJIX7ADg191ZVNvWhJfK
	KeumgMyLAteDG2p1TF0BynPGOyis1SlOqvyw/XpLfHVwjvTz0d8jE5ME7LCqFlaC6cZNjI
	Nl++BbxOfvGRWwYeUq6R8fTHQfQu5ubKtzLgaMct9nMwPgDrTUUxiWNnTWrs4Q==
ARC-Authentication-Results: i=1;
	rspamd-75b96967bb-r662q;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Slimy-Language: 3f63b5ba177a6e50_1744306711855_2881099363
X-MC-Loop-Signature: 1744306711853:187796569
X-MC-Ingress-Time: 1744306711853
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.62.49 (trex/7.0.3);
	Thu, 10 Apr 2025 17:38:31 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4ZYRqm0bssz70;
	Thu, 10 Apr 2025 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744306710;
	bh=YwxaJTg4VJbIYIQ6s+Ic7Nv7sEsm9q3MKFC0yNU64hU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=MgKhBiI69HXrwf01/pCiEXtBE6JBwR9Y1Z5yfP3KyiTkwq2mmN5P0NyW2pRhAY1qq
	 YRo6dPXEpIV72q3digPVEezjwF3sCVOkocRnQhlUZDLEhOrpKaPERGmzF8eTUVZoDL
	 dZNPOCb2vetDceHq1sYqwupZIBXk5U/E1d6DiY6XtTn3V+jLKkVGfLkkWtC15L3AQi
	 JFG4NetVjuKrUx2mY0vEEXoJL4YfT6UIjj6lwkQA1KcW1wZ//zKsSfUH78sogpbkYD
	 S8CgcAdfyPBa7PH6fK1a7gEMXpPOIspd6R0zwok7cIml0IyPtZhMClXoHw3losIOZ9
	 LUW8qJUc51SIA==
Date: Thu, 10 Apr 2025 10:38:17 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jan Kara <jack@suse.cz>
Cc: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH v2 2/8] fs/buffer: try to use folio lock for pagecache
 lookups
Message-ID: <20250410173817.5cdlnnooxwgbkpov@offworld>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-3-mcgrof@kernel.org>
 <plt72kbiee2sz32mqslvhmmlny6dqfeccnf2d325cus45qpo3t@m6t563ijkvr5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <plt72kbiee2sz32mqslvhmmlny6dqfeccnf2d325cus45qpo3t@m6t563ijkvr5>
User-Agent: NeoMutt/20220429

On Thu, 10 Apr 2025, Jan Kara wrote:

>I'd rather do:
>
>	if (atomic) {
>		spin_lock(&bd_mapping->i_private_lock);
>		folio_locked = false;
>	} else {
>		folio_lock(folio);
>	}
>

Fine with me. I just think the trylock for the atomic scenario would have
given greater chances of successful migration, but at a lack of determinism,
of course.

>I'd actually love to do something like:
>
>	if (atomic) {
>		if (!folio_trylock(folio))
>			bail...
>	} else {
>		folio_lock(folio);
>	}
>
>but that may be just too radical this point and would need some serious
>testing how frequent the trylock failures are. No point in blocking this
>series with it. So just go with the deterministic use of i_private_lock for
>atomic users for now.

This acually crossed my mind, but I also considered the scheme a little
too much for this series.

