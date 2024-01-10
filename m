Return-Path: <linux-fsdevel+bounces-7683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B4782948D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 08:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3AD128A17E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 07:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16B03E47F;
	Wed, 10 Jan 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZLrVSeLC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2854B3E460;
	Wed, 10 Jan 2024 07:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26BCC433C7;
	Wed, 10 Jan 2024 07:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704873450;
	bh=o8bVrq46Gw19VxIK/nS2ne4F5DHCPbUXM28VIPoI9ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLrVSeLCGoiCQtx2Tc+jSiQpYzEdB6yK3wVyesZlJGzmHCgNnSbkqFZxlUl65Blts
	 HICYK1vv+dAFGSSbDM3WUFflLnzF5x5QDWDmPinepBzAB0w+C1Q4UJfsaY8uZMVj/Y
	 NZ69F/AZSeR0/ZLoYwkgzp14i0WjAW3/cxaSGr08=
Date: Wed, 10 Jan 2024 08:57:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <2024011050-sharpness-dill-672f@gregkh>
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
> > Note, I agree, change them to work our a "real" filesystem would need
> > them and then, automatically, all of the "fake" filesystems like
> > currently underway (i.e. tarfs) will work just fine too, right?  That
> > way we can drop the .c code for binderfs at the same time, also a nice
> > win.
> 
> Are you volunteering to rewrite binderfs once rust bindings are available? :)

Sure, would be glad to do so, after the binder conversion to rust is
merged :)

thanks,

greg k-h

