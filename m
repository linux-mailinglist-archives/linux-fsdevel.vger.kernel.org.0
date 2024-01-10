Return-Path: <linux-fsdevel+bounces-7705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12E4829AC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 13:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB6D1C25B20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED19495C1;
	Wed, 10 Jan 2024 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wR5c8Kj+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C8A48CC7;
	Wed, 10 Jan 2024 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ws3LWjOi7S+S4CtjPbXLD+3eiq35Y86yQtBI0OP55yw=; b=wR5c8Kj+q9PbFk8dgK0hEnHWQI
	E05ggc6aieDOv/EbX5j0MwQVqynQpDAjlDhHq+z/zEoPJf9ojcamcIsOSEACKEkjMntUvra1heP3I
	yy0KZgQXJvi38ie+uqx8eqvBO7TInIu8NAaBlAVOG4L97CVevMTcZBpOTf2InaORdE2C02S/sbNe+
	+Ni9mwgle5ck7dnoSD3ZiGRBN6fJqqho4sYHwm+dNvV6mmiEyPN70piaz0NRQUbfTkY04/spfF7ou
	Ir4NSIEVtghdBR2QOZdqSVy5/rhaOV4SHMQ0a/W/LGB3u0btTvRSKgEHRsThL6WKs4Da7TGIr/7Zl
	gPgqpSSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNY7t-00BRj6-3S; Wed, 10 Jan 2024 12:56:09 +0000
Date: Wed, 10 Jan 2024 12:56:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <ZZ6T6aBjOf+vA9sB@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org>
 <ulideurkqeiqztorsuvhynsrx2np7ohbmnx5nrddzl7zze7qpu@cg27bqalj7i5>
 <20240103204131.GL1674809@ZenIV>
 <CANeycqrazDc_KKffx3c4C1yKCuSHU14v+L+2wq-pJq+frRf2wg@mail.gmail.com>
 <ZZ2dsiK77Se65wFY@casper.infradead.org>
 <2024010935-tycoon-baggage-a85b@gregkh>
 <CANeycqrubugocT0ZEhcUY4H+kytzhm-E4-PoWtvNobYr32auDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqrubugocT0ZEhcUY4H+kytzhm-E4-PoWtvNobYr32auDA@mail.gmail.com>

On Wed, Jan 10, 2024 at 04:49:02AM -0300, Wedson Almeida Filho wrote:
> On Tue, 9 Jan 2024 at 16:32, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Jan 09, 2024 at 07:25:38PM +0000, Matthew Wilcox wrote:
> > > You've misunderstood Greg.  He's saying (effectively) "No fs bindings
> > > without a filesystem to use them".  And Al, myself and others are saying
> > > "Your filesystem interfaces are wrong because they're not usable for real
> > > filesystems".  And you're saying "But I'm not allowed to change them".
> > > And that's not true.  Change them to be laid out how a real filesystem
> > > would need them to be.
> 
> Ok, then I'll update the code to have 3 additional traits:
> 
> FileOperations
> INodeOperations
> AddressSpaceOperations
> 
> When one initialises an inode, one gets to pick all three.

That makes sense, yes.

> And FileOperations::read_dir will take a File<T> as its first argument
> (instead of an INode<T>).
> 
> Does this sound reasonable?

yep!


