Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C76E135F60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 18:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbgAIRcs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 12:32:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:17885 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgAIRcs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:32:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 09:32:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="423323930"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jan 2020 09:32:44 -0800
Date:   Fri, 10 Jan 2020 01:31:40 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RESEND v5] x86/resctrl: Add task resctrl information
 display
Message-ID: <20200109173140.GB11490@chenyu-office.sh.intel.com>
References: <20200109135001.10076-1-yu.c.chen@intel.com>
 <20200109145355.GC61542@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109145355.GC61542@chrisdown.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chris,
Thanks for looking at this patch.
On Thu, Jan 09, 2020 at 02:53:55PM +0000, Chris Down wrote:
> Chen Yu writes:
> > +#ifdef CONFIG_PROC_CPU_RESCTRL
> > +	ONE("resctrl", S_IRUGO, proc_resctrl_show),
> 
> There was already some discussion about "resctrl" by itself being a
> misleading name, hence why the CONFIG option eventually became
> CONFIG_X86_CPU_RESCTRL. Can you please rethink the name of this /proc file,
> and have it at least be "cpu_resctrl" or "x86_resctrl" or similar? :-)
Ok, I'll change the name from "resctrl" to "cpu_resctrl", because:
1. it is a CPU feature so a 'cpu' prefixed seems to be more obvious,
2. other CPUs than x86 could also use this file in the future.

Thanks,
Chenyu
