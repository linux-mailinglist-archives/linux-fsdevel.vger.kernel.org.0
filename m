Return-Path: <linux-fsdevel+bounces-16912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B308A4C02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 11:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A212890D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A7B481DE;
	Mon, 15 Apr 2024 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlGYN0Cz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03E45944;
	Mon, 15 Apr 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174862; cv=none; b=I8v097bspnOT90FlJKoDyw6EeO5T7WSz1AdH61wTo5pcLPejmulsauhQoo/cblRxqxRTzqEEYCq0EBYXmlcL7HYek5uqLO1H1RYJfpM2j0JFF6FHPb9yq4N/dIS82oEg7ZRQbMLV6ZbFqXCkDrSl/G335Q5tpVNDQAOVBc/hJk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174862; c=relaxed/simple;
	bh=NoEbOkT6xpKcfcjZdRZo7iJAnVMKsEeObPkosVfORFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMNX+qvLI+52G8r8EIhGeuTZmxUrQfFJ+rxWBvOTPVW9n+x+DDjFZjE+MsDhxkZu1LyExxmx7kfkItwR6pu61Eu4Gw4XxceBJMgL9R+wUB7fLdsPaMReiUgHIotklRjGR7OLiS5Ti0lmEUQIVoW9WkqRE7Ly5sj8Yr0gect4cb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlGYN0Cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E07C113CC;
	Mon, 15 Apr 2024 09:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713174861;
	bh=NoEbOkT6xpKcfcjZdRZo7iJAnVMKsEeObPkosVfORFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlGYN0CzRlOADAIXkZNUaiy1RbCw72AsWmRqt0l9v/IDG9KKoEyYEXW0b2BzHZ8hu
	 Mbofryhvu9KtrKdKg72efLeeCZ0tdc66jtTV8H3lRq91amjot5uwr4gw2V7qrgCLyo
	 g2kneAcIZS49T3dAD90kvrWnMOGAuTufUByPZEMEZAa2OMM563rRmMMbjJsP1lFZkj
	 MzLBLHHB8sLWELwb07k9vSimPP5iUAF9oKzBohzUtj2TI/aceQvoV64PLtZKuLs1tE
	 A5RVyVTds0uKDPPwj7h/yRqoHorS3YLfhZRUwzg/fL/AmgbwK4E54i15jZvQRdmGvg
	 d7Ia7QEEOVYNg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwJ2Z-000000002OA-1ayb;
	Mon, 15 Apr 2024 11:54:19 +0200
Date: Mon, 15 Apr 2024 11:54:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>, ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 2/2] ntfs3: remove warning
Message-ID: <Zhz5S3TA-Nd_8LY8@hovoldconsulting.com>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
 <20240325-faucht-kiesel-82c6c35504b3@brauner>
 <ZgFN8LMYPZzp6vLy@hovoldconsulting.com>
 <20240325-shrimps-ballverlust-dc44fa157138@brauner>
 <a417b52b-d1c0-4b7d-9d8f-f1b2cd5145f6@leemhuis.info>
 <b0fa3c40-443b-4b89-99e9-678cbb89a67e@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0fa3c40-443b-4b89-99e9-678cbb89a67e@paragon-software.com>

On Thu, Apr 11, 2024 at 02:03:52PM +0300, Konstantin Komarov wrote:
> On 04.04.2024 11:06, Linux regression tracking (Thorsten Leemhuis) wrote:
> > On 25.03.24 13:05, Christian Brauner wrote:
> >> On Mon, Mar 25, 2024 at 11:12:00AM +0100, Johan Hovold wrote:
> >>> On Mon, Mar 25, 2024 at 09:34:38AM +0100, Christian Brauner wrote:
> >>>> This causes visible changes for users that rely on ntfs3 to serve as an
> >>>> alternative for the legacy ntfs driver. Print statements such as this
> >>>> should probably be made conditional on a debug config option or similar.
> >>>>
> >>>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >>>> Cc: Johan Hovold <johan@kernel.org>
> >>>> Link: https://lore.kernel.org/r/Zf2zPf5TO5oYt3I3@hovoldconsulting.com
> >>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
> >>> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> >>>
> >>> I also see a
> >>>
> >>> 	ntfs3: Max link count 4000
> >>>
> >>> message on mount which wasn't there with NTFS legacy. Is that benign
> >>> and should be suppressed too perhaps?
> >> We need a reply from the ntfs3 maintainers here.

> There is no problem in suppressing the output of any messages during 
> mounting, like:

> Messages like this:
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index eb7a8c9fba01..8cc94a6a97ed 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -424,7 +424,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>      if (names != le16_to_cpu(rec->hard_links)) {
>          /* Correct minor error on the fly. Do not mark inode as dirty. */
> -        ntfs_inode_warn(inode, "Correct links count -> %u.", names);
>          rec->hard_links = cpu_to_le16(names);
>          ni->mi.dirty = true;
>      }
> 
> can also be suppressed for the sake of seamless transition from a remote 
> NTFS driver.
> However, I believe that file system corrections should be reported to 
> the user.

A colleague of mine also tracked down a failed boot to the removal of
the ntfs driver and reported seeing similar warnings with the ntfs3
driver.

We're both accessing an NTFS partition on a Windows on Arm device, but
it makes you wonder whether these warnings (corrections) are correct or
indicative of a problem in the driver?

Johan

