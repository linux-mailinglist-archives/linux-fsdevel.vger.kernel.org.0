Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38476DF7B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 15:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDLNwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 09:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjDLNwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:52:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0513D10CA
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 06:52:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f26so22926542ejb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1681307569; x=1683899569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6UePRKxgzqqhv0WlMFum5WhT8Fo7qQq0HQsLtF573Ck=;
        b=nNjqd5iAbQJvG1BOO2ScAd8XxlysS0/k6N6xZoBrsOnwZiCxolUsWjUzeojO9Bw/BA
         Q/YxqlyLYlP/QnraJ9W1MM7DjQPP2yd3h/w28kk+zee3irMayubbsOs1XWitUfr9H4n8
         fPPBQVcFVDEIN9WNmA24dIRWyVwqfNeBEtEqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307569; x=1683899569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UePRKxgzqqhv0WlMFum5WhT8Fo7qQq0HQsLtF573Ck=;
        b=Kd9wDQ0wOit11qqxSMQnMVjxZD0ohCtG1Bwaogb3v310kMY2tzAca5vvWOJWgjqwIL
         eaYq/Z53qVv3UuulgMF3ETpbmNTFTqJzVK0Ba64r2LyHiUGJ8a/NIkgLqCl8BLLiZ18T
         3OgFf0jsZv7PVvSnQaobnqaWnQuFkxORX0VikLgEemED8SEjHDWazj58K2OIGx5TIukL
         ap8KuEFlwbo87QCnnWJ2GWFyouRuHHbifW9JrVGICOSdcbu4Ma/zLOfEW8+alFj3LNlf
         s1pj5rWJE+B76q57IczuS09Ij59BaB2y/m6DowNTQhdsXj1HOxt5Sk9XbRzR3fo+Auxt
         06bg==
X-Gm-Message-State: AAQBX9e55J+Ql9ekISwxxGf4Hlp6xhWNvwPtX7l93fpNHDUxD1iu4uj3
        sBKNpJRkhnanNRvQGhMXdGZpUes17CGoIPzu+r43CA==
X-Google-Smtp-Source: AKy350akVDMxSYmf1op8qd/cRmhdUF+2E8mr/Y5rK3scyaFV3IDiLFABZDIDUsam4fuTMbxVVnF0LQsl/7CPk9Lm6Gg=
X-Received: by 2002:a17:907:d609:b0:92b:ec37:e4b7 with SMTP id
 wd9-20020a170907d60900b0092bec37e4b7mr1322484ejc.14.1681307569396; Wed, 12
 Apr 2023 06:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d5a93805f8930638@google.com>
In-Reply-To: <000000000000d5a93805f8930638@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Apr 2023 15:52:37 +0200
Message-ID: <CAJfpegsGjFQX9t_NS8-oiE0K8Y0xEmr60VXMg6d4HQCCXOrOXg@mail.gmail.com>
Subject: Re: [syzbot] Monthly fuse report
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+list69b50efce6f847334104@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 5 Apr 2023 at 11:00, syzbot
<syzbot+list69b50efce6f847334104@syzkaller.appspotmail.com> wrote:
>
> Hello fuse maintainers/developers,
>
> This is a 30-day syzbot report for the fuse subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/fuse
>
> During the period, 0 new issues were detected and 0 were fixed.
> In total, 8 issues are still open and 34 have been fixed so far.
>
> Some of the still happening issues:
>
> Crashes Repro Title
> 146     Yes   INFO: task hung in fuse_simple_request
>               https://syzkaller.appspot.com/bug?extid=46fe899420456e014d6b
> 26      Yes   INFO: task hung in lookup_slow (3)
>               https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
> 13      Yes   INFO: task hung in walk_component (5)
>               https://syzkaller.appspot.com/bug?extid=8fba0e0286621ce71edd

Hi Dmitry,

These all look like non-kernel deadlocks.

AFAIR syzbot was taught about breaking these by "umount -f" or "echo 1
> /sys/fs/fuse/connections/$DEV/abort", right?

I wonder why they are still triggering a report then.

Thanks,
Miklos
