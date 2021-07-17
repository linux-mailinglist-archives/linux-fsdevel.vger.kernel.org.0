Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579413CC0E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jul 2021 05:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhGQEAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jul 2021 00:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhGQEAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jul 2021 00:00:30 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0248CC06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 20:57:34 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id s2-20020a0568301e02b02904ce2c1a843eso1505943otr.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 20:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=0zxPduS5IUlaKoDmCEn68k89T9YkKaQNgugxVbUHaKI=;
        b=mSnM0y1yE9GJNTAl/VrDjjO2dWCp5qZh3Y3TWQtvQUQnvZ0vy2Urn87kQs5cOV9ORn
         DYHDMUcPRI5k5luZi6jzQX/zb9ULgyrCWylieSZcWpbbDdSvbnjYyv9SzzsH2IfbA7lm
         0r4/RbNOcKpoaipakSaoiTp9KNLTlDTC1HKVtR9uHW+ipsPC2SG9WU0oo31/jwAewzb7
         YTk3YlvgTQvpT2z9Hgq6LPc06gPvGLzyvw9i0HyZm0j3jeoaPOaKvVFUQa0pzuxz2RAG
         yhXgipmZ6eG5PwSnDXQ6AQPcc9N0FxiH2DkNtfZ3Xm8mDmgfz/OlKgVYtbh1OBVm08s8
         s10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=0zxPduS5IUlaKoDmCEn68k89T9YkKaQNgugxVbUHaKI=;
        b=E/MQ4G7UwhbH91YQOLaQe50CEKtf2iOtS0yOtHkzR2HuOTfOh+gOsYttZov0SJkb4o
         iM/WfS7eha2P47Ohja9nez78G/K7hkyK/M5JVjadj9HnE69eUheWUgS7Ne+LoMV/vVIy
         1dVTz49DYrzU8a+RTI9caWeoZvQKnjCEHq4ftoc+CacC4mxEKDkJ06GtujY4iAzaaJFh
         5MrIXZT4SGcfQq2LQVz8KbQ6KaYV2YqcSZK7qPRvEKlyn9YL23pjb4dhV3BlybGVf3Do
         qUVzosrJT0qx4/TJsOPMcXkxNhyr4az6+OgI56DvLw8LM2M8m/YkQbseyyxAxYKtRugH
         638A==
X-Gm-Message-State: AOAM532Kmv7U4bym05/Pv/0tLT3KyKqz1GN7cicPq6jaCcuJ5qloxdaW
        LsYvcaIYFaz3J6w8RnHQOROnPUl7z0PNVjhElcE=
X-Google-Smtp-Source: ABdhPJzNEUy25n9NfwE2aman7lou9idxrsIlmxAE4G1W1+YVwSNdQtT6lOK6Jw0WKb5x2WUbXx9xTKgJEhTL3ktYM7Y=
X-Received: by 2002:a05:6830:1414:: with SMTP id v20mr10550223otp.69.1626494253420;
 Fri, 16 Jul 2021 20:57:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: tofilbamar@gmail.com
Sender: aliftomarn6@gmail.com
Received: by 2002:a05:6830:1291:0:0:0:0 with HTTP; Fri, 16 Jul 2021 20:57:33
 -0700 (PDT)
From:   Tofil Bama <tofilbamarn@gmail.com>
Date:   Fri, 16 Jul 2021 20:57:33 -0700
X-Google-Sender-Auth: sg5rQqSrr8PHA7uc-GWI1yE_Aao
Message-ID: <CACwWz1o75sp0z5+N7d1TdmPhSuiDM-rbpqxga0QwdyGmabC6EQ@mail.gmail.com>
Subject: GOOD NEWS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear,

My name is Mr Tofil Bama, I am the Bill and Exchange assistant
Manager in Bank of Africa Ouagadougou Burkina Faso. In my department
I discovered an abandoned sum of eighteen million three hundred
thousand United State of American dollars (18.3MILLION USA DOLLARS)
in an account that belongs to one of our foreign customer
(late Mr Shitu Nuri) who died in Ethiopian Airlines Flight 409 that
crashed into the Mediterranean Sea on 25th January 2010.

Since I got information about his death I have been expecting
his next of kin to come over and claim his money because we
cannot release it unless somebody applies for it as the next
of kin or relation to the deceased as indicated in our banking
guidelines, unfortunately we learnt that all his supposed next of
kin or relation died alongside with him in the plane crash leaving
nobody behind for the claim.

It is therefore upon this discovery that I decided to make this
business proposal to you and release the money to you as next of kin
to the deceased for safety and subsequent disbursement since nobody
is coming for the fund, it is 11 years now the money is lying pending
in the account of our deceased and I don't want the money to go into
the bank treasury as unclaimed bill.

You will be entitled with 40% of the total sum while 60% will be for
me after which I will visit your Country to invest my own share when
the fund is successfully transferred into your account, Please I would
like you to keep this transaction confidential and as a top secret
between me and you until we successfully achieve this golden
opportunity.

Yours sincerely,
Mr Tofil Bama.
