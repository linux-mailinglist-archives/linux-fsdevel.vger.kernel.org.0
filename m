Return-Path: <linux-fsdevel+bounces-49112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378DDAB823A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9D686138C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6100128C00D;
	Thu, 15 May 2025 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5u+6ARl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BFF295DAB
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300436; cv=none; b=PlOp+6gqH0ZYDhXplSBISovxtFhtBI+iWGa9XT6MR9nMPTqXhEf34yLzCz1D5YhJQ5dwnnwx7OS7rMzbUQDAN1gfLqSmE2qrOYDmajJIyOg59AYGlMZ1S0aOLUz8zeHMYfr4W2b/d0dimhJ9mMz3fhxBNI3zqC7USVfS0/fimco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300436; c=relaxed/simple;
	bh=vOrd6PIK9JNp9YoV6IK4ouoXy4US1Dw+Y/IgT1KRNiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKXfIFhQ94vX9Qk2tOrc9iuqgvy7b48UJGo1JKv6JA8XGBw+T+CX0qrlw1nsD48S7/v5pfOb4lbZFowymXMUXb7Lh94UALdg6ms4TqSaBBS16/wtJryTxx/e/+ariuu1dyV2ZIXD7u5nigldpM8LNZw91tqV3cOzzvx/Rg/VolY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5u+6ARl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5F4C4CEE7;
	Thu, 15 May 2025 09:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747300436;
	bh=vOrd6PIK9JNp9YoV6IK4ouoXy4US1Dw+Y/IgT1KRNiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5u+6ARlga8hY8996hgL0eDAm7+dEnNKdvRcRqs352Rf3OeQweOuKyWoLN44yVjBD
	 1FvmniuD/Nd/wpudCsmAiChmnkfqUcG31ec1jp8sx8aTgndY2wk5TD7n2MqC5XnuxO
	 MafB9uBRZfF9qo43BEo8HrJ1I00LstWvwS7DZ2P983d0t8NWeTxg6DTATVaknP3XOT
	 LBT29GIV3LyvZyKEgP9mbUpkrcU/nc1L83VcnvQJwgtptbIHaZIuHbjyYPKEsOyxw6
	 Q43HK1s18PrrzZRkEvQbRsVbFToTaapXiQo/HMLqWKYkQPjCv996kUkgaxQr1s9bsn
	 thUaxvIDbt6Sg==
Date: Thu, 15 May 2025 11:13:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] filesystems selftests cleanups and fanotify test
Message-ID: <20250515-nullnummer-allemal-38ed310cf71e@brauner>
References: <20250509133240.529330-1-amir73il@gmail.com>
 <20250512-absaugen-stengel-a301f3dfc91c@brauner>
 <CAOQ4uxhxvP6Cd_nNsc6VkCSjUnHVVFMToP2DqA_DwQCPmJ9XWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhxvP6Cd_nNsc6VkCSjUnHVVFMToP2DqA_DwQCPmJ9XWw@mail.gmail.com>

On Wed, May 14, 2025 at 10:25:31AM +0200, Amir Goldstein wrote:
> On Mon, May 12, 2025 at 11:40 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, 09 May 2025 15:32:32 +0200, Amir Goldstein wrote:
> > > Christian,
> > >
> > > This adds a test for fanotify mount ns notifications inside userns [1].
> > >
> > > While working on the test I ended up making lots of cleanups to reduce
> > > build dependency on make headers_install.
> > >
> > > [...]
> >
> > Applied to the vfs-6.16.selftests branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.16.selftests branch should appear in linux-next soon.
> 
> Forgot to push the branch?
> 
> I do not see it in your tree nor in linux-next...

Should all be done now.

