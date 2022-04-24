Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6650D2EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiDXPqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 11:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiDXPqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 11:46:38 -0400
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Apr 2022 08:43:36 PDT
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A146232EF7;
        Sun, 24 Apr 2022 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xuJCo
        hPLpFFq0nMkMgsbwR1ueyZayVeBCU2CJqE14pI=; b=jNQkkiccd/n8seGOBVHS4
        m0YAZMfc4LWuwlRnOjvlX1aNv7CljcpvJSThbl52VsZFLGEU95vGyg5xWI+jwvdC
        XOT+p/3n00a00myuOBiZQ7djO4umHcLO9JfNcv1yUzEP0XgsTlUX8Z+hqSmiRQuq
        pZBzoOT8A7e6Xj4D7+Icww=
Received: from localhost (unknown [113.87.88.166])
        by smtp14 (Coremail) with SMTP id EsCowAC3FO6BbGVifODzCg--.55167S2;
        Sun, 24 Apr 2022 23:28:02 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     lkp@intel.com, Junwen Wu <wudaemon@163.com>,
        akpm@linux-foundation.org, keescook@chromium.org,
        adobriyan@gmail.com, fweimer@redhat.com, ddiss@suse.de
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] proc: limit schedstate node write operation
Date:   Sun, 24 Apr 2022 15:27:55 +0000
Message-Id: <202204231250.LYIILAXn-lkp@intel.com> (raw)
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423023104.153004-1-wudaemon@163.com>
References: <202204231250.LYIILAXn-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAC3FO6BbGVifODzCg--.55167S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRuQ6pUUUUU
X-Originating-IP: [113.87.88.166]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisRrsbVXlpdDfGgABsr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: kernel test robot <lkp@intel.com>

>Hi Junwen,

>Thank you for the patch! Perhaps something to improve:

ooh ,I will fix the warning

