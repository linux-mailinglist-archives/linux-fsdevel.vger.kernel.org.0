Return-Path: <linux-fsdevel+bounces-2941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C567EDB0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 06:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF39280FB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 05:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9DAC8CA;
	Thu, 16 Nov 2023 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Wg0wnd30"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6FC18D
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 21:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yalsUp+8+NJhb0PCwkk+ItPeF8C+DFJoUVHI5zXOXyM=; b=Wg0wnd30gLMXRYfpzeLAgVkfas
	cXRiVMgYy883/ETOrPKHu6ZvIanWiOsANLpaxi79xQH/yVNu3tL/yhl2Kt61i4AbnXCEmJrbwf0Cb
	cKzcQ+8KCaPQG7bz7NPnXGf69aqwdATU2/vAtQMnFxRbQ3Zk1YfTjsI8led9H6+cTV9fEJg9eHLdw
	fhk+jewNBJqbO9EQj2Yt3/GR7JRUAB8ng3roK25glXIeI3RL3T3ceNtE+gcBcOhetRG3OCYipvzru
	SaSA5VkyBJpyoHRMAt3nO6j9vtk43Gl/3s5TzOpqqoX8EF1m4OzmvyrlPBLVKKGLwNvMHT5EiwkB8
	PLn5RXzA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r3Ue8-00GOdY-1o;
	Thu, 16 Nov 2023 05:10:32 +0000
Date: Thu, 16 Nov 2023 05:10:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 1/2] new helper: user_path_locked_at()
Message-ID: <20231116051032.GY1957730@ZenIV>
References: <20231116050832.GX1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116050832.GX1957730@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 16, 2023 at 05:08:32AM +0000, Al Viro wrote:
> (in #work.namei; used for bcachefs locking fix)
> >From 74d016ecc1a7974664e98d1afbf649cd4e0e0423 Mon Sep 17 00:00:00 2001
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: Wed, 15 Nov 2023 22:41:27 -0500
> Subject: [PATCH 1/2] new helper: user_path_locked_at()
> 
> Equivalent of kern_path_locked() taking dfd/userland name.
> User introduced in the next commit.

... and unless anybody objects, into #for-next it goes...

