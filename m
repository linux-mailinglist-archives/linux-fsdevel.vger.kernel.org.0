Return-Path: <linux-fsdevel+bounces-12568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CC2861274
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01741B215FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680B27EF1D;
	Fri, 23 Feb 2024 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="V7mt5epm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63EF5C60F;
	Fri, 23 Feb 2024 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694190; cv=none; b=dmjsdpWO/8hPYBvq6hamHzBkiRsyxbwGjPhQIk97U/R70M67Dp88OMRdrl9P/nnlirTlL92QWcKO5R0jUuxqYWQC43/UFG/R9gqwOBb0Nyu9lFb3TpGFglXGoVqzwmKs++E+/RVfY5Vloo/cooMOdCvbEMOPIU8EXH+LWblopY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694190; c=relaxed/simple;
	bh=DMl9SaIfNnCiPqZcr2KHiTkWmnMLoueDw9vzCtQ0OcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMVA15pPScr9Q17PZz2ep8VhQmgzwDNp8xSOLwV5q5JaEIl6jkl+0nsXGqg8xeiHpuJvfP0GnxSsLN8lgQn97Bl/MT5/XFnaOeFQtB4e2+/VLXWt0wMY804gpJvyQ7r2p2EKBU+gf4dp0sZYmLIWlps0aWqsKpgoAX94IfXCmTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=V7mt5epm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fosF7GfKf2usxsyEbl1OhNuYQcSb047/bfaGYF2Hs5I=; b=V7mt5epm1aNYA7oARhYrU1rRos
	FL01jcgnFchLQ/9k791iZeOzv+o97fToKMuq0HqSWnMJXd6GeNbgSHwWX09XOPKgTbxvIVEV8OPO4
	ej9xe0VjC3wsy7cU7Xb+Ba6r4Cr9uEItiDIt8OGL+SD0vewcmeFV+KxTQ3zNxHG+AwiGtZX3MKPv2
	w/5SbY4rf/V37fppF5wdbR1kpPddcQKqR7s99HoOfypWwRoRsG1R3vGI9Rnt4rRwGBCZZTHJpIs57
	uHEwT0tG/M+mW71uDNN/FxrkfwmtrqH9TjL0ZkbKvRl9ighwpY8Iizoyxj0vTdMM+n9OQYjJBNZMi
	lRsiJ3VA==;
Received: from 179-125-75-196-dinamico.pombonet.net.br ([179.125.75.196] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rdVPa-002gSY-Nm; Fri, 23 Feb 2024 14:16:23 +0100
Date: Fri, 23 Feb 2024 10:16:17 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
Message-ID: <ZdiaoVT8ZqGkH6oQ@quatroqueijos.cascardo.eti.br>
References: <20240222203013.2649457-1-cascardo@igalia.com>
 <87bk88oskz.fsf@mail.parknet.co.jp>
 <Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
 <874jdzpov7.fsf@mail.parknet.co.jp>
 <87zfvroa1c.fsf@mail.parknet.co.jp>
 <ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
 <87v86fnz2o.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v86fnz2o.fsf@mail.parknet.co.jp>

On Fri, Feb 23, 2024 at 09:29:35PM +0900, OGAWA Hirofumi wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
> 
> > So far, I have only seen expected correct behavior here: mkdir/rmdir inside the
> > "bogus" directory works. rmdir of the "bogus" directory works.
> >
> > The only idiosyncrasies I can think of is that if neither "." or ".." are
> > present, the directory will have a link of 1, instead of 2. And when listing
> > the directory, those entries will not show up.
> >
> > Do you expect any of these to be corrected? It will require a more convoluted
> > change.
> >
> > Right now, I think accepting the idiosyncratic behavior for the bogus
> > filesystems is fine, as long as the correct filesystems continue to behave as
> > before. Which seems to be the case here as far as my testing has shown.
> 
> There are many corrupted images, and attacks. Allowing too wide is
> danger for fs.
> 
> BTW, this image works and pass fsck on windows? When I quickly tested
> ev3fs.zip (https://github.com/microsoft/pxt-ev3/issues/980) on windows
> on qemu, it didn't seem recognized as FAT. I can wrongly tested though.
> 
> Thanks.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

That image was further corrupted by mounting it on linux, as is mentioned
in one of the github issues. Let me see if I can arrange the Windows
testing of images I was able to test with. I can later attach them too, as
they should compress very well.

Cascardo.

