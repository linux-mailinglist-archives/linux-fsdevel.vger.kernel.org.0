Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC5E672E66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 02:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjASBsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 20:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjASBpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:45:49 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0F76CCEA
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 17:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674092487; x=1705628487;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H0yumoilwvXMNgP5CKTSmhWM1Etd0rYerw/ET4AwaTE=;
  b=fyGdltkKI3yLIO37f+11gKrLa8IPErB9Z6cfGtxdifCq2Uvob46vlFy6
   6SmeVOvNiby1EWWnvAvRXWEtT00Bpya2rVO4/CVGqxqPCJqOUkxUZk51X
   3nBD3a8UhPOmxSc5BizTumdiBd+olIquC181SD68ADxi0Qjg5HzZgtfci
   jHFxNCCUZoREvGRT5b8SQ3WyRvgUiMu3gBvsjOuFMAK3q4SBR5aOdokT9
   1WGWkh8r0/si9qAKRY3K7AiRaHnCoS2L/6jZRjPxd7PtuGtIMA/IGllYv
   fpHCL+M3IQdKCbf4+XUW/cA4QHmSE5genkWtA/dbAYK9GmMIvfVPFC2yy
   g==;
X-IronPort-AV: E=Sophos;i="5.97,226,1669046400"; 
   d="scan'208";a="226183938"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2023 09:41:26 +0800
IronPort-SDR: DpwNaOx2N9NvodToGF5On5eSlxzJ7VPxCKaRNE9FxL+ANWYM712DcUhTIUowkZWOLtYTDyBicL
 G1mqISqE+u2XbZ56MgzcoCvxC+TqluSbE/mdEnw5HGo8vmOg2qywsUMwOecDk+LSJBmY2O6Cwg
 LHW45viVGlm63XLez9aeY4953CYmMybw0Ot9IolbLPssTw4RS91e75J/GWtHwC1z90KwndLvv2
 SGeNJERjRBy3ttkRxkPtWOj0OfXklgpTAVrkaJB+5r6aTY4C+S46/SmZMH7D7LQD6qDKkARBS1
 Aag=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2023 16:53:21 -0800
IronPort-SDR: cGMUchweG2VW4ZxMt40DzgMwzdokWkeH0Ye29xmrjGSxvgsTCm6/4aJA6qdVYfS5Tfh5rHG+Rn
 tfLjmqf0tHcx/ttTl/ZnVuPkpmIQNyuZvAyjFIcvGkXub7M0nN5ShIobKLb9VcZWz3ceFHGI/V
 rETFyhkG3W4FMpPhEmW6r3aMxE5Jhbi89Ie2GW5cpi637lzOKZODQMYsHSRhVKL3A41I6HKoI2
 kuE6CSJ4LmyRMp4s9LmRNLaAsciJZqOBi6OQ+oIVkkPvsvUvf0U0GR6y3Y6D6UePbe0luxm6sf
 D14=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2023 17:41:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ny52G41L9z1RvTp
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 17:41:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1674092486;
         x=1676684487; bh=H0yumoilwvXMNgP5CKTSmhWM1Etd0rYerw/ET4AwaTE=; b=
        U8lWE/Dxcw8k6B77sAsgusHKIki/07DfAiD6jw06BVPQD/hIi9jFGnDb5BNsae9W
        zcydeg6OSgh1nMutpmivk6Ij0TGX2Z3C6AtVsvOzIhbTw3XfwLExmBQUPKhY+HLX
        A1ryy+vGiZz2VgUzWSOnKUpI9aH4kcZpq6cdb2YOOfPtaSBhMuqJGve3im7CK8eD
        sGyTwZZpBvTWMcwYzPRQFpdxUVdPNxIe/UwrH0ScF8hmbUQm7mgoeeEMAJWkF36h
        AG1OXg+O/AeIidZ/7lhsOaxCHWJPLae7ReBOmhsRrhauDZYmLi093Oax7hTiHDx2
        BoAHmzu8gthKqNvrCF6Q6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2Sy0Rue5n1cz for <linux-fsdevel@vger.kernel.org>;
        Wed, 18 Jan 2023 17:41:26 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ny52F5cKYz1RvLy;
        Wed, 18 Jan 2023 17:41:25 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 6.2-rc5
Date:   Thu, 19 Jan 2023 10:41:24 +0900
Message-Id: <20230119014124.4332-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6=
d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs t=
ags/zonefs-6.2-rc5

for you to fetch changes up to a608da3bd730d718f2d3ebec1c26f9865f8f17ce:

  zonefs: Detect append writes at invalid locations (2023-01-16 08:42:12 =
+0900)

----------------------------------------------------------------
zonefs fixes for 6.2-rc5

 * A single patch to fix sync write operations to detect and handle
   errors due to external zone corruptions resulting in writes at
   invalid location, from me.

----------------------------------------------------------------
Damien Le Moal (1):
      zonefs: Detect append writes at invalid locations

 fs/zonefs/super.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
