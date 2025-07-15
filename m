Return-Path: <linux-fsdevel+bounces-55037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A6BB06873
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 23:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267384A7388
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 21:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B62C08DD;
	Tue, 15 Jul 2025 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="lRkCdsfV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ce9F+IH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5624E1E501C;
	Tue, 15 Jul 2025 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614465; cv=none; b=kFdVgS0dGdYGRQjg3EPgXtu0f3g8vlK+mxejG3kVLDQL7cFwGKNGRPF8y7B0bkFjqmce4pnmGJl9CucqdsFVxj9U1AqywYmVPXdA/YHEFBIassnB7UTn/YR/+m61LEcPetbVvcnpHe4qUH+7Fgi6RbF55dDkjYnZTI0spXsntt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614465; c=relaxed/simple;
	bh=vhYV6kzLF08a5hDrKXNokh9k27mccWgw1jxcRH+uRk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABB/PE+Cweg4jkeMtT0AnvvZ2I11BL52W3GNByVkD0LerId8Vh+Orx+nDQ1HKh7DJSFbjiOrNqek1Ux/f7/xuIvnnrcsWl9O1t0/uFskXqIoITnZWQkG6FvRFdfiI/jB7OA3TQP2ZI/KHmR1BR88CXiWeUkGtFXwSs2i72j/8NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=lRkCdsfV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ce9F+IH1; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 62E9B1300E65;
	Tue, 15 Jul 2025 17:21:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 15 Jul 2025 17:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1752614461; x=1752621661; bh=UYHWhle+vh
	Soss1fvdZ2btqEJcq1ge5i+HAEGBVMw8w=; b=lRkCdsfVtMWMwLHZr39F7f/8mX
	921zmhadMTq7JcDH40jPOUA3zEj3R8hvQ31WXo8U+bDofR3ATiX4rwN3fcki5uL8
	IVnPSyWwglK5YOStOSWQGsJlswe1a/bgW4B6uDqK+n0gpg8LHvZFjWWUcG7ZIsD5
	DxuALrsh3O1VydYoDvs9AOccGag8gaCIl8ND1nBlAyE/w+1pho7we6cRkuD9WWhE
	xvf2bWjKL1ux0lIVVQDBG+eZ6QqsFwW0BaE/VyP+OkDaIWye4XLGehVLoILn5kDJ
	+xXs4v++Br2DKNV3PlvDZcRaf9VjLw6d6OD6ws8kKE331gCAlGxUn4d88x9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752614461; x=1752621661; bh=UYHWhle+vhSoss1fvdZ2btqEJcq1ge5i+HA
	EGBVMw8w=; b=Ce9F+IH1uvDNbsSwJIOP/rG/i042S/gMBWsX56WO7ElW3Brcxmj
	c1JjYLwvXBU+k0VWWkBnSh50U7X4rUP8GAZWPiuGETvDoibxN2/HRM1Plm8bl8qY
	vu50j3amKiU4VMH4HzDgz05hzNo5aTorV31PNArsuFQBCWB6HMYcxYwQ+jobOedV
	NtLRKYyUhzppcTmuTu6k1K/7xHIEtx1/XKMnqfGHQQN6ixZ5iJGW4nMdFVcc4zMi
	eK+JRLEKsiUH6f6pZTdSS6m/cJmNYwKQ9XszzgDD598L05RWFPyW0ezHAewLufF9
	C1jEE3fzp1bmaBf72mOvXoP8C7TURS3nvUw==
X-ME-Sender: <xms:O8Z2aBb2o3WSeJkNDpvVK_1CfhO4HXwOqnefRuxSnSagyMaVbJ7BrQ>
    <xme:O8Z2aGPom1oJq26vkt0eDfcvv5b9IgnfKOZSLKeR1XIUY2ArbYSHbT7-Yl8HRO6Pg
    CPMcXGd7bN_Xioq4Do>
X-ME-Received: <xmr:O8Z2aE1jUd0BIG6M25PzLxIX8T39DGUUxYmmeFZKMyQVOs9BWD3JTG-OHP0aibjjwSIvQ21iW1vsIlJSisds4TExpqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegtlhhmsehfsg
    drtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgt
    phhtthhopegushhtvghrsggrsehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitghosehf
    lhhugihnihgtrdhnvghtpdhrtghpthhtohepgihirghngheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhrghosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdgvrhhofhhssehlihhsthhsrdhoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:O8Z2aKl8sgIcZ83waB3ooxuEhOSaVUsZcdWFiIg6hl8aj7u3eVSUsg>
    <xmx:O8Z2aC6he-On3LWoKqy9AnQ59r2GaSw5CGT9VR3Z3zM5QWA25DXqJA>
    <xmx:O8Z2aLnJYp_POSGdFf9OLum21MHWKvZ7zEj6d5IqEt_FNGLQPwIRKA>
    <xmx:O8Z2aMRfslUUz8n58RzMU71E6Do8GJBcqd7ZWglxBBPvoJasm0MSFw>
    <xmx:PcZ2aBt1WhpTWdR5pXv9pupYXwxThC7C0L11zr9gt1KsmEnOtMWynpYe>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 17:20:58 -0400 (EDT)
Date: Tue, 15 Jul 2025 14:22:33 -0700
From: Boris Burkov <boris@bur.io>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
	Paulo Alcantara <pc@manguebit.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
	linux-cifs@vger.kernel.org,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: Re: Compressed files & the page cache
Message-ID: <20250715212233.GA1680311@zen.localdomain>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHa8ylTh0DGEQklt@casper.infradead.org>

On Tue, Jul 15, 2025 at 09:40:42PM +0100, Matthew Wilcox wrote:
> I've started looking at how the page cache can help filesystems handle
> compressed data better.  Feedback would be appreciated!  I'll probably
> say a few things which are obvious to anyone who knows how compressed
> files work, but I'm trying to be explicit about my assumptions.
> 
> First, I believe that all filesystems work by compressing fixed-size
> plaintext into variable-sized compressed blocks.  This would be a good
> point to stop reading and tell me about counterexamples.

As far as I know, btrfs with zstd does not used fixed size plaintext. I
am going off the btrfs logic itself, not the zstd internals which I am
sadly ignorant of. We are using the streaming interface for whatever
that is worth.

Through the following callpath, the len is piped from the async_chunk\
through to zstd via the slightly weirdly named total_out parameter:

compress_file_range()
  btrfs_compress_folios()
    compression_compress_pages()
      zstd_compress_folios()
        zstd_get_btrfs_parameters() // passes len
        zstd_init_cstream() // passes len
        for-each-folio:
          zstd_compress_stream() // last folio is truncated if short
  
# bpftrace to check the size in the zstd callsite
$ sudo bpftrace -e 'fentry:zstd_init_cstream {printf("%llu\n", args.pledged_src_size);}'
Attaching 1 probe...
76800

# diff terminal, write a compressed extent with a weird source size
$ sudo dd if=/dev/zero of=/mnt/lol/foo bs=75k count=1

We do operate in terms of folios for calling zstd_compress_stream, so
that can be thought of as a fixed size plaintext block, but even so, we
pass in a short block for the last one:
$ sudo bpftrace -e 'fentry:zstd_compress_stream {printf("%llu\n", args.input->size);}'
Attaching 1 probe...
4096
4096
4096
4096
4096
4096
4096
4096
4096
4096
4096
4096
4096
4096
4096
4096
4096
4096
3072

> 
> From what I've been reading in all your filesystems is that you want to
> allocate extra pages in the page cache in order to store the excess data
> retrieved along with the page that you're actually trying to read.  That's
> because compressing in larger chunks leads to better compression.
> 
> There's some discrepancy between filesystems whether you need scratch
> space for decompression.  Some filesystems read the compressed data into
> the pagecache and decompress in-place, while other filesystems read the
> compressed data into scratch pages and decompress into the page cache.
> 
> There also seems to be some discrepancy between filesystems whether the
> decompression involves vmap() of all the memory allocated or whether the
> decompression routines can handle doing kmap_local() on individual pages.
> 
> So, my proposal is that filesystems tell the page cache that their minimum
> folio size is the compression block size.  That seems to be around 64k,

btrfs has a max uncompressed extent size of 128K, for what it's worth.
In practice, many compressed files are comprised of a large number of
compressed extents each representing a 128k plaintext extent.

Not sure if that is exactly the constant you are concerned with here, or
if it refutes your idea in any way, just figured I would mention it as
well.

> so not an unreasonable minimum allocation size.  That removes all the
> extra code in filesystems to allocate extra memory in the page cache.
> It means we don't attempt to track dirtiness at a sub-folio granularity
> (there's no point, we have to write back the entire compressed bock
> at once).  We also get a single virtually contiguous block ... if you're
> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
> vmap_file() which would give us a virtually contiguous chunk of memory
> (and could be trivially turned into a noop for the case of trying to
> vmap a single large folio).
> 

