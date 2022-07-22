Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B983B57E2AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 15:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiGVN6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 09:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVN6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:58:32 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F08BAAC;
        Fri, 22 Jul 2022 06:58:31 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MDwRn3016701
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 09:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658498309; bh=O2vZamNti37vaYiHfmsa7CRQrBvYBsTTdgnOC1njLI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HHDhAyjs4H+p3JXzwLHAcZ7ZnaiXODrAZF6LE5J3apkR3sVVZ17w/NAD9zehbPwzP
         KAWHuiSHDPsrymk2+i7ozwbyMVdR4rEBDPBvYBY/rVbryCfuNdb4wXHiLUh+ANVXnu
         wLDFRZtMLVeAS95D2NZpTIiwGU2ODFqVqsPFhnlX+y1PXq7prXZkzT3mf5aOIQMrCc
         1c5qaL4QAfUWAlWvoRqMBGUUBp4AlEsdsU5kZoB1dVgFkifmNUYM5LvKKGcw+vGZz5
         UyTIleHPC5uZeyTbY0vLt4ytqIOSlJpNNcQaa4z272bkkb7xaYxKHpAn2chmGiyIeG
         uZHWJBfNlpJzg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 67DEA15C3EFC; Fri, 22 Jul 2022 09:58:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     bongiojp@gmail.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v5] Add ioctls to get/set the ext4 superblock uuid.
Date:   Fri, 22 Jul 2022 09:58:12 -0400
Message-Id: <165849767596.303416.13387912948805613383.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220721224422.438351-1-bongiojp@gmail.com>
References: <20220721224422.438351-1-bongiojp@gmail.com>
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

On Thu, 21 Jul 2022 15:44:22 -0700, Jeremy Bongio wrote:
> This fixes a race between changing the ext4 superblock uuid and operations
> like mounting, resizing, changing features, etc.
> 
> 

Applied, thanks!

[1/1] Add ioctls to get/set the ext4 superblock uuid.
      commit: 2cdc09d757bf2cefe5de132076eb5d0a8e8df384

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
