Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A04779B754
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjIKUxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbjIKMdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:33:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980FE1B9
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 05:33:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC87C433C8;
        Mon, 11 Sep 2023 12:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694435626;
        bh=pHvuzdBWALCSGYdj9dS0eFr31K1DKFG1ViL7xUjzWDI=;
        h=Date:From:To:Cc:Subject:From;
        b=HsirWk5V2CUwjbLf5VYJ//NO2qEIwtINnD5SWBmAG3aCIWre5QJDb2c8aoxnQbk0G
         qWVAlpH4LuasIKZh+YgaSUfhDro8qk+eo9mF6zMj5rlAL5slTnZf5JXJno6SpdojGi
         rx1S90IRL1o+9Sb82oImOmp9VPJDDn44tO4NVEf2oTmNzqT/n3ajumMvJC/LxdZMZM
         qiH0WcrX4mrx6qztUe23PPVywhEqSNsWRI2I2Bbdd5cq1zPDfEXMVjTaSJlFb0vXro
         y1BffN0M2iJahlHXtxI/kUmtkOOdwu9+q/H/Ogfbg70jgDru70splwcEx5IBoNFLDM
         o9GHYxgV0VX/A==
Date:   Mon, 11 Sep 2023 14:33:31 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: vfs.git rebased to v6.6-rc1
Message-ID: <20230911-aktive-satellitendaten-fb9062f56a00@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

Quick notice that all active branches have been rebased to v6.6-rc1 in
case anyone depended or planned to depend on those.

Thanks!
Christian

