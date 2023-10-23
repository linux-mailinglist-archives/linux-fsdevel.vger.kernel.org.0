Return-Path: <linux-fsdevel+bounces-951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D787D3F3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F61281262
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E6021A00;
	Mon, 23 Oct 2023 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="gF+0t4lk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EFD219F1
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:30:54 +0000 (UTC)
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281EC8E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:30:52 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100]) by mx-outbound47-12.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Oct 2023 18:30:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwesQhna9Dq9aEg9YW8Ps+zoloZJGn0nOsIoEbbTbIy2N3iSARivk93VrOMIAfXP0yzPXM8ktOYmWaHWPu8D3o1IDGI6fMvRXtJZNXB+Mnh91YHdQXNiUDEQs+71a6+oims+0cy/cFb4CGzUCgpOgKehFYj9UiCoAAHl8FkQfa3OhDiBhMbIHUHlvYlZLHfJ2s2HavcGZEqrxDoRbv9SrP5m7l4OOqzECypNVSBL6JYXK1JfYRzdHL5ut66BykWWNYpqV59EctWfPbD/VDkDELeSPd+tkLPcFsxHcavMFlaw8lGJnCF1ALxVV0/a6TK9KRIM6C+YeB2EL24Rqhqv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMNnSvyz+X7/FGvxqmDw9AMN0exwQanNEnLSs7cxqpg=;
 b=YE5ZW6pZe8GAxZRdxEIOUp0GgbPnsXZwX9+ogc8X1TtekgZos8asWYESaYMm7D7fx2sSZ2GZ7Cv5t52y4ZUGE4tJTmmbLihF1TykZGuLUpbWcKV9c320BX8swBQFCQnj5YHA7Mw66fTEFngc34wcz0dzlFQy5+hianW+fC7lNPjhFFI/S7a2+ksniSNsatYJ+zYQlyiv6nhdEZmYtmyF4z3wVLSXcWsVVWrcG0kWTbpaFC+/z/6WBVDIb3wGUoFfP+KoytleF4D23EOXwERPa+cyPxjH/5yQvQQiPbmLegVcPsWJbzjYZZzxNr2WuOl1D4vycihiQ8FLM3YwmWAfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMNnSvyz+X7/FGvxqmDw9AMN0exwQanNEnLSs7cxqpg=;
 b=gF+0t4lkntptt6JAyJosvwWq9gmnKyzWNZHq+xGqtIqpSJsEMDvEmy0CHWnpz4z+HO8XZlUVGmIl65WBdCOLI6JK6BiowRs1B2Yz7FV1W/9LepzYp6cupg5nTd+PbjC4D9FEXcGoEPuF+g/JZzUWH2Ax5kWbA7O2naoTEqWUofo=
Received: from SJ0PR13CA0162.namprd13.prod.outlook.com (2603:10b6:a03:2c7::17)
 by SN7PR19MB6784.namprd19.prod.outlook.com (2603:10b6:806:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 18:30:45 +0000
Received: from MW2NAM04FT045.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:2c7:cafe::76) by SJ0PR13CA0162.outlook.office365.com
 (2603:10b6:a03:2c7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.15 via Frontend
 Transport; Mon, 23 Oct 2023 18:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT045.mail.protection.outlook.com (10.13.30.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.18 via Frontend Transport; Mon, 23 Oct 2023 18:30:45 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 698D020C684C;
	Mon, 23 Oct 2023 12:31:49 -0600 (MDT)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>,
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH v10 7/8] fuse: Avoid code duplication in atomic open
Date: Mon, 23 Oct 2023 20:30:34 +0200
Message-Id: <20231023183035.11035-8-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023183035.11035-1-bschubert@ddn.com>
References: <20231023183035.11035-1-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT045:EE_|SN7PR19MB6784:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 35745315-6715-45a6-f0d2-08dbd3f62bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+/pyDDxPoeJZtxoA18JMIPPveay7Cll+hFEUqrWiPOB+Co3ccYmwW4CE8X7iLTgtyg06Bwx2rtWX4Ms6oRvhG2pQ7qy6fsXZO9xhmK0htC60JEWs2lFEC/1Pq/u6z7EFbiWg6aOmAtaxhwvQBqe+++jX6pVsz2UVaem6kKg4OVsx4/7W8YwEFxPiLYsZ1Dl70/pY7Xlh5c2TCqUQcq4oP2D7EdcbfNXuMHCv09y4C69JTNNpM0GQVREPIs/OEckg/on7vpY4CIErtbxJVcoKiKNt4fWosgs5qzqNPdQBn1vfkFlD3ynp5wUMDSTk34lH98941rFofE+PumCrHyObwwB1q/nOeZVKv5gszXotXbrtIJaO1MU3A4AaN5UYhLJE0T6cClsivQaA3uSblkpbvCVYSPhU8pvex2/tyEqwuDDCV7cMt66OCNVPZdYZpqBLSVepET7psq19auAtN8qCVwOhFm7LumJiFU67gmkKYx9qtS33HvBENxI7C8qAkw9z0OCb7KVJYMWrNb4Kdd8s8Di/fUg6FCb2nghecdZJm3R4wB0geWngm6JwRAmJcHOsBSuR/KSccSvqCsWO0OdJEbxLfnkMUHFRvouFEh4zoNCuXWSussWjLueRJx++K0lhIWZ+1Enc+QtX3V1PMoxTb+0yDFsvDfl2oI73k0aJ7UtSEDHE+W/E/pDxccRUP3BWYrlOdr4YoNYeKRJmR6RYeWsa63dBaY0o/C0veebWf/Ebg/CZTDZfmGV0s00/YsgD65ZQ8n3VMCUGJ/ywVJToiw==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39850400004)(346002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(36860700001)(47076005)(83380400001)(6666004)(478600001)(26005)(54906003)(70206006)(316002)(6916009)(70586007)(2616005)(86362001)(336012)(1076003)(6266002)(82740400003)(36756003)(81166007)(356005)(8676002)(8936002)(4326008)(41300700001)(40480700001)(2906002)(5660300002)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ssePut79hxgzQYTHrTU+AFuWGp/05K+hHloxJcuDrEtToeN7qwqp+2HX8ah88dzyajDDeyUajmWnNad/re4TmIcO/oVyhH0wBwsulO8HMLDoMAqfEehX+X0fXHq6zm/Nk+393ZfEgm23fcSgiHF3ntJ5xPs10ERuasVRKO0hb3JdqytdJYVbmFws8X/2rmChTGlUW1CANjqaczfvGvf9+odM589rg3hkbk8Jx9pCL+/Oyjpoihh6ruOlAsmcRF1chdCnDijjDJh6jP5vTgiEA7Ub4MgjMRVUFKK4/9n4Zbdocl+XTgYrFTHV30ewQ6lQP86GLyeKR3DTsG7x+MoOTxXKdHk3NH9ezw1xu76+Mjt2eGwOgBSuKzpFv40CeBIt1IyqVIy48U6WJ57w0XaUjCEb10yUjm9K7au1lIDzdHcnn9yav7Jfkm19cajACFAcoyhDHa5CCazZZobi0Zg9SgOOOmYsie4WZpjUKtE/HZuLNXt9+zm3+m/Gtz0FRXCS1sLCS893qJWzgmsVpZRDQcA+bPPgAgmozmE4lkt2YC0ZPZIN+p0XIlVy/Z8iceMm5Hqnwpw9/51jqLUUc0kJsI/vsYRSq1WbSYbqzVgY427/byMQn2qsylG0HTOT1ATbR3DgijmCMBYeZ/E2nekN+G2eezxoNTKjOzmuZjbG1wqZ27x7YtKQsyIdlsUhOaWaGdQs4bQcjXFRKcJUWU5AzzROzTUJ5HAlTYsfE75KjllrUpukdmW16EWqQUg/OQtbyq6C+UeliZavwRWDn31ni7NJUEVTIHjZyq47D1Wd8Abnf1PNC1MovB+vAWaCRKHAYZJwKp8jpWw7DMf0UFMZ9N1AANU2RP7euS/mehfqQ88=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:30:45.1887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35745315-6715-45a6-f0d2-08dbd3f62bc2
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2NAM04FT045.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6784
X-BESS-ID: 1698085848-112044-12589-1010-1
X-BESS-VER: 2019.1_20231020.1656
X-BESS-Apparent-Source-IP: 104.47.70.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWRiZAVgZQ0MzczMw4OTHFwM
	QsLTHNzMzAIMnQ1NI8KSUpydjY0DBZqTYWAA6O2O1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251639 [from 
	cloudscan10-35.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The same code was used in fuse_atomic_open_revalidate()
_fuse_atomic_open().

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Horst Birthelmer <hbirthelmer@ddn.com>
Cc: linux-fsdevel@vger.kernel.org

---
(If preferred, this could be merged into the main fuse atomic
revalidate patch). Or adding the function could be moved up
in the series.
---
 fs/fuse/dir.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a770c0a6e022..c4564831af3c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -801,6 +801,25 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	return finish_no_open(file, res);
 }
 
+static struct dentry *fuse_atomic_open_alloc_dentry(struct dentry *entry,
+						    wait_queue_head_t *wq)
+{
+	struct dentry *new;
+
+	d_drop(entry);
+	new = d_alloc_parallel(entry->d_parent, &entry->d_name,
+			       wq);
+	if (IS_ERR(new))
+		return new;
+
+	/* XXX Can this happen at all and there a way to handle it? */
+	if (unlikely(!d_in_lookup(new))) {
+		dput(new);
+		new = ERR_PTR(-EIO);
+	}
+	return new;
+}
+
 /**
  * Revalidate inode hooked into dentry against freshly acquired
  * attributes. If inode is stale then allocate new dentry and
@@ -829,17 +848,9 @@ fuse_atomic_open_revalidate(struct fuse_conn *fc, struct dentry *entry,
 		struct dentry *new = NULL;
 
 		if (!switched && !d_in_lookup(entry)) {
-			d_drop(entry);
-			new = d_alloc_parallel(entry->d_parent, &entry->d_name,
-					       wq);
+			new = fuse_atomic_open_alloc_dentry(entry, wq);
 			if (IS_ERR(new))
 				return new;
-
-			if (unlikely(!d_in_lookup(new))) {
-				dput(new);
-				new = ERR_PTR(-EIO);
-				return new;
-			}
 		}
 
 		fuse_invalidate_entry(entry);
@@ -993,27 +1004,15 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 
 	/* prevent racing/parallel lookup */
 	if (!(flags & O_CREAT) && !d_in_lookup(entry)) {
-		d_drop(entry);
-		switched_entry = d_alloc_parallel(entry->d_parent,
-						   &entry->d_name, &wq);
+		switched_entry = fuse_atomic_open_alloc_dentry(entry, &wq);
 		if (IS_ERR(switched_entry)) {
-			err = PTR_ERR(switched_entry);
-			switched_entry = NULL;
-			goto out_free_ff;
-		}
-
-		if (unlikely(!d_in_lookup(switched_entry))) {
-			/* fall back */
-			dput(switched_entry);
-			switched_entry = NULL;
-
 			if (!inode) {
+				switched_entry = NULL;
 				goto free_and_fallback;
 			} else {
-				/* XXX can this happen at all and is there a
-				 * better way to handle it?
-				 */
-				err = -EIO;
+				/* XXX Is there a better way to handle it? */
+				err = PTR_ERR(switched_entry);
+				switched_entry = NULL;
 				goto out_free_ff;
 			}
 		}
-- 
2.39.2


