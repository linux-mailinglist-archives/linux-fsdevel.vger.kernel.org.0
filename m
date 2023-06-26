Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8647D73D742
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 07:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjFZFml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 01:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjFZFmk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:42:40 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE1AE48;
        Sun, 25 Jun 2023 22:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687758122; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UmdVEWQo0uezW3gzYI8AGYJNrAzST0w0p1m2K4Gy2/HaL3YMKh7dU9JGWY34mJWvao
    tVZGMtToJJXaBr+FtXfc2Hp+9Q0eTwxER7h4Cirqz6zVdFMLDqc3bq4xy3k4sdcYiGol
    AYUsMDSdsXz3JeRWShwCtvAzSY7BxUappx0oLIikg5lZFDjhjL5wtEqnDFWQ44xCYbH+
    F/pbaWPKcsAtGFuT4cDtpqgAIlLq5FL6YD505NS0hQ1I5pjQfEf5rShD8oqXBbc3sAI3
    M8l0oKQxsYvPvT3V5bSQn2FNYdNaY4ew1RaA7FyZPWCui//6DW4knLYasqq5q7uB5SGs
    TOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687758122;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=u84PcML5e480sTa8HkZqNl0cQA2NFsZSaC6NnQ5PLFk=;
    b=VOecyVDzGmcEar+tZSwaVZyvYyR8xoGyhAQnnqiMsg6OtOOCDfe8UpiXNOB804DSAl
    EQhcGlisbAy39RKUfSMEQXPk9m34sJNPGbyvwasodeICCBFmfUvkvsylcCCnqu+0veSO
    llB312bnL9vrAvk0bsxykpgs90VcaiUBEYVStDWAJ1SrJgkL7eZhuQaWKc+2vzaHh9sw
    7X1GG2IJlMrQNydAsFY8We50jGKdGNWFs9MUDaAk/BDQxrlyhpON/uDpOLSSN7xFCJsh
    +/oivfnz9nJ3EiS2ojGy4bm2LWKqUTa3w7sD2l2pmvogEEx/WoTDL25qXuuVF03PB07f
    QRvQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687758122;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=u84PcML5e480sTa8HkZqNl0cQA2NFsZSaC6NnQ5PLFk=;
    b=VWyoD7aBvrrl7+S6R0ytC2ezlnhivupTe/tkyi9bL53i2l0PfntXr5aRcliYRAZHAC
    C/u1YtTTPFjGTnRllVi98JpknXUgKYkl6D3iWd9nWORos8Jr8UeVafDS2Am4o2rIdH2M
    UfQX5T7QqKOVF4nAJ8f1y0j0Tzf32cTBu4ALeO0JWZgKxYLZit+/SmR6qn/LmRIBxkg6
    ZteTTqpM+OOat1t+EKkFO3Reu5u8Nm5RIzAZBIPIVipRGUR3oZ6XCoZQluIImECgTZp6
    JwHybKNru2Iqz5FepNKxaR3jqFN3EQ44UTzGkaymgAbZf6DluhUJarGI47bxKbt4xYq4
    Sm6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687758122;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=u84PcML5e480sTa8HkZqNl0cQA2NFsZSaC6NnQ5PLFk=;
    b=4uursAC7+f1zlisTJ7H6N9A601ItGoeMxAgnDzNgxvc7m1glMB5P017maCLOAHDQTA
    HuKG8Jw+3DqAcCVw8LDw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RrW5o+P9bSFaHg+gZu+uCjL2b+VQTRnVQrIOQ=="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5Q5g1Vv8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 26 Jun 2023 07:42:01 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        willy@infradead.org, hch@infradead.org
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com, Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v3 0/2] clean up block_commit_write
Date:   Mon, 26 Jun 2023 07:41:51 +0200
Message-Id: <20230626054153.839672-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

change log:
    v1--v2:
        1. reordered patches
    v2-v3:
        1. rebased patches to git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next


Bean Huo (2):
  fs/buffer: clean up block_commit_write
  fs: convert block_commit_write to return void

 fs/buffer.c                 | 20 ++++++++------------
 fs/ext4/move_extent.c       |  7 ++-----
 fs/ocfs2/file.c             |  7 +------
 fs/udf/file.c               |  6 +++---
 include/linux/buffer_head.h |  2 +-
 5 files changed, 15 insertions(+), 27 deletions(-)

-- 
2.34.1

