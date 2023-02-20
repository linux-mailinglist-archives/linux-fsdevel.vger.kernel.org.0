Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4922569CA7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 13:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjBTMHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 07:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjBTMHo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:07:44 -0500
X-Greylist: delayed 1305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 04:07:44 PST
Received: from smtpq2.tb.mail.iss.as9143.net (smtpq2.tb.mail.iss.as9143.net [212.54.42.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4F216305
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 04:07:44 -0800 (PST)
Received: from [212.54.42.107] (helo=smtp3.tb.mail.iss.as9143.net)
        by smtpq2.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <me@rubin55.org>)
        id 1pU4cH-0003UO-Rd
        for linux-fsdevel@vger.kernel.org; Mon, 20 Feb 2023 12:45:57 +0100
Received: from edge.raaf.local ([83.87.71.29])
        by smtp3.tb.mail.iss.as9143.net with ESMTP
        id U4cHplyR1PuCLU4cHp4NLW; Mon, 20 Feb 2023 12:45:57 +0100
X-Env-Mailfrom: me@rubin55.org
X-Env-Rcptto: linux-fsdevel@vger.kernel.org
X-SourceIP: 83.87.71.29
X-CNFS-Analysis: v=2.4 cv=Ybd7pSdf c=1 sm=1 tr=0 ts=63f35d75 cx=a_exe
 a=55+TWXFlYidg0d0YyPQsNg==:117 a=55+TWXFlYidg0d0YyPQsNg==:17
 a=m04uMKEZRckA:10 a=xmC3PgOMfwqtXtabtDsA:9
Received: from ORION.raaf.local (orion.raaf.local [172.17.1.14])
        by edge.raaf.local (8.16.1/8.16.1) with ESMTP id 31KBjqMD045980;
        Mon, 20 Feb 2023 12:45:52 +0100 (CET)
        (envelope-from me@rubin55.org)
From:   me@rubin55.org
To:     stefan.tibus@gmx.de
Cc:     adilger@dilger.ca, dave.kleikamp@oracle.com, harald@skogtun.org,
        hch@infradead.org, jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Jfs-discussion] Should we orphan JFS?
Date:   Mon, 20 Feb 2023 12:45:52 +0100
Message-Id: <20230220114552.27395-1-me@rubin55.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230119080532.crn7wzo4jz5x5ng3@tibus.st>
References: <20230119080532.crn7wzo4jz5x5ng3@tibus.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDGZ5ZKUvvAAa5LudPpQHQ95+oC0++yU9Fvyn4sk11teR8k5U7roAOqjFugDnQaXYezuvyl99hdeIaiId65AW5f7W+6KmRjqjGb7DttvqP1Zag1ujXHS
 F6ZOZpnBuzq2J7NcV6ag8O/55P3rISBNZq8YJahtYRxeVZKj6Z11dv7NAY3UKwMD/hkvMrAJeaw1W6YtQzYva/M7zfpaoLCLta2NsDNA1bjeeDu31PcRGMZ3
 Ys6zSdAWR8DQ16Bqnc8pDeFtTyuH3TO3aQxGGBn9ygJqHTtyvLCpA5lIfeElKUwk011zwLuLnwZIj0rKMkslOYC1wki8/Og7siwYAJt9rR6UBziJ52HgfCyN
 evY2iWBknZ4YhV66/52BmV+wa7T24t05kOOMY7gWJTkpDbmvpS7aIz6kXC/5q+AvycL8C/GmRBbjexmRDLICNxcbh69fXQ==
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I would also like to chime in as a long time (20+ years?) user of JFS.

I use JFS for essentially all my Linux boxes, laptops, desktops due to
its low resource usage and proven dependability. I also really enjoy
its "naive" implementation of case-insensitivity, which I tend to use
on /home mounted filesystems.

I would really miss JFS for what it's worth and would like to sing its
praises: low resource usage, tried-and-tested stability and for a long
time the only case-insensitive option available (I know about ext4's
new case-folding features of course, but have not had good experiences
with it yet (experienced boot issues with grub, per directory setting)).

Kind regards,


Rubin!
