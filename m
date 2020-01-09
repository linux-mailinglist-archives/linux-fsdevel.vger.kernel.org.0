Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A2C135B4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 15:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbgAIOYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 09:24:48 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38637 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgAIOYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:24:47 -0500
Received: by mail-wm1-f50.google.com with SMTP id u2so3052623wmc.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2020 06:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bwws+tO9I9tQbRiOVrZn10ifd3BCAQ4eGYhkP7+nREo=;
        b=GFv+wsOmFHcCod8xr4q4mFZcrLDXObBrNqM8qQca43lrRQjVBm3vPTwcdb5Yqq4n1/
         Uv1lW2i+PqKw6CukLnQ0G8HS6P5x7H9xw1ngCGDOkUnaPaaCbi7+znRr/A9l0tvrrPiG
         RRyMahdThv1GIzRU5Ndjfx/j5efxzs/DdYIXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bwws+tO9I9tQbRiOVrZn10ifd3BCAQ4eGYhkP7+nREo=;
        b=WsfmY2/4ng8Dmoipbsd6XFgifFnnXFFn/SUEUd0PxSJ0qKdOIWDPeh5MA6e9dhzraw
         D0A4ORbB8vtV4PMIUiMN8nG0vEtGJ0mMy+7a9Bv3oCBULlROn8aKEMX0HZ4E2WNxPbjt
         tZUfmsjRyC2ZnKGjJ5vvFlIiXtwcIoJtM/YgJSFxbx6XPz6kTEvBzNBd2S9I8q+D/0lh
         dNSa4672iItQCkRb4fv/BeTz2RD/RV9rLGQrbU3y8iMvcLLSRohrhdz6FfTGNrj2kH1g
         cm41jd2jBf33AbsoludAdfFDQtBFqUAUB/cSzlcXIvBYNiiTtk17vYbdVbbDpWKFytOH
         fM3A==
X-Gm-Message-State: APjAAAWxg5uO0hBlN9EkTVKLZuz5dDazcLrCCrRxvi92AOcWNeebJViX
        kHQFN3c3T4ZPVCYL72bqdQ8wtQhnF0MV42yp
X-Google-Smtp-Source: APXvYqwTvJP4R9irCho2zMdDcYd1x6gNkvv4B7wNNQVVD7l0ZQIvJRI00hikXfeJwMzr86wI2xtOSA==
X-Received: by 2002:a1c:b4c3:: with SMTP id d186mr5112329wmf.140.1578579885654;
        Thu, 09 Jan 2020 06:24:45 -0800 (PST)
Received: from localhost ([2620:10d:c092:200::1:37ce])
        by smtp.gmail.com with ESMTPSA id t81sm3070545wmg.6.2020.01.09.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:24:45 -0800 (PST)
Date:   Thu, 9 Jan 2020 14:24:44 +0000
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
Message-ID: <20200109142444.GB61542@chrisdown.name>
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
>+
>+/*
>+ * A task can only be part of one control
>+ * group and of one monitoring group which
>+ * is associated to that control group.
>+ * So one line is simple and clear enough:

Can we please avoid using the word "control group" to describe these? It's 
extremely confusing for readers since it's exactly the same word as used for 
actual cgroups, especially since those are also a form of "resource control"...

Doesn't official documentation refer to them as "resource groups" to avoid 
this?
