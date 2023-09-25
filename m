Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5D07AD87A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 15:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjIYNAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 09:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjIYNAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:00:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A974FC6
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 06:00:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731B8C433C8;
        Mon, 25 Sep 2023 13:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695646836;
        bh=W9qd9a4GQnuU1S5HYospHVvnKpO7Q+YtTlMG0TzkoOY=;
        h=From:To:Cc:Subject:Date:From;
        b=mpWuaxFjC8o3izCE0XYKcRPHv0tnLOAcHehgN4NdwMOfMeSPhRukFIB6t9C6ZZIM/
         AvjX9OGhU2fnc0UD1L7APYMXC4SQO0UOMpMtwGhS1xIuWskMs71Nekvn2Nhn831s1e
         sZfrlq2p+BM8KJNNUS+5HJORcHFqQcAAXRtZuJ1WEWQJuyMAxYpcEYM6ZAqQ1A48UY
         +iNBaM+uxtsoXVnwO52hBR4XNW3SOweQ+sfZm+XdNFTKW/nzhdy/EwNFGVY24ryyoN
         Ws0rXp7Ai3D12OV+/28I/w3l3csu8HtuxVd62ky6ZcRKp40r2K4/skmlBka5h612pS
         tK5Ht5EJuljbg==
From:   cem@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     hughd@google.com, brauner@kernel.org, jack@suse.cz
Subject: [RFC PATCH 0/3] tmpfs: Add tmpfs project quota support
Date:   Mon, 25 Sep 2023 15:00:25 +0200
Message-Id: <20230925130028.1244740-1-cem@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Carlos Maiolino <cem@kernel.org>

Hi,

this is my first implementation attempt of project quotas on tmpfs, this is not
complete yet, it should still have statfs implementation and default block/inode
limits mount options for prjquota, other than that this series already make
prjquotas functional for tmpfs.
I'm sending this on early stage so maybe Jan, Hugh and Christian could comment on it
as they were in the loop during quota implementation for tmpfs. So maybe you
guys could take a look on it and give me your PoV?

Thanks

Carlos Maiolino (3):
  tmpfs: add project ID support
  tmpfs: Add project quota mount option
  tmpfs: Add project quota interface support for get/set attr

 include/linux/shmem_fs.h | 13 ++++++----
 mm/shmem.c               | 52 ++++++++++++++++++++++++++++++++++++----
 mm/shmem_quota.c         | 10 ++++++++
 3 files changed, 66 insertions(+), 9 deletions(-)

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
-- 
2.39.2

