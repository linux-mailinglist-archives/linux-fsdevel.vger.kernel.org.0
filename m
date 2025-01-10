Return-Path: <linux-fsdevel+bounces-38858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D448AA08E0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 11:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D481881DCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C0E20B1F2;
	Fri, 10 Jan 2025 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="MpdxHEIt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E751B4F14;
	Fri, 10 Jan 2025 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505047; cv=none; b=bP8gvzmQgrI5LpCtruns3LTOP1blB2scncLVo+QuAFjQYcdeZSGafkgJw7GPh886sqSs7F3SgHlQ3Cqv26wtTUIBDebfSV9JkPms8lg2Sw/q9YzzVbgr4Et9ZL4t4xT0Gn/iSm140tHKwg28ta4h1qhhv2nyibjcbngkPBB5HUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505047; c=relaxed/simple;
	bh=VqLS2m0Jp4rELFScyCJzI6NufkdvD35l4P55XysbWOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHaer68zSkcZ8DGk9CVM7ib56vucZoDSKTF7texfh4vl+Gkb+77605tlA9Dq0BS6twLGu/ifj1qZP/ybR2uoQKt6wQaKNsAf52nApUCpZXyCJ7y++91BAdoLKZMntY0xJof83XnwxPmsnnVNbZ22ckM86BsGzfRMhsQmZsf3daU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=MpdxHEIt; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fPPBrxOFG710mad1JEFyz6crD1/I53BWSyTyxrGq+DI=; b=MpdxHEIt2Dnv6prdqzslLz0Rhk
	diXqwCYfGo3KuTYMxTzw2c8Aem4e5Mqk2GLtEBVq6FTn4pWBGuKiCTHkpL1sj02fGUf/9b61js22r
	1qntFve3Im1T/XefyWk707spRQSRpr85XxtvxRtRGTo2b0CxmwY6ehGxvDLLNC/z+st+8hGTi2yXR
	V1c1SOXuB/T5WijxN7PDYZ0ra481b1p27kX4wC4eL57RCWHHTD8rpPE0O6lH91BeOqF0sbAZw4ew8
	9tB2W2IFkNGgIUfgeLmEvvO0KCMGRl9tkBcC67bCBOBrGB/jRQcfuEx5umr0/dECdvXPC4Uybel6D
	FQgowcng==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tWC4V-007oOG-2u;
	Fri, 10 Jan 2025 18:30:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Jan 2025 18:30:16 +0800
Date: Fri, 10 Jan 2025 18:30:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] crypto/krb5: Provide Kerberos 5 crypto through
 AEAD API
Message-ID: <Z4D2uC-kcSzQJS-H@gondor.apana.org.au>
References: <Z4Ds9NBiXUti-idl@gondor.apana.org.au>
 <20250110010313.1471063-1-dhowells@redhat.com>
 <20250110010313.1471063-3-dhowells@redhat.com>
 <1485676.1736504798@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485676.1736504798@warthog.procyon.org.uk>

On Fri, Jan 10, 2025 at 10:26:38AM +0000, David Howells wrote:
>
> However the point of having a library is to abstract those details from the
> callers.  You wanted me to rewrite the library as AEAD algorithms, which I
> have done as far as I can.  This makes the object for each kerberos enctype
> look the same from the PoV of the clients.

I think there is some misunderstanding here.  For a library outside
of the Crypto API you can do whatever you want.

I only suggested AEAD because I thought you wanted to bring this within
the Crypto API.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

