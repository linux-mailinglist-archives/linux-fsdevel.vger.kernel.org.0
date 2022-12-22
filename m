Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF20D654345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 15:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiLVOlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 09:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiLVOlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:41:47 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38989DF3F
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 06:41:43 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o6so3026154lfi.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 06:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oGSNefEUZplCFCKNRfY16Kt/sT/KjRS68RvAs8iCVEc=;
        b=G5Ik5Ml+3TJbS53OWv8j525NnsNYlMnJuSZ9QXypkkcE9GYTrXrDDELUlqRUeGRO92
         5zu1BC+nigYso8rQg/ShGmE8BBVQSWvvVkZGVNnGQNZ3De6VLDNRXndkIycM5Ihg37Pa
         DBP+15NCvKSMXbieoHneKXo8os8yNmx7wWl7ZrXXx4GVJCWc/1E9pVu49kZmTnb5anAu
         +97GHYNMtBE8pvsCfUNuqTXb8lBz8WExl46o93iFmZ93/IXt6qqQ/Kcem0UxdJpeFXsh
         bR82V2AW8zhTRkbmEuRYCiUWDEl7OGD2bHANDtjEm/Md2pympeJqSpKEIeolMl++CtOv
         0OKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGSNefEUZplCFCKNRfY16Kt/sT/KjRS68RvAs8iCVEc=;
        b=1rzI4yDyNeN5EfpnFaU1lN10Lsy0wSoKXSSPRxXJkO2ITmX5zGjFl1NlaF95QeoMPg
         YNAlavfWWj5bMqeljZm7P1IEutQ2jzzwsMITYXszj6QU3szT4R3v288ViQ15+Twt0wdw
         9eY7aOqcWbumnCZU18DaVWgqeARp38I7PK9S0/uKd/6NlrPcnwOIrXFeOYpfLeEGXYT5
         hKjmpUMXLhPOB8NqHEDfkUoBULVoROsqMLWfAbXkHgHm+D2wXoxnRvHp/IyClV+A/GKR
         9CMZeGKyE1K9c8jxzJAJ3bjrdEsm2cQPv+O/g9MMpegyd2tKcUe3kmt7JTPC889+xg2g
         b9jA==
X-Gm-Message-State: AFqh2krfn/U/7lCnkPXBVUTDsqNZA6S9ZawIYor0n/XWXxCg4F0Lz2Gb
        U5iqHmZze5wnntAsjQd8x6ZFpMXkaJV+HWLXv+4=
X-Google-Smtp-Source: AMrXdXug0SS2lTsFXC/H3VcUVxUMvR7S+jzb7J2cYFjAwPPHRrNgVWgSjCYbyzIuJZLaMpGzey7iplgbSRqRYF5zYJ8=
X-Received: by 2002:a05:6512:3c82:b0:4b5:7f79:f8bb with SMTP id
 h2-20020a0565123c8200b004b57f79f8bbmr634673lfv.7.1671720101493; Thu, 22 Dec
 2022 06:41:41 -0800 (PST)
MIME-Version: 1.0
References: <CAPr0N2i3mo=SP+AdpMz=qHXejsKWs+JLTPaJVGwrzopaWOfVdA@mail.gmail.com>
 <CAOQ4uxh8c1=eBVihamhzCCAvRr38j0HCmth9ke3bo_nKsv62=A@mail.gmail.com>
In-Reply-To: <CAOQ4uxh8c1=eBVihamhzCCAvRr38j0HCmth9ke3bo_nKsv62=A@mail.gmail.com>
From:   Zbigniew Halas <zhalas@gmail.com>
Date:   Thu, 22 Dec 2022 15:41:30 +0100
Message-ID: <CAPr0N2gtz79Z1fNmOc_UHjQrZfqUwzx2rJ7+4X0jFbMAAoh3-Q@mail.gmail.com>
Subject: Re: FIDEDUPERANGE claims to succeed for non-identical files
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 22, 2022 at 9:25 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Thanks for the analysis.
> Would you be interested in trying to fix the bug and writing a test?
> I can help if you would like.

I can give it a try unless it turns out that some deep VFS changes are
required, but let's try to narrow down the reasonable API semantics
first.

> It's hard to follow all the changes since
> 54dbc1517237 ("vfs: hoist the btrfs deduplication ioctl to the vfs")
> in v4.5, but it *looks* like this behavior might have been in btrfs,
> before the ioctl was promoted to vfs.. not sure.
>
> We have fstests coverage for the "good" case of same size src/dst
> (generic/136), but I didn't find a test for the non-same size src/dst.
>
> In any case, vfs_dedupe_file_range_one() and ->remap_file_range()
> do not even have an interface to return the actual bytes_deduped,
> so I do not see how any of the REMAP_FILE_CAN_SHORTEN cases
> are valid, regardless of EOF.

Not sure about this, it looks to me that they are actually returning
the number of bytes deduped, but the value is not used, but maybe I'm
missing something.
Anyway I think there are valid cases when REMAP_FILE_CAN_SHORTEN makes sense.
For example if a source file content is a prefix of a destination file
content and we want to dedup the whole range of the source file
without REMAP_FILE_CAN_SHORTEN,
then the ioctl will only succeed when the end of the source file is at
the block boundary, otherwise it will just fail. This will render the
API very inconsistent.

Cheers,
Zbigniew
