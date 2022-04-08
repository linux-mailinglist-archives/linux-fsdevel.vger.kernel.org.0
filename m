Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CECF4F8CA7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 05:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiDHCEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 22:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiDHCEN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:04:13 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144AB1B29CF;
        Thu,  7 Apr 2022 19:02:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so12661258lfg.7;
        Thu, 07 Apr 2022 19:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KtR1xob/thiGszD7KEJLex0sFRI1srTBLEogfW0iec=;
        b=Vg2taqVGF4Xd7tLv0zJDWPPnSKr28FcypPGkp7IayrblHDpZydfv4ZgzJLE00i49TV
         7kXsBAafkcxIGS7Mq54E8sKp710IxQqQrqC1Aa+AvWCXuqMmE4t0iAO0dsclFrYLEXVb
         yrW4GWontyYiLF0PjN7NXAHIqiRHLr9gY8iAXFjsm7WjCFTfMzl5aSIvIZWybp5kCWNs
         Kcz1dZXdM0Sx+Hrtxdkmwg3olKAmA8i+vC9o5fXhmATZb+rKbbAbs84sFVTwM6tSLk/B
         acDf62XMBcKrpE6EJ9obKEWOHtRGlmaDR+QO5SN1vyrayZJpgevcflTeV06FbgaprRJM
         gNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KtR1xob/thiGszD7KEJLex0sFRI1srTBLEogfW0iec=;
        b=LQQCVR6tWFQIhIqGoJXOzAoF8HQjITyIa2o4Px+11oo0FdNj+lfZKV1ymVKXgw23TB
         118ugKMOFoTnO4WIGywUKGBxopI1MHCHo8uY29kAJz8MX4kwoBqco6UIOM5FgJSFgwx7
         D6WpdcphKofsTzuv9WkOK6Px+KEkgSpUjZlMnVGvPXCtBdcyhhz9b2Nu+hptWjiu2cwY
         FDsz6VBiwiuduKosODJFKG3edBmXptlE3fl68WlW0L18tkzkJCvQ7ahwmhO6VEPYi87k
         O9p/xX3jutwh3DngPq6zqN0BQ3JwiqgzMfIMcLOAYbMN3rOXIT1OC6Kmb2DxQ2XGayeO
         BXwA==
X-Gm-Message-State: AOAM531lnrOSJJLa9Y2E+5AlPCphsxK8rpFbpYAC9Ix0w1zcESTm8Xfy
        sIFQ6eFTCCKGcxaBOz1vrKu7SO7wToj0laR8+As=
X-Google-Smtp-Source: ABdhPJx4wgH4soMsHaepHsZdxc8tN13YUhVhevnldLA5FTyOT15xrA0CD3CWhY85U+zic/4auO+KTNtQWj+tMpTPZK0=
X-Received: by 2002:ac2:5444:0:b0:44a:846e:ad2b with SMTP id
 d4-20020ac25444000000b0044a846ead2bmr11533423lfn.545.1649383329104; Thu, 07
 Apr 2022 19:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5muFq-4J=uedVF9qdYmFzgDDPwuYD+zrLytjUJE+APcBow@mail.gmail.com>
 <20220406044447.GD1609613@dread.disaster.area>
In-Reply-To: <20220406044447.GD1609613@dread.disaster.area>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 7 Apr 2022 21:01:57 -0500
Message-ID: <CAH2r5mt8a1uD3CCvErUZdFR+kUi5a66hES+7XSmTtzEB0D1hCg@mail.gmail.com>
Subject: Re: cross mount reflink and xfstest generic/373
To:     Dave Chinner <david@fromorbit.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This works - thx.

http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/940

On Tue, Apr 5, 2022 at 11:44 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Apr 05, 2022 at 11:48:29AM -0500, Steve French wrote:
> > I like the patch which allows cross mount reflink (since in some cases
> > like SMB3 mounts, cross mount reflink can now work depending on the
> > volumes exported by the server) but was wondering if that means test
> > generic/373 is getting any changes.  In our test setup the btrfs
> > directories we export over SMB3.1.1 for SCRATCH and TEST were on the
> > partition on the server so reflink now works where test 373 expected
> > them to fail.  I can change our test setup to make sure SCRATCH and
> > TEST are different volumes or server but was wondering if any recent
> > changes to reflink related xfstests
> >
> > commit 9f5710bbfd3031dd7ce244fa26fba896d35f5342
> > Author: Josef Bacik <josef@toxicpanda.com>
> > Date:   Fri Feb 18 09:38:14 2022 -0500
> >
> >     fs: allow cross-vfsmount reflink/dedupe
>
> https://lore.kernel.org/fstests/cover.1648153387.git.josef@toxicpanda.com/
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com



-- 
Thanks,

Steve
