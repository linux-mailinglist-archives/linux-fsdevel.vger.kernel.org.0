Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D873452343C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 15:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244065AbiEKN2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 09:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbiEKN0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 09:26:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D51BE0E;
        Wed, 11 May 2022 06:26:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24BDPv53007361
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 09:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652275559; bh=abbENq8IYOkc31p6pnrCQWyxwIO3BZIyZtmCWB5OPRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HeH4aOpTDpaJiWJvLNgGACAFXgFVu5qorYBNh/xr8wtCmvHqVqhBquLL3LlALBk5C
         er0AFygPA4IIq1YmJiaFdJVwIm9d5Tn9o8cU9NAQaPXheZtPf0Hnqnu0oS4ZmxLzXj
         u1mVEZdjxQer8QVYo6+IjvnJxIkrqUP6MAW4cCCVLdOI8JPwuVops76ZeSdlo/PKDL
         x9/vlSOQiA1H8gjIWX9ozXcm8orry08eGpYpOR9O93Kz6KrK8O0ZQwdzZ1NOidFokd
         SRqUFlb9niC/ii3zzbZ8SZBmV3XooiqXjTMtvut+q9b+m1Ijh1QLJpzj2kaSAf8YSh
         Hr5oYa0oXvj6Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B043E15C3F0C; Wed, 11 May 2022 09:25:57 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: Get rid of unused DEFAULT_MB_OPTIMIZE_SCAN
Date:   Wed, 11 May 2022 09:25:55 -0400
Message-Id: <165227553566.382666.7632158616841910185.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220315114454.104182-1-ojaswin@linux.ibm.com>
References: <20220315114454.104182-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Mar 2022 17:14:54 +0530, Ojaswin Mujoo wrote:
> After recent changes to the mb_optimize_scan mount option
> the DEFAULT_MB_OPTIMIZE_SCAN is no longer needed so get
> rid of it.
> 
> 

Applied, thanks!

[1/1] ext4: Get rid of unused DEFAULT_MB_OPTIMIZE_SCAN
      commit: 7e0d0d44001506bc42932b5e37baaab84f0397cf

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
