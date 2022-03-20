Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB124E1BC2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Mar 2022 13:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245109AbiCTMzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Mar 2022 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiCTMzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Mar 2022 08:55:44 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB4237A19
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Mar 2022 05:54:22 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so16191815oot.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Mar 2022 05:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVoWiBQjkxiVKcGUV9hgrG7Vt3MQ0EFgI5iOridfNnw=;
        b=jPMdulUQigBzEk0lcU8v/7/6XWPm//DG0LYRRvG//vtAqtwdMm4VqATYrEqjh65cTn
         /dt6QpXhqif1glu6KrRa61Ss/v+rpT1GSTq7NfkHHrZ745sFZGt4fTI7Ctp327FL0RCS
         z2ih98snsjuv9yLGXSYQi+0EXQZUiey1cCTwIlpk+Qp/qAMymdKPPuEOsQv1UjJUoifp
         Ijt1rq7Cx2UYtNVCgw9EKzNw0Ju6ijfA9CYj9IH/aZPPNyytz5HzpYspClH3eIy7B5bF
         Gw51MOIEVVCtNAUP9fyrF5lHQvV5ClIbIfPKmwFzyVICKjvl+DNAjNtwMinLc17ghhyd
         6miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVoWiBQjkxiVKcGUV9hgrG7Vt3MQ0EFgI5iOridfNnw=;
        b=xwbBJ0SHDMBVpIRQqXItQc4GAdsjSJBRdfHKT+GORSYCvFEtPLDfUfpJdbgXQBMNXO
         qpi45OsOGEXvp0cXBL4tp6etjARey25QasN4HH+lThee0nJmv5vD+7Elpvn64hrjBqEZ
         XQUP2Y3Cuk+w6+KrRw8F9S4cu1V/hYfKVmIR1+yud2pajYnQjlEnG6GvWkjZC1UhVDLC
         bPF7ko8sGgQwfwXYonKtmyoKN3tm1yY9eaCqfFZpDRS2xIMGLcCpREgmhfWfWX6eGAKf
         pjSTbvUklufLqlrqH1QoLbgZSCozKZNFxOlEcaJFKVyBpX3niZJH9QCqz9ly6q5r+7AL
         DzIQ==
X-Gm-Message-State: AOAM5319eLHqdtrE0yVeGoCi7I7qErCclmQMKtIOkwCIdNcwOIJ2nKsI
        6Bmgu/kq8eSCL5M8mw9RSgBLdL+ROijzt6lH56HzmsaQ
X-Google-Smtp-Source: ABdhPJwhKR1vCoZWLq5txZaaRXT/6yGalKWwPc910tZp6HQnKCjIKX6PGSpGbhpwMVl/ulzBUHwSSkH77knScIaV3xo=
X-Received: by 2002:a05:6870:7393:b0:dd:9a31:96d1 with SMTP id
 z19-20020a056870739300b000dd9a3196d1mr9032315oam.98.1647780861385; Sun, 20
 Mar 2022 05:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220307155741.1352405-1-amir73il@gmail.com> <20220317141204.hbpflysc7p5e5vdo@quack3.lan>
 <CAOQ4uxh2KuLk21530upP0VYWDrks1m++0jfk6RGqGVayNnEHcg@mail.gmail.com>
In-Reply-To: <CAOQ4uxh2KuLk21530upP0VYWDrks1m++0jfk6RGqGVayNnEHcg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 20 Mar 2022 14:54:10 +0200
Message-ID: <CAOQ4uxhx=-RT_J-hiogPE9=LTyYVD2Q7FnZH03Hgba4Y3eh-QA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Volatile fanotify marks
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

On Thu, Mar 17, 2022 at 5:14 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Mar 17, 2022 at 4:12 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 07-03-22 17:57:36, Amir Goldstein wrote:
> > > Jan,
> > >
> > > Following RFC discussion [1], following are the volatile mark patches.
> > >
> > > Tested both manually and with this LTP test [2].
> > > I was struggling with this test for a while because drop caches
> > > did not get rid of the un-pinned inode when test was run with
> > > ext2 or ext4 on my test VM. With xfs, the test works fine for me,
> > > but it may not work for everyone.
> > >
> > > Perhaps you have a suggestion for a better way to test inode eviction.
> >
> > Drop caches does not evict dirty inodes. The inode is likely dirty because
> > you have chmodded it just before drop caches. So I think calling sync or
> > syncfs before dropping caches should fix your problems with ext2 / ext4.  I
> > suspect this has worked for XFS only because it does its private inode
> > dirtiness tracking and keeps the inode behind VFS's back.
>
> I did think of that and tried to fsync which did not help, but maybe
> I messed it up somehow.
>

You were right. fsync did fix the test.

Thanks,
Amir.
