Return-Path: <linux-fsdevel+bounces-42891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE6A4AF63
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 07:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B3C3B2627
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736E1CAA87;
	Sun,  2 Mar 2025 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="ER9PnGbj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6662315A8;
	Sun,  2 Mar 2025 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740895834; cv=none; b=jqyEEcDHxJz3fn/HDfcXSTki6ZwVFNK8EshpZo25nZMc8dksmfm3MKzbwHc1kyEfxNrj0Rox0bUqm6tfPn6jq4Nzueo2GZTdKZBCfcZXDWJ6d1N+1YcIRqEjy5pnZUpq/USYTipcKH58hQZ/hDQ74rW7pwKBx+MUrx93CDNvAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740895834; c=relaxed/simple;
	bh=JoCwhW2kedYhm5VZxvqYJTAzDu/galJk+5XSV8Q/EsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvPFOu6v9u1vPZSl74EFa57x9bRviwHJ8kXN9hwkRDVjJ0yC4KlNsA2XnpBlAI8f8exdVxKygmSgruitbrhhs5Fy7IthHm3nXszoVzP0l2w/gSTDpEIrWT3r2gd7f3zvYmMWFSRKT8ibsHMTwHeFSfNGGQ2e+srp1XZchFB6eB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=ER9PnGbj; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4JDdLgOIRKP6MkDwL0d2OG9t1NrXyqQHEitlHLvr074=; b=ER9PnGbjfRxn1mAt7YKFNq8TmC
	orXqJlek/iL3VRobrFCqBXwW9DvB3DORKVURCZ8VI4u1M7CZ7MZ1jSZgP3I5JLpcOU6uc9e3VLPqn
	f5QrUwu8LVaxvFub0uNGhuIjnAo5Q6IAVUe5JnaxHOAe1Zk5ZvgWoLavvejX28kg5dsf8uIkIRqBr
	3rfwraq9sBcRmfhQY0J1qA8dTtlgW2CBued7o2KKMCzckQZyneO0XfgxtS2QEV2tq3qg435eUWpdZ
	UdwMKnf+Tmh2ONUorVluZRyoIIbJG4ryJog6cyqs2vQ8ex1xerrL1QnuY4RleK/x+iHDCCqvN/jvH
	LvtlOnmA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tocWN-002zOO-0v;
	Sun, 02 Mar 2025 14:09:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Mar 2025 14:09:51 +0800
Date: Sun, 2 Mar 2025 14:09:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] crypto: Add Kerberos crypto lib
Message-ID: <Z8P2L6nZGUEUiNwS@gondor.apana.org.au>
References: <3193936.1740736547@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3193936.1740736547@warthog.procyon.org.uk>

On Fri, Feb 28, 2025 at 09:55:47AM +0000, David Howells wrote:
> Hi Herbert,
> 
> Could you pull this into the crypto tree please?  It does a couple of
> things:
> 
>  (1) Provide an AEAD crypto driver, krb5enc, that mirrors the authenc
>      driver, but that hashes the plaintext, not the ciphertext.  This was
>      made a separate module rather than just being a part of the authenc
>      driver because it has to do all of the constituent operations in the
>      opposite order - which impacts the async op handling.
> 
>      Testmgr data is provided for AES+SHA2 and Camellia combinations of
>      authenc and krb5enc used by the krb5 library.  AES+SHA1 is not
>      provided as the RFCs don't contain usable test vectors.
> 
>  (2) Provide a Kerberos 5 crypto library.  This is an extract from the
>      sunrpc driver as that code can be shared between sunrpc/nfs and
>      rxrpc/afs.  This provides encryption, decryption, get MIC and verify
>      MIC routines that use and wrap the crypto functions, along with some
>      functions to provide layout management.
> 
>      This supports AES+SHA1, AES+SHA2 and Camellia encryption types.
> 
>      Self-testing is provided that goes further than is possible with
>      testmgr, doing subkey derivation as well.
> 
> The patches were previously posted here:
> 
>     https://lore.kernel.org/r/20250203142343.248839-1-dhowells@redhat.com/
> 
> as part of a larger series, but the networking guys would prefer these to
> go through the crypto tree.  If you want them reposting independently, I
> can do that.

I tried pulling it but it's not based on the cryptodev tree so
it will create a mess when I push this upstream.  If you want me
to pull it through cryptodev please rebase it on my tree.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

