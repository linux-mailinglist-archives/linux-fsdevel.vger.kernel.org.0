Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471E16CC923
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjC1RWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjC1RWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:22:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADECD327
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:22:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q102so11539333pjq.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680024126;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GVxFN87at+wjwykAh1QULFWwJDd6CZuS01Xk07klLz4=;
        b=frO0Pjy04AXuHspnXo910Brbf/qhGfFerXrz+0CfBDayFgveIrTFG5oHhZ4vu6BNOV
         QFm7seX17Zy+HkjdUrMRUbRlsgYF96E1U6sGOWatI6nn5OTxJFAYtQDCctLqVTFyKpUO
         lzUAxCNpZnc62gD91aiaCrsI33PCN2Y8qSTo92kRiQfp7HIv2v3aHHCD1bStPoyNmrwu
         bRHls5Ow5AYist+2nT8ZhOpfWgAtSSrw/CYQ9IjPjd6sfyoZcijIIJdVoy9scdV89gCv
         MTot5DQ74CCZJ+Oz26n3tnJCH+1eSUD+hgHKYFcINKEQ4tFlTu+uB02tifYsaTCRTm+2
         iD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024126;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVxFN87at+wjwykAh1QULFWwJDd6CZuS01Xk07klLz4=;
        b=7U2KixThNdVpLyAXK1Dc1ttqP0byNtONTJBx56WQwbTC4GbF19pac8bGfZGMT4LvNv
         gWn3js9jbx1y4A6Arxph/MoL7e/ucikfy3cMuf5slP4HpfZzAgXhyGVz52epU8d+SfVn
         RtsDINS4UTwpvm8tO1w9dPqhXFV23ZkwIJMBQPXzy7BqZhYk0m7R26Zr5mEiWA93TQeJ
         OXv/b90NVdL9hKUvSoX5SsR1yRhe1xEtj0X2YHxQM2L1MrGnAGMRdP3+7nJer9L1dYO4
         +dHsp2HJhbz277wCzSDjhZStoipdQZRZPDm1yhAEZeh11FzxBQ4yl7Cl14fWITjGkYaM
         HCNQ==
X-Gm-Message-State: AAQBX9fmmCcYP62hGESUCBMKNex+c/ygbutOUmEqWQnx0fJz5DeKFz+E
        0p2K8WlXZ6P7OtHX/i88QF/3RpG0rDZA1re6wlc=
X-Google-Smtp-Source: AKy350Yd19UGfSHqtygWDll/c+el9njBUS+PaXWmwqtiC5lHfNy0079gQbeI7/UoL/1jlIOUoqXm+CaczPHdShISUjs=
X-Received: by 2002:a17:903:555:b0:1a0:440e:ecf9 with SMTP id
 jo21-20020a170903055500b001a0440eecf9mr5608189plb.5.1680024126317; Tue, 28
 Mar 2023 10:22:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:a89a:b0:d4:b3f3:95e0 with HTTP; Tue, 28 Mar 2023
 10:22:05 -0700 (PDT)
From:   =?UTF-8?B?4oC8?= <merdaille1010@gmail.com>
Date:   Tue, 28 Mar 2023 17:22:05 +0000
Message-ID: <CA+5sztMKGAYobp27nYnr4Nvd7x=M1LHp1c7g0H9KNEA48B+F6w@mail.gmail.com>
Subject: Message de [toddwilliams207@yahoo.fr] !
To:     linton <linton@marktwain.rad.sgi.com>,
        linus biland <linus.biland@bluewin.ch>,
        linux fsdevel <linux-fsdevel@vger.kernel.org>,
        lin ccp <lin_ccp@yahoo.com>,
        lionqueenhn <lionqueenhn@yahoo.com>, lionrat <lionrat@aol.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SHORT_SHORTNER,SPF_HELO_NONE,
        SPF_PASS,SUSPICIOUS_RECIPS,TONOM_EQ_TOLOC_SHRT_SHRTNER autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Salut ami!

[toddwilliams207@yahoo.fr]:Vraiment un rem=C3=A8de simple ici
https://00qx0.app.link/jL809pYawyb





Tout bien, toujourstoddwilliams207@yahoo.fr
