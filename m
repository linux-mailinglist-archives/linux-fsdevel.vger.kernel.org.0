Return-Path: <linux-fsdevel+bounces-53985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49170AF9B7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 22:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F6C1CA51EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 20:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E57C22CBD8;
	Fri,  4 Jul 2025 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CpLV6wvg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8812147F5
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751659833; cv=none; b=kj/Oqu5/bNCxxfPs3j1BUkWxCahBElGm/1mj8PBkH6Fu1rAMocDPsp0Wedmm0Aza6q90VUlSjpPc4KnJWVA0Pfy3W5kympdHyNpsiGh4O8YSHGB8dpnk9YWRoT7VLKMLgIsx2iEwbFiajqo3Jjj1k8nw9A5WW4jkRFP1FVvbTwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751659833; c=relaxed/simple;
	bh=73I/4ZDRPg+YXlVyFaN4zU5HfpKtQflbDl5HMS1BLoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSV9Zf9QMF7u692gxfs6hiZ5qlTan/8qDfapEHTTyFS+VdxoZOHlZTN7DtDpkoY5M/Gd0FQG2SMls0I455YY3UTzyit28ZRRDMOuH0mQWAV2ltLtNnhU+PP8/WgMIPlTgDBfvI//mk9coIIDVW9FGwkZU1VYrMqLe+NrPsK8w4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CpLV6wvg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=ca8LT9QZTBTIb6HKyszosTRGb2SKtCISAIjzJYBxmQQ=; b=CpLV6wvgzkkexpZDGR2DRlXFY8
	Cghfjtx/8IfnGNnrztwtHP4hXflY0vRIz7umiO9p3jl+Gw+TXmd5Ajiezkbr+PAW3z7DspMJ19/Sk
	vlqYUubzHDe0kO8COllXmzt1GGJkTKAcUS26AVrLZzIWNBAbdR6ECA79gp9TsFMnz5nlxg2asEDVB
	Z/WH5/ftKFSUBua9QNgKEdgumA9ceMZjdHD9KSJqXahcnWkeVWxHX7xo80q59mWzf7rTJ2AQbWwew
	uOmcyCrG4mvuFvCXm/rR2gyu8zgv9JNHGmQk290Ky5DAnCHMN2cyzXkxTj1lH928l7HrCioUwlbb+
	HKqDZAWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXmjr-0000000Eleu-3PnP;
	Fri, 04 Jul 2025 20:10:27 +0000
Date: Fri, 4 Jul 2025 21:10:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Justin Tee <justintee8345@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 11/11] lpfc: don't use file->f_path.dentry for comparisons
Message-ID: <20250704201027.GS1880847@ZenIV>
References: <20250702212917.GK3406663@ZenIV>
 <b3ff59d4-c6c3-4b48-97e3-d32e98c12de7@broadcom.com>
 <CAAmqgVMmgW4PWy289P4a8N0FSZA+cHybNkKbLzFx_qBQtu8ZHA@mail.gmail.com>
 <CABPRKS8+SabBbobxxtY8ZCK7ix_VLVE1do7SpcRQhO3ctTY19Q@mail.gmail.com>
 <20250704042504.GQ1880847@ZenIV>
 <CABPRKS89iGUC5nih40yc9uRMkkfjZUafAN59WQBzpGC3vK_MkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPRKS89iGUC5nih40yc9uRMkkfjZUafAN59WQBzpGC3vK_MkQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jul 04, 2025 at 11:33:09AM -0700, Justin Tee wrote:
> > Sure, but I'd rather do that as a followup.
> Yeup, that’s fine.
> 
> > Speaking of other fun followups
> > in the same area: no point storing most of those dentries; debugfs_remove()
> > takes the entire subtree out, no need to remove them one-by-one and that
> > was the only use they were left...  Something along the lines of
> > diff below:
> Very cool, thanks!  We’ll take that diff too (:
> 
> Also, may we actually move this enum declaration to lpfc_debugfs.h
> instead of lpfc_debugfs.c?
> enum {
>         writeGuard = 1,
>         writeApp,
>         writeRef,
>         readGuard,
>         readApp,
>         readRef,
>         InjErrLBA,
>         InjErrNPortID,
>         InjErrWWPN,
> };

Sure, no problem...  Your driver, your preferences - it's not as if
that had any impact outside.

While we are at it, handling of debugfs_vport_count looks fishy -
it's easier to spot with aforementioned delta applied.
        if (vport->vport_debugfs_root) {
                debugfs_remove(vport->vport_debugfs_root); /* vportX */
                vport->vport_debugfs_root = NULL;
                atomic_dec(&phba->debugfs_vport_count);
        }

        if (atomic_read(&phba->debugfs_vport_count) == 0) {
		...
	}
	return;
is OK only if all updates of that thing are externally serialized.
If they are, we don't need atomic; if they are not, this separation
of decrement and test is racy.

Note that if you do *not* have external serialization, there might
be another problem if you have the last vport removal overlap
with addition of another vport.  Or, for that matter, if removal
of the last vport on the last HBA overlaps with addition of a new
HBA...

Unless something has drastically changed, binding/unbinding of
a device to driver should be serialized by drivers/base/* logics;
no idea about the vports side of things...

