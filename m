Return-Path: <linux-fsdevel+bounces-15206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ABE88A5A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 16:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9C81F38F7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0489D15B12C;
	Mon, 25 Mar 2024 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lam2HJ0n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0DB145B29;
	Mon, 25 Mar 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368333; cv=none; b=XwX5D9Rmsg5Key0rWsQo3W/chrHaMcoUe7l7qRTdqcXEcTtjtVbc85ENJ9uWKXyaZ18QzVNAc53n9Lxk8trM/22FZAwZGcBJOwLEzvDUEc54Hfe3eTZ4A68QvKvfelsUYsNce5hPx7a6Da+WLW0VJ13OyyPRkGayVs7lWxWWFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368333; c=relaxed/simple;
	bh=/eWTHCGbthMM8s000KyybSQhaxmkfQahpwzNlykKCR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL23SoASqBJKN+CWFC+j/b4hI5uS6Xj3J/MoqITttjl/+LMgueYb5NUYxdCV3YvaH94wZqnxF1b0vxk7DY+L9uJEYioM2X0oLFR1QYsdeuI07l22+vXRvg1dlH0Wg3N8gBxn6hdW0dua8XkO7mcSllEL0BCxmCquWvHyFeCn8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lam2HJ0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D291CC433F1;
	Mon, 25 Mar 2024 12:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711368332;
	bh=/eWTHCGbthMM8s000KyybSQhaxmkfQahpwzNlykKCR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lam2HJ0nZdB04deN0sWBUNzu9z6Xsvm4NsmTY1g/ji/2bkV5XoQeYV+9ssahTdoDH
	 cqdaYdqk3291t3mby8pEoMZKjtbILq080aPI4EzSWDMuJmoARNbRv8SnemPk9hNDnL
	 TQ+vAxtz7I2klk1k5CZ1iLVl67TNhCikY9JB6Xn7EiB3lZOyv8MZ962zkDuI1ycFcT
	 bOyNimsO4rAQivKaib9fBn1KB5mD2M769B+9DcWMGctRjI7B4O+P/iiOOu04l9I/3n
	 C1W76gLtt3wOmIZ8V0QCofGVECD4aJl6sDhIubwVp4EzblUQjVI8HpgpUyGGZLtE5Y
	 kDVtVjUWkxIHw==
Date: Mon, 25 Mar 2024 13:05:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Anton Altaparmakov <anton@tuxera.com>, Namjae Jeon <linkinjeon@kernel.org>, ntfs3@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
	regressions@lists.linux.dev
Subject: Re: [PATCH 2/2] ntfs3: remove warning
Message-ID: <20240325-shrimps-ballverlust-dc44fa157138@brauner>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
 <20240325-faucht-kiesel-82c6c35504b3@brauner>
 <ZgFN8LMYPZzp6vLy@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgFN8LMYPZzp6vLy@hovoldconsulting.com>

On Mon, Mar 25, 2024 at 11:12:00AM +0100, Johan Hovold wrote:
> On Mon, Mar 25, 2024 at 09:34:38AM +0100, Christian Brauner wrote:
> > This causes visible changes for users that rely on ntfs3 to serve as an
> > alternative for the legacy ntfs driver. Print statements such as this
> > should probably be made conditional on a debug config option or similar.
> > 
> > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Cc: Johan Hovold <johan@kernel.org>
> > Link: https://lore.kernel.org/r/Zf2zPf5TO5oYt3I3@hovoldconsulting.com
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> 
> I also see a
> 
> 	ntfs3: Max link count 4000
> 
> message on mount which wasn't there with NTFS legacy. Is that benign
> and should be suppressed too perhaps?

We need a reply from the ntfs3 maintainers here.

