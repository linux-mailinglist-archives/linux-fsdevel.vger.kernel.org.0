Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1035736352
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 07:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjFTF6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 01:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjFTF6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:58:15 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314379F;
        Mon, 19 Jun 2023 22:58:14 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-55ab0f777afso2915927eaf.1;
        Mon, 19 Jun 2023 22:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687240693; x=1689832693;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=34Cco61/4CW2mJNGmud8pxFMzhtMzt/hfDZvFbf9jm8=;
        b=f8odMrO6q9vdgu38ISGQ/W11cWQ7v2uCy+kAnIsiyHfjaix8YelJQCeYEQVx21bP3M
         O9DIgBsmoEM7tGj16Wwby8SqArHTGXaMUs3WRvtdvdy/Qw5D42sEJ8AZ6Woius7ABECj
         PWFOS41K+W8B7xh2z+lllDUxb0gXZEHEndCu5zZQykHJH0FhfM5KscX2DGqsg13nxaIO
         yOmXR2gTTmiXADFxuxnAyK5g7QXB/lho25IDQ7inHcpY3vWFTvUGp2o+8A0wUh+o9GEt
         lQfGvmEnxdmDdroaT+go46HiVadTobW+HmrVy1LgGoXeJQ4GArYnruCZRfsEaDjZQtk3
         V+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687240693; x=1689832693;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=34Cco61/4CW2mJNGmud8pxFMzhtMzt/hfDZvFbf9jm8=;
        b=AaTUlSax1ZWVG/vLpw+k90hWfy6KEma0NIo2aqCkUTIhBYkH/i6umj8MjLMwFDSh7Y
         H1ct4ViVgWVFxUjxLA0X1U3WeTLQfEWg+A5PlQnd1Ir5g7nMTLVuEXkzJGqWAoGlBdok
         /P7/2vQycRY3/DxylmJ1DRGnl/SIuJhkX/aRCxkbaSVoU7yYxP24dxd0C1gzDh46I0aq
         ZBYpWIc/upjfic8IkhW1XCOkPWVD6v6G3n6DT0xZk8Snii2Z5V2pQgqr4WUCgKCA0xc+
         F9K7W5WIwE3t9JRutHPJtDtnj/hpi+193fCHAv9gCde+Xia5dfz8P8nDVGnW/cuspIsn
         PY2Q==
X-Gm-Message-State: AC+VfDxFK8VBsIZB4ilrunilI6Qynce2IYtwnt8V6354Mc5BFGdG8Xcr
        hgUbU1azB7G9oCyXAzHbjfak5SFHTog=
X-Google-Smtp-Source: ACHHUZ5VxjyqQWNmctrmbIbQrcyROPysipfn8YWYYbcnf4EGYbT/uE54/VOQg0l143eXMhPY/cRH5g==
X-Received: by 2002:a05:6808:14ce:b0:39a:abe8:afc3 with SMTP id f14-20020a05680814ce00b0039aabe8afc3mr15297730oiw.38.1687240693479;
        Mon, 19 Jun 2023 22:58:13 -0700 (PDT)
Received: from dw-tp ([129.41.58.17])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090aea0500b0025bf1ea918asm688250pjy.55.2023.06.19.22.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 22:58:12 -0700 (PDT)
Date:   Tue, 20 Jun 2023 11:28:06 +0530
Message-Id: <87fs6mn09d.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv10 8/8] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <20230620050102.GF11467@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> Ritesh: Dump the enum; "because btrfs does it" is not sufficient
> justification.  The rest is good enough, I'll put it in iomap-for-next
> along with willy's thing as soon as 6.5-rc1 closes, and if you all have
> further complaints, send your own patches.

Sure, Darrick. I agree that enum created more confusion than help (sorry
aobut that). I will dump it in the next revision & address Matthew's
review comment on the variable naming.

I agree to lock the current set of changes as functionality wise those
are looking good from everyone. Any further optimizations/improvements
can be handled seperately so that we don't complicate this one.  

Thanks once again Darrick and all the other reviewers!!

-ritesh

I am pulled into something else for next couple of days. Post that I
will work on it to get next revision out.  
