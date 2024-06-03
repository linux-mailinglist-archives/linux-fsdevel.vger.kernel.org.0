Return-Path: <linux-fsdevel+bounces-20855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823D38D885A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 20:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04443284313
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 18:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490B8137C43;
	Mon,  3 Jun 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeHcZpkN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E52135A46;
	Mon,  3 Jun 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437687; cv=none; b=TtUDFmr13j4u0iVxXg65Q6XkSmIbyH8lLMXeMtEZIrn9/9UBbNIUq66cnV/RHtd2NIQAMwe67h6ZakRZzil2+xALEZ7Q9m3mmsGTi74ZDC9kiPHdbL/luD91Z6vO+DMSl4A4bpM7i2I8YHQYHEH5ccpP+LX3OrHC536vTVzoUq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437687; c=relaxed/simple;
	bh=7wbfTvzN1ZGYxMgm7ZA/tR9fMo/2aHMXnL51s275mE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxP/XEF6vB/DaOChWptjCMCWr3ZxPtx5a5mWc6ulwDnmTalDCCyyqiXjsZ+TKs1XYB/rpWcAwkkW20C67VIT7sVk64WOyVvYencaTQKHdvjLRRU1hQpAQOsWgPcPiE66sAUiXvVtJhbPxu1KdPowMiCAMg6g1gvrCHBxxVx3xf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeHcZpkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6CCC2BD10;
	Mon,  3 Jun 2024 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717437687;
	bh=7wbfTvzN1ZGYxMgm7ZA/tR9fMo/2aHMXnL51s275mE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeHcZpkN4zwepuyuMN/cVcQXXrW4X7lsm8bk/i1qf6KEFBcesVZLxx+k/XNH1mSTQ
	 6g9fF6ZRUIJmJ379Lff5V3xeEUVpQcJydVHXCWZfcCiTEOMHKdCeRcznBFffV/s0in
	 iNBaSfub7M16NSQ3EuNwz0wLwmpZ+7AMydDRT+TUpSBVDx42BwxOp/NdzfAC2rr8rg
	 CQqZ9J/i5RhbWj+wn+PLmnS5DhuOOKWs20NyaoXZXPtXuv515s4wxXM3Px3eu+pYsf
	 YTe3wRH86dNDT0aCYc8seWxVOOLJ4LqtoSM5vClTe8Sn/ZqMWIPUxlje+C05LxCX9f
	 xCPtJhf3PYciA==
Date: Mon, 3 Jun 2024 19:01:21 +0100
From: Simon Horman <horms@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: amir73il@gmail.com, bhe@redhat.com, clm@fb.com, dhowells@redhat.com,
	dsterba@suse.com, dyoung@redhat.com, jlayton@kernel.org,
	josef@toxicpanda.com, kexec@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu, netfs@lists.linux.dev, vgoyal@redhat.com
Subject: Re: [RESEND PATCH 2/4] fscache: Remove duplicate included header
Message-ID: <20240603180121.GF491852@kernel.org>
References: <20240502212631.110175-2-thorsten.blum@toblux.com>
 <20240526212108.1462-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526212108.1462-2-thorsten.blum@toblux.com>

On Sun, May 26, 2024 at 11:21:09PM +0200, Thorsten Blum wrote:
> Remove duplicate included header file linux/uio.h
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Simon Horman <horms@kernel.org>


