Return-Path: <linux-fsdevel+bounces-75280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJs7EWlqc2mivQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:32:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC3975D9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D30783070FA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D320326ED35;
	Fri, 23 Jan 2026 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MwCJO5DV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qhDprTxD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4A1E231E;
	Fri, 23 Jan 2026 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171461; cv=fail; b=dg7tsR/baueR0kKgTdFzzOcepEoN8zBqnfcwK5fkX7dHBce5v4neJHgfm90dF16AOsWtNJAbDz32aFKOMUoUdw3ZpHwQnTnezpyvo/x2FHb3KZY++Lch6fGnavA7Uw8dO5T9cJpRjsFshmG9WLRSZxqUqY1eJe0+86RxDN/WMBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171461; c=relaxed/simple;
	bh=Yh+Gt/exTlcrMeR11Ka9yOtaRoekTOm8TTx5FzzeQtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ID2VMW5T60M3oga47GGFuL5ryUpmN2105RKC2YdHsJ0CVoSFE3o6d03sjjF3/25SRMGd0XP7UgaueR25PpUbCKYVD9EQSjStV040Pi4pfoXwT4AP+WRc+POO9t/8/sXiw+NS6FR1Sp9A0Af8M2iTa+QKH+nAJ2uVmE+RkYOSKEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MwCJO5DV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qhDprTxD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N6wPGB1884207;
	Fri, 23 Jan 2026 12:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4HWfSkUgV4sCJsvWyG
	/M10VInLWEAYZ0NVGllTuy5tw=; b=MwCJO5DVDoEwuu8FEw2/3LKWxatGxfx8jG
	feG1dh4IWwV1/34nZe678UZJWMjPmrYg0YeN/htLoh8u5do2x3RaVsWtSq3wGZpz
	4/KBWywolZgeBCgS49VjJza//lXZ403Qi4KdAKR3571JI2Ykr3+NaR7xlKbhKkyw
	QbC6mr+1Ze1gk6WsCT4UXtaFnnXQU4e1M3Ef8+oth8kmTl+uCpRVkvqVY02etwoE
	Yw3Dqk1FQKJpUxlumBHgMtQY3fxv+e10njtofUBb8972MAoSYFUwv2q8IKgtemtq
	QXi4f6jZkfPt0PGbU4akRM7/U7C/ISfJSRNc/CeCTlJaoS3FRXGQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8j9xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 12:30:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NBE0ZI022766;
	Fri, 23 Jan 2026 12:30:43 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vj2nc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 12:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwZd50AdBRGU2bx2V71PotDMz9FdsX/Ehds7Vt6C0x6geSDEFlyjw7w9CU5aPUdfXxfFnLpZh7icnJgnRH5BP9JTwYqvJSUDcg46eZgKSg0n5c7pBsNfqIYNjrD80hSuw+NeS94izFepJRAV5OiofltXVt0bBj941FK0AYWsP0PKPg/PXrQ940oRdNxNbBLk5FXbBLm3rD3ec9tGnHpj/1sqjbPWmZabBsxKIXjqU0d9IVwLQj8TmNugYt9p2Dtq12mACIw4WFlf4GkwoA3EYVgmM2B677qzyra/rXEUiM+EIsyEm1bkJqysoRZgpixmeEIL/dsK4HAI1YEuA3iq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HWfSkUgV4sCJsvWyG/M10VInLWEAYZ0NVGllTuy5tw=;
 b=g8J7Jcw0e/udpNmr21D4p6sqQaCmInJYH+D159M5h4Ll+e2L7pv15cO4s/hP2R0owOHx0pySx41F76At9+JisQRIBrlDBTirNC0aT+IqzdI+2S8SaIHF76H601whePRDQgDphDYCdHINjNooaOyAsTECr5WBCUS3DiXWCJkd7yZtkxRMbhJ1ciHBnl/gTTn+5aB6ewF41XaXKE4jTU1H1qccD9YMdLBLGDA40+bzA9EQx69NjZ4qxi4DdS6LZhOCiRhCYmR5mKoWwbDTLqwq66UovUHEvlw63fw/vSNlwW44cbEMHAhsP44ViC+EPgpx+UjNTUJuzv/p7rgn4sOn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HWfSkUgV4sCJsvWyG/M10VInLWEAYZ0NVGllTuy5tw=;
 b=qhDprTxD2y5UJKW1MtEGJI6TUu7BsNUnJbXYBP+/DyddJhwafGJtuO5i30vHzF22mqIPNev1GPGfN3f+QzZhOCS645R/idQ0g0FicQsrU/Vg1NcNYuHbxa/vn9FusekBnXMrZiMrQKYXTyqFFL1aqtSEnhXTVWLUIqMesDGmqyg=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CO1PR10MB4786.namprd10.prod.outlook.com (2603:10b6:303:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 12:30:40 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 12:30:38 +0000
Date: Fri, 23 Jan 2026 12:30:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, ntfs3@lists.linux.dev, devel@lists.orangefs.org,
        linux-xfs@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 08/13] mm: update shmem_[kernel]_file_*() functions to
 use vma_flags_t
Message-ID: <40af67b2-4d9d-49ff-8085-25a60bd25619@lucifer.local>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <736febd280eb484d79cef5cf55b8a6f79ad832d2.1769097829.git.lorenzo.stoakes@oracle.com>
 <7ccc3447-3a39-4206-95c5-a6cd00e2bda6@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ccc3447-3a39-4206-95c5-a6cd00e2bda6@linux.alibaba.com>
X-ClientProxiedBy: LO4P123CA0078.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::11) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CO1PR10MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: 323fb27b-9ddc-4de7-7f79-08de5a7b3739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?49fbx8x+kg3rgm7Nw5mM9DGpIHDQikLWbUncf8a/dECd/wCYT4tA44+56bUf?=
 =?us-ascii?Q?ETuCYJDbbfOg3cKdSD4SzhmtM2sEggeexP+d951ccoMGOQrzqSkdynCkiSLv?=
 =?us-ascii?Q?BujJhqJanfkVXgSGbntCIRa7gZVJcCx352cz5ALwRUh1K/EZ5T33y6/tmrD8?=
 =?us-ascii?Q?QIxRLUXfL2pUkUWdO14VIhK8FtHYcj1CZdwIr8PEYYsrJIbwNwTWmOyR0XBe?=
 =?us-ascii?Q?Wtm8fP7JuHOXLtzEM0RX68rWih/7CvYHfihh7ZM89mHI3km2kMRwOlcBTRBi?=
 =?us-ascii?Q?zGyYCpR/n9i62l48CUlvrAB9EqYruGQszEBLn51tobOl5NcQLOHXs3XrYfYd?=
 =?us-ascii?Q?53BoUEClVvlf7uqi2M/NoOwEHK5COXfSnUHuf6zHJnGw7He7vDcU6MPQr30O?=
 =?us-ascii?Q?UDQphaz9YOOFbdnV46VGOslpDMuUxKp4w0aqr2rVKQ94Ko70hNxpoc82leg+?=
 =?us-ascii?Q?MQSVkG3szrgQN1X6FkrxSLUvHGhQQUJrUamVTh/z7xyOERJpBfWNUPMm79d9?=
 =?us-ascii?Q?3I/soNpweCdV2iNsvxH/P0V36hMMdYWZySKGw8+QFvwswdPmWNpdfAmmS8HO?=
 =?us-ascii?Q?x9jFJNvUav1nCLRFCzdppZv8GD0dx86SitkEI/cPUsBaU47/R3ixtQJ0So8m?=
 =?us-ascii?Q?IvaC/DHOZCn0DQHmy7jJPFwuJqJUVFPIUWkQGNxiz4tJwkP+tlDLIx2UCUpL?=
 =?us-ascii?Q?3Do6ZleBDOL4Y6cHic4Rnqm0OHZHdIlatRNOVNrIINAciW+EfV41f4C/4nWh?=
 =?us-ascii?Q?VnJODhqvaGET79T7i2LDWIgB9banQX+oQ7KSy4RwWnWQbFZW0suot/M4bVc9?=
 =?us-ascii?Q?HMSLWJq3qgudSGMTrliZf5gCwaVqL1cqy9EvnkASAeb8jxv3a5odgR3pSxYz?=
 =?us-ascii?Q?c/DUU/lsT3r82Jvxo0INnSPdwHfE90zSbaqG+px5spPkJj2Irpp+PcOqLP2G?=
 =?us-ascii?Q?GCNMOQNUV7iLcn5KyRJ6DCpx8wxTNyoLP/u6pzyrVgcX5Sc+UngQfy744KXv?=
 =?us-ascii?Q?O5Mg5iQmeSFB+nco1zf6PH20tckOsPFYIhahudxDvXkTcntOBwerYhAUNGBH?=
 =?us-ascii?Q?fidd5KhfFFWsSSqQQfI6nTmUasBhBdG1xZBaFjXyiFs7EozoMjDrAIGRF6yS?=
 =?us-ascii?Q?HiHWab4eutBNz+ZsmjtUUZF1Fyf8vBd+wecT15JhibdvZRAPnpTjeZXgAuXB?=
 =?us-ascii?Q?1rUV0p4znepDIEkj9bALwN2FEKWXd51tjeOpumNKHJnuItJ0vNoPJxSbKZmc?=
 =?us-ascii?Q?Q1kEUvj9eZXlLwKXQDSemTAOCNDPXHlEl3gTZB4JV8qTyoKYlduQy7hykfO+?=
 =?us-ascii?Q?2X07/cCqiWMeCo+MKyxtxaKpusBsOVVG2L1ppt8U2yWinuP7vQgJc1Z6hCEy?=
 =?us-ascii?Q?oMPnB1WJjsHu/fO7TlfodiFYO9wBXT6lnfBJrBY8ShNf9in1U1XGZkqZNodi?=
 =?us-ascii?Q?27vbZ+teBXJnQr8JD2KRGdJh7wub/0X81J5tSOLaG1V9r9y/ZSWAfboC5qJe?=
 =?us-ascii?Q?RMcjDaVbLDyQ34CHvyWTy8TuBgaPE40MqiAVko1gT1lvG9paCkGCae1t1ZHb?=
 =?us-ascii?Q?v4cmwa/p8Vq1z6evbZ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lElheO0pn0y+epnV9/coPFBaRbTYV7OKqeuROnS8Okp83C9obau3cPdvjx2a?=
 =?us-ascii?Q?kD0Dn/Gx9eZ4I9mooK2RcpSrNyklsMW0xnBkDHNt3uL5IkVre6m6gtQNVvaB?=
 =?us-ascii?Q?XRJqUIvmOVL8mE5YyKtXMC9BhLutftU6VB5Zic3mO1+9fduXSJ82dozcv+Tf?=
 =?us-ascii?Q?u8n+YAW0s3To9PHD6jCOnsjWXN3EKVVyYMtdsLTCWgHH1Se0vQvsRmXgo2nT?=
 =?us-ascii?Q?PnhLZ0NcZSdAuNRaJ+YMnxIrlan1oi5b1XPT6GH915js3SeRVXQcoe8sQGhV?=
 =?us-ascii?Q?SD2NmXlHRGJa05MRjrgZkTd7J3iezsbV90btoin5cwLTs8IQXH1tPwJ5oy3v?=
 =?us-ascii?Q?bQetNoBv2L+hpPVJeP/y2L24vzXVyyrMNqAGnyWrjF/l1/Kvw1TWX0XlHYCQ?=
 =?us-ascii?Q?RtojXUFAnaILDseK+db6eLLCKFO+V2adBbYLhtYASgpEWDQYm0g9YPMTsIL5?=
 =?us-ascii?Q?NL+fgBp9/AFj/nv6RPjSQu9ttKnruE/XLTyfWBWdA4h+jgpjPW61MBB+AKq3?=
 =?us-ascii?Q?1sigv5C3pgBRAFmXEbeFyE08a11Nq4piJHGeksruhy9XMQuMc2zu2WjUgVPI?=
 =?us-ascii?Q?egSL+Wg/iX98lRNGVyHXVGb1Ib6RruxGdqZ8X8iNMaC+NC0uiKcOr/OpCBdB?=
 =?us-ascii?Q?K0L40xqWwVu4fxg18WmDbqB3lvwu/mdgX22RYVptK32XHF4LwZpiqzGtiCHL?=
 =?us-ascii?Q?ntm2T3MZbR2HBRjvXFrcFghIwuX8D2W0ZWbV+E0hQgMdz0xHoJKop/uiOB+s?=
 =?us-ascii?Q?ZmeOii0HR3WX5lHYezoivRapv1tAkC7bqAWSmwjpo77dR3hK8kf0Euh7hNps?=
 =?us-ascii?Q?t86V6Px8VhaiT/tyvaXZCxuKPraZ8tu5dnUP4XozEPlY/kU6uS8yE+WM2EP6?=
 =?us-ascii?Q?+NdzvcweBlGGaE0gVWpo4fMFThZMD8RCM0oq+izwxpczjGiNAbox9PoBdcAW?=
 =?us-ascii?Q?HRoYjUM098nwVmmhGPxvZ48EZU49/IbDDVN6A1VpLNm4LXc1iW/pf6U67d1A?=
 =?us-ascii?Q?Khqe9EtdvncffsuV+eki0lBmhfRnbJLRROMJ4eTuvg81gm9qZvXYPHZjnkEL?=
 =?us-ascii?Q?rMSpAAskZLZoGW/9BX1MXi2Tn8r7ySuEyOHzd2iHWAMpVkFwU6Qz4/aJCEx9?=
 =?us-ascii?Q?iJkWFfTbpndmNXF3gJKELhmx6ef+aYVdfj6ixYEoLVpJWcfmCU81dhMttpZu?=
 =?us-ascii?Q?O/wrTN3N6q2qciPnwR1QC13YeO74rvjF+lcOVjrKguiGnVP7rf3L7VGjIArY?=
 =?us-ascii?Q?xD7q9ERNy9yZjAziZr0IWZAkap+kqBdNZnHqZyPmW0CFXd5W7PEf2m1SL24P?=
 =?us-ascii?Q?GRHJWp8AGNbX2yHXQKSfPA7N+IL2AztVtIjUzb1k4EteLIQ7vVEdiRsue+2K?=
 =?us-ascii?Q?IrUAmInum6bAwZsKAwFWk4S/MjkM1A58A4TWwhTA+3IFh61E4dYnWtyojwBr?=
 =?us-ascii?Q?xiXboYKN3mjzyQbYEGFM2qTQN6cH4abhV07tIVAtnJWidbNmN8XwnJANAwHv?=
 =?us-ascii?Q?lZV4LZ9T+04i11lZZ9327gOnjHxBSFK9bF3q9coIQ4qABq13Jheq87RpLRTA?=
 =?us-ascii?Q?bFnyWotDVYbtpyKlI+LeSEri//97gqqV9Trn+tg1O6CCnlb1fUd8W7Ru+fY6?=
 =?us-ascii?Q?yTyccB7NU+DFOeguyR+Qv/FT6RXszF/P78IcyqZ8ESj6KWtUMKTk58CqV+gb?=
 =?us-ascii?Q?U+f/vi18LhcUeBWFCHWGgvL76dxaEcwGVYqym3DmAHHjDkS8PC+59qXUbE15?=
 =?us-ascii?Q?aoeOL3Y39L+SK0gigiOBB/nzFz7QLwQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uC9ryCI30PeiSPhehLZCDxideZPIDzo76u+2JptGnluQ06KLlvWUJQPDle9/RX1sGZ3HE3fV45bdAY1gknhVDX5kTMYma2/RCDiqMNk6B3Qagbuo2Ab+y5pykqx3GgoW34/vUTVLUqt6p8H6zkA0G5BOIa7YM0XnKKdjgG/VREzX4wZAPxh1G+nD1Ih+yW6VSg0num65lTDLjyYarW/v24zbWoTrzshoRrSHmJBjcoj5t9Z+MRfIhaddd7Sj72m7bEMg15K8DddZJPf5pQAnxKEV/YgxiEbgXdBRalk/gWIOcpg4qNIPNKMWGgyZKqu2V5Rs58dgt87grnOSugUQFAIL/deFYSrGV77cFHOF/1rGqxJfSDda7heSaGpxoj1PN04fFHx1Yfit2EiDLXeuh56e4m649GFOBN3KMocMIUh49eeM+0l8+tilA0v/XRSS+qQ4CeWEw0vXnOktLIWjPVJr9dbIlAuHvn8s4mkZxHwXR2jbjhnR5StwqOHrMMJlLvuDbKXhqCO5MOJM6KusTuyu8lIycUUMcXhPWAY/YaojsYoHRl3onz2Av11cNwJge7HsTonjL2Cb8adMC3gWps/Vn0mfW+3Oq+//EmcYxeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323fb27b-9ddc-4de7-7f79-08de5a7b3739
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 12:30:38.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awu6l0UroqalHr7KadpPu4VMN6Wo7qdaORq07AAZ6VLJUfoROkLykE0VB6X35Voj+Hbp3EAIg+LpwZNG6Fk3LGo2GXIECf14mR57T4uhcoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601230102
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=697369f4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=SRrdq9N9AAAA:8 a=UziPCChS1pfoD-ODKIIA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEwMiBTYWx0ZWRfX0QC4Z36GqQwo
 mhcIGxPCAk/KwfHqnKDacZZWSCKdSex6hPpfhZ/r/og0DbgkZ9kErf7eB7zzLGe9hRcGvarCSes
 XDxntjrIEsdiw08uE8dL+eM9noVrbed86ucQ7dNHxxpi65FcXHVlB0f1gDKiERs/fdWAeRdAfSJ
 qw4fHpn481DW/Je9cmH506lHSm2U8k/ujVARkyFUgrHw1A/0c9yI7+gNtkCcR3j8/7yHLi9axyI
 fsnP+QfFJZ7UNjsWoyF9Wq/pcRiddQWybwFaE1vMpSFcDstSfpbvFVeHPqa0XEJDl8qInAPcRCZ
 HeiNxqOrkBQjWr094i55Bxey5Xz6YVIBK4grl2K8s9kvj7ktTqJC7NLFPoXe3yQRw7B1gurFQBR
 onkaudeEbPiGJpud3u8L6OpXNjG1qqw9egTRIZjJYkejOetTBlTizVNd7uTtpAeBr2WN5MYX+vO
 940isal9RK+O17/DD99SlgdLeDmr/Pui5F0wOSlA=
X-Proofpoint-ORIG-GUID: 3lHxrssufZUQJFInaL8xq8fU5l2_aFyS
X-Proofpoint-GUID: 3lHxrssufZUQJFInaL8xq8fU5l2_aFyS
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75280-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim,lucifer.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9EC3975D9B
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 02:20:51PM +0800, Baolin Wang wrote:
>
>
> On 1/23/26 12:06 AM, Lorenzo Stoakes wrote:
> > In order to be able to use only vma_flags_t in vm_area_desc we must adjust
> > shmem file setup functions to operate in terms of vma_flags_t rather than
> > vm_flags_t.
> >
> > This patch makes this change and updates all callers to use the new
> > functions.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> (reduced distribution list too)
>
> Thanks. The shmem part looks good to me with some nits below.
>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks!

>
> > ---
> >   arch/x86/kernel/cpu/sgx/ioctl.c           |  2 +-
> >   drivers/gpu/drm/drm_gem.c                 |  5 +-
> >   drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  2 +-
> >   drivers/gpu/drm/i915/gem/i915_gem_ttm.c   |  3 +-
> >   drivers/gpu/drm/i915/gt/shmem_utils.c     |  3 +-
> >   drivers/gpu/drm/ttm/tests/ttm_tt_test.c   |  2 +-
> >   drivers/gpu/drm/ttm/ttm_backup.c          |  3 +-
> >   drivers/gpu/drm/ttm/ttm_tt.c              |  2 +-
> >   fs/xfs/scrub/xfile.c                      |  3 +-
> >   fs/xfs/xfs_buf_mem.c                      |  2 +-
> >   include/linux/shmem_fs.h                  |  8 ++-
> >   ipc/shm.c                                 |  6 +--
> >   mm/memfd.c                                |  2 +-
> >   mm/memfd_luo.c                            |  2 +-
> >   mm/shmem.c                                | 59 +++++++++++++----------
> >   security/keys/big_key.c                   |  2 +-
> >   16 files changed, 57 insertions(+), 49 deletions(-)
>
> [snip]
>
> >   	inode->i_flags |= i_flags;
> > @@ -5864,9 +5869,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
> >    *	checks are provided at the key or shm level rather than the inode.
> >    * @name: name for dentry (to be seen in /proc/<pid>/maps)
> >    * @size: size to be set for the file
> > - * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
> > + * @vma_flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
>
> nit: s/vma_flags/flags
>
> >    */
> > -struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
> > +struct file *shmem_kernel_file_setup(const char *name, loff_t size,
> > +				     vma_flags_t flags)
> >   {
> >   	return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE);
> >   }
> > @@ -5878,7 +5884,7 @@ EXPORT_SYMBOL_GPL(shmem_kernel_file_setup);
> >    * @size: size to be set for the file
> >    * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
>
> nit: s/VM_NORESERVE/VMA_NORESERVE_BIT

Good spots, will send fix-patch.

Cheers, Lorenzo

