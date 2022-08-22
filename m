Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA3659C0B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiHVNhJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 09:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiHVNhF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:37:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6C22AC40
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 06:37:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h22so10975124ejk.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 06:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qSePyfd1Y2EMPHsdhyul1LskKjWov4i06MUQ203pP68=;
        b=rXfb6Wv0vVe5XNutyWI0zL1Gt27lZZTa552I7NsC16bCS0xt/QemqACvU/mRBvDYDn
         YOfuGEia3a0snUoALWl2vsh2soh/6QOoZfZnFBDCHRJWQtEY0tUU5HraNzpXVD8F0b5u
         5LLs/OEe2oBnEZtbFCKONnqtN6UBtdGmCLbJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qSePyfd1Y2EMPHsdhyul1LskKjWov4i06MUQ203pP68=;
        b=TQU1gjvkuj/nKWCcrsA0d3BMYRQCIJx9QPq6isxwzrijgXa4tMj9UB3/IRjk3FX6jD
         elj/1TpwKg0R8RCJlPpoE4tXphIwmm8U2ZTK3IqHoUL7k3lQfXHwakSjBXRYHXYA9DOM
         XHmx3wrjsarT74QHQ8XMnPEvfvaepwHmspSJmtCkwMLTEqmviyxvxY2YDRKMLcscFxgc
         OzXBH66GtltJc2S1I7jC2My7Zje8GoRavPXjtE6+kwz0S53FFhM+WTdVRAWkWMNzgw/t
         Gpxk31R2bk9Tre9uTnckBhutHI22jz6QSAI8IMDWk2R3+beS6bW3NQcJCHtz5QA7ia6G
         bqrA==
X-Gm-Message-State: ACgBeo01HeZSyPZCtUqgXMqPBVclcNnHh3n/P3r3ZM+cf5x3aK0uTK2k
        96lowK6meSUHfmeWU0fiuxihQIVPvcUodkfRODE8IA==
X-Google-Smtp-Source: AA6agR6AmsdE16NKnZr2QV1mHbBEHrXLB8beuGIO5+LXsbMWTNonfVC7p6DO1grU7Zc+VyNrEWMaSRjgZS4QviZDPXM=
X-Received: by 2002:a17:907:7396:b0:738:7bcd:d7b5 with SMTP id
 er22-20020a170907739600b007387bcdd7b5mr12518114ejc.691.1661175421530; Mon, 22
 Aug 2022 06:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200728234513.1956039-1-ytht.net@gmail.com>
In-Reply-To: <20200728234513.1956039-1-ytht.net@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 22 Aug 2022 15:36:50 +0200
Message-ID: <CAJfpegv=8gc1W80e0=33dEcdQb4OgVWKBVXi3jNDKVWV1fWetA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add filesystem attribute in sysfs control dir.
To:     Lepton Wu <ytht.net@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 29 Jul 2020 at 01:45, Lepton Wu <ytht.net@gmail.com> wrote:
>
> With this, user space can have more control to just abort some kind of
> fuse connections. Currently, in Android, it will write to abort file
> to abort all fuse connections while in some cases, we'd like to keep
> some fuse connections. This can help that.

You can grep the same info from /proc/self/mountinfo.  Why does that not work?

Thanks,
Miklos
