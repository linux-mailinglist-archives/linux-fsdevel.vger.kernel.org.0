Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24527609C7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiJXI1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiJXI0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:26:36 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09AB013F00;
        Mon, 24 Oct 2022 01:26:24 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 8D82E1E80D74;
        Mon, 24 Oct 2022 16:25:07 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D7XCuSzGAQ4o; Mon, 24 Oct 2022 16:25:05 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id DDC621E80CA5;
        Mon, 24 Oct 2022 16:25:04 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     bagasdotme@gmail.com
Cc:     krisman@collabora.com, kunyu@nfschina.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] unicode: mkutf8data: Add compound malloc function
Date:   Mon, 24 Oct 2022 16:26:18 +0800
Message-Id: <20221024082619.178940-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <Y1ZFLO98zNoAgniW@debian.me>
References: <Y1ZFLO98zNoAgniW@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I send the 1/2 and 2/2 patches separately, and divide the two functions and related modifications in the 2/2 patch into two patches.

thanks,
kunyu

