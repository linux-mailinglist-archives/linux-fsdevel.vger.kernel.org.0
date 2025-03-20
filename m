Return-Path: <linux-fsdevel+bounces-44560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D1A6A5C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD014189A9E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6DC2206AE;
	Thu, 20 Mar 2025 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QOwf5Dm8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lEI32QDI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E421CFE0;
	Thu, 20 Mar 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472203; cv=fail; b=WaDb992IfiPH3gnSrqSrEx/NdJsYLY3HT5ZKR3q7XgsEVLGgnFZ2t7Q6s3ai5Ssm8OgepjjY6eu1LFJmXD28pHO618T6HQWMBV8cXoIi4CM1KXN9X+ClI+9+6XGKI2zy3z++QZpj/6iDaPxNG2jL368P1hyJC16mCsjmPEbdf5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472203; c=relaxed/simple;
	bh=RJ82/I3qgd/7TM7uO+VE5h5Jns8oekWSKstyNumcH/0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sU3zIUqEAlSrxBHwoJr3RfEVK8sruVWZMEjSzRcO7dRggWvM7WmCO+Stbaz2c4eLrGgsUgr4WueLfW1gW13GkCWhptI6MmI6KtWKVSD0/dellSsXgLzD/3ZHjmfyg+bWzZi0Qvf+Z4yrx09kT+9iWOnl5+mCEODuGdnGTEAQTqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QOwf5Dm8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lEI32QDI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8C4ml019774;
	Thu, 20 Mar 2025 12:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=WsTLHXubT65LBEiQ
	PVZXLH3wNRxjEGsUTCSvxqgb4No=; b=QOwf5Dm8F+yNS13KjzOAwnQfAMufRtiU
	oNuVbltcAQFAdIjeAiufmgr0TqYeGF7u2odSlhdxMb6mQdjy0Y6epN/0vDpLALSh
	nNaP6KtcYz/UKwnSyvBl84uAhF7p4Tvq4b2ugmN6e9RTO5ULT9QzXd/+Sg8Ml3fX
	jR/aId2jnZzKxBfqXGXO166I8uD7oSE+L8oXRENYkiXXUhvp78SI+/9O4j37GBXv
	3accHUgwMAXVSFC50EXJ82eSR6uivfxMCOXaka91E8UTTzGBmyNj1ZO8INd3TV2q
	4I9b4DvZ9Zj6hfsRP78XvHkael+XVT9mnrxmi3lrjSokuv+S4nXI0A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hg5r20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 12:03:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KAfUV5024558;
	Thu, 20 Mar 2025 12:03:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbm9xbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 12:03:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnnJ/aGyFjfsuewKj+fivuzX1P0zIhiG/uPGwVWS93z6vYWPguVPcHup2eiwzEdyn2U860B4QhxlUlWDX8bhmpfbLVv4FevrlHzh/Xroby0zBh0c+jn62STHjy6i/lWSSLG0wI91Oimxu+LOcmlN14jxqFA9wEKAQ1zP13uW14QbkX+JRQv1U7co+ZSeQYxKyW3TWI2qbP3JnZJtwadolp0kDefCfUY9lbrlwgdd1cFafT7i/IRA2imcRQ/87dV3MYveJFlPAtiatSGYZILnzOcaJCDMYEKAopSVlylaMpXcvCCD4k5h3DxALCNOxrshBz1FuJNg8cXRB6Csgl7/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsTLHXubT65LBEiQPVZXLH3wNRxjEGsUTCSvxqgb4No=;
 b=sfaNk6SCqfPNfouDeQl+XE00XPVamUgtfqq/fH/r2fIbkB79uu+Wpp8DKexkG0OVMRSWqvtTfzK6cD7bOP1uEP/tmfLg/9DwHrnPCUXYAx3bwhqikzgsP9TO9lcW0AGUXIAosaw/hRtkDppKcs96nmU0tI+xTd33x1WEsvuurRRXSZGuIVQBoyG9Jw0PyJaRMPvGWfT2ZkHa0k7x7JZQOeLmnoA0TURJa0GoyEXf0o1tTNE1R7ntiXDJ6YsXLkMmzfx17YbPz7c39QUIji8FG6uM3BU6loIIRnDDp/oA4d2PWndQy6erW/CgVygzyOi/ljgTBeZQCNSLK+vWujRsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsTLHXubT65LBEiQPVZXLH3wNRxjEGsUTCSvxqgb4No=;
 b=lEI32QDIJeuD8OKxl1xMu4Zhsx++4Hwxm74kjLJnvgJHBRFRyYQO+spQVadrzdtIjJgBNgdNk9Z5OXh3AtdVvn+TZHrLZB2dZCnhiYN2DpRlb8c0g2TKxpPeKTuqGBtk1tp4VzUkdEVCC7syqu0T0EiL992d6c5UGmgkgBsTBIU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6902.namprd10.prod.outlook.com (2603:10b6:610:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 12:03:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 12:03:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/3] further iomap large atomic writes changes
Date: Thu, 20 Mar 2025 12:02:47 +0000
Message-Id: <20250320120250.4087011-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0042.namprd20.prod.outlook.com
 (2603:10b6:208:235::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: b277030a-595d-413e-11ae-08dd67a72d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LsBsdHOS/I6IT+zZOCR6iLJWdkW9VLSMJaDctkvDzGYDE2lKTqC+duMUaHLb?=
 =?us-ascii?Q?rB8RWRAjcUrPFgo3AjpWXBtCB3zxiZjS50PuWEQZ8paZ0nLzijSDr4u52wht?=
 =?us-ascii?Q?E1HsxXrX4rUillVJW1TNs2qu/GMV7QFGXF9qWN98RKvmjMdmVaIq5sVrdSL6?=
 =?us-ascii?Q?VeLq4+2KNtftJfieRfmK5if+/5L1xNQKuGBx6WVVwT/vLZHT/QiwIMqwcXkt?=
 =?us-ascii?Q?QTnTdFN7YExXm1Wl+UZSCjl+Shn/J05SXK8UUcuZbp5OGahEo7D0xS/PaoHl?=
 =?us-ascii?Q?N5cPzm7JYsJoO+preOkl+M6zrnSTJ0xEtNxLmjMY7AqJTktyMZBMAtAi8bmI?=
 =?us-ascii?Q?DfbHBQss4VVqByF2Fd1u+PCN0NmGBU5aZ9bEN4teVuwWY/MkbvxPGlzwUgGV?=
 =?us-ascii?Q?hTfgMBkOo9Ee4/SONkEBo9XHvCm5umCKz3gtrRHPRtMTEhZCI/JM6UlpjFA8?=
 =?us-ascii?Q?KGzVUm3NjecByvCSZwEXg/hJl1oq5lVBY53ZNl+oMylwqEQ3RxzL1b4IjqEC?=
 =?us-ascii?Q?XXHWBOf4FCMlVoDWX77JH3N9HnC6fEIRRRNmFrstow7ScF24+NSTYQC5a2x+?=
 =?us-ascii?Q?XaL9/qXa3mb1McQzdyags6mXyGFYe04D/lGJHvFVXTVnLkEeU7QrL2/8ulpM?=
 =?us-ascii?Q?rpK3dKlbEMd7uHpQMKvlbmN34h0ZJbkNHvE5fyU4ErfMEbaJOTdGwNYsgxhm?=
 =?us-ascii?Q?/7y/Ldz7ni0cltpvdW4JE2z/QyxAJeW+kuMP0U8VbsbPE5sYnZD1zY5J+kLv?=
 =?us-ascii?Q?cFp65wI3JM4JPjYzf/FeeykEKovYA5qKd+qCKW+nKP5pLUy4cuIejb888G9p?=
 =?us-ascii?Q?TPKkvX32uPrJn1+Rg20p4pSTm5mciiLdzrmeg4+ZO5bOKmRQQv4erqNHzvFb?=
 =?us-ascii?Q?8/meKNnp67xbn8gS8dJ1Z7LPcpSjfdsrZ1totzANvfONK0Cn0K7Epm3d2yqH?=
 =?us-ascii?Q?nRIxwwzJ26FJDXLrWuolQczqAgneMJFUdlwQC26QLrUvm5/5yCtc2yRKdn0q?=
 =?us-ascii?Q?Ze0BeCyLNXOsHN+nDdxN6rkjYcYBXgn+UY8hfr0xmvp6hxaz7k5V5wMcYVGx?=
 =?us-ascii?Q?k0ll27/YjOTTD9S2Tevg7jENd58r03lhP5mCGW/mXL5Z/pG0RlR+FKgIQDCr?=
 =?us-ascii?Q?FV6NtpQBSMpdB7+DxBoAOt7GOSghTXbM1TVXjkY//PlqN2l7cBqSuzxIawZY?=
 =?us-ascii?Q?+/fiw8zZIqRSJIdfbdT0bx3OwjP2lNc4VEMZ4wlMhP+UtYOL+ZS5ZZLa9UlB?=
 =?us-ascii?Q?glMaXhP10NgFqbGjFA9QGUK/MD6mavlEIRWwD2DTLTKAfLfTq6Y928ttGCLf?=
 =?us-ascii?Q?WsvFzeTCHl7hoJqxCbMSeeQHuHIugAXez4BrunGy7ZXRhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1tBswaOovi1q6DdSz2OoMqiS8x2hsBeKYtDCrw/KTKLXO37EKcXVd4JNizU9?=
 =?us-ascii?Q?Zifl+ncUbaqg0nzKdW2PAySZ0QIV+qCeQrC4eLFuGT6SXrgdZv0CYPem5Y/g?=
 =?us-ascii?Q?y8P/uteo2zZ2bbGM2B+DjrdjQBfi1tYZgB4eH8zW7AMc3+t6JbsgrOjd8N4s?=
 =?us-ascii?Q?H53ttkMp5saUSJBdUSLlR30FQTCqzpnEqdTMmesMQMTOcU4rdg1QlFj/YCcB?=
 =?us-ascii?Q?2iDINYCAJFr73wwmxCbwCpBYKhVMbTqDq0liW2Dbgty20JDmpUTRn1dVlytZ?=
 =?us-ascii?Q?GjUnOttQXZ/7TDJVX4DAzIf3P+UZfmvGiUlgmd0N4FbtIl8IZzf6ykUZjMej?=
 =?us-ascii?Q?PMXYkZxLlC0OaRJjLIa2FyVb71WZWo/+GKFnIyT97J+XXPVmA/gV9C25/14y?=
 =?us-ascii?Q?W99XGE4TRSg3rY86m+vUnOUxE5gTmxWiRYByY9JH+nUH264eEiqI/Diih6g+?=
 =?us-ascii?Q?iBP2WTAjEyji+/r3asXY83nJq5yEQupnm6SrSp1WCDEcVbfC4YZrPBOm2lEA?=
 =?us-ascii?Q?IfJdWlC4JPAUf+2FsBrxJ4St6k7r6FHMxfK/mysWeNHUNk1IEplFSSpxB9jJ?=
 =?us-ascii?Q?BVgDTD3G88HbSEKqtMfkroPNlB0FyWdn950aZTo2b91WsyR0fWGPbbuh9tgR?=
 =?us-ascii?Q?Pox8mJBOsciufcy20JJ6db40UILDWzMmKF10WxOWZAnJREn13FrudE0kgbV7?=
 =?us-ascii?Q?FC26HPmMtmubTGAFBzwvNBPP3FKgOiA0wpzXUbMizupuifFYCOBfusuftovR?=
 =?us-ascii?Q?j/5B9g94gcdvTnXTBMQpwNWsxZKHfaaVmLZbHE0zdXk+7OXMFnJz47GUn/cU?=
 =?us-ascii?Q?I6F6ZwcEmfTQi420yqbd8/tHF+FKW7cYkcDvhBQVo9S2/um6ar6vDSFBEF00?=
 =?us-ascii?Q?8ZVX9Me2L2qv9ZU5tvbWBa7Umsdg4GF30/Ys4j7vn6nz9+WC6wn0hTDx6wsn?=
 =?us-ascii?Q?ZhaEPinE0Nhf8eRQJ/NjcWoQ4MOlMvD2ab4EYbxsNfLN64yRy6t2TlWshUqr?=
 =?us-ascii?Q?B6eGbmAFKPHQa9MJbRspw4HvrQ+L3GZi+ab9fQh5xjTIfENwAQiuYC5SbWuf?=
 =?us-ascii?Q?QstEfJsMNZqr9CF6d516B/7ZcSv8ZsWJ2m2EPLvA4UdO6QP97MD94aYIMyql?=
 =?us-ascii?Q?rdwD8D1t+D38s9pREL9sXCcGIqD48mfeY35tTM1aWC42IwWv/bjlgFyunVtt?=
 =?us-ascii?Q?R6ZRI/oEdChMmoZ2CnxDdb6xIYYDPVino4fwkd/bepHIsHZk0STyaOwOoq9M?=
 =?us-ascii?Q?xMsXXlLu92drFg3o6GaPPqfrMcs2Bjx/JlA61NbU+kclHJ+NTlfW5tu+zcxC?=
 =?us-ascii?Q?WAI7D+dbzbvWXrwQsXBzQcK2Iv4BaLbSm1PaX0rAOxW9RcEBV3DG1XyYUQtd?=
 =?us-ascii?Q?EzMWVhHt5KGTfQtHaSAVlfu2qJ0rqZ3Ibb4/uHJsVjyZl98c/eKmTGTNRoP5?=
 =?us-ascii?Q?UnzdXcBdonIOwfmPbED4t4kRD/ipXitM/dsQOUUeHRq2e8iFPkFLMXAC29b7?=
 =?us-ascii?Q?ttb+KMFVMr2dnYUc1R4TN7wWF9hSHDWidi3iAs9YD1AeSaFIMlrz3/wVSVK+?=
 =?us-ascii?Q?CLgffANy4nmzgrIcoDgGzWTJ1/RUj2iYPXAecaNuoSmHM/cNu4+rpXlHMFzF?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KXzUg4oVGo1+eroOHLi4AzKf8pSpvbj5JZ0i4IKjfxgNV2kYVCT0jjHGKzeSk+D0xi7aI8XiYeZq7q0FvxmQd1YwOkksxO5xz4i4XkWHjK5C+I5FY2KDq1VGLzbSCQacAg+XVIQBQh5tXsjNhbfjqvUxqBiaCG3PeBpoyhaa98c83QazazjAbcemqo6iry9vVk154W5qtyQr+YcoIShKsdTyJLr8+kbxc+luLTWyZ6eix1P/j1s5LVC2o/MtylOTbdUh/QqEzE9cYlZ8Q6HHJ6s1fbTXUEciexHRZ+EDj7JgMQjDXHZ9WOiZYysAUZgdnwfx9/3V56jZdQaElwd9MMdvIyRGzLsdvDjxeFkqW9EgX99RAvg8kQA3uGlmhdJoVlRauqEC1ydYet54naG19TGDd3YoERNvpdxWnd0pA2Cd6AfrKdw00Mj3A4RjfnqtYAshT+SnRBZUDaSSIkkJdwpZxLDowV6LMK1NU3L+jZimzwQrrF2kZs2FjGn/7yNaVfMxsxrec7YsT+Z2LhnUjqqVZDq8cvPruHUaH7aNoTIK6fAMUS+p2Y7/jbzNUD/Ezr2F1HLEzElW0ZpZTV/O5C9/YEzjjrtenx6p0LbnIqo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b277030a-595d-413e-11ae-08dd67a72d5b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 12:03:07.6103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hu59B0pXn+OQ4+RVhj+PfpmLieprUX3+o1zCFJ/1YyRip7XCs60edeMfXqcLnF9SNjC0Mih8UDnV2nIZLsEjTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=919 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200073
X-Proofpoint-GUID: -oh_8FPDTY_Je5pBM3H-X7Cc6xL5BcjO
X-Proofpoint-ORIG-GUID: -oh_8FPDTY_Je5pBM3H-X7Cc6xL5BcjO

These iomap changes are spun-off the XFS large atomic writes series at
https://lore.kernel.org/linux-xfs/86a64256-497a-453b-bbba-a5ac6b4cb056@oracle.com/T/#ma99c763221de9d49ea2ccfca9ff9b8d71c8b2677

The XFS parts there are not ready yet, but it is worth having the iomap
changes queued in advance.

Some much earlier changes from that same series were already queued in the
vfs tree, and these patches rework those changes - specifically the
first patch in this series does.

The most other significant change is the patch to rework how the bio flags
are set in the DIO patch.

The baseline is c7be0d72d551 (vfs/vfs-6.15.iomap) Merge patch series
"iomap preliminaries for large atomic write for xfs with CoW"

John Garry (3):
  iomap: inline iomap_dio_bio_opflags()
  iomap: comment on atomic write checks in iomap_dio_bio_iter()
  iomap: rework IOMAP atomic flags

 .../filesystems/iomap/operations.rst          |  35 ++---
 fs/ext4/inode.c                               |   6 +-
 fs/iomap/direct-io.c                          | 125 ++++++++----------
 fs/iomap/trace.h                              |   2 +-
 fs/xfs/xfs_iomap.c                            |   4 +
 include/linux/iomap.h                         |  12 +-
 6 files changed, 91 insertions(+), 93 deletions(-)

-- 
2.31.1


