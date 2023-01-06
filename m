Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCEB6606FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 20:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjAFTRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 14:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjAFTRY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:17:24 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F801BC
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 11:17:23 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id m23-20020a4abc97000000b004bfe105c580so706817oop.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jan 2023 11:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPMCgZhfjIqLlZSt80mt/MRb1U8G1aCCF1CW+pU7nac=;
        b=KaiVt9rKM65zPESuFOVGS1v+/3JN6NVMPQQEUcXYqixO60rEYkxp051HpigqjR51l/
         nrO7HVdyQCS7CikIffgGj+uejriUtWp8T8DPnu2unjyioiDVZrCpA+4B51wPxk9S4Nbu
         pl/JIfvgcUDCpZQ1yj08gy4UNG9FfS7GsSyPcqjJMOmNdfFWksedDu1CmVZlHP4wHyvI
         XGCJKspb1aRKaISObbr5xsiSPCo0umh6PusOPUegj3zCSCCzsB9SXeTABxBOTbfjPZ0z
         uuJr4ngWlik6jHtmfl2iMQZ76eUa6EkkTsJXC5XT+3tXTNekm/a+8t4vuKKbEl5qW6fR
         Q2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPMCgZhfjIqLlZSt80mt/MRb1U8G1aCCF1CW+pU7nac=;
        b=QmDirAoqEzG9lbdF4XQesd4mHWc9NdljTfXe5LYC8G8tMoZN0ZmVsoUkqWWXIhBL8V
         PQ17Nxm5d9feva2XliJN5n8yDRyO7ElsckZhEoZz4lE/antu8HIW2psmd0WAAP1hSWWu
         r5h8zGdviCNYWMdUqete9BCJjA86gr+sNvRga+5JtaR3t/9f0htlhBVOkYNxXZQJTOLQ
         feBEjOLH3LH0vlaVgbqtRuzO1JYDTb0l4o3+3L89wRddq6zWiJ+aLu58K4/7OxlYfPKB
         6ryu/rH/uWd+1c83ME7j1mnvg2WE9O9+3My7sV3bucrjvl4MuMd2OQiWSg37Awxxfwod
         HN7w==
X-Gm-Message-State: AFqh2kq4x/TFw0a3oyVvb7KvfjZ8slMJxVSYhc1MxTxit7K5aIaUfZpq
        jNjfhWjg1BXvWmAC8cf8oD5A8cBrAFo05njfCGdprw==
X-Google-Smtp-Source: AMrXdXton316KXaX80FK7xrsgx50aENyoJnxyNzKnafl+WXc6mJJNK11EKPRNTMiM+exSjlm1hzBWw==
X-Received: by 2002:a4a:bd94:0:b0:49f:f3ef:33b3 with SMTP id k20-20020a4abd94000000b0049ff3ef33b3mr27165983oop.7.1673032642241;
        Fri, 06 Jan 2023 11:17:22 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id bb9-20020a056820160900b0049be9c3c15dsm775975oob.33.2023.01.06.11.17.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jan 2023 11:17:21 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: [LSF/MM/BPF BoF] Session for Zoned Storage 2023 
Message-Id: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
Date:   Fri, 6 Jan 2023 11:17:19 -0800
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        "Viacheslav A. Dubeyko" <viacheslav.dubeyko@bytedance.com>
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I would like to suggest to have ZNS related session again. I think we =
have a lot of to discuss.
As far as I can see, I have two topics for discussion. And I believe =
there are multiple other
topics too.

How everybody feels to have a room for ZNS related discussion?

Thanks,
Slava.=
