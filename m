Return-Path: <linux-fsdevel+bounces-23517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1961392D933
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 21:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0C9B24C7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A5A197A99;
	Wed, 10 Jul 2024 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FZigzMiJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OAt/Ke16"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A4F29D06;
	Wed, 10 Jul 2024 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639953; cv=fail; b=CGSAxS+ok28rX84mlC2mZ7VW4l7+ovxbhVr1kTGM6QYIiYJLoIbxl7VDittBN+WcAuaoVj3zTlGB1W9u4n373Xtgr8b6TG9WFxkV12BavBdP4MlSN962xAseQ0JcS9yJVcw7GYYoKj7tdtIyfieLFG9V6Jfzo6bcGerXbgAxbGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639953; c=relaxed/simple;
	bh=sOQuTIE3XFX/MQiSf0CM432OhyMIT4vuYulaxzupkJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IktmCIZactKgzlgjb2fW9L6kzIZd9NkMKvsG5gV0GbWiZZPGbFnkwNRKO/t2Wd9y5v2ZM7E00enEe8073u3+5eG9aMg8/ucYcmmmZCybD/rF+mEUiGXU4NgQ+qP8fQogDfDpJey5ai28N5682YxqQl+my3KN2l/P1XYOybIAdSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FZigzMiJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OAt/Ke16; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFu3Sr013704;
	Wed, 10 Jul 2024 19:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=sOQuTIE3XFX/MQi
	Sf0CM432OhyMIT4vuYulaxzupkJ0=; b=FZigzMiJAVSkp8utTXOYvVqTqiYSp+X
	iJ2au/Jf6GPtEfTlFc6rcsVRuMM6GsLygcII+rR7KlbLn6oE+JT/CpIiBXTTAWYB
	gS1aGVun2TrNHX0rkz2xLYldsdSdVRm3S2sxs0ytb0en69kDMRLi/jaKQQzyNeRu
	WbygqoOM2E7O/K2rd4NH2D2e8Fs0lUjQCvYrzRWA/kVmIMdT2XaPidwa0mt3tlFt
	IlD8iZqy5wkk0eLjqrggmlb9r8KXZdtFhOnXaD+6lFcKHK8+wmV815L2x7VFMRIp
	lOScQQqHkPTiEzypLMveCiW0YNm2kw06KoBwLvTCOoQa33imrlItxmQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8fyge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:32:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIp4Fk022734;
	Wed, 10 Jul 2024 19:32:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv1hajh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs06Z/meB5RMDZ44CFTnAJY6rAupkoHHAkwmi6O3rOv2hkMpuMVVoCUaSKVzxPHY6QFyDwmXOjgCFFGO03fdtYOzFLWx3ZDQLgV+ja+WBuYvgjbtbqhbo4H+DoU8YsmbCxnsI6sctICfDr2Szx/DjddS3rrdL7tcOHfgxXCrO3JEWzy6jVeuhI2TG7HJkMy2JkBxwcpVUfxTuxgk68907Fto6BZDYcyUvvZJ0eqpvHSCYZS4PcNv0CmBHalFzE6T5nZt4w40udC0u7/KCAoTpVNqt/41WV3UzvW0AhY+DMkVi/o4AZNZTX1DfnfGbiPGuFiwXZye/ZJr7VrkqzKZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOQuTIE3XFX/MQiSf0CM432OhyMIT4vuYulaxzupkJ0=;
 b=bhvF96ae9GgaV6uzIehtrJEDZ/cokX8iwYrcmmwNeGHIvFrM4btqQg6VEBJnOY2Egj4XWa5cywYwPxANZcnAo7JBIG7CIRMftC3so9DOnr63eguDA1gF3rwSLiyvxKqyNd95mCPB6IklKqjo6ly/LWNDAW2dgsuFilBMfUyR8OPEScLToIGf+DKQlncSxN1PVWfdS4+6ns0ToRbYsOEEAPAcTlaU97ezvk/sFmZisKWkR1sUClaellZmH1OlxnCxi99cDOX9aAchGDM9hHnTd/opL7r8NiYo0q/adnXFopfIrhERK25LxcAxxF3JuXzomiwrGKEUsoj4opl+JHM5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOQuTIE3XFX/MQiSf0CM432OhyMIT4vuYulaxzupkJ0=;
 b=OAt/Ke16/mzyWcvE1O1qEmXFRnztWZsxgAP5tsu+lvVBRxYxp/8kKmpEAYn7PEZ1yvTDqUaxzE8Ys81Xof5EK2rgbKnRCjb/7imunQ1yqSqRwYxx4xUqW/ODWe/0pA4gfuRvtVAPet7sPpuzM0nNWS4t40fsf9VSbEguiXeCLwI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM6PR10MB4188.namprd10.prod.outlook.com (2603:10b6:5:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Wed, 10 Jul
 2024 19:32:10 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 19:32:09 +0000
Date: Wed, 10 Jul 2024 20:32:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v2 0/7] Make core VMA operations internal and testable
Message-ID: <8a2e590e-ff4c-4906-b229-269cd7c99948@lucifer.local>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO2P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::36) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM6PR10MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e6bec8-4021-4783-e51b-08dca116fd85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iXojaZ724SDH4FrctLAuXA+k/LtArwOQFk+ouQEzQluF+qnsxHzb+uwr33Ve?=
 =?us-ascii?Q?dVpmo0c3dAXWXtbre172bXZmnQ8nD9+C+iAh2/9iMSgt5cC3/cmo2YImybPe?=
 =?us-ascii?Q?ecNHXOkIEr4oUZyyYzqUs55Ikzq4h9zf4ec66q4mQVVBffOD2mWGeC8WECe4?=
 =?us-ascii?Q?D/koRQs2gveLfUVwY+owLvR8bcCbBB3Rscsu2fMSJO2i0f07MDfxFenlqF25?=
 =?us-ascii?Q?xYLd6RQxSYtVNx7AOB7EsYPW2VGQlsO/sQuLqGEN1SYZQyGZp6LgJ+GO6hLp?=
 =?us-ascii?Q?uQuuxHSS4aDUzcavEa47EZmpubisKiTSuutpuudyWKfCGzdDY9K36NarkBUB?=
 =?us-ascii?Q?QQN1CtEhiOI1WJcUexJEIIf+uO7IXn2ua1stl7zNQJdvf7Kemlx8DnBeWUC/?=
 =?us-ascii?Q?Xi8fwR9ULdSJrgSAD6j9nw8SE3ax0+LJXSSKJtrNdohdqfwaSv9yQ++qp5Nf?=
 =?us-ascii?Q?SS5Qhg1r6YwomrLn/gtnvI35B0j5vQR4eue9tlnFxnexEjIr9I3liFnAhZQz?=
 =?us-ascii?Q?bqK6dPojnzL96fAcRk5fe4IiGPXWE6tsjVDIqBAxMaQxpfNfdq1RWC/KJxAB?=
 =?us-ascii?Q?qKjLnNZ8O9ZImalXbq/DuXZ73BAlS5SMqmF3uoZEg9A4delS3X8//gO1bqmu?=
 =?us-ascii?Q?7OzxTPSVvwXU+f6EDZvLumwQXU1F560z3s1rxqVAM3CKWjHoCdiHp5+VWLNg?=
 =?us-ascii?Q?mcydzmeFb7IYM3v8W6CwEgNigTI4UShJM4dsNOYmnzyt31kXVlh1NK48Z/x5?=
 =?us-ascii?Q?jHP2By7IEGt+m6aWZNGlb5S7A9HwHitVJXjJUTUG3IDvt6WweHH9ofPGhj2W?=
 =?us-ascii?Q?G5oydexdHKqM0giAa0W2uSkr3STgCGouCbGskdn1GDqX9m6SmtFweA/M88t9?=
 =?us-ascii?Q?2eY6UrPHZ1hyovrUjc3XVXUWyXWlc0hBx1I2e/tsy5GbezWNTb8xQLmrkatK?=
 =?us-ascii?Q?Qgyn8MbRq0ZNwW6asYNBwW3XJJ+zSPUYyDm8vPfRqRSBrs4QjYWBXKw8PXjo?=
 =?us-ascii?Q?glgeftQtPtoyllioJoj8i9bSWQ6wiWZsGjndeqRD5YhrUoCCrbYkBTs9NIzf?=
 =?us-ascii?Q?TO9l5q9Q2x/IwpPHTv8clkIFQKK6FjNhLCsmrG6M3+/Rp+7hzoV6MwlhQM+S?=
 =?us-ascii?Q?ulpg1TRbLfzECcMtXrMZ4fc6Fyje7vC2Qsf0n5ZAvwoaM3raKKkkHAO+0fcB?=
 =?us-ascii?Q?duQ9yygI5s1mgmZFruteEd6Hl/8ANMOlT1t+5bYyU54wIKVH0+uLPNWkZ4ES?=
 =?us-ascii?Q?V6FB/RLPnH9dGPUJf4uq4Cr+5B8XQaxIrbPCXkVTXmMp3DdmDwGp895mDWss?=
 =?us-ascii?Q?d1kmJ+1eqaJrmvV+AOG1Gb3ef6ITMEI/4XHbkLw8o1QMow=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QlZlITBcj1xGRcHH3KG3y6uJkyd9vlpr+QlpPMWGKQuKaJz8ngyt+G2ZqnQl?=
 =?us-ascii?Q?SpK48ZXpB+TteKB6RHzrDP4FSbjG6L/Kx8QWuXZgtcXHLyp9tFAddPJbs4VK?=
 =?us-ascii?Q?Uw+siSL0zT7SKFmTwD6iDhyypRIrlx9nHVgYLNjv3Bl9yRBCjW7ciK3mfvGm?=
 =?us-ascii?Q?hsXap9QT3LkKsS5XcN3RBV8dIqjO+fSiqW74oVVBCHjxJJ0qxYEUf1v3i4K0?=
 =?us-ascii?Q?1EB3VrDHG2TJ7jHfOh3KUf+xi9jc0ao4kjEqFG8esHU0LjhcVJGRiklXjgCV?=
 =?us-ascii?Q?oxeKBEyudyExGfqvuSQbKCBf0+IsmUY1oWVndQQ6VrdPMN1xVxiK+/96eBV9?=
 =?us-ascii?Q?5GctGTaJzVstNYErdDk1jcatMNQ74URHQLd7fpr/CmHyOgybry5CQFARZT0G?=
 =?us-ascii?Q?dNkrl/enAmOsydo3N5TA0e4p+LjZ/arBcgRjHGVuX13mtfKK7V+Wd9DmKaKl?=
 =?us-ascii?Q?dO+tInUk2DSrdiVc6YddxxNFbHaULHMJ78jQgpBhC8jQ57Zwk7C2Mgcpn8FV?=
 =?us-ascii?Q?x8mJWkHozlC6FRCaOn1WgAW6INVgLXEuQmCLEkg/7fZQ/X5F6KHnRhVruJcz?=
 =?us-ascii?Q?CXDVSjWUTyPtk0xMM7aiuhpNwCVVYMCWYW92ah0KkmSQFBFTDyjp920h65jo?=
 =?us-ascii?Q?3iPf2tFU1ZW0NkELvrmzOF04tX2HSpP46GyqIkxnl3T39gmw7S/yGDYMFkvD?=
 =?us-ascii?Q?qvXVLugn7K8s6Xy/2PKVKUcV5Jvit4Xrp73Gd+hW5cmO+i6uPUc/6e3wwlrI?=
 =?us-ascii?Q?waKqDAZWsHvOPeuMqvolTXNLhUhtb6TV0Fldo1epkEA4Io5Rtmaz/UFGLE53?=
 =?us-ascii?Q?oPU7nTBwplr3QxQPw1tUTMUzYU6Q1zJ32dyUd+kq0q4W+ikOc2ThdRJ3g11R?=
 =?us-ascii?Q?uD1d4mwrelSRfFa/u7bhRcJTt64otLtoM6VCVIQQ7Wwz5YfTYfZsdcRY/9Pd?=
 =?us-ascii?Q?PYSD4BQhFeTaGrhcIcknpf4DzaGwpxA9/jsmTPxok0EzMSUPP9ikyW9lj3kO?=
 =?us-ascii?Q?nGmOXqYsOxOsMSsv8EzMAUhjGZP7RTGWLFF8gh5vPAMl/FQ7xgh4c2B0zy8Y?=
 =?us-ascii?Q?2PHoVNxX9dXArtLtLEKcWt921sHYgs//rJ0FYvoIBDPFWC3ETEX/8USsG+xF?=
 =?us-ascii?Q?9wWdfjl4iJFUGqbyH75ADphLVbQvAVgQPKq8DwsIA9m8pMNR0v3nr33Hfp7O?=
 =?us-ascii?Q?c7LBR8VpUDsQRdUUadF1Sa58ZT1shI1nlwEEjvFMCeo6tvNGPPszar8Oqgmp?=
 =?us-ascii?Q?cBay5isu6IE4u/WkYhyBYOK3VgqachVIQEQ8rPCbwfi/bE/ihfpNhXzaNoKU?=
 =?us-ascii?Q?Hhx2hLNMvH24kepN2XXmaID27lZIU5ozRb9Mj3ealE4LLNQMDVfQ2342d8iK?=
 =?us-ascii?Q?rqYLHvQbse5KOQw03o+CATCXE63cTfg3e5as33/UJCGOctPCtfgx1uEy/Rcu?=
 =?us-ascii?Q?xMXeEUhHw9XJyio/8eMJ+DXPgPNGwlYV5YnGFE57VMoVxQqzjw80s5z+kfKW?=
 =?us-ascii?Q?jMNIAteShw2leE5nlygXO2pMrQcOHY/m8oRShAe8pZN9wi5qF+8TPSs3okA9?=
 =?us-ascii?Q?gK+8m7faXgx9LtqSwHqDvQgQNq31reWwYocIjArOfU0KduFrtErUqFwxJIuY?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ttdqs1Z5h5qdrtfVYkSoEMHmRjNxlInm1eG9EttqITukqWuLgo74On6yWP0BqJ6VLd/ghgblJF3CtXj60GWyaQkYgfAwPF083dR9gAPzjTp2tRLJJJRX+Ma5tzIP44mxXDp+bAFsyfEvD5QQDca70HPRnK9vDMRmCedT5Ub4upsHqG1QyBnlgIApCJaivXhVxNqF6Otqo4mR7PXdI1W0ftqSmLO7xRVB6Mum+f8qU/7UejHiM3UMxpAJKMGvTbUHT3vxVSoR8Mpg/JLcTK9qWAlLvbamp+wOQ5Ix4yTnhCuEqRb6d7kHVBmT30PcYqCYOrcYWDwPKRfdjxbhGEyHLEAIytU9kV5Rh9OJ3UOROI33A4uyK0y3w+XLs7SGmeZZBMt2OPsQtBUMHYN4J9Wy5Zbd/jMy3Ef5lDAHCPNAAf7jWJdcSgizpuqcAcia6F90KjV4pFlhr3AzfPbcW+gDp4/o9Ha4LbJxK8ftTHi/ovAiJdZhBy0hqZpxvuAVWkGgrjYA4NjGcLCK/veyH2gdUYLgA7R0TtY9O5mkDkleUVRoUVY52SP+0GRRDNarvOWlPWqOHhlbzvgegKIi12Ar38oV9i5xt8znZYm+jqqjr14=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e6bec8-4021-4783-e51b-08dca116fd85
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:32:09.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQ/GCJ0NDQTwDD7NpdsVI46i3NOTh8frh/wYvdevamNRYS7dqUpv2yyjBx9boYubww++fNdzs0ceMLYoh8FUh/85PFSXNsVaTxU34S6RcwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100138
X-Proofpoint-GUID: v1uZ9hIqRXkbTivMMKHJzC0XGH22XsOj
X-Proofpoint-ORIG-GUID: v1uZ9hIqRXkbTivMMKHJzC0XGH22XsOj

On Thu, Jul 04, 2024 at 08:27:55PM GMT, Lorenzo Stoakes wrote:
> There are a number of "core" VMA manipulation functions implemented in
> mm/mmap.c, notably those concerning VMA merging, splitting, modifying,
> expanding and shrinking, which logically don't belong there.
[snip]

Hi Andrew,

Wondering if we're good to look at this going to mm-unstable? As this has
had time to settle, and received R-b tags from Liam and Vlasta.

It'd be good to get it in, as it's kind of inviting merge conflicts
otherwise and be good to get some certainty as to ordering for instance
vs. Liam's upcoming MAP_FIXED series.

Also I have some further work I'd like to build on this :>)

Thanks, Lorenzo

