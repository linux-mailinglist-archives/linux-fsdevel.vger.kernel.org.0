Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F0385E84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389725AbfHHJcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:32:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59697 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389565AbfHHJcF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256725; x=1596792725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lUU9T54QR52TyC+Jq5zzRhvcQsB4/EQha/EEg5ySYzA=;
  b=OeEqd8ckmVrF6kJ/G/A+8v54jlCbmIfAhpARIWXcft4gC5UFyHUf93Q1
   pTKZCSulDthc0eySGQB2D7+XgmBTS1RlXIKVETwDjiHntShuINBxoLXFq
   +mm/wjpil5Vs5ovtBuD4tUDUxnGixe3p+LRkBWZyyaC3MogxLAQPtMYqo
   LsLySVjucWRE9XEgRQQyv4zUr+6Km6hl958EX/Q7UEZZTtxHTdGEJmbru
   sIfynvXhjjfczvNh9UZ0qDB+mNN+sPW7CFpFISALjH31+ruXw55a8cKba
   BpnBbd7p8QHSB6CREZrxCqXop9IoUBOSi9fE2GzT2hZTgNdHXD9yJ6V/Z
   A==;
IronPort-SDR: 0TvEN1yKtNhNhxWNZQo6AnKJAt2+l2LL9oFQB52W7bUAzSkE2r7DzhM7VOc5uQwzOPL69rQ6jk
 H5PNnZddHhuqP9MTjnLYIYq3OGaaFcZXWMvG4eJSzGN7m9yYDlNftzQ+FNTpWsKzK90gY1sHFR
 h6AzHSLGTwO5N/vVrzfrVFSWiVN4ZkFkmTehkq+h4SGHo/C3WpO+lFZTJxJw0EYRP2bkeHGPto
 J3ltGm6Fw/NwqQSkSmCJHaMcOvywinENVShD7fMYNhIKN1jQzeOHVGso/e2he2Ooo4HHZRbUia
 Vg8=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363426"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:32:05 +0800
IronPort-SDR: STKCcgI/glddXFOD+zJijbLWCH60+819MlpO4+QKT0omDEAG31dRGqCxVMuivaHpUeJQ1m366T
 F4MgjnbttefLYVtrh9UpdnXQM4JHyl1AuP9pI5hmfPJHhsKFtvCJWfXlpyOE8aiBHq3/wXws4I
 mfP72yxtqPT4Mv1Qsi4Li4+/oeTOSu0jlLhh53X06K5m+QfnfQ8flUWNO9dEHuaFMiflEcj2bL
 e3UwI7CNEX1pBYByZB8mVLk+dlJUo0hdCPIMAiaDMGKnZZzhjpFf9NiDX4zYYWGI+OtbRtUQU8
 8+DZK6KMq2WCXc9KgMVV55pa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:49 -0700
IronPort-SDR: BDeWM+V8lbSQDQcfqQEm7/WRu1o1URSSz3UHOHqyi1GrzNxkXFTMjoaY0D+2t+FjHAm7ETcJEO
 JT0iKYYhjt1nT7DXY03ND6n382qK7nE4woT1H9NLUY6ZJC3sn20IE3PINtgZYUZrTz67/Ydy7c
 G6qghopsycPjmyJQcsBiFAELYdYx9a0kxfvusid5sVQR/vzi7Iyi4tE92RPeplC3kBlj+3WGQ7
 lJ2QKkyCbUh6RX46jGI1FNuVbS03OBujkB+FdZ+PHJBm3u7ImecToPp6rMbcRcPDKaZFD5I4hK
 wxk=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:32:04 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 27/27] btrfs: enable to mount HMZONED incompat flag
Date:   Thu,  8 Aug 2019 18:30:38 +0900
Message-Id: <20190808093038.4163421-28-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This final patch adds the HMZONED incompat flag to
BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount HMZONED flagged file
system.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 144cf9c13320..b9dc9d4e152d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -294,7 +294,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
+	 BTRFS_FEATURE_INCOMPAT_HMZONED)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-- 
2.22.0

