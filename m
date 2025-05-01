Return-Path: <linux-fsdevel+bounces-47835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2EAA61AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178A21BC1D61
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54542192F9;
	Thu,  1 May 2025 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZXAEQJvY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iDhRVL5o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D81A314A;
	Thu,  1 May 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118686; cv=fail; b=OFt+5bRifKge2l8sPLsG2dyqK0pCEiCDRGlbhJkSU/zVzm2c8PQ6PJWJWKehmq8jS8ZT6mqkQ5so+FH7jDQdGvq5VJlg0MDKxaOW4FaylH8vq9bS/lytH88oK+ZoFMhXnW+1Pb9jxlyg7haHq+POIBfIUyJJM1/mjZ7vRpsIb2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118686; c=relaxed/simple;
	bh=mtBRe3tUtY+uqrN8Hja4a3RAl2uLQhjEcmcfQC0xH5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u0hLxOQA4ARZeIMGmFaoSkpC6FxxVlEMmMLNGy0MkA5mR1JCSmDjJP7ooxNWxlrwtJWFjBbmCeElljw8XnI//GCn67VW3rLpyTuBDsT/KMk2+LrmUF08ViOqcIUetVAbD8/Smn4fdLK/1IskoKreLt+zAsafihoIbwroV6qchio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZXAEQJvY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iDhRVL5o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Gk542008227;
	Thu, 1 May 2025 16:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=BERhNCdozwID3SnU
	1oVEH8Q67sfiJF+mdJTiYT2NVSg=; b=ZXAEQJvY0R/en37GC2Lue/D3Tjj0AfYc
	zXRk/XUB9BGAxRHyFcSgzEDlFw05gjbYqvKSO4lEBfaOXKgFALg3IoI4fHZ7hDIy
	DwSWrg7E6zPoR1lWcG/wNvrpBdhCd0IfcJgWoUkOJ9zPE9z/wdJQ9QU3kRolFKhi
	lSfqjlEvjLxKhRnB0Xd3DxM/oytEIUcegLQbIwccUbPKLPwMDubUJ/AocKzUR7yW
	ha5es0pM25n00wX2zae29MQO1eKIbfkiB5w5nyP5nUyjNeFhp+Yp19vzo9LPer0t
	HdGs7G6LE5SwuQg+zT6NY5Bzhz3en0MqZLCF8xBfPNx/AQ1ZIS/Feg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uskfsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:57:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541GH4Vg011314;
	Thu, 1 May 2025 16:57:48 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011024.outbound.protection.outlook.com [40.93.13.24])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxd9ada-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:57:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tbzqs7GdGJ1ntsAT8ZyDmIYeNGZzBI5AEgQCQU4RNeO1I+FzkjYZiM1VqrQQM6DpxaMhAFFe/c0FqOMTnqKV3+xPfumuphv/sQPns37uWXEhsjoD6hWW+OdowVeDmjIAg4HMDdsFUwOCOazpZFT7F3e/1SHAXN7seV6KK1Jf2UlWPuSFMExcCPePxy0h73LqYCFZ2Z6XH3097FhwpqAv9+Z+iuM6Ku8qDZHQz8FlC1wQ/zb2E9lmEof24Bsv5SVw5ruBr1YpBdxldpBCJkVAnDxPO+1YRlqocnLt07uJAoEtkPHwNWs5PkCgRbZw2Urkdqn0rEPDo0/KHmjHe01lVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BERhNCdozwID3SnU1oVEH8Q67sfiJF+mdJTiYT2NVSg=;
 b=jV7zZhjNtptWezylLpigg4iIx2wkSh6HSOaFiXwcyOi/LCmkoI3oQxcVMB4UcXbkVpfvUmPSvxNIwM6o6bRqXZCeVK4bsBJtqP/iuseE7phUlHGGwkuaAMQxybx1fCycwffjc1vzgomCfG9q+WNXztW0KhezhFaSQpIbneTJZbwBeA65ZtGfIHCe96yNSGGQWV3VTk4OYH9BHdc0QkFZ4CKnKQCexgmYyH6PSfJy/TrxfY8rvD9OsXzkoxKUeSkaspQxv0VeQtb1isqj5FWFod3yhRuvredr43dlNjJ7KJnXiCMB32T7RcslniV8YDTvWTXlVg+bv5G9PkgX1siBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BERhNCdozwID3SnU1oVEH8Q67sfiJF+mdJTiYT2NVSg=;
 b=iDhRVL5o1tUz52BkpvMyWPvPBvaD1aiF4jeMbVHZwKYyYB9PYVJSa5SPx6vW2mJQWaHL/CtJgv1w+IaXF++wf+ryTfVZA444MjPF74fEG848s26a2/z/u9Y3OINYF5lMhOPnptiV72KH6EW63FMZaM5tgZn/t39CfnH+87HMt+g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6040.namprd10.prod.outlook.com (2603:10b6:8:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.35; Thu, 1 May
 2025 16:57:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:57:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 00/15] large atomic writes for xfs
Date: Thu,  1 May 2025 16:57:18 +0000
Message-Id: <20250501165733.1025207-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d0f716-3f67-4836-286a-08dd88d14b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zj+zYlUvQ8HKc2rkYOIatyJ3JdPIjxo+gB2XHzEqi5EO+IhUfv4MlwttY6fE?=
 =?us-ascii?Q?+j1ZsJg6zUGblykMyCwqCbtfBZX5Flii/dX5SLf/w3yodq+kDF6XAZsZ3NOK?=
 =?us-ascii?Q?cm3MgeavUhgzUaBiWA8SMTHLgMPkV9v8fdTzMZhJr/dHc5Hg8DiEmHKPDMJ2?=
 =?us-ascii?Q?JYsWYRfA2pyDUyvD+bP5AxSyQXpJbf52lcYB+mxemZ6PCQgrpob3ekmcdH5V?=
 =?us-ascii?Q?gBaqdjh7fdwa6lJf8yodoO0Gq4ROalnWdhHoPhMelxfkZ1aPs/23ADbuqF9Q?=
 =?us-ascii?Q?gys0lU9FKVv4s+qU4VNuc3OTdcZMu19/SxVSunfRx919WOtZPOXPTblU3RIF?=
 =?us-ascii?Q?aRhRw15clgKL1/9FpiCHLmT7UHei3MsHcy1mHo9SoWZuHXfiqH36MktzzsJS?=
 =?us-ascii?Q?GQbhTSB08IFSCO1Zoo8hgsf7UuWodF7E6qymyzVCE3Dy5GvZyYX8hqxPua94?=
 =?us-ascii?Q?81jWoHWqemgIRR3wPYI6e6xKniXnLsQXC8r0hi2h7cH8KxSRVND59dH3++tu?=
 =?us-ascii?Q?aOBDcZk6kB5d3c3rXEw0rZ/AdgfeULdyPbUEjlQddtuhd6Cv5blXd0UlUT2x?=
 =?us-ascii?Q?/x9ZZEX7RyU1ittBHiOyKBMbLm4KxB6WaKWQqOyYoOIcgtwGechAVbBYMbKE?=
 =?us-ascii?Q?U9Q4ZzdqpIMC6SR3scKhVOeSZj04sL9QyGixBvdCPqwT1hzf2xigWrhIrMyP?=
 =?us-ascii?Q?L1ae2YlNvGOCOcYC6u5t3TD6UqqPVzQuluBvvNdX2ytCbPvZz4bpKA3AP+2D?=
 =?us-ascii?Q?W8AKMzqtF+whyWUXI95hxW9othY/+ds+6dIE+5u9w6JAvHpMZlIEnFsh6OhH?=
 =?us-ascii?Q?OmQLRqxpHw6SqpCi6DuMpQvp1BVshvb8xlXhUryxzvHSCv4O6yUY8lwRs+J3?=
 =?us-ascii?Q?S+gIjol7SBW49T3fSClBTTWVYkqq3XVxTkUy7s3uocXsLwLY8lCZDymAPFKj?=
 =?us-ascii?Q?cAYqw4mZKqBRR/3UWFzwr+cTiYCjowe5L7h09ZdgpRiQCJhWdRO+xXFcpfBi?=
 =?us-ascii?Q?lkMtbGGKXT27jtZ/fdSXa/nFoG2E/MHj2iKTBgh+4CiyBPhNhMN2vXMdDWfU?=
 =?us-ascii?Q?74jhdtJGyOfKSEPo1bLotNMwaWO4IWzevq8o8Z5jIXINf98zokYE93Tj8QmJ?=
 =?us-ascii?Q?de2G3j4JhtNbqkVsbnRQehSnRb6gyGX9uuTbEadBwaIgQsms+hLC3LSWp+uc?=
 =?us-ascii?Q?qIsKsXR11H+86uIIWhMVFyxvAWRstkCWH5fFg4pOfB0aWiQ4gEhfWhdZTyQD?=
 =?us-ascii?Q?faoRD/ieWLchddsOXd1gU084BU+mGOB580GUeKVPx38+uARVkpniX9zyTYQf?=
 =?us-ascii?Q?CuDxHtDiZhkg5q8IyDS87AnFodqZSStaxKZfyGjKyF/v5jH4/wU4mtSdfwny?=
 =?us-ascii?Q?ifaMg4mL2x93XTKNAJu9kXF1vTWGs4pVyGdbugsbljo1Wc6xr5zFcnqZpWK5?=
 =?us-ascii?Q?ojr1Dg1Y8AI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/XCKqoxlu9QPndjeAp5nmOh4QItT43M6KuggOCwiiL/nLzPxcHKGktMh9tJH?=
 =?us-ascii?Q?ovdxWM+n0GUJAXIuGWFbcTx0YOufMK8iErYodKPutnNcTTCgAqm6IqiNjiLm?=
 =?us-ascii?Q?pPEzYMbDcSb7807DWdpyGQmEkn60RG8v1xuhafYYbRgEttm45vdeDEP5omOV?=
 =?us-ascii?Q?JmyN6g+TgLDBJzEgqTu0DnKVUdJFyPEdSPd8Y3bhH3lbRKWrwSrZyuxk8UED?=
 =?us-ascii?Q?Hd8BxiHveLNG8kw6G4LMWc1FvLoNX78Sb+UyTeQZ0u34kGBLTAc4hK6NKNo1?=
 =?us-ascii?Q?L8jpflBNroT4tq0kE3yq/p+s3sJEAl+3kYDRljn6htveismmqqDWm6BH1p7F?=
 =?us-ascii?Q?1CaviUP21IdHmLSUCgHUzlVH0fKm2XU34P0KKQ5/LVOmzsbfpED0Ut6+s2E2?=
 =?us-ascii?Q?npA0OkaYXoWcI9EejbgQff8a5D8utRIjBSR+GkiPSLy6WPCZ9ah1CsN66o5R?=
 =?us-ascii?Q?dCK2iTaAmiPejG1MAGZKHxeo3fdxrXJEaoESX32lq2AssXR96Bu5Qp+0iVB0?=
 =?us-ascii?Q?i41/AeH/YexcX4lOG6jy0FIIhwg9e49+9fMohz7rR0pny65aNZ+avsUzpKxo?=
 =?us-ascii?Q?TgrcSAfJLy0BuiMWV/YtIzHsdCh+B6lFdIZOWTW83gLVdPo/vSa36asqyQGI?=
 =?us-ascii?Q?7YV4+nWWJCik0/rkbwOFQShDGNFllAR8EHrbqckStPxjKeuTF9sr7bZhz5It?=
 =?us-ascii?Q?TLYNhJv4SXZWvYGR6qMEukNf6OFvbW3koHy+4o2GQ6tllD7WKUXT7O/Nwu8K?=
 =?us-ascii?Q?a3UYkoyG/TDUp2OgC1CJ2QxiZURllG0e0MSfdq7bvKYn/pW2AanT93JwrIO9?=
 =?us-ascii?Q?m1pOcTHXENZxEtg5MxWiq3jua1Js8R0ONlruG4oF8cc6AU2oKNZ01fi0RVHz?=
 =?us-ascii?Q?emBQGNxydXCCjmKt8x5qOoae4qkWXFVjgkaUFhosSnPXdM/g2Xjv43CjoOGf?=
 =?us-ascii?Q?ToSWYwdudD+f0xSANYZSpo/No9w59aaqUhKxbP33KIhPbtHjQL2HgFBVD2U+?=
 =?us-ascii?Q?76L91bdnmUaamhHggIkZqC1BS3f+MihLrpj41IxCK56A73nM5fPv8IGYSR7A?=
 =?us-ascii?Q?arcXgStUD71UejOOHRDtKi7bYdWklD/Bw0R193z/6LmANasigsfPmdqQHTSX?=
 =?us-ascii?Q?g9F0J2z2KSIgb5Vl0hKagFRZLqoHXRoUEJq/59KIhwPE6oTDTy476boliuVD?=
 =?us-ascii?Q?8u3UnjNbxMXrKnyRBNMjZxhX111wXfFQYc9T0BQKklQXSsRemQh4HGKR/DTb?=
 =?us-ascii?Q?Dqc8kralCsLroMN6ajIfK2Mbog3oZbNYzyWGEuaIyPNWLASTCb3IZDJl6y8E?=
 =?us-ascii?Q?9cKPSiKGj4tt8S0DIZqxMhinINjwpSJcJeQJIs5QiwGlt5NwXCXzzrVuUt0u?=
 =?us-ascii?Q?AueHnMEGMtHHi/p6DCq7EguFJhAO6N6cjDrz7aXcCnj/lAmv35KRI9cqlvCs?=
 =?us-ascii?Q?F5ec5JQHUT4USokTEwGBd1TjaJNG8HYpE8Ta1lKSfSHhhzGcpGbcytUYckEh?=
 =?us-ascii?Q?Y/sTiDRzsHoYM+//2JhI0C5NnGPZli/ZcXsaUBIfqrYS7APeA+ydNQTykdfl?=
 =?us-ascii?Q?ythnqdJIIS/Vd3rsm/vn25m1GsSld94IJeDyvnkCTyo/ImXakTH564FUk8mx?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QLi+aLLuWm4HPKItezQnMrtrfgUDHUw2+poJPbzpmgK8nax6HSU8tkbZpeOiKOFXQ5GUJqEdA6C7e8toRes9RAB+xIPCZiWWrbpTlWLtZbYaplq2B5f4Bl5cfXG0BwxoXXr6TzRxAiMk8k80TzT+/beK3yBQzEpPl/ekYxLThUAXyVP7eaCb8wAaPGAhykbR16YM1oSw6BsnDREyHhjCBxYmCm3dt1K06Yz2RU960dBBFhI5aVUQaDvduEGmWJDeEaXCWIdZKdkItSvybcNv7bnYF5Ht+lwGshxrRUKyIMQMTX1SK9vZMgcXbIXlhe/vsaGZePxetg9RUADv1LGUHvUwwC/rkH3yv0NSeKUgP8o0s7EZs8VAj7MOocVWA0dHFw58BXT8pt6aKBGYWuZwbJk8rNCttqLk0/zSGJxwEjWVMtyiSkjJzb8FoGYMt29KelVRMKiGV1um399uH8UQrZLvxPosCLXlxDcqp/PlfQEYIfAa8EDHpAFwIL/oH/4cgl4DFXaULGQiijtP0zgt5BJE9glD2t/m88fq/XxcQn9+qGHRDQUy7QX5awBNFKrPXEmVGKu85SitL6JXfs+iTCx4uhHEnfixjw+KeYDK2dY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d0f716-3f67-4836-286a-08dd88d14b0f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:57:44.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAJio8q0v/eN3OQmoWLRg8RTTtcZYTXIQlFzJuh3H6f60wc0w292HD4n0FrRjO77ZGubXYwo2AQ5Fi9l6C9cfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010128
X-Proofpoint-ORIG-GUID: 7kVT3Rk-_9aPHebeOqpX3d3jLkj1SnEu
X-Proofpoint-GUID: 7kVT3Rk-_9aPHebeOqpX3d3jLkj1SnEu
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=6813a80d cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=04d_y77oF55RfSPHe00A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfXyYR8NMETHUN4 mFHNOHWlX4ezc4H7ie7OgnxhdVuVBSuqsXC+eIZCSaFSsmYFwon8kRJxuZgxQ63+qZCF2DrlNg1 W/O/Kg7sPFoT3qNUgfvWXpbAl9Ch+Y7tK8UfLmWU9EmxjTtEAaUnIaiYTBr94DPC4Bz4PCSbrYZ
 I4iZWidVtNo8HKsucOVPtyaSsajEIzHNq5CZhEoySRPlZjnmZgpYaozlalsManQlAQRR6W6uKpF 9lC0JvH2m0cxKRmP3K3lv4LrGh7l755WL8dKK8YK/PdfstL/7VnjPUW4FN+1LDq02BXSzWYvPrI LRBCmLxSJ1jW6vRzQBDWZHxmiUakD9qqQ3qWo9TiYx605ZGgeI1n1TTZhC2lX38PxE7Ddq24t14
 jC5e+CPlaLZf89mTmmWuTfMvz9+oRKzu0epXm+cGMYfa+6lt54MgVNCPLtQTIbStJZkAoQyN

Currently atomic write support for xfs is limited to writing a single
block as we have no way to guarantee alignment and that the write covers
a single extent.

This series introduces a method to issue atomic writes via a
software-based method.

The software-based method is used as a fallback for when attempting to
issue an atomic write over misaligned or multiple extents.

For xfs, this support is based on reflink CoW support.

The basic idea of this CoW method is to alloc a range in the CoW fork,
write the data, and atomically update the mapping.

Initial mysql performance testing has shown this method to perform ok.
However, there we are only using 16K atomic writes (and 4K block size),
so typically - and thankfully - this software fallback method won't be
used often.

For other FSes which want large atomics writes and don't support CoW, I
think that they can follow the example in [0].

Catherine is currently working on further xfstests for this feature,
which we hope to share soon.

About 15/15, maybe it can be omitted as there is no strong demand to have
it included.

Based on bfecc4091e07 (xfs/next-rc, xfs/for-next) xfs: allow ro mounts
if rtdev or logdev are read-only

[0] https://lore.kernel.org/linux-xfs/20250310183946.932054-1-john.g.garry@oracle.com/

Differences to v9:
- rework "ignore HW which cannot .." patch by Darrick
- Ensure power-of-2 max always for unit min/max when no HW support

Differences to v8:
- Darrick reworked patch for mount option
- Darrick reworked patch to ignore HW
- Minor changes and cleanups from Darrick
- Rework some commit messages (Christoph)
- Pick up RB tags from Christoph (thanks!)

Differences to v7:
- Add patch for mp hw awu max and min
- Fixed for awu max mount option (Darrick)

Darrick J. Wong (4):
  xfs: add helpers to compute log item overhead
  xfs: add helpers to compute transaction reservation for finishing
    intent items
  xfs: ignore HW which cannot atomic write a single block
  xfs: allow sysadmins to specify a maximum atomic write limit at mount
    time

John Garry (11):
  fs: add atomic write unit max opt to statx
  xfs: rename xfs_inode_can_atomicwrite() ->
    xfs_inode_can_hw_atomic_write()
  xfs: allow block allocator to take an alignment hint
  xfs: refactor xfs_reflink_end_cow_extent()
  xfs: refine atomic write size check in xfs_file_write_iter()
  xfs: add xfs_atomic_write_cow_iomap_begin()
  xfs: add large atomic writes checks in xfs_direct_write_iomap_begin()
  xfs: commit CoW-based atomic writes atomically
  xfs: add xfs_file_dio_write_atomic()
  xfs: add xfs_calc_atomic_write_unit_max()
  xfs: update atomic write limits

 Documentation/admin-guide/xfs.rst |  11 +
 block/bdev.c                      |   3 +-
 fs/ext4/inode.c                   |   2 +-
 fs/stat.c                         |   6 +-
 fs/xfs/libxfs/xfs_bmap.c          |   5 +
 fs/xfs/libxfs/xfs_bmap.h          |   6 +-
 fs/xfs/libxfs/xfs_log_rlimit.c    |   4 +
 fs/xfs/libxfs/xfs_trans_resv.c    | 343 +++++++++++++++++++++++++++---
 fs/xfs/libxfs/xfs_trans_resv.h    |  25 +++
 fs/xfs/xfs_bmap_item.c            |  10 +
 fs/xfs/xfs_bmap_item.h            |   3 +
 fs/xfs/xfs_buf.c                  |  41 +++-
 fs/xfs/xfs_buf.h                  |   3 +-
 fs/xfs/xfs_buf_item.c             |  19 ++
 fs/xfs/xfs_buf_item.h             |   3 +
 fs/xfs/xfs_extfree_item.c         |  10 +
 fs/xfs/xfs_extfree_item.h         |   3 +
 fs/xfs/xfs_file.c                 |  87 +++++++-
 fs/xfs/xfs_inode.h                |  14 +-
 fs/xfs/xfs_iomap.c                | 190 ++++++++++++++++-
 fs/xfs/xfs_iomap.h                |   1 +
 fs/xfs/xfs_iops.c                 |  76 ++++++-
 fs/xfs/xfs_iops.h                 |   3 +
 fs/xfs/xfs_log_cil.c              |   4 +-
 fs/xfs/xfs_log_priv.h             |  13 ++
 fs/xfs/xfs_mount.c                | 159 ++++++++++++++
 fs/xfs/xfs_mount.h                |  17 ++
 fs/xfs/xfs_refcount_item.c        |  10 +
 fs/xfs/xfs_refcount_item.h        |   3 +
 fs/xfs/xfs_reflink.c              | 146 ++++++++++---
 fs/xfs/xfs_reflink.h              |   6 +
 fs/xfs/xfs_rmap_item.c            |  10 +
 fs/xfs/xfs_rmap_item.h            |   3 +
 fs/xfs/xfs_super.c                |  64 +++++-
 fs/xfs/xfs_trace.h                | 115 ++++++++++
 include/linux/fs.h                |   3 +-
 include/linux/stat.h              |   1 +
 include/uapi/linux/stat.h         |   8 +-
 38 files changed, 1320 insertions(+), 110 deletions(-)

-- 
2.31.1


