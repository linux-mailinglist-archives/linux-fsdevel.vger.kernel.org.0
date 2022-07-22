Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD7057E2AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiGVN6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 09:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiGVN6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:58:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901148FD55;
        Fri, 22 Jul 2022 06:58:35 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MDwTuC016765
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 09:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658498311; bh=UGllnM1+v0SMLCV2Bs00x1y7zCVsfON5mZ1JEIRM1CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=a+LlJKGbyjxpQqu195g26HgoivBvVhSZbc39y931bM0urfYII1DqoW0HgzYltXjdn
         PPC5ZY6P1/qoFRKQfc8KaDMCdZ1SYpfGXYJmU/GgGA0B7Mg+A/R+oWE6w3bCQ9vWBc
         70eEy0rQNbUHik/6Glupz7KSLVPyPS+DcX3jIXy46BexbPc6Gu89U2k5XUJNOvTPPo
         qxUqhqB6Iutl4VYB8nNjj6BoDfOKN2zaH//c7QwJd0mZdNvlvEPesXbUM/lB6XzLuC
         AOhR1c9eQQbF2YHrNfdrlLf1FbGfBwcbsJQsM6q5Q8izJ4aLEDi7SoYFL1kDZtTMV/
         ysTtXe/EfW/QA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 768B115C3F06; Fri, 22 Jul 2022 09:58:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        riteshh@linux.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: Reflect mb_optimize_scan value in options file
Date:   Fri, 22 Jul 2022 09:58:20 -0400
Message-Id: <165849767595.303416.6878521506996536850.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220704054603.21462-1-ojaswin@linux.ibm.com>
References: <20220704054603.21462-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 4 Jul 2022 11:16:03 +0530, Ojaswin Mujoo wrote:
> Add support to display the mb_optimize_scan value in
> /proc/fs/ext4/<dev>/options file. The option is only
> displayed when the value is non default.
> 
> 

Applied, thanks!

[1/1] ext4: Reflect mb_optimize_scan value in options file
      commit: 961edf078b5606ce480ae2ebdac64ca829ea3f75

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
