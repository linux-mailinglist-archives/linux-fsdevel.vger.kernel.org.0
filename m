Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C4A57E45A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 18:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiGVQ3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 12:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiGVQ3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:29:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CF8904DA;
        Fri, 22 Jul 2022 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zciwolEljb5SShub7sh4EMK6hHgSoCS7WLArISZs/2Q=; b=Ex0+XV1w/1Xwg1Qm1mtEwBLqhv
        Gd9hF48zcgT/DNtRhhbwtCgjs0q+X8fy6JMtzHBDD9t2MeX+PlIXZN22sdLVoB+G+cY+TT4h4358g
        RnOFTR3kLopa45aR7x+CdiRzKm4jzx/+ObnToppAihHlscfer4mx4KiomPi36ht1OBPW6Frm+0ulu
        b4QeF3r5WpHXsfFX7HCrzpT6EUABB/T1+f6WgC/Yv0TO12MdasDk17hX3lixz9Q/icJQNxEOWcYM1
        46gPETu4QNzP/68t3Z20PCzJmP/glNDj4HtfH+uQSbN1X5fES0jJ2hYaMvQUzJbLM5Ek3qsK6/6Ht
        bdEwnofw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEvX1-007vOd-9Z; Fri, 22 Jul 2022 16:29:39 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ebiederm@xmission.com, corbet@lwn.net, keescook@chromium.org,
        yzaikin@google.com
Cc:     songmuchun@bytedance.com, zhangyuchen.lcr@bytedance.com,
        dhowells@redhat.com, deepa.kernel@gmail.com, hch@lst.de,
        mcgrof@kernel.org, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] procfs: document proc timestamps
Date:   Fri, 22 Jul 2022 09:29:32 -0700
Message-Id: <20220722162934.1888835-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds some documentation to procfs for the timestamps of inodes.
While at it, nuke some ancient silly boiler plate which resemebles
a bible disclaimer of some sort.

Luis Chamberlain (2):
  Documentation/filesystems/proc.rst: remove ancient boiler plate
  Documentation/filesystems/proc.rst: document procfs inode timestamps

 Documentation/filesystems/proc.rst | 71 +++++++-----------------------
 1 file changed, 16 insertions(+), 55 deletions(-)

-- 
2.35.1

