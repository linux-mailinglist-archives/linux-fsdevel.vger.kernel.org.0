Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB324F7C3A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 11:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbiDGJ7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 05:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbiDGJ7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:59:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F47645C;
        Thu,  7 Apr 2022 02:57:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 17so6782770lji.1;
        Thu, 07 Apr 2022 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5UAfKxsrsRPvh+meKdkGbOkhRM3tNuXSuWFqHVxSXs=;
        b=m3YGQUepXhCvyRxD5o4/1/8dJwfSqa900VjhrgSGI09drgozJj46mc06D3MszpYN5M
         jlYFphQm7t4z0kWI/eNluuJ2Tv3d3SQisTc4OuY+EgvXiBF85r9th6ucqr5vLN7ynuKR
         aJ3uQspwY+wbi32vnAD7ej0+I7za05t0o6cIqFxw3byiq132kHi8X8xP3sX9iTmalokJ
         U0HN/mcG0wC6fy83qgQrjwfIim2iiRqkvgaaHZysXmN81JYWeKUD22dMnxLJ8d2KnnvU
         qg3Vusbb04fxIuGMBJmNrYjNMu86OQrzogTKd8WC/BHKeiniDcxI8SX7XzyDBON/+O4Q
         dHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5UAfKxsrsRPvh+meKdkGbOkhRM3tNuXSuWFqHVxSXs=;
        b=l/DMucsbhhLLabozuaNDHjrWgMdXy6CoB0/ZgRV8sESozgx4I4uMoVl5R8bLcEg59b
         +l0gjdG7wXVMvKvaHww0FRos5TC3kiSurYcIQV43FN5YflCsFlCKJQ9/t2y+zERX7jpf
         IY6GnwPP0R1S2bmPBcTQPCofNBzhPJI1d9Yr6zrzNRUeadZLzBdIgQDOoOvN24hmOABt
         HnNeHaV4Ir+uX1s60NfaiSFw584Zff1tTtv+z4/5lF3Ve/7CojblsH/MSPtgbpsxnhuG
         OV4fT3RzG2UB3oy1fjD5NrNfAuQI7a8uOF0bHD8w0GsZ0COof347NOgh5QhI1nnlQkXz
         CbaA==
X-Gm-Message-State: AOAM532EvQOJUrkxPP6adudsAgWhhllHKWKCUufj9j3+mxFGIgwdI3RX
        WTEGL3j9SNxh2RLN6uraeFQEuHwxyz9XNNnf3XyY0bsVXTo=
X-Google-Smtp-Source: ABdhPJyz9uV69vNu9Xkhp5TJC8HBxV2DDog4ohbuQHHfoDApG8f+V+4nHmjPwPczr9oZDDOIOrwnGBVRazYGtFts0ug=
X-Received: by 2002:a2e:9c03:0:b0:24a:fe64:2c12 with SMTP id
 s3-20020a2e9c03000000b0024afe642c12mr8033891lji.101.1649325462634; Thu, 07
 Apr 2022 02:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220322115148.3870-1-dharamhans87@gmail.com> <CACUYsyG=RmUkX0b_0_1PmC4B_Oute5DnAf-xxFOr6h95ArPZDg@mail.gmail.com>
In-Reply-To: <CACUYsyG=RmUkX0b_0_1PmC4B_Oute5DnAf-xxFOr6h95ArPZDg@mail.gmail.com>
From:   Dharmendra Hans <dharamhans87@gmail.com>
Date:   Thu, 7 Apr 2022 15:27:31 +0530
Message-ID: <CACUYsyGkg2+wSfaZUt+B1woQRu96s1RY+b59RPoVE7QkTEsUtQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] FUSE: Implement atomic lookup + open
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 4:37 PM Dharmendra Hans <dharamhans87@gmail.com> wrote:
>
> On Tue, Mar 22, 2022 at 5:22 PM Dharmendra Singh <dharamhans87@gmail.com> wrote:
> >
> > In FUSE, as of now, uncached lookups are expensive over the wire.
> > E.g additional latencies and stressing (meta data) servers from
> > thousands of clients. These lookup calls possibly can be avoided
> > in some cases. Incoming two patches addresses this issue.
> >
> > First patch handles the case where we open first time a file/dir or create
> > a file (O_CREAT) but do a lookup first on it. After lookup is performed
> > we make another call into libfuse to open the file. Now these two separate
> > calls into libfuse can be combined and performed as a single call into
> > libfuse.
> >
> > Second patch handles the case when we are opening an already existing file
> > (positive dentry). Before this open call, we re-validate the inode and
> > this re-validation does a lookup on the file and verify the inode.
> > This separate lookup also can be avoided (for non-dir) and combined
> > with open call into libfuse.
> >
> > Here is the link to the libfuse pull request which implements atomic open
> > https://github.com/libfuse/libfuse/pull/644
> >
> > I am going to post performance results shortly.
> >
> >
> > Dharmendra Singh (2):
> >   FUSE: Implement atomic lookup + open
> >   FUSE: Avoid lookup in d_revalidate()
>
> A gentle reminder to look into the above patch set.
Sending a gentle reminder again to look into the requested patches.
