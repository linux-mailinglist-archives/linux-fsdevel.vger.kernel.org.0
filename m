Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB81661DF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 05:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjAIEqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 23:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjAIEqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 23:46:51 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E5C139
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 20:46:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d17so6984209wrs.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Jan 2023 20:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/QnpFcrDZmxZizOnzoOkLTrfFGO7lpW7L9aDCTOnzxU=;
        b=nt1Gvpqi7HCDN4rYvjhIV4HyJN4ayuOK6EHKWktudk6G2YpAVvZqRD/9Zh6p2GRupd
         644qqWWoyCQOn3TuIB71mRgZmWkoZDYqNGk1IiJ0TocKy9t6TT96RWxFuBFz38d+BJ6G
         J9VPR7mHWA9OJEvtznvN79DN/YhNsfkS3DTbuMSrZp6hzlcfcbuvBiEK3nFHrzf50tye
         vDBnvEMSuKtgFajYxBt+2BlgHMfwtuf7inu55keX86RUCh1Pfr3/pBzv8/jcaWLqwqGb
         XhonYxNZdKZnvI3Y9vTacrrKcTdIJ5oBt9ZR5e0Wzy21QNCNCfF6z8TAm6XpmpLU104Y
         hNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QnpFcrDZmxZizOnzoOkLTrfFGO7lpW7L9aDCTOnzxU=;
        b=tITfbZDhhhWrN/iTulN6hAsglqa1UBRlR3SFH1jaZ34luawZszVScd3PHDz9Zh9cfQ
         UMLIp1ZGDwACE/AIzD1Qgc2tQEsDrOZbyPJrkxdUfVVtYlJnMYXAP9vAtYr18JE2vzRE
         fDPKm+BlNj6FgZEynWjtOozLnPvprm03Um6nLqCpWZCMa4Ehd3BytEitezxT/4yEIV08
         VKhYw1BEE67CVyLYTTs81wr47m8uIgLZORSlJQiDnt1a2qneictR01DxooAjvGtyENx9
         5LDyhQjqZrM3Juq2ZSzu15SfiCIApsre0F1vJ8VmLropMYgKCjEvN6TkQ2NrHVdGeVY8
         OaAQ==
X-Gm-Message-State: AFqh2kqd0u8LJDk5HWjcqHctlugjZGiDrg6Ss/OSGDpfZAP/geGrLQ7s
        3l6NPyvwY3Qh59gpart4D5CZ3QkX1+9MIfksR9nfd9PWy+8=
X-Google-Smtp-Source: AMrXdXuz6F0ugV5mf4qV/0wSG1IccZD0aG4NUA0PUqYxIRXAzIlci3gpnedoVs+KnTt5xtZfGkidFxdiFi5MfH3WRok=
X-Received: by 2002:adf:d21b:0:b0:28f:a755:4d6d with SMTP id
 j27-20020adfd21b000000b0028fa7554d6dmr702336wrh.180.1673239609032; Sun, 08
 Jan 2023 20:46:49 -0800 (PST)
MIME-Version: 1.0
From:   Anadon <joshua.r.marshall.1991@gmail.com>
Date:   Sun, 8 Jan 2023 23:46:38 -0500
Message-ID: <CAFkJGRdxR=0GeRWiu2g0QrVNzMLqYpqZm6+Ac5Baz2DcL39HTQ@mail.gmail.com>
Subject: Do I really need to add mount2 and umount3 syscalls for some crazy experiment
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I never post, be gentle.

I am looking into implementing a distributed RAFT filesystem for
reasons.  Before this, I want what is in effect a simple pass-through
filesystem.  Something which just takes in calls to open, read, close,
etc and forwards them to a specified mounted* filesystem.  Hopefully
through FUSE before jumping straight into kernel development.

Doing this and having files appear in two places by calling `mount()`
then calling the (potentially) userland functions to the mapped file
by changing the file path is a way to technically accomplish
something.  This has the effect of the files being accessible in two
locations.  The problems start where the underlying filesystem won't
notify my passthrough layer if there are changes made.  Since my end
goal is to have a robust consensus filesystem, having all the files
able to silently be modified in such an easy and user accessible way
is a problem.  What would be better is to have some struct with all
relevant function pointers and data accessible.  That sounds like
adding syscalls `int mount2(const char* device, ..., struct
return_fs_interface)` and `int umuont3(struct return_fs_interface)`.
Adding two new syscalls which look almost nothing like other syscalls
all in the name to break "everything is a file" in favor of
"everything is an API" is a lot.  It sounds like a fight and work I
would like to avoid.

I have looked at `fsopen(...)` as an alternative, but it still does
not meet my use case.  Another way would be to compile in every
filesystem driver but this just seems downright mad.  Is there a good
option I have overlooked?  Am I even asking in the right place?
