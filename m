Return-Path: <linux-fsdevel+bounces-45429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0D3A77903
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EEA3ACD06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9801F09B6;
	Tue,  1 Apr 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9MIabF7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1BB1E1C22;
	Tue,  1 Apr 2025 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504044; cv=none; b=IZ4DOIP8QlaueTAYUQnwGtTPd5pLE+31SxIMj588ZQHZM55Gq65yVXyPRtbTzm4IPz/bjB1tZrT6dhVzbhnw24exZnay2IuZEg4dGyqkex1xQj+RTb4uID+a4mgX7+WucP8Kh2UUvSgc7RB6XZJVqXYXj0/75q5OvoBuF3AGUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504044; c=relaxed/simple;
	bh=t74m5IOeCnD80TXf36CGYsb/1JjQ6GqllVydWqlrlh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL8MZG281iIFm97TN+rICnLHJkYgnvYRzYryWtgqiA1CJh3vWcXrZpKe23nYVrhvYNJYZybShXFHXEDdpvIVf2axRpjV5m5frDo4HPAweJ1PRetSbe6+agdVdkaCpouy3wxvU8T6SENRUWq8D+irGEzVJtZEzZKiSfAuzRgVXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9MIabF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FE3C4CEE4;
	Tue,  1 Apr 2025 10:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743504044;
	bh=t74m5IOeCnD80TXf36CGYsb/1JjQ6GqllVydWqlrlh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9MIabF7Bd/CRu041JVGsINMJWpZADWwJlLMEkbEOVjHxxN0d2WPjOFnkKXsuwX5K
	 mvjEr20Nup84K1ER2bvjabLGjv09T1lEcAv01lnrbKX0LdSKqCfXIvhzXyhLwR9EeW
	 y3zHztvB3j7V1ZCUXuTzyZ+EgDWRyDfRAUlpi5cmcAs7g5c8Se07bu7Fl9DUqXNSWJ
	 mMK22gyAatlYWh1BbY2kSZLbu17rpBGNwesSe+0YjDmvuKsdqNXL6hfsM+LsxaZig1
	 mbzk061nIVnDVdA2oOnNT14sHSS66V5FHaXjyY7tRRVscQVKiQX5ja2aETRLzQRAap
	 KxzsLGWDcokdg==
Date: Tue, 1 Apr 2025 12:40:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Randy Dunlap <rdunlap@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: initramfs: update compression and mtime
 descriptions
Message-ID: <20250401-exilregierung-wellen-0a8e529804cc@brauner>
References: <20250331050330.17161-1-ddiss@suse.de>
 <39c91e20-94b2-4103-8654-5a7bbb8e1971@infradead.org>
 <20250331174951.7818afb1.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250331174951.7818afb1.ddiss@suse.de>

On Mon, Mar 31, 2025 at 05:49:51PM +1100, David Disseldorp wrote:
> Thanks for the feedback, Randy...
> 
> On Sun, 30 Mar 2025 22:13:19 -0700, Randy Dunlap wrote:
> 
> > Hi,
> > 
> > On 3/30/25 10:03 PM, David Disseldorp wrote:
> > > Update the document to reflect that initramfs didn't replace initrd
> > > following kernel 2.5.x.
> > > The initramfs buffer format now supports many compression types in
> > > addition to gzip, so include them in the grammar section.
> > > c_mtime use is dependent on CONFIG_INITRAMFS_PRESERVE_MTIME.
> > > 
> > > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > > ---
> > >  .../early-userspace/buffer-format.rst         | 30 ++++++++++++-------
> > >  1 file changed, 19 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/Documentation/driver-api/early-userspace/buffer-format.rst b/Documentation/driver-api/early-userspace/buffer-format.rst
> > > index 7f74e301fdf35..cb31d617729c5 100644
> > > --- a/Documentation/driver-api/early-userspace/buffer-format.rst
> > > +++ b/Documentation/driver-api/early-userspace/buffer-format.rst
> > > @@ -4,20 +4,18 @@ initramfs buffer format
> > >  
> > >  Al Viro, H. Peter Anvin
> > >  
> > > -Last revision: 2002-01-13
> > > -
> > > -Starting with kernel 2.5.x, the old "initial ramdisk" protocol is
> > > -getting {replaced/complemented} with the new "initial ramfs"
> > > -(initramfs) protocol.  The initramfs contents is passed using the same
> > > -memory buffer protocol used by the initrd protocol, but the contents
> > > +With kernel 2.5.x, the old "initial ramdisk" protocol was complemented
> > > +with an "initial ramfs" protocol.  The initramfs contents is passed  
> > 
> >                                                              are passed
> > 
> > > +using the same memory buffer protocol used by initrd, but the contents
> > >  is different.  The initramfs buffer contains an archive which is  
> > 
> >   are different.
> 
> I've not really changed those sentences with this patch, so I don't mind
> if they stay as is, or switch "contents" to "content" or "is" to "are".
> 
> > >  expanded into a ramfs filesystem; this document details the format of
> > >  the initramfs buffer format.  
> > 
> > Don't use "format" 2 times above.
> 
> This is also not changed by the patch. I'm happy to send a v2 or have
> these clean-ups squashed in when applied. Will leave it up to the
> maintainers.

Just send a v2, please.

