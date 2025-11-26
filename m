Return-Path: <linux-fsdevel+bounces-69919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E589C8BB78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 922373589A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 19:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF818342523;
	Wed, 26 Nov 2025 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BHndPZwG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E167341069;
	Wed, 26 Nov 2025 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186733; cv=none; b=MZPT8FGklNMvFKmdn+mV5K/Z/2ihcQyVVrjbPjit9KTuctDaAviXTLN/EM8COsLzzN5oZCb7dDegpSyRZP4bluaNBmRR5QgBAJMvcA/KaDm8/yZ1JPlqQP1f+iLaN1+Bn4Hla3rM/JTkGZVSj9EBJ0uXVgbgTYYqpLxQTzmU6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186733; c=relaxed/simple;
	bh=IDbiAn47mRrdNWWdJk1P+5Mok84WKTmYvTwqwFEo4kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA+tYuyPJx+0Fuh3KyVn24aFeWQnLbLdAqxK3JESSOaESs2QhHshY746IjoeZkhlvtz1v2kg+S4g4vErRO1P1fdRVTdonG/KFMHpdQYLZH4LaYGTxd80vfpFbC7uAKsngpJPNQ7lArEeHoOxsil/ulL2mtCNQr+8K2mdv0lxb+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BHndPZwG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F9CMg7xCCCe7pvWjCkZUtW9tN5r9wm9+9Wqdv/t8aKI=; b=BHndPZwGPTrM215ddveW6SCQGS
	w5XGshZORwCGNkF8wPex0jf0EUyPFK42vLiC8mTGhk+tO6My2wml6VI0EsCSE2x4vzP4RS3RM2FEr
	lIWTKBpIZsjjNZedOqvW17H9D4sdzF7bEHaBbp3kIO9Fn2PrApcD17fPyx+UpKuLfsy3aPWxinpDV
	sDejfX89mi//7BMUyjo+iWwITrIg/kt2sM2gf2XYfhdVtASKmx7bkn3q3toxJm7yAJQLqE2K8M8wi
	7Zz8OhoN0oy5k2OZqqEPYmZInZGg4p53iAQ37QqdvZp1utXGyGhaL8SAv//OBGvF//QTmxqepp7NU
	1/vp9G6Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39804)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vOLYU-000000004SL-1B7L;
	Wed, 26 Nov 2025 19:51:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vOLYR-000000001yH-0OLR;
	Wed, 26 Nov 2025 19:51:55 +0000
Date: Wed, 26 Nov 2025 19:51:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, brauner@kernel.org, jack@suse.cz,
	will@kernel.org, nico@fluxnic.net, akpm@linux-foundation.org,
	hch@lst.de, jack@suse.com, wozizhi@huaweicloud.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	lilinjie8@huawei.com, liaohua4@huawei.com,
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com
Subject: Re: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad()
 with rcu read lock held
Message-ID: <aSdaWjgqP4IVivlN@shell.armlinux.org.uk>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <20251126101952.174467-1-xieyuanbin1@huawei.com>
 <20251126181031.GA3538@ZenIV>
 <20251126184820.GB3538@ZenIV>
 <aSdPYYqPD5V7Yeh6@shell.armlinux.org.uk>
 <20251126192640.GD3538@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126192640.GD3538@ZenIV>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 26, 2025 at 07:26:40PM +0000, Al Viro wrote:
> On Wed, Nov 26, 2025 at 07:05:05PM +0000, Russell King (Oracle) wrote:
> > On Wed, Nov 26, 2025 at 06:48:20PM +0000, Al Viro wrote:
> > > It's been years since I looked at 32bit arm exception handling, so I'd need
> > > quite a bit of (re)RTF{S,M} before I'm comfortable with poking in
> > > arch/arm/mm/fault.c; better let ARM folks deal with that.  But arch/* is
> > > where it should be dealt with; as for papering over that in fs/*:
> > 
> > Don't expect that to happen. I've not looked at it for over a decade,
> > I do very little 32-bit ARM stuff anymore. Others have modified the
> > fault handling, the VM has changed, I basically no longer have the
> > knowledge. Effectively, 32-bit ARM is unmaintained now, although it
> > still has many users.
> 
> Joy...  For quick and dirty variant (on current tree), how about
> adding
> 	if (unlikely(addr > TASK_SIZE) && !user_mode(regs))
> 		goto no_context;
> 
> right after
> 
> 	if (!ttbr0_usermode_access_allowed(regs))
> 		goto no_context;
> 
> in do_page_fault() there?
> 
> NOTE: that might or might not break vdso; I don't think it would, but...

I don't understand how that helps. Wasn't the report that the filename
crosses a page boundary in userspace, but the following page is
inaccessible which causes a fault to be taken (as it always would do).
Thus, wouldn't "addr" be a userspace address (that the kernel is
accessing) and thus be below TASK_SIZE ?

I'm also confused - if we can't take a fault and handle it while
reading the filename from userspace, how are pages that have been
swapped out or evicted from the page cache read back in from storage
which invariably results in sleeping - which we can't do here because
of the RCU context (not that I've ever understood RCU, which is why
I've always referred those bugs to Paul.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

