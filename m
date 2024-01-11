Return-Path: <linux-fsdevel+bounces-7782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC882AB0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 10:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC80D28BAD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 09:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CE410A2F;
	Thu, 11 Jan 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG0OP3Kl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2312E55;
	Thu, 11 Jan 2024 09:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4322C43394;
	Thu, 11 Jan 2024 09:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704965513;
	bh=GOKYIrNJmnVcviaScxu30qp4yGiMKhhgc3g+c6uuz0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PG0OP3Kl8NQPrrQQK/XJzG5sbgLFc8sJIAi73MRMR5jryZXclCJN2ADci+LAheEXl
	 tYlOpVoEYWManosG85Ey98s43FtVnKBECwIwcCcseBKm1qkCH2TcGiBR+NgATvl3H4
	 IsggHN2/iQQhhCRT9mq3IfL1JQLJnnWCJ5fSutEKPYJQf9kCYJYtedluYa77KORZQ8
	 yXx+s3NlLlWq3gDXpgEWg8cTROd1H6VL0aoerpjqOo1fEHTfx/TGl+EnTy67Bj35uJ
	 hnQxcihCLFjR87TL6H7lKddMK3zthi4ZxkXfBqwxezt8GoOcGR/O1byde10JYgeCM5
	 KrtCDIR3Dd75A==
Date: Thu, 11 Jan 2024 10:31:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs: remove duplicate built-in __initramfs_start
 unpacking
Message-ID: <20240111-gerochen-gerede-7dcbce468f13@brauner>
References: <20240111062240.9362-1-ddiss@suse.de>
 <20240111064540.GA7285@lst.de>
 <20240111191510.09fbab13@echidna>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240111191510.09fbab13@echidna>

On Thu, Jan 11, 2024 at 07:15:10PM +1100, David Disseldorp wrote:
> On Thu, 11 Jan 2024 07:45:40 +0100, Christoph Hellwig wrote:
> 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks Christoph.
> I don't think there's a regular tree for queueing initramfs changes.
> Christian: would the vfs queue be appropriate?

Certainly. I've picked it up now. You should receive a thank you message
in a minute.

Thanks for making me aware of this!

