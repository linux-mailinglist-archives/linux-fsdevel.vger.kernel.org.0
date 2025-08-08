Return-Path: <linux-fsdevel+bounces-57108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2F4B1EC55
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 17:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D3F18C4F3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A549728541C;
	Fri,  8 Aug 2025 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NPIGwmgG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zUqNOIf3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52971C4A17;
	Fri,  8 Aug 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668119; cv=fail; b=BuGxG98JyQjvjf1jHIGiYR3wqfXcOli9IV2HQMDg9LlSVW6YCbXNBYvRudUqys3ABOJLdG7f5xmVA7n0nf9Cg8JRiYKhNnxPhi9LFGYwM8xUPOMlJax19CBNyGQD8BFcA3DH0Vvbs6Td8rWBDbMuo5JWPfcc9YkhS/8nS66kMlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668119; c=relaxed/simple;
	bh=nh9Fa97m5iZcyril+7BH3bFPeoSdnUaQfoFeagz2ni0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rET5zKehdfxIVCL0mLVrrWidWoh5MZ79w2on5P3wmqdYeswlBE1iu16tabZndgLf7hz8wsPGYmzuUwUiSLyX4zef7ULTK1FiqbJsCeGBsBFQQGDDH35Xn/9PMEC/WFsbzyz8+mFKlQmRAWFBcXszgiMqIJqG4dHs1D1+PH1VM2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NPIGwmgG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zUqNOIf3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DNTW8014746;
	Fri, 8 Aug 2025 15:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/oseSVPmXXi31u4T66
	hhqWXynH5odVqXADVgwYQrwYI=; b=NPIGwmgGHk6UI+WhHirpE7vitmaC4pdwXL
	vst7uFpLEc1hNtuq6aea7/csnUJHKU7DjOuWpFPWkat8ZjTfImGiE01FIFsyiDDw
	pfJDYlgw2scJ09vj1A4HU62m9ODIJv+4BS3+nB6b71Ag2Db1zq4s2o4UTDYmptjv
	nTmujdc9ZmoH7zUyMlWauxrt+x8j7u4yLOQks11nj08eUGxxP3DQCR2vAeGQoChV
	A/K3swTGdhdACSrj5fvw3WgTZxQuyKn2cXJVsncnHCwmc9mrssZirB6BKuzTu+kj
	ikkaUT6engLWtjmbdBXCUahuEV38fHTnxDQbQVRQcIKk+hYIwyuA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpve6mcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 15:47:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578EH5pQ032083;
	Fri, 8 Aug 2025 15:47:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwtexnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 15:47:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Akomebsmak2JFZQ1UD0zI6xe6J2OGTrlJucn50gWlqfOgzzSe6DvmP7KKFCpRJvPd33yWv+hSRnElx+KZcvpjVDRFN88pWtcWD+RqX8cslmJ/aaTXa8EQHhV4Oow3CRzp+Q1cIx9C5hD+fm+/ogXz+Hr7Ch7AwVp4/l027ONcgkTyESuNKuZfHt25WxFuMVI4VdgKyE1G7y/45R+GnH8WC9fhiBRggqmejCRLUV4VJC/kQIdywade8KalADxH4YUNIfQHXQMPmXCnMJ5lFBJClkiuzAYUGy6ls9mBp8xDZIJ8F992wlT6W5xr8A/w0b4nO4g9RB1rqbK/dCpGElEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oseSVPmXXi31u4T66hhqWXynH5odVqXADVgwYQrwYI=;
 b=hvPatrBhBTXBU6ZWk5m0PkMaSJ+YJAihGeBzQQdDxQGkrDMuZqtOCB851u7nq+1pzLLB/JlSiBANflQ2mmmys7llZMn57HS9oljQSHfTvrJd4FQ8VCa/XesS8So47YFgbNMhpOecyTEWfLTXgVBtYCbpflKVl6mnu9RTIFSVS8/tMG9I5CCngrY0K75vp8HkM4zKu9elIq0TLP7ui2NByUKey12VffF+6N4Y5qL9TRodsZRoxz9CykLLBDPz3CCu+gnXtyVolkR4xbnb9gTbTp5xv2qdy48/k+9yvThfRg7d4E+p+RHdzLIW0F+eXOAzDOWOV3MoxMI/UVQooi3SOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oseSVPmXXi31u4T66hhqWXynH5odVqXADVgwYQrwYI=;
 b=zUqNOIf3/JmavaxhksXsTsylBJ/QcSi6mAzezWeHJHggUmdwGm0MzVJjPzlO39myn+Yp4ZtfeydUISStWGg5oHDnbHd9WmtbxoyWPAhEr4hAw5/bDw3SRF3qTyZl5k6ZamjZTn6YrlV6uSolbZx1xqIKlLSrPtMw2v1pi3kNkRI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5107.namprd10.prod.outlook.com (2603:10b6:208:324::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 15:47:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 15:47:42 +0000
Date: Fri, 8 Aug 2025 16:47:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 3/5] mm: add persistent huge zero folio
Message-ID: <731d8b44-1a45-40bc-a274-8f39a7ae0f7f@lucifer.local>
References: <20250808121141.624469-1-kernel@pankajraghav.com>
 <20250808121141.624469-4-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808121141.624469-4-kernel@pankajraghav.com>
X-ClientProxiedBy: MM0P280CA0076.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fef815-717c-45b4-6920-08ddd692e90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xdo25V6r1XIyt+ne46cMOdQ9R+KhREwDtTBA3qNonHoil7IeOrWS+H6niUYC?=
 =?us-ascii?Q?m0uPvTZ58j6+T6OkosckBeKXdyQXQT5RAANc+6rBB/6qLsADUmaYFYY+ftQK?=
 =?us-ascii?Q?0AvvEjU4DyHkcX/sM36wpYGll8ixTFm94Z+OcgPTB44j5ITKDAplzt1QmW/g?=
 =?us-ascii?Q?EhdZPQhF+FA2k+68l0TQ2xMmjz/mjmRz60FgWS7gxsDmIn5wBhEauQg6XMxu?=
 =?us-ascii?Q?YdStebLD7lhejoOqKVnZW5fgRazDOCDqsIE3xGM54hjtzpexOfYNvG5KfFQD?=
 =?us-ascii?Q?8gEyPGf/vodG3L2wuoXIKTqmh1JI/5qYh5mfveVuCT2YRqS2zEVpmxJda1ex?=
 =?us-ascii?Q?Dy5gD8X7dmZZa+LWOlyMIR8O6P647u8B9zS8AS6XJBtCSSTQvpxKoiDYxnwG?=
 =?us-ascii?Q?QgqSURnugoCeIZhpfYWiQy1bfSlN5sKjzYk0VhOgjOZDwmOHogxyQ/yKsELb?=
 =?us-ascii?Q?itlvUdF/A7pgHfzAD2qRsixO0BORHYP+0kT78fMIbyjfdTEk9oWPkjkYT/VF?=
 =?us-ascii?Q?kfVPS3OB6jLfohH15abDchqE0gvWcuTyP8qp8jueDs/CeX50eJZE+SHN20ho?=
 =?us-ascii?Q?el816uxJLfTc6N2XO2nD9SVAV2S1N8Td8vobZkqKVc/BebXGcjRJTv/2Auqf?=
 =?us-ascii?Q?EgW1X83iY0i6h5tf89hGkYXGd9B+YUrcv6HW16PrMtVsg9UccgGh3KfCUtYt?=
 =?us-ascii?Q?ZKjn6tnZ6Q8wLTHtj0mthwkQ85XS66YKrrwTMoE3KoVLE/e79Z7TX5MHRfQK?=
 =?us-ascii?Q?d9EJw85Fm/UKCnGkfk852TnTC0CsBiM33ELNNxoGquHOqcf+JzF6uQYhw858?=
 =?us-ascii?Q?oVrgfPrqhE747wYUU1L1DVaoKXKkhHjEAVK/UoMu3gVvMpiFhQVw39LOWiS0?=
 =?us-ascii?Q?3MV82YDGOxeEfWJN9FKtWMut9fkwLODAsOaW3GN7FUT2mmRZKn0C/QQaEgX3?=
 =?us-ascii?Q?obooZBILY83f6qsPMoaojdkXsGjYAGlFc6JUlEOZjxZrewjEgu9iPATUfAYr?=
 =?us-ascii?Q?+eEHZKHH0VkEg6kdCaxT31ChePF7Cp6jYueofWHLLz1FlYv3bwvJPYTmKazk?=
 =?us-ascii?Q?r3Ngp3HsMZ3UgQ4srK9w//YTGhK7Aq6GjdBW/2e6Q1N8D7amtYM8BDU56rZa?=
 =?us-ascii?Q?+YeaUOB5U/OJZqK6T8PW7fYU+q/yZHFEk/L8MCtWAIbMj5KZ57oo86TtECGz?=
 =?us-ascii?Q?o6wsD9ivys8dWRO+SEB5/DifeW2Yt8byUbY3C07TqKoQzBpC39RThsWLfwZE?=
 =?us-ascii?Q?ygw5HKvUPmwiv/qL0tsWteNc7cW4AdkXEkxr+Qia2SmbgplXpRQ3j6P8rhiM?=
 =?us-ascii?Q?y4p64+6MvhCHLGDriDWlsV86x2B94Pj9HYJHGAE7Uyzf/FlLBqlw4Vu+9nrv?=
 =?us-ascii?Q?tzPoGv2RDg2+ehK4a1xfbfCyDgaVWKjt228ZumdYIVDo0053m4ekousIUQIt?=
 =?us-ascii?Q?WPzWaw9aMIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XSVFGbh2+sjfmHcRYj5rGK3LNpe6JJ4Z1h3HFlN7BZ4EXbTZMGOR0BE46w+r?=
 =?us-ascii?Q?XHdLHu2LGeZM3Mwcz0iV52ecSYyB7/ksRUW4NeRIvLGWGFgIGFG8jV0X3BMJ?=
 =?us-ascii?Q?a62FmhBXzUFKeteMfcgnoenuxTluMPSDE7pmOWM2B329hac3Ij2sC1MYQtU8?=
 =?us-ascii?Q?J9UDYxYohEPny2UiiYzy5gPah/prNWl/DDUlCC5jS6NysvaVU+OZFsngz18K?=
 =?us-ascii?Q?zMobwpHw5drXBjMfmqh1BUkZmnhbpULOPILa8OCZmmLrLHm6Lu09TgBTem88?=
 =?us-ascii?Q?+Ork/M94xPWfdu/UDZ1K/aGYJTkB2gXHHQAxNohM///Epbw7wJsTB6jmWkPV?=
 =?us-ascii?Q?iYNKbp7QkiOaMCbPvTtXy5zSDaINpKkWV72CGiTtP6AqA1h0McuukSiLroes?=
 =?us-ascii?Q?jAl0r/Yl4IBUgsqtGu9AoZGNPkbvTLouuvKPPxnpn2hTOmDaU/4HQBwvEPnN?=
 =?us-ascii?Q?wsU11EsfR5gVNlQtTpGGya0BIASLZc46tjy7OR4f2QaHI+WaSyJK9kOcljcX?=
 =?us-ascii?Q?ovS4x34qRDEx2djePB1Zb0MMdrrTIcxf+qedszaTzjvzGNE/8GdvA6nL8XZ4?=
 =?us-ascii?Q?jR6MX34JsfZO9tkFvkzTdb5vfwJeqgQYer1N1c/04hWSTZKHoffkk7s5LAEd?=
 =?us-ascii?Q?FVh/ot6FcUVXUScNyAy1+IKFVelSt8ipuFvUqMTMc9vrMWM6uvfV2Ph4ygvb?=
 =?us-ascii?Q?zE5DKcRvy/tXht04eCwhCNgCZ1OnKE50HDZVuu8HjZRKzHfPAW3x0NCpvCgx?=
 =?us-ascii?Q?xCkazGB0SNsvT9abkLUXxrF9Fd5X6veZ9QtrUTHP/MJLQOYH+723t72GvaPJ?=
 =?us-ascii?Q?kq3Sa0kGzxHvttTj18450+AUxTfxsbJcD/qcNHDpRU6OzqfegpuvCTe/3iWZ?=
 =?us-ascii?Q?qyHiZmKZBnSwNWBz+vnyCa50rI0DWvhnz0jB6aVFIHOG7BKbcVPfLOAEoZM5?=
 =?us-ascii?Q?GRv2ggcIlQONg7S2/Jd/a1jSau+F/N3xLgY45lF8jryWVr7hkaxbGnQHr3C7?=
 =?us-ascii?Q?9X9rjNYLmT2drAqGPJRL2OUB3YFwGncQKNH3CLKbxI28mQCKzYklVXSwgm2P?=
 =?us-ascii?Q?ZKIuROPovlnX0PawFAbQ7HbVXJysIswvm0mXQXwbbkvLEbGUov3t8PU9UT2B?=
 =?us-ascii?Q?OQPvZr/+o4bIYkYSZwU6uiorsAZ8VnXKfx2HHa87vrwZuj+8iFEJ5M/gNEjh?=
 =?us-ascii?Q?jsn6N6Nrm4a/9OfB3bZB2KYPz1Qo1a2CmHEEgEJmkCPUvENcqfKMDNlsy6RL?=
 =?us-ascii?Q?8Y8yZGnb99ZV8ULReodMyJz6Fh87GwjqvrvSS/e9s7xZoXMuZIdO3KAQCT4W?=
 =?us-ascii?Q?rZoG6crWWZpTKNri/QFEd0/IRAVgUpDwv/e0tjJBpd4Za4L8s0qYdlb0/Ufn?=
 =?us-ascii?Q?hFQUXsaE9LUTzVtb/Ts5KbnmQ/6H+h8b4KQBWg+5y28lU+6pqP9pKfUqWrs9?=
 =?us-ascii?Q?o/bXhnBwTKkbnD+dkcNEgSXgcqcjxXBFEoW5UH1Kq48QH2aPAQMs4vJ/CPTb?=
 =?us-ascii?Q?OMg10zXhsx7+QU8DwHW1xjLXqlsZJOOwtwyZk6BknIPse+NbLF8sxCf/Ervg?=
 =?us-ascii?Q?Lybm86lpp/yy80meURmHZ2wqA8fOJqDK4IrDJAKlWFy3mliIpGHIbXOj+RG3?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dyCrLWQILt/+lQNgpq1unUwWyqZNh4QqLx2H9/xe7cootPdxN7Y2vU06ogdZxSo9N59Cp0dWh7Q0O7XiMicxZ6QJh0BE09IQxeMJofy/tZPxB6LZ1ScZgFlUI7dmWQw+Oa0nhtFvOHhb6Dsux6JBjBWt6cpifO3W+0A4BWzW/ipRz3ZrcwrJ3c747+R5hxb5U4l++aSVTK5nvL3SqjUEkjUBhhy6XpANDVyVAHcPTAZBpbAFGp+3jiRHyheEMxfk/s9vRbrnpHJ3bIIeqpUvho5MCOF4DdvriB6b6rM9n3SXI+Tk1mWj1EunzNdR0nGBPJmqnlOs6RJmfNMVqvlMjLMcw80XCFmtKffI3KAElWq6Rnky8vs/3ID6R/7tw42c3i89HGYKU1VjPzFFeaci0VSvljqMoK+CT5WTxcFz+AlO9UHos4IZ55fr0/t0WricEW+sHNJsWahq7T48lcBX8HWig3sZc83k8ZjZiURY7qQ/Qmx5X39niRAHrV0kjLxgI71WoiUG7jSqDdpeSWb1IhGZBbs8/WZm0qnTKRyWCfGAuA4ph02Yb5ndd3dupLSqnj5apSbCI5WxuivddOl1+zvdOm1j2kzoBRDk3eMbqsE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fef815-717c-45b4-6920-08ddd692e90b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 15:47:42.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJVV2aw967Hw6guVTlWFxbNEsn2p5FMCvFQGQTZ9oaZijclrvDdOl4z/zVkrwInE+hpFM3U5uxPbOcGJzXo5uI1m8/YysAvGeN0+xdJvEmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508080128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyNyBTYWx0ZWRfX+1hYQ+75fycq
 3+HBv2wYQ4MmkAztSjC07R+RaM6GrIVLWm+o3/9QO+vhWpx4I0zkJe0UQsoc9yERo5aK6W8OiJG
 V+yBSXGBZf04dG+cXnbSBE9+aL+A8nqz1E1+5X/UAjg0drCG//0rxHnEowIzLjJPCanbyPhFnVB
 jToninbsK84VyjK9Peqdzob8LIVYubKTA6Cja6QrVI8vpV1rnOVk88R97BQFeVovBptPKnHdIMC
 pH1wBPOg5iz1S9YNz8xd1rSJujTxAAMR8+NejcsUmyt0Qoh3+grogeS5qkAIHhe0uVo9zeob5kq
 i6rFEKElubcDujru2i1CFbdgRUhYGvTrQLIiAPsiin9emIu4mTouRyIdviop15OUVBDl4BetXS3
 cy8wkjlnKq54pYBWd6tsqdQ+rAqmOPMve9cTsHk7z8QNS3BlnXdNMjHROZHKLZuhhaYCbDMZ
X-Authority-Analysis: v=2.4 cv=ApPu3P9P c=1 sm=1 tr=0 ts=68961c21 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=b-UZI_kN-eTE8Grid68A:9
 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: Fw7XuUAUs_r2J51GBbLyv7zDfC0eMmx2
X-Proofpoint-GUID: Fw7XuUAUs_r2J51GBbLyv7zDfC0eMmx2

On Fri, Aug 08, 2025 at 02:11:39PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> Many places in the kernel need to zero out larger chunks, but the
> maximum segment that can be zeroed out at a time by ZERO_PAGE is limited
> by PAGE_SIZE.
>
> This is especially annoying in block devices and filesystems where
> multiple ZERO_PAGEs are attached to the bio in different bvecs. With
> multipage bvec support in block layer, it is much more efficient to send
> out larger zero pages as a part of single bvec.
>
> This concern was raised during the review of adding Large Block Size
> support to XFS[1][2].
>
> Usually huge_zero_folio is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left. At moment,
> huge_zero_folio infrastructure refcount is tied to the process lifetime
> that created it. This might not work for bio layer as the completions
> can be async and the process that created the huge_zero_folio might no
> longer be alive. And, one of the main points that came up during
> discussion is to have something bigger than zero page as a drop-in
> replacement.
>
> Add a config option PERSISTENT_HUGE_ZERO_FOLIO that will result in
> allocating the huge zero folio during early init and never free the memory
> by disabling the shrinker. This makes using the huge_zero_folio without
> having to pass any mm struct and does not tie the lifetime of the zero
> folio to anything, making it a drop-in replacement for ZERO_PAGE.
>
> If PERSISTENT_HUGE_ZERO_FOLIO config option is enabled, then
> mm_get_huge_zero_folio() will simply return the allocated page instead of
> dynamically allocating a new PMD page.
>
> Use this option carefully in resource constrained systems as it uses
> one full PMD sized page for zeroing purposes.
>
> [1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
> [2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/
>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

This is much nicer and now _super_ simple, I like it.

A few nits below but generally:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/huge_mm.h | 16 ++++++++++++++++
>  mm/Kconfig              | 16 ++++++++++++++++
>  mm/huge_memory.c        | 40 ++++++++++++++++++++++++++++++----------
>  3 files changed, 62 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7748489fde1b..bd547857c6c1 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -495,6 +495,17 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
>  struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
>  void mm_put_huge_zero_folio(struct mm_struct *mm);
>
> +static inline struct folio *get_persistent_huge_zero_folio(void)
> +{
> +	if (!IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
> +		return NULL;
> +
> +	if (unlikely(!huge_zero_folio))
> +		return NULL;
> +
> +	return huge_zero_folio;
> +}
> +
>  static inline bool thp_migration_supported(void)
>  {
>  	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
> @@ -685,6 +696,11 @@ static inline int change_huge_pud(struct mmu_gather *tlb,
>  {
>  	return 0;
>  }
> +
> +static inline struct folio *get_persistent_huge_zero_folio(void)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  static inline int split_folio_to_list_to_order(struct folio *folio,
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e443fe8cd6cf..fbe86ef97fd0 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -823,6 +823,22 @@ config ARCH_WANT_GENERAL_HUGETLB
>  config ARCH_WANTS_THP_SWAP
>  	def_bool n
>
> +config PERSISTENT_HUGE_ZERO_FOLIO
> +	bool "Allocate a PMD sized folio for zeroing"
> +	depends on TRANSPARENT_HUGEPAGE

I feel like we really need to sort out what is/isn't predicated on THP... it
seems like THP is sort of short hand for 'any large folio stuff' but not
always...

But this is a more general point :)

> +	help
> +	  Enable this option to reduce the runtime refcounting overhead
> +	  of the huge zero folio and expand the places in the kernel
> +	  that can use huge zero folios. This can potentially improve
> +	  the performance while performing an I/O.

NIT: I think we can drop 'an', and probably refactor this sentence to something
like 'For instance, block I/O benefits from access to large folios for zeroing
memory'.

> +
> +	  With this option enabled, the huge zero folio is allocated
> +	  once and never freed. One full huge page worth of memory shall
> +	  be used.

NIT: huge page worth -> huge page's worth

> +
> +	  Say Y if your system has lots of memory. Say N if you are
> +	  memory constrained.
> +
>  config MM_ID
>  	def_bool n
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ff06dee213eb..bedda9640936 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -248,6 +248,9 @@ static void put_huge_zero_folio(void)
>
>  struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
>  {
> +	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
> +		return huge_zero_folio;
> +
>  	if (test_bit(MMF_HUGE_ZERO_FOLIO, &mm->flags))
>  		return READ_ONCE(huge_zero_folio);
>
> @@ -262,6 +265,9 @@ struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
>
>  void mm_put_huge_zero_folio(struct mm_struct *mm)
>  {
> +	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
> +		return;
> +
>  	if (test_bit(MMF_HUGE_ZERO_FOLIO, &mm->flags))
>  		put_huge_zero_folio();
>  }
> @@ -849,16 +855,34 @@ static inline void hugepage_exit_sysfs(struct kobject *hugepage_kobj)
>
>  static int __init thp_shrinker_init(void)
>  {
> -	huge_zero_folio_shrinker = shrinker_alloc(0, "thp-zero");
> -	if (!huge_zero_folio_shrinker)
> -		return -ENOMEM;
> -
>  	deferred_split_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
>  						 SHRINKER_MEMCG_AWARE |
>  						 SHRINKER_NONSLAB,
>  						 "thp-deferred_split");
> -	if (!deferred_split_shrinker) {
> -		shrinker_free(huge_zero_folio_shrinker);
> +	if (!deferred_split_shrinker)
> +		return -ENOMEM;
> +
> +	deferred_split_shrinker->count_objects = deferred_split_count;
> +	deferred_split_shrinker->scan_objects = deferred_split_scan;
> +	shrinker_register(deferred_split_shrinker);
> +
> +	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO)) {
> +		/*
> +		 * Bump the reference of the huge_zero_folio and do not
> +		 * initialize the shrinker.
> +		 *
> +		 * huge_zero_folio will always be NULL on failure. We assume
> +		 * that get_huge_zero_folio() will most likely not fail as
> +		 * thp_shrinker_init() is invoked early on during boot.
> +		 */
> +		if (!get_huge_zero_folio())
> +			pr_warn("Allocating static huge zero folio failed\n");
> +		return 0;
> +	}
> +
> +	huge_zero_folio_shrinker = shrinker_alloc(0, "thp-zero");
> +	if (!huge_zero_folio_shrinker) {
> +		shrinker_free(deferred_split_shrinker);
>  		return -ENOMEM;
>  	}
>
> @@ -866,10 +890,6 @@ static int __init thp_shrinker_init(void)
>  	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
>  	shrinker_register(huge_zero_folio_shrinker);
>
> -	deferred_split_shrinker->count_objects = deferred_split_count;
> -	deferred_split_shrinker->scan_objects = deferred_split_scan;
> -	shrinker_register(deferred_split_shrinker);
> -
>  	return 0;
>  }
>
> --
> 2.49.0
>

