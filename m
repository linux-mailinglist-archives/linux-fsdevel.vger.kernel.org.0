Return-Path: <linux-fsdevel+bounces-46936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA71EA969D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5369C3BDAEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFA82857DE;
	Tue, 22 Apr 2025 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nUBt6WNZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rVdMn/ZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92D27E1A4;
	Tue, 22 Apr 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324953; cv=fail; b=BiCYd27Q3Z5uDrXFE7pAeXmrmkJotpUvzkwKR3HRRVxMQ97/NcZNFx3Wo2F6mGAX0O7wV1U5z7co4k/l7SIBKga3o9qf8UkTD+Xraaon7Z3jOxGuyJ6DWzAKOmdGUiPRB+Pd04VhJxyY6T1DtfiMlHhpiidQ86wFXqiCyjXVyKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324953; c=relaxed/simple;
	bh=ZX73xGEFMOMYmNL4et0fTXURB9gouRcKe/bIjQHJKaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HE0rpOMasUfcTSdBigpBJ2XFw4wsZEbFXgpM7jRGd6QVrYdKXQzFr7hFZ3d40syXiD+u2q7cKBNQnSbsrNKSeH4Z93OdC4ptH/wgGWaKjg4SsKql5IBphFJ2BJFHPmojqn/OTystnGxnYYQOxDTRX9aDqRmG8WsdlhBboEscJzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nUBt6WNZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rVdMn/ZO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3EfE003576;
	Tue, 22 Apr 2025 12:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=c/CLJMpAMTPp80gzwn6FxNAejmPx2XltQc8IXHdhmjM=; b=
	nUBt6WNZwPDrxaU7j1itA5N+mz+NOlRCYcteSH0KiZzGKM2XhvhZ6WBDWEt1J3Sl
	hoKTjXyD/tCBs4zy1cw/9+gmRTz4a+vH1AND9AhaX023inqq6E1xum9jL5Ejjq+0
	tQZisGVI2znXVTWh3wZWrK126/vTzdgElvvivvxxFuuusfAeOALrs5NC3KKVcyGA
	EgZ9KZk2fvyk6SHozx0QMuNfyKMBLtG3N/uMyNzstZrJW5iI44STm/EU3EUCA56o
	j2WwQToa/mmgyHJl7+rVqUYCPMeoMTEEP8//nOhrM8zdm81TYJBy8RX74Vl2v7LS
	rJTN3j2Yg4Mm6X6SnUl0Fw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4643q8vbux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBtH9S002293;
	Tue, 22 Apr 2025 12:28:55 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012013.outbound.protection.outlook.com [40.93.14.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999v45-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRwuLBhmXELAa/H1xN1y2dUWS1oFaOduS8y1W/qwPt4HFcycz483Vt4qaoFa7xvI1ZTmNYXoM1XWP+LC23+WRzLe+BB6LwObk7lGWYHM6RYJxme5p8xN/jMDL+Xh9KRSagGsKteYYGTrktS5+MKnpsHflb0nWT75FfkbCCSrMs487Jh8ImukiO7AHTJ89kBuKEuZmTZUhTGE1f3+5Enp+BfgDuACxN9L9i9BAO2kdVRhUIA4PLcpdTq1/v24bCxnUYh+GXMy966IJdnXD3Hp/KbKR+XPhCxYVxG/i0b8rKN8imdcSke7FwHuop9Qcsh43zkJwaqXTjuAQo8blHjHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/CLJMpAMTPp80gzwn6FxNAejmPx2XltQc8IXHdhmjM=;
 b=kVGxgXOLpZSszzAsy/kZgYdmSjPUkEbaUZ4PU0HLQuFDs9dsD/hgO2llC+7pZdxuV9taHMOSt6rDV6IP8AMn3QFQ8R3YWhgHF6Ie02HZiaQpp1o+1M21TP4kYUWHwmYAIKqloAzHzOS71mzVX9yA2uj+z3v7mU10g8ztC0mPIg3TKKGT1lQDBc73NIX82gYRwlXOTYWhGHxLMox8vJ6i7Jlq+dCcU9Empe5oX3++Y/mJsKsyHN56B8KiOCsRPnzkuBY7LCMCwFSacS5pVjRv1OtZYGVhGEcacUd3NfLbZ9wyUeKlOy7/tPdxqI5PEJX0ZuvyHlvGpjX/bIxqTTdY9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/CLJMpAMTPp80gzwn6FxNAejmPx2XltQc8IXHdhmjM=;
 b=rVdMn/ZOD+HBQCyE22BAxxP4rZ2IXhztv2O7CRTKD7+lWSdhxt/KPShgr+RDTXcHwDUCMaHguHULxiJF2I4w/RxgNoMIhILNiuLh8uAwhDjNz1A0h0yjztu8PzIYUZqiwVFshxhQ8cupdSj9m/BugXyaSmlmGd5I/CQKf6wOa0M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 13/15] xfs: add xfs_compute_atomic_write_unit_max()
Date: Tue, 22 Apr 2025 12:27:37 +0000
Message-Id: <20250422122739.2230121-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:408:70::36) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 065c111e-4a0c-46e3-3e51-08dd81993661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oswCRlthuwu6I892KiB5J3urrt3bSE0v6ZlW1gH7UKer8JRGEzPAisUvrXYV?=
 =?us-ascii?Q?k3f4M7yI9tBAvfBDRMkYXDKiGb53hyY4vjWfmIeuKDX7aFHGFO45upgwqFv1?=
 =?us-ascii?Q?p9FBRKOIGXG5Mkw2ZuuOEaaMB6BQOXdzK1fv0hOJV+5Mb8QQkTd3YZwqotFh?=
 =?us-ascii?Q?PJwvKWuEio6Hjcz+McWNCkXWD4JbvQ4gUDHu5zwwId6o4OR3Iqh46P9gPdt2?=
 =?us-ascii?Q?avb2o+fvzMHkCv8YDuWndCJcCS+l275pgGEvq5qBsx3OPAC+JfbUFa+cTZGQ?=
 =?us-ascii?Q?18LEA9xGSJ9ZJ6LlE1o1OhSADmaJfkcrT+SQKBLSutJ5xv7PbUGeHph4oP24?=
 =?us-ascii?Q?mRu6Ux1GTQpYw7Taqx954doxJucJUwVYMLh0GWKd641J62OEi3nfMIMAO+XN?=
 =?us-ascii?Q?DfYXIeDgZK5rHKIohx37P32FjA2ktuGQxfgy94qgOl/aIRoHqq2fLjxekEK2?=
 =?us-ascii?Q?j3RQ6k9e/SRrecrkly42pp7ouU5ce81V/NFBZH5L3E1lXjcz3yA06g6Tmx3T?=
 =?us-ascii?Q?eirnqcQ2Vj0bKWxLb5f2ohldxqaqPhCr9U23IxUM3cJ1bWxEEiiDPqS9HQmP?=
 =?us-ascii?Q?Htmyz2CIp5Mp76rTIUA4Ibcq4B72DrWrp7+lGwHTahUYEwQiHFk4sEar+u+9?=
 =?us-ascii?Q?BSSB8hmrvJNZ0ZrkwsbvLInVDzSHtCF1OVJ2pqUkQxINFrZFNU/ZY51essbm?=
 =?us-ascii?Q?6E/Su0SUG6z9ts6F3chCmKiZ2bNGHrgNGJhoBNuNE2ez7JnmgphbpUwBIpRh?=
 =?us-ascii?Q?H4Jjk/ty15+y9uyz7+jfYF4gncIFDkMwvUI2idas2W2viG24z2CIpRqRbtc2?=
 =?us-ascii?Q?CJfiXRMRg9CQKIHkvHgZtYgk7bq5S/kTQ4Sn7Ndconjj/Coy7SUqTwvq73Bu?=
 =?us-ascii?Q?PElDXhcbvcZxmIWRxy/qgXm/8gZ8YS0yoXTCgh9AiHgd97zH7zdF27cFO/sS?=
 =?us-ascii?Q?L+hKSTYxCRnyHAg/Aw8aeNM7X1SCq6boUNXdLJPImTkxiIt4qBIGle4+I0QW?=
 =?us-ascii?Q?xCXVCALS9DkYuSEruKGPtiLrs5SfHl8jcSd2p0RAPmlVUkB+Iq0OwyAIbr2f?=
 =?us-ascii?Q?gcL6FBdwVqPYctb8re/yj9nY8se4dKYl7SUmwLS4SD2TyFZ9VynxbpefDULW?=
 =?us-ascii?Q?yS1uF/9le7KrHdPGoGDJefvWjmjdPqBvZh9hcFgpuMFLiqLhf/3An4uMHXHx?=
 =?us-ascii?Q?y9wueeQv0nW2HbEOnugOmtfFx1R+6DDSqbzWXm9P7INgdXXgwtEDHYSMBFn8?=
 =?us-ascii?Q?DW16x0aw1kx4QW43+VH73snc4EMBw9KK7FcJoXzqXMEaO9wmZpkvNrMu19jA?=
 =?us-ascii?Q?FSVo1LgOkKu892wYdcQGpyB6ZblcKl5NW1ukywl72AOx9C6St/Eu1UbUEl0s?=
 =?us-ascii?Q?jjHMa+w4AlaW201qKj9FRaQlNKkYw500ZfdI0kh/F1DVcCDrAfld6cVuAwy+?=
 =?us-ascii?Q?Y8uStRiPLKA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0L8gFnKTaH9ZqWZFBUZQWaIyq4oIkKeQ1iCorwqI8HnEQDlXTA66By1dtcZ3?=
 =?us-ascii?Q?qnOBWdxZO6QDq1nDlvALFzu2uGzjkCBXCZr5KuO8sCipEBj8jLmq4pjZQvGq?=
 =?us-ascii?Q?EgwHOEW4ZSmA+IaRfU8qx4BsqT4UjqNcV/8WpyfzzLXjmGYbijvbbl+YI8yD?=
 =?us-ascii?Q?go/L43BU/IDbrJTPmI57S0rq5KHULqcWY+VXRSZJH4zjUB6M86SEzjdeemm6?=
 =?us-ascii?Q?LiVX6iQT5Zfph3nfgsP0liEytpBn31AhVzDaw5UX7N/kyKTpQXcuozD3a5lz?=
 =?us-ascii?Q?P8nPbi705bSfXL0SCMuHEJ88Xh8o3afW6WagZ0NYfEiqIxYeJZEXG4l9KafU?=
 =?us-ascii?Q?arp8h4oqlRMPpAckYeOQL2BZGkzuS0J3wtk6nnDYL5LKsbhgNnZXYJ+JRLgU?=
 =?us-ascii?Q?OLXLdyFEgFHynIWggBloSCmRObq+C0zxGEo1+ImT3ZB6+Cry0Z2+/edlNQma?=
 =?us-ascii?Q?qwj4FF/HI6KlEjjoeVAy3awx/SelQHFn+ftbFLJXbYB+s4bvokYpPU/JCA0f?=
 =?us-ascii?Q?wHAfc6AWa+OCLTXT1gVuknDUYXaWsf5m8wgnBbDNaDgb8j8OrHtbCuP0jCEy?=
 =?us-ascii?Q?RUdEA2WXO0ijqJPI5I7qO2JXtrMvRntt4ZZkdztxMdCQY1jddGbzq7lcwfv/?=
 =?us-ascii?Q?9LIWj/W0bZIJm1Geq/r+PTSPvypWV17DN7fYQ4dLGbzQE7V1tfiZ4AaqX0iy?=
 =?us-ascii?Q?VLA27os2WxNtkCq5vTNfqMDL5O4kUdB51lHkWAcdE/CAD4l1CEZP4qSNB/Yu?=
 =?us-ascii?Q?3II/q7QvK0qWnmdUDHUAZGh2s+KQVnX9wI7X4S+MIW/cKyFbOp7ZS1CQhVoI?=
 =?us-ascii?Q?rR3sZL8I/BVZiJPIgRRfQmH6NvTD2THw7wV34CgSULsC7rwVMbFgRGuPmoTe?=
 =?us-ascii?Q?E9EjyAVOFkYQiD6QXK3e2uYYxL49STRGbhI3AfOBPz55pF0WFDWxUOmXmP01?=
 =?us-ascii?Q?Dkza9r6fvapjjqbGqr9EjmC+yuM1r7XBdAsNkWzCsx5axErC637SextP0jXV?=
 =?us-ascii?Q?bUw40xbapg6rrTAb2OmACVFLFEXfapn5tcz47/4vgWAgEFT3qBbJyoUfcYhw?=
 =?us-ascii?Q?6hPEOKt5LWFoJGyWwzKpvtPIwi9wZZ6OJCeS+m43oJuPI+40BNhzbHQx2z7D?=
 =?us-ascii?Q?iz7+eocTdNsFHxDLbl2JudNiM/F9EzXYa5mQRfUIATGZsPzV0jnKZu3zymsR?=
 =?us-ascii?Q?ZtGWr1gNeievs7dj+HNuDfh6fbL+/F3HEEXdpY6iYRRmIsS23X0PZs4BFwyQ?=
 =?us-ascii?Q?LWLkU/2618A5TrRhnolChBWphHIAyai+hj6Gkqcor+z0S2bc3GtselumkQlG?=
 =?us-ascii?Q?JCE5J7GvROig42FOdlge0J3HQXdqJrqO4YFwMe4bvaXKwwtmRtN6AhGqifDW?=
 =?us-ascii?Q?mgw61BX0PhmAv08csWwpp1I4KkD01DDMuWT1reFGL620saw2SNyMs2OZLSWE?=
 =?us-ascii?Q?vXyhL2HJ63bKSs8DJ0dxDZFDu+KFFQmBJNDvNyPq6Wq1GnWCmqXrdLD5X/mx?=
 =?us-ascii?Q?w51n8UZHYL6tTjooPLFMaP5biho+egDLuRiRj5YR0zoHE9sTOwvqxpBe+e91?=
 =?us-ascii?Q?61Hz9KnNoi58x4K00LhKXm7PO9FKJrcux7ZKloC1skpZlffhqQINGwFODOS9?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gucMJ1w88i9133H7OQjDBIO1biBsfnVcPHYmuFC2eOLFLF1Ze+4kLeT8kTKuINWjp8b5Rf/QZ/UJwt3hkNedS/eYfqyUJ6OzYae/gIhe9vE7UiXnuctNqVWmehgtmJVctx4Qu1rIBj483SJVRJBJsjZLYl+NGbaxrwpa73YCqTnEa+QiOAaRJCqz4Hc5aaDiisACaJE1xXuCfxDGNqUyo9IFTTR4L80WpuJ7WXcQ0hP7hySlqA+dtOALfTSpiOc1fWxxEbk9t+ig6vLMh5n9ITNddhKsALCGUr5OW+uCZgUOShEo9cXWo612dJBrt3SN4+pjzzi2EXI4XP0K6X04/bYlwmSQpCy/HZpF1tPQSGL2Vm86VkvCGwaoDFrHbqS1koUWuejXdcXyywO5bacsA6TWMfqXg3CoTokitAM9eTRSM4m+HuJIPfS0rbv0GBHtOluon8FCmIxc3+zvMk9+BJ7rxUDUY4aBMeRxroNZvWoJIhb7jI8oQaOozJmZ0Y0KjjrINkrgGSG1N+DVJnZyuyvKAHZ+oPeH/epdHsR2YHGehR6O4b3bvoVACEv1JXdRUALXQEZmNPBRHYQKzQ9HcxzCG6xJSr16eFC7pPbZ6J8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065c111e-4a0c-46e3-3e51-08dd81993661
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:40.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRfjDTQfyTkLxSY6TwnkgFaaWxNoiD4nCekoRIXqCH+GQIaZEmoIu0RCyRWtJZF4S4cV+z1oMCqZlxwCLNKeaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220094
X-Proofpoint-GUID: oDfzwhuEHGejATeieAH42E5YW6Ppe7n9
X-Proofpoint-ORIG-GUID: oDfzwhuEHGejATeieAH42E5YW6Ppe7n9

Now that CoW-based atomic writes are supported, update the max size of an
atomic write for the data device.

The limit of a CoW-based atomic write will be the limit of the number of
logitems which can fit into a single transaction.

In addition, the max atomic write size needs to be aligned to the agsize.
Limit the size of atomic writes to the greatest power-of-two factor of the
agsize so that allocations for an atomic write will always be aligned
compatibly with the alignment requirements of the storage.

Function xfs_atomic_write_logitems() is added to find the limit the number
of log items which can fit in a single transaction.

Amend the max atomic write computation to create a new transaction
reservation type, and compute the maximum size of an atomic write
completion (in fsblocks) based on this new transaction reservation.
Initially, tr_atomic_write is a clone of tr_itruncate, which provides a
reasonable level of parallelism.  In the next patch, we'll add a mount
option so that sysadmins can configure their own limits.

Signed-off-by: John Garry <john.g.garry@oracle.com>
[djwong: use a new reservation type for atomic write ioends, refactor
group limit calculations]
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
[jpg: update xfs_calc_perag_awu_max() ddev check]
---
 fs/xfs/libxfs/xfs_trans_resv.c | 94 ++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_trans_resv.h |  2 +
 fs/xfs/xfs_mount.c             | 81 +++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h             |  6 +++
 fs/xfs/xfs_reflink.c           | 16 ++++++
 fs/xfs/xfs_reflink.h           |  2 +
 fs/xfs/xfs_trace.h             | 60 ++++++++++++++++++++++
 7 files changed, 261 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 6c74f47f980a..708cfb4be661 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -22,6 +22,12 @@
 #include "xfs_rtbitmap.h"
 #include "xfs_attr_item.h"
 #include "xfs_log.h"
+#include "xfs_defer.h"
+#include "xfs_bmap_item.h"
+#include "xfs_extfree_item.h"
+#include "xfs_rmap_item.h"
+#include "xfs_refcount_item.h"
+#include "xfs_trace.h"
 
 #define _ALLOC	true
 #define _FREE	false
@@ -1397,3 +1403,91 @@ xfs_trans_resv_calc(
 	 */
 	xfs_calc_default_atomic_ioend_reservation(mp, resp);
 }
+
+/*
+ * Return the per-extent and fixed transaction reservation sizes needed to
+ * complete an atomic write.
+ */
+STATIC unsigned int
+xfs_calc_atomic_write_ioend_geometry(
+	struct xfs_mount	*mp,
+	unsigned int		*step_size)
+{
+	const unsigned int	efi = xfs_efi_log_space(1);
+	const unsigned int	efd = xfs_efd_log_space(1);
+	const unsigned int	rui = xfs_rui_log_space(1);
+	const unsigned int	rud = xfs_rud_log_space();
+	const unsigned int	cui = xfs_cui_log_space(1);
+	const unsigned int	cud = xfs_cud_log_space();
+	const unsigned int	bui = xfs_bui_log_space(1);
+	const unsigned int	bud = xfs_bud_log_space();
+
+	/*
+	 * Maximum overhead to complete an atomic write ioend in software:
+	 * remove data fork extent + remove cow fork extent + map extent into
+	 * data fork.
+	 *
+	 * tx0: Creates a BUI and a CUI and that's all it needs.
+	 *
+	 * tx1: Roll to finish the BUI.  Need space for the BUD, an RUI, and
+	 * enough space to relog the CUI (== CUI + CUD).
+	 *
+	 * tx2: Roll again to finish the RUI.  Need space for the RUD and space
+	 * to relog the CUI.
+	 *
+	 * tx3: Roll again, need space for the CUD and possibly a new EFI.
+	 *
+	 * tx4: Roll again, need space for an EFD.
+	 *
+	 * If the extent referenced by the pair of BUI/CUI items is not the one
+	 * being currently processed, then we need to reserve space to relog
+	 * both items.
+	 */
+	const unsigned int	tx0 = bui + cui;
+	const unsigned int	tx1 = bud + rui + cui + cud;
+	const unsigned int	tx2 = rud + cui + cud;
+	const unsigned int	tx3 = cud + efi;
+	const unsigned int	tx4 = efd;
+	const unsigned int	relog = bui + bud + cui + cud;
+
+	const unsigned int	per_intent = max(max3(tx0, tx1, tx2),
+						 max3(tx3, tx4, relog));
+
+	/* Overhead to finish one step of each intent item type */
+	const unsigned int	f1 = xfs_calc_finish_efi_reservation(mp, 1);
+	const unsigned int	f2 = xfs_calc_finish_rui_reservation(mp, 1);
+	const unsigned int	f3 = xfs_calc_finish_cui_reservation(mp, 1);
+	const unsigned int	f4 = xfs_calc_finish_bui_reservation(mp, 1);
+
+	/* We only finish one item per transaction in a chain */
+	*step_size = max(f4, max3(f1, f2, f3));
+
+	return per_intent;
+}
+
+/*
+ * Compute the maximum size (in fsblocks) of atomic writes that we can complete
+ * given the existing log reservations.
+ */
+xfs_extlen_t
+xfs_calc_max_atomic_write_fsblocks(
+	struct xfs_mount		*mp)
+{
+	const struct xfs_trans_res	*resv = &M_RES(mp)->tr_atomic_ioend;
+	unsigned int			per_intent = 0;
+	unsigned int			step_size = 0;
+	unsigned int			ret = 0;
+
+	if (resv->tr_logres > 0) {
+		per_intent = xfs_calc_atomic_write_ioend_geometry(mp,
+				&step_size);
+
+		if (resv->tr_logres >= step_size)
+			ret = (resv->tr_logres - step_size) / per_intent;
+	}
+
+	trace_xfs_calc_max_atomic_write_fsblocks(mp, per_intent, step_size,
+			resv->tr_logres, ret);
+
+	return ret;
+}
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index 670045d417a6..a6d303b83688 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -121,4 +121,6 @@ unsigned int xfs_calc_itruncate_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
 
+xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
+
 #endif	/* __XFS_TRANS_RESV_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index ee68c026e6cd..eb5ed61b6f99 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -666,6 +666,80 @@ xfs_agbtree_compute_maxlevels(
 	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
 }
 
+/* Maximum atomic write IO size that the kernel allows. */
+static inline xfs_extlen_t xfs_calc_atomic_write_max(struct xfs_mount *mp)
+{
+	return rounddown_pow_of_two(XFS_B_TO_FSB(mp, MAX_RW_COUNT));
+}
+
+static inline unsigned int max_pow_of_two_factor(const unsigned int nr)
+{
+	return 1 << (ffs(nr) - 1);
+}
+
+/*
+ * If the data device advertises atomic write support, limit the size of data
+ * device atomic writes to the greatest power-of-two factor of the AG size so
+ * that every atomic write unit aligns with the start of every AG.  This is
+ * required so that the per-AG allocations for an atomic write will always be
+ * aligned compatibly with the alignment requirements of the storage.
+ *
+ * If the data device doesn't advertise atomic writes, then there are no
+ * alignment restrictions and the largest out-of-place write we can do
+ * ourselves is the number of blocks that user files can allocate from any AG.
+ */
+static inline xfs_extlen_t xfs_calc_perag_awu_max(struct xfs_mount *mp)
+{
+	if (mp->m_dd_awu_hw_max)
+		return max_pow_of_two_factor(mp->m_sb.sb_agblocks);
+	return mp->m_ag_max_usable;
+}
+
+/*
+ * Reflink on the realtime device requires rtgroups, and atomic writes require
+ * reflink.
+ *
+ * If the realtime device advertises atomic write support, limit the size of
+ * data device atomic writes to the greatest power-of-two factor of the rtgroup
+ * size so that every atomic write unit aligns with the start of every rtgroup.
+ * This is required so that the per-rtgroup allocations for an atomic write
+ * will always be aligned compatibly with the alignment requirements of the
+ * storage.
+ *
+ * If the rt device doesn't advertise atomic writes, then there are no
+ * alignment restrictions and the largest out-of-place write we can do
+ * ourselves is the number of blocks that user files can allocate from any
+ * rtgroup.
+ */
+static inline xfs_extlen_t xfs_calc_rtgroup_awu_max(struct xfs_mount *mp)
+{
+	struct xfs_groups	*rgs = &mp->m_groups[XG_TYPE_RTG];
+
+	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev_awu_min > 0)
+		return max_pow_of_two_factor(rgs->blocks);
+	return rgs->blocks;
+}
+
+/* Compute the maximum atomic write unit size for each section. */
+static inline void
+xfs_calc_atomic_write_unit_max(
+	struct xfs_mount	*mp)
+{
+	struct xfs_groups	*ags = &mp->m_groups[XG_TYPE_AG];
+	struct xfs_groups	*rgs = &mp->m_groups[XG_TYPE_RTG];
+
+	const xfs_extlen_t	max_write = xfs_calc_atomic_write_max(mp);
+	const xfs_extlen_t	max_ioend = xfs_reflink_max_atomic_cow(mp);
+	const xfs_extlen_t	max_agsize = xfs_calc_perag_awu_max(mp);
+	const xfs_extlen_t	max_rgsize = xfs_calc_rtgroup_awu_max(mp);
+
+	ags->awu_max = min3(max_write, max_ioend, max_agsize);
+	rgs->awu_max = min3(max_write, max_ioend, max_rgsize);
+
+	trace_xfs_calc_atomic_write_unit_max(mp, max_write, max_ioend,
+			max_agsize, max_rgsize);
+}
+
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
 xfs_rtbtree_compute_maxlevels(
@@ -1096,6 +1170,13 @@ xfs_mountfs(
 	    mp->m_rtdev_targp->bt_bdev_awu_max >= mp->m_sb.sb_blocksize)
 		mp->m_rt_awu_hw_max = mp->m_rtdev_targp->bt_bdev_awu_max;
 
+	/*
+	 * Pre-calculate atomic write unit max.  This involves computations
+	 * derived from transaction reservations, so we must do this after the
+	 * log is fully initialized.
+	 */
+	xfs_calc_atomic_write_unit_max(mp);
+
 	return 0;
 
  out_agresv:
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 2819e160f0e9..ba55fa1d9594 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -119,6 +119,12 @@ struct xfs_groups {
 	 * SMR hard drives.
 	 */
 	xfs_fsblock_t		start_fsb;
+
+	/*
+	 * Maximum length of an atomic write for files stored in this
+	 * collection of allocation groups, in fsblocks.
+	 */
+	xfs_extlen_t		awu_max;
 };
 
 struct xfs_freecounter {
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 218dee76768b..8c47af705f79 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1040,6 +1040,22 @@ xfs_reflink_end_atomic_cow(
 	return error;
 }
 
+/* Compute the largest atomic write that we can complete through software. */
+xfs_extlen_t
+xfs_reflink_max_atomic_cow(
+	struct xfs_mount	*mp)
+{
+	/* We cannot do any atomic writes without out of place writes. */
+	if (!xfs_has_reflink(mp))
+		return 0;
+
+	/*
+	 * Atomic write limits must always be a power-of-2, according to
+	 * generic_atomic_write_valid.
+	 */
+	return rounddown_pow_of_two(xfs_calc_max_atomic_write_fsblocks(mp));
+}
+
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
  * metadata.  The ondisk metadata does not track which inode created the
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 412e9b6f2082..36cda724da89 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -68,4 +68,6 @@ extern int xfs_reflink_update_dest(struct xfs_inode *dest, xfs_off_t newlen,
 
 bool xfs_reflink_supports_rextsize(struct xfs_mount *mp, unsigned int rextsize);
 
+xfs_extlen_t xfs_reflink_max_atomic_cow(struct xfs_mount *mp);
+
 #endif /* __XFS_REFLINK_H */
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 9554578c6da4..d5ae00f8e04c 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -170,6 +170,66 @@ DEFINE_ATTR_LIST_EVENT(xfs_attr_list_notfound);
 DEFINE_ATTR_LIST_EVENT(xfs_attr_leaf_list);
 DEFINE_ATTR_LIST_EVENT(xfs_attr_node_list);
 
+TRACE_EVENT(xfs_calc_atomic_write_unit_max,
+	TP_PROTO(struct xfs_mount *mp, unsigned int max_write,
+		 unsigned int max_ioend, unsigned int max_agsize,
+		 unsigned int max_rgsize),
+	TP_ARGS(mp, max_write, max_ioend, max_agsize, max_rgsize),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, max_write)
+		__field(unsigned int, max_ioend)
+		__field(unsigned int, max_agsize)
+		__field(unsigned int, max_rgsize)
+		__field(unsigned int, data_awu_max)
+		__field(unsigned int, rt_awu_max)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->max_write = max_write;
+		__entry->max_ioend = max_ioend;
+		__entry->max_agsize = max_agsize;
+		__entry->max_rgsize = max_rgsize;
+		__entry->data_awu_max = mp->m_groups[XG_TYPE_AG].awu_max;
+		__entry->rt_awu_max = mp->m_groups[XG_TYPE_RTG].awu_max;
+	),
+	TP_printk("dev %d:%d max_write %u max_ioend %u max_agsize %u max_rgsize %u data_awu_max %u rt_awu_max %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->max_write,
+		  __entry->max_ioend,
+		  __entry->max_agsize,
+		  __entry->max_rgsize,
+		  __entry->data_awu_max,
+		  __entry->rt_awu_max)
+);
+
+TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
+	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
+		 unsigned int step_size, unsigned int logres,
+		 unsigned int blockcount),
+	TP_ARGS(mp, per_intent, step_size, logres, blockcount),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, per_intent)
+		__field(unsigned int, step_size)
+		__field(unsigned int, logres)
+		__field(unsigned int, blockcount)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->per_intent = per_intent;
+		__entry->step_size = step_size;
+		__entry->logres = logres;
+		__entry->blockcount = blockcount;
+	),
+	TP_printk("dev %d:%d per_intent %u step_size %u logres %u blockcount %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->per_intent,
+		  __entry->step_size,
+		  __entry->logres,
+		  __entry->blockcount)
+);
+
 TRACE_EVENT(xlog_intent_recovery_failed,
 	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
 		 int error),
-- 
2.31.1


