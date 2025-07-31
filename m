Return-Path: <linux-fsdevel+bounces-56414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D89B172AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 16:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E9F5665B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667282C3276;
	Thu, 31 Jul 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LNlZ5z1m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qytLjVq7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1161EB39;
	Thu, 31 Jul 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970518; cv=fail; b=Un4Gz5wrllbUE7LjS3dNIjmC4vBD+Vrpd1h0Ky4z1dpH2rXgrj3II2A5cjJCUyJCu+rqr2tLDE89vdUC1I0gAaC+kVJ4fxBvf5H2jIJFe8ba1OwZnNfXj9ObiH6AQbI6HitnEkTmS5HslXb5XW9r1C5dqp82X6ooK4+wzRjjmRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970518; c=relaxed/simple;
	bh=uZ7OggGIRcXMrTRE65SFkjLtpOMqRSTcRftb9JxoyA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=acEknNJ0lcYpjKUa8FKCDddpRWYAN+wgLPNzWR5HSFzgsciK4ZphA6h5ME5ATg0XFsKfHjGgI82mV/xW3lbkpKIwg5P1W7yii0yAPhWXbCrWbbFk9NzFJs1BQu1s8C/ctNg7E5i++leKHMcOrc6vSIpfHYJCPlFfEBExenutTGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LNlZ5z1m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qytLjVq7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VDj30b020537;
	Thu, 31 Jul 2025 14:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aTZj1DvoCjPlm+hCJ+
	OtUj13aplJfwzrhOodI7sfD+o=; b=LNlZ5z1mXE1AqOgb0v1PWo3qJGR1+uaoFQ
	uZALYUWQBUULESWftl9hFoaBAw5ziAYaosfHEM5QXKDfnZkF62srqty+LIBsP8L+
	cxVSqxv+4nNb+k/nPyXMXf3yzPZDf6llfbVkVbVWJF33wTj7YcVeuC4pOPQntDbC
	F0y4PHjmzc7+S000obYFq968Bx7MYtYzb8tU+GyMdTR0Yh3z/LNu8v5LhdKUQbam
	caNcPM5cPvP+A41pIKA+YJVyDSEAgnOnlIsH1fffJYbq54gEO4j+x2wMBQlcLzTW
	eIdeWGFYUl6VKS1FVyVux/wx8m/6SQdL3s+yjAS5wO95NFexAVXg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5x418e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 14:00:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VD52IH016906;
	Thu, 31 Jul 2025 14:00:31 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011035.outbound.protection.outlook.com [52.101.57.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfjuwkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 14:00:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDrf43BaACcSgZwGBUyOrgBbQlgn6AKnmsbGEgbiM5I4fDERZHDqBpajOG9kb8mMsDXRDQv4B3y6HTzsdp+W/DTMnL49vNOVL0cjttYmLbYj9ngEh3RPP/ePcmORtYPgdWg+dS0cWlL3IvgD8pMRt7SfNkNNHwpATXI3jJpIcGR+cnbKyVi1FodvjQKvXnDQgF2T29Fa3+DuO/zkClht/PhD42hvZ4YLgwBqIqAX08MaWubPTgRiGRGRaiAowyqWDYK1cQuf8DDA0zUTBISreNVofSZaW+eF0pWPHoZeLANY6tRByV2lU1odX/NhZkw5xZWRG8Vy+bBRJ/lfw6UM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTZj1DvoCjPlm+hCJ+OtUj13aplJfwzrhOodI7sfD+o=;
 b=QxPvwzeZYsKLWtxw37I0cjNdKAttxi7xUHuunWY+uItg+XZJtZ8Mi2aR9isWytbTNlv9ortcdhqcLzA/uKDKP3zxc4HqMZUZyi9brCkpcWr277ZutTJ5AzYE0TgGP4Tfg4VmVHVhFgluUpd43huwKCBe4uNkIVVfMqzYn/1KcD5BtGuam8e1/K6c46A97bQH+bXS4DTrDZvPOMxNoeLjsIfELx6DnEpsK2WiCFxHfS1QUpREMrvP391w8Qj9du5ayofjt9zq/btq4rfhD+aba0/4ogVC4Xb8DQnM6MRR7joufn2pPEBRB5fHSOuaazmCNOgPE1hqkNR9sDEQpTJDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTZj1DvoCjPlm+hCJ+OtUj13aplJfwzrhOodI7sfD+o=;
 b=qytLjVq7w6j/zLHLsxqMQJTJHB/sRTQtgG4930gOtmlYSUslznDCkEts8kdLoDya22sBS7mGTei7eQHcH3vQfWEcmANigC9IbwCC8077PqXP+q1pUZHITMfQs+FUPZ+KefAxdlYC6GAqCyOho3x2ym6VOXcTjbopeNysGvB/qmc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6882.namprd10.prod.outlook.com (2603:10b6:610:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Thu, 31 Jul
 2025 14:00:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 14:00:20 +0000
Date: Thu, 31 Jul 2025 15:00:17 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
        riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
        dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v2 2/5] mm/huge_memory: convert "tva_flags" to "enum
 tva_type" for thp_vma_allowable_order*()
Message-ID: <c44cb864-3b36-4aa2-8040-60c97bfdc28e@lucifer.local>
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-3-usamaarif642@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731122825.2102184-3-usamaarif642@gmail.com>
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: b4bc7a85-064f-4d28-e44e-08ddd03a9655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6gmsS1tMzIcya9nGsa7rZkKdx+yaMR6PMBN0cBvSNJ+8yuhOtlD3J2UK91JI?=
 =?us-ascii?Q?OXc9L0Fpr1GRF+bldmlF2AHfc7R9RKDKHsEqa5qmGi6tKvPzXzUwiRgPLVDS?=
 =?us-ascii?Q?AvxkR8EYE3lgtPHrq7HX1Xg93VZxVgVRf/j+gQ+BvgGMNPMg6G8N51iYteNh?=
 =?us-ascii?Q?O7ou7GNhSnH7ClMxDE9ulHeBQSILx77JiOqaFXmQ1PU850okX5UVZBmh3Ceh?=
 =?us-ascii?Q?1rCJSFLqbRc2W4fXirvAhyLvjjbgvIPhJAQmQReEmXrS7Vc+8F7ssb33TWLI?=
 =?us-ascii?Q?hGt7vG7LsRDax98TWXD6yZIPCRchQpBBs78CfKztv7X2w6wFHgQWE+TEaKwI?=
 =?us-ascii?Q?V5mucePXaTK5wV1tf+KpxXaIeAE8I7UoMPsJZ7DoISJNm4ov6iH2gioXitf2?=
 =?us-ascii?Q?klj8B31h1HHGbnvrm4cE6s2WzlPjBRfXIOgAHWXnKz8RuI3tMgVTNamEdb1B?=
 =?us-ascii?Q?pBVHH+Hda+gWgEd0zRY7c0d3l1OAS8qGGuYV6ImqPBvw3fIy/6E00oIy6TOG?=
 =?us-ascii?Q?qEtttJu/r+Oncmm0Zx4c61aVoAipW9IUU5egIl+dkgCnKUzISzC2qs9TGwTX?=
 =?us-ascii?Q?xkF8iFaEA4COoRYSyycJ/z0Pjo7IrMEJ3WW4eU9Ik0NbqFdnZ8PjRD5Cca3g?=
 =?us-ascii?Q?O8+9U98Lew3N++JSAkSyf9waiKUfvUjVUcvR3kZCvtR7bRUlvUDgnV3lxEBG?=
 =?us-ascii?Q?6+dRV/hUvenLbMI/iVyJt981vIH76RA2S10Jr/N/rwQAtv+6qYKJCmZ5yXYh?=
 =?us-ascii?Q?BqBtXgWY/13+u8HgqijrfUreK4TaUHfAYoyUpgqSbNzGWEc2kTmxTVNxQL/2?=
 =?us-ascii?Q?QPHQb+xp/GpMZiXcKdc2faBp9r+5rflqASBt1gZJRP9JltiY27Z9cgBdHhRv?=
 =?us-ascii?Q?N3AYUTMUsxIq+kpstgnObvgpCRxVnmbTgFeoi7n5jJhrJAYFnOkaUOd351gk?=
 =?us-ascii?Q?fbT4dz0pgOl3LZbxx00FptcKJzS/lUBm3n+WXgMryB16zYbJ42gWWp8M0r+h?=
 =?us-ascii?Q?sLKz9loTelLpmBxNB6GEjHzXEX3xqo0gjb2MRVZKyDx2DrmOEwUEkn5+lMZ/?=
 =?us-ascii?Q?hN+I5H8kycJcDWC80ZpxYXq+lKB419PR3ZWEroVpAVgY/oScDJwgc3MMSaiB?=
 =?us-ascii?Q?IVjdXxLhec5CxActhRsF8HQGpZr9wKt8uSNfRkn7UAnrxmpXrIEbVrVup2hv?=
 =?us-ascii?Q?y6xWBn+B4PMdRQTdc1RW+SNEW8RPv8t53m+KV5LdwASvL9/60nwzjSkwlZnq?=
 =?us-ascii?Q?2EwhQmJyL60bpoiPvexeX7JFoxWuTYzL2snHGLe/nHKoXnAp1Ghvvv5bGNNc?=
 =?us-ascii?Q?rT6m7ms3lTBPKSR9hbA1cnzBfc7JMsE4l4UaYNGAUlExLdr720k4lFWlpFGN?=
 =?us-ascii?Q?SUguVFnfHg9kPoBQWjR6BnIGULsWK4liQL7Y6u7jQ2E2ywt2BUyuRU+w2WG5?=
 =?us-ascii?Q?KWbkMZbAo9E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZWnMvsvIdNpFu4kuaeFgVsuFhFHQxaReEnu7qiiyD5g3+ebdl5+OoXmxSZPZ?=
 =?us-ascii?Q?8Lb1I/KfCqtqWye71UmjL/RGOxKwfgcKAZOBpWojjvMUAN6Z0LvCRcN2MJcY?=
 =?us-ascii?Q?9/VgpRs8GOFJGJf8sf5jSdHXJpz0iU/ZV7bWrOB7MSCxG5q937zu19tX4aKr?=
 =?us-ascii?Q?OlPXpgaSJ62Z0/7g0NkfJIQY5Jg7cy9P2hLe8xsDN9TZiscoTuklZ8u6g1ww?=
 =?us-ascii?Q?rhVhm9BcCSiSukpnblYzGRkRbSqZmBpCN2q4O+Fh8OYeeJLB3FDbP1/0yz5y?=
 =?us-ascii?Q?RDFcbjF8bbaVN9AtcvPO7nr7KqlYSug39iyY8WNO6YvNUmugNG8NEMzwZjCV?=
 =?us-ascii?Q?bvM4JEz9eIBZRhe6zVjshrCP3b85oW0bk4u6m1hKIFT/hCuY6BfoNYxpkdK4?=
 =?us-ascii?Q?aHn5fq6AyuCWrIvm27w7cB7kVvZ7/vmuiejwvZZKaK/OHS+2IWpRYcrN9kv/?=
 =?us-ascii?Q?ZE/DK7dBRqGcJO85deMHGmHI8exc3XgtqbY2usAUfnc4isGKh5Nso5tml//3?=
 =?us-ascii?Q?3nxg5TuOaSxKDWkRcxJSTp5HA8e203pHN8oW8tv9NL+r93FqY09pAWI/DM/1?=
 =?us-ascii?Q?pdmkCnfceuCWhYA1E6TCMRzoOh5bUTJIAu4gH1sq1D/OToEC+d31fOnGh0Uj?=
 =?us-ascii?Q?0GMDf2jf7iwhm65Q5MAOgvI2WSplzGpHJEAAHE5JRwMWgMXKrddVn0h6pO8c?=
 =?us-ascii?Q?1JJK+a2BfGrspdUX0MJw7aZlWZb+1eroWTrWVxJ+V8vmiSkLj/reXzNh1Sc3?=
 =?us-ascii?Q?bi09/K1/fi5gzstbjA8MWr4axZ+lg22TB2+TpNT40u8k/EedqReVhcwYRfi7?=
 =?us-ascii?Q?fw6/q6viYmwvC7uitMegZoiKJWaXYncX48KKW/QighVos/kxPENVjLqPdcTl?=
 =?us-ascii?Q?mwvEiAQ+EKzAGOXxMroEjlVPd6NYPf1FFH+xdxZtQm8uMo3IVTXAEtU026RM?=
 =?us-ascii?Q?FXonwAOGhwVN7clNnwiPZwne+cDGI890c5nBIiDVULQ7qqkPHVzR4RUz89Zs?=
 =?us-ascii?Q?QqQUw5nMImsW2XSFZwJ/24zAabzaWqzry0iKIzlG/FoGr5x/P1vNWzQWeK2O?=
 =?us-ascii?Q?4TMby1KEpLe5RjO+/EL1qGZ4nzmXEhph9GbP2tHedxt7NvrZWe/DcCDtNhTQ?=
 =?us-ascii?Q?O5bl+L+kVlVPcTsdS3h/KNruDQRi40omGFZCI/U894JnuPqchnR+z25X2yMx?=
 =?us-ascii?Q?fq3MYAjujQXzVBQRsPx1cnJIB+6S1pAn3RCmt8G4zQSd+kArZjhW/vOIrISw?=
 =?us-ascii?Q?DsgWmlHQM1UkV4V6pu2YHV6cOmG3WMEeAbvN1xeYols6nrvi59W4xoEgeDgv?=
 =?us-ascii?Q?9iqoLsbu+StAt6pN2JIyXT+j6r+2Uem4E2FF7P41MzysuqTqS9/QwybBodQP?=
 =?us-ascii?Q?Sq/UQrPSRphBWDuYQiPiQ5De29MZKkMG4/kJC94oSxS7X0b0zZrBtAqOre3n?=
 =?us-ascii?Q?/7MHwRGfA9uCEw23FnjVGLqPs5xqoTvcGOoaeCwg5WWkstyZ6Bj1Bmq0HVXr?=
 =?us-ascii?Q?MusJkmdKRDjhsF/d7I6HvHoCFE4prPX0TpSufXtfS+D+kp+6v7aXAEU/Z1/i?=
 =?us-ascii?Q?RxdlQEwRi1eAEvxl+h9MLTZKLHk2qZzwg2TFWnG6rnnhYHIalfbg2CffxDjA?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ENd0/02jtVXZJWzv6pFV+q7FUeUOBKw5eh8XUEi+XAGMJjlYAug9COF48UpXdqj5yMoZ4dioLWncAKB14+hIRuECwyRgjcwXeySfdXDmNp9tbTNxq18j4PnHHvDw5bzZrvfbEEIKsUpI6c/ppYenNIp9c0Qd8hYbyC547B5Pj7B8xUPFaVxvIPbV2CF8KYeJcjyzrvzAPm3GjOrhxACy7/FAxNvtfauyT2dDGRJTuglSG7AdnlH5iy9SV4peOWTe7WET7uiQJKQkgqiF08h2Lvr0cMVTMErraFr7W//Ttiqi4leUtLBRHJRTe5/kxeASpMebu/v4pfcgp6kUTxbuhbO0JwvsLj5HD9zbkCBHvujM8zqQz2A3Gt8k5ss8OuwroA3cmhbzTCSdUIFF0lcMah+uKkzgm0uJxuav8DXRZfDKdTcdRcml1wVSsdf7QojfvMYiSNRxEfwOogxCiwi7pug53EwFxMhK0tRubWUXVDLeVsU6pUICWhSK/fK0NbGp6ACGAKoZRTdnTp/EzI88Wr8ssb/iwNQVQCKP178WoBjG14izZg33pHsxcV5gQoi3lD7w1PlhgeIroe3wbyicBFX5g69Z6UlApt36yxs+tkA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bc7a85-064f-4d28-e44e-08ddd03a9655
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 14:00:20.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WqQfx/vltyD09Yo9QrK17PIg6eF+CAXbXoIdr+cacHkawnr63qcsTaQzg+62OywBocR542xaXGRjIXcf63PLvhSxzxYz91o/1iYzIAdRB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310097
X-Authority-Analysis: v=2.4 cv=X+lSKHTe c=1 sm=1 tr=0 ts=688b7701 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=Zq2wxHQyVX6x2_3kT-8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: 9xVtJWdPYq8bAkjkGCagnRlw3uoeYFJI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA5NiBTYWx0ZWRfX6qMA52waj6kc
 JxObga/HLkupFhYehlrFLGrU+gPOVua+lrmLhHi/WISk67a21YXOa2VCz/Py8yJWSpqvv3Mc+r8
 qsVxzK51XAZGQqP4GtiIpcoWrX5UIFgx7gUhRXKOfKbqjieSkvRttqHAxtI+uvPPRJY5EYzW+HL
 pz9STKf6EDRwnkzG/F9g0hOcbLmviVyyfWjra04qIW5XV6CH33YWz7i54JXkn+auMh7lNVei6RM
 kVo9YfcvGh8+5nhoqBWgb86oRroEZz3onjtVWaaK+JphIlNzdFVnt1EREZx3MMA24I/rPZKoxMk
 byF7Pbg4FAq2EmYhvVRF0UWKpoJ1d7Jgha9Sdop8W/7galPzt95y6QWrVt6QrIHuyTRjLLDyUXj
 P63FvcZYFnhdf6IeT1WkS9XBAGbGpgMTqrKhtpNU051Lpondf56IulPEH0Ha+zdwhaoueHLI
X-Proofpoint-ORIG-GUID: 9xVtJWdPYq8bAkjkGCagnRlw3uoeYFJI

On Thu, Jul 31, 2025 at 01:27:19PM +0100, Usama Arif wrote:
> From: David Hildenbrand <david@redhat.com>
>
> Describing the context through a type is much clearer, and good enough
> for our case.

This is pretty bare bones. What context, what type? Under what
circumstances?

This also is missing detail on the key difference here - that actually it
turns out we _don't_ need these to be flags, rather we can have _distinct_
modes which are clearer.

I'd say something like:

	when determining which THP orders are eligiible for a VMA mapping,
	we have previously specified tva_flags, however it turns out it is
	really not necessary to treat these as flags.

	Rather, we distinguish between distinct modes.

	The only case where we previously combined flags was with
	TVA_ENFORCE_SYSFS, but we can avoid this by observing that this is
	the default, except for MADV_COLLAPSE or an edge cases in
	collapse_pte_mapped_thp() and hugepage_vma_revalidate(), and adding
	a mode specifically for this case - TVA_FORCED_COLLAPSE.

	... stuff about the different modes...

>
> We have:
> * smaps handling for showing "THPeligible"
> * Pagefault handling
> * khugepaged handling
> * Forced collapse handling: primarily MADV_COLLAPSE, but one other odd case

Can we actually state what this case is? I mean I guess a handwave in the
form of 'an edge case in collapse_pte_mapped_thp()' will do also.

Hmm actually we do weird stuff with this so maybe just handwave.

Like uprobes calls collapse_pte_mapped_thp()... :/ I'm not sure this 'If we
are here, we've succeeded in replacing all the native pages in the page
cache with a single hugepage.' comment is even correct.

Anyway yeah, hand wave I guess...

>
> Really, we want to ignore sysfs only when we are forcing a collapse
> through MADV_COLLAPSE, otherwise we want to enforce.

I'd say 'ignoring this edge case, ...'

I think the clearest thing might be to literally list the before/after
like:

* TVA_SMAPS | TVA_ENFORCE_SYSFS -> TVA_SMAPS
* TVA_IN_PF | TVA_ENFORCE_SYSFS -> TVA_PAGEFAULT
* TVA_ENFORCE_SYSFS             -> TVA_KHUGEPAGED
* 0                             -> TVA_FORCED_COLLAPSE

>
> With this change, we immediately know if we are in the forced collapse
> case, which will be valuable next.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Overall this is a great cleanup, some various nits however.

> ---
>  fs/proc/task_mmu.c      |  4 ++--
>  include/linux/huge_mm.h | 30 ++++++++++++++++++------------
>  mm/huge_memory.c        |  8 ++++----
>  mm/khugepaged.c         | 18 +++++++++---------
>  mm/memory.c             | 14 ++++++--------
>  5 files changed, 39 insertions(+), 35 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 3d6d8a9f13fc..d440df7b3d59 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1293,8 +1293,8 @@ static int show_smap(struct seq_file *m, void *v)
>  	__show_smap(m, &mss, false);
>
>  	seq_printf(m, "THPeligible:    %8u\n",
> -		   !!thp_vma_allowable_orders(vma, vma->vm_flags,
> -			   TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
> +		   !!thp_vma_allowable_orders(vma, vma->vm_flags, TVA_SMAPS,
> +					      THP_ORDERS_ALL));

This !! is so gross, wonder if we could have a bool wrapper. But not a big
deal.

I also sort of _hate_ the smaps flag anyway, invoking this 'allowable
orders' thing just for smaps reporting with maybe some minor delta is just
odd.

Something like `bool vma_has_thp_allowed_orders(struct vm_area_struct
*vma);` would be nicer.

Anyway thoughts for another time... :)

>
>  	if (arch_pkeys_enabled())
>  		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 71db243a002e..b0ff54eee81c 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -94,12 +94,15 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
>  #define THP_ORDERS_ALL	\
>  	(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_SPECIAL | THP_ORDERS_ALL_FILE_DEFAULT)
>
> -#define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */

Dumb question, but what does 'TVA' stand for? :P

> -#define TVA_IN_PF		(1 << 1)	/* Page fault handler */
> -#define TVA_ENFORCE_SYSFS	(1 << 2)	/* Obey sysfs configuration */
> +enum tva_type {
> +	TVA_SMAPS,		/* Exposing "THPeligible:" in smaps. */

How I hate this flag (just an observation...)

> +	TVA_PAGEFAULT,		/* Serving a page fault. */
> +	TVA_KHUGEPAGED,		/* Khugepaged collapse. */

This is equivalent to the TVA_ENFORCE_SYSFS case before, sort of a default
I guess, but actually quite nice to add the context that it's sourced from
khugepaged - I assume this will always be the case when specified?

> +	TVA_FORCED_COLLAPSE,	/* Forced collapse (i.e., MADV_COLLAPSE). */

Would put 'e.g.' here, then that allows 'space' for the edge case...

> +};
>
> -#define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
> -	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
> +#define thp_vma_allowable_order(vma, vm_flags, type, order) \
> +	(!!thp_vma_allowable_orders(vma, vm_flags, type, BIT(order)))

Nit, but maybe worth keeping tva_ prefix - tva_type - here just so it's
clear what type it refers to.

But not end of the world.

Same comment goes for param names below etc.

>
>  #define split_folio(f) split_folio_to_list(f, NULL)
>
> @@ -264,14 +267,14 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
>
>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					 vm_flags_t vm_flags,
> -					 unsigned long tva_flags,
> +					 enum tva_type type,
>  					 unsigned long orders);
>
>  /**
>   * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
>   * @vma:  the vm area to check
>   * @vm_flags: use these vm_flags instead of vma->vm_flags
> - * @tva_flags: Which TVA flags to honour
> + * @type: TVA type
>   * @orders: bitfield of all orders to consider
>   *
>   * Calculates the intersection of the requested hugepage orders and the allowed
> @@ -285,11 +288,14 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  static inline
>  unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  				       vm_flags_t vm_flags,
> -				       unsigned long tva_flags,
> +				       enum tva_type type,
>  				       unsigned long orders)
>  {
> -	/* Optimization to check if required orders are enabled early. */
> -	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
> +	/*
> +	 * Optimization to check if required orders are enabled early. Only
> +	 * forced collapse ignores sysfs configs.
> +	 */
> +	if (type != TVA_FORCED_COLLAPSE && vma_is_anonymous(vma)) {
>  		unsigned long mask = READ_ONCE(huge_anon_orders_always);
>
>  		if (vm_flags & VM_HUGEPAGE)
> @@ -303,7 +309,7 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  			return 0;
>  	}
>
> -	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
> +	return __thp_vma_allowable_orders(vma, vm_flags, type, orders);
>  }
>
>  struct thpsize {
> @@ -536,7 +542,7 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
>
>  static inline unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					vm_flags_t vm_flags,
> -					unsigned long tva_flags,
> +					enum tva_type type,
>  					unsigned long orders)
>  {
>  	return 0;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2b4ea5a2ce7d..85252b468f80 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -99,12 +99,12 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
>
>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					 vm_flags_t vm_flags,
> -					 unsigned long tva_flags,
> +					 enum tva_type type,
>  					 unsigned long orders)
>  {
> -	bool smaps = tva_flags & TVA_SMAPS;
> -	bool in_pf = tva_flags & TVA_IN_PF;
> -	bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
> +	const bool smaps = type == TVA_SMAPS;
> +	const bool in_pf = type == TVA_PAGEFAULT;
> +	const bool enforce_sysfs = type != TVA_FORCED_COLLAPSE;

Some cheeky const-ifying, I like it :)

>  	unsigned long supported_orders;
>
>  	/* Check the intersection of requested and supported orders. */
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2c9008246785..7a54b6f2a346 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -474,8 +474,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>  {
>  	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
>  	    hugepage_pmd_enabled()) {
> -		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
> -					    PMD_ORDER))
> +		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
>  			__khugepaged_enter(vma->vm_mm);
>  	}
>  }
> @@ -921,7 +920,8 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  				   struct collapse_control *cc)
>  {
>  	struct vm_area_struct *vma;
> -	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
> +	enum tva_type tva_type = cc->is_khugepaged ? TVA_KHUGEPAGED :
> +				 TVA_FORCED_COLLAPSE;

This is great, this is so much clearer.

A nit though, I mean I come back to my 'type' vs 'tva_type' nit above, this
is inconsistent, so we should choose one approach and stick with it.

>
>  	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
>  		return SCAN_ANY_PROCESS;
> @@ -932,7 +932,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>
>  	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
>  		return SCAN_ADDRESS_RANGE;
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, PMD_ORDER))
> +	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_type, PMD_ORDER))
>  		return SCAN_VMA_CHECK;
>  	/*
>  	 * Anon VMA expected, the address may be unmapped then
> @@ -1532,9 +1532,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>  	 * in the page cache with a single hugepage. If a mm were to fault-in
>  	 * this memory (mapped by a suitably aligned VMA), we'd get the hugepage
>  	 * and map it by a PMD, regardless of sysfs THP settings. As such, let's
> -	 * analogously elide sysfs THP settings here.
> +	 * analogously elide sysfs THP settings here and pretend we are
> +	 * collapsing.

I think saying pretending here is potentially confusing, maybe worth saying
'force collapse'?

>  	 */
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER))
> +	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
>  		return SCAN_VMA_CHECK;

Again, fantastically clearer.

>
>  	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
> @@ -2431,8 +2432,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  			progress++;
>  			break;
>  		}
> -		if (!thp_vma_allowable_order(vma, vma->vm_flags,
> -					TVA_ENFORCE_SYSFS, PMD_ORDER)) {
> +		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
>  skip:
>  			progress++;
>  			continue;
> @@ -2766,7 +2766,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  	BUG_ON(vma->vm_start > start);
>  	BUG_ON(vma->vm_end < end);
>
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER))
> +	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
>  		return -EINVAL;
>
>  	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
> diff --git a/mm/memory.c b/mm/memory.c
> index 92fd18a5d8d1..be761753f240 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4369,8 +4369,8 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
>  	 * and suitable for swapping THP.
>  	 */
> -	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
> -			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
> +	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
> +					  BIT(PMD_ORDER) - 1);
>  	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>  	orders = thp_swap_suitable_orders(swp_offset(entry),
>  					  vmf->address, orders);
> @@ -4917,8 +4917,8 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  	 * for this vma. Then filter out the orders that can't be allocated over
>  	 * the faulting address and still be fully contained in the vma.
>  	 */
> -	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
> -			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
> +	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
> +					  BIT(PMD_ORDER) - 1);
>  	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>
>  	if (!orders)
> @@ -6108,8 +6108,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  		return VM_FAULT_OOM;
>  retry_pud:
>  	if (pud_none(*vmf.pud) &&
> -	    thp_vma_allowable_order(vma, vm_flags,
> -				TVA_IN_PF | TVA_ENFORCE_SYSFS, PUD_ORDER)) {
> +	    thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PUD_ORDER)) {
>  		ret = create_huge_pud(&vmf);
>  		if (!(ret & VM_FAULT_FALLBACK))
>  			return ret;
> @@ -6143,8 +6142,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  		goto retry_pud;
>
>  	if (pmd_none(*vmf.pmd) &&
> -	    thp_vma_allowable_order(vma, vm_flags,
> -				TVA_IN_PF | TVA_ENFORCE_SYSFS, PMD_ORDER)) {
> +	    thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PMD_ORDER)) {
>  		ret = create_huge_pmd(&vmf);
>  		if (!(ret & VM_FAULT_FALLBACK))
>  			return ret;
> --
> 2.47.3
>

