Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70287AA6C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 17:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390243AbfIEPG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 11:06:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:55864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732130AbfIEPG5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:06:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 907A4ABC7;
        Thu,  5 Sep 2019 15:06:55 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de,
        linux-xfs@vger.kernel.org
Subject: [PATCH v4 0/15] CoW support for iomap
Date:   Thu,  5 Sep 2019 10:06:35 -0500
Message-Id: <20190905150650.21089-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously called btrfs iomap.

This is an effort to use iomap for btrfs. This would keep most
responsibility of page handling during writes in iomap code, hence
code reduction. For CoW support, changes are needed in iomap code
to make sure we perform a copy before the write.
This is in line with the discussion we had during adding dax support in
btrfs.

I din't mean to change the series topic, but I am expanding into
XFS. However, I have not thoroughly tested XFS changes yet. I am
sending this for the deadline set by Darrick.

This patchset is based on DIO changes sent by Christoph,
based on patches by Matthew Bobrowski.

[1] https://github.com/goldwynr/linux/tree/btrfs-iomap

-- 
Goldwyn

Changes since v1
 - Added Direct I/O support
 - Remove PagePrivate from btrfs pages for regular files

Changes since v2
 - Added CONFIG_FS_IOMAP_DEBUG and some checks
 - Fallback to buffered read in case of short direct reads

Changes since v3
 - Review comments incorporated
 - Added support for XFS


