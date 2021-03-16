Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5BA33CA8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 02:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhCPBJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 21:09:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30425 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhCPBJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615856941; x=1647392941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G/CsHuRAioaaEejpkK0LjKwTr3cGQI2p4I6giqmdmbE=;
  b=hJJnsfBiVInDnqW6R5+1+VzuX5kmbeE4e8UmAZSFb22DkXE9T1g/3oxv
   Nhwu5bE0v+n8E/rGWuNfMTLbOinqkvcBGiJg7j0W9HEyFnowBEmYZsGC0
   ZGwq6SmxWpKVtebpk/SilckLRbBj6HgT8INrc1IouZ9c4Ll35FlmpeJxU
   Ux7iUfdHG82OldBew3DMv4KxFYg53uN1/0MaU1dmDUGqkbayFK5z0dQXT
   RUfkOGbZ7GVjJSY3iTReFDsJ+KrBIaGV3f9wiDIZKcQZrKErqk1xYsyq/
   PLI7YNZ4+kUK+4ZUt7jWcj5NSqwC05Pyz58mF3c19g7lWCa1FRHnSKb37
   Q==;
IronPort-SDR: lOqN7M9JR6zz8npNwNym4kHrysXEUeIZnJxWaDgHI05wMA2iw2IisuRRn5hs+MK9DFYX60X0LC
 K1Aj9a7rXkwiLB2dfCPz/o4P+OHKCBVGHYTm1ftx87spHil5qRAaBVXbM7xfNG6XXsQcktbhaG
 8hUupBCUQ7FUkbmKrZObjDxA9fLvnzvd37A23XVTkSfJmSZJSKcyMUHxpbkzUI5xSmlH4pKS4t
 biakCO9VusPW6lhcxqJZhv/8h2K3IsXmAPAjRMJbloeVLc4pkF9n7zcgpknlIA+hi5IkcE/DLX
 PzQ=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="272929387"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 09:09:01 +0800
IronPort-SDR: XPrNeJQzwj7aY4amV5wJj5iW7YMBBWpMWF+HLnCxKn8zryqFY6m8VbvKMxvxSXDyoA1dQ9JTF7
 21gNvy5h2/fQUouuOXeSoiWFkmk4vOlVyV8iXtXMpEaIoNNzj3oznFLfqaopeYWOdzQNI61qcS
 qpbyZ/ZAVSc+2Nz1rsNoQ0TxYmKi1Tgrn//OjI4t91luamAp7PaSRFLwlXXHpzwZ5YeUy9Y7mh
 JXuDMZCjCDGzKNUDeriYQq0moF8OM4FzqCt+y2dQOciGLd/EmlXQfAUnQd5J8fpG6Fx7udimJ4
 QzLz7Qk+2MkPDvGYCKQleuLJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 17:49:37 -0700
IronPort-SDR: uTr5Ulwo02sCcoHqwuhOwkA8pgKwBBxh16CCi0cUP0aWwnFz/b0ei0N+/7G1qT8AOPQCHSQWm5
 va2W/cFXRuPs7LmI0rTqr4wjNQcxdOnfDb/rFiVIJeAN9UiV4GAsxMbOR7rfEVDIrxA1ZWQBgb
 o1lRCVu8768ldSQZup37JXI6BpF60lgaJq+G0+0KFwPcY/9QGYpK4wGcUIJlsdhafwO795eEGd
 PIN2I9aip6Nf/VTESDlC6AEzHJSB/onHFoIsHHg6swNzk2lfx1909oo7imqE5nBAeWGEV6y6rS
 3Jg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Mar 2021 18:09:00 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/2] [PATCH 0/2] zonefs fixes
Date:   Tue, 16 Mar 2021 10:08:57 +0900
Message-Id: <20210316010859.122006-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A couple of fixes:
- prevent use of sequerntial zone files as swap files
- Fix write offset initialization of asynchronous append write operation
  (for sequential files open with O_APPEND or aio writes issued with
  RWF_APPEND)

Changes from v1:
* Fixed build warning (uninitialized var) in patch 2

Damien Le Moal (2):
  zonefs: prevent use of seq files as swap file
  zonefs: Fix O_APPEND async write handling

 fs/zonefs/super.c | 94 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 10 deletions(-)

-- 
2.30.2

