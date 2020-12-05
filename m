Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8A2CFF3B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 22:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgLEV3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 16:29:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgLEV3c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 16:29:32 -0500
Date:   Sun, 6 Dec 2020 05:28:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607203731;
        bh=4z48dUqSouK4GSOzBXOaPmeem+ji2gnvk6THESip6uY=;
        h=From:To:Cc:Subject:From;
        b=fJFYR/fKFfy0YWlb2GqgxhVtW+m8tzWcp6Odaewz4daoSs2eKcKQ0rBz1RFj4DClq
         ucVLXGfam/imDDRLmj7KcqGD25dwJr52bOe6wlUAitnc4/qUo0u7yBvVy916APDU2L
         0n5JLSBR7XQej2VdzJsaG+es6B8tcFCB08DLAZnugNvQfvnemrJJ2K5YM/6ENqYlIJ
         rtvB+qcQ/6sRCiXaGtwyG9dD2bKbsUtpL3FO0uwSiwNdxWBdIVeKYJ8KhCralMmVvb
         LbQGss2e+tt1ieU3AoBB85F+jFaupknPZP8iKIlOBqxcUb7VyppyKRDGN34b8TF+PV
         mUBGTdyzZYqQg==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Huang Jianan <huangjianan@oppo.com>
Subject: [ANNOUNCE] erofs-utils: release 1.2
Message-ID: <20201205212511.GA15184@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

A new version erofs-utils 1.2 is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.2

It mainly includes the following changes:
    - (mkfs.erofs) support selinux file contexts;
    - (mkfs.erofs) support $SOURCE_DATE_EPOCH;
    - (mkfs.erofs) support a pre-defined UUID;
    - (mkfs.erofs) fix random padding for reproducable builds;
    - (mkfs.erofs) several fixes around hard links;
    - (mkfs.erofs) minor code cleanups;
    - (mkfs.erofs, AOSP) support Android fs_config;
    - (experimental, disabled by default) add erofsfuse approach;

The big part is erofsfuse, which is intended to support erofs for
various platforms (mainly older linux kernels for building servers
to patch images) and for new on-disk features iteration. It focus
on simplicity and portability thus no optimal optimization such as
in-place I/O or in-place decompression (Therefore, NEVER use it if
performance is the top concern.) It can also be used as an unpacking
tool for unprivileged users. Thanks Jianan for originally picking
it up, erofsfuse finally got in shape. However mainly due to some
lz4 1.9.2 issue, it has to be disabled by default until the recent
lz4 1.9.3 is widely distributed. Please kindly carefully read README
before trying it out.

erofs-utils has been included into many distributions, buildroot,
and Android AOSP for a while, therefore it's quite easy to have a
try and here is the latest benchmark on my PC for reference:
https://github.com/erofs/erofs-openbenchmark/wiki/linux_5.10_rc4-compression-FSes-benchmark

Plus, it's known that EROFS is commercially using by several Android
vendors for their system partitions as an acceptable compression
solution with good performance.

EROFS fixed-sized output LZMA support is still slowly ongoing since
I need to seek some full time to fully calm down and focus on the
algorithm details itself, I will update on the mailing list when
I get a significant progress.

Thanks,
Gao Xiang

