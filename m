Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B91F660156
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 14:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjAFNei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 08:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjAFNeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:34:24 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D8C4167D
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 05:34:23 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so1978989lfv.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jan 2023 05:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cJHSClaSNSC6CADWeDtciJpzEgHDP3Cx3FDxh15jpg=;
        b=IScHOh10i5C8L5k0c1dA8+EkISFY9PKI2OpLYfIPDsa9+z7hmwIee+/WSWG/z5XTOZ
         rI2eM2jr6fFtVUI9IbBIUGccEjNspUHo8K7jbi6HaAAXEBFuzziA/xekfQINLBWbGh7X
         of+ioSs3P19CFk+kuSvRSH4jHvaQGU007RPYJQL6d7APizs4nOpwlwiOOlju6WDIMShR
         bgXdc4IVCfge4ILGrIj2KzSE4ZIRU30VD1zvQQQBzvOGSo5TjlJCtZMvAgVgwNw+lFi3
         YZYYQBx/6y1sx/YDy0Q9/3ypad7LK8Y0Asic6PWTjCEcsI+pif2sXi2+dT7NP6Bb75OB
         34bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cJHSClaSNSC6CADWeDtciJpzEgHDP3Cx3FDxh15jpg=;
        b=McvfuA7tpuu7EgibWSVirroJICnXmp17IaFlXnuSCuXVmWqfw5cf7qtj7sG2CrTvpE
         ptibmRC0ze9ZW2s8qGE5Rmx7f6sxg7W6bAM0eBv+CEtt/YRpR3cObrmFFiddI7xcFlze
         fgIq3i5XJKHl83gesVXtcVaVV2psq6C6cSoVNqIIfgdeeVyKuwBzfWkWB/Ph7jANvc7j
         XzAnsN3SHFCuRvo5H6VFyBYHEF56WyGZGvHjenhyxwVbYranfWQfRxJl93A4Jcf6ErU6
         7YiHk4MPC0qKYYCtUTePoyRKobtSk3U7BDlsXjo1oEDPYTquUjN4JblQZLh4zH4u7fhT
         FIeQ==
X-Gm-Message-State: AFqh2kqPcDJsJTDgeQ46UZUi9eBPQbCdw487Qm/73h+EtFX4uEWyozTs
        jHxuS4OlE66VisChXaYYmbJbi0+PiITewf04hforgPeUv7M=
X-Google-Smtp-Source: AMrXdXtKaUUuYgnPYWfF9SYOq1rP1PUr2BCte7j8ySIBjmmHVsO+gyfeS/NZY+zZ/fL/JJLWzixvJ9Qd/U3+PZd6U1s=
X-Received: by 2002:a17:906:7c53:b0:7c1:639:6b44 with SMTP id
 g19-20020a1709067c5300b007c106396b44mr7022140ejp.200.1673011641729; Fri, 06
 Jan 2023 05:27:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:9c06:b0:84c:83fa:e436 with HTTP; Fri, 6 Jan 2023
 05:27:20 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <joykekeli3@gmail.com>
Date:   Fri, 6 Jan 2023 13:27:20 +0000
Message-ID: <CAKaeHTfQ5pyr8quqvsMujnETkO=FAcONmzbh4itZzNr4t=Fs_Q@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Best Regard,Mr.Abraham.
