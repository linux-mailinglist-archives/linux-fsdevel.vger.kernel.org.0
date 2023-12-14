Return-Path: <linux-fsdevel+bounces-6033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E5D8124DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 03:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB28B21275
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 02:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A85802;
	Thu, 14 Dec 2023 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="R29QRSd2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786D385
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 17:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mpCBnjQo/44mFVnof1U7TK+Dw27YW8ACazu4SL9I5tA=; b=R29QRSd2ztGgULsgRR4ck/TPBC
	O3eSwfOeZbleMS8FuJdmbXLdBp/SynaU3Z5pXV8frttoNMM9i3YbjQ78yZgd5l2RzKt8VYL9vFkPc
	XOStuvi5hESY3WV5cK3w+g5JLUgOKJl6ylHMEgJSljFv2ydAXH9DTO+92OYkz6soAwDTqtgpPg5tu
	lZd1Ii+PWYZfZolsteukDnv9wGDBOPtrnU9w8pqhTEZGuQ50g0LxOe/Qh0Rsc1Hkt9lquAz4bRwSe
	C3mEnFbfiw/43nxG+JLiP2Keh0NaLnG7YI4xCAuIgxuSHkDe7efe9fjsBzNA0TCBw43ia8ST75mHe
	xerzTMwA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDb0j-00ByRT-1X;
	Thu, 14 Dec 2023 01:59:37 +0000
Date: Thu, 14 Dec 2023 01:59:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:headers.unaligned 2/2]
 include/linux/unaligned.h:119:16: sparse: sparse: cast truncates bits from
 constant value (aa01a0 becomes a0)
Message-ID: <20231214015937.GO1674809@ZenIV>
References: <202312140955.cqLj4SLn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312140955.cqLj4SLn-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 14, 2023 at 09:25:30AM +0800, kernel test robot wrote:
> Hi Al,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

It is, unless the mainline does *not* have equivalent warnings refering
include/asm-generic/unaligned.h instead of include/linux/unaligned.h

