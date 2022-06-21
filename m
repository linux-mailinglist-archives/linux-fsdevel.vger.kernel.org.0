Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F57E553140
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349215AbiFULoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 07:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiFULoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:44:08 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A2192BE;
        Tue, 21 Jun 2022 04:44:07 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8E20D1D46;
        Tue, 21 Jun 2022 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1655811796;
        bh=SsPWLRwZ+YtjxwDE4Qg+SPcCuy/4HJXnRFWKkUo025w=;
        h=Date:To:CC:From:Subject;
        b=JFy4EqOugen0mS5Y99vJW0JdHQeOS9A/KsYZWk/zJdISab/R+WRcZqOvIvp3D9aA2
         u118eR9sqBpzm90KUvGCO3m7WL6v/rfp48ig/rUR/CiQnt30ofJM1m07SAr3kW5zTY
         CLfP5QKYJpQDPh3EIiFGMx13Qg4hQpmSVhykoo9c=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 21 Jun 2022 14:44:05 +0300
Message-ID: <ab1c8348-acde-114f-eb66-0074045731a4@paragon-software.com>
Date:   Tue, 21 Jun 2022 14:44:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/2] fs/ntfs3: FALLOC_FL_INSERT_RANGE support
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added support for FALLOC_FL_INSERT_RANGE

Konstantin Komarov (2):
   fs/ntfs3: Fallocate (FALLOC_FL_INSERT_RANGE) implementation
   fs/ntfs3: Enable FALLOC_FL_INSERT_RANGE

  fs/ntfs3/attrib.c  | 176 +++++++++++++++++++++++++++++++++++++++++++++
  fs/ntfs3/file.c    |  97 ++++++++++++++-----------
  fs/ntfs3/ntfs_fs.h |   4 +-
  fs/ntfs3/run.c     |  43 +++++++++++
  4 files changed, 277 insertions(+), 43 deletions(-)

-- 
2.36.1

