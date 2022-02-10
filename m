Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444FD4B1666
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 20:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbiBJTem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 14:34:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243590AbiBJTek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:34:40 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A6FD62
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 11:34:41 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id j12so6531225qtr.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 11:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=Nkl51yYf/EKhGstFPpzBrtWqnV5GN775dSpin1RK3UE=;
        b=WNY5d5ME1mlUXyTWD6sK18mEZKD+vsTIMpBeQSFlhk8Fvo+Am7EqNZpVWhkd/Pu4pc
         tRK3y66AjiVZSit/4HAFgM5IDZZVLnxngOJHbYxygMNYSXmhsbI5LEts+LrrY1E0Lp1K
         93vshHkvHYlnogalgr2VymZvuIAINY0APwV2lL98gLjSjPgQdUQKmSNg3uRXwwTu0j8R
         rHBt88/5vQyyanJwD4fKUwGPk9J3kaHQUobuUtyXouqCOjb1vlb4qiqZiahZmYIFEvnM
         OdaA7cPKxgmgYLCdGjNaN2ZJlsBkUqZ2T8gOnn3vRuDFbQVidACAN5Xb93uOKeS4gu/W
         Ad7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=Nkl51yYf/EKhGstFPpzBrtWqnV5GN775dSpin1RK3UE=;
        b=rRrdgPpR7j4VcnL20rviGRwA43lvNY6YWn7TCA8hs8Y990PvjsoeXdUMx4i5Gecx68
         HxAmOYdZ+SQYeWo/IAb5KBi4SdxK0o+h45pHTHO521hZSoChJKEW2VU+mCaRRa5Z1Xep
         ylLSXSwGR8o9fONGcc7vjsmYlhwYNUaNIXTRltE8alMn/owEeiCsx90kgvpq7SBfrxy5
         X1urqH+z0FW22f+J6vOpD16IQMTUI4A6J3PuPPYoyImTdbIQ1g+gRT3CZVZ1Zlvh8LCo
         9yiv1nj/3hbGFkh0LcIGbrcmrGpelHLfwenzWwcnq584UoFrM/e/MK1pb7dyJOTuaLOC
         TPSQ==
X-Gm-Message-State: AOAM531klB4aBuBkqy3WVDDYKK+SxFPWpNo6H/TZk2N4ES6zk/XZ3+Hr
        Qnp3OelMvlztFPp1k+LIO4Bu1A==
X-Google-Smtp-Source: ABdhPJxCaQNdrxnnNrnO3nmn9K0NNHI1oDAUnu+Zc0f4BAcJ0cTVFx+DqI3jPR33HCdZlO4WMvqsyw==
X-Received: by 2002:ac8:5896:: with SMTP id t22mr6043234qta.613.1644521680580;
        Thu, 10 Feb 2022 11:34:40 -0800 (PST)
Received: from smtpclient.apple ([2600:1700:42f0:6600:cd8a:8634:7b18:da1e])
        by smtp.gmail.com with ESMTPSA id n19sm1503518qtk.66.2022.02.10.11.34.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Feb 2022 11:34:40 -0800 (PST)
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: [LSF/MM/BPF TOPIC] File system synthesis inside of computational
 storage
Message-Id: <A7928480-2F5C-4BCD-B8E8-62E2AA5FCD8A@bytedance.com>
Date:   Thu, 10 Feb 2022 11:34:38 -0800
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Cong Wang <cong.wang@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
To:     lsf-pc@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Computational storage creates the way to offload as user data as =
metadata processing into storage space. So, I would like to discuss the =
feasibility of building a storage device that is capable of synthesizing =
a file system by itself.

First of all, it is well known that designing and implementing a file =
system architecture is a very time-consuming and difficult process. Also =
this process includes a significant amount of debugging and bug fix =
efforts. But real life and evolving technologies require much faster =
data processing. So, file system technologies cannot satisfy the =
challenges of real life very frequently. Generally speaking, if =
computational storage is capable of designing and evolving file system =
architecture under I/O load then it could be a very interesting =
solution.

Any machine learning approach is based on training by input data. So, =
I/O requests can be such training data. It is possible to imagine a ML =
engine inside of computational storage that can analyze the requests to =
store and to retrieve the data and to build the file system=E2=80=99s =
metadata structures on the fly. Generally speaking, computational =
storage can implement a file system architecture inside of a storage =
device without any preliminary development of a file system driver.

Initially, the ML engine inside of computational storage could be =
equipped with the initial set of metadata structure primitives (array, =
queue, bitmap, tree). By receiving I/O requests, ML engine can use at =
first the simplest metadata structures and to gather the =
modification/access statistics. For example, initially, it is possible =
to use a simple array of extents to account file=E2=80=99s content =
location. Then, with a growing amount of statistics, ML engine can =
synthesize more sophisticated and efficient metadata structures and =
start to use, for example, a tree that consumes existing arrays as =
tree=E2=80=99s nodes. As a result, a file system can be constructed by =
an ML engine taking into account the peculiarities of files=E2=80=99 =
lifetime and workload.

Any opinions related to this crazy idea?

Thanks,
Slava.

