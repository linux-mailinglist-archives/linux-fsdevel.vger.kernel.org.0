Return-Path: <linux-fsdevel+bounces-3437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE17F4906
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 15:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DBF1C20C0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBD84E62E;
	Wed, 22 Nov 2023 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv0oBkig"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813544E618
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 14:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A914EC433C8;
	Wed, 22 Nov 2023 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700663682;
	bh=fHg7c6FZ/4FR922N3PVFEPuZ3UD+zK+T122j5y/vi24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mv0oBkig1FELFlF3fWQXRvhtTyQlIAUTZU7YzEALNTNGTNeawLAxxp4npQlNOGz7v
	 h45EHUXdHYidEqWZ1B0aifDoUlT2qD9x8GgvkhSzdloq9kqKBDS0ZG4PLSojbMI/jv
	 IrAuQGG+qinkqMetGtXh6l7uLbGLXkZArSguTno4jD3cziK12ya8WNlt+kQO9XYXTS
	 qikmZNBXZN2xxm0nZgha2LZhqc1+vyRy78Wf0U6C1cmcqd7DWzpIMY6JYnQx1EpIZZ
	 zWGIc83naWCsMVSlGokFjcxS8fmjClN91T2lSsPoLClSQfWQsRPaYmRFKGKqCyUreN
	 g5PNKr1dPSEdw==
Date: Wed, 22 Nov 2023 15:34:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH 3/4] mnt_idmapping: decouple from namespaces
Message-ID: <20231122-runden-bangen-787f0a1907ca@brauner>
References: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
 <20231122-vfs-mnt_idmap-v1-3-dae4abdde5bd@kernel.org>
 <20231122142657.GF1733890@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122142657.GF1733890@perftesting>

> You accidentally put a ; here, and then fix it up in the next patch, it needs to
> be fixed here.  Thanks,

Bah, fixed this now. Thanks!

