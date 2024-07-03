Return-Path: <linux-fsdevel+bounces-23025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C12CE926002
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70CE6B2EBCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 12:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB35C17B40E;
	Wed,  3 Jul 2024 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DxOMHxWn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TkG2lG8w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA017A596;
	Wed,  3 Jul 2024 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007925; cv=fail; b=Qy+K+7Ec9MBWP5UZdbQjP2LGciyV0iPEaEPRM2eZB5WP42UXhOCe8nEpST1bg2ZGMrCqlMMyKMJfd+7ZxG28808YobxaLJbcd4Iz+chRhqH+d3jTdi+o1rMBHKYHXuySLr6lVeoZrfI2Xq7QZ5SwzHtS0ROuWzYo36LjQXVXv2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007925; c=relaxed/simple;
	bh=gDHb8TeqJLW/5tpog1TcyWF3474CeuxbYZPADdq3gzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r8uBifCNlS6xRHZQZ19pXEg3t0NzmIJeYdJyXjahsLh3xHAsvcEbVHrtMVuN7WlYDVSJifTGr8yWQPti7jCD0c1BF4IJZsr3dWnQ94NsR2ZksddI9Kq14PqqFCIqdAZXbwkLaVXgWoj4HzdsjlDmJ0enA0lkK8Vm/L+M++gpNPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DxOMHxWn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TkG2lG8w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638OWsY030316;
	Wed, 3 Jul 2024 11:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=RX6BnSrxfjC/UyAUvVq+15y27kl+wsHVpexIot/qX18=; b=
	DxOMHxWnReFQHjzzvbT5YhBjdVfLa1CXbhP2TXsBnM3+F1UHgOFlbudlesQqbok8
	jUIol1Grgdw8Ad8hqzwjJinTzteY4SP0J304u5mi88sPP4frdT9PMghu9E+RM1Ry
	uKhBDuPLrsiNkBAy1SQj6CPNM1+cQbYE52M92z2sy7XQtxk1keZCzif8FWZwXW9M
	IHr4af/9MMVEbfj/AYDzSQLrias+05gYubTTaMZeQv6/STG+mmdLawP1A3TYiobr
	zbm5oBI8flAMMpuMCV6hQEPaXHsk6W3Ddb5UUekFjmaaAjwLF2uvZ1N7hkhbu+Cx
	X7FortzvBXEJLrOhvS8yfw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296b01g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:58:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463BSgtt010204;
	Wed, 3 Jul 2024 11:58:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qfem3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LizJVUrhZl7W19zGd03+SR1G5Q2OK8wcwsgxsHC+HSdLNZhB0lnSBFS6C53r4f5sqUEy8vEqDJFAXbzRzeh8YadS/Fk69ENbz/gFiSLOChvTDm7K5SdtGdbBgxPucokJdwNuweYZiESnHyrD0ApsJED+AF+hklRDoq38yymiDElQM1gibysb6dV4m5B8o/wMOHpmFvbDJdtCXzVTSiBizHqnKTWYJ/PRb7SgKVFiImhXas8vBqhojtX58buWSq17DaHM9zhvkk0+ZkOfI9rf2FPiX9AfA0zlN1HwmPnaH9aDd/bbffDoPl1/kH9IYOjqXK88CFny5vd49yvBA+qKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX6BnSrxfjC/UyAUvVq+15y27kl+wsHVpexIot/qX18=;
 b=e2CXWf2T4crGVHgd7SLubpbDpmovz1X9OZbsVSgBRtdSOWEeP3RXPENppYQBOVvZjIF0S6j8u7lZaLzTvVo1vHPpKXiVx9B+At9kffFTFxGLBid+gR4m8rFwg8F89n+dhVc/HzffQeIe2prLq93xqkkcwYMG5bC0jYwMBVABQglVtXnsYVA6BuplNIzfmtORk1Vv32FPLeF292kD2d4L0CTlZUAo0HkW7VJeza8bXUcKIod6x9tJcT9AneCMj53Y3Rjio0pXL34pn4IqFLmL5UYJqciviaUkdrKl8g214je+UWPONY+qqjAx2sNrvCpDGPsL7WnsnzssfZeiUiNTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RX6BnSrxfjC/UyAUvVq+15y27kl+wsHVpexIot/qX18=;
 b=TkG2lG8wxIB1kv9CY4Zi8fS14eisfRO+21bSZNAN8Un22vzLtd+hA0XC6GKlMRuwAh/HfbDFidmEeWwdnU/pahz+huwFodOLvx80WKA78rKL96cRTzPyBffxq9fOKPqqJ1pETizbzJoLBrAAshVBlRHNwxq4gsT+wfEyheP4kqo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO1PR10MB4676.namprd10.prod.outlook.com (2603:10b6:303:9e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.39; Wed, 3 Jul
 2024 11:58:22 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 11:58:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 7/7] tools: add skeleton code for userland testing of VMA logic
Date: Wed,  3 Jul 2024 12:57:38 +0100
Message-ID: <3303ff9b038710401f079f6eb3ee910876657082.1720006125.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
References: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO1PR10MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b84830-8eb2-47be-94b1-08dc9b576fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?llktaYp6r2zJ5mBa+TZE11SRUzD0UROD2U5WsLH8cU/s6mq+mmskS7MgYGac?=
 =?us-ascii?Q?bklIW7Ir/8c3yAgkxFS7IqsqIXQO9iAP/d7E4X4oBDhMQIkMzZbfRX7egdcN?=
 =?us-ascii?Q?QFqeFtE115EZgtXnj6QfjtUAVZ263WLiU7x3FwaSV+GsSYbq4KXrARjLcMrB?=
 =?us-ascii?Q?xPwZ12KBv6u2BfoCGhMPE98LSbL6JVOtP9dOXtBpq9yc7lRFQy+OxygIozLb?=
 =?us-ascii?Q?cBy4b+7dZRUCziH32aPGNKfUP+cUilkh9/IDDFK+EH6vyR2c1zA75gcBWjrk?=
 =?us-ascii?Q?9nl4lPSultcGl+JwcDkFkwtURdQRLryk8rVKXiMAhZUOAOZWlhisc9AkRUzV?=
 =?us-ascii?Q?FNUSofIh4jrVxDCY2KhgrQ6WX0ajRGgeAcZyyMwneWuhZMoo6SqnALdMgEJB?=
 =?us-ascii?Q?CsJ6PVNnNLkO781xWpC9UBTpL9SjreyMW4rQ3urGbCnRD9AWI1y+AhSAXS/S?=
 =?us-ascii?Q?nEHcV4BmWxyh8Gfygo1WOGjNzBMxiqEoJzPTKBaBdigHlcBfkyEWFj6kUvNh?=
 =?us-ascii?Q?c58lPslOLq44c6tUjobyvgZ0eLKuNtqU0nKUW9NXQ/SICSlQu6VfpVssQV8Y?=
 =?us-ascii?Q?AJGeBtvps/3ZG7Z0Lrw5ldLoQh+Q2OkZEeXWmCbAOZympiFVWwzt0AufZVRy?=
 =?us-ascii?Q?exwD9UeNm186ZDmPukmIzqV+ri47IImUR2kr99ZGHvfW7XQf/kGbrIKkx7Da?=
 =?us-ascii?Q?xAPi8TFf0j8kcxvsroeFSqrZfPAttKPan2M/Fx5etdZvFK6ZgWdDNZHzMSYB?=
 =?us-ascii?Q?Lcl0wKk16rWnI5ly9ydVEt5ZAjRdG/iGstoRJfWq5KGZkTEJAotExKU4sco2?=
 =?us-ascii?Q?eJnGDmWuxqr6jlqA2gvTkq8M2U6lXp8yqqeApN5wzsCcah/7vdv67lvvMP29?=
 =?us-ascii?Q?Rx3ZXrbYX7VvFySymCXQvPo1WKtFqtHbhr8FC+a6AvwaYH642yJxQtzAkwxh?=
 =?us-ascii?Q?G+TFXKhEFpEMpqDLaiyOvvH8VX5Y2sjcgNDneD0x5A6D7qryFpWEOQcMBhPa?=
 =?us-ascii?Q?ewcwr1y+T8wDq/N/hoEkp01wf+59THi8yc6PyXQmgpidNGvTaxqM16SiZdit?=
 =?us-ascii?Q?Lc96oe4RvZqfhUVNmWjLGyQUhKxih9V0pxrnFRMsnUbisQAKlfGY4NaAVSzt?=
 =?us-ascii?Q?2zwzC25sRpqDbNK2wQcSz4Wyebde/S78iHI/uNeATJytQSXj2VZqHKlaawE0?=
 =?us-ascii?Q?TC34FHi09YqVY8Q9laWBzxDsMu79jn7aq6rgNU80jV8FQimAAjAiS8c7+FKe?=
 =?us-ascii?Q?z9VWAPm5nzcqygTI0Ogh0TDZjKK1LR5+3T4GXdL81e+SOpDo5cG/L0wCRagk?=
 =?us-ascii?Q?ZbjIH01/GAMOcCmCnhq7qsrQI1+lbQBNFyZPraCSSz04Zw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RAh8qoYnEqNGo5MznDHKO9y1M2hEASR9Id3rJzWnuTVsD9h80cOnAepKSNpw?=
 =?us-ascii?Q?H5t8YIRL9SXjI0rAbuBR+dPLYb5j03eNmmMWNxGBnIfOcOdHSyM+tezniaU6?=
 =?us-ascii?Q?5dolhFr31uWbsffmwxLpClfdhghnyKc8xldDbEcKfO8PR7gzvQL3gy1nSKYI?=
 =?us-ascii?Q?veyE4kHftD4ud0keSV5OjyyoLhZN8KRdY41Zf2PVkQCMuuReLGI5HmEpNjC0?=
 =?us-ascii?Q?jHhvyruU77taSxKHZdJ+S8tEcJQCVGMi/Uz49Bw60o/45JUwNil3X4NUoypE?=
 =?us-ascii?Q?4HFzH9Z/xeO+levOhmsb+fRJALR7NBAIEtljR8EmrlrTxEJEGxFdAVyxri05?=
 =?us-ascii?Q?EYsbAxs7w3R0bCrXC0ioEpzgIgRnvIw8mA5BlWLewRk6PqyYCQqe69pjLt1w?=
 =?us-ascii?Q?c3zl3u0pUMM9vT4r+K4LKHZgC5EiRWbaeSymZSjoJjK+5smoqKWIipeiLnOu?=
 =?us-ascii?Q?lUwP6Wek4vGW+6mJ2+JKm0z6bwDp0o9ni02nTtB6gHP7G/qpD85yDBNxgJBC?=
 =?us-ascii?Q?3eXUVwaVSHH0Q1MAqXtnWN4JEAUXe9lzhE0RIRxVetif2l7Dey6cxBJncsBa?=
 =?us-ascii?Q?z4xZNJA5Sh4gBfBAsh75fXSB9n0rhc1kLvnXZ5JoCePJXF65Eh4dJW+4b0Im?=
 =?us-ascii?Q?TuSWK2Y9YcMLxQqY0ClO9P2VQIB7b6DTAOBR5yS0qa/1Bv8d1NWZN7XWS35e?=
 =?us-ascii?Q?7uRg9rohJuP21OGNIVVHycb/mfZ2z1GItJVEaueoSw3nhfSvoYDqStfXrHPo?=
 =?us-ascii?Q?psEg7ULgTq4o0fuNtqS9tKpYSKd5GAvfzCvZxYpSIqk959LYLZb2kqcL/SYE?=
 =?us-ascii?Q?+VhZQx7dsWJ6ih2g3HFz6SrGw4z3IJRtfNuE4nob8al8wekXfNbxGHHyQqAf?=
 =?us-ascii?Q?Xi6SEz+R4zwDuKYu362SKqCqSsc7YtcTEXASb6/Acuu5QvUDrb5IpzkWZm8y?=
 =?us-ascii?Q?qrfj08kp4VCszckJD8mgUEyomurRHFeDGz90JGmDmUnwxon3VaoQXM2y4kZZ?=
 =?us-ascii?Q?qPmWTdyB/srbFHFJDqQQw+bKopfyTGCRCzXbGM6Xu7F5LLo+C5zHLiDDRKIc?=
 =?us-ascii?Q?EHsA5eX9ot+Oxaw9VUNEem9Ebkn3Z9759q7nu3WCVbzMrf6o3skmeuo44EO2?=
 =?us-ascii?Q?ZMfxusMGlHmU0liXeza+vbH6Gk2Asg41ZbEir3ooqrYZCe0YaQVhzmnjHg3n?=
 =?us-ascii?Q?TcOJrAP4zvTA3QnEwBoX2BMesVNvg4mbVdpX2jOSnphfD8o2w3KfnbYhUlP/?=
 =?us-ascii?Q?vdqvwEa0+w7oE7Mgyfsk4asQ4n9WYDe19woq6TKXZcEKVlv8qJoTpuHfNfbq?=
 =?us-ascii?Q?TJwf0gkR39mqs2FPHlW5Ik8hhT3Rz7cimWziCCoE177fglSEftMf+m1HGnYh?=
 =?us-ascii?Q?mO7CcNTwU+z41wI3u16zlt/bIO0SZU3u1KIfI0hxQqdcfL6cW/J98UL4Smgo?=
 =?us-ascii?Q?FpHHkwZIGMz6s9qmrkMLfdyJCQh5bVslxw160OzqEttN7tDOVM+9j0BIDP8t?=
 =?us-ascii?Q?SsgN3T7ncPwHBXHta5oRkZHIqlEJNZMxhZIcSHMefZ0gK/P3MPQ6KXubyM6p?=
 =?us-ascii?Q?DPtSW9McrrmrtUCc+fNg7nK8vuhSB96ms1Q9J6sbYDKZDVPYmKbDgSFKKs/z?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	evXj8rr/Z1mQHGNA48gQYqcT5JPcldvvf2YZYerMzBLhYImztBnQFLc5it5J431o0JvBjuDv7Snz0tFQEYW6KOrDou+O8gwz0uADKeJ+QqKdjxJcOnu+KL6HQ27OsHVjOpo65nB9lmClzYBsHhgcVcR2dIZ3Vc3qKOIfILL18mqUhj5v0wtqqyQCaUch0gnhBGl9mVzzDPthIp2Njtrxd2MzR2pmfuf2tIYMD3y1GAz9y/5SkECjp7JGlmZhaIMRYJ/Gw7JKu4xMAFSAnmV8Z7QyU8p3ZhWlls+GGpWTMBfY4FhYL22Hh3YIp/LKGLh6Cy5inkQie26AkXFycqcTsAoLyckGwPyv+lQnFDY2/L6WJ5wF7Kcl/Dd3uWLi24LaiggsibMkq/rwyRttFdOnXYVS7zYbpfxg29/Y/u2yBGjpVzblS5lTXIVFLiY706fHXIzegOrWBd60ss4bNs2ZW1/z+A87v/Y6dAKS83t4uWyX4TcQrehPh0yMXnIv/msbaF9q/U4Zj3IWqMDmFDUNTH/VfJuDeafX/8YcElQ1D5cXLLARM0ngxqNYfZ8/D3kg9XfhtZ/sSMjp/kUdNqwk+CS2hSWObeoWM6CnkPAgmvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b84830-8eb2-47be-94b1-08dc9b576fee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:58:22.4891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKKL9LJ8BHX/a+8FF05fPhEydo4HmihCALT8O4igTwTgRUL12XMXz3qv2vfuCUU7Ra67UMvKeD9QPMhLeJnOs7GP95m3s1TKGFs+Re2qpEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_07,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030087
X-Proofpoint-GUID: eFGVxUTKETqnAtLNj_Lph5XHaVrtT69J
X-Proofpoint-ORIG-GUID: eFGVxUTKETqnAtLNj_Lph5XHaVrtT69J

Establish a new userland VMA unit testing implementation under
tools/testing which utilises existing logic providing maple tree support in
userland utilising the now-shared code previously exclusive to radix tree
testing.

This provides fundamental VMA operations whose API is defined in mm/vma.h,
while stubbing out superfluous functionality.

This exists as a proof-of-concept, with the test implementation functional
and sufficient to allow userland compilation of vma.c, but containing only
cursory tests to demonstrate basic functionality.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS                            |   1 +
 include/linux/atomic.h                 |   2 +-
 include/linux/mmzone.h                 |   3 +-
 tools/testing/vma/.gitignore           |   6 +
 tools/testing/vma/Makefile             |  16 +
 tools/testing/vma/errors.txt           |   0
 tools/testing/vma/generated/autoconf.h |   2 +
 tools/testing/vma/linux/atomic.h       |  12 +
 tools/testing/vma/linux/mmzone.h       |  38 ++
 tools/testing/vma/vma.c                | 207 ++++++
 tools/testing/vma/vma_internal.h       | 882 +++++++++++++++++++++++++
 11 files changed, 1167 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/vma/.gitignore
 create mode 100644 tools/testing/vma/Makefile
 create mode 100644 tools/testing/vma/errors.txt
 create mode 100644 tools/testing/vma/generated/autoconf.h
 create mode 100644 tools/testing/vma/linux/atomic.h
 create mode 100644 tools/testing/vma/linux/mmzone.h
 create mode 100644 tools/testing/vma/vma.c
 create mode 100644 tools/testing/vma/vma_internal.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ff3e113ed081..c21099d0a123 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23983,6 +23983,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	mm/vma.c
 F:	mm/vma.h
 F:	mm/vma_internal.h
+F:	tools/testing/vma/

 VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9..badfba2fd10f 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -81,4 +81,4 @@
 #include <linux/atomic/atomic-long.h>
 #include <linux/atomic/atomic-instrumented.h>

-#endif /* _LINUX_ATOMIC_H */
+#endif	/* _LINUX_ATOMIC_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 41458892bc8a..30a22e57fa50 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1,4 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
 #ifndef _LINUX_MMZONE_H
 #define _LINUX_MMZONE_H

diff --git a/tools/testing/vma/.gitignore b/tools/testing/vma/.gitignore
new file mode 100644
index 000000000000..d915f7d7fb1a
--- /dev/null
+++ b/tools/testing/vma/.gitignore
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+generated/bit-length.h
+generated/map-shift.h
+idr.c
+radix-tree.c
+vma
diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
new file mode 100644
index 000000000000..70e728f2eee3
--- /dev/null
+++ b/tools/testing/vma/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+.PHONY: default
+
+default: vma
+
+include ../shared/shared.mk
+
+OFILES = $(SHARED_OFILES) vma.o maple-shim.o
+TARGETS = vma
+
+vma:	$(OFILES) vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
+	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
+
+clean:
+	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h
diff --git a/tools/testing/vma/errors.txt b/tools/testing/vma/errors.txt
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/vma/generated/autoconf.h b/tools/testing/vma/generated/autoconf.h
new file mode 100644
index 000000000000..92dc474c349b
--- /dev/null
+++ b/tools/testing/vma/generated/autoconf.h
@@ -0,0 +1,2 @@
+#include "bit-length.h"
+#define CONFIG_XARRAY_MULTI 1
diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
new file mode 100644
index 000000000000..e01f66f98982
--- /dev/null
+++ b/tools/testing/vma/linux/atomic.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_ATOMIC_H
+#define _LINUX_ATOMIC_H
+
+#define atomic_t int32_t
+#define atomic_inc(x) uatomic_inc(x)
+#define atomic_read(x) uatomic_read(x)
+#define atomic_set(x, y) do {} while (0)
+#define U8_MAX UCHAR_MAX
+
+#endif	/* _LINUX_ATOMIC_H */
diff --git a/tools/testing/vma/linux/mmzone.h b/tools/testing/vma/linux/mmzone.h
new file mode 100644
index 000000000000..e6a96c686610
--- /dev/null
+++ b/tools/testing/vma/linux/mmzone.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_MMZONE_H
+#define _LINUX_MMZONE_H
+
+#include <linux/atomic.h>
+
+struct pglist_data *first_online_pgdat(void);
+struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
+
+#define for_each_online_pgdat(pgdat)			\
+	for (pgdat = first_online_pgdat();		\
+	     pgdat;					\
+	     pgdat = next_online_pgdat(pgdat))
+
+enum zone_type {
+	__MAX_NR_ZONES
+};
+
+#define MAX_NR_ZONES __MAX_NR_ZONES
+#define MAX_PAGE_ORDER 10
+#define MAX_ORDER_NR_PAGES (1 << MAX_PAGE_ORDER)
+
+#define pageblock_order		MAX_PAGE_ORDER
+#define pageblock_nr_pages	BIT(pageblock_order)
+#define pageblock_align(pfn)	ALIGN((pfn), pageblock_nr_pages)
+#define pageblock_start_pfn(pfn)	ALIGN_DOWN((pfn), pageblock_nr_pages)
+
+struct zone {
+	atomic_long_t		managed_pages;
+};
+
+typedef struct pglist_data {
+	struct zone node_zones[MAX_NR_ZONES];
+
+} pg_data_t;
+
+#endif /* _LINUX_MMZONE_H */
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
new file mode 100644
index 000000000000..1f32bc4d60c2
--- /dev/null
+++ b/tools/testing/vma/vma.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "maple-shared.h"
+#include "vma_internal.h"
+
+/*
+ * Directly import the VMA implementation here. Our vma_internal.h wrapper
+ * provides userland-equivalent functionality for everything vma.c uses.
+ */
+#include "../../../mm/vma.c"
+
+const struct vm_operations_struct vma_dummy_vm_ops;
+
+#define ASSERT_TRUE(_expr)						\
+	do {								\
+		if (!(_expr)) {						\
+			fprintf(stderr,					\
+				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
+				__FILE__, __LINE__, __FUNCTION__, #_expr); \
+			return false;					\
+		}							\
+	} while (0)
+#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
+#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
+#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
+
+static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
+					unsigned long start,
+					unsigned long end,
+					pgoff_t pgoff,
+					vm_flags_t flags)
+{
+	struct vm_area_struct *ret = vm_area_alloc(mm);
+
+	if (ret == NULL)
+		return NULL;
+
+	ret->vm_start = start;
+	ret->vm_end = end;
+	ret->vm_pgoff = pgoff;
+	ret->__vm_flags = flags;
+
+	return ret;
+}
+
+static bool test_simple_merge(void)
+{
+	struct vm_area_struct *vma;
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	struct vm_area_struct *vma_left = alloc_vma(&mm, 0, 0x1000, 0, flags);
+	struct vm_area_struct *vma_middle = alloc_vma(&mm, 0x1000, 0x2000, 1, flags);
+	struct vm_area_struct *vma_right = alloc_vma(&mm, 0x2000, 0x3000, 2, flags);
+	VMA_ITERATOR(vmi, &mm, 0x1000);
+
+	ASSERT_FALSE(vma_link(&mm, vma_left));
+	ASSERT_FALSE(vma_link(&mm, vma_middle));
+	ASSERT_FALSE(vma_link(&mm, vma_right));
+
+	vma = vma_merge_new_vma(&vmi, vma_left, vma_middle, 0x1000,
+				0x2000, 1);
+	ASSERT_NE(vma, NULL);
+
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x3000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_EQ(vma->vm_flags, flags);
+
+	vm_area_free(vma);
+	mtree_destroy(&mm.mm_mt);
+
+	return true;
+}
+
+static bool test_simple_modify(void)
+{
+	struct vm_area_struct *vma;
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	struct vm_area_struct *init_vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
+	VMA_ITERATOR(vmi, &mm, 0x1000);
+
+	ASSERT_FALSE(vma_link(&mm, init_vma));
+
+	/*
+	 * The flags will not be changed, the vma_modify_flags() function
+	 * performs the merge/split only.
+	 */
+	vma = vma_modify_flags(&vmi, init_vma, init_vma,
+			       0x1000, 0x2000, VM_READ | VM_MAYREAD);
+	ASSERT_NE(vma, NULL);
+	/* We modify the provided VMA, and on split allocate new VMAs. */
+	ASSERT_EQ(vma, init_vma);
+
+	ASSERT_EQ(vma->vm_start, 0x1000);
+	ASSERT_EQ(vma->vm_end, 0x2000);
+	ASSERT_EQ(vma->vm_pgoff, 1);
+
+	/*
+	 * Now walk through the three split VMAs and make sure they are as
+	 * expected.
+	 */
+
+	vma_iter_set(&vmi, 0);
+	vma = vma_iter_load(&vmi);
+
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x1000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+
+	vm_area_free(vma);
+	vma_iter_clear(&vmi);
+
+	vma = vma_next(&vmi);
+
+	ASSERT_EQ(vma->vm_start, 0x1000);
+	ASSERT_EQ(vma->vm_end, 0x2000);
+	ASSERT_EQ(vma->vm_pgoff, 1);
+
+	vm_area_free(vma);
+	vma_iter_clear(&vmi);
+
+	vma = vma_next(&vmi);
+
+	ASSERT_EQ(vma->vm_start, 0x2000);
+	ASSERT_EQ(vma->vm_end, 0x3000);
+	ASSERT_EQ(vma->vm_pgoff, 2);
+
+	vm_area_free(vma);
+	mtree_destroy(&mm.mm_mt);
+
+	return true;
+}
+
+static bool test_simple_expand(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x1000, 0, flags);
+	VMA_ITERATOR(vmi, &mm, 0);
+
+	ASSERT_FALSE(vma_link(&mm, vma));
+
+	ASSERT_FALSE(vma_expand(&vmi, vma, 0, 0x3000, 0, NULL));
+
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x3000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+
+	vm_area_free(vma);
+	mtree_destroy(&mm.mm_mt);
+
+	return true;
+}
+
+static bool test_simple_shrink(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
+	VMA_ITERATOR(vmi, &mm, 0);
+
+	ASSERT_FALSE(vma_link(&mm, vma));
+
+	ASSERT_FALSE(vma_shrink(&vmi, vma, 0, 0x1000, 0));
+
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x1000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+
+	vm_area_free(vma);
+	mtree_destroy(&mm.mm_mt);
+
+	return true;
+}
+
+int main(void)
+{
+	int num_tests = 0, num_fail = 0;
+
+	maple_tree_init();
+
+#define TEST(name)							\
+	do {								\
+		num_tests++;						\
+		if (!test_##name()) {					\
+			num_fail++;					\
+			fprintf(stderr, "Test " #name " FAILED\n");	\
+		}							\
+	} while (0)
+
+	TEST(simple_merge);
+	TEST(simple_modify);
+	TEST(simple_expand);
+	TEST(simple_shrink);
+
+#undef TEST
+
+	printf("%d tests run, %d passed, %d failed.\n",
+	       num_tests, num_tests - num_fail, num_fail);
+
+	return EXIT_SUCCESS;
+}
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
new file mode 100644
index 000000000000..093560e5b2ac
--- /dev/null
+++ b/tools/testing/vma/vma_internal.h
@@ -0,0 +1,882 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * vma_internal.h
+ *
+ * Header providing userland wrappers and shims for the functionality provided
+ * by mm/vma_internal.h.
+ *
+ * We make the header guard the same as mm/vma_internal.h, so if this shim
+ * header is included, it precludes the inclusion of the kernel one.
+ */
+
+#ifndef __MM_VMA_INTERNAL_H
+#define __MM_VMA_INTERNAL_H
+
+#define __private
+#define __bitwise
+#define __randomize_layout
+
+#define CONFIG_MMU
+#define CONFIG_PER_VMA_LOCK
+
+#include <stdlib.h>
+
+#include <linux/list.h>
+#include <linux/maple_tree.h>
+#include <linux/mm.h>
+#include <linux/rbtree.h>
+#include <linux/rwsem.h>
+
+#define VM_WARN_ON(_expr) (WARN_ON(_expr))
+#define VM_WARN_ON_ONCE(_expr) (WARN_ON_ONCE(_expr))
+#define VM_BUG_ON(_expr) (BUG_ON(_expr))
+#define VM_BUG_ON_VMA(_expr, _vma) (BUG_ON(_expr))
+
+#define VM_NONE		0x00000000
+#define VM_READ		0x00000001
+#define VM_WRITE	0x00000002
+#define VM_EXEC		0x00000004
+#define VM_SHARED	0x00000008
+#define VM_MAYREAD	0x00000010
+#define VM_MAYWRITE	0x00000020
+#define VM_GROWSDOWN	0x00000100
+#define VM_PFNMAP	0x00000400
+#define VM_LOCKED	0x00002000
+#define VM_IO           0x00004000
+#define VM_DONTEXPAND	0x00040000
+#define VM_ACCOUNT	0x00100000
+#define VM_MIXEDMAP	0x10000000
+#define VM_STACK	VM_GROWSDOWN
+#define VM_SHADOW_STACK	VM_NONE
+#define VM_SOFTDIRTY	0
+
+#define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
+#define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
+
+#define FIRST_USER_ADDRESS	0UL
+#define USER_PGTABLES_CEILING	0UL
+
+#define vma_policy(vma) NULL
+
+#define down_write_nest_lock(sem, nest_lock)
+
+#define pgprot_val(x)		((x).pgprot)
+#define __pgprot(x)		((pgprot_t) { (x) } )
+
+#define for_each_vma(__vmi, __vma)					\
+	while (((__vma) = vma_next(&(__vmi))) != NULL)
+
+/* The MM code likes to work with exclusive end addresses */
+#define for_each_vma_range(__vmi, __vma, __end)				\
+	while (((__vma) = vma_find(&(__vmi), (__end))) != NULL)
+
+#define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
+
+#define PHYS_PFN(x)	((unsigned long)((x) >> PAGE_SHIFT))
+
+#define test_and_set_bit(nr, addr) __test_and_set_bit(nr, addr)
+#define test_and_clear_bit(nr, addr) __test_and_clear_bit(nr, addr)
+
+#define TASK_SIZE ((1ul << 47)-PAGE_SIZE)
+
+#define AS_MM_ALL_LOCKS 2
+
+#define current NULL
+
+/* We hardcode this for now. */
+#define sysctl_max_map_count 0x1000000UL
+
+#define pgoff_t unsigned long
+typedef unsigned long	pgprotval_t;
+typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
+typedef unsigned long vm_flags_t;
+typedef __bitwise unsigned int vm_fault_t;
+
+typedef struct refcount_struct {
+	atomic_t refs;
+} refcount_t;
+
+struct kref {
+	refcount_t refcount;
+};
+
+struct anon_vma {
+	struct anon_vma *root;
+	struct rb_root_cached rb_root;
+};
+
+struct anon_vma_chain {
+	struct anon_vma *anon_vma;
+	struct list_head same_vma;
+};
+
+struct anon_vma_name {
+	struct kref kref;
+	/* The name needs to be at the end because it is dynamically sized. */
+	char name[];
+};
+
+struct vma_iterator {
+	struct ma_state mas;
+};
+
+#define VMA_ITERATOR(name, __mm, __addr)				\
+	struct vma_iterator name = {					\
+		.mas = {						\
+			.tree = &(__mm)->mm_mt,				\
+			.index = __addr,				\
+			.node = NULL,					\
+			.status = ma_start,				\
+		},							\
+	}
+
+struct address_space {
+	struct rb_root_cached	i_mmap;
+	unsigned long		flags;
+	atomic_t		i_mmap_writable;
+};
+
+struct vm_userfaultfd_ctx {};
+struct mempolicy {};
+struct mmu_gather {};
+struct mutex {};
+#define DEFINE_MUTEX(mutexname) \
+	struct mutex mutexname = {}
+
+struct mm_struct {
+	struct maple_tree mm_mt;
+	int map_count;			/* number of VMAs */
+	unsigned long total_vm;	   /* Total pages mapped */
+	unsigned long locked_vm;   /* Pages that have PG_mlocked set */
+	unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
+	unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
+	unsigned long stack_vm;	   /* VM_STACK */
+};
+
+struct vma_lock {
+	struct rw_semaphore lock;
+};
+
+
+struct file {
+	struct address_space	*f_mapping;
+};
+
+struct vm_area_struct {
+	/* The first cache line has the info for VMA tree walking. */
+
+	union {
+		struct {
+			/* VMA covers [vm_start; vm_end) addresses within mm */
+			unsigned long vm_start;
+			unsigned long vm_end;
+		};
+#ifdef CONFIG_PER_VMA_LOCK
+		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
+#endif
+	};
+
+	struct mm_struct *vm_mm;	/* The address space we belong to. */
+	pgprot_t vm_page_prot;          /* Access permissions of this VMA. */
+
+	/*
+	 * Flags, see mm.h.
+	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
+	 */
+	union {
+		const vm_flags_t vm_flags;
+		vm_flags_t __private __vm_flags;
+	};
+
+#ifdef CONFIG_PER_VMA_LOCK
+	/* Flag to indicate areas detached from the mm->mm_mt tree */
+	bool detached;
+
+	/*
+	 * Can only be written (using WRITE_ONCE()) while holding both:
+	 *  - mmap_lock (in write mode)
+	 *  - vm_lock->lock (in write mode)
+	 * Can be read reliably while holding one of:
+	 *  - mmap_lock (in read or write mode)
+	 *  - vm_lock->lock (in read or write mode)
+	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
+	 * while holding nothing (except RCU to keep the VMA struct allocated).
+	 *
+	 * This sequence counter is explicitly allowed to overflow; sequence
+	 * counter reuse can only lead to occasional unnecessary use of the
+	 * slowpath.
+	 */
+	int vm_lock_seq;
+	struct vma_lock *vm_lock;
+#endif
+
+	/*
+	 * For areas with an address space and backing store,
+	 * linkage into the address_space->i_mmap interval tree.
+	 *
+	 */
+	struct {
+		struct rb_node rb;
+		unsigned long rb_subtree_last;
+	} shared;
+
+	/*
+	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
+	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
+	 * can only be in the i_mmap tree.  An anonymous MAP_PRIVATE, stack
+	 * or brk vma (with NULL file) can only be in an anon_vma list.
+	 */
+	struct list_head anon_vma_chain; /* Serialized by mmap_lock &
+					  * page_table_lock */
+	struct anon_vma *anon_vma;	/* Serialized by page_table_lock */
+
+	/* Function pointers to deal with this struct. */
+	const struct vm_operations_struct *vm_ops;
+
+	/* Information about our backing store: */
+	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
+					   units */
+	struct file * vm_file;		/* File we map to (can be NULL). */
+	void * vm_private_data;		/* was vm_pte (shared mem) */
+
+#ifdef CONFIG_ANON_VMA_NAME
+	/*
+	 * For private and shared anonymous mappings, a pointer to a null
+	 * terminated string containing the name given to the vma, or NULL if
+	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
+	 */
+	struct anon_vma_name *anon_name;
+#endif
+#ifdef CONFIG_SWAP
+	atomic_long_t swap_readahead_info;
+#endif
+#ifndef CONFIG_MMU
+	struct vm_region *vm_region;	/* NOMMU mapping region */
+#endif
+#ifdef CONFIG_NUMA
+	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
+#endif
+	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+} __randomize_layout;
+
+struct vm_fault {};
+
+struct vm_operations_struct {
+	void (*open)(struct vm_area_struct * area);
+	/**
+	 * @close: Called when the VMA is being removed from the MM.
+	 * Context: User context.  May sleep.  Caller holds mmap_lock.
+	 */
+	void (*close)(struct vm_area_struct * area);
+	/* Called any time before splitting to check if it's allowed */
+	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
+	int (*mremap)(struct vm_area_struct *area);
+	/*
+	 * Called by mprotect() to make driver-specific permission
+	 * checks before mprotect() is finalised.   The VMA must not
+	 * be modified.  Returns 0 if mprotect() can proceed.
+	 */
+	int (*mprotect)(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, unsigned long newflags);
+	vm_fault_t (*fault)(struct vm_fault *vmf);
+	vm_fault_t (*huge_fault)(struct vm_fault *vmf, unsigned int order);
+	vm_fault_t (*map_pages)(struct vm_fault *vmf,
+			pgoff_t start_pgoff, pgoff_t end_pgoff);
+	unsigned long (*pagesize)(struct vm_area_struct * area);
+
+	/* notification that a previously read-only page is about to become
+	 * writable, if an error is returned it will cause a SIGBUS */
+	vm_fault_t (*page_mkwrite)(struct vm_fault *vmf);
+
+	/* same as page_mkwrite when using VM_PFNMAP|VM_MIXEDMAP */
+	vm_fault_t (*pfn_mkwrite)(struct vm_fault *vmf);
+
+	/* called by access_process_vm when get_user_pages() fails, typically
+	 * for use by special VMAs. See also generic_access_phys() for a generic
+	 * implementation useful for any iomem mapping.
+	 */
+	int (*access)(struct vm_area_struct *vma, unsigned long addr,
+		      void *buf, int len, int write);
+
+	/* Called by the /proc/PID/maps code to ask the vma whether it
+	 * has a special name.  Returning non-NULL will also cause this
+	 * vma to be dumped unconditionally. */
+	const char *(*name)(struct vm_area_struct *vma);
+
+#ifdef CONFIG_NUMA
+	/*
+	 * set_policy() op must add a reference to any non-NULL @new mempolicy
+	 * to hold the policy upon return.  Caller should pass NULL @new to
+	 * remove a policy and fall back to surrounding context--i.e. do not
+	 * install a MPOL_DEFAULT policy, nor the task or system default
+	 * mempolicy.
+	 */
+	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
+
+	/*
+	 * get_policy() op must add reference [mpol_get()] to any policy at
+	 * (vma,addr) marked as MPOL_SHARED.  The shared policy infrastructure
+	 * in mm/mempolicy.c will do this automatically.
+	 * get_policy() must NOT add a ref if the policy at (vma,addr) is not
+	 * marked as MPOL_SHARED. vma policies are protected by the mmap_lock.
+	 * If no [shared/vma] mempolicy exists at the addr, get_policy() op
+	 * must return NULL--i.e., do not "fallback" to task or system default
+	 * policy.
+	 */
+	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
+					unsigned long addr, pgoff_t *ilx);
+#endif
+	/*
+	 * Called by vm_normal_page() for special PTEs to find the
+	 * page for @addr.  This is useful if the default behavior
+	 * (using pte_page()) would not find the correct page.
+	 */
+	struct page *(*find_special_page)(struct vm_area_struct *vma,
+					  unsigned long addr);
+};
+
+static inline void vma_iter_invalidate(struct vma_iterator *vmi)
+{
+	mas_pause(&vmi->mas);
+}
+
+static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
+{
+	return __pgprot(pgprot_val(oldprot) | pgprot_val(newprot));
+}
+
+static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	return __pgprot(vm_flags);
+}
+
+static inline bool is_shared_maywrite(vm_flags_t vm_flags)
+{
+	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
+		(VM_SHARED | VM_MAYWRITE);
+}
+
+static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+{
+	return is_shared_maywrite(vma->vm_flags);
+}
+
+static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
+{
+	/*
+	 * Uses mas_find() to get the first VMA when the iterator starts.
+	 * Calling mas_next() could skip the first entry.
+	 */
+	return mas_find(&vmi->mas, ULONG_MAX);
+}
+
+static inline bool vma_lock_alloc(struct vm_area_struct *vma)
+{
+	vma->vm_lock = calloc(1, sizeof(struct vma_lock));
+
+	if (!vma->vm_lock)
+		return false;
+
+	init_rwsem(&vma->vm_lock->lock);
+	vma->vm_lock_seq = -1;
+
+	return true;
+}
+
+static inline void vma_assert_write_locked(struct vm_area_struct *);
+static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
+{
+	/* When detaching vma should be write-locked */
+	if (detached)
+		vma_assert_write_locked(vma);
+	vma->detached = detached;
+}
+
+extern const struct vm_operations_struct vma_dummy_vm_ops;
+
+static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
+{
+	memset(vma, 0, sizeof(*vma));
+	vma->vm_mm = mm;
+	vma->vm_ops = &vma_dummy_vm_ops;
+	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	vma_mark_detached(vma, false);
+}
+
+static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma = calloc(1, sizeof(struct vm_area_struct));
+
+	if (!vma)
+		return NULL;
+
+	vma_init(vma, mm);
+	if (!vma_lock_alloc(vma)) {
+		free(vma);
+		return NULL;
+	}
+
+	return vma;
+}
+
+static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
+{
+	struct vm_area_struct *new = calloc(1, sizeof(struct vm_area_struct));
+
+	if (!new)
+		return NULL;
+
+	memcpy(new, orig, sizeof(*new));
+	if (!vma_lock_alloc(new)) {
+		free(new);
+		return NULL;
+	}
+	INIT_LIST_HEAD(&new->anon_vma_chain);
+
+	return new;
+}
+
+/*
+ * These are defined in vma.h, but sadly vm_stat_account() is referenced by
+ * kernel/fork.c, so we have to these broadly available there, and temporarily
+ * define them here to resolve the dependency cycle.
+ */
+
+#define is_exec_mapping(flags) \
+	((flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC)
+
+#define is_stack_mapping(flags) \
+	(((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK))
+
+#define is_data_mapping(flags) \
+	((flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE)
+
+static inline void vm_stat_account(struct mm_struct *mm, vm_flags_t flags,
+				   long npages)
+{
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm)+npages);
+
+	if (is_exec_mapping(flags))
+		mm->exec_vm += npages;
+	else if (is_stack_mapping(flags))
+		mm->stack_vm += npages;
+	else if (is_data_mapping(flags))
+		mm->data_vm += npages;
+}
+
+#undef is_exec_mapping
+#undef is_stack_mapping
+#undef is_data_mapping
+
+/* Currently stubbed but we may later wish to un-stub. */
+static inline void vm_acct_memory(long pages);
+static inline void vm_unacct_memory(long pages)
+{
+	vm_acct_memory(-pages);
+}
+
+static inline void mapping_allow_writable(struct address_space *mapping)
+{
+	atomic_inc(&mapping->i_mmap_writable);
+}
+
+static inline void vma_set_range(struct vm_area_struct *vma,
+				 unsigned long start, unsigned long end,
+				 pgoff_t pgoff)
+{
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+}
+
+static inline
+struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
+{
+	return mas_find(&vmi->mas, max - 1);
+}
+
+static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
+			unsigned long start, unsigned long end, gfp_t gfp)
+{
+	__mas_set_range(&vmi->mas, start, end - 1);
+	mas_store_gfp(&vmi->mas, NULL, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void mmap_assert_locked(struct mm_struct *);
+static inline struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+						unsigned long start_addr,
+						unsigned long end_addr)
+{
+	unsigned long index = start_addr;
+
+	mmap_assert_locked(mm);
+	return mt_find(&mm->mm_mt, &index, end_addr - 1);
+}
+
+static inline
+struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
+{
+	return mtree_load(&mm->mm_mt, addr);
+}
+
+static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
+{
+	return mas_prev(&vmi->mas, 0);
+}
+
+static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
+{
+	mas_set(&vmi->mas, addr);
+}
+
+static inline bool vma_is_anonymous(struct vm_area_struct *vma)
+{
+	return !vma->vm_ops;
+}
+
+/* Defined in vma.h, so temporarily define here to avoid circular dependency. */
+#define vma_iter_load(vmi) \
+	mas_walk(&(vmi)->mas)
+
+static inline struct vm_area_struct *
+find_vma_prev(struct mm_struct *mm, unsigned long addr,
+			struct vm_area_struct **pprev)
+{
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
+
+	vma = vma_iter_load(&vmi);
+	*pprev = vma_prev(&vmi);
+	if (!vma)
+		vma = vma_next(&vmi);
+	return vma;
+}
+
+#undef vma_iter_load
+
+static inline void vma_iter_init(struct vma_iterator *vmi,
+		struct mm_struct *mm, unsigned long addr)
+{
+	mas_init(&vmi->mas, &mm->mm_mt, addr);
+}
+
+/* Stubbed functions. */
+
+static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
+static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
+					struct vm_userfaultfd_ctx vm_ctx)
+{
+	return true;
+}
+
+static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
+				    struct anon_vma_name *anon_name2)
+{
+	return true;
+}
+
+static inline void might_sleep(void)
+{
+}
+
+static inline unsigned long vma_pages(struct vm_area_struct *vma)
+{
+	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+}
+
+static inline void fput(struct file *)
+{
+}
+
+static inline void mpol_put(struct mempolicy *)
+{
+}
+
+static inline void vma_lock_free(struct vm_area_struct *vma)
+{
+	free(vma->vm_lock);
+}
+
+static inline void __vm_area_free(struct vm_area_struct *vma)
+{
+	vma_lock_free(vma);
+	free(vma);
+}
+
+static inline void vm_area_free(struct vm_area_struct *vma)
+{
+	__vm_area_free(vma);
+}
+
+static inline void lru_add_drain(void)
+{
+}
+
+static inline void tlb_gather_mmu(struct mmu_gather *, struct mm_struct *)
+{
+}
+
+static inline void update_hiwater_rss(struct mm_struct *)
+{
+}
+
+static inline void update_hiwater_vm(struct mm_struct *)
+{
+}
+
+static inline void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
+		      struct vm_area_struct *vma, unsigned long start_addr,
+		      unsigned long end_addr, unsigned long tree_end,
+		      bool mm_wr_locked)
+{
+	(void)tlb;
+	(void)mas;
+	(void)vma;
+	(void)start_addr;
+	(void)end_addr;
+	(void)tree_end;
+	(void)mm_wr_locked;
+}
+
+static inline void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
+		   struct vm_area_struct *vma, unsigned long floor,
+		   unsigned long ceiling, bool mm_wr_locked)
+{
+	(void)tlb;
+	(void)mas;
+	(void)vma;
+	(void)floor;
+	(void)ceiling;
+	(void)mm_wr_locked;
+}
+
+static inline void mapping_unmap_writable(struct address_space *)
+{
+}
+
+static inline void flush_dcache_mmap_lock(struct address_space *)
+{
+}
+
+static inline void tlb_finish_mmu(struct mmu_gather *)
+{
+}
+
+static inline void get_file(struct file *)
+{
+}
+
+static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct *)
+{
+	return 0;
+}
+
+static inline int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *)
+{
+	return 0;
+}
+
+static inline void vma_start_write(struct vm_area_struct *)
+{
+}
+
+static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
+					 unsigned long start,
+					 unsigned long end,
+					 long adjust_next)
+{
+	(void)vma;
+	(void)start;
+	(void)end;
+	(void)adjust_next;
+}
+
+static inline void vma_iter_free(struct vma_iterator *vmi)
+{
+	mas_destroy(&vmi->mas);
+}
+
+static inline void vm_acct_memory(long pages)
+{
+}
+
+static inline void vma_interval_tree_insert(struct vm_area_struct *,
+					    struct rb_root_cached *)
+{
+}
+
+static inline void vma_interval_tree_remove(struct vm_area_struct *,
+					    struct rb_root_cached *)
+{
+}
+
+static inline void flush_dcache_mmap_unlock(struct address_space *)
+{
+}
+
+static inline void anon_vma_interval_tree_insert(struct anon_vma_chain*,
+						 struct rb_root_cached *)
+{
+}
+
+static inline void anon_vma_interval_tree_remove(struct anon_vma_chain*,
+						 struct rb_root_cached *)
+{
+}
+
+static inline void uprobe_mmap(struct vm_area_struct *)
+{
+}
+
+static inline void uprobe_munmap(struct vm_area_struct *vma,
+				 unsigned long start, unsigned long end)
+{
+	(void)vma;
+	(void)start;
+	(void)end;
+}
+
+static inline void i_mmap_lock_write(struct address_space *)
+{
+}
+
+static inline void anon_vma_lock_write(struct anon_vma *)
+{
+}
+
+static inline void vma_assert_write_locked(struct vm_area_struct *)
+{
+}
+
+static inline void unlink_anon_vmas(struct vm_area_struct *)
+{
+}
+
+static inline void anon_vma_unlock_write(struct anon_vma *)
+{
+}
+
+static inline void i_mmap_unlock_write(struct address_space *)
+{
+}
+
+static inline void anon_vma_merge(struct vm_area_struct *,
+				  struct vm_area_struct *)
+{
+}
+
+static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
+					 unsigned long start,
+					 unsigned long end,
+					 struct list_head *unmaps)
+{
+	(void)vma;
+	(void)start;
+	(void)end;
+	(void)unmaps;
+
+	return 0;
+}
+
+static inline void mmap_write_downgrade(struct mm_struct *)
+{
+}
+
+static inline void mmap_read_unlock(struct mm_struct *)
+{
+}
+
+static inline void mmap_write_unlock(struct mm_struct *)
+{
+}
+
+static inline bool can_modify_mm(struct mm_struct *mm,
+				 unsigned long start,
+				 unsigned long end)
+{
+	(void)mm;
+	(void)start;
+	(void)end;
+
+	return true;
+}
+
+static inline void arch_unmap(struct mm_struct *mm,
+				 unsigned long start,
+				 unsigned long end)
+{
+	(void)mm;
+	(void)start;
+	(void)end;
+}
+
+static inline void mmap_assert_locked(struct mm_struct *)
+{
+}
+
+static inline bool mpol_equal(struct mempolicy *, struct mempolicy *)
+{
+	return true;
+}
+
+static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
+			  unsigned long vm_flags)
+{
+	(void)vma;
+	(void)vm_flags;
+}
+
+static inline bool mapping_can_writeback(struct address_space *)
+{
+	return true;
+}
+
+static inline bool is_vm_hugetlb_page(struct vm_area_struct *)
+{
+	return false;
+}
+
+static inline bool vma_soft_dirty_enabled(struct vm_area_struct *)
+{
+	return false;
+}
+
+static inline bool userfaultfd_wp(struct vm_area_struct *)
+{
+	return false;
+}
+
+static inline void mmap_assert_write_locked(struct mm_struct *)
+{
+}
+
+static inline void mutex_lock(struct mutex *)
+{
+}
+
+static inline void mutex_unlock(struct mutex *)
+{
+}
+
+static inline bool mutex_is_locked(struct mutex *)
+{
+	return true;
+}
+
+static inline bool signal_pending(void *)
+{
+	return false;
+}
+
+#endif	/* __MM_VMA_INTERNAL_H */
--
2.45.2

