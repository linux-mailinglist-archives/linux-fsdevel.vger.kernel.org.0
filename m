Return-Path: <linux-fsdevel+bounces-6598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92A181A620
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 18:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950F72863F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 17:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964CC47791;
	Wed, 20 Dec 2023 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A+xiIs5P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8247789
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=QASNwzP7RGEObnbD8MsoAt08k8vwAOr8PlYPQ/biv2w=; b=A+xiIs5PRoHrzBv013ebo2K+BB
	9WokmsX5ybK55tAJk2c0Qqpxd/BZFCtwBql8t/jqHoiWmV+BrGymdN66feNBWgWRDPutsHHpss1Zn
	rlxl4vpuxFfZvCMQluVqIz5hX5eo8+8qYyBA4ttSrpuFaax83PbuNwQWsiOYRPTtiIFLYf6lhxhsr
	QteM1ToPTX6KCqgET6aLaek5D0oZGMkhTr/sIr9iLbL/Ao11p6kRl1TuAZEE3AWrcbuDEdY5Hl5Yn
	8UNL1mMU5c5uaCpMydNfKeHl2PshD6JhT5Kjpdj8W9YoTfFXN87hlVOTnE5pSuEhREpWoIT+Jelvg
	aZwqlDmw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rG0A5-000Vlj-1q;
	Wed, 20 Dec 2023 17:15:13 +0000
Date: Wed, 20 Dec 2023 17:15:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andreas =?iso-8859-1?Q?Gr=FCnbacher?= <andreas.gruenbacher@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHES] assorted fs cleanups
Message-ID: <20231220171513.GW1674809@ZenIV>
References: <20231220051348.GY1674809@ZenIV>
 <CAHpGcMJO=3tSg2Ouwgw-WS8HD6viyomr1hxqG-8CiFmMNzCriQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMJO=3tSg2Ouwgw-WS8HD6viyomr1hxqG-8CiFmMNzCriQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 20, 2023 at 01:16:31PM +0100, Andreas Grünbacher wrote:
> Al,
> 
> Am Mi., 20. Dez. 2023 um 06:13 Uhr schrieb Al Viro <viro@zeniv.linux.org.uk>:
> >         Assorted cleanups in various filesystems.  Currently
> > that pile sits in vfs.git #work.misc; if anyone wants to pick
> > these into relevant filesystem tree, I'll be glad to drop those
> > from the queue...
> 
> thanks, I've added the two gfs2 patches to our for-next branch.

Dropping those two...

