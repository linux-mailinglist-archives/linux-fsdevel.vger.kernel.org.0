Return-Path: <linux-fsdevel+bounces-70036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446CC8EBC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 15:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DB6934A07F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A75132BF44;
	Thu, 27 Nov 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea0Y1G0Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52CE1FE46D
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764253429; cv=none; b=b3Gc5g9Y4DcsRqfYlP/zi6k0spm28o9fxTGuB+j5LJjfuXDJ2ws9Z65VDy9F8jD5b9WTTyy0GJrDerkl3BWDaUcIPMsZa1FurFYJqRCQEo4DJuIRQw2y6ZKr814ZoaXYcc/7pDKPNrQfPbSClryndkkSJl81PdgVq3YbChwLVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764253429; c=relaxed/simple;
	bh=r07qtYGEb7AnC6anOUPmwTrLLsNrLYAVrCgqJnbbPKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFxzp5+V4DReFt3wkcJkttRXe/jIXCd7v33sxMA3enx9ZjOseQl3hyG5UvW5XW7TYp5AK+cyhpSYJ0EFjmNLRJ2SBcusTdeWG3iM3ak3Jn6aAoNcOT6MWM23NO843Rg4uJo3elJymMfov9MIk8qCYJpaJ9ppVccX+4/tJhI9IJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea0Y1G0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C07C4CEF8;
	Thu, 27 Nov 2025 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764253429;
	bh=r07qtYGEb7AnC6anOUPmwTrLLsNrLYAVrCgqJnbbPKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ea0Y1G0Z9/IYHDSbEJavEbqdCjuH+PodNnjxcOx1VYe8B9FNt1npwgiWl7/1n9u+z
	 4r+9W/9pCLq/pl9obQ9xEkONlBJx5UgCU0G3BrO+2pej+1luBmvtKE6VybD4ZK1/Oa
	 vG0GZBHaoIB264JoVRe8F8tE0BFYqzOK0nksIan7ieNW+veVUML2UIZxMzexCAIQOZ
	 A21J0ZFBNi3N77/h+QIK8xufyreIAkbAffPPmQWGMEiN6xEdcgyYrMuR/lOdGXXmQ8
	 S0C98IQWCX3a6fDGRx9jkPawe9XTu/eQo1SobnfJbMlTJrGLzo5dhjtQjeU3jYPk3c
	 MEQpa4/8DPZQQ==
Date: Thu, 27 Nov 2025 15:23:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, 
	"Saarinen, Jani" <jani.saarinen@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: REGRESSION on linux-next (next-20251125)
Message-ID: <20251127-entnehmen-fokussieren-3159ffb8e98b@brauner>
References: <a27eb5f4-c4c9-406c-9b53-93f7888db14a@intel.com>
 <20251127-agenda-befinden-61628473b16b@brauner>
 <5ffeb0af-a3c9-4ccb-a752-ce7d48f475df@intel.com>
 <20251127-kaktus-gourmet-626cff3d8314@brauner>
 <78e1b97d-837f-48e9-882f-8320473ec9bb@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78e1b97d-837f-48e9-882f-8320473ec9bb@intel.com>

On Thu, Nov 27, 2025 at 06:16:05PM +0530, Borah, Chaitanya Kumar wrote:
> 
> 
> On 11/27/2025 4:13 PM, Christian Brauner wrote:
> > I just pushed:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.19.fd_prepare
> > 
> > If you want to test that, please.
> 
> aah! only the sync_file.c change you suggested was not fixing the issue. But
> with [1] on top of linux-next, the issue is now resolved.
> 
> It also solves another issue[2] we bisected (before I could report it to
> you, which is never a bad thing)
> 
> Thank you.

Yes, sorry, two pretty obvious mistakes on my side. Thanks for testing!

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.19.fd_prepare&id=bf44cb6382f90fbda2eeae67065dc9401a967485
> [2] https://intel-gfx-ci.01.org/tree/linux-next/next-20251125/bat-mtlp-8/igt@core_hotunplug@unbind-rebind.html

