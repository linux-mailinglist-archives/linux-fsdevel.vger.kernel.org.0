Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBA9659616
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 09:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiL3IIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 03:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbiL3IIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:08:46 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BA012D15
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 00:08:43 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-482363a1232so134486627b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 00:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MkWenUBEKit5EicAMnK3zGvAGNsX3uoJJOelu4sUgaI=;
        b=DAEyHcSLRBNuD9dJ0KiSp+4vePWkRHx57/M28IAtk7qP6HsuOaAUczG6+WDwQb8+re
         zRgG0AbHHFUrqFaBqHMhq45bJIrjXE4KL6f07iFyvJkJjyGnzMp7AvDIJUQy/wtWzMu6
         kyio6aN00QwlEtqpeyvaGxhYi3J7/pa8c1ljRkDruG8Zhzcwicvp9W7F5wqUhNaSHnNF
         cpNhbvhvW/z7fAVq2FpzJSJd/UC5rw51OLD9U1c3dikDFhYj7GL+H3vGkq5txFMnQ+Yb
         VSllZx4ctHY9mABlPuXzottxjNE1sa3G9qA85GPR9c1+ZCOuM5gkPPiNJZ4TafOga4sq
         93kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MkWenUBEKit5EicAMnK3zGvAGNsX3uoJJOelu4sUgaI=;
        b=vrixDeVw93qxE39UnExX5KR+6oPDolYNK/7/qhzXEQ8BljAZV+8IxSEak+LILavwrF
         IaUQbwGkbT6Uj+7TnL2AC54Gab65bXvJxHPw9cKORImF9SRBEs2rFwmJ41KTXGZ/OMpd
         zQfh7Wq2Qfj7SQc5PCrKTaxG3hZxM2+A3F3p8Uyh+gSnm15AAfAhFiLYVWi2i2gIFnOH
         vRxgSwFW82VQtZyNdM8P3KKAz6rBVJcW5mEgFAnMwZNdanxhKmXm6Tb3GGo8XqrLOb6e
         QxG2Yy044RphjUrs8M8mNMUwVN0M1h1w1FsONHkfXTfu2Kz7oi0SshrNe1k29jLoK4Nt
         LGiw==
X-Gm-Message-State: AFqh2koSqijkyY50WI2y/CjYX9fFlwzxFFQIZ13GmMdocoo7hoyPBo9j
        rgSS9IfNnsUOEQFDhyccJ9uKYn4I6/ObxcfbpTOpxHIJTJw=
X-Google-Smtp-Source: AMrXdXvAxZgZyXV41B1+VID2WVC1XSvszmYEtpy4WY5MQejvRg+1dbAOHL4hQqfBl0PTQnuB+VG5oCYMLh0Iv3DxdB4=
X-Received: by 2002:a0d:eb49:0:b0:3ec:2e89:409c with SMTP id
 u70-20020a0deb49000000b003ec2e89409cmr3914321ywe.20.1672387722693; Fri, 30
 Dec 2022 00:08:42 -0800 (PST)
MIME-Version: 1.0
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Fri, 30 Dec 2022 17:08:31 +0900
Message-ID: <CAM7-yPQOZx85f3KxKO1feSPcwYTZGRNNVEgqn4D_+nhhXvqQzQ@mail.gmail.com>
Subject: [Question] Unlinking original file of bind mounted file.
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

Hello fs-devel folks,

I have a few questions about below situation's handling.

======================================================
1. mount --bind {somefile} {target}
2. rm -f {somefile}
=======================================================

when it happens, the step (2)'s operation is working -- it removes.
But, the inode of {somefile} is live with i_nlink = 0 with an orphan
state of ext4_inode_info in ext4-fs.

IIUC, because ext4-inode-entry is removed in the disk via ext4_unlink,
and it seems possible
the inode_entry which is freed by unlink in step(2) will be used again
when a new file is created.

Suggest new created file which recycled the inode_entry unlinked by step(2).
and bind mounted-file is live.
In that situation, it seems that  via bind mount-file, it can
manipulate the data of the newly created file and access it
arbitrarily.

I don't know if it's right  to allow access to the removed file via
binded-file and it's the spec of filesystems or designed action by
ext4 filesystem only.

Thanks.

-- 
Best regards,
Levi
