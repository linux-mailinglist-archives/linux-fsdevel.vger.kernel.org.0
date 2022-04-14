Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65287500BBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 13:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiDNLFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 07:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbiDNLFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:05:04 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552EA3C4B7
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 04:02:40 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id j6so3548230qkp.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtrBGZoxqFU9jOlgs71IN9cqMVlUJhNPoL2pVNfqqnw=;
        b=BV0xdzU2Y/ytwEP99Tt0MKlWuBNgpzq2eo+xkSFmhHqzcR/sCdbCfsmjQJSM5+iT/W
         HUTj9XLZQdxR91rIW7iw1tPn3fexZF3PdGsN0Y1A+yjM6wOAEpeBtzipiBwm0aRt903c
         niZ6r+ork/2zEVoEbHqhCSzZEulEQLfjFLiYTAP8ofxnya7GKqKHi8h8PUiMoUn6OHho
         TlK5bb52oTOBpdYISwpAXtWxPpOM+jLb90fUsbb9wmRqewaA/TPRFRKKHPoOfvDnGYA+
         fV/0s3ahKaMAdAdufGdKBh17eTHMG+PY/Cisb/4FVUiYKIXdGbxEY+3UvDNlwFw6DaKG
         O77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtrBGZoxqFU9jOlgs71IN9cqMVlUJhNPoL2pVNfqqnw=;
        b=4qCmWjcELRF0RF9xmKuK6qBa+IwQ2y6q3nZfGAbU5T+7bYU5gXHlEuRnECXdDoIPSn
         YNkz+Pq/tLhLJb8jvDy/I1GW71E7GJRvfxUHy/zpIMSm/2ywf+Kf+yBzeFnIk2MnXlR7
         0fdkh/+1SOlLcxPe/n5hm32P9yLpnXG2KxQjTh2Rgcy1d5cTCJPdo5xrxzsGRKFG/hW/
         w4Q2TJLVXociAE1Qp8yo3pQ48XPy0goDMJKX+atHxYjye/uiwLU617mCareYxQkAj4o4
         U0SXwShXDCH8Mopdg9zVoEl++YF7r1OdCb94x2IPCPg7LhDZLVtIF4IA90rKRc13xNPd
         ScsA==
X-Gm-Message-State: AOAM533ZD/dIpEzB+uC5VbPApnAer+pKzZjcdO8nNKLlqzgvZ0DS4nrz
        g4AaINKmyc3aP2eBK0tGbmjAkf1Gs2gfNMarixPx5u7Ebj8=
X-Google-Smtp-Source: ABdhPJxLetRPRKEUwHwpcPf+t4lcvI9QI/CxUf5GwAlP4U9Wnxlrs/ncOLfAwVIdIDwoJ74vGVfsnWtCGE9sYQMM280=
X-Received: by 2002:a05:620a:10ac:b0:69c:7450:a56f with SMTP id
 h12-20020a05620a10ac00b0069c7450a56fmr1324601qkk.386.1649934159328; Thu, 14
 Apr 2022 04:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com> <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
 <20220314113337.j7slrb5srxukztje@quack3.lan> <CAOQ4uxgSubkz84_21qa5mPpBn7qHJUsA35ciJ5JHOH2UmAnnbA@mail.gmail.com>
 <20220413115112.df3okrcutiqvsfry@quack3.lan>
In-Reply-To: <20220413115112.df3okrcutiqvsfry@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 14 Apr 2022 14:02:27 +0300
Message-ID: <CAOQ4uxhvR8Kr99V1gCmBxRWQqQuhCLz9h30YhEYjF-qkdOpjaQ@mail.gmail.com>
Subject: Re: Fanotify Directory exclusion not working when using FAN_MARK_MOUNT
To:     Jan Kara <jack@suse.cz>
Cc:     Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
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

> > Jan,
> >
> > Just a heads up - you were right about this inconsistency and I have both
> > patches to fix it [1] and LTP test to reproduce the issue [2] and started work
> > on the new FAN_MARK_IGNORE API.
> > The new API has no tests yet, but it has a man page draft [3].
> >
> > The description of the bugs as I wrote them in the fix commit message:
> >
> >     This results in several subtle changes of behavior, hopefully all
> >     desired changes of behavior, for example:
> >
> >     - Group A has a mount mark with FS_MODIFY in mask
> >     - Group A has a mark with ignored mask that does not survive FS_MODIFY
> >       and does not watch children on directory D.
> >     - Group B has a mark with FS_MODIFY in mask that does watch children
> >       on directory D.
> >     - FS_MODIFY event on file D/foo should not clear the ignored mask of
> >       group A, but before this change it does
> >
> >     And if group A ignored mask was set to survive FS_MODIFY:
> >     - FS_MODIFY event on file D/foo should be reported to group A on account
> >       of the mount mark, but before this change it is wrongly ignored
> >
> >     Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events
> > on child and on dir")
>
> Thanks for looking into this! Yeah, the change in behavior looks OK to me.
>

And I got sufficiently annoyed by our mixed terminology of "ignored mask"
and "ignore mask". Man pages only use the latter and also most of the
comments in code and many of the commit messages but not all of them
and variable name is of course the former, so I decided to take action:

commit 6c6f07348c0c587e2bdcdb997caa30f852e818ef
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Tue Apr 12 13:25:34 2022 +0300

    fanotify: prepare for setting event flags in ignore mask

[...]

    To emphasize the change in terminology, also rename ignored_mask mark
    member to ignore_mask and use accessor to get only ignored events or
    events and flags.

    This change in terminology finally aligns with the "ignore mark"
    language in man pages and in most of the comments.

I hope I didn't take it too far...

Thanks,
Amir.



>
> > [1] https://github.com/amir73il/linux/commits/fan_mark_ignore
> > [2] https://github.com/amir73il/ltp/commits/fan_mark_ignore
> > [3] https://github.com/amir73il/man-pages/commits/fan_mark_ignore
