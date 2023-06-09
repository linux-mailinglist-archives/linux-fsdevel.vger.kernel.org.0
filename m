Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A123729A63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjFIMuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbjFIMtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:49:41 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3182136;
        Fri,  9 Jun 2023 05:49:40 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5697653122fso812967b3.1;
        Fri, 09 Jun 2023 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686314980; x=1688906980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CahWo+ipYMplGimnhWBHGO6K1bzLCeC+5zbZIw52vnM=;
        b=Frgi+ePD1kB6zdym4N+vxCf6HM4sQ5AuLCOxttzemBH8GpBeKHkTOb8afVAdF8Q+E+
         bhJryUdXlbnxaZAozXFI91Bt3ARTH8wDTUYGK+xBsHo7d2fS7EyzBFB88QVaFUBgKfUk
         QhY7sNIU7uBL5IxUfWOqveqoidEhTLevwUOp4etHQF4ilZfQHFiHbB3LD5ZJ3LBm8c6a
         5yt3E7F9OaelMAdvRkef2dMfxl0zmxS0iw8N/l0PmlOrpb73tvxG20rNlBaPlwNm/7cD
         Su5jvfQdD1PVjoP+mrlujW+E/SfDWtwo8Q8VGbX1S+/K7nLPnhQiNQK4r2EV1w/iiRjA
         8bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686314980; x=1688906980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CahWo+ipYMplGimnhWBHGO6K1bzLCeC+5zbZIw52vnM=;
        b=TmrTdRjowj83ZW7mJg8vM8JOkFAlDe4H1d6fQh41oLXzvTHxKyi28NnlfZQ8Y1rPm/
         CGnsq4aIC7KSShkSRN6CzUrvMVQuPMwpUxcBeOcDXP+aS3VGPnkTXvbp2xoCan+3jWE4
         18cMQUULI4v1aDfFRliceDqWTH3aEg6Eqpo3GScyfmku6WUEj6mOPEnpcNjTCjNY2CbB
         CpOEpno5QvaQphaNm8AekYJBPlJDgCeJWH5t+s9nCr0nCqqmi1d9B5pebzV8cpD9oNaJ
         vDNUwG/IGyh3f1+fglW6HXsa2fX68ENQcXSVD5rJoGt7GOOe+D84KtvKmR+FXNe21SHg
         6zRA==
X-Gm-Message-State: AC+VfDwRHzbG2H7E6wBfZz2NCr8gmx9j+cZfWSXh5GeWgEJeRlLlxb9y
        RCpBMp0NHABhio9YX9INQv81tv6+IWe60TG6JQLTlY7omn4=
X-Google-Smtp-Source: ACHHUZ7ssxf2Mpg6cFCbVufWk1PJ4Wq/Z0XtozVBjpmytX4ZyB4ma+Sk9wIpu6Xql8wwWhfQpKhKU9dn+QZl3Wg9044=
X-Received: by 2002:a81:1711:0:b0:561:1c43:c4c2 with SMTP id
 17-20020a811711000000b005611c43c4c2mr504788ywx.5.1686314979875; Fri, 09 Jun
 2023 05:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnZJGDWUT0D7cT_kWa6W9u8MHwhG8ZbGpn=uY4zYRWJkzZzjA@mail.gmail.com>
 <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com>
 <CAPnZJGB8XKtv8W7KYtyZ7AFWWB-LTG_nP3wLAzus6jHFp_mWfg@mail.gmail.com> <CAJfpegu4_47=yoe+X7szhknU+GedJTqHO0h_HcctqZuCiA41mw@mail.gmail.com>
In-Reply-To: <CAJfpegu4_47=yoe+X7szhknU+GedJTqHO0h_HcctqZuCiA41mw@mail.gmail.com>
From:   Askar Safin <safinaskar@gmail.com>
Date:   Fri, 9 Jun 2023 15:49:03 +0300
Message-ID: <CAPnZJGB3BzdtSues3x3ErPQNG=zpPvoSA2Akwr1oexH-4F1w8w@mail.gmail.com>
Subject: Re: [PATCH 0/6] vfs: provide automatic kernel freeze / resume
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        linux-pm@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
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

> If the ServerAliveInterval is set to less than the freeze timeout (20s
> by default) and you apply the patch and start sshfs like below, then
> suspend should be reliable.
>
>   (echo 1 >  /proc/self/freeze_late; sshfs ...)

Thanks a lot. I don't want to apply patches. I'm happy with my solution.

Note for other people reading this thread: ssh docs say that actual
timeout is "ServerAliveInterval * ServerAliveCountMax", so if someone
will apply this patch, he should ensure that ServerAliveInterval *
ServerAliveCountMax is less than 20 seconds.


-- 
Askar Safin
