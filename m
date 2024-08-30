Return-Path: <linux-fsdevel+bounces-28047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F0A9662C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DB41C234EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C81A1A2860;
	Fri, 30 Aug 2024 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuV78ntK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B8E13635B;
	Fri, 30 Aug 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023831; cv=none; b=XEOVllOVxL5LjcJmTz3HdZCYJCED54bt0jpjySyQ4E3O4QRpC8bpXpwfNIlS5FneHTC50Zw2suWzOkuW2BQ9TtpxeBLm6S7IvUWRLZy339wOmzYI5/n3hXxXE3l8Spad52HEhxfzcONIU5hV8wPDTgyavMeLeY8EX5d+YH/Tn/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023831; c=relaxed/simple;
	bh=TcDTJRaPELReivBPxvvSd+y7D7MEGkufPnGS3PdYcyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIUbiATsGZ7/SRPn3u6hAC5lxA1RL/pA7tflfE1ARUliVw2Uq7Vq3oPUfCQpPsokVWbaEuMceC2F9zOefAMhrwF37Vj3Jq9s8ZLZYfXLeNmR3VnXz813kutl23Fvz5pIRseEdifQDckUTyyteBnO8gC/FnmCFHL4gbplH4ZJOLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuV78ntK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7071AC4CEC2;
	Fri, 30 Aug 2024 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023831;
	bh=TcDTJRaPELReivBPxvvSd+y7D7MEGkufPnGS3PdYcyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XuV78ntKfPJzbcgh8/mlP1vsTNFoyq5Lm32o+gVEnycpdMQkUcleum03MJ5nip1bw
	 KKtcS8zbrGF5WtohSodiEjzf2ZN+iOiCTUQAzGQ6w652hCPo7DWYOK7COZzJq1cg8h
	 ZskxYyMtYjbid+vDs7U00rjB3lxlul/kWXlgZ4akJmDGLJ1TzpnsCmG3w3HfBP0Su2
	 5MKkEiIiORRIDP5omslbsqoxOxwGR1D54Y9U2s+hZtSAsrGeOF5Yr8fGstKfV0pEEN
	 lMT+axfxXTZEt0/pp9+kO+ExITl8tXRf/d4DFcqGQtSIU2DlV+KEj94GsAfw8RbPtb
	 +QsamTjDWt+Fg==
Date: Fri, 30 Aug 2024 15:17:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, dhowells@redhat.com, 
	jlayton@kernel.org
Subject: Re: [RESEND PATCH] fscache: Remove duplicate included header
Message-ID: <20240830-weihnachten-umtreiben-d3a9f1aee2e7@brauner>
References: <20240628062329.321162-2-thorsten.blum@toblux.com>
 <20240628-dingfest-gemessen-756a29e9af0b@brauner>
 <4A2EAFA2-842F-46EF-995E-7843937E8CD5@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4A2EAFA2-842F-46EF-995E-7843937E8CD5@toblux.com>

On Thu, Aug 29, 2024 at 02:29:34PM GMT, Thorsten Blum wrote:
> On 28. Jun 2024, at 10:44, Christian Brauner <brauner@kernel.org> wrote:
> > On Fri, 28 Jun 2024 08:23:30 +0200, Thorsten Blum wrote:
> >> Remove duplicate included header file linux/uio.h
> >> 
> >> 
> > 
> > Applied to the vfs.netfs branch of the vfs/vfs.git tree.
> > Patches in the vfs.netfs branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs.netfs
> > 
> > [1/1] fscache: Remove duplicate included header
> >      https://git.kernel.org/vfs/vfs/c/5094b901bedc
> 
> Hi Christian,
> 
> I just noticed that this patch never made it into linux-next and I 
> can't find it in the vfs.netfs branch either. Any ideas?

Picked into vfs.fixes.

