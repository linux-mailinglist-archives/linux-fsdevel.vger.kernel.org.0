Return-Path: <linux-fsdevel+bounces-6786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB75C81CA26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 13:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D2EB2211D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 12:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2825179AE;
	Fri, 22 Dec 2023 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNeRC2U6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953912E70;
	Fri, 22 Dec 2023 12:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36A2C433C7;
	Fri, 22 Dec 2023 12:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703249074;
	bh=eGSp3UmhYhManYRTB43mRPJmf58RmVuDt+RJbm/WCRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNeRC2U6wsUBM/90OotnMkMSOd/Qd0WP/Run+iZVBMHAna/a4pLQ3IixMRmlE1CDn
	 gv8n6zpDDYWUiPu4P1AzevTlj8JDjoV7FOvjqBeKYIm8x4NZOS+LY36QHatRomfSKF
	 s32FtbY9Wp3qvC2bHX1FwHrGZUgEZxNyZu7fmwTcU0FNd0ZTyLJm0CA4VPsetd7rh3
	 ThCGeQmRz3yBi91TTM47FyI+3ERKEUA3L6O8IFhOmVRksGn2/NQhs7NeGwmYWZTHjw
	 Rfk73lOdAVPZd++MlR+M7kyJO/8Eo9u062n2vLnkayhd4drVYh1/0Uch4GrocW/K5Y
	 67x1U6ffgaf9Q==
Date: Fri, 22 Dec 2023 13:44:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] Intruduce stacking filesystem vfs helpers
Message-ID: <20231222-bekennen-unrat-a42e50abe5de@brauner>
References: <20231221095410.801061-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231221095410.801061-1-amir73il@gmail.com>

> If I do that, would you preffer to take these patches via the vfs tree

I would prefer if you:

* Add the vfs infrastructure stuff on top of what's in vfs.file.
  There's also currently a conflict between this series and what's in there.
* Pull vfs.file into overlayfs.
* Port overlayfs to the new infrastructure.

io_uring already depends on vfs.file as well.

If this is straightforward I can include it in v6.8. The VFS prs will go
out the week before January 7.

