Return-Path: <linux-fsdevel+bounces-45903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C8DA7E727
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 18:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CE7423BA2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADF020D4E8;
	Mon,  7 Apr 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob1V427l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067AF208993;
	Mon,  7 Apr 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043878; cv=none; b=ooCtVYDBoo2rJX1twlSASHvIgMkAZBUwBCtdHS1vMbu6iVK42QAyO6Jmx+L01xtxzrgMiFRTYVAEX4StCId1MwOU1T0CeFWvedzi1m6Va69aUOM7av8bDFd/vjl/N0wsaBcxSKFRujB+OFFuIID/sIdEMOo2Bw0HPu1+vK8O/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043878; c=relaxed/simple;
	bh=l+RlM2GkKCKgf9tRKVZ3F85pkCwSsrfFBdQC/V8sy7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ge74edDjr82Ehaz80z9Sd7IuoVd9lvoiQri3q3QlaK9IwVBvVqs7hact0uJKwBQngZQwHAvbVaVSe15gR8HQD5vmL1rH46V/Qk5HUTbwu4pJEVtG38bwrqiTqqSiI7SpP2IP2nZUhUCMjTsF32Wt7KltG+q3ECFwHwh8jMkF01k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob1V427l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32542C4CEE7;
	Mon,  7 Apr 2025 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744043877;
	bh=l+RlM2GkKCKgf9tRKVZ3F85pkCwSsrfFBdQC/V8sy7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ob1V427ldxv2n22FMlYJDmAaOWOYHPlwfwd4MRMaAHlhtP79BxwjBsZxzZMY8q16l
	 a4VvpYVT1pm2R2VzByIOwjsNXuKqVF4emucaOXqlAJxOc6v5YeDf/ry+KjVLFmfVQp
	 g9ugIRvLDxCgfFhc4KJHadsfrNAo8PvJD5WuHK/fA5zq2w/mmGs2g1f2Odc6pCoABq
	 k4xIC1fNJa3W4XyCo4lfdccQFMk8ugoyEE1nHSMD95iiC8cRAp52D8Q+CCKIsMdHtA
	 zFHBRzbTev5JAo2jTBVaTZnbfQv8kkda5lsQjKZ+ycChDEw33kwBtSoBHZ5WcIGN7j
	 57NqUcCAcm/OQ==
Date: Mon, 7 Apr 2025 09:37:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: iomap: Add missing flags description
Message-ID: <20250407163756.GD6266@frogsfrogsfrogs>
References: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com>
 <cfd156b3-e166-4f2c-9cb2-c3dfd29c7f5b@oracle.com>
 <87ldsguswz.fsf@gmail.com>
 <9831a558-44a4-41ef-91c9-1dd1994e6c1f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9831a558-44a4-41ef-91c9-1dd1994e6c1f@oracle.com>

On Mon, Apr 07, 2025 at 09:45:04AM +0100, John Garry wrote:
> On 04/04/2025 11:23, Ritesh Harjani (IBM) wrote:
> > John Garry<john.g.garry@oracle.com> writes:
> > 
> > > On 03/04/2025 19:22, Ritesh Harjani (IBM) wrote:
> > > 
> > > IMHO, This document seems to be updated a lot, to the point where I
> > > think that it has too much detail.
> > > 
> > Perhaps this [1] can change your mind? Just the second paragraph of this
> > article might be good reason to keep the design doc updated with latest
> > changes in the iomap code.
> > 
> > [1]:https://urldefense.com/v3/__https://lwn.net/Articles/935934/__;!!
> > ACWV5N9M2RV99hQ! M5YtnH5eBpf0C629QX_zsHZjxSMfWBW8svEup_qNhkg2ie5uqB81lAEO_3DR2pKKSYqUZgLGXiUyQUqi_mjMeZc$
> 
> I am happy to see documentation, but I think that there is too much
> fine-grained detail in this case.
> 
> For my large atomic writes support for XFS series, I am looking at this
> document and thinking that I need to update it again as I am introducing a
> new error code for iomap_dio_rw(). I don't want to have to update the
> document every time I touch iomap or related code.

You're changing shared code APIs.  The documentation must be updated, so
everyone else can better understand the new code.  This is about
reducing friction and confusion in the fs development community.

> > > >       * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
> > > >         be set by the filesystem for its own purposes.
> > > Is this comment now out of date according to your change in 923936efeb74?
> > > 
> > Yup. Thanks for catching that. I am thinking we can update this to:
> > 
> >     * **IOMAP_F_PRIVATE**: This flag is reserved for filesystem private use.
> >       Currently only gfs2 uses this for implementing buffer head metadata
> >       boundary.
> 
> do we really want to update the doc (or even the iomap.h) if some other FS
> uses this flag? I don't think so.

No.  I've changd my mind, you all are right that these design docs
shouldn't be mentioning specific client filesystems.  Just leave it at

"This flag is reserved for filesystem private use."

> > This is done by gfs2 to avoid fetching the next mapping as
> >       otherwise it could likely incur an additional I/O to fetch the
> >       indirect metadata block.
> > 
> > If this looks good to others too I will update this in the v2.
> > 
> > Though, I now wonder whether gfs2 can also just use the IOMAP_F_BOUNDARY
> > flag instead of using IOMAP_F_PRIVATE?
> 
> I'm not sure

You'll have to ask Andreas Gruenbacher.

> > 
> > > > @@ -250,6 +255,11 @@ The fields are as follows:
> > > >         block assigned to it yet and the file system will do that in the bio
> > > >         submission handler, splitting the I/O as needed.
> > > > +   * **IOMAP_F_ATOMIC_BIO**: Indicates that write I/O must be submitted
> > > > +     with the ``REQ_ATOMIC`` flag set in the bio.
> > > This is effectively the same comment as iomap.h
> > > 
> > > > Filesystems need to set
> > > > +     this flag to inform iomap that the write I/O operation requires
> > > > +     torn-write protection based on HW-offload mechanism.
> > > Personally I think that this is obvious. If not, the reader should check
> > > the xfs and ext4 example in the code.
> > > 
> > It's just my opinion, but sometimes including examples of how such flags
> > are used in the code - within the design document, can help the reader
> > better understand their context and purpose.
> 
> Sure, but you need to consider the burden of maintaining this document and
> whether it is even 100% accurate always.

If you don't care for the burden of making shared code easier for others
to figure out once you've changed it, then please don't work on it.

--D

