Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D2845856B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Nov 2021 18:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhKUR2L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 12:28:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238338AbhKUR2I (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 12:28:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29EEC60230;
        Sun, 21 Nov 2021 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637515503;
        bh=aiJq05jytq7//TsGyG6sMDwMz+aZHqTBKT1ARxUR17k=;
        h=Date:From:To:Cc:Subject:From;
        b=f8epykOM4dDb/QXcWqNNwT0zBZ6ONCkdWq2YHJkdSS4OOJbMBuwkSLa2AIss3K3vV
         /Kpv3/NsCm4SFmzDIptCB2GWr9/DF/yA37CxjRer2Q7LCuVAKbeQ9DkCh/iChanF1F
         upLLCljJrPbVh582PkB6eHuBYjC+E5FvrVk4ZlYg4z+dadUBA4pdgEHIAlpNHC0cES
         CGb1GSMeAuQ3ErLZTUNLcL8NHIijSK74Gj+ERqdNkS/nFqe0wrajX/bJ2oJjQfOdEJ
         NCEZ3Vz4BPutnqXe7lF3ftl8+RJ5ZKbjnCo3YDFG3C6PIocFjDd1ryu4b0gTsQIv8p
         lAkARzibKDYYQ==
Date:   Mon, 22 Nov 2021 01:24:56 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] erofs-utils: release 1.4
Message-ID: <20211121172455.GA8626@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

A new version erofs-utils 1.4 is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.4

It mainly includes the following changes:
   - (experimental) introduce preliminary dump.erofs (Wang Qi, Guo Xuenan);
   - (experimental) introduce preliminary fsck.erofs (Daeho Jeong);
   - introduce MicroLZMA compression support (thanks to Lasse Collin);
   - support chunk-based uncompressed files for deduplication;
   - support multiple devices for multi-blob CAS container images;
   - (mkfs.erofs, AOSP) add block list support (Yue Hu, David Anderson);
   - (mkfs.erofs) support per-inode compress pcluster hints (Huang Jianan);
   - (mkfs.erofs) add "noinline_data" extended option for DAX;
   - (mkfs.erofs) introduce --quiet option (suggested by nl6720);
   - complete MacOS build & functionality;
   - various bugfixes and cleanups;

Many noticeable updates here. First, new preliminary fsck.erofs and
dump.erofs are now added to analyse and check EROFS images by Daeho
Jeong, Wang Qi and Guo Xuenan. More improvements about those features
will be shown in the future versions.

Thanks to Lasse Collin, LZMA (specifically MicroLZMA) compression
support is also finalized in this version. (btw, tail-packing inline
for compressed data is now ongoing by Yue Hu [1] which will be
addressed in the next version.)

Also, in order to support chunk deduplication and some container use
cases, chunk-based files and multiple devices are supported in this
version. As usual, add a word here, our team will announce the new
opensource Nydus container image service [2] implemented in the Rust
language at Open Source Summit 2021 China which aims to use a minimal
metadata (EROFS-compatible RAFS v6) + a few content-addressed
chunk-based de-duplicated blobs for effective distribution as well as
storage (such as minimizing underlay fs metadata overhead). It's still
under some internal release processes so please stay tuned..

In addition, users can now write their own per-file pcluster hints
to adjust compression unit size for each file, which was contributed
by Huang Jianan. There are also some AOSP-specific features to make
Android scenarios work better as always.

In the end, we are actively working on more useful scenarios [3] and
quite happy to hear, implement and enhance any useful feature requests
from communities. Feel free to feedback any comments, questions, bugs,
suggestions, etc. to us for better improvements and welcome to join us
as well :-)

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/b1b3b72371dd4a6b46137dce2fab04899e111df9.1637140430.git.huyue2@yulong.com 
[2] https://github.com/dragonflyoss/image-service
[3] https://lore.kernel.org/r/20211009061150.GA7479@hsiangkao-HP-ZHAN-66-Pro-G1
