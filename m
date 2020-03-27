Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C028195B8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 17:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgC0Quf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 12:50:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2607 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgC0Qud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585327833; x=1616863833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hfSaALAwOkEjkHXBUzEOgrr3qDzp+TUzOjdfRsri0lw=;
  b=J8VvgXQ7PnoiAQ+dVO11KF8EExAH5V9W5TiTPD4rnvdXTnRSdDKB9IOh
   AxZiQFPqqsKFN2HzISknpGc9jloCWyWmPxjqMVI87JlPfvBhh4aUzddZi
   /MXVEJY7Z2fhN5PngfS/DX73bYngiY/IyB04W3BaEpzLu9XnyrpjwqFsY
   aixd9w0U8AUySyYRWxsp6Ty5PA9KBM7/y2PJQRp+65+TCc3BnFEkmVpSH
   Fgw1EDAjZZEpHXDwlY/LMq+ANCAaWcgpuQVFAhXvGq8aa+iXt2+WsoPe4
   /ZzITbSfgeREDfcJZvtwW7URL0CgPPO6NhJh+txD/1Lix1aEXG34GqNe0
   w==;
IronPort-SDR: 6WkaZyBbAUyhL9plfPI2jYA5vGnZQk5urjLrw2UbzSa84390Dl9FRHzLkCSMsVVR4g9lpRifhL
 INEXOIr8SixmJpsfQSxDLfGxlukiy1RmuR/faHMlBQL/mKTIL4uouJUNEQThaM8VnrBu8txy8r
 ExWIGn/Ek3N8dQnt5CMplnwuTcMCIKa1uJAVF7bghceqKMtV98hO5i7HKexBG4gBNxKIPHZOuj
 2iBa98VW9u1Zbe+BRh0CLUcFb6SgRzSdQfjDKBbqzy8EPalrVRc8IRbO1J7HuPkvA0Yi5XgF/8
 XcU=
X-IronPort-AV: E=Sophos;i="5.72,313,1580745600"; 
   d="scan'208";a="242210468"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 00:50:33 +0800
IronPort-SDR: UDzevWbbLOHJGhB4aUVSd9wtEvasaZ30b920BYOTNr1kBwr8WUZ8R8ui2qooQ4zXotpdveypPc
 xs5jskTf56tzDLfv7M3WKlRJ8brIiyYGCHjqbQR6A30GjdTacUPv804TQKEeUKGEQz5we67j69
 EruTGjlD401E+3VTI8DXqKdsXall1KS8FaTl4/ORYAxtU+ZLvbyFgW0TrAadMNmRXh6na66Q6I
 zyWppcumzw5tic5IxtWIyjuPAKvfR+32MuMrt3dJPqL17VHMdenmMhcnrN0vXx+9epI3tXXczm
 QKyM5mLOrBjdPPdULyIFwMbJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 09:42:07 -0700
IronPort-SDR: Ee5vfifK/q6CaWhGLfVLdauIISNxd9ua1WXrJsCuI2uHvPqEegQll2GsmXVhlsgZpHP0TI0kC3
 5gbSXgVenN1zVYKFhJqp3ZF07eG3UPIv9Y75wj2tJJFc5G18y9NutvGuaIK7jO4g49O2GHQSTK
 qCDfeKeg2eV86Jy6CH6I34n3m72IrHyXY/ZotO0dcafc4A5VbeeAYmzujmBlGsmnXI8m85ceHu
 96VwWL3CwMvDrBtbICkY7KG/GzqjpQlu5WF93lRrr0RWDzWkoGglfJfYsy65Tc8e40pfJXyvXf
 tgg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Mar 2020 09:50:32 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 09/10] block: export bio_release_pages and bio_iov_iter_get_pages
Date:   Sat, 28 Mar 2020 01:50:11 +0900
Message-Id: <20200327165012.34443-10-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export bio_release_pages and bio_iov_iter_get_pages, so it can be used
from modular code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index aee214db92d3..023ad8bd26c7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -998,6 +998,7 @@ void bio_release_pages(struct bio *bio, bool mark_dirty)
 		put_page(bvec->bv_page);
 	}
 }
+EXPORT_SYMBOL(bio_release_pages);
 
 static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1111,6 +1112,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		bio_set_flag(bio, BIO_NO_PAGE_REF);
 	return bio->bi_vcnt ? 0 : ret;
 }
+EXPORT_SYMBOL(bio_iov_iter_get_pages);
 
 static void submit_bio_wait_endio(struct bio *bio)
 {
-- 
2.24.1

