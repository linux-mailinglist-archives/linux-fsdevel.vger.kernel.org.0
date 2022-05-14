Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEF2526F7A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 09:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiENC47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 22:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiENC4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 22:56:20 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31712D9E93;
        Fri, 13 May 2022 19:03:23 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24E23GDX027652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 22:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652493798; bh=sFmzqkIeci57u6nHHwJ3RZ6bKRyy3u2QpbbxnT80U28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mxx6yK9tTGz/EXWRPSsD9y1HlsrJLehKhvLirg43Gz6E75bazb57jOSow2szOuxqj
         vABckrFZbiAXiME0gNfco8F4hyWjrWQaddWm7oQxRux8XRq0Mu/oSJpoH+Yj3updeI
         CZnp+vVMLZzOuNdYXlTuNVJc257Tct9VOyLrxNM8Vc7UonNsaCNP9PBLmlZIwPw1jV
         icBu/0QCElbayJYzCoR0C4/q+/LvmgjqsUNlSlYR1s4cyeHXfQfjG2IsfJM6+FuT/Y
         MMY2SsoKHdpikJITrxEiHdSd2zoScFwnJWSj4/U/HstAzHBLY1NZ0Lrwqpb4XzfgzV
         8H3TWGRE1lpnA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 441E615C3F2A; Fri, 13 May 2022 22:03:16 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix journal_ioprio mount option handling
Date:   Fri, 13 May 2022 22:03:15 -0400
Message-Id: <165249378801.644521.15436473858156116983.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220418083545.45778-1-ojaswin@linux.ibm.com>
References: <20220418083545.45778-1-ojaswin@linux.ibm.com>
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

On Mon, 18 Apr 2022 14:05:45 +0530, Ojaswin Mujoo wrote:
> In __ext4_super() we always overwrote the user specified journal_ioprio
> value with a default value, expecting  parse_apply_sb_mount_options() to
> later correctly set ctx->journal_ioprio to the user specified value.
> However, if parse_apply_sb_mount_options() returned early because of
> empty sbi->es_s->s_mount_opts, the correct journal_ioprio value was
> never set.
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix journal_ioprio mount option handling
      commit: 8d7b9890b5d18a593b7c7e10d23513340919b837

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
