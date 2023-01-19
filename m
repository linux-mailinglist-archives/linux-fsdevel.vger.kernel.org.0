Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EE8673212
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 08:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjASHFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 02:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASHFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:05:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A192830D3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 23:05:33 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b10so1507615pjo.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 23:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=txG1XI7DK5qkyfzJsKyT2pWmLht7EdUGbR24ELqCUHo=;
        b=lxqHsMH2HIghXj4gFBlPCciC9Iw+prjvBTBsMieEaNPRpj0rthzQo0CNTH3sx6kocj
         AyEj86BLZB5WET6qEiF5+HPDKjPetcbMIwu44wa4YD1FHl+0X/ew3/IC5zSuHxHpK0l+
         kPpPB7XJxISSXJZwCfkhzDDDEY8TN0Y/fefk466VY1C/WZQf3yRP638cfmdteBeYMyhn
         F8BP5t2vMlXKJvaBgZL2vRZDAj4uyXzFwjV28yciqxDchSzciyawcRkXRsTmY9oWOe9i
         SgWrD7lRAveYJ4ENRgIRt9S4mhdkd72ce0UoY5A0VqInxZdUqfFO2CSXMtHHFE/HerdG
         9NgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txG1XI7DK5qkyfzJsKyT2pWmLht7EdUGbR24ELqCUHo=;
        b=UDqu1Gqs0p2Fx5ynMoBegvwBgmy0xNfqui5RXg34gvMiygVd8PJahb9u7sav0JXFac
         PK9e16Kmi/X2D2NswacCbojEgBlMI60b8pI2TyM1mfmXxMoxxytJF1TUxxPsdpDZ5ZkU
         rRC1os2e71f6tEu3WnikfUJxeii7pYX2+7K64P0R2oIqHEQ3cVpi4PcS8Tb8MnyaqFBS
         tCYaxRCylLvMDLneRmi01vDDP6xK46z5YFD9bEc8lSEXSypoYxvD096nXggKDVmEhtt4
         s8nclTXUMwlC38to0cBoiDBSJAbrxpOVOQY+I1565qyTo6Fy/MW4m1Tz9kdBlr2rFy12
         NMrw==
X-Gm-Message-State: AFqh2kqTrI8mIbw4gCUO+0PtvtDa6J5p4DuVYbrK1KxfgxCpvXmrM0lm
        dkyc4gbroogZwbpuNeJvoM0=
X-Google-Smtp-Source: AMrXdXt58siXWKsK0SGOpumac1dFmRQ4jmOmPF5wpgCiZeEMvDmOFznZXC79asasvoPNM1i9j8atJQ==
X-Received: by 2002:a17:902:7fc9:b0:194:84f2:c1ec with SMTP id t9-20020a1709027fc900b0019484f2c1ecmr10354245plb.21.1674111933032;
        Wed, 18 Jan 2023 23:05:33 -0800 (PST)
Received: from ubuntu ([210.99.119.24])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902690600b00192aecb231asm24263298plk.121.2023.01.18.23.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 23:05:32 -0800 (PST)
Date:   Wed, 18 Jan 2023 23:05:28 -0800
From:   "YoungJun.Park" <her0gyugyu@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alex Murray <alex.murray@canonical.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Re: question about fuse livelock situation
Message-ID: <20230119070528.GA1337007@ubuntu>
References: <CAJ16EqgEd-BP3XStsR_Cm88Qw2=CTppZo7Ewqv9se+YyzrbzCQ@mail.gmail.com>
 <CAJfpegugtmfjkW9ysDobNJGZM=G0Y_wrK1uHwANjSnKX1K++SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegugtmfjkW9ysDobNJGZM=G0Y_wrK1uHwANjSnKX1K++SA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:58:50AM +0200, Miklos Szeredi wrote:
> On Tue, 30 Aug 2022 at 03:58, 박영준 <her0gyugyu@gmail.com> wrote:
> >
> > I found fuse livelock situation and report it for possibility of problem.
> >
> > [Environment]
> > 22.04 5.15.0-43-generic ubuntu kernel.
> > ntfs-3g version ntfs-3g 2021.8.22 integrated FUSE 28 - Third
> > Generation NTFS Driver
> >
> > [Problem]
> > I bumped on livelock and analyze it. and concluded that it is needed
> > to be fixed.
> > it happends when 3 operation concurrently progressing.
> >
> > 1) usb detach by user. and kernel detect it.
> > 2) mount.ntfs umount request & device release operation
> > 3) pool-udisksd umount operation.
> >
> > [Conclusion]
> > 1. mounted target device file must be released after /dev/fuse
> > release. it makes deadlocky scenario.
> 
> Shouldn't this be reported to ntfs-3g developers then?
> 
> Thanks,
> Miklos

I reported it ntfs-3g and ubuntu bug report channel. 
ntfs-3g does not respond and ubuntu bug report channel response it like below.
(If you want a detail scenario flow picture, calltack etc check the link 
https://github.com/tuxera/ntfs-3g/issues/56)

> Hi

> Thanks for reporting this issue - in general it is better to report bugs
> via launchpad than email (e.g. by running the following command (without
> the quotation marks) in a terminal: "ubuntu-bug ntfs-3g" or by
> https://bugs.launchpad.net/ubuntu/+source/ntfs-3g/+filebug)

> I notice you also appear to have reported this to the upstream nfts-3g
> project at https://github.com/tuxera/ntfs-3g/issues/56 but have had no
> response.

> However, my initial thoughts when looking at this is that it appears you
> can trigger a livelock within the kernel from an unprivileged user in
> userspace - as such I wonder if this is a bug in the FUSE subsystem
> within the Linux kernel and hence whether it should be reported to the
> upstream kernel developers as well? As per
> https://www.kernel.org/doc/html/v4.15/admin-guide/reporting-bugs.html it
> would appear that this should be reported to the following email
> addresses (assuming this is a real kernel bug rather than a bug within
> the ntfs-3g userspace project):

> $ ./scripts/get_maintainer.pl fs/fuse/fuse_i.h
> Miklos Szeredi <miklos@szeredi.hu> (maintainer:FUSE: FILESYSTEM IN USERSPACE)
> linux-fsdevel@vger.kernel.org (open list:FUSE: FILESYSTEM IN USERSPACE)
> linux-kernel@vger.kernel.org (open list)

> Thanks,
> Alex

Could you explan why it shoulde be fixed in userspace?
then I try to fix this issue and to report it one more based on your comment.

Thanks,
YoungJun park. 

