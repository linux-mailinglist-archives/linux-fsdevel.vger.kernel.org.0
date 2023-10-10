Return-Path: <linux-fsdevel+bounces-2-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E097C4163
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 22:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2B71C20E47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 20:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD52225CD;
	Tue, 10 Oct 2023 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ju2dOj/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED7F225B1;
	Tue, 10 Oct 2023 20:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6766C433A9;
	Tue, 10 Oct 2023 20:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696970419;
	bh=K6wXGfhe1UDpbSWljf8+blTcTyQbdY6mZGAI2ovoKn8=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Ju2dOj/LZZmRJsCLOYATcvid16e5M5tA3xBMjW+u4Hr8N3wyhAfaXRS01ZvC3n5oO
	 K/P9L8W1gFk61is0oISNh8EA2y5e8AR/qF5GxTHDKHThXkWgEFi4CrCw40riT+bReg
	 82MlGx3PpURNZNG3nkxrPzS8TqoF697Y4NYfb3Z0=
Date: Tue, 10 Oct 2023 16:40:18 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: This list is being migrated to new infrastructure (no action
 required)
Message-ID: <20231010-spotty-subtract-e5b849@meerkat>
References: <20231010-triceps-flattery-228412@meerkat>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010-triceps-flattery-228412@meerkat>

On Tue, Oct 10, 2023 at 04:22:58PM -0400, Konstantin Ryabitsev wrote:
> Hello, all:
> 
> This list is being migrated to the new vger infrastructure. This should be a
> fully transparent process and you don't need to change anything about how you
> participate with the list or how you receive mail.
> 
> There will be a brief delay with archives on lore.kernel.org. I will follow up
> once the archive migration has been completed.

All work is finished. Please report any problems to helpdesk@kernel.org.

Best wishes,
-K

