Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C2BFD81B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 09:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKOIqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 03:46:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52074 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOIqp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:46:45 -0500
Received: from zn.tnic (p200300EC2F0CC300B4C5AF24BE56B25A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:b4c5:af24:be56:b25a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD0131EC0D02;
        Fri, 15 Nov 2019 09:46:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573807603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gzm0MsATgUeRf/cV4H3chmTT5kcyvLvkgX8Ha1pOZg4=;
        b=hlR76+RevqugKg4NnWt0MSY1yG3p7Yzg4h0iZWDTl315fdJlRF38T83a4HXKzwNnW+njDH
        My/PGVzkzqQaorJaVDDjc22AuoizeM+yazbhgzR78R2sUOUTw/JW7eo6CdeX+k5SiYCJ9I
        7muzQIQe8j2aCDXsEYgJS0oIzE31kO8=
Date:   Fri, 15 Nov 2019 09:46:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Shakeel Butt <shakeelb@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2][v2] resctrl: Add CPU_RESCTRL
Message-ID: <20191115084643.GE18929@zn.tnic>
References: <cover.1573788882.git.yu.c.chen@intel.com>
 <a39663fd4ce167e65b6d41027c3433dc00bf54f0.1573788882.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a39663fd4ce167e65b6d41027c3433dc00bf54f0.1573788882.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 01:24:20PM +0800, Chen Yu wrote:
> Introduce a generic option called CPU_RESCTRL which
> is selected by the arch-specific ones CONFIG_X86_RESCTRL
> or CONFIG_ARM64_RESCTRL in the future. The generic one will
> cover the resctrl filesystem and other generic and shared
> bits of functionality.
> 
> Suggested-by: Borislav Petkov <bp@suse.de>

I don't remember suggesting adding a separate CONFIG option...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
