Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61E16A4F93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 00:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjB0XNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 18:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjB0XNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:13:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F17BDDA
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 15:13:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bv17so7911329wrb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 15:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJgi4IboWDAeEB/+pYFtMZQnVuI8I/vNjiJArKeJCpg=;
        b=fLMrL7BhFmzvZE38KZfkQpFgQLaJY681zzslH7qtjAPSVLR7jPRTyEFaOfJ+Q2Whfm
         L5oAQ04AaWLilq/JnqPsgPI3kspckLkvGyEkKVtfjyKcfAjCnC5Qmz/wZnQ2WAOdFqNE
         qs2VVQk1F6xuvgQsuJkV6qzKABFf0NxYMSsAOj1AmJFREVw/i5G/kAnQXXwBE8k8Z7l5
         scemQRGPjNnT66NWwH2nYhrVc33t1gvgGu1B5mpvU4U61chFMUWnYvyvmsvhcCdvfF/2
         +NgShAfTm0sCT7wC3NqRsXu4TFZGcr8JtEipWmqeOA7XeUci4vf1uwn2ZQLFHPG+CsM5
         NENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJgi4IboWDAeEB/+pYFtMZQnVuI8I/vNjiJArKeJCpg=;
        b=7QmdwAx1qRAOuEsjfuDnwkTurJhkQtu7yCSa0RRrL2oAQhCInCU4HUjtx1Y211CvYA
         SaoI+aLfrCJmuF9jQqsXX7GRjozguYld5SkAmsAQZL6dtSyOfBHzz6d+l2tlGhJUyAnM
         +5i0JXi2CMbluG93ogddrPOW8AqiEAXTca7eRXUDzf6efn0NExF9Gn00pvfSzWUfcjgV
         uPIRzi9MGNT2o2Ib08kGI+hEOvlHpRDQqVMzOJhGIX4Zn9Y0IDY3ZM1LNal/+nY+fmMi
         SzloC7jB+pEu4/GhwMcewC0TFWCxVdH+cRe8UqYbDhIfx8/RbPyc8uipsB7kBstvmIZH
         ptqQ==
X-Gm-Message-State: AO0yUKWmGLVyeyw5UP/PvvdwaWdbrmWvXCUNneGaea27nBizZmrTbOGv
        hFdu93AIrsef91boXd7TOekCsGZT9IyS1vMaLZ0=
X-Google-Smtp-Source: AK7set8mxBKZ/grkn/tjz3ozBfd7zbd5al14FvASLZIC8HWQ7Uso2iV5HUgWmbT5oqq+V8b5c7XQydvZ0lV2uTAbwXA=
X-Received: by 2002:a5d:5141:0:b0:2c9:2917:4e2b with SMTP id
 u1-20020a5d5141000000b002c929174e2bmr176786wrt.1.1677539579719; Mon, 27 Feb
 2023 15:12:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:1009:0:0:0:0 with HTTP; Mon, 27 Feb 2023 15:12:59
 -0800 (PST)
Reply-To: Advocate@tptlegalfirm.com
From:   Larry Aaron Riteman <denzegreg7@gmail.com>
Date:   Mon, 27 Feb 2023 23:12:59 +0000
Message-ID: <CAM68aUF5zRnnriieS5e-a67Rb2zbEm=Ch5KcdJQtdRTX3jtYWQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello.

This is my second message to you regarding the estate of your late
relative. Please contact me via my email ASAP, for more details.

Regards,

Larry.
