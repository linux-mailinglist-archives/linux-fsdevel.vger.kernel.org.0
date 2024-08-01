Return-Path: <linux-fsdevel+bounces-24812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B80079450AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D38B27C29
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC161BB694;
	Thu,  1 Aug 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WRmqYxHe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OzmniJQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063581BB686;
	Thu,  1 Aug 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529925; cv=fail; b=MlDwt5JXB8zTl/Fg1Z2F40MXbkEEOrgIqEBcE8J1uu+f1PQ8TmJTiYdEmnXrMUVPVZwPZ8KrEsVckGHIETM0SaAwAX4nVochv7Mev+ZdztMfytaHvEqpisv/+fIOksDrZVM/J7K1Np8okAcqoKlUtJitN9l4u9ZARok6AJX/r5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529925; c=relaxed/simple;
	bh=c8gojaNtQGaRgutvm42uCgJqO5Qhcwrfzgld/BMcKhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X+rZyUy5gW6ToMhu7WZOuGwkAHXVs1WSNsit0Rd/+uhog2HOROLziz51KBd67Vzw6XxHhoiQDpJGCHfqIk/UA10ZT5zjp5F1mz5MGCIXwqLOZ0DYMNGMfSx9rqdfSl2BE0sRxaCIeX8MXbRTCytwO7x55gYyywBagWvnNMfl9No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WRmqYxHe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OzmniJQp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtV8k028570;
	Thu, 1 Aug 2024 16:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=mfT8Q94CDIpjJ9DeddZlavq3BAlepPIDJNWQ+avK3tM=; b=
	WRmqYxHe5sCtYVSmrnGZlqOkbhndGbf845tclzGya6m//eMJdvkJfBvdHQ9Vfb0c
	PHjBod+9miBulXUJH0FLAITJIOJL1Tfs3vAcz27HNmpSm4UBpUnjQ+juJDovLNWK
	S8Ckdve9cEP+as8wU/+kDFtRk/a0P0G1ImuM6BURkoe/UktdwAbc41ku++m5DJ7N
	fdHdUPBZc5gu25D8u7o5AHQiV+N7o9jssGAWz5u0BM3dXjCNuuVi1c/ZglzgnloN
	j/KEwxUNGIWq/BdqXmOSmKDV7IGRB39nqF0M/ReS9cxQTL/Nc2vY9v19mseNnzOq
	Cx3r5K6Vpxw3uJHDIktTZQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfyj779-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471Fe9Hg036902;
	Thu, 1 Aug 2024 16:31:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp0es54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t26tKcVDsDYGmnh1D0EXikIfI0zeooubdSBdZifjbo4tXe+UGRfVHkXSpRp1gX2T7e/yANuIwLEo3pNnJ0rKPoqRyz1iKtdU0I4AjZZDr7ayBO8MFQoO0xZYqxswYM0pBBHpPRdaGxWXx728XDfmXCf50WOremm0+C2uojsqkOjq09c3QwNiIIg/3WexlwIJxSBExhAtUbC50WPwyprVEmKjIppu+iHZVbFokzHNGR2UstFF1BmCHu8jbc/fWL7aubL+Lq0OqTVSff13UyS8ARzkiKDIu73zFLnqlBLnzrQ+VkzPpwYj5wwJrcQfO5SkYtFW/bqMBKvRRNdvcuNJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfT8Q94CDIpjJ9DeddZlavq3BAlepPIDJNWQ+avK3tM=;
 b=kq7i/aDrzhgeD1bxEafohueyWzLHMgkhTpYiWMG/iaenNFk08LOwWFYflPtzji3uVbVZGita/9DaaVbGXsHxesv42sv6pV4pLrx1HhTG+8BXvEJNMm4fsezcI/pi/LM7U6TH9g2hTf7l6tEywtTzk9PVSW0qF+ZzSerZYNsUPAoeYaBikNZD5sv/HwKUh7imeJrMvr9/p2BTq5KC2TclDc69AXbEGtkO67Ij7L5p5Fav0EtKe8H6kb4LuX91jy9UybLNNpW//FNSk08rmKDw6tElcnce5fCHqZLoPk6goIyTKU2TL7I5wIsR7f6P+Zv/gD17QzvrMblCpa1U8B9Snw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfT8Q94CDIpjJ9DeddZlavq3BAlepPIDJNWQ+avK3tM=;
 b=OzmniJQpuEkLvrcCOcRC2H8lBLdtUIT4ypKA3fw2km6EqmQuSAOkTrLKh0tiAOVvxz7rCBh0lnj5iTD8lbJmrBheVYfsv6f8uUgNCkmJVY3zWwXb/LUcozSFFOM0jYg9Wr4kdrAd8PX+Gi9M0DqkkSM8m4OQR9NsVjHU6ss5EKw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 04/14] xfs: make EOF allocation simpler
Date: Thu,  1 Aug 2024 16:30:47 +0000
Message-Id: <20240801163057.3981192-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:208:2d::48) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: d942695a-1d8b-45a2-ca52-08dcb2476cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6BbZ0tYR1Qi0n49cmc2sPUZHSbh96g9mHKSXAMKp9W0Rd5cXxd2AIgWZ6eD7?=
 =?us-ascii?Q?gGzdHGnGW04F94CZgPLxDuTACoo4g+CM7+E0YcWmDbwA6KGXMwBDsdXPkNzf?=
 =?us-ascii?Q?u5zIn1XJUdupmsjwwMn+HVjavonpsjHlpaEuaFAyWXQubumtT1+DPRayycp3?=
 =?us-ascii?Q?In/UG3IaVRbnpAdmqwrnhMySjNZDrkvwbyQXqKziROLxJN6QPzqSGVRsFAoR?=
 =?us-ascii?Q?skWkPfrUkL66Bho1NQ3WyClGErj0sDEPoYV4iyqh3uyDwo/soxrG3HehO3g+?=
 =?us-ascii?Q?pHa7Bf8/36Dg6+1cLiY9Vql9BhGzxOMjKnKGGjQ4K2lmXpJ1UZC+PlwwvYo0?=
 =?us-ascii?Q?8DnuY7YWSiIW6yzMdqumiVcGFZUoE71pmniojmYbB9fz+xfIC1i5euzBGaKW?=
 =?us-ascii?Q?ayTEqi/38pO42fGOMj1gzmj9q+r4U2w2saCnl0SX0tTVuZZYR+52i/qgh3xE?=
 =?us-ascii?Q?m2Ao/IpHaQq2Rm3ckpikSRod6HsVuy78CM0kX71KDnyGGse9LvGSlzpL8z+z?=
 =?us-ascii?Q?nO1MaCGdu6t5SP09eAUZrRHuDrHCaGk5V+hESio4jJFF3pICa3XLu8qMZa2G?=
 =?us-ascii?Q?JLd7DU+3o6oRPDfzyWlwYbeFxrHRzZAKdo68pmaNV/vm1r5QOl38tx5Ny/OD?=
 =?us-ascii?Q?KAOLVCc9BsGHLpVcc2bs/8BPOZKLyqXjva+sq2BCBikJ3dZqLo8WKNrDM+lw?=
 =?us-ascii?Q?t1bGL6DQiNqbc8bCLtLND3K36WQ7QkJUgen36SQw69BmzPOQT+Oi/TmHQucS?=
 =?us-ascii?Q?iylRRAFmLA1NvAf7s2rO7PWAS3/MChM7oPoS/LRYE08I+IpKU9z1nVjxh5km?=
 =?us-ascii?Q?imDdh+oruKZdQh0gMqQ9bf/igmis1h//dL3LIzPkPN3GVXbJjZUBbOateHWv?=
 =?us-ascii?Q?qb8GvMd68QnJcLLEnCcu2bQNRMDXWOTv3MBAQZs/MC+ZlGOUxWtL/+61wVLF?=
 =?us-ascii?Q?gWkblHZg0qp4WhkyRkvweFhluuFlVUI2oJI6jUEjATaYKY0aLIq6BWJF2L2n?=
 =?us-ascii?Q?E/+2i5hYILktnK0jfAP8ahr+Rn6gZsQzRRlKTfXx7L55/nep4Nd4DPAgu38i?=
 =?us-ascii?Q?A1GPgX+lA5iy4oCTKjgRGxD+0TYtb3TezcLc6TH9/oRA3RogUufZG/D5DrmO?=
 =?us-ascii?Q?gp7nkaVXZYlmP1F6evHOkXYyLKs/zucnzij3vCli/+lhjw80fMLqQSYZFEZC?=
 =?us-ascii?Q?BwpAw7Lfzil0M2jv13kFSkiPOFlUFHdCNWkSclM54x8m/613zQCVbafbVqJw?=
 =?us-ascii?Q?n0fHi+Fg00gSrywGT3DEP0zN4FmAxZO0mIFpcjtCdiaxXweAs5TdsnEz/6aY?=
 =?us-ascii?Q?pQ60V8uDYZKekj2vGyx66l4UcSOBgArnGTBGvIHCaudZpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UV1T+/DiMAuyCQg+sftiN5LJ06ByEWRbwlJVKM1hMuVzXgML1nWNZCtrYTPt?=
 =?us-ascii?Q?Rk4NmobyAD2hxw4ZLjHOpngSxNZLkqPamNIv0xdBVw1t+hQvs7DMvVTp+pFv?=
 =?us-ascii?Q?4KyF3IVaHJJU5ECgFLfb8AH9x/JrgCOVn8keFVQvYB4iQiY0RCVgPHP6q1T3?=
 =?us-ascii?Q?DgJErU/XS65ytpTjHeaN9nYlPT+7T/hzSK9PluJqceFeSHritK0ZQl3Xr5EQ?=
 =?us-ascii?Q?GXQ0kZfPrWJRJoy46qLa+2P6RJt4OYcjkC0SmKicduVgJ6n0LuidYgzb/5fU?=
 =?us-ascii?Q?jO3IxQdmk06TlcqDd+v790MvP/V/qvtbvTZ+FKTjeWrtWas9f2rDIOjxsu+g?=
 =?us-ascii?Q?NB0tmGxFXAOEP/8+mItgKXblxPbMq8Qpf5p8a3TenTXabSsxZbhcA2a3Si3P?=
 =?us-ascii?Q?t+UpQIzmJOdxIcz0iBwd2vQKemd/YXtJjn1CPfUKaejCobDhRoLbmBUzaaTT?=
 =?us-ascii?Q?CRhVgONxOD31L/WrwS4ZEBrqIFfgZFGyadsmgKj+EYv9OGJ72XvfmITSXg0q?=
 =?us-ascii?Q?/co4WOfttJoqIHSkjbRk4RZDtTiTDgY0U9b4X9aExPlqHvdQwE6IcXcKwnGg?=
 =?us-ascii?Q?4fom8dgskv0SfAC/8MysKYKCd+7WrR9FTVm3zViALHEHJC+NWxQieYJuwtOt?=
 =?us-ascii?Q?/yh1XNO4aGq1K/LfEZ3GOySsfmnVOkLp55g1nF6/v/M81PlZc4QhWTwnmgHZ?=
 =?us-ascii?Q?y6jzw7E0aHUhPusdigrTAbOoFdcaRmeG4ccSH941rbhICgv639UTDYXQD1/L?=
 =?us-ascii?Q?2pvzNPT5ycEX121NohnCQ3AdctJAeNLPbzhhHg2BhZtQ5tb3s6D68QB5rZ5T?=
 =?us-ascii?Q?D6NJ1DiUPnN9NGNNsNWCZVIOMk3zC2I3+Q4zp5xgX06BbRMUFQennUsxB2b7?=
 =?us-ascii?Q?L6jrO2pFaeRNAu3q5OTc/CcPNhqF2N3SpBht/ZnSSXJrM1y7KCqWYqNIE5lD?=
 =?us-ascii?Q?6DxS4YrN5B5W+HigEbqi+AseaD3cZVfsI2z5u9xEc2DdiEx8vlixyqqGhiqz?=
 =?us-ascii?Q?JgZcWnyjwWHbWoabuVzwA9BT0ki0p5KI3QtWAP95SoKWXQAg2nHWbubSUQVP?=
 =?us-ascii?Q?82m7OnxIJZjISnXDcKK/vHyebLJYPdWtxhpKRckfcmCLQnMX4uPXcHhGIeB2?=
 =?us-ascii?Q?F5TmWp79rEORj02I/pTxf6TPqJHipFEQQ+PlVBGq2EGXLKDC4hQ4isBzip1m?=
 =?us-ascii?Q?9rGxuZ7PcPSxFwF8v1DWvdLIPW+CulWYe5mUdXws3rXmSvwrRV5q51Yv+tzM?=
 =?us-ascii?Q?6Jhr0OJmR026h2pQQeguW02m56ypCCogMxkdMG5/AW1/NGieWefbju8tr933?=
 =?us-ascii?Q?PyXuTcNxaU9NMGmGWOQ7iswcFZcDDHqz1OsCYgUh1+F9TY1+Nl+BGtqODwqD?=
 =?us-ascii?Q?G/tSH6Xr5BKfZnAxa5bHfUmDhNKH58O6/TK6iNWVfuTtMfXEnUJYAvttSJvA?=
 =?us-ascii?Q?Dpx3OU9PHxU/CsUPGVlp31QJa0nofS1qpv83cYRghvLnV8aaRUkJCZYO/8Xq?=
 =?us-ascii?Q?RUrv/YcV8HNanQ1dqKsrhx+Rm+Boe3qS0qrjDnzZQwiw8Rx8DH2rJ2ybuSaV?=
 =?us-ascii?Q?YAkD6Jd/ndZyavRHOMDF7OgW3zSusc85xmCTA7qZSTR7AkFNpbKSEFAX8AUO?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hW5t044uH7eANYE81PvbwcPeFUCBEhcEU288ygip7g4/FT5+rp+qLIlWWraj+P+cypHpjZt/bGRRH3wJhigGZBRjPKRvmHRGzSP1lGM2NlOzf+i621jC0lo5iHxJArXAlRVpD8W4jCJCL5lOhJCZeZ2c91QeNZ+ZnD257PiqgPB3IORC3Q/A22hpz/ealkvKHJ9cZoUmpBie9NxfVimMPVN7AF6ApEk2kDknKopyk4orHmSDD7p45vuJhs2IALHe/720Lm+SUC5z7HZi67uihk+gXqmN1ULmm7UAfMmqgBY9/1XsqfyvEn2R3PeRHbsQkqDDRWRx2V0V1uC+KneYYUdeiLT+qgMysW1H6VhFrmnFPSgKKrOuh7ADt29DRPiydG2WazX3hqsYS95S8U/kd5IyJ1KI2vhztNG9K9ptxnNImAA3AoVAVBESO4Q2lQJx4BPqKYMBg85BNmUzz636d6cZGnXpgRsgWDc3du/IInNyfpTj+KCQJvcrzabD7xm+GlVQHxqheMR4Cj235RO9OOZuxz/oziopv2FOMeV1buQEg1dfE67sVhNKGFG+58+sgz3rpJIrb9/2r/A9nYI9TiFhAi3BdgSNsXWRY54/zZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d942695a-1d8b-45a2-ca52-08dcb2476cec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:42.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXV33Ad7m2MMMIJ/+/PPh6g5r4hWHRMvbqN4+TxurPYokMBrLXgtRArbz1IzmoO3M7dscSGnOfyibPPUpYPZKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408010108
X-Proofpoint-GUID: QaA0oiZVGOYFqmrqbHmqxoCKznQfT-c-
X-Proofpoint-ORIG-GUID: QaA0oiZVGOYFqmrqbHmqxoCKznQfT-c-

From: Dave Chinner <dchinner@redhat.com>

Currently the allocation at EOF is broken into two cases - when the
offset is zero and when the offset is non-zero. When the offset is
non-zero, we try to do exact block allocation for contiguous
extent allocation. When the offset is zero, the allocation is simply
an aligned allocation.

We want aligned allocation as the fallback when exact block
allocation fails, but that complicates the EOF allocation in that it
now has to handle two different allocation cases. The
caller also has to handle allocation when not at EOF, and for the
upcoming forced alignment changes we need that to also be aligned
allocation.

To simplify all this, pull the aligned allocation cases back into
the callers and leave the EOF allocation path for exact block
allocation only. This means that the EOF exact block allocation
fallback path is the normal aligned allocation path and that ends up
making things a lot simpler when forced alignment is introduced.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c   | 129 +++++++++++++++----------------------
 fs/xfs/libxfs/xfs_ialloc.c |   2 +-
 2 files changed, 54 insertions(+), 77 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 25a87e1154bb..42a75d257b35 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3310,12 +3310,12 @@ xfs_bmap_select_minlen(
 static int
 xfs_bmap_btalloc_select_lengths(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	xfs_extlen_t		*blen)
+	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*pag;
 	xfs_agnumber_t		agno, startag;
+	xfs_extlen_t		blen = 0;
 	int			error = 0;
 
 	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
@@ -3329,19 +3329,18 @@ xfs_bmap_btalloc_select_lengths(
 	if (startag == NULLAGNUMBER)
 		startag = 0;
 
-	*blen = 0;
 	for_each_perag_wrap(mp, startag, agno, pag) {
-		error = xfs_bmap_longest_free_extent(pag, args->tp, blen);
+		error = xfs_bmap_longest_free_extent(pag, args->tp, &blen);
 		if (error && error != -EAGAIN)
 			break;
 		error = 0;
-		if (*blen >= args->maxlen)
+		if (blen >= args->maxlen)
 			break;
 	}
 	if (pag)
 		xfs_perag_rele(pag);
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, *blen);
+	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
 	return error;
 }
 
@@ -3551,78 +3550,40 @@ xfs_bmap_exact_minlen_extent_alloc(
  * If we are not low on available data blocks and we are allocating at
  * EOF, optimise allocation for contiguous file extension and/or stripe
  * alignment of the new extent.
- *
- * NOTE: ap->aeof is only set if the allocation length is >= the
- * stripe unit and the allocation offset is at the end of file.
  */
 static int
 xfs_bmap_btalloc_at_eof(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	xfs_extlen_t		blen,
-	bool			ag_only)
+	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*caller_pag = args->pag;
+	xfs_extlen_t		alignment = args->alignment;
 	int			error;
 
+	ASSERT(ap->aeof && ap->offset);
+	ASSERT(args->alignment >= 1);
+
 	/*
-	 * If there are already extents in the file, try an exact EOF block
-	 * allocation to extend the file as a contiguous extent. If that fails,
-	 * or it's the first allocation in a file, just try for a stripe aligned
-	 * allocation.
+	 * Compute the alignment slop for the fallback path so we ensure
+	 * we account for the potential alignemnt space required by the
+	 * fallback paths before we modify the AGF and AGFL here.
 	 */
-	if (ap->offset) {
-		xfs_extlen_t	alignment = args->alignment;
-
-		/*
-		 * Compute the alignment slop for the fallback path so we ensure
-		 * we account for the potential alignment space required by the
-		 * fallback paths before we modify the AGF and AGFL here.
-		 */
-		args->alignment = 1;
-		args->alignslop = alignment - args->alignment;
-
-		if (!caller_pag)
-			args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
-		error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
-		if (!caller_pag) {
-			xfs_perag_put(args->pag);
-			args->pag = NULL;
-		}
-		if (error)
-			return error;
-
-		if (args->fsbno != NULLFSBLOCK)
-			return 0;
-		/*
-		 * Exact allocation failed. Reset to try an aligned allocation
-		 * according to the original allocation specification.
-		 */
-		args->alignment = alignment;
-		args->alignslop = 0;
-	}
+	args->alignment = 1;
+	args->alignslop = alignment - args->alignment;
 
-	if (ag_only) {
-		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
-	} else {
+	if (!caller_pag)
+		args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
+	error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
+	if (!caller_pag) {
+		xfs_perag_put(args->pag);
 		args->pag = NULL;
-		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
-		ASSERT(args->pag == NULL);
-		args->pag = caller_pag;
 	}
-	if (error)
-		return error;
 
-	if (args->fsbno != NULLFSBLOCK)
-		return 0;
-
-	/*
-	 * Aligned allocation failed, so all fallback paths from here drop the
-	 * start alignment requirement as we know it will not succeed.
-	 */
-	args->alignment = 1;
-	return 0;
+	/* Reset alignment to original specifications.  */
+	args->alignment = alignment;
+	args->alignslop = 0;
+	return error;
 }
 
 /*
@@ -3688,12 +3649,19 @@ xfs_bmap_btalloc_filestreams(
 	}
 
 	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
-	if (ap->aeof)
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
+	if (ap->aeof && ap->offset)
+		error = xfs_bmap_btalloc_at_eof(ap, args);
 
+	/* This may be an aligned allocation attempt. */
 	if (!error && args->fsbno == NULLFSBLOCK)
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
 
+	/* Attempt non-aligned allocation if we haven't already. */
+	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		args->alignment = 1;
+		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
+	}
+
 out_low_space:
 	/*
 	 * We are now done with the perag reference for the filestreams
@@ -3715,7 +3683,6 @@ xfs_bmap_btalloc_best_length(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args)
 {
-	xfs_extlen_t		blen = 0;
 	int			error;
 
 	ap->blkno = XFS_INO_TO_FSB(args->mp, ap->ip->i_ino);
@@ -3726,23 +3693,33 @@ xfs_bmap_btalloc_best_length(
 	 * the request.  If one isn't found, then adjust the minimum allocation
 	 * size to the largest space found.
 	 */
-	error = xfs_bmap_btalloc_select_lengths(ap, args, &blen);
+	error = xfs_bmap_btalloc_select_lengths(ap, args);
 	if (error)
 		return error;
 
 	/*
-	 * Don't attempt optimal EOF allocation if previous allocations barely
-	 * succeeded due to being near ENOSPC. It is highly unlikely we'll get
-	 * optimal or even aligned allocations in this case, so don't waste time
-	 * trying.
+	 * If we are in low space mode, then optimal allocation will fail so
+	 * prepare for minimal allocation and run the low space algorithm
+	 * immediately.
 	 */
-	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
-		if (error || args->fsbno != NULLFSBLOCK)
-			return error;
+	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
+		ASSERT(args->fsbno == NULLFSBLOCK);
+		return xfs_bmap_btalloc_low_space(ap, args);
+	}
+
+	if (ap->aeof && ap->offset)
+		error = xfs_bmap_btalloc_at_eof(ap, args);
+
+	/* This may be an aligned allocation attempt. */
+	if (!error && args->fsbno == NULLFSBLOCK)
+		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
+
+	/* Attempt non-aligned allocation if we haven't already. */
+	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		args->alignment = 1;
+		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	}
 
-	error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	if (error || args->fsbno != NULLFSBLOCK)
 		return error;
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 2fa29d2f004e..c5d220d51757 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -780,7 +780,7 @@ xfs_ialloc_ag_alloc(
 		 * the exact agbno requirement and increase the alignment
 		 * instead. It is critical that the total size of the request
 		 * (len + alignment + slop) does not increase from this point
-		 * on, so reset minalignslop to ensure it is not included in
+		 * on, so reset alignslop to ensure it is not included in
 		 * subsequent requests.
 		 */
 		args.alignslop = 0;
-- 
2.31.1


