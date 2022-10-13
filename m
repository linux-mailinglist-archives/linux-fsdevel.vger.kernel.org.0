Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CAF5FE3BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 23:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJMVHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 17:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJMVHR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:07:17 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029D4183DBE;
        Thu, 13 Oct 2022 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tRw94o76Jt1YDr6z4Zx8zuKiI+Bw9m67g8hCPngyLQs=; b=LMUJeCEMyRlUbeAPvkVlgfgC3Y
        J0ImZQLdztclRIrtZRhNYcKGSCwf4jHxzGBcFk8GyL3JEHA3yfS/w51khU7KWKiV9JnQSMU0J4Zz0
        07NslbqgGAT4K1jUekF8KsqsLuA2w+WPRuTssnlGsfGwBn1w1nQ0Z0yJe4bTB/1VojJLJLEQ+GxLS
        KHBxtg2zEkrwKNi5TopwhRC9n2b4tOpqrxqT9d6NYZUO8Pka9EOc1+51IdYpgdezmONL/+NcdusnB
        BzFRbZ/dt1nupkRAyUF+eez1g0NGkcDT+cAzPRo5lmbUgYN6ZTF6ZJ0PJpfNIWgeYXoCE1voaPxUE
        JxNGhq8g==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oj5Q1-0010sn-R8; Thu, 13 Oct 2022 23:07:06 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        ardb@kernel.org, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH V2 0/3] Some pstore improvements V2
Date:   Thu, 13 Oct 2022 18:06:45 -0300
Message-Id: <20221013210648.137452-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees / Ard and all pstore/efi folks,

this is the second iteration of the patchset with modifications
in some patches, one patch dropped and applied on top of the first
3 patches in the old series [0] (since they were already picked
by Kees).

I've tested this with QEMU guest using OVMF and both ramoops and
efi-pstore backends. Reviews and comments are greatly appreciated!
Cheers,


Guilherme


[0] https://lore.kernel.org/lkml/20221006224212.569555-1-gpiccoli@igalia.com/


Guilherme G. Piccoli (3):
  pstore: Alert on backend write error
  efi: pstore: Follow convention for the efi-pstore backend name
  efi: pstore: Add module parameter for setting the record size

 drivers/firmware/efi/efi-pstore.c | 25 ++++++++++++++++++-------
 fs/pstore/platform.c              | 10 ++++++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

-- 
2.38.0

