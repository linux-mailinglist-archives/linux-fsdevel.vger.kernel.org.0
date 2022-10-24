Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3385F60978C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 02:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJXAnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 20:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJXAnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 20:43:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E165810;
        Sun, 23 Oct 2022 17:43:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso5141582pjc.0;
        Sun, 23 Oct 2022 17:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAHmIx43CcUy6jio/UUUYILeSOOvlH6FmdJfzEj8eks=;
        b=IUHfAGQNBRt7IEHfR4uYvCBVurbevFI9XyPgouFCf1F7yoebQPmYct+slj/zhVto1A
         F9OHaVIB/QV6UriyXxjsJfSDeURzbhHv6QcBUH24MmidSaN4C/6DPK+Ox1MHCj/fsG8o
         5iJQsP8X3GYttiu10UxjYgGa/WH1guQW6PFx5oec2mUXg5vBJFe1kxec850NTuGaF/fu
         Lqn47DjtFPK3MmYM91ylo6JZaueJ1v/rJRQTFnWlC1+XjaDaGqEo4ArJcHFrn3aFNsSc
         12KbNpyRW55HMY26Ivy/J/Y5ejkrXedYaQsV40P0u898IUBCh4BA3dySKevP58Wg1dCP
         xBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAHmIx43CcUy6jio/UUUYILeSOOvlH6FmdJfzEj8eks=;
        b=G5rP+IvsaRSZMfLTH1MoyRHmlDZRx6g+c5rzG//pQJ3cx0pKZ3lbEl6SCJtonci57q
         8NQG5FlQgtDJojBgF9XPvSWiAPytq5C7rZLbYu8q/Uj9CDzbYqlp9lrYXWeuIOkW9PB0
         WzZddKxdoKlvzPOj+pGYoPIwn0aZmhI00/G9cILlSS7MIQVtG+MoX9A6boPpxxBPCMxU
         XFXdffmr1pxKNnrUi9bc65fg9KTU1lnpOJfVHJJAiZPHvbQjwqG6rkp4Ic9jSOqafTqA
         WmbqBoDqjKQ4oST95K/MeYgvLFEOEjQf+qw0p9MtHWORoQAxxRZnSK5ER08uHet2eAYy
         VQ/w==
X-Gm-Message-State: ACrzQf3SOtoXDdDCyM5saFKN1ETSnnKI5dmYUgxAi5xbxQ91b/0MW5/O
        Bf6ZHcEt/OU6NCFNaj4O8GVPnjZT3wMs1Mpe
X-Google-Smtp-Source: AMsMyM7sVRO1O8XmRqiNkT1GTOpweUX3vquiDvo1l3jp5G24c3k5YT3HrLyxL0qDUsPY16wHACcUAQ==
X-Received: by 2002:a17:902:ccc2:b0:178:29f9:5c5e with SMTP id z2-20020a170902ccc200b0017829f95c5emr29430475ple.21.1666572187529;
        Sun, 23 Oct 2022 17:43:07 -0700 (PDT)
Received: from localhost ([223.104.41.198])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b0017f9db0236asm18880815plf.82.2022.10.23.17.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 17:43:07 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     viro@zeniv.linux.org.uk, raven@themaw.net
Cc:     18801353760@163.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yin31149@gmail.com,
        akpm@linux-foundation.org, cmaiolino@redhat.com,
        dhowells@redhat.com, hughd@google.com, miklos@szeredi.hu,
        oliver.sang@intel.com, penguin-kernel@i-love.sakura.ne.jp,
        siddhesh@gotplt.org,
        syzbot+db1d2ea936378be0e4ea@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, smfrench@gmail.com,
        pc@cjr.nz, lsahlber@redhat.com, sprasad@microsoft.com,
        tom@talpey.com
Subject: Re: [PATCH -next 0/5] fs: fix possible null-ptr-deref when parsing param
Date:   Mon, 24 Oct 2022 08:42:57 +0800
Message-Id: <20221024004257.18689-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y1VwdUYGvDE4yUoI@ZenIV>
References: <Y1VwdUYGvDE4yUoI@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Oct 2022 at 00:48, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Oct 24, 2022 at 12:39:41AM +0800, Hawkins Jiawei wrote:
> > According to commit "vfs: parse: deal with zero length string value",
> > kernel will set the param->string to null pointer in vfs_parse_fs_string()
> > if fs string has zero length.
> >
> > Yet the problem is that, when fs parses its mount parameters, it will
> > dereferences the param->string, without checking whether it is a
> > null pointer, which may trigger a null-ptr-deref bug.
> >
> > So this patchset reviews all functions for fs to parse parameters,
> > by using `git grep -n "\.parse_param" fs/*`, and adds sanity check
> > on param->string if its function will dereference param->string
> > without check.
>
> How about reverting the commit in question instead?  Or dropping it
> from patch series, depending upon the way akpm handles the pile
> these days...

I think both are OK.

On one hand, commit "vfs: parse: deal with zero length string value"
seems just want to make output more informattive, which probably is not
the one which must be applied immediately to fix the
panic.

On the other hand, commit "vfs: parse: deal with zero length string value"
affects so many file systems, so there are probably some deeper
null-ptr-deref bugs I ignore, which may take time to review.
