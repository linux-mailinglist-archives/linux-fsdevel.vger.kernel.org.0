Return-Path: <linux-fsdevel+bounces-6045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28FD812B69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 10:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49713B212DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 09:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178652E3E0;
	Thu, 14 Dec 2023 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LRFGOXCe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1006518B
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 01:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CIaYFv+/pS0r5+q/6X3q7uuU1S6yT0o0nzV2Kv1T8Gk=; b=LRFGOXCetvVlsjBAB/D+7vKIQ+
	FcMt4ayDZpn7ww4+ag1F910AD4PAZeWszykS7fStrbGLxmcaqeN4naDLUA4+wt0EtJhEsSfCI0ell
	2z7M2z1jxyeU0wRzk8CX+E/e+nSYoQtTQ6mx+moYDASKpHemY75wlPgZIWqK6/t9voTcbTtNy7VIW
	iJFbyZnxP9uzY2u6uz+JFI+OlP6wahdc0aP5A5Q0LOrS2EarABun6udXaj/w3EPpPXmefyYsteyl1
	J7gtLLm1e6ReMxz3MIay/40Js4IMYQagG50pJw0QsxVtj4KjI2UppmXs9M+mLoR0eHUUg4bcp9W10
	s/iQNzLg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDhnO-00C7wj-29;
	Thu, 14 Dec 2023 09:14:18 +0000
Date: Thu, 14 Dec 2023 09:14:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:headers.unaligned 2/2] drivers/cxl/core/trace.h:11:10:
 fatal error: asm-generic/unaligned.h: No such file or directory
Message-ID: <20231214091418.GP1674809@ZenIV>
References: <202312141458.agmsUCZB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312141458.agmsUCZB-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 14, 2023 at 02:50:07PM +0800, kernel test robot wrote:
> Hi Al,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git headers.unaligned
> head:   959598f725aa7721a4bad53c2e997c7255ff32dc
> commit: 959598f725aa7721a4bad53c2e997c7255ff32dc [2/2] move asm/unaligned.h to linux/unaligned.h
> config: i386-buildonly-randconfig-002-20231214 (https://download.01.org/0day-ci/archive/20231214/202312141458.agmsUCZB-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312141458.agmsUCZB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312141458.agmsUCZB-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/cxl/core/pci.c:13:
> >> drivers/cxl/core/trace.h:11:10: fatal error: asm-generic/unaligned.h: No such file or directory
>       11 | #include <asm-generic/unaligned.h>
>          |          ^~~~~~~~~~~~~~~~~~~~~~~~~

Charming...   Anything of that sort deserves to be hunted
down and shot - including gems like this:

net/sunrpc/xprtrdma/verbs.c:58:#include <asm-generic/barrier.h>

OK, I'll adjust the script, but IMO we should make it a matter of policy -
*NOTHING* outside of arch/ and include/ should ever have
#include <asm-generic/whatever.h>

#include <asm/something.h> is generally best avoided, but it is
defendable; asm-generic is not.

