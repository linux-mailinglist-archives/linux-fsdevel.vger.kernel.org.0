Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE1F797AD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 19:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbjIGRwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 13:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbjIGRwS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:52:18 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B236170F
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 10:51:48 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-48d333a18b3so447685e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Sep 2023 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694109072; x=1694713872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ewixdf5MDqg0mZKfVOIVseBe9QYxPNn7/P9pgx4Cjmk=;
        b=S2FO36G9wlcwup5RaTHi97Rg2pKEIXYadudb/lo0ZIWENw/NyJZ7TemuHnnVaHHoN/
         kMDKcW3vPhlz2ymKaS2aZF/hVT4nCvH4DWKGWzeq0inbnf96bSlEPurR0SZv1Ofls95w
         TDz/8gr2fAhjBqf1aZdBBdxJ6w6jOqhbuh5o5vrGJ98qEhet9Vk8lctJjOUsfFOMXLPL
         z8NFVy7IVvpeDu3dCY+TDSZA+7/fff55h/e8vRaL4llN22hwxVc+VBo6iCZsSk+RLFAO
         igvhpGNIjrtHqlfpugGBS697UtkaxB6lgNicu6UUhMEDpaolFydpS9DuLm9j/UsIW/vy
         N6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109072; x=1694713872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ewixdf5MDqg0mZKfVOIVseBe9QYxPNn7/P9pgx4Cjmk=;
        b=WF8siYdLTT/q2AecxKyuhoLgdbNyljcVbWMVRrHF529o/fAI+LUgT6nh6DGv/Rvtsw
         OWH6lqRX8grfQ6xBrdxpdSzO8InKxZgSOKGytfkr6l7PZkrJYW1qYHVDb5P/T/JVoxZI
         UKeCUWSk/fyaLkqx3BE10Y1CdkJtemvg9UC9eXlL+xKJWRARDo0LqAJW/M5JnDAHu699
         vFoyotZinv4i5iniv7ItAYnZRmDFuOmDWNjob2faxN91irfPmOpZ8eLOESyFfWzftUTU
         0qEMiZ0GKbCONPBTnu/GumCMHlRZKqiIKV2zXQ9n+9gU1s0Q83LXEkrbDb9ec0Kjhdr+
         n6OQ==
X-Gm-Message-State: AOJu0YxVHyQHQaw74emNZIqvaDLUxyco20D0GmsgkQJb/UadmGQxdQa3
        CQWiUpiK0sv7k71cFf9ZkO5KZo7qa6LVwgGHW99rs2skjFI=
X-Google-Smtp-Source: AGHT+IGfbSc4HTh9XWUHnevQ2GDwIc0Etu9ihuWTnN2kv7jDA/ooxz9d1n4qmaNK7WDqKM8m1b8y1l38rTDyAso7SqU=
X-Received: by 2002:a67:bd09:0:b0:44e:fc88:9cc5 with SMTP id
 y9-20020a67bd09000000b0044efc889cc5mr5881996vsq.20.1694082023835; Thu, 07 Sep
 2023 03:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAD_8n+R8vGv0DWqYc01-S62BtW3Y=WMsEFwcSLzWgzVZr7z4bg@mail.gmail.com>
In-Reply-To: <CAD_8n+R8vGv0DWqYc01-S62BtW3Y=WMsEFwcSLzWgzVZr7z4bg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 7 Sep 2023 13:20:12 +0300
Message-ID: <CAOQ4uxhE8En64rr3mx1UAOqqzb3A-GoeR7cx2D+V73ytr6YLjw@mail.gmail.com>
Subject: Re: vfs: implement readahead(2) using POSIX_FADV_WILLNEED
To:     Reuben Hawkins <reubenhwk@gmail.com>
Cc:     mszeredi@redhat.com, Christian Brauner <brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 7, 2023 at 8:44=E2=80=AFAM Reuben Hawkins <reubenhwk@gmail.com>=
 wrote:
>
> Hi,
>
> I found that this change broke readahead for block devices.  I can change=
 my application to call posix_fadvise easily enough, but would like to fix =
readahead for block devices nonetheless.  Is there any reason why readahead=
 should *not* work on block devices?  Before this commit, 3d8f7615319b2bca8=
7a4815e13787439e3339a93, readahead succeeded on block devices.

Wow. It has been broken for 5 years and nobody complained about it.
I guess it is not common for people to readahead from blockdev,
but this does not justify the regression.

TBH, I am not really sure why I put the S_ISREG() limitation in readahead()=
.
Judging by my earlier comment in v4 revision [1], I probably added it to
preserve -EINVAL value for readahead on pipes -
generic_fadvise() returns -ESPIPE for POSIX_FADV_WILLNEED on pipes.

I would either replace !S_ISREG() with S_ISFIFO() and explain the reason
for this check in the comment above, or remove !S_ISREG() altogether.
It will probably take at least 5 years until someone notices the change
-EINVAL =3D> -ESPIPE if at all.

>
> I've never submitted a patch to the kernel.

There's a first time for everything :)

> Can you advise me where I should send the patch and who should be copied?
>

Send the patch to the relevant mailing list: linux-fsdevel@vger.kernel.org
found in PAGE CACHE and FILESYSTEMS (VFS and infrastructure) entries
of MAINTAINERS file, CC the PAGE CACHE and VFS maintainers and
the authors of the patch (Miklos+myself).

What & how to send the patch is more important.
See submitting-patches doc [2].

Let me know if you have any questions.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/1535443233-31068-1-git-send-email=
-amir73il@gmail.com/
[2] https://github.com/torvalds/linux/blob/master/Documentation/process/sub=
mitting-patches.rst
