Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870F26D6A00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 19:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjDDRO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 13:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjDDRO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:14:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480AED3;
        Tue,  4 Apr 2023 10:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1FF36378A;
        Tue,  4 Apr 2023 17:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327B4C433EF;
        Tue,  4 Apr 2023 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680628461;
        bh=q0SEd99SwGnQv2q9V/VBWUZ22Egdd8W2yS7XP6MsaXY=;
        h=From:To:Cc:Subject:Date:From;
        b=rxf8Px/sRI8aDXXpPLhlzWA7uWbh8KlGWQty8kES5RT+P2cE0UZXEEk7kk3dpox6G
         4U3EzithdvlX5dCrUpSuB8HxmQk1UaHJEeMPlD9GBQxvV6kJhHp1/7vG5wwQFgAujZ
         8J2/JqrepCiN9l+GM1AFR4ph4XOMpfXEG9CaXA3eunj96pT3CF7kxt4gFWVmW49cI2
         yBQzPqBiSeQeLQ0bnDeJnllu9cv1Gd9xjYPac0pm7TEd3B3phZewlywDchtaA8Wmc2
         kyj4IPnK8suH6Z4FcqGxNK4kuoJegBuoeAE7HuJeTE+DUK0ijwELoh8zHTxKF51NPy
         ZZTcI9PosiYyg==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-unionfs@vger.kernel.org,
        jack@suse.com, linux-xfs@vger.kernel.org, fdmanana@suse.com,
        ebiggers@google.com, brauner@kernel.org, amir73il@gmail.com,
        djwong@kernel.org, anand.jain@oracle.com
Subject: [RFC PATCH 0/5] fstests specific MAINTAINERS file
Date:   Wed,  5 Apr 2023 01:14:06 +0800
Message-Id: <20230404171411.699655-1-zlang@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I think I might be mad to include that many mailing lists in this patchset...

As I explained in [PATCH 1/5], fstests covers more and more fs testing
thing, so we always get help from fs specific mailing list, due to they
learn about their features and bugs more. Besides that, some folks help
to review patches (relevant with them) more often. So I'd like to bring
in the similar way of linux/MAINTAINERS, records fs relevant mailing lists,
reviewers or supporters (or call co-maintainers). To recognize the
contribution from them, and help more users to know who or what mailing list
can be added in CC list of a patch.

(The MAINTAINERS and get_maintainer.pl are copied from linux project,
then I made some changes for fstests specially.)

PATCH 3~5 are still under reviewing, hasn't been decided...

About [3/5], if someone mailing list doesn't want to be in cc list of related
fstests patch, please clarify, I'll remove.

About [4/5], if someone people doesn't want to be CCed, tell me, I'll remove.

About [5/5], need more reviewing from btrfs list.

If others fs which *always send patches to fstests@* and *hope to have a specific
co-maintainer* who can help more on your patches (to fststs) before merging, refer
to [5/5].

Thanks,
Zorro
