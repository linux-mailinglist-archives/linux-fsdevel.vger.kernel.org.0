Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3590135F99
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 18:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbgAIRqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 12:46:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:13542 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731838AbgAIRqw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:46:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 09:46:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="396165253"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2020 09:46:49 -0800
Date:   Fri, 10 Jan 2020 01:45:45 +0800
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
Message-ID: <20200109174544.GC11490@chenyu-office.sh.intel.com>
References: <20200109135001.10076-1-yu.c.chen@intel.com>
 <20200109142444.GB61542@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109142444.GB61542@chrisdown.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chris,
On Thu, Jan 09, 2020 at 02:24:44PM +0000, Chris Down wrote:
> Chen Yu writes:
> > +#ifdef CONFIG_PROC_CPU_RESCTRL
> > +
> > +/*
> > + * A task can only be part of one control
> > + * group and of one monitoring group which
> > + * is associated to that control group.
> > + * So one line is simple and clear enough:
> 
> Can we please avoid using the word "control group" to describe these? It's
> extremely confusing for readers since it's exactly the same word as used for
> actual cgroups, especially since those are also a form of "resource
> control"...
> 
> Doesn't official documentation refer to them as "resource groups" to avoid
> this?
Right, how abut changing change this description to:
control group  ->   resctrl allocation group
monitor group  ->   resctrl monitor group?

Yes, the Documentation/x86/resctrl_ui.rst described them as
"Resource Control feature", which is composed of allocation
and monitor, so distinguish them as above seems to be appropriate.

Thanks,
Chenyu
