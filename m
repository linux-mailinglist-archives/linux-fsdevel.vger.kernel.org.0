Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415C0263D9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 08:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgIJGwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 02:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgIJGwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:52:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98820C061573
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2020 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=dqAQws+pZvIQBVeeSFMgSOYQ4VgVDai1XfPk4crKTRk=; b=dQpl0qKx2kx2b/Gz5Weaiyckty
        j5xlzulOmien3IRXtPtdhLDb4qLGBMaMHE58PSAaXw26548x5ytELU7625H3ujLqJfwujuGlAMcHJ
        n8rBbTuSO4AzwTnlimIklOBOrK6iNDshJgs9TkoLC0ynIaYst9nSOqQDtsC3gavUeySUx/w10oIo+
        ehJPnubtbbvWjHyGhi4b+XqvXUhaef1axTSrDp85TsQrmsZwrNuGpvhTFfVR1q4T1TozyinlxBBXN
        eRYXRZ/WsQ6cQ1dfEt/TudNSjInSZn39p/VAStXfP/pxQzhJMNj0VhjkuxqYtD8O2IHfTWLeKs9Zy
        K1mPqSeQ==;
Received: from [2001:4bb8:184:af1:d8d0:3027:a666:4c4e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGGI9-0000BV-TH; Thu, 10 Sep 2020 06:42:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: state cleanups
Date:   Thu, 10 Sep 2020 08:42:38 +0200
Message-Id: <20200910064244.346913-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

a bunch of cleanups to untangle our mess of state related helpers.

Diffstat:
 fs/stat.c            |   70 +++++++++++++++++++++------------------------------
 include/linux/fs.h   |   22 +++-------------
 include/linux/stat.h |    2 -
 3 files changed, 34 insertions(+), 60 deletions(-)
