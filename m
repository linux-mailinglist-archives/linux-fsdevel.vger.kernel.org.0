Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8683F025B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 13:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhHRLMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 07:12:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56556 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbhHRLMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:12:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 74F932200A
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 11:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629285109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UrLUB19xxS0T/5Y1Vo7Ex4cSyyVFhIxz6YEVhyhgNl8=;
        b=SxorqouZZ5GSawd5mfhgy8H2plTecq3xAOtQtdmCBVbfWL6JmC2DHeKYUoNqT6GcwEW4lK
        ADcwLGcmcVZCzmYCHFtBcgGTzJeDmsR5TZ0o/rsEpX8gpevunxrrxZCyoW5GPMDRtQUBmA
        +3RxsVJms4jOPd70DH8WHushqLgDo8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629285109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UrLUB19xxS0T/5Y1Vo7Ex4cSyyVFhIxz6YEVhyhgNl8=;
        b=w4/a5J5+vgR3tai217sgMBame38EUgzTouPpZ7Y/35AYg1kWhRaGngWJ/PR4NIs+40oorJ
        n5lWLvicXwaCXZBQ==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5678FA3BA2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 11:11:49 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] exfat: allow access to paths with trailing dots
Date:   Wed, 18 Aug 2021 13:11:21 +0200
Message-Id: <20210818111123.19818-1-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset adds a new exfat "keeptail" mount option, which allows
users to resolve paths carrying trailing period '.' characters.
I'm not a huge fan of "keeptail" as an option name, but couldn't think
of anything better.

Feedback appreciated.

Cheers, David

--

 fs/exfat/exfat_fs.h |  3 ++-
 fs/exfat/namei.c    | 25 ++++++++++++++-----------
 fs/exfat/super.c    |  7 +++++++
 3 files changed, 23 insertions(+), 12 deletions(-)

