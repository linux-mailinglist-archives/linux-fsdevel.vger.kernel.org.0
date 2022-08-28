Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9A65A3ED5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiH1RaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH1RaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:30:21 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A4E7641;
        Sun, 28 Aug 2022 10:30:19 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id c3so6322879vsc.6;
        Sun, 28 Aug 2022 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rC/kcvyTRMZn63lmOJ8Yw6MSQcVtIHue9Gs8f5KhzxI=;
        b=QiXycj2Fdgnnrcm4Yd55Jnz3ZDDRPTXPBhcd/BxbbSyT3Zj+SXca6TuWA3S9oQYIpK
         +DiNwzR4IFUcCb7F93FMJvDvLeKJE1idtoAe7Z7+HxoCXOYDxacZA86EHf0KbFyIF/Uy
         BPoEEGpBZ0ykd4SmaC1S+kWWUyPoeA8Za81JF+uKMOeoHbf7wjWIyYIrDxuESx6uaiD0
         nuAqZ9Dd5iytqXuVa+Yl6Obc9b6h6cEANAN4FCVBoi81wp93z2O3BTXvqwFgQrENj2GK
         ODpG5xkdP+LrQLZXOK7+xcWTXmwoQc4EIhtXhI4QTJsmbChg+T/6xKH9jzGdBoprGUPi
         qa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rC/kcvyTRMZn63lmOJ8Yw6MSQcVtIHue9Gs8f5KhzxI=;
        b=G41h19QUFyVaeevEK2nMq07L+sjWbqN9qcGoL5fAO6gO5QjSkEX7mMDH5cinaNwllS
         8/vAHfKrJDL6BvmRjGAhSfAElIJnvuRZ3r/+UBGIEA4Ddd+0B2LWFoeCqes2SoS8H93V
         JbPNZGvoZZIpnPsiQIfabe0wIkUIoZ0aDm7CESNAa4XjDFZ8kXMfJ9eE66ktHgugmXba
         /4Axqp43nPwZZw1Ri3KQZNtxJA9JAk2fXm24hBta+wOnGwlv0p4bSNPWmepeULW47EF8
         Ufc4F+GxsvGHYRdTfbZyX8swmZt7zb+CAM6KEz81iY4hFG8kigD89qwRGlh+PpccYDi0
         y3bg==
X-Gm-Message-State: ACgBeo1Rm9TfTRcApnlj4MkOX1HlgUsYG4smilvYqBg/yInzHGfuBsPA
        FjaAtL/ASUMApGzpC9HBJOQ3mqYhkVu4/F0Z6r4=
X-Google-Smtp-Source: AA6agR7cmg57rCLNkmwrUUJk/RyfQYniAMvh9OKyjO2Yd3+bL6n6ixaimSWK3PPDLAo0oGuiuEXzn5LzJQt8j7+ovg4=
X-Received: by 2002:a67:a649:0:b0:390:88c5:6a91 with SMTP id
 r9-20020a67a649000000b0039088c56a91mr2450540vsh.3.1661707819049; Sun, 28 Aug
 2022 10:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220826214703.134870-1-jlayton@kernel.org> <20220826214703.134870-5-jlayton@kernel.org>
 <CAOQ4uxjzE_B_EQktLr8z8gXOhFDNm-_YpUTycfZCdaZNp-i0hQ@mail.gmail.com>
 <CAOQ4uxge86g=+HPnds-wRXkFHg67G=m9rGK7V_T8yS+2=w9tmg@mail.gmail.com>
 <35d31d0a5c6c9a20c58f55ef62355ff39a3f18c6.camel@kernel.org> <Ywo8cWRcJUpLFMxJ@magnolia>
In-Reply-To: <Ywo8cWRcJUpLFMxJ@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 28 Aug 2022 20:30:07 +0300
Message-ID: <CAOQ4uxj=+7n5vcxNt8CTkPCzv7u8AQYHdzF2mKS29Bj3S3NxnA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] xfs: don't bump the i_version on an atime update
 in xfs_vn_update_time
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>, Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Dave Chinner <david@fromorbit.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Neil Brown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>, xiubli@redhat.com,
        Chuck Lever <chuck.lever@oracle.com>,
        Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        ceph-devel <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > >
> > > > Forensics and other applications that care about atime updates can and
> > > > should check atime and don't need i_version to know that it was changed.
> > > > The reliability of atime as an audit tool has dropped considerably since
> > > > the default in relatime.
>
> I've been waiting for Amir to appear in this discussion -- ISTR that a
> few years ago you were wanting the ability to scan a filesystem to look
> for files that have changed since a given point.  If XFS exported its
> di_changecount file attribute (as it currently behaves) via BULKSTAT,
> you'd have the ability to do that, so long as your application could
> persist bulkstat data and compare.
>

It's true that exporting i_version via BULKSTAT could be useful
to some backup/sync applications.

For my case, I was interested in something a bit different -
finding all the changes in a very large fs tree - or IOW finding if
anything has changed inside a large tree since a point in time.
So not sure if i_version would help for that use case.

Thanks,
Amir.
