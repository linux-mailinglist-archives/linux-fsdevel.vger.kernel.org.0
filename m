Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF8782706
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 12:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjHUKYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 06:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjHUKYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:24:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D5710F
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 03:24:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so4755136e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692613453; x=1693218253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JWv+yavI21hdsA2de00od+06jOmtpq7dA1Gt2U3Tmd4=;
        b=Bl2ipkAGcmqDcfVSVsy7Pp3HD0/J072C2FIgVM/8QDsULWGsugbFxywMsoKFWvEsI9
         qoU24aH/aNwrOG7T/O3X3fHX7kdeilDXCErcXHkmcDmesJ37cWlx9fWd8KDtkCMpZMD9
         t+4vTlb51DzisD58O2eAXK0R7vm8N4ktVpIzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692613453; x=1693218253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWv+yavI21hdsA2de00od+06jOmtpq7dA1Gt2U3Tmd4=;
        b=kg3/ck/g5F9BvPOSbDF51UIlKC4W9IMwI8Sf4G8rymL2TuzOVxY9uNXOvBShbXuKOX
         xKtSVRPYGaQ7bs8NbZLfytJFEq8++JYCu1KQSOqBhZw7pt7PEt5Ulcu8qyc3qY0Y7Bzk
         qPTdeafVhMdjzU1zYHN51QhYS6P1+I9uE+q507l8vyHNuNU6eY26qFy0XZj8YC9CROZF
         5XYjSdVoc6l4pS+eJYz4u3YQ7mOu2WLrcpImqAHCLxl+fMnvsVHglXeA1lAKbW9SoonX
         UydfnN3G9Wf6Aws/5CWhmO1iwkPtF643Qrp4v2uSfiB/kcf/xoShS5q5OsdSDW9m5TjT
         rPtA==
X-Gm-Message-State: AOJu0YyeiySO5T7Q2NPvC9w/ssxG6JIVWU5HTBdjJTHH8q9YAOe5Q7qn
        P7KPKDZKy0fpUn9w4+KiS4cOe9alg88pk842oTcJXw==
X-Google-Smtp-Source: AGHT+IE+mwwGj+mBMcFDaSMSAuehg+IW9Lcs9ljpWmTtT7EBLkeGsjqhyBjmwFaP4ISNECXfDcDcoUo3XCYByc89cfU=
X-Received: by 2002:ac2:4c92:0:b0:4f4:dbcc:54da with SMTP id
 d18-20020ac24c92000000b004f4dbcc54damr3439503lfl.27.1692613452642; Mon, 21
 Aug 2023 03:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230817022453.99043-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230817022453.99043-1-jiapeng.chong@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Aug 2023 12:24:01 +0200
Message-ID: <CAJfpegsN0HNBALcHNatFq9-21vyiP6k91gbdLTd_e_HhKxQqqg@mail.gmail.com>
Subject: Re: [PATCH] fuse: make fuse_valid_size static
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 17 Aug 2023 at 04:25, Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The fuse_valid_size are not used outside the file dir.c, so the
> modification is defined as static.

Thanks, folded.

Miklos
