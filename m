Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314653086C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 08:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhA2Hv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 02:51:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:54478 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232327AbhA2Hv5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:51:57 -0500
IronPort-SDR: gUdtTLELIsO3eEfTHcj70M/boW25+k5Ej3tx+pDyja0QvA6hGRTt7XE11KA5nICjhcaJ3gwiGy
 U7yfCByvBa8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="159554792"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="159554792"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 23:50:03 -0800
IronPort-SDR: ZWufvdLxqWhtNoJddEVC92Qewkv4HYX+jv714KlxUzkLMnrZMpATCBqw3+l6VUPm6tnMxWzh8O
 EcMkBkkVeheQ==
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="389203998"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 23:50:00 -0800
Date:   Fri, 29 Jan 2021 16:05:58 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ltp@lists.linux.it,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [binfmt_elf] d97e11e25d: ltp.DS000.fail
Message-ID: <20210129080557.GB13077@xsang-OptiPlex-9020>
References: <20210106075112.1593084-1-geert@linux-m68k.org>
 <20210126055112.GA19582@xsang-OptiPlex-9020>
 <CAMuHMdUFsRSCDJeML+0i17ig6oFr+-cz660xyhkhkfg2UtPTzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUFsRSCDJeML+0i17ig6oFr+-cz660xyhkhkfg2UtPTzQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 09:03:26AM +0100, Geert Uytterhoeven wrote:
> Hi Oliver,
> 
> On Tue, Jan 26, 2021 at 6:35 AM kernel test robot <oliver.sang@intel.com> wrote:
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: d97e11e25dd226c44257284f95494bb06d1ebf5a ("[PATCH v2] binfmt_elf: Fix fill_prstatus() call in fill_note_info()")
> > url: https://github.com/0day-ci/linux/commits/Geert-Uytterhoeven/binfmt_elf-Fix-fill_prstatus-call-in-fill_note_info/20210106-155236
> > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> 
> My patch (which you applied on top of v5.11-rc2) is a build fix for
> a commit that is not part of v5.11-rc2.  Hence the test run is invalid.

sorry for false report. we've fixed the problem. Thanks

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
