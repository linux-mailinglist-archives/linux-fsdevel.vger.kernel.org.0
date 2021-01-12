Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB72F2551
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 02:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbhALBNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 20:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731384AbhALBNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:13:33 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174BCC061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 17:12:53 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b8so498350plx.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 17:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HeroSUVjjmC+Oi1TznGuZqpsMLfJSMPO+vq+1KmDVOY=;
        b=eh3zl5GxXEYsEZi6yuaetcvNkJbsOPeSlI99r6w6+7dicC5rvtqC81rRI/VOQFtIVC
         8RDAFZbcqMf72vNe80Ux6BOjdoCVwQEfACLjtQBWn8W02nAUK4QiR5WpPxLZy4FQXNSG
         bTwU6ywKdhHi3J/GglPA+iyXCvAEk2QagSGKXk4Woz0M/A0+WybRt9hp9NVK1cX1RQIU
         qeQpheXPopxYcL9OZ5gqX22NdJPSw1gAESQkovLj1Q7UJR+4yZix50BIcwqZftgllBVC
         X5NCmW6DUy6srOhc6rTOK7zYFJHIqvKDtQOuTnZCwryddZ/17xuF0JTmskybdyoo8lSF
         OxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HeroSUVjjmC+Oi1TznGuZqpsMLfJSMPO+vq+1KmDVOY=;
        b=Rm9MyUd/q+Gk4RufNZSIKzxAEiU7QZrp5hV4Z5yao34rNAhrAsVG9hhvsfth73EO5z
         xZHCCLhzKgWmmO4dWZ+45aFCKL0nzqUXKK8elJ+IN9bIFCjvnLsAxz3IrsMepx1r4Q1x
         /KxocXTZtJFwB7HLQkdNUMZFt54fDfHntRYwSOxHd6A9UZRHl9eJmR9YGJ2GDkZpCZ7x
         7P4JcmyOcll/NLSu2byTDKeENqOweKB5j8MgmBnPtf0SOJlOk18WslJvz56gFtOS9shN
         bce+f0rbWhLFYDAM9K17piNy09Q1+jgVbhN9pE7v0M5nuCHevFv9m+SunPEJ7zEdBLOe
         Tl/A==
X-Gm-Message-State: AOAM533Q3LHNmj8NBZy2jJMXYU7+sJmbBr9+T1FdUs0atvzkuaKtNY3D
        pMWeYX0ZwVcDTjGDBG8l304zDA==
X-Google-Smtp-Source: ABdhPJxRF0FNun799Re6m0Dlhn3msDTubi+Ca34uUaYeDXhd5YM/gQp4x/Eq+sUbStMDe7j70fv8hA==
X-Received: by 2002:a17:902:7c04:b029:dc:99f2:eea4 with SMTP id x4-20020a1709027c04b02900dc99f2eea4mr2508598pll.43.1610413972364;
        Mon, 11 Jan 2021 17:12:52 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:675])
        by smtp.gmail.com with ESMTPSA id o7sm921465pfp.144.2021.01.11.17.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 17:12:50 -0800 (PST)
Date:   Mon, 11 Jan 2021 17:12:47 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com, linux-man <linux-man@vger.kernel.org>
Subject: Re: Ping: [PATCH man-pages v6] Document encoded I/O
Message-ID: <X/z3j7dtRrAMc8wC@relinquished.localdomain>
References: <cover.1605723568.git.osandov@fb.com>
 <ec1588a618bd313e5a7c05a7f4954cc2b76ddac3.1605724767.git.osandov@osandov.com>
 <4d1430aa-a374-7565-4009-7ec5139bf311@gmail.com>
 <fb4a4270-eb7a-06d5-e703-9ee470b61f8b@gmail.com>
 <05e1f13c-5776-961b-edc4-0d09d02b7829@gmail.com>
 <dcb0679d-3ac5-dd95-5473-3c66ae4132b6@gmail.com>
 <559edb86-4223-71e9-9ebf-c917ae71a13d@gmail.com>
 <2aca4914-d247-28d1-22e0-102ea5ff826e@gmail.com>
 <7e2e061d-fd4b-1243-6b91-cc3168146bba@gmail.com>
 <48cc36d0-5e18-2429-9503-729ce01ac1c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48cc36d0-5e18-2429-9503-729ce01ac1c8@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 18, 2020 at 11:32:17AM +0100, Alejandro Colomar (man-pages) wrote:
> Hi Omar,
> 
> Linux 5.10 has been recently released.
> Do you have any updates for this patch?
> 
> Thanks,
> 
> Alex

Hi, Alex,

Now that the holidays are over I'm revisiting this series and plan to
send a new version this week or next.

Thanks,
Omar
