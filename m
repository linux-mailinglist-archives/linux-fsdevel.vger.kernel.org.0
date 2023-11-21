Return-Path: <linux-fsdevel+bounces-3319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69C7F328A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 16:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0421AB21DC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232365811E;
	Tue, 21 Nov 2023 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqwanqef"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057658103;
	Tue, 21 Nov 2023 15:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0CBC433C8;
	Tue, 21 Nov 2023 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700581309;
	bh=S88VS/JeNntgndUZ+3tIptCd/YSnpIXHgKlJ3ODXnYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aqwanqefpr3Pq2I8OUu4qpHMLikru3c1tl5pk6dsAO8huIMuXDefgqjJAVMZjE9DY
	 pUhL2k8wDB4kDQDJwMd/PciuuR547GVr9NAGbENepq+nAoqlCyL4Y5LSgkNI7Az9L0
	 tWtspR1OunSZvG29mY7w9rjAkxnHrV6pOZLM5IeNTGkt3Prm6kNQFq00G2FGorky3b
	 FIQs/iC9niZj2k7LhIHbZlFD2iUrPpqZjrx4thAF9b3IcCPcEZEbl1lSzLJ4Vkxp1s
	 N5FBJiIgz1RJ7s9K1oqpGIgYUqzVIc3Jnftm9mnLltZbGDRpfLAA9JFooKj5h6xUAi
	 iUB79HewtRN0w==
Date: Tue, 21 Nov 2023 16:41:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 00/15] Tidy up file permission hooks
Message-ID: <20231121-neidlos-postschalter-5227118b3d8c@brauner>
References: <20231114153254.1715969-1-amir73il@gmail.com>
 <20231117194443.GC1513185@perftesting>
 <CAOQ4uxjuDxSro+4qtXfodSf-EcAA8aUBGuWpaVn4+H8Ai=JcFg@mail.gmail.com>
 <CAOQ4uxh8GY=OwTWzkokDFq4O-1UVVYMEezBDQqEp=yP51zdbGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh8GY=OwTWzkokDFq4O-1UVVYMEezBDQqEp=yP51zdbGg@mail.gmail.com>

> Christian,
> 
> Here is a status update on this patch set.
> 
> 1. Patches 1-11 reviewed by Josef -
>     if you can take a look and see they look fine before v2 that would be great
> 2. Patch 3 ACKed by Chuck [1]
> 3. Patch 9 should be preceded by this prep patch [2]
>     that was ACKed by coda maintainer
> 4. Patch 12 is self NACKed by me. I am testing an alternative patch
> 5. Patches 13-15 (start_write assert helpers) have not been reviewed -
>     they were posted to fsdevel [3] I'll appreciate if you or someone
> could take a look
> 
> Once I get your feedback on patched 1-11,13-15
> I can post v2 with the patch 9 prep patch and the alternative fix for patch 12.

The series looks good to me. I just had some minor comments.

