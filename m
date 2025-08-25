Return-Path: <linux-fsdevel+bounces-58970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C1B3384F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1B23BF85E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3B7299954;
	Mon, 25 Aug 2025 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8szN6GP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507FC2882CC;
	Mon, 25 Aug 2025 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108658; cv=none; b=uBeA4jRItkSBFR9jBOr6k8Dq26gZXLxPTpY82z+E658jdwObaFS97wCyVfjfpukLJgjJYcjL+wtHezN7ngxIzTwt147YWcDkLEHkiSZvf5AZMPrbMXHNoEbpybvUHPwSdy47Lw2eEmH+I9i1yknqJbj7RpYOjn6wq9BRRjsV1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108658; c=relaxed/simple;
	bh=+EyeDx37l7GSWutALi8iTFyX6KSuRWpcLVm/DEInLUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4kVDwTGwNf1Id/Kh95MIZECJmHH1Y59u3HyeLrqePL0CUEBlqv4+WQZAMP1IJROfcVW/Zpv3x3s5KGMI/WNJ2B8303v6CrhII1+FGD0RU/Hn9gKugfqLMeWlFRlKd2CQMDbsJlC0vr0qUwlEZylZYHS/PvFocDgrCbjIMVF9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8szN6GP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FF0C4CEED;
	Mon, 25 Aug 2025 07:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756108657;
	bh=+EyeDx37l7GSWutALi8iTFyX6KSuRWpcLVm/DEInLUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p8szN6GPttvPOMcOUOPqUQLg4acBVkvFa37LhG5Xioe/blvG9UG5T963Mt3mSu2QD
	 mITP0ia40Vx9RDSxVUWcVpY6LSKP8HnBIyQTgWq/Pd0LHt/uKAro0s7UyrEHjwfHSQ
	 CwdBNw3ZLLmqj//6ScsQyxsNPvpB639u6iBXlYYqYbi4r0ofeQBb9lKRSJcVqWg2xr
	 kAUQfTRCBJkzngm3YaD5gx7jMQjkdlRjbPGMec7re+N1ZLoReuYWDya5fbggNO+YRi
	 bZr5YeP/YqOidzGJrY+IZbS4fIhttlFhKwpUeyoSbhNWXaCKWk0yR/cXOFLwv7ef6F
	 fOBdpaSKHgMUw==
Date: Mon, 25 Aug 2025 09:57:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Theodore Tso" <tytso@mit.edu>
Cc: Greg KH <greg@kroah.com>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, ksummit@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINER SUMMIT] Adding more formality around feature
 inclusion and ejection
Message-ID: <20250825095732.4571e6d0@foz.lan>
In-Reply-To: <20250822122424.GA34412@macsyma.lan>
References: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
	<20250821203407.GA1284215@mit.edu>
	<940ac5ad8a6b1daa239d748e8f77479a140b050d.camel@HansenPartnership.com>
	<2025082202-lankiness-talisman-3803@gregkh>
	<20250822122424.GA34412@macsyma.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 22 Aug 2025 08:24:24 -0400
"Theodore Tso" <tytso@mit.edu> escreveu:

> On Fri, Aug 22, 2025 at 02:03:13PM +0200, Greg KH wrote:

> The current baseline is that the media subsystem, networking, or BPF
> maintainer's decide what features to accept and who they will accept
> pull requests from.  

On media, we typically place things that deserve more discussion under
staging. We did that for stateful decoders and encoders, for instance.
The same was done for stateless codecs. It means that any drivers written
to use such features also go to staging. Not always possible, but
something like that IMO serves to signalize to users, distro-maintainers
and the maintainers of such feature that, while we're ok to have it
being tested, we're yet seeing issues that need more discussions and/or
fixes.


> The same us true all the way up the hierarchy
> maintainer tree up to Linus.  What is the alternative that we could
> use?  That some democratic voting procedure, or some kind of core team
> would stick their oar into making this decision?  I'm not sure that
> would be an improvement; in fact, IMHO, it will very likely be
> significantly worse.

Agreed. It is really hard to see when problems will arise, specially
in cases like this.

Thanks,
Mauro

