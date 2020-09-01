Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E572588C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 09:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgIAHIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 03:08:48 -0400
Received: from verein.lst.de ([213.95.11.211]:52124 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAHIq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:08:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3B84668B05; Tue,  1 Sep 2020 09:08:42 +0200 (CEST)
Date:   Tue, 1 Sep 2020 09:08:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>,
        lkp@lists.01.org, rui.zhang@intel.com, yu.c.chen@intel.com
Subject: Re: [fs] ef30fb3c60: kernel write not supported for file
 /sys/kernel/softlockup_panic
Message-ID: <20200901070841.GA29847@lst.de>
References: <20200827150030.282762-2-hch@lst.de> <20200901064849.GI4299@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901064849.GI4299@shao2-debian>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks like since the start of this series we've grown new code to
use kernel_write on sysctl files based on boot parameters.  The good
news is that this just means I need to resurrect the sysctl series
as all that work was done already.
