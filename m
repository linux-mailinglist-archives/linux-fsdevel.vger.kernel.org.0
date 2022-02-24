Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5E94C2810
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 10:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiBXJ2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 04:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiBXJ2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:28:41 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0B922A24C
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 01:28:11 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id e140so2556789ybh.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 01:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ygp7HmSMQP3Q+rbTx5g2DkVDCEdl+SFVfMjp/BmaoiI=;
        b=cepL0hdCN9UbyCzkOyV9cQEdxhgUijKh9zmmcDO5ikU473yp2AMOZcJXilqLRa0sFX
         zfJ9F6q5gR/6iBDSs/MWKl5HIY9yjtZF5m5sa1Ox3N3Gu4/ncdRBYcD3fvzUBnuQqtrM
         nAUWwm6kL8VdrogYpBrNw18wLKWFmZd6DDEvOI6D4H+mHJGqcA8phVZheJzRPgN7lv64
         eRe0E1LIuKHztxG7hg2oe7Qf66pC89aNTF/Ig8zlbtlXZZhzOOy4WbazNK2qNpt4Zstb
         gznQQkwisI3iIEeReJZnQLwDvvvJDXee/MNMui+50vNhX2zNwhqzm+l5ZvFAoJxzA9Pw
         B3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ygp7HmSMQP3Q+rbTx5g2DkVDCEdl+SFVfMjp/BmaoiI=;
        b=ayEoQhpojgZMxipNYlPYoHDpF3ZCl+wxLKSzFRx8IG6stbLbsGqTN59vPgJj4g27x4
         OjeYbcEHWLldYWey4s5/DpzA6z4ZbVUN8F5Px2ml+a249zsaIU3mD445hS3y7lbTXXtA
         cgHU6AiAiYpdX7BKGSLDJHniNsqk799m9XeJCVrRZFKXQIOAk9EkzCAxjQvujjTekT96
         Hawdstf1SdGbDR47b7KU5WGyS23hBazboaoXtzB9XCNT+UsFeCDU5mZ0ngqHeHc5+tvx
         69ws9nQqNZ7uuZH56oyJSSS0jAXmtZAVFyRODi4+ZxCF1B3vKq39CQIHBpteyiKMpgco
         x9aw==
X-Gm-Message-State: AOAM532v41SkvzpPFO3AAcz2HhKe1YAjd/TFTHjaIG9vAKXxafMyDqkW
        rEL3QYw7lCj3dL2TE/JG5ksj5PD5ze3UyWvxJaCSuw==
X-Google-Smtp-Source: ABdhPJxscph16DkI7QPkYWvFXGKPAB18KesE5yybvpBkL5Qinq23VhWYa9sR4nWUBegylDrScVJnGI8fPsI6IwGs7nc=
X-Received: by 2002:a25:6993:0:b0:624:55af:336c with SMTP id
 e141-20020a256993000000b0062455af336cmr1603707ybc.412.1645694890926; Thu, 24
 Feb 2022 01:28:10 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 24 Feb 2022 14:57:59 +0530
Message-ID: <CA+G9fYs_8ww=Mi4o4XXjQxL2XJiTiAUbMd1WF08zL+FoiA7GRw@mail.gmail.com>
Subject: [next] LTP: readahead02.c:295: TFAIL: readahead failed to save any I/O
To:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Linux next 20220222 tag LTP syscalls test case readahead02 failed.
Please find detail test output on below link [1]

test failed log:
--------------------
readahead02.c:181: TPASS: offset is still at 0 as expected
readahead02.c:285: TINFO: read_testfile(0) took: 37567 usec
readahead02.c:286: TINFO: read_testfile(1) took: 37263 usec
readahead02.c:288: TINFO: read_testfile(0) read: 0 bytes
readahead02.c:290: TINFO: read_testfile(1) read: 0 bytes
readahead02.c:295: TFAIL: readahead failed to save any I/O

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/4607403#L16941
