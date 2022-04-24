Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C870350D2CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 17:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiDXPiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 11:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240198AbiDXP2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 11:28:45 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 502C3186F0;
        Sun, 24 Apr 2022 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SSwEb
        R1Q0zSkY2pkp2ZsB1ndiNG5yqAkeTuM/roPQF8=; b=hPyVegbjX0JylMYh/e+HX
        IS+ahqmgjqBBm3IzNIva1SPiyQvhX/4uvc5lC8MeFzN4p5beKIW23HqerLPeB6oE
        6gtvtrZFCsjBx1ss/mPNFAxzBa+RkwO0/NLdv6sM+RYMIHsGidfaoV3L5w+m9HBO
        6a8Cv0TKCzZ1OULa4sgnks=
Received: from localhost (unknown [113.116.51.137])
        by smtp12 (Coremail) with SMTP id EMCowAC3kXW4a2ViEoBPBQ--.1532S2;
        Sun, 24 Apr 2022 23:24:41 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     willy@infradead.org, Junwen Wu <wudaemon@163.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, ddiss@suse.de,
        fweimer@redhat.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] proc: limit schedstate node write operation
Date:   Sun, 24 Apr 2022 15:23:54 +0000
Message-Id: <YmNs+i/unWKvj4Kx@casper.infradead.org> (raw)
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423023104.153004-1-wudaemon@163.com>
References: <YmNs+i/unWKvj4Kx@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAC3kXW4a2ViEoBPBQ--.1532S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRJ8neDUUUU
X-Originating-IP: [113.116.51.137]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBFArrbVaEDhGxwgABsn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox <willy@infradead.org>

On Sat, Apr 23, 2022 at 02:31:04AM +0000, Junwen Wu wrote:
> Whatever value is written to /proc/$pid/sched, a task's schedstate data
> will reset.In some cases, schedstate will drop by accident. We restrict
> writing a certain value to this node before the data is reset.

... and break the existing scripts which expect the current behaviour.


Hi, Matthew,can you describe it in more detail.

Thanks

