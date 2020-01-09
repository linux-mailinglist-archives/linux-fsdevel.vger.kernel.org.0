Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9B4135BC9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 15:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbgAIOx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 09:53:59 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:54854 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbgAIOx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:53:58 -0500
Received: by mail-wm1-f50.google.com with SMTP id b19so3228682wmj.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2020 06:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rUxPHa2T/qhjfPbBGgKT0jw2Pzfyyz7G8V70ESCMcRw=;
        b=V6FQkdls3RdCEqF/mu2mah0JUBnQeCeA2/rmb4KqnquLCXhwFabSCLIUAtoGpGytTu
         hs37ORj+RgTBBs6BP0kEDsoaqi7d1zj01UB5OvxuJKUmulPxpZmXE5S6BEcYsUxzp6hn
         17Z+yZ1Kw/5ysSD5DVe7CvuGiTqVJjmXixcog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rUxPHa2T/qhjfPbBGgKT0jw2Pzfyyz7G8V70ESCMcRw=;
        b=NYzeje7Z59JJIYA0w8gccD6UH8a1XqQYIHKmVIITOsFCWm2tDJYi0Y5TScer8M3/Nk
         Suta0oryIcCvucDaJ8ckC3Rvx2C/dnEFXGxFqfK801Och+4y5B/u1NCFT73TFRBEo43g
         yVgy5JgY6bnkCTP+yC4mD5OTU9rEvoMOTaMsW4TGpixpj+XP7juzAcpZGpgY0+MeepGN
         o/PFykCPnWWbj3rH4UFudFZ+OvxwrzGDriey9upCguLO6q/l+TQYIqb5UgMjLQCjLIiD
         J9DSw1KfpEIHP+vzopde5/h/x8B2FGvXgMgQyCT4Kg72UVCArGo3I6ZeRfuZnJ4Sfu0z
         rUhg==
X-Gm-Message-State: APjAAAUB9BkYvYbLkojAhRWWPfg9Bq/Mzxh+dPQDyPD8HN01qSrLsbsL
        aanlnxBk4iWbG/5DtRTvgqFswg==
X-Google-Smtp-Source: APXvYqzq0xB087gtDch3VgcD10JC1IwNoOD11dTRRE2inBUSxt3yaAvEH7p8AntjfBQlsiOZ0U8ijA==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr5240117wml.138.1578581636799;
        Thu, 09 Jan 2020 06:53:56 -0800 (PST)
Received: from localhost ([2620:10d:c092:200::1:37ce])
        by smtp.gmail.com with ESMTPSA id p7sm2966892wmp.31.2020.01.09.06.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:53:56 -0800 (PST)
Date:   Thu, 9 Jan 2020 14:53:55 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Chen Yu <yu.c.chen@intel.com>
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
Message-ID: <20200109145355.GC61542@chrisdown.name>
References: <20200109135001.10076-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200109135001.10076-1-yu.c.chen@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chen Yu writes:
>+#ifdef CONFIG_PROC_CPU_RESCTRL
>+	ONE("resctrl", S_IRUGO, proc_resctrl_show),

There was already some discussion about "resctrl" by itself being a misleading 
name, hence why the CONFIG option eventually became CONFIG_X86_CPU_RESCTRL. Can 
you please rethink the name of this /proc file, and have it at least be 
"cpu_resctrl" or "x86_resctrl" or similar? :-)
