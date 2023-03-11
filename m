Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6719E6B5E92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 18:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCKRSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Mar 2023 12:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCKRSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:18:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8255717CCE;
        Sat, 11 Mar 2023 09:18:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D72A1B803F1;
        Sat, 11 Mar 2023 17:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C74C433D2;
        Sat, 11 Mar 2023 17:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678555091;
        bh=OqMHq2/S6nAUuvpkSIGBYmiSX+aQtkh+hYs7nV9aLEI=;
        h=Date:From:To:Cc:Subject:From;
        b=s8OT6kPJKT1xtyIsRrDQ+LjUM3V8x1e/6BqcRhy1UW1TZ9tugHrmpL+P5T2goYtne
         FywDg5MxH00TSQDo6bEQW75lMYeQZwIwslb0vBr/bpa01GP9iNYWLKtCfMizqaGS4d
         OyrhoigZYi1gdRueBH7bblQcBxknVBHLvbTe7PaRmZ4SWZ5H44eMJnuUkEb4Zrbz6h
         KIB0ng9/eExMi5xTCEB1njrBBApJJx18Lx6wXebfiBFLEzOXUYXOK5ldyRBrDmVcA5
         Y1KeTG7CqXpWz3YIPRz6JYcEPDqb3juUQwTAJDOzfwaDzObPSdmW/rHNJ6xLXww5Jp
         IDGqDD4dYhBkw==
Date:   Sun, 12 Mar 2023 01:18:05 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] erofs-utils: release 1.6
Message-ID: <ZAy3zaoCulNNpFSS@debian>
Mail-Followup-To: linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

A new version erofs-utils 1.6 is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.6

It mainly includes the following changes:

  - support fragments by using `-Efragments` (Yue Hu);
  - support compressed data deduplication by using `-Ededupe` (Ziyang Zhang);
  - (erofsfuse) support extended attributes (Huang Jianan);
  - (mkfs.erofs) support multiple algorithms in a single image (Gao Xiang);
  - (mkfs.erofs) support chunk-based sparse files (Gao Xiang);
  - (mkfs.erofs) add volume-label setting support (Naoto Yamaguchi);
  - (mkfs.erofs) add uid/gid offsetting support (Naoto Yamaguchi);
  - (mkfs.erofs) pack files entirely by using `-Eall-fragments` (Gao Xiang);
  - various bugfixes and cleanups.

This new version supports global compressed data deduplication
(`-Ededupe`) and fragments (`-Efragments`, `-Eall-fragments`), which
can be used to minimize image sizes further (Linux 6.1+).  In addition,
mkfs.erofs now supports per-file alternative algorithms, thus different
configurations can be applied in a per-file basis (Linux 5.16+).

There are also other improvements and bugfixes as always.  Kindly read
README before trying it out.  Recently I've got many useful inputs, so
it's time to release erofs-utils 1.6 as soon as possible and move on
to focus on those new stuffs (e.g. negative xattr lookup improvement
with bloom filters, shared xattr names and tarball reference) then.

Finally, as a community-driven open source software, feedback and/or
contribution is always welcomed.

Thanks,
Gao Xiang
