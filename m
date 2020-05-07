Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BF21C99CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 20:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEGSuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 14:50:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35879 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgEGSut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 14:50:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id f15so2430640plr.3;
        Thu, 07 May 2020 11:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NVtq4LDDtvm7cyqcZmZ6iVyVFqaMEGZyo2ntIU6mBx8=;
        b=MkU6SofPX1nSol8g32toQunda+QRsJDgV6ECkIfwTDWlj0tRgdBWeEYxJ+rVJ9Q53L
         UHFoQPNDDFnzrCxHsTKJVf1Sn2w0MpWMzfX9ea9l7s1jd8EdongQZU4jSFjR7A7DBYsG
         4u6usbp92htw/LZpUYq/2oom4r1v5Ee5wFv47+3kV93FunQz2S6saDM4CDv3DrB3F8TQ
         ka/C2DN/ISVM+5iN8MdRtT9dS5MiUZT6eWxQkJBUwdl4DQhOBBFOOsfnOl+v+luBnQf2
         5u/bLVWUOIQXP0Q0uqi8mLkGaHlTCMIfhEgs7xI7R5behg7f64bPlidCjP5vbtVrHj6N
         wYEg==
X-Gm-Message-State: AGi0PuZ01BqftuvErG1l1PAtoKe3ZxhCJNgk0DUbCf1f+ik/Ti7ZxZQl
        QPV7leXsEnSsGBgIePqLoLk=
X-Google-Smtp-Source: APiQypL/T4pokMBN3BjyJTmEhzQ6U4iO/Je8syJeCy3/7O5YcCFMehZ+kLkFe9ehfbZ5CmV/DTUJmw==
X-Received: by 2002:a17:90a:d808:: with SMTP id a8mr1614734pjv.6.1588877448984;
        Thu, 07 May 2020 11:50:48 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id ft14sm474731pjb.46.2020.05.07.11.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:50:47 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 92589403EA; Thu,  7 May 2020 18:50:46 +0000 (UTC)
Date:   Thu, 7 May 2020 18:50:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200507185046.GY11244@42.do-not-panic.com>
References: <20200507180631.308441-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507180631.308441-1-aquini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 07, 2020 at 02:06:31PM -0400, Rafael Aquini wrote:
> Another, perhaps less frequent, use for this option would be
> as a mean for assuring a security policy (in paranoid mode)
> case where no single taint is allowed for the running system.

If used for this purpose then we must add a new TAINT flag for
proc_taint() was used, otherwise we can cheat to show a taint
*did* happen, where in fact it never happened, some punk just
echo'd a value into the kernel's /proc/sys/kernel/tainted.

Forunately proc_taint() only allows to *increment* the taint, not
reduce.

  Luis
