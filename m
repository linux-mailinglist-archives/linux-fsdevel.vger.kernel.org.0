Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB7BFD818
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 09:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfKOIpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 03:45:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51908 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOIpz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:45:55 -0500
Received: from zn.tnic (p200300EC2F0CC300B4C5AF24BE56B25A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:b4c5:af24:be56:b25a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 730C41EC0D01;
        Fri, 15 Nov 2019 09:45:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573807554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Gb5IEaADnPzH/V2oziiwyoJzJJg2Z9ixAR/RHeDU0vk=;
        b=aDiwoGkaUudTm83t/aiUjy+TsJSC0eAADTKo7UTO5u8nwz4FXmkh7O9ldG9x26Ux8gt4eO
        P7PUAodJ0EUzcqKWiHOkLB7sMXU5r5emf26+109FZLMuwmVepDmj4q67R+Q1EvSaOWEcr9
        3+D4TaiD500UFyx7gHyVcIldHoJidVk=
Date:   Fri, 15 Nov 2019 09:45:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/resctrl: Add task resctrl information display
Message-ID: <20191115084554.GD18929@zn.tnic>
References: <20191107032731.7790-1-yu.c.chen@intel.com>
 <20191113182306.GB1647@zn.tnic>
 <20191115042411.GA11061@chenyu-office.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115042411.GA11061@chenyu-office.sh.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 12:24:11PM +0800, Yu Chen wrote:
> Okay, in next version proc_resctrl_show() is declared in resctrl.h.
> However since there's no common c source file for resctrl currently,

And what do we do if there's no .c file in the repo?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
