Return-Path: <linux-fsdevel+bounces-13997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 618348762A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 12:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EB61C21031
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CBF5E086;
	Fri,  8 Mar 2024 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc9/YQLJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42E55E50;
	Fri,  8 Mar 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895582; cv=none; b=sZ63lAd/x17ET9X9P4869ktzMxssLk+ngQY2vA1+U/eXEp3S3K2eUXGHnHJUWCzfow4dqZN4FUGClRJs2T3/ZUvLr9Gn/DtJABSQGAQwI01pPIVs+2Fuc7mnwMafmvJBUnbiF8GC9LRYx11ys0gRXU8L4RuVb7HJN2tWgJKCxWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895582; c=relaxed/simple;
	bh=XCx6rBF5QXE5ljZ6dgmSjPlktK82y9NFAFmToHiY3rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCJBrzKuaoVLuXbSKWCVmrDUIQdMKqR99ph2no0ygSUF6YfuyM7aZrep7Dx9TVhdIHRbN3lDEX8KhtCXqY28YAEvHWq07IS1cF4inQyOut5rTB1O05DGvgUVDIVt+bPglifXLVtWJ9I9mpG3gN6CF6eDCoX4xwxuk7Aamzgc/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc9/YQLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1A1C433C7;
	Fri,  8 Mar 2024 10:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709895581;
	bh=XCx6rBF5QXE5ljZ6dgmSjPlktK82y9NFAFmToHiY3rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qc9/YQLJqkDldT6nTmCJ9jNzgiOZI4nHUSHkFPdsNoG2yuVaomoPar+KYppkc5q3y
	 yoHfW+OfBFS1ZJZUp47J76Noncnw71Loxw8R+PvRKf4oebIptJtXoAm1ZlKpf7qj+3
	 +tlfLfOGAuxn8uEYuGXHYlWsP8KJuFFXcZ1mPkHpG7uh5EdaU8jT0T7zIGYG4oSyOo
	 GyxaRoQQ+8uP77ICDPDbjiRIKGOikgR7rgMftZw24JUOpjXfvxQplJ5QfbWKxmMGjq
	 IJQRbV2bvumrCOimGX+9/Jt67pGPPobSTq5jb7yEYhPfPpWof8XGfw9ei8BDhi6oDT
	 ARQqftLEDHxuA==
Date: Fri, 8 Mar 2024 11:59:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] statx: stx_vol
Message-ID: <20240308-vorkam-aufgearbeitet-44ed64f7de69@brauner>
References: <20240302220203.623614-1-kent.overstreet@linux.dev>
 <20240304-konfus-neugierig-5c7c9d5a8ad6@brauner>
 <xqazmch5ybt7fatipwkuk7lnouwwdn55cirvaiuypjmy3y4fte@6vwyvv3uurl5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xqazmch5ybt7fatipwkuk7lnouwwdn55cirvaiuypjmy3y4fte@6vwyvv3uurl5>

On Thu, Mar 07, 2024 at 12:39:58PM -0500, Kent Overstreet wrote:
> On Mon, Mar 04, 2024 at 10:18:22AM +0100, Christian Brauner wrote:
> > On Sat, Mar 02, 2024 at 05:02:03PM -0500, Kent Overstreet wrote:
> > > Add a new statx field for (sub)volume identifiers.
> > > 
> > > This includes bcachefs support; we'll definitely want btrfs support as
> > > well.
> > > 
> > > Link: https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq/
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Cc: Josef Bacik <josef@toxicpanda.com>
> > > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: David Howells <dhowells@redhat.com>
> > > ---
> > 
> > As I've said many times before I'm supportive of this and would pick up
> > a patch like this. There's definitely a lot of userspace that would make
> > use of this that I'm aware of. If the btrfs people could provide an Ack
> > on this to express their support here that would be great.
> > 
> > And it would be lovely if we could expand the commit message a bit and
> > do some renaming/bikeshedding. Imho, STATX_SUBVOLUME_ID is great and
> > then stx_subvolume_id or stx_subvol_id. And then subvolume_id or
> > subvol_id for the field in struct kstat.
> 
> _id is too redundant for me, can we just do STATX_SUBVOL/statx.subvol?

Fine by me.

