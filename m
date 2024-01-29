Return-Path: <linux-fsdevel+bounces-9285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E56583FC10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 03:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02B2282E4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 02:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9A1E55F;
	Mon, 29 Jan 2024 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X/2urYF1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413FEDF57;
	Mon, 29 Jan 2024 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706494395; cv=none; b=WL3npSFjmNt6WxGsRXb0bo27/mQAfCatRXPs1tPUEN95DdTJqt/3QE6Tx2+UFk4m5d2446fyolujPC3PDsLb/BfT/4L0rqFwGnstni9K3X1Z9aM1k+VRfeMpIAHGAgpQ2Nl146nUe6+Oip2fpDfmTSk8USR2aWdXpF1hLLRjGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706494395; c=relaxed/simple;
	bh=qKAZsTA5V1biK/wV673ngjjOBuUZbt/6b/iCDQTJULo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nB6+qMOsw2aZvIvprx2LO3K4uA4I/PdMhF7ZrhoRMMiYkaCjwMfJKXs1YFzPEkqajZCQBCc9cOSw47Gpq0Re8HKiJU0xuH5a68osjkW0WkZiz6ztEE5G7gniSMKjQtm1komu079vomXkm7Sy8muvGLf/cgU0AvVGdf3om/M8ISY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X/2urYF1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lAL3P084x7WQ6qVVeqeoAVBmL5c5NTI7cGrWGT3TUTU=; b=X/2urYF1jciDJ4IFOIHE34Fu58
	KYG0+3C0mc+xkYSOy6zT+QQmg9QzPm/VdX0efqfz+r+iEqKnemMpev4lAKP8/i5gzrmnF2WUZt4bB
	0l+QiZKVpWXv3Rv7ueuL9AdGLxT7n0XVPtojX85ZtyJXY8dPLL61V9JjHbOPTJADq+3OC8O4LZ2rk
	Xe09HmXbmabhctvc0SYfmJsfFs2aq9KhQ6Q81mQjTUudoO6+CRXDpbGS1Fx/MmA7wUFBNKmEDRSwF
	IkLvSyFRuVCWknk88kgvW2ptTejGwEiVW6uBI12faeL4vHg4G2uSu/WjOl0N4oCOQ7z4Gwok/VqTt
	sQhznZFQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rUH93-0006EJ-2c;
	Mon, 29 Jan 2024 02:13:09 +0000
Date: Mon, 29 Jan 2024 02:13:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.alpha 5/8] arch/alpha/kernel/io.c:655:1: error:
 redefinition of 'scr_memcpyw'
Message-ID: <20240129021309.GG2087318@ZenIV>
References: <202401280650.Us2Lrkgl-lkp@intel.com>
 <20240128211544.GD2087318@ZenIV>
 <CAHk-=wj8LUAX_rwM4=N9kNGeg=E+KoxY6uQfyqf=k7MOrb4+aA@mail.gmail.com>
 <20240128220904.GF2087318@ZenIV>
 <CAHk-=wih5PvaVpdgjLrAof6cX0SP9kM-z-pWczDk8EaHscDGzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wih5PvaVpdgjLrAof6cX0SP9kM-z-pWczDk8EaHscDGzg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jan 28, 2024 at 02:39:35PM -0800, Linus Torvalds wrote:
> On Sun, 28 Jan 2024 at 14:09, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Do we ever use that thing on iomem in non-VGA setups?
> 
> On iomem? No. But I think several of the routines just work on either
> VGA screen memory directly (c->vc_origin = vga_vram_base), or normal
> RAM (vc_allocate)
> 
> But who knows.. I *used* to know all this code, but happily no longer.


I hadn't finished going through the callers, but AFAICS in !VGA && !MDA
case alpha should be just fine with the fallbacks, so we could just
put the instance in io.c under the same ifdef that pulls asm/vga.h into
linux/vt_buffer.h

