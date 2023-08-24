Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE53978739C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 17:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240834AbjHXPH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242118AbjHXPHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:07:10 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5E719A6
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 08:07:05 -0700 (PDT)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105]) by mx-outbound-ea17-82.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 24 Aug 2023 15:06:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJggNZ4NmoKtFzsLayq5FEcW82w1QNL2YxLuk+52oBdaRzXQVDLTfA8a4vxMQRbDqkhv22eUNxCEbaCyKKybIRnONk2cyaC9sYpT6vIot6n3SpUNOmCnR1nIhhFgI6PyouvyFlWjvea7VnU1RDLy2aNTf2/B8WcaKI3OYWyp1x4yxiqBBmryCO6EyFaK95Ypvq8zuNsj5mCChciIX5YD9KsEKrn+OXSg8tRXz0Jl6dBg5bZ9ps1VwcGmJ40gerJwtNWFGR2+8UScKC2TZny65HaOQyWUZyFjsYI0mhwjlDgmhL5ZCGrvzvTt3OXg6Xrx0DB9rIfUkshcWnii+qd9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lTNrwulir3onAf7S/QafsprHuIPEf1SiXXrxq2zNTw=;
 b=P+XT8sp9IhvYJ/g069tdiZaECq5RcSk/rAkAGCBTjkGQHJL6hQlaUUEC3DnEkcu8//S15d4pmSqAzqknHPVFsgS3T44WwnN407a2G3d1YStNYuD9LfqAGUaavW8u++yxWqih4npTbG4gc/H75WNmWEecRvL4yWpAJ89D2qqN18AfORpvXMlioAPgUplSrD96uA/uYGp/5Eh98ekbwlF7mbBgtCUdwOmh3oT3ZWuGtQnJo29UXzZRceldY7OBCGb9Yo2CMS7hLtOlAopQuEbTHIqb+mNqM7VAqw2UVX56283U+hRuqBGJ+7Pwka8NfBZiUgAC5dKVYqTyRWxgGUtZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lTNrwulir3onAf7S/QafsprHuIPEf1SiXXrxq2zNTw=;
 b=b3YS+G8yjz94yUOEWtbL2+TUcQrI3H7JBZaRWa+odsZozCM3p8NAcVd9XR/Ectx60d22uVyp15Bix06HYbObc0AWI4CaxwcLx2gS7HWOQ8AyDtbkUZmvFbghu5CLgrWG/VU3WjbmMwvtFAOiQ4SJAiX3sJ5LrgTIbIt9TnFHg0U=
Received: from DM6PR06CA0041.namprd06.prod.outlook.com (2603:10b6:5:54::18) by
 SA1PR19MB7157.namprd19.prod.outlook.com (2603:10b6:806:2ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 15:06:12 +0000
Received: from DM6NAM04FT008.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::cf) by DM6PR06CA0041.outlook.office365.com
 (2603:10b6:5:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 15:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT008.mail.protection.outlook.com (10.13.158.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.17 via Frontend Transport; Thu, 24 Aug 2023 15:06:11 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 8368220C684B;
        Thu, 24 Aug 2023 09:07:17 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH 4/5] [RFC] fuse: Set and use IOCB_DIRECT when FOPEN_DIRECT_IO is set
Date:   Thu, 24 Aug 2023 17:05:32 +0200
Message-Id: <20230824150533.2788317-5-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824150533.2788317-1-bschubert@ddn.com>
References: <20230824150533.2788317-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT008:EE_|SA1PR19MB7157:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b75a8b3e-4712-49e5-193b-08dba4b3a761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/3u2vOExTHiMvdniEBvOg+XjgItYipYpyMEH2ckTbuFcP9fzji7ssr6ipTcSWkU05mr/7mZHOEl24agUJPRdVNGGLw+Rj1I63Wz7y4k9VcDfgzkLuoPac4O0ImVBUz5QsDOSXocIcz9SLJyupHc8MO/K1/y00pHujq096ZGSWv1cuuOcIzvMjY1u7Y361SHugiuyK9J3ntvBDxXKn1ZuYJcaKTI5sgnj0lPJeHEgHcnTCv3M1+0or/AZ2MLZymMal359p5nVsWz3YEDiQ0YdlV9cBT0L/fxGf61nGJircYiowoWM3Rg8gHOc6c8XFk5okq4tNPS8meJdEDoK+PpklXYqZdWyuwgT5nmDpvMEO55Xcq5Om0e5jsMN8l8tC7fQUGIZrkTxySdBmF5fBRUkami85FceVXFm2IovYv2l/vaRK/J5rgAQM6zLWgl0H5HbRrsC1k8tfiPT2NmVBapPP15j+GPjFAT/dCW0zJ64op5CN7vSHsuVOAUNn6aP7pPbHkvAD4O64V1k6uyYjlNFyBQH1LkI1i8fiifTbRxBxgZu8z+cF1nkWGioBi/KXCEh9LlC41Hsb/qP3iHcgUmVHGwWEj5aTzZ6fEn1EdNQADLdT9Pf8bVIpbBlPSg1GXPYNJWVQCPQbj70QE1mfb/8uVcb6XD5nikt7cVzjhv3pu/rtCME/5P8dGFHc7ddU5i3MK2LvsxA48mARlOjz776d9vl8msSN9Kg/flL1gvum4iMyBoIUDiAq2fBx3vTY7B
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39850400004)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(2616005)(8936002)(4326008)(8676002)(83380400001)(5660300002)(1076003)(336012)(6266002)(36756003)(36860700001)(47076005)(40480700001)(26005)(82740400003)(6666004)(81166007)(70206006)(70586007)(54906003)(6916009)(316002)(478600001)(356005)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OHb11QDoik0ZbznC6niWOInHiG2dfa4Nr85dSJumUbifBvpoo2FOzfdRTXe441d+Z2O6nEQ2JNawC3b0QV1U/TfpxTsh5KnKjO9kjjw1qshzDbZHRteLcH/uA0UBZrG8O+JphCpKb4xwXEtBs3XFk5W6JhkKF4HmSDFqWlCLPNRW+xpOjNyEI9KUsfYIWKYSyvGbmO8aH4sspnRWeLPXAbkudvYC0VeOuEH3PvtEz6L8RTDbFIGu621OcZ58kehHuwiTZixy4H0m/42bshhecPzKtR14DAQmNfi+tvCeiFZW97L7AuToNP4waFzlCsOcc7MPw6PK/NJiBapopH8IEeBc/k04o0htSPIzbfOZt9y0TNnr/VIa80qKaYuExDo5QlkL+gsJFIB418YRP81tYTDlNdSOdHQUVKSsFnROOMBAMvVwxSdlpiAsubd0EHAJJPlJPlAmxh7K2+54alG3DGgZF9i7GRx4Qdfs77J1NtpkKcOOqtQQrj73l2DCNos2Lu09N3vuEzpfjgrB0KeFjfpHU5r3I7fJUJIJlQH0GiAgoxHKqU75kIJNC+RGr6zHCjVyb4vh/m8ZSzk6W9LD7CLDTEyRGunA1Kh+iId5ihMgY/y0RKh9kb95vgEcksjPoCeQ6Zbh520J5gbyobGgskTr0aVbvKmhnbROXpqOl63PCqk16/FdfqiNab5xbGwVb125fWu5pDcL8PXh4966qPEtff6Jt27bEsWj6TLgpqtKRYScFUXz2V7Sm3clDpQnfrTyX02cfOxvh81rPgk2GQ/dJHwKendD17H0f99YOwySd9/zdPVoYflLQiZdrZTxo8NWI5GFofBeDQx/r+rAsDVea5WlhXvNjYCWUZ81qOr2ZTLKe/jJwa3Meco5nLwzBIomgiGvOU1M+PEj+19dBQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 15:06:11.6535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b75a8b3e-4712-49e5-193b-08dba4b3a761
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT008.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB7157
X-BESS-ID: 1692889583-104434-4698-9397-1
X-BESS-VER: 2019.3_20230821.1520
X-BESS-Apparent-Source-IP: 104.47.55.105
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWRiZAVgZQ0NTCINEy2cgsNT
        XNxMjUzMg40dDIwNgkOdnU3DDFyMhAqTYWAG0nvuxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250361 [from 
        cloudscan19-64.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fuse_direct_write_iter is basically duplicating what is already
in fuse_cache_write_iter/generic_file_direct_write. That can be
avoided by setting IOCB_DIRECT in fuse_file_write_iter, after that
fuse_cache_write_iter can be used for the FOPEN_DIRECT_IO code path
and fuse_direct_write_iter can be removed.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 54 ++++----------------------------------------------
 1 file changed, 4 insertions(+), 50 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 905ce3bb0047..09277a54b711 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1589,52 +1589,6 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return res;
 }
 
-static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
-	ssize_t res;
-	bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
-
-	/*
-	 * Take exclusive lock if
-	 * - Parallel direct writes are disabled - a user space decision
-	 * - Parallel direct writes are enabled and i_size is being extended.
-	 *   This might not be needed at all, but needs further investigation.
-	 */
-	if (exclusive_lock)
-		inode_lock(inode);
-	else {
-		inode_lock_shared(inode);
-
-		/* A race with truncate might have come up as the decision for
-		 * the lock type was done without holding the lock, check again.
-		 */
-		if (fuse_direct_write_extending_i_size(iocb, from)) {
-			inode_unlock_shared(inode);
-			inode_lock(inode);
-			exclusive_lock = true;
-		}
-	}
-
-	res = generic_write_checks(iocb, from);
-	if (res > 0) {
-		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
-			res = fuse_direct_IO(iocb, from);
-		} else {
-			res = fuse_direct_io(&io, from, &iocb->ki_pos,
-					     FUSE_DIO_WRITE);
-			fuse_write_update_attr(inode, iocb->ki_pos, res);
-		}
-	}
-	if (exclusive_lock)
-		inode_unlock(inode);
-	else
-		inode_unlock_shared(inode);
-
-	return res;
-}
-
 static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *file = iocb->ki_filp;
@@ -1665,10 +1619,10 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
-		return fuse_cache_write_iter(iocb, from);
-	else
-		return fuse_direct_write_iter(iocb, from);
+	if (ff->open_flags & FOPEN_DIRECT_IO)
+		iocb->ki_flags |= IOCB_DIRECT;
+
+	return fuse_cache_write_iter(iocb, from);
 }
 
 static void fuse_writepage_free(struct fuse_writepage_args *wpa)
-- 
2.39.2

