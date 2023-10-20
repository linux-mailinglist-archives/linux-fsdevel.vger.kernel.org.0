Return-Path: <linux-fsdevel+bounces-835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D087D1186
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 16:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3DB281B64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1651D553;
	Fri, 20 Oct 2023 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJ/3joCf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF61A29D;
	Fri, 20 Oct 2023 14:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7265C433CC;
	Fri, 20 Oct 2023 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697811923;
	bh=wldg2zwOkncbKRJtGFBFpmkGBwcFXywZnG13CG3zHhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJ/3joCf+5FMJaprCbr89oaXtaFok28cVqNP3CRzEhEVviVmSBnfJEbf9nyriexnS
	 kyIo8D2DFuBycYxVqzbD0Folujn5QAbqFEUqMSbxuUnEi4CIGcomqNtXAcZAdshQS4
	 oL+F3/lLdsPNrI1aA6ZpIXh3qpjnRQeYFi0xTIBA=
Date: Fri, 20 Oct 2023 16:25:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jesse Hathaway <jesse@mbuki-mvuki.org>,
	Christoph Hellwig <hch@lst.de>, Florian Weimer <fweimer@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	giuseppe@scrivano.org
Subject: Re: [PATCH] attr: block mode changes of symlinks
Message-ID: <2023102034-atlas-obligate-46bb@gregkh>
References: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
 <2023101819-satisfied-drool-49bb@gregkh>
 <CANSNSoV6encjhH2u-Ua8wmjy==emvpi+76HTZasxbfzobMQ_Vw@mail.gmail.com>
 <38bf9c2b-25e2-498e-ae50-362792219e50@leemhuis.info>
 <20231020-allgegenwart-torbogen-33dc58e9a7aa@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020-allgegenwart-torbogen-33dc58e9a7aa@brauner>

On Fri, Oct 20, 2023 at 01:01:44PM +0200, Christian Brauner wrote:
> The other option to consider would be to revert the backport of the attr
> changes to stable kernels. I'm not sure what Greg's stance on this is
> but given that crun versions in -testing already include that fix that
> means all future Debian releases will already have a fixed crun version.

I will be glad to revert a change in a stable tree that is also reverted
in Linus's tree, but to just "delay" a change getting into the tree,
that's not ok (either the change is good or not.)

thanks,

greg k-h

