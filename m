Return-Path: <linux-fsdevel+bounces-24323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CE793D41C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 15:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE380B23CDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 13:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EB717BB2F;
	Fri, 26 Jul 2024 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N28z2Dnd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF33E143889;
	Fri, 26 Jul 2024 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000136; cv=none; b=YHMagqhfwgE0IL+cKjTXCVIBSq63HGt3tQqE5fLG3kjIosgBd1TlH2hi5ogwYXtQHOwYTnwwQTqr8JrNN6FP0t6eHpwbuwRR+ipJ/OXb3ChN+ROl8IfHyMZKsUTFXBZHCQOc/omOiEZUPq6Lt9UEH9A3Ei6DzNUMYSX626enbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000136; c=relaxed/simple;
	bh=2XPNAANLlnV18mYheSqcXKSvPqiSzT1mkrdmG03hAHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q25aK+EqIWuJXHG+b0v6CkHzwVpEF/KxIiu3iQp+s5xPT/pmfhA0zSJZudYOD3wUnRLExwJctOViLdckRKwmqrin5r5TL5gHgSY2VuX/1mfZ9clPSV9Hr5XxE7TzP8ov9OjN1vPVct3Yj00udT5sGrkcUfYeKPKhB/2NHAT/f4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N28z2Dnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB14C32782;
	Fri, 26 Jul 2024 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722000135;
	bh=2XPNAANLlnV18mYheSqcXKSvPqiSzT1mkrdmG03hAHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N28z2DndMp3MEstTCyzAuQOTUMcD2/dS12rriNfZQyHu02MQtepDOm3B2GRUDJhpX
	 qhc6dz17K3AtVDQr5mlVdjft44oniEFUzfd3FWG2vE+nZ9xKV8Euz0wvOyMl+T7myD
	 l51XAsXRPE0a35s49WnqTxESJMY1cYeWGLfB9zRILENFzZ34s3rxD/poqOEpbzW56y
	 T9daK6hXfOrdWehsoXvOwm/UFtfWkeJZT0dgyzqds4GBQI4TCj8fFV8WWANVhg5FOG
	 oZ/RJWk14QePTTRJNtj88YGwxEwVoK0SyJ8OcHxwgRAj7LBx36SrfgxmgLgpmn35kn
	 AuRrPH9rgojpA==
Date: Fri, 26 Jul 2024 15:22:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org, 
	andrii@kernel.org, jannh@google.com, linux-fsdevel@vger.kernel.org, 
	jolsa@kernel.org, daniel@iogearbox.net, memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 0/3] introduce new VFS based BPF kfuncs
Message-ID: <20240726-clown-geantwortet-eb29a17890c3@brauner>
References: <20240726085604.2369469-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726085604.2369469-1-mattbobrowski@google.com>

On Fri, Jul 26, 2024 at 08:56:01AM GMT, Matt Bobrowski wrote:
> G'day!
> 
> The original cover letter providing background context and motivating
> factors around the needs for these new VFS related BPF kfuncs
> introduced within this patch series can be found here [0]. Please do
> reference that if needed.
> 
> The changes contained within this version of the patch series mainly
> came at the back of discussions held with Christian at LSFMMBPF
> recently. In summary, the primary difference within this patch series
> when compared to the last [1] is that I've reduced the number of VFS
> related BPF kfuncs being introduced, housed them under fs/, and added
> more selftests.

I have no complaints about this now that it's been boiled down.
So as far as I'm concerned I'm happy to pick this up. (I also wouldn't
mind follow-up patches that move the xattr bpf kfuncs under fs/ as
well.)

