Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04237651711
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 01:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiLTAKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Dec 2022 19:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLTAKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:10:44 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717D4B2B
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Dec 2022 16:10:40 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z26so16164127lfu.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Dec 2022 16:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q4cQ0DopySezXK1/XnLO/aLwPIZH/9uUydt6b7Kl0JA=;
        b=ihBOxERENh45xMmCxnbBjV3GAU5GeiW4NK7VVfS+9u034CZ2WNuCnwoUO66+z2cU4U
         phthKzV2s87PbzuwUC7ZJ9PRz2BSWtLZKCmuikKU+QejtyVEOhjv0Ygnkd2y7DCGwam8
         tKCP4sWcDfZLi8ef4dLgLrovL8sB5JPjib5Cz2/6NMq8R7VQpWQoCCZwrarl38kUfPCR
         KQpeoMZT0fJbIvkvzWeWNL8kx5ymU8RiSE7Kx4RprsVInY39AQ+3PxxO5aEc8sSLAWpN
         pxRUAk5e4EB/aU/yh7z03Ml2m0g6D5hwbcIPBuYxBVgZxb6bApkV2qcgtHrQDc6qgutd
         SovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4cQ0DopySezXK1/XnLO/aLwPIZH/9uUydt6b7Kl0JA=;
        b=59IRyNk+BOa3Qsg0q+35zglYMlF3NJj3lKy5U2TjOhkgxVfGwoyyOwGStmuC2kp35S
         6nI4acjSAek15At/ulsdybkXvoDm0XhAjvw+fNYRNZuDzu3+54S/ipFhv0VIOtjRS+88
         6t9e1ht61kOCXnA2TJTrCdLsr4ahEW+vbnqVayP+ht4Ld9/XbmcNQfu7XbNrkFhzvIwi
         Ie3/IySPyhLPH8kNO5LBYt8xvC/1UHhix7o7qm+4vddHNYouKXo+OAWAJM3ryS0h1J3v
         e0Fcs/hUsh82KUlufvYigOLmz4zgoeHUQrFq1ueziKuyfzoqQ8d+1A9Q31p1reME9fmy
         fWew==
X-Gm-Message-State: ANoB5pklEgfQ0naOqPbqxJ+E4EmgZgkl89q2j3hADOh9/Mw4AeNKqhQe
        +fgJquavhFyt7LtmRsNUzgdmY0SI9dyq5uJusbL9rGkJExs=
X-Google-Smtp-Source: AA0mqf6/vb4DV2NkAAb+QzC89gMddh0OvGS1gWaeKtGdkGRUWFbBfwLr56vdMzS4wqm5Y/1zQ/OR6K1ay6J/ix0Xs+E=
X-Received: by 2002:a05:6512:36ce:b0:4b5:7aad:268f with SMTP id
 e14-20020a05651236ce00b004b57aad268fmr10162616lfs.673.1671495037888; Mon, 19
 Dec 2022 16:10:37 -0800 (PST)
MIME-Version: 1.0
From:   Zbigniew Halas <zhalas@gmail.com>
Date:   Tue, 20 Dec 2022 01:10:26 +0100
Message-ID: <CAPr0N2i3mo=SP+AdpMz=qHXejsKWs+JLTPaJVGwrzopaWOfVdA@mail.gmail.com>
Subject: FIDEDUPERANGE claims to succeed for non-identical files
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I noticed a strange and misleading edge case in FIDEDUPERANGE ioctl.
For the files with the following content:
f1: abcd
f2: efghi
FIDEDUPERANGE claims to succeed and reports 4 bytes deduplicated,
despite the files being clearly different. Strace output:
openat(AT_FDCWD, "f1", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "f2", O_WRONLY|O_CLOEXEC) = 4
ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=0,
src_length=4, dest_count=1, info=[{dest_fd=4, dest_offset=0}]} =>
{info=[{bytes_deduped=4, status=0}]}) = 0

The reason is that generic_remap_checks function is doing block
alignment of the deduplication length when the end of the destination
file is not at the end of the deduplication range (as described in the
comment):
/*
* If the user wanted us to link to the infile's EOF, round up to the
* next block boundary for this check.
*
* Otherwise, make sure the count is also block-aligned, having
* already confirmed the starting offsets' block alignment.
*/

So it effectively becomes a zero-length deduplication, which succeeds.
Despite that it's reported as a successful 4 bytes deduplication.

For a very similar test case, but with the files of the same length:
f3: abcd
f4: efgh
FIDEDUPERANGE fails with FILE_DEDUPE_RANGE_DIFFERS. Strace output:
openat(AT_FDCWD, "f3", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "f4", O_WRONLY|O_CLOEXEC) = 4
ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=0,
src_length=4, dest_count=1, info=[{dest_fd=4, dest_offset=0}]} =>
{info=[{bytes_deduped=0, status=1}]}) = 0

For this case generic_remap_checks does not alter deduplication
length, and deduplication fails when comparing the content of the
files.

Cheers,
Zbigniew Halas
