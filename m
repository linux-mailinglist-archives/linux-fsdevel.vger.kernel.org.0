Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC8B715D18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjE3LYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 07:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjE3LYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 07:24:33 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4FD115
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 04:24:26 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39855d57240so2694824b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 04:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685445866; x=1688037866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fpeVFf4HYSFKWVkH4psx6XWClCE7Pw9O6mlEXg3ssXA=;
        b=bRBy8OFF8M6ESV/CqxPG0Zm0fgDgnY+H+ScocLqDlCzx813Qj8hChJYzTWrA4S/3i6
         zP8zv4usC/Hp5ttnexNyYUru/t9hJziAtQIWOwgKmv5iW8USBWHFVIwUMHSu3WQK6hfF
         wlzBIRXbgD3m8PBJVwxPz0C/aOA1lzVddAC6xgB8bxMvRz8ZMotb2g/0LQWghPXfpbm2
         eeCdAFIgsYdRnQnCoC3V/r4TNwMBqTTW4ke7rpgFg+s/IgEqQSAp6dR7iyIeY9Yoyo0N
         /svdQssSVJZs6zc3F+x7j+p7GVCaz/q0QVj7dC4+ZeaJv9b3Py8QGYibLQ4fCovZC2jA
         AZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685445866; x=1688037866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpeVFf4HYSFKWVkH4psx6XWClCE7Pw9O6mlEXg3ssXA=;
        b=SxWxckwzJoPKbnLjW7fk7H2yhHLRaEpwjdAtNAgWV4pYoPmL/mYHmeTHmNlXyrAllt
         bYmumiPQ1URyDgst1sZD0hAD87O15HBZQivygKwj9U6p35r0F6BNejgwbrj4kOA3BnW9
         M3OEpFfujoUSVWuY9k81tcjFIr/DBDXRqLNu0KYnWF85oiOOwJOs8k71jy+S35V4K/PC
         Lh0iYMFG/a8Aqxai23zR6ie15MQYpB4gnu1DrUpdDhRdJo+JLbwSa4yNab9nyM8OL6ON
         3WipoSIv6GHAcbXZ31f5VgSky0W+8NzvyojmVqkyBk73/G/Gnx0Rg/8jL2ddmkMKf5xg
         DXpg==
X-Gm-Message-State: AC+VfDxHL7EX4DGk8cqvHCTny0Ba89QkUU7X9JATZGX0i1iutCZiVQaR
        7hV6ENks4v7vstOX5u1CmDyoUNVLtGt56Rcd9mMjp5VQAQVem9gpAXo=
X-Google-Smtp-Source: ACHHUZ6g5bk0eLe2t86uVRj615HeQB1zD3d2iMcSb3N/hPHw2Pmi1tB/ZWiZnN1NttFUM5m5Gk8Qrg7ipL2x++lEDow=
X-Received: by 2002:a05:6808:2184:b0:398:4b04:25ca with SMTP id
 be4-20020a056808218400b003984b0425camr1292658oib.14.1685445866121; Tue, 30
 May 2023 04:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230526130716.2932507-1-loic.poulain@linaro.org> <20230530-polytechnisch-besten-258f74577eff@brauner>
In-Reply-To: <20230530-polytechnisch-besten-258f74577eff@brauner>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 30 May 2023 13:23:50 +0200
Message-ID: <CAMZdPi_WE7eegcn3V+7tUsJL2GoGottz2fGY14tkmqG9Tgdbhg@mail.gmail.com>
Subject: Re: [PATCH] init: Add support for rootwait timeout parameter
To:     Christian Brauner <brauner@kernel.org>
Cc:     corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

On Tue, 30 May 2023 at 11:45, Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, May 26, 2023 at 03:07:16PM +0200, Loic Poulain wrote:
> > Add an optional timeout arg to 'rootwait' as the maximum time in
> > seconds to wait for the root device to show up before attempting
> > forced mount of the root filesystem.
> >
> > This can be helpful to force boot failure and restart in case the
> > root device does not show up in time, allowing the bootloader to
> > take any appropriate measures (e.g. recovery, A/B switch, retry...).
> >
> > In success case, mounting happens as soon as the root device is ready,
> > contrary to the existing 'rootdelay' parameter (unconditional delay).
> >
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > ---
>
> Not terribly opposed and not terribly convinced yet.
> So, we have rootdelay= with a timeout parameter that allows to specify a
> delay before attempting to mount the root device. And we have rootwait
> currently as an indefinite wait. Adding a timeout for rootwait doesn't
> seem crazy and is backwards compatible. But there's no mention of any
> concrete users or use-case for this which is usually preferable. If this
> is just "could be useful for someone eventually" it's way less desirable
> to merge this than when it's "here's a/multiple user/users"... So I
> would love to see a use-case described here.

I can integrate the following use case into a v2 if you think it makes sense:

In case of device mapper usage for the root filesystem (e.g.
root=/dev/dm-0), if the mapper is not able to create the virtual block
for any reasons (wrong arguments, bad dm-verity signature, etc), the
`rootwait` parameter will cause the kernel to wait forever. Adding a
timeout allows it to detect the 'error' (panic) and reset the device
after a few seconds, the bootloader can then decide to mark this
non-bootable partition/parameter and fallback to another partition
(A/B case) or into a recovery mode.

But it's not specific to device mapper, if a eMMC/SDCARD is not
detected at boot time because of hardware or software problems (e.g.
updated with a bad devicetree), it could be desirable to panic/reboot
instead of waiting for something that will never happen.

>
> And this is only useful if there isn't an early userspace init that
> parses and manages root=. So we need to hit prepare_namespaces() as a
> rootwait timeout isn't meaningful if this is done by and early init in
> the initramfs for example.

Indeed, and I do not use initramfs in the above use case, the mapped
device is created directly from the kernel (thanks to dm-mod.create=),
mostly for boot time optimization reason, and this is for the same
reason that rootdelay does not fit.

Regards,
Loic
