Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0616836FDE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 17:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhD3PiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 11:38:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:1612 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhD3PiL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:38:11 -0400
IronPort-SDR: iqdTu+KKd5eh/9jbdygoq+Pu5hMGeefrKoQfpQ1wFa3vbjZSEVdwrLnVmnk/u9X3ibdXKG9UIp
 wA9zqc/fmixw==
X-IronPort-AV: E=McAfee;i="6200,9189,9970"; a="196865193"
X-IronPort-AV: E=Sophos;i="5.82,263,1613462400"; 
   d="xz'?scan'208";a="196865193"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 08:37:21 -0700
IronPort-SDR: y4NiguFVGo9clL3pWdgvh18tMNGati0oedHbJUB4iuA/rN/UDDuHamXBmdx6PI3EixblWlcE3g
 6czixA17o6ug==
X-IronPort-AV: E=Sophos;i="5.82,263,1613462400"; 
   d="xz'?scan'208";a="431487328"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 08:37:18 -0700
Date:   Fri, 30 Apr 2021 23:54:31 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [iov_iter]  2418c34937: Initiating_system_reboot
Message-ID: <20210430155431.GB20100@xsang-OptiPlex-9020>
References: <20210428023747.GA13086@xsang-OptiPlex-9020>
 <YIjT+lZNn46VgscR@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <YIjT+lZNn46VgscR@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi, Al Viro,

On Wed, Apr 28, 2021 at 03:18:18AM +0000, Al Viro wrote:
> On Wed, Apr 28, 2021 at 10:37:47AM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 2418c34937c42a30ef4bccd923ad664a89e1fbd4 ("iov_iter: optimize iov_iter_advance() for iovec and kvec")
> > https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git untested.iov_iter
> > 
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +--------------------------+------------+------------+
> > |                          | c5f070c68e | 2418c34937 |
> > +--------------------------+------------+------------+
> > | boot_failures            | 0          | 11         |
> > | Initiating_system_reboot | 0          | 11         |
> > +--------------------------+------------+------------+
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
>  
> Could you run it with soft_panic=1 in command line?  Alternatively, some
> information about how to reproduce that without running hell knows what
> as root on host would be very welcome; I can't imagine a single reason
> for needing root to run qemu, to be honest...

not sure if this soft_panic=1 test is still useful, but from test, it seems
not generate more useful information (attached one for example).

and if you still want this test, could you help check our command line and
maybe supply further information how to enable it properly?


--E39vaYmALEf/7YXx
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg-soft_panic.xz"
Content-Transfer-Encoding: base64

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

--E39vaYmALEf/7YXx--
