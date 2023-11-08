Return-Path: <linux-fsdevel+bounces-2376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3EF7E5294
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 10:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCAEB20F17
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E5DF4F;
	Wed,  8 Nov 2023 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ffx2uh2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D7DF47
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 09:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51014C433C8;
	Wed,  8 Nov 2023 09:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699435262;
	bh=9f1HWkCwCFtzk3fX889cU2VmJzksISA21iZ6B4BDtY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ffx2uh2ybtQm2VWN6sUqgEmp+f4T8KlTqy+vKM/yR25g1fiiGYU3n3SKANcJnNIT/
	 B0RG6ZT8lLSZRnZPNWXnE++9DaEpN+rEwCSp7hISUK6YnM2N5Slcw/Em8wuJy+vwg7
	 GNgY1qSTGhAtN6SV+rjEI3tInTNktZUkK03tOC1nF/BneKjW51QR4nZoK9UZeB+q10
	 KPO4hPWzCK9ztXaXC3ztWrxVFv2qJzmRvu1/aoBvdddCiyVy7f1Xec/yVIQyZXYbFq
	 fiUgEV4hsah02Yb+4IkFdi6M6Ua+PIYyNUthYTNGjorHQaLHO36sZ+GPFY1/B4aYmk
	 K1Mbtz6RR4leg==
Date: Wed, 8 Nov 2023 10:20:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: amir73il@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
	syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Pass AT_GETATTR_NOSEC flag to getattr interface
 function
Message-ID: <20231108-knieprobleme-aufhielt-562b5bbafb79@brauner>
References: <20231002125733.1251467-1-stefanb@linux.vnet.ibm.com>
 <20231010-erhaben-kurznachrichten-d91432c937ee@brauner>
 <e6b66098-77d6-46e9-b013-986ad86ba26b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6b66098-77d6-46e9-b013-986ad86ba26b@linux.ibm.com>

> Did something happen to this patch? I do not see it in your branch nor the
> linux-next one nor Linus's tree.

Sorry, my bad. I'll send that out as a fixes pr soon.

