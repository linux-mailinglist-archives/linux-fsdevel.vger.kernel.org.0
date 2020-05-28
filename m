Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E991E63A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 16:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390991AbgE1OUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 10:20:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46468 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390924AbgE1OUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 10:20:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id i17so3107734pli.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 07:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ioMBz2HkB++LPoInJNCol20ptpLepBHp/qIksTleTi8=;
        b=LL2hfGBLgD8NUppR66YMldKso85eFYW9T2DrveaF+FR3jkqWSfOARMblNLZ33KluVJ
         15395dW83v95BEBsv1Lb4zGH/6e0zgaPIYCbF7Gxv4Vt3OEo0WiRTXgy01Usszd3vpOU
         3jmhspJFJUt0NflHMPYHJTkKKy6B3lDmhFlWcz+I32piY87Qz10CWlLNJXz5Xiv9zYBm
         y+H9bkSDJSGt4qcG6f4+bZZsFBYsSTtRo9H+upEPpQ7HtiP0VuZvSixiGJOXKIQhOiB5
         5GA+1SFeo3vQzm/Z4/JHUnX0zEoERSH/qpb1mFxl1rkwknT/eO3a0hYCwLZNeCtG5Ad/
         jaGg==
X-Gm-Message-State: AOAM531Vr2AZpP1pmDJPU0Rft48HABwymqZ6zjPMql7sWtE/8Fr6w7Q8
        C+/+QWKEOwjV6Tj6zH4eMyY=
X-Google-Smtp-Source: ABdhPJyrHzw+oAkehx5luhCUgrCWpCV3i+DoNzd43jiNtdIUXziN/7kcwGF0/IiAAa5CfZPrd0TMyw==
X-Received: by 2002:a17:90a:338b:: with SMTP id n11mr4218072pjb.225.1590675647079;
        Thu, 28 May 2020 07:20:47 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id l3sm4818428pgm.59.2020.05.28.07.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:20:46 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 30DE440605; Thu, 28 May 2020 14:20:45 +0000 (UTC)
Date:   Thu, 28 May 2020 14:20:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Boris Sukholitko <boris.sukholitko@broadcom.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com
Subject: Re: [PATCH] __register_sysctl_table: do not drop subdir
Message-ID: <20200528142045.GP11244@42.do-not-panic.com>
References: <20200527104848.GA7914@nixbox>
 <20200527125805.GI11244@42.do-not-panic.com>
 <20200528080812.GA21974@noodle>
 <874ks02m25.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ks02m25.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 09:04:02AM -0500, Eric W. Biederman wrote:
> I see some recent (within the last year) fixes to proc_sysctl.c in this
> area.  Do you have those?  It looks like bridge up and down is stressing
> this code.  Either those most recent fixes are wrong, your kernel is
> missing them or this needs some more investigation.

Thanks for the review Eric.

Boris, the elaborate deatils you provided would also be what would be
needed for a commit log, specially since this is fixing a crash. If
you confirm this is still present upstream by reproducing with a test
case it would be wonderful.

If you are familiar with what might be the issue, you can even construct
your own kernel-code proof of concept test using lib/test_sysctl.c. We use the
script tools/testing/selftests/sysctl/sysctl.sh to hammer on that.

  Luis
