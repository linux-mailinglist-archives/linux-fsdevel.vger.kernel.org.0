Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4D217BC68
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 13:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgCFMMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 07:12:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35910 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgCFMMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 07:12:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id j14so2196768otq.3;
        Fri, 06 Mar 2020 04:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vfLp1FhQDcublXc84R+92QUDEJl2WMGGtAZn34jMq4Q=;
        b=Umff9i94gjlNa3oYklRMofweiY+dV/E8kXGbg6ij+kZNKnriIOm9Mg8nerGTVCuByK
         L98n45rb74dm4yA1RDfLWUZUiOVjfmjnkF/nq6jG9xvrO7nCeRUm037h+Uk5c37NzJIy
         Gi2suUTsbyQOyxOLLMHhrWJYASRExg1hB7FZBTytFPP0LpaqcQfUs3tQBDVn3V3w/WMq
         bvqw4Hv4ESe5gQlSysum8kaNc/8afqwabLinP4i2sguUocwgxAyxzlFfqBHJ6BcEkinT
         QqCwAlirRDey42AL2RmqiqpmLTrsLNKDuch/g7qQG6eVki2uEuBreZgVjaJyUd+rXxeh
         rjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vfLp1FhQDcublXc84R+92QUDEJl2WMGGtAZn34jMq4Q=;
        b=RdlnUmzeo83v8rnSJs4yhIc97LdR42qs42fEprn/fJ0TAD317sM6i2o33R4cGdcTN9
         RBK8fojayJW06CPQLIBEb4ZtWY7oBssIXW1OnAoUR3uKfBm55u6JzdrVORQwW5uiqAoX
         VrC9CUgW5xUMNceoCgJjfj93SYIO+eBGoXW4i0apByuag7FTZ+FYtqV2TO78MXtWg38B
         jv+N8dh6SSmibuGIHf0vxZraa0FU3OpuAhhIgkSgkbXXXj0r8TM/fj4KpJYocctquV+U
         wLHNS1Kv/btgvrch3/na7/5XUfIIVuwZf0mxhYccYN/I/XRvFacXLj0ENcJ4OdZLK1JM
         q9Pw==
X-Gm-Message-State: ANhLgQ3oSa/evLNB3rVSMh8kHcgBJ5hYFbDVBBxJ9KfIBrc6TeqhxvIk
        neD+DhNKTqvFL05qP1QWW++3ecGkamuR37ypAy0=
X-Google-Smtp-Source: ADFU+vtEMErh4XfQao2++X0CvMCxBO+mnPh/GXclb6CrqLF+1TpseUcAmJcDjafdyMMnSFhXEhRrBR3PdRVv3UTKgVU=
X-Received: by 2002:a05:6830:1606:: with SMTP id g6mr2308928otr.120.1583496723068;
 Fri, 06 Mar 2020 04:12:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:95:0:0:0:0:0 with HTTP; Fri, 6 Mar 2020 04:12:02 -0800 (PST)
In-Reply-To: <20200305161228.GU23230@ZenIV.linux.org.uk>
References: <CGME20200302062613epcas1p2969203b10bc3b7c41e0d4ffe9a08a3e9@epcas1p2.samsung.com>
 <20200302062145.1719-1-namjae.jeon@samsung.com> <20200305155324.GA5660@lst.de>
 <20200305161228.GU23230@ZenIV.linux.org.uk>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Fri, 6 Mar 2020 21:12:02 +0900
Message-ID: <CAKYAXd85h_SoTS4y9_cc1Yzo4001dFC1a_xGtL6s+whNzfsQPg@mail.gmail.com>
Subject: Re: [PATCH v14 00/14] add the latest exfat driver
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-03-06 1:12 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> On Thu, Mar 05, 2020 at 04:53:24PM +0100, Christoph Hellwig wrote:
>> Al,
>>
>> are you going to pick this up, or should Namjae go through the pains
>> of setting up his own git tree to feed to Linus?
>
> I'm putting together #for-next right now, that'll go there.
Great, thank you!

>
> Al, cursing devpts, audit, ima, fsnotify and a lot of other unsavory things
> right now...
>
