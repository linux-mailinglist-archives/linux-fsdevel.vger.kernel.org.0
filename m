Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD36F4CB2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 00:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjEBWAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 18:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEBWAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 18:00:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C601704;
        Tue,  2 May 2023 15:00:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF4F862902;
        Tue,  2 May 2023 22:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA8CC433EF;
        Tue,  2 May 2023 22:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683064840;
        bh=pFx4CX9KRr8fZ+gWBIKelGXuHXyvyYmvVc8c7H+7oeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=br+xzZumDRJ+cg71kYAvs3POmeUdZRbSyfMLmMRoQuDLopggh4YAwN4qaIBPk0agJ
         E32Mk0fO2kLNIIT6Li8tuPxz5QbxzOjJLTPTwn8BP0j845xJM2+iTQ2OOB0mwIqUfH
         CtFOKNHmC0KJcrO670r0TOQniNWJ8E5ries26CfGHfb6LGNOfQMBF6Y6sgrvgEHIev
         hMnRvri4at1DWM0H90Dh7Z6MrPOUhHn3yZqdBUltikbPpHJvaVdkkDumKh029bsbe9
         gFNcH2af/VqgHV6XxS/qDItVh4PdbRkGpeh63q85my1tuZ0eXeEvNDDc1Ptx4UZhAK
         vpgsWHih2cevg==
Date:   Tue, 2 May 2023 15:00:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     syzbot <syzbot+c103d3808a0de5faaf80@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xfs_getbmap
Message-ID: <20230502220039.GC15394@frogsfrogsfrogs>
References: <000000000000c5beb705faa6577d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c5beb705faa6577d@google.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git inodegc-fixes-6.4_2023-05-02
