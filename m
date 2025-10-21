Return-Path: <linux-fsdevel+bounces-64826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD08BF4F32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C3E1892317
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 07:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A327F005;
	Tue, 21 Oct 2025 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Kbuo+v+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900E21FBEAC;
	Tue, 21 Oct 2025 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031576; cv=none; b=ZGsMDlHfBPXjyEoFPPfINubzjuuCV+v4rqreruaO6df7NWsLVNmG58XsukM6CXQa3iUYyhKJFGKlRmOBrLElQqsmwoDM3pTyCd07wresln/G9ysFccO9INAWsDLbV7TdkbyMGc+RdHRNBmfgMYl+SOnxwiR/bGi6CPayhOlEm8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031576; c=relaxed/simple;
	bh=8+t9A0kZYWOlwZbL/Kjits3Uw62fi4VAwF1SOn82uzw=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HUyFeBypgr5jmIfwfjv2ict24exoeKfqtGXAfcYEmwyLa5bCvIgNFutdqcoAo8Fj1pxS/FVN6Wo7KspzePJnJ0cu+yYnS6u+Gn+QhI+EW8ZMylkkbOkSjnOfu73JUyutpPWDV6W8jAMr8MwxqnFS8gHIQYIPfyWvV+QvwpD1ZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Kbuo+v+r; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1761031573; x=1792567573;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:subject;
  bh=8+t9A0kZYWOlwZbL/Kjits3Uw62fi4VAwF1SOn82uzw=;
  b=Kbuo+v+rl6NY87CNlkg1XyK50UN/ugaIEW7QG6wwbyXg2h8C5KUbPHYc
   EeZIMMqbr/XpRzAs5Nd4lDojSnfS2K320Q8tnqX9L1wAH/fpS34i0+r42
   WnJG4bTVF73dBkZ0zmmGKjQ1HlpLhYXJjIvUk/PMcPU2EUhI9FIFHwG0L
   Vf9H6cqZx0EVVyA0JqfvELgHHUM7bww3ievY3g94eubCWOfikJ+z8E+tj
   r4YbYAl0bOt39iy9rHyYAul3sageo2HJs3xw+3C4BPNuwKz3Ar6hIBhp/
   T7kkRj/gmXiOqmseAxtsdK7uBlHSQ9aB7e94wxrtugq4Sx8MwycIPcEEC
   Q==;
X-CSE-ConnectionGUID: TYAeHBJkTkyfK88JJgTexA==
X-CSE-MsgGUID: BLPocVkKTgeQ6UWeWe47Mw==
X-IronPort-AV: E=Sophos;i="6.19,244,1754956800"; 
   d="scan'208";a="3819608"
Subject: Re: [PATCH 6.1 0/8] Backporting CVE-2025-38073 fix patch
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:25:52 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:2836]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.38.159:2525] with esmtp (Farcaster)
 id 06137168-4ab5-48ee-b858-30f80bdf9b8c; Tue, 21 Oct 2025 07:25:51 +0000 (UTC)
X-Farcaster-Flow-ID: 06137168-4ab5-48ee-b858-30f80bdf9b8c
Received: from EX19D013EUB004.ant.amazon.com (10.252.51.92) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 07:25:49 +0000
Received: from dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com.amazon.de
 (10.253.107.175) by EX19D013EUB004.ant.amazon.com (10.252.51.92) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 21 Oct 2025
 07:25:40 +0000
From: Mahmoud Nagy Adam <mngyadam@amazon.de>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <nagy@khwaternagy.com>, Jens Axboe
	<axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov
	<idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
	<adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu
	<chao@kernel.org>, Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong"
	<djwong@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, "Anna
 Schumaker" <anna@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Hannes Reinecke <hare@suse.de>, Damien Le Moal
	<dlemoal@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ceph-devel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-nilfs@vger.kernel.org>, <linux-mm@kvack.org>
In-Reply-To: <2025102128-agent-handheld-30a6@gregkh> (Greg KH's message of
	"Tue, 21 Oct 2025 09:16:18 +0200")
References: <20251021070353.96705-2-mngyadam@amazon.de>
	<2025102128-agent-handheld-30a6@gregkh>
Date: Tue, 21 Oct 2025 09:25:37 +0200
Message-ID: <lrkyqms5klnri.fsf@dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D013EUB004.ant.amazon.com (10.252.51.92)

Greg KH <gregkh@linuxfoundation.org> writes:

>
>
> On Tue, Oct 21, 2025 at 09:03:35AM +0200, Mahmoud Adam wrote:
>> This series aims to fix the CVE-2025-38073 for 6.1 LTS.
>
> That's not going to work until there is a fix in the 6.6.y tree first.
> You all know this quite well :(
>
> Please work on that tree first, and then move to older ones.
>

Yup, I've already sent a series for 6.6 yesterday:
https://lore.kernel.org/stable/20251020122541.7227-1-mngyadam@amazon.de/

- MNAdam



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


