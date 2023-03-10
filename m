Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49256B54EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 23:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjCJW6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 17:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjCJW6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:58:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C3911ABBE;
        Fri, 10 Mar 2023 14:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=G6+Cn89Ag9qW4eqhjNdBjQ8YmvxCStNR3LV0by4fV3k=; b=zZ1WSST/cH7QUvz9Ds/P3tCfmS
        aXovpVr04NxN011cTjexoffPvMNsDAXeLnFb2ESZvEGwTDiRDMnKB+i1OGzvwTvRfgbPbgAmTQTiw
        a4aNFYjBGKYWs8dhy7emo/sUV+6x4/gPDECYnG1LoSX7bD+tzc4cMnxYOljDC8yG534hFNSonbZla
        mbJriUQ9wxbcTg1zq4NYNaJorwtPTzysGbGmvEZ8tNJj4P2EyLyz4PSGkvq6HiQfIUwt1x1Rks9Wn
        RTYa2BK4EsqM7uLDUMTJn4Msv0ghJNfq8pOwKPSohOS9vNKyaMrBjqShQtALB64KNaJ7oUqIep6W5
        upTCPD7w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1palhD-00GYlR-2Z; Fri, 10 Mar 2023 22:58:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     chuck.lever@oracle.com, jlayton@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: nfs/lockd: simplify sysctl registration
Date:   Fri, 10 Mar 2023 14:58:39 -0800
Message-Id: <20230310225842.3946871-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is just following the work of the same sysctl registration [0] I
just emailed you patches for sunprc but for nfs and lockd.

Feel free to pick up or let me know if you want me to take them through
my tree. I haven't even finished compile testing all these yet, but they
are pretty trivial.

I'm just dropping netdev on this series as its purely nfs/lockd stuff.

[0] https://lkml.kernel.org/r/20230310225236.3939443-1-mcgrof@kernel.org

Luis Chamberlain (3):
  lockd: simplify two-level sysctl registration for nlm_sysctls
  nfs: simplify two-level sysctl registration for nfs4_cb_sysctls
  nfs: simplify two-level sysctl registration for nfs_cb_sysctls

 fs/lockd/svc.c      | 20 +-------------------
 fs/nfs/nfs4sysctl.c | 21 ++-------------------
 fs/nfs/sysctl.c     | 20 +-------------------
 3 files changed, 4 insertions(+), 57 deletions(-)

-- 
2.39.1

