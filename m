Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A41436D163
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 06:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhD1Edd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 00:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhD1Edd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 00:33:33 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD8C061574;
        Tue, 27 Apr 2021 21:32:48 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbbsS-008tr3-K1; Wed, 28 Apr 2021 04:32:44 +0000
Date:   Wed, 28 Apr 2021 04:32:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [iov_iter]  2418c34937: Initiating_system_reboot
Message-ID: <YIjlbF/F9Y/5YOzt@zeniv-ca.linux.org.uk>
References: <20210428023747.GA13086@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428023747.GA13086@xsang-OptiPlex-9020>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 10:37:47AM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 2418c34937c42a30ef4bccd923ad664a89e1fbd4 ("iov_iter: optimize iov_iter_advance() for iovec and kvec")
> https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git untested.iov_iter
> 
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Could you try https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git for-lkp
on the same test and see what (if anything) gets spewed into dmesg?
