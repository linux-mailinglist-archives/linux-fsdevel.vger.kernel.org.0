Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52D16A63E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 00:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjB1XqY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 18:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1XqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:46:24 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5808637739
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 15:46:23 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536c02c9dfbso319670227b3.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 15:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677627982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h11ZoA0UQooK/pbR8vLZdRo2Kp8rymhd93Mvqhpe4Zw=;
        b=JWqBlrnTf6BrNp3TEKR0I9j2u4AKXhFtwBtZOSz3SS7yXUrHcIJ6tER9N7Cw3Ti59G
         9VrOv1cA/szGdIMZUWGPLPvX0VCStU6Lp6Zut+khEcLwzIAHSl65W6wZj15NI4NQt5YH
         oRuqPZQr3LQFKFR16w4Y6ZgRb8ZLVjMmHpyA2TXyiRk1bUNWBQ6/Re+g4big+8IsJNE4
         8QRtZ1SHAt5+YWzjVSeaYAnzWZFD4dXv1taBHM7xFmRDVhFfJ9rA0pFQUHHr7olErpHx
         MxvUZLkwDIykO3UCzAE6loi7k0/FtbR1Z488wGRiJcvIc7Zu8Ew9Wcqw1Al+1MFaFL8w
         2ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677627982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h11ZoA0UQooK/pbR8vLZdRo2Kp8rymhd93Mvqhpe4Zw=;
        b=fxU+a337lFGd8GUGCvGyhe9UGdmOFGkreU8uQO0pPb21IqUbyeVYdjBd2mBMuxi8C/
         JCYwljbiQHdcWSwF9+K2Rt9ed4nIfh1aA3E/jKyvl/l/e/vo2TXquEC0IXpFYiXU/+r4
         0T59x6IlJutj+AmaIr/YnGRtS0Zl95hioc0KijVr9FNw7N6SBYWUUQ0SoZ20TMmIKxCh
         6PWKQMktgfVvZvlh6XOwFqEvz7eOMx8VlcAZ2FuOh7SlAh5zatHAU1UVx4adrrExF1Ne
         /JFVolXP1UvQIqk28a5Ov0tbgXc1RBXzgzk5IZ4AtY/H8XnRkCRE920wx6yC4HZtVMbN
         yZUw==
X-Gm-Message-State: AO0yUKXUj/mmy6GIxjH/W+nNm5IbwPAUMhmJrEKVRxSg4IR3dXEifFiY
        LIr8A20iHcgYz6QWRkVhMHrseQZS4hMrQT3RtlWIN8cZAgw=
X-Google-Smtp-Source: AK7set/IToCZVVKo679DUhuJyrtdi32tFo+2x4C7yV3jZ+lvbkYWJOaU2ESKfUBPqpShjlIMWVbmmPNNXNpUP6afq3g=
X-Received: by 2002:a05:6902:140c:b0:88a:f2f:d004 with SMTP id
 z12-20020a056902140c00b0088a0f2fd004mr4288672ybu.5.1677627982415; Tue, 28 Feb
 2023 15:46:22 -0800 (PST)
MIME-Version: 1.0
From:   Leah Rumancik <leah.rumancik@gmail.com>
Date:   Tue, 28 Feb 2023 15:46:11 -0800
Message-ID: <CACzhbgSZUCn-az1e9uCh0+AO314+yq6MJTTbFt0Hj8SGCiaWjw@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Filesystem backporting to stable
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current standard for backporting to stable is rather ad hoc. Not
everyone will cc stable on bug fixes, and even if they do, if the
patch does not apply cleanly to the stable branches, it often gets
dropped if no one notices or cares enough to do the backporting.

Historically, the XFS community has avoided backports via cc=E2=80=99ing
stable and via AUTOSEL due to concerns of accidentally introducing new
bugs to the stable branches. However, over the last year, XFS has
developed a new strategy for managing stable backports. A =E2=80=9Cstable
maintainer=E2=80=9D role has been created for each stable branch to identif=
y,
apply, and test potential backports before they are sent to the stable
mailing list. This provides better monitoring of the stable branches
which reduces the risk of introducing new bugs to stable and lessens
the possibility of bug fixes getting dropped on their way to stable.
XFS has benefited from this new backporting procedure and perhaps
other filesystems would as well.

- Leah
