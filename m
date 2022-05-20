Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925D052E2FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 05:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbiETDRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 23:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344726AbiETDRI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 23:17:08 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562095A585
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 20:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bIxUOzwwvPU+e9GeDDqKCekSgz8zSH4PCiVE+54uAwM=; b=F5FmEKon3w99QwvBkPThSQqLkI
        0MEJit2AYqlcQNDIKms7MjddstoT95HyCndu7LjORmPimd0cc2gxAtIjf80pZxbA1Kqx1eoFOuzbU
        TUHiw2cCFUJvqdewTBOqIXSabG25hXVl8+V2zaV0VU1vm/mqp/6j7fDcmxMgSYHmC8xm1KEeMfHWZ
        V0qXbql53iEzA0csP5RsMhBF3F1y4xz9LfSmJAMqkK771X4T8Tz+rVXyouFsukq4z9UQHnTJ6yVUn
        3jt1QeI2Mk6eYoFwkl9XC8c7G0KYU/5BVFHKznOVxyPaJbABysKy+sVt3nway8cFY1LY2vP9Q6ZBx
        uXoA+xqg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrt8U-00GU77-Bz
        for linux-fsdevel@vger.kernel.org; Fri, 20 May 2022 03:17:06 +0000
Date:   Fri, 20 May 2022 03:17:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCHES] stuff from the last cycle that missed the window
Message-ID: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Several patches had been sitting in -next since January or so,
missed the last window.  Just noticed that this stuff had never
been posted to fsdevel, so...
