Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432844FB57F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 10:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbiDKIDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 04:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbiDKIDM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:03:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904DFDE8
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 01:00:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 50A5121112;
        Mon, 11 Apr 2022 08:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649664058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=cqLV4bA6Tc6vYY1vLp7NI3y74qVVN17/v8Aqcs0xfko=;
        b=BKWs+2YG9Lig40b01F3njgdBF/sosfmj9BhgpNpe1cSv5y4r4EHFKfBmiW7hnvFnLeNQX/
        DdEOUGBtSPR3cM0vuUdQhCrRW8wyg5k3jvuZS+fKWR2dTfd4ZFcJglmo+uhy6J9CXwFSG2
        Eg1sjbKR7XJy//UFg4Qr/R66OMID5eI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649664058;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=cqLV4bA6Tc6vYY1vLp7NI3y74qVVN17/v8Aqcs0xfko=;
        b=FKS+HPpwWRjAoYDibz+wy60xuyRGaGkQfha5I6ep59Vs57Ap9gzoMtLy040GzcRNbqq1p/
        K0lzvf1kDRGeXcBQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4303FA3B83;
        Mon, 11 Apr 2022 08:00:58 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D6992A061B; Mon, 11 Apr 2022 10:00:57 +0200 (CEST)
Date:   Mon, 11 Apr 2022 10:00:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     contact@archlinuxarm.org
Cc:     linux-fsdevel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Reiserfs deprecation
Message-ID: <20220411080057.wehpxhckqq3247fq@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[resending, fixed up archlinux address]

Hello,

I'm not sure if this is the right address to contact, please redirect me if
not. Pavel Machek has notified me he's recently seen an ArchLinux ARM
distro on PinePhone using reiserfs. Reiserfs is unmaintained filesystem for
quite a few years and thus it is not a good idea to put user data on it
(the chances it will loose data or crash the kernel are growing). Because of
the lack of maintenance we plan to actually remove it from the kernel in a
few years. I wanted to warn you early so that you have enough time to plan
how to stop using reiserfs and migrate to another filesystem...

                                                                Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
