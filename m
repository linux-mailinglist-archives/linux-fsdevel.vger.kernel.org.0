Return-Path: <linux-fsdevel+bounces-12700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F059D86292C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 06:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360091C211B5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 05:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B30BBA41;
	Sun, 25 Feb 2024 05:32:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ADE9443;
	Sun, 25 Feb 2024 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708839176; cv=none; b=OC/WBvtYjmITTl6JvTXAVNUOre6KcnyOmTbpvV1UUxrqQVlz2cSq3P37s7zObfjKXmKDzVmyLvJsg5gfY3lT6sa959nmJ3X3pG+BaUcIBOccMc9j8hBxnXSH8j+ZpK2pE4SdhZQ1mDVxIEK55CZ7Myo0ooXea5UiEy2OgX3HC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708839176; c=relaxed/simple;
	bh=G0eLgSrVWDaqFmr8pIApIw2GEGe9uLTYg8vm6fkZOfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8WiT1Q31lh3QZPzjbL03oR4RiEAc4QaorQnrhjaUqWqe+vf5ym25nOG54qFw2H5H7TVFz0cX7or2GXnhb+5OErYFwCpv7beG8gqptfOro4oalwcOuOObzxISBQmoYPVTCKelOTfa40K28xmaKZb95fI//D3QSxHPRpECXeCp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1re77i-00HVde-1a; Sun, 25 Feb 2024 13:32:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 25 Feb 2024 13:32:40 +0800
Date: Sun, 25 Feb 2024 13:32:40 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	David Laight <David.Laight@aculab.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Graf <tgraf@suug.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/1] Rosebush, a new hash table
Message-ID: <ZdrQ+DjvEOMzAtPA@gondor.apana.org.au>
References: <20240222203726.1101861-1-willy@infradead.org>
 <Zdk2YgIoAGOEvcJi@gondor.apana.org.au>
 <4a1416fcb3c547eb9612ce07da6a77ed@AcuMS.aculab.com>
 <2s73sed5n6kxg42xqceenjtcwxys4j2r5dc5x4fdtwkmhkw3go@7viy7qli43wd>
 <ZdrJn0lkFeYGuYIC@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdrJn0lkFeYGuYIC@casper.infradead.org>

On Sun, Feb 25, 2024 at 05:01:19AM +0000, Matthew Wilcox wrote:
> 
> Task a trivial example where you have four entries unevenly distributed
> between two buckets, three in one bucket and one in the other.  Now 3/4
> of your lookups hit in one bucket and 1/4 in the other bucket.
> Obviously it's not as pronounced if you have 1000 buckets with 1000
> entries randomly distributed between the buckets.  But that distribution
> is not nearly as even as you might expect:
> 
> $ ./distrib
> 0: 362
> 1: 371
> 2: 193
> 3: 57
> 4: 13
> 5: 4

Indeed, that's why rhashtable only triggers a forced rehash at
a chain length of 16 even though we expect the average chain length
to be just 1.

The theoretical worst-case value is expected to be O(lg n/lg lg n).
However, I think 16 was picked because it was sufficient even for a
hash table that filled all memory.  Of course if anyone can provide
some calculation showing that this is insufficient I'm happy to raise
the limit.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

