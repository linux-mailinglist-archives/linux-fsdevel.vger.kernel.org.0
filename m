Return-Path: <linux-fsdevel+bounces-51767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F437ADB390
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B79F1891192
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5F28540B;
	Mon, 16 Jun 2025 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chF7aZUK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2792853ED;
	Mon, 16 Jun 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083395; cv=none; b=phH1M/ENRD6BnCM3OsIZ2Yn8NQEGkfvUMrhf6S49AFrpAgCY39zXKnE7E5DhaKutfRwzwhB+Wef0p44bTekbn/Vm8JquDm/iFspyLKAq2Ilx+POvzhNiUMMUdulT2XuL0DinWJ3xVpL1sdaEBQ4qS9dqTkL9Vr+Thci5zRO7DKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083395; c=relaxed/simple;
	bh=2uT8JC/DSi8Dq7nQMzcbObK0mkEgpa4jHBqH+uyt6Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utGAWgQ7Nfqf8tFLeYajSFB3laMa4OfWF0dR8NvwV8x/HdHa8g9ix6Pwk2EAZlnCsWmgQOn2XAcnCSnyne8rKdpIzLn2T2/bmpBx7ld3FE9Skw5E3WeBw+hWSINLvHKq4kPwxqDQE7INd92/kwz5h43A+L0UCeaUHnTycVX5ngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chF7aZUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530E6C4CEEA;
	Mon, 16 Jun 2025 14:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750083394;
	bh=2uT8JC/DSi8Dq7nQMzcbObK0mkEgpa4jHBqH+uyt6Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chF7aZUKMctuvja+Uwx3VOEeKbVkNsJtS+FOJsv1Yd6YBkTUB9gZBpfJYVNlWJ303
	 2nLd1z3C4bdhxtTAgHhD23j9vAA9rMMgUlq2Hc91KdQxbS8wLNXFV5+qP4ybzWGDFv
	 XWCADIvIIOZi+RLYta2P8lxkv44zYtXeCVR2EIyrkLeyYZm5BFDKTgOjd0YcgOoDmh
	 nD97+bYdy5hltcEQPcVet1PT8+42Ti2IUePEoi4TPA0kZ/0xdA8+oasMX8Qoto5G5s
	 ZDYgu7SFNuE1QBXwA1It7O/qnIaQuk0UmjNHXMY6IOc664ZTgd5eucPbLUDghmUOa6
	 XiWJni0XaiUxw==
Date: Mon, 16 Jun 2025 16:16:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: opened file never has a negative dentry
Message-ID: <20250616-quadrat-entmilitarisieren-5b80f13b60f9@brauner>
References: <20250615003011.GD1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250615003011.GD1880847@ZenIV>

On Sun, Jun 15, 2025 at 01:30:11AM +0100, Al Viro wrote:
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

