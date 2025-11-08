Return-Path: <linux-fsdevel+bounces-67544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9099BC43105
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D56644E9448
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CC22561D1;
	Sat,  8 Nov 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C1ATOrJo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NO6Jp8C3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4A26CE20;
	Sat,  8 Nov 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621881; cv=fail; b=hX4UljMVlxdfK2KLlvmCr/5GtzjDFeRbGamZ683ZAgtG7HAmiEYObdjL+wBnriN6OtM7qM21DlgJOmoTGSQRl7RkAkwg1vBwsG2BgWgpRtyX9zh/1ZPcuB+tk4FCTNsSrAKwSlsY8r9494sS/Qu9v6/X6oS9Q/cZHY7AsqPGXBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621881; c=relaxed/simple;
	bh=AZ3s0B+uhePQZXTS6i9X9ezX6E6ciUS6QFxCmlxX9io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYbuqewxexGv22LTa59oqmjlBhu2ukEEIBLoTHD/NSGCIfVQ/VM4cZMFEpj54V93C8hlBNfmmHPcNFffqZYFCvNuPzSHij90k/abeR2xSDsvRvtlvYZRgnoYC3qDMS36gn7ZH1TZAXJkQfHWOp57lzfFQHx9T50krUrYuGi/HfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C1ATOrJo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NO6Jp8C3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8Fg8vt024800;
	Sat, 8 Nov 2025 17:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vzCGIt3sJ5ONOndZRuqYi7OVSaXyL8N0gC2xsfawbow=; b=
	C1ATOrJoQxkDXt4BLeVx0roHuBdz4EUmeUgSHrxZmekAmpD12zFui+3tcPk65PJA
	l20ljK1RMx+0NVsVXGy7QHn21U/2zFc6pXxoFDlcLCQ4LPM3JQhdPSiyYc93a9y6
	MRh16ImaCQU1807adWmI2xJmz6USOcZm6E3+ECOGnEKDkxwO4WCABJm5iQS0Czfb
	VZQMhR5RRI3OfoDOdFyGEqhlBWAhvf27o4j8Ng2f7UTyxyeGdDrfP54W6TebeJDH
	7SXHCRt3/J+WajWQXeeO55/ijRDh/241lRQNSI7FZRogGaV3C4G1YmqTfhknDEHI
	zqzmiSgD8oTj4XGS1sIVMg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9vs8gnmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GXJIj000746;
	Sat, 8 Nov 2025 17:09:17 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaaps7e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FE9KUIKWtTY6UjhavFiUJ93mTn+HtD+GVixm3Ym9HpsOEb7BivfLQU/LEF2y62cR0GfGCZ5/xr6L3ga+4OKqEazZJcATr5wv2QmsqnY/URalhv4wkW1OmpMpubFPtoSsEpLWZFg/HgmFguevmAB7ZiPQLrYvFfXdLviH/dG0tHH56CQG6r34eVCqfRcrnodlicTeLXSf6/IvSLwc0kAockNAII1SBKr6hRy40kgZn3HWXIGmdtjcurdB+VwVbea4BuA9OEvlnjYos4/kQwKtfSIuhQ8Htu2tkWi4ZM3Hx9Rofwq8zu2mBKc3lliM8OaALed52mYkKuw2yySsTnFPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzCGIt3sJ5ONOndZRuqYi7OVSaXyL8N0gC2xsfawbow=;
 b=kRX/oblssQXALZb8Dfvj5VGSzMnaJsWcLxdKPhMQWErnvU7PEQ4lFwmbJSAUsgfTTnnAHCqSqvShg0XZKRIslNFpf+DINMeU6y0RaUbOMHoiSFR3DIhlXQKVOdCoR5ZkypFMn5neOHNFTI0V3JCT38EKhdQjvYHo4Ec4FQ+YPr/rDIoGu3Hungla5i3PHy/oDPPrdFNpgii8bbdbIB7KAuFPFS8dPLOIXzntsIamtMRjjLq4a4kaj61cfLQtgEZux3+Ga/iZ08BnoGrvWswQNLGUYRtUYLCLVO7RNXoAvROLaVCfA8fHVotxFf8RQXu1/eI+UbBsPn88mjf2YP1gtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzCGIt3sJ5ONOndZRuqYi7OVSaXyL8N0gC2xsfawbow=;
 b=NO6Jp8C3eqRoWeZELx1VBlmNUZv4mAnPsR5zQuaVFopxY7R2Hu5bOdSVv5y6avjK13yWPL9cSL4BH0heLE8kWS/QZM+QvL59pSFJlzte1BoZYlDziXnRMmEXxPxqp0GlRj7WC9J5YzZFWP5DUpQ+TfPqnN/r/T3V7uSzOEpeqYE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:09:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:09:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: [PATCH v2 08/16] mm/huge_memory: refactor copy_huge_pmd() non-present logic
Date: Sat,  8 Nov 2025 17:08:22 +0000
Message-ID: <29f5631ec08be166eeb857d01602d925c4bd410f.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: 7868c322-5723-4939-46ef-08de1ee989d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?11/Wuc2ahGk/v4UJmqMEkoqtUgFgMEr+Wd83PovPZwyWyhsQ5884YDQUtLOa?=
 =?us-ascii?Q?5Mn3MkUAGnAkED8UXWP/t7NT4qvmH7jyY/h61u85q7bqAL3yI2kxsGHEt2ew?=
 =?us-ascii?Q?NC3SZv+Zlo8HBMnCssEgkdURc5kzJAY4VcyuIHzJvt4bJW1zyy6I2mSqAFrp?=
 =?us-ascii?Q?osoITLaQSHEEYft2f0fSuNtcfnmyn6Jj9L+u+r8YPtCUltKk9CTsVnGhm0sy?=
 =?us-ascii?Q?Ds+7V0Lhojpa7DGutNEuP8RpGn8FgLMKiYU6Nqu+Jj3vBQ4RJEEKWh8mRMZF?=
 =?us-ascii?Q?pBlzUDTxV9BLwWnclxw7YN2H0dszmI0b0KcvWQ3f3Uh/6IVphCAzu3YDXV8y?=
 =?us-ascii?Q?xXIV9k8Gx2NM/5G8s5SBHBXY+9xRQsIUxCKbu5+FRKeEDqEvL+LKwoB9z12/?=
 =?us-ascii?Q?L64k9IkwMSskupjIqgZHn1teoqXUhJ25xfXJ6YRY+9l4g2NcqAw8EsDY+wNj?=
 =?us-ascii?Q?ArCBmz9n8UjsA41JTfI7B59OMH7Nxx9JJ8rDkgpCp1p+DW7n57M956bk2JGo?=
 =?us-ascii?Q?gY/MO4jwcPJv8aUyOG7lKXFyqwpKQHZ1jz6cSvLtHJpnLPCUKQ/ItHLB/wkR?=
 =?us-ascii?Q?0ElC16kc2Z2Zopi3rTvwVyrOccUdZiitVV23G3fRpcHUH0W255mgjGxR5lei?=
 =?us-ascii?Q?WP2Rw7GFDRAXt+Z9Op2h0BCS10wRb3G027lOMUZ4e9UVxJqREdDZZoc4EENc?=
 =?us-ascii?Q?rjcgeWsk7WqNh+NR3iv6w0mLMO3wfTFYjm+Sa6wR1WyjUNW4L3q7CV41KulM?=
 =?us-ascii?Q?g+HggpoDKv9VbHDhtQQac2fs9oyTAVFLo1oUJpqDUW14NzAn5LCVVw0p91Lu?=
 =?us-ascii?Q?BmPQRGtlyDPKOzwDS6nVY0Hn6Fw45X4I1SD4BbiGXTIClybuyAB+9mhAfle8?=
 =?us-ascii?Q?2CdeubUKMIczbWX1XnHI2rvayoQU8wKcXI1Ajx5bt8zhSgKZFme4HnE/FjKX?=
 =?us-ascii?Q?KtTXh0xJv8sAmYAjizofapBvwU4ptaKXD5TDWQyo+KFTnEej2fSiyVZ7DjgP?=
 =?us-ascii?Q?u55Uj9N8k+XmybAzpoaMZ4CTSYYQL3zjy/7CksThgq6rGjugjwFwLzbBh3OW?=
 =?us-ascii?Q?CXCE+f6ONhajnIkgXdrU0jQ7DxVcYt6fZgUJSczRevNvh4poyxbdKptOgpTI?=
 =?us-ascii?Q?A6rER9d/k2AODB/qFusH0nMy2YAgBM7Mi5vI5OaMgU5TRTOwiqM2qHLLv4g7?=
 =?us-ascii?Q?9gRha7MGr7O04UN1TtZtVn3TnaWhbAmpCwyoyCMVV4Kv71Leo9fvSvjl3lGA?=
 =?us-ascii?Q?uxDwoXCKIFaGtQKhMCuCmNPcpwBiMFQo9gozd9pJ77Vw6bmlDBgwvFSCQe1T?=
 =?us-ascii?Q?Jg4TN27a3djANQmPQpqA+PtJPpaVrS7qT+ihMfEUwk2v70Sxk1z29Ybzg6kr?=
 =?us-ascii?Q?0PikMCtZbjgsJGab8dJgmcfaJITmzrvlHpsHQyNSTmW+pq66erIwuHQeSryW?=
 =?us-ascii?Q?v4vcU63PxJ7HIztvQgQY/kCC0M+p/Pu2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?soxCWSCM6lEsC1eV5QlNbvCRq5uM/zHjBguidm+jxW9FFJo7eKIiawIeCVFw?=
 =?us-ascii?Q?1U2khSpUnQsLR9bRE6NGTWW/xYAUV+Fo7uZ3UvKj7N4JSOeti0SFgcW+jC3V?=
 =?us-ascii?Q?+bEkqvfNrPozxud5htrN+X15ZUBMAQbWlX74I2EFLr2e9IABwUW5txzN1ixx?=
 =?us-ascii?Q?DMJD0dUJD/IVGm48mZ1L8Elza+BhfYtjGQuvo5kmq8C1H/iXgfCIviGU2ZBE?=
 =?us-ascii?Q?uL2p2vZB3clj3o7jYmw1IEj+Yx1205Iwg3drtpr2a0+MiPeXgNdh6GjHdEKB?=
 =?us-ascii?Q?JCn/lKWNDRtfNw/OCXTsUruO673PP9vMQLoxkDoZGihHfdTllxaRTqC+hinX?=
 =?us-ascii?Q?zEx6svCDgnUbAD3ogcX1phmcUo5MzIBIvPYtAgnKrmz4HIRqClcPrOrQM1jq?=
 =?us-ascii?Q?+Iet4huwosdmn7arDGjWAyBzmkOdUHVHSrLSfHMI6n2ZX/86tf2oH9JSWsux?=
 =?us-ascii?Q?HZt3poJxzIFAjfNzW2ZzMJLKATXim0sVrqjl4101NqodCsUqu0z+4QlG1dsB?=
 =?us-ascii?Q?RLcjwQiVzI/UgmZ2MHs1j0IKQse3tW4glWQCQKLxz4VjIXWID46bSFE6zvPE?=
 =?us-ascii?Q?3sTWK8JfARp25Oi9UWrVqyLW4RUcNbt+3iesmnqqE7XAncLKsgNQfMI1TcX4?=
 =?us-ascii?Q?kvceAPu9PkpISa80n5qTAnQCpZdcGdZUXZHgz+eXZRwOBCxs+WKSkN5FcqIK?=
 =?us-ascii?Q?eHg3Mk5I4x4l0P95ALK19Se7xKCI1/fa6FDdasNMqXwmUZ7e1l5oMJIHPUMi?=
 =?us-ascii?Q?OXR+iziJ3Yp4iN9tXd53XCYsppe4Asth12WqwFZPCfVNCAWEDn5HRfy4KKwt?=
 =?us-ascii?Q?Q0mnugcl7DtcSUcDsWNshFYHobElHMYmXbKAaG76+WkxRJudJVsUOetJeNdY?=
 =?us-ascii?Q?wnJgyBa/ZxZNz6CEU9yfkulGPtZ21RQ4cuQAjG6688B7mWtq4gP/kNv6wL6K?=
 =?us-ascii?Q?00btU5z8Qsx0e9lYLAm/VoqjkTkmGTgseJ8MtvDBCcw1DcX8N3KT3qptf3kP?=
 =?us-ascii?Q?kffl062IwN+WCGW9AbtAzlMM3ynqqD2YmphKgzU9fS2Fxxf16cO7uVQh4QGZ?=
 =?us-ascii?Q?e8TfNuqW4fuvmgTWUsDtBTUQBq9HkIxL+WgAZywo5xr5MqJV8AavRFQUOcx4?=
 =?us-ascii?Q?RGr6Lv6mLFes/Poj3srlV0T6zc4XiMxnf8XzhkaJWK8D6roqogDhoOaWg+mw?=
 =?us-ascii?Q?VgOTYTHyXm6ViEIStElXrE2zPQZGNeJ6frVYX7bpTKjkf/Ak/jAxJlEte+Jd?=
 =?us-ascii?Q?b30touqr5bZmzBD/mRAxUO6x9qv4pDDUYxbXz52JS1RnZuUC5kaOs3jV5dgG?=
 =?us-ascii?Q?N4CFoQApoCjWpaD4q0nJU3PzKcnv0SfTxFb7W4iI1cz6vvuczpQ8HsvfdYly?=
 =?us-ascii?Q?XxDBaulK/2S1ypGyj4zERNWa/IrWCFHC8h2LGHe1otGUFpj9v6rSY63y9nMd?=
 =?us-ascii?Q?nNnExZEmle3cFyoxjCou/7lNPsGddeD9eqvNULvEwSVgNf9wE8GGpfyZx5jI?=
 =?us-ascii?Q?wq25S9poszWv923edgFhmRFbIs50pcN1tgCdEiOYj3vHBzVmkyIaZkJb7kUy?=
 =?us-ascii?Q?520X+K94t5IePGvd7FbflYaIij1SwfwhhZDAimf6plidXG27tQmLD9oKS/42?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	htaBqSJvUF6DyjbFkUiZ/7LtZKRIukc9UwISmaAGIVjvEy82rXNrjvs90hLZcanA5PGTs+euct3zpAUB98hOKy1RUv8PtLLmbapGV0D1dc9Nrmtnd0Esfcmzz73drUXjstkljcSuOtFKwP80OUwRXB1Ufm3zZRyubS+0SnZq1q0/jSpSRWVEzH6JJbibdj9h52sUhXk1eXnHDZcf7BHQjWgo0OU6ZnjSdAjOmhHR8E78Ke6RmiT6gQb0W8vs0cgR7uN8keE1yMr7V/N2hKKrwFIxmmnCogtsN9YlLwBWjPE1aTA5ovSgWIgBd2HTFIg3/bC7Qu8MKKkpH73DMVCnCp69JJby6mQtLoKsBm0KFBJ5FpMJHgymdgIG8rcBs7Dfvf8Tz6Ak+QoFRd5KlfN1ytEtTz6dCKm8tKdZ2TILqBJJx+teH/TedgyTPXTbjG70WHKPh2sRrs27Mg+LhKsMt/rg4km7tGGcfk3JCnKWwn/ElhUQoyOvUafdYeh8OhHZtZXSeIiHzXTPBSKxUEjjx9d6c0s/Y4nJDahCB/oDJte0Igh9E0WHG9cyBUb8antuOm5hTPFKrndZT30qyEugS3Ug27/ja+SCIKrWYYCMxok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7868c322-5723-4939-46ef-08de1ee989d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:09:12.4426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVwpzqfyIlX9eLVaHyjPb+Kuy7gaBsKARMdi83WyFY1IF3E9DOXv0iAX4GXgMthvqr06HxeArLWPKKn+SG2Cw//9nyxVADdtyOLImPabG8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511080138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxNiBTYWx0ZWRfX1QI9N8iRj+vS
 7d3T4SnkdBY16FV8gCvedEWJaF8ml1cfbaDbbpO5JiFm0mHTDIPX3f5ekhxpibkZpBT9RFsTvBj
 KLUSUN+sP3AqbTNimfu8klJwzTwH+Y3BVglNzj6jAAnPhjFO6T2Rkn9ijGu7zZXRVByC1mBQg0w
 N2qXxcHEb4GsU/bJqfnw380aJ5HGcPpEdOFlTxcGybCabY0c6Ij6A8h3uF7q7LcftEUNQ5TUB5e
 V5HwTwjGW6aQhyETB8667TXboWb9IXRmzROZjG2cZxk+PNqtWMNdNNvAk7pSv8aWH5LmXUM5UVW
 s/SnG786aonufSBRTWbI+XLJclQ9EsofLwEKAcnZysQ9ZmNnWxxQFcf1saIxnvwhsvFAs5+dy9S
 jlO30FImW5kh0N0uF4AOkk0NiojZS1L6JTjUwidHnLq42/xPj2g=
X-Proofpoint-ORIG-GUID: vHyhdle_Sbz1MW1C4wyF3Vxa7pZlaVUq
X-Proofpoint-GUID: vHyhdle_Sbz1MW1C4wyF3Vxa7pZlaVUq
X-Authority-Analysis: v=2.4 cv=eYgwvrEH c=1 sm=1 tr=0 ts=690f793f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=9UmCEYkwnbpDqGD1g-YA:9 cc=ntf awl=host:13629

Right now we are inconsistent in our use of thp_migration_supported():

static inline bool thp_migration_supported(void)
{
	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
}

And simply having arbitrary and ugly #ifdef
CONFIG_ARCH_ENABLE_THP_MIGRATION blocks in code.

This is exhibited in copy_huge_pmd(), which inserts a large #ifdef
CONFIG_ARCH_ENABLE_THP_MIGRATION block and an if-branch which is difficult
to follow

It's difficult to follow the logic of such a large function and the
non-present PMD logic is clearly separate as it sits in a giant if-branch.

Therefore this patch both separates out the logic and utilises
thp_migration_supported().

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/huge_memory.c | 109 +++++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2e5196a68f14..31116d69e289 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1774,6 +1774,62 @@ void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pmd(vma, addr, pmd);
 }
 
+static void copy_huge_non_present_pmd(
+		struct mm_struct *dst_mm, struct mm_struct *src_mm,
+		pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
+		struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+		pmd_t pmd, pgtable_t pgtable)
+{
+	swp_entry_t entry = pmd_to_swp_entry(pmd);
+	struct folio *src_folio;
+
+	VM_WARN_ON(!is_pmd_non_present_folio_entry(pmd));
+
+	if (is_writable_migration_entry(entry) ||
+	    is_readable_exclusive_migration_entry(entry)) {
+		entry = make_readable_migration_entry(swp_offset(entry));
+		pmd = swp_entry_to_pmd(entry);
+		if (pmd_swp_soft_dirty(*src_pmd))
+			pmd = pmd_swp_mksoft_dirty(pmd);
+		if (pmd_swp_uffd_wp(*src_pmd))
+			pmd = pmd_swp_mkuffd_wp(pmd);
+		set_pmd_at(src_mm, addr, src_pmd, pmd);
+	} else if (is_device_private_entry(entry)) {
+		/*
+		 * For device private entries, since there are no
+		 * read exclusive entries, writable = !readable
+		 */
+		if (is_writable_device_private_entry(entry)) {
+			entry = make_readable_device_private_entry(swp_offset(entry));
+			pmd = swp_entry_to_pmd(entry);
+
+			if (pmd_swp_soft_dirty(*src_pmd))
+				pmd = pmd_swp_mksoft_dirty(pmd);
+			if (pmd_swp_uffd_wp(*src_pmd))
+				pmd = pmd_swp_mkuffd_wp(pmd);
+			set_pmd_at(src_mm, addr, src_pmd, pmd);
+		}
+
+		src_folio = pfn_swap_entry_folio(entry);
+		VM_WARN_ON(!folio_test_large(src_folio));
+
+		folio_get(src_folio);
+		/*
+		 * folio_try_dup_anon_rmap_pmd does not fail for
+		 * device private entries.
+		 */
+		folio_try_dup_anon_rmap_pmd(src_folio, &src_folio->page,
+					    dst_vma, src_vma);
+	}
+
+	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+	mm_inc_nr_ptes(dst_mm);
+	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	if (!userfaultfd_wp(dst_vma))
+		pmd = pmd_swp_clear_uffd_wp(pmd);
+	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
+}
+
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
@@ -1819,59 +1875,12 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	ret = -EAGAIN;
 	pmd = *src_pmd;
 
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-	if (unlikely(is_swap_pmd(pmd))) {
-		swp_entry_t entry = pmd_to_swp_entry(pmd);
-
-		VM_WARN_ON(!is_pmd_non_present_folio_entry(pmd));
-
-		if (is_writable_migration_entry(entry) ||
-		    is_readable_exclusive_migration_entry(entry)) {
-			entry = make_readable_migration_entry(swp_offset(entry));
-			pmd = swp_entry_to_pmd(entry);
-			if (pmd_swp_soft_dirty(*src_pmd))
-				pmd = pmd_swp_mksoft_dirty(pmd);
-			if (pmd_swp_uffd_wp(*src_pmd))
-				pmd = pmd_swp_mkuffd_wp(pmd);
-			set_pmd_at(src_mm, addr, src_pmd, pmd);
-		} else if (is_device_private_entry(entry)) {
-			/*
-			 * For device private entries, since there are no
-			 * read exclusive entries, writable = !readable
-			 */
-			if (is_writable_device_private_entry(entry)) {
-				entry = make_readable_device_private_entry(swp_offset(entry));
-				pmd = swp_entry_to_pmd(entry);
-
-				if (pmd_swp_soft_dirty(*src_pmd))
-					pmd = pmd_swp_mksoft_dirty(pmd);
-				if (pmd_swp_uffd_wp(*src_pmd))
-					pmd = pmd_swp_mkuffd_wp(pmd);
-				set_pmd_at(src_mm, addr, src_pmd, pmd);
-			}
-
-			src_folio = pfn_swap_entry_folio(entry);
-			VM_WARN_ON(!folio_test_large(src_folio));
-
-			folio_get(src_folio);
-			/*
-			 * folio_try_dup_anon_rmap_pmd does not fail for
-			 * device private entries.
-			 */
-			folio_try_dup_anon_rmap_pmd(src_folio, &src_folio->page,
-							dst_vma, src_vma);
-		}
-
-		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-		mm_inc_nr_ptes(dst_mm);
-		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
-		if (!userfaultfd_wp(dst_vma))
-			pmd = pmd_swp_clear_uffd_wp(pmd);
-		set_pmd_at(dst_mm, addr, dst_pmd, pmd);
+	if (unlikely(thp_migration_supported() && is_swap_pmd(pmd))) {
+		copy_huge_non_present_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,
+					  dst_vma, src_vma, pmd, pgtable);
 		ret = 0;
 		goto out_unlock;
 	}
-#endif
 
 	if (unlikely(!pmd_trans_huge(pmd))) {
 		pte_free(dst_mm, pgtable);
-- 
2.51.0


