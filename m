Return-Path: <linux-fsdevel+bounces-48024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2C0AA8C1A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 08:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE848188D0A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 06:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8FB1B415F;
	Mon,  5 May 2025 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SctF8lZh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zn0MejrV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FEAEBE;
	Mon,  5 May 2025 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425354; cv=fail; b=AGR1zEO8Knf7CJAUXupJXD5Q992iU791ogMGUJtFJ1g85Vw5uO6LRfj/k7vTL1c3CGEhcQtPA6jYIq9nv55399Ijv+6yC8OT4KSgpFSXb0CyP83uZ13GWoN/uTcvgpV+SWu8d8k8Bpni4I/yE8XekJEvc2Q+U48lN5dsKkBv18A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425354; c=relaxed/simple;
	bh=yx9hGKRGuYT+9XV3l/o8xqBeLIowRG2tAQwts+RZADk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bfo3YXIbqjuJQ0gFS8Xl4cXY5+ClGnMTGPVZB5vOVODQisM80AQzE+C3bw1ISpzlA3OJtfnKR7KrQttsqdfXglt1bwERJsk+KAG1PCeyaBn6V7ROAMUARzqqN7zw/cczZEMioG+4Q89GZVF4qgL7Mb7HEu1tyHofSQ7XoYL02wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SctF8lZh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zn0MejrV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5453uhGq005757;
	Mon, 5 May 2025 06:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/EY6RKYidw5735VvmNHbZCGOGtC9hy3CDxabJN4tmLM=; b=
	SctF8lZhpUBUbMFbd5Ajmh0PQOUnorTN8RDx0tLFRrC11UIfnPbO99mCyuH/K0k3
	Ai3qH9x4pC/O3ByARbSbu1suXARJh7ijCdSkDYBv+dVzv9oyKP9cyWaoOvEVtFpn
	g78tUd8G50aCZ/WjlOLb5FIlvIIdDfEngWeZosuM9JuiZ8nYX9VlfoQK17VHyteT
	k4ge0XGZhW36uI852OCfT6wlKfNBqiEDTAWw2bArtPD4hFOFekWV8l11+RiCj97P
	Sm1IAIsPAS8tOSs+56i1ekSQJxrbU/ktJgV+iHCSNN0FXgJYi68IoFYcgYy7QTbl
	1XlgWO4UghsudCzh1ZoeJQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46en9p86d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 06:09:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5453ZAMF011271;
	Mon, 5 May 2025 06:09:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kdj2eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 06:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3zQpEQBHSjdALasqUabRDewVbWSB//USLRINY3XVdejIrN9Rup2dGal3SijisoZaA/EAQoWFHE5Ii0RUSib3cA9qZz5BBGKV6NY1x/UvtQTs+bHq5Uw5nqfF8hqZwlQAjrw1gHcFAptuDUyMyuE50Pa+hF+kQKq+lbd/ANtdfVa15WDGuSRONeh6r3oD4yyoKs927WtF9QHXw7pry7bRy4dNS5LprWl6/6C7SrHhsmgM2BOCmfr/88jB1DSXg//A5MBYwL8KmogGNJMOQCNV13TTcX1JKk19cbFLDD50F87gFJRyaiJ/muv7xubUGNWfsHkyeN6kRO7SwgB9avQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EY6RKYidw5735VvmNHbZCGOGtC9hy3CDxabJN4tmLM=;
 b=k/65xzMPfdjJQsfRzRbNamY4jZhX4i5WKmNKgLa8eQB7MB34LqT97zjXnjLlunDhEF3nBq6YTshwXfD+tVYvdB9sodZk8+kuV+ZY2K5hqr0GYYY5UfmG5e0GqX+9lauqN7YqMoFy9+2HhUlN1ZDA/huY1dYLclRhyFB0WrhtpLNXhYO5VGZ3pImLWrxVHSw9z042WwLPW+9gDkvzbFmVjSf1Zd56WfALX5yBcEux4HbOsdZxMap7/7Hk7gi0tfIcEcus16OtSIQKICgS/JdiQZp8FjUwgLCo5kt5HtrwjGz6ffJ1+5iZektwxWhrUkzkWAkKNzmScipQFhmGeEkD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EY6RKYidw5735VvmNHbZCGOGtC9hy3CDxabJN4tmLM=;
 b=Zn0MejrV7QTgwhvoa1uOomKwVl8zLX3gv7Ejk1T6k0sTvaS0s4ieZBu6JBNn/+/XfJykHCwUcKHjcOiAXPJRmBz73lo9PlHrR/CiYhuw7G783Tdh9pmvAPosvkrKeYaU/wuxqai3Rd2FVidZ+WEuRVdd0ETVHWggOYDpDTFAAaM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5901.namprd10.prod.outlook.com (2603:10b6:8:87::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Mon, 5 May 2025 06:08:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 06:08:57 +0000
Message-ID: <2a5688e8-88ef-4224-b757-af5adfca1be1@oracle.com>
Date: Mon, 5 May 2025 07:08:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/16] xfs: add xfs_calc_atomic_write_unit_max()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
        cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
 <20250504085923.1895402-15-john.g.garry@oracle.com>
 <20250505052534.GX25675@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250505052534.GX25675@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0023.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b54a6d-dfc4-4342-e7aa-08dd8b9b5216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm5UdHdVaExFZmhiQWN3U0VSVlcwam52amhvanRLNEw0Tk9NUXlZV1RmdzlB?=
 =?utf-8?B?Z2tpS21xQmZTeWxZOGZRWDhYejdidlp2eUEvUnpRREEyd0h4anZZV3NmNXZy?=
 =?utf-8?B?UUhrV0Q3ZVRpeTN2RWt0UndsM1FDRHNoQXZJQ1ZYVXIwYm1FTnZvUlBxZk1t?=
 =?utf-8?B?cm54Q3gwTDZDdm9zSWEwMzFMbVBzT21XaGFRL3ZLRGRXZ2VDL2ptQlU1cSs0?=
 =?utf-8?B?M21KbEhabXZ5a21nc3JqK2RReHUxT3I4cEtlNWJMaHJCd095VURNS202VXpk?=
 =?utf-8?B?Z0Fzd250WEtCUG1FUllkWEo1Sy8rT3NBZW03cFFhNkNSVEgwaUI4L3hjMVhz?=
 =?utf-8?B?NUxNa2svcFJOY1d4OW9VZTVRbXhUVUxydW82ZHVqT3BkYjNMcEphdkZrY251?=
 =?utf-8?B?YkZPUTZjbFVGSFRsa3FpWDBvVkNVMGtKejRDMjA3bm01MDBuWTZVeE5Ob2tu?=
 =?utf-8?B?aDc2UUI2WXRJd2dHUWJQSG9aNzBma2dPeFJ4Mi9iODhpTHowL2x2NHYrZ0Vh?=
 =?utf-8?B?RDFuNm9KcW5xRXFYNnVqRnZBbFZnZk90SmJ4dVk4N1FPdmNrVi92a2tRS1VD?=
 =?utf-8?B?Z2M3U1lxeGJ1a25qS2dvV3l2Ni83Mk5NT09vK0UyMDEycE1iK3RYRCsxN1N6?=
 =?utf-8?B?b2t3VXlzSnp3NDFZSGZaMmp6QnI1RFEyZnJEcWViV0wyQWozVm5Gb1JMdlN6?=
 =?utf-8?B?WUovQ1JkK3NsUllzUWxzMHROUE8yb0cwZWRsK0xiRTZjODV2bk9RaTNZbzJS?=
 =?utf-8?B?R0JnQlQ3U1ByZFh0UENlVzg5T3ZkTjVYNU5rckxPRzZoTjgvcHhDL095aGZp?=
 =?utf-8?B?MGk4Mk82YitRZlQ4dm1YRlE0QkFPNHhKZHVUemEyMVNmSkdldFN4Wmc1SThO?=
 =?utf-8?B?UlI1U2VOV2xNWWtpZlFlVm8zcXBBZCtUaktMeWJWV3ZEQlFFR3VBemFDYmRQ?=
 =?utf-8?B?V3hsWmkrNTlUZ2VsSFJ5OXdJaW1vQXhRVWZIZWlWTE8yT0VOYW92WjNJTFNx?=
 =?utf-8?B?RkNMdk8zLzk1K080bHlsNEhnbmdobGlNOStoYkNZcUdXa2FWNVA3RDlJQkls?=
 =?utf-8?B?am5iRm8rMXA2WjI4d3FETUdZODNOMUViVVRJeU9ZTjNUMmgzWnpxQkFqM1RN?=
 =?utf-8?B?bW93NFF1bGd0QzdaNmRUNmlVYXhiWkRvZmtndjE2alJCU3RBeU92RmJmRTBv?=
 =?utf-8?B?dk9vbCswWGlnRGNiR085NUtlZDBrZDA0VE1XNXI2a01SZmxGOE1qTVMwcE8r?=
 =?utf-8?B?UGlGUEt2cXRBU3I0MVB0OXpxWnMrKzJSbUJlYUIwQ1hQbWorUzBQMFgxQXMz?=
 =?utf-8?B?R01qaENOc2FvTEhMaGtibnNWUVNLVENKZ2NMSzdOQzNwQUh5alJQeHdFRWJR?=
 =?utf-8?B?SVQ1L3lIUjcwZ3pSV3FtdEhBbUtyY1R0ZFFuRm0xZTRYTXR4NUhkNGpEVUk2?=
 =?utf-8?B?TnhVTXhNVFhDMTZibUJPK0MwTkRYZDM0RXY3YStlWWZRR2JqTFpKSit0ZDJq?=
 =?utf-8?B?dEhyS1Uzc1lNSS9BU2lwUGsrcnM3dHdPTU9YaThrWHV0SHFBMjQwK285bmIr?=
 =?utf-8?B?cnlxa1h2ZDdDVXVmRjdGVGtrRVRDeUpiM2k3RmNuUWhBSmpFdEExM2tqR215?=
 =?utf-8?B?K0N1TkoySXZtQU5JcDM0Q2tlU0Zvb1FCYWg4SWcrMTFOOERqZnNXazZTa2Rr?=
 =?utf-8?B?UkRNZzFUMFk4UVlIVmRVNjg4aHBBVlZXMklCT1laV2dQcTY0bzVtYTdRTkpx?=
 =?utf-8?B?elJOSFA3ZjJOUlgzSWMrMDBDclNvem9UMDdWVXVZZmo5STVaTlBMeW9nUHlT?=
 =?utf-8?B?dk52dlpuQU9MaWdxTW9DWGJQRVpQNFpRbXhiaE1rdmsvNlFBdEE0dk5CTkw5?=
 =?utf-8?B?cXBXODE0elUxYTd4eGZkZnZJLy83dmpNMmgwWlk4bmh3UExZTkNmNFlxVmZj?=
 =?utf-8?Q?gEluRZsEYIc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjE1dk1JVjN0dk1lcDhHdzdqcDdldEowRlRIL0c5elB6SlhiQmZFQ3NGM0pq?=
 =?utf-8?B?bEFYOHJDRk55VHZkWUJoTnVDaHl0Zk9McXZaME5OUTZXZ3MzbzRTVkJGVnN5?=
 =?utf-8?B?dDZpT0lneWlkc3F4Z0tKbHNVQTFXaUw1NGJ6L1VYdmttVVovRG1nMnNmbmZW?=
 =?utf-8?B?OW1LRzJhclFqTGYvcDJFa1B5TjVjSFhNclhza1U4NW0wc0VjbUI4YW9MRnY1?=
 =?utf-8?B?Q081OCthTi9kN3gwV3NFbHUzZmxLK3NtY045UkdPL0xwS0RxcUdoU0NXWDlr?=
 =?utf-8?B?N2Z6dEFNS2VCa1pnUGM5RFNQYXc2RWdTejcwcFFZS3lRTEhuVzFmVUE4cTJI?=
 =?utf-8?B?VnlVdUtuNEpSRElrRkJrZHVmL2tqQUxkN1VSQmFzT2lCbFBNR3p1bjB6NjRS?=
 =?utf-8?B?UTQyMkpVZ0NKTzYwS3ZCSDJIc1BRK202WGtUTjl2SWx1YjU2ZkZEMVhxQldz?=
 =?utf-8?B?VHlBaFY1SE05cUxHLzMwZjZYWEs1RUh4NHJKZ2pCRnhkWHJ1dXpsMWhlc2dh?=
 =?utf-8?B?cHhzVU9HbGpqckpPV3lJczVRL0dma3cyMTc0c3JVRmdYNk95VENXNzdmQXZG?=
 =?utf-8?B?RldSblBwNHE1Y1JZd0h5eXpYY0tBTTg3WTlMRitjOVMwdlNNa2JUTHdOZCtW?=
 =?utf-8?B?NVVhOTI1bjdqYzhDQnloVHduT3VxSUxhSVhxL1owQ2VKd2hWQWMxenN1TGNw?=
 =?utf-8?B?V2NGb0dWY3RJOFNhWW52L2U4bmVEU3BMZkxVZkdlbTlvVXNobk5hSU4rOXF5?=
 =?utf-8?B?ei9WZXpoSXMyeDdSeCtPOVIrQjhWNjlMbjJsQms5QXlHeDRqWE1RT2MvVGZR?=
 =?utf-8?B?dEFwR09qRFNhVlNUZVlTVmFsMDFCMnhnWXVITDh1dHorNFNtQS9SWHdSeGJZ?=
 =?utf-8?B?ZmRhbW1CU2xZVjdVcDNCbWg4UjZlVVJMZWxaK1Y3ckdaYkdCOGRhMEVXeGNU?=
 =?utf-8?B?aGVIS1VxQzRaMm5XUGhqbUF1c0JvZURtRXBSalJINXBuTDNGQ1dkOHY4UDFY?=
 =?utf-8?B?T3dGNmNyK1AwUDJEMEJEaUpkUFZ5Z3lqV2pidnJFeEZvQ1BHRXJHUC9nTjky?=
 =?utf-8?B?Qzkwc1ExeERaQnE1cGZjQmJsUFMyazhTTUxUZTUyUTJVdjhSak42WDVsSm5R?=
 =?utf-8?B?ejBnbkFMTzVlSTJjSDMvQ2JDeDEwUElmdXlMM1Z0S3VCWkE3bC9GNkdCQXlK?=
 =?utf-8?B?TXpQMGtKaTBINWNUUU5LRFB4bDQyblVGNFg3WDFCWFlJMzQ1RTh1Umoyd3NB?=
 =?utf-8?B?ZXYvNHBWYm1zTVUvS0ZnZTlqVE5ZN3hjMVhYeWhNb1dJeGNOOVZyTGlTMjM1?=
 =?utf-8?B?aWg0RExQWm12QU02a1V2eWUxczF2ZDlRZk5KRG9zVzhuUWxiRnVsT0U3K1BU?=
 =?utf-8?B?U1EwZ3JtMmlRMnVDQ1RBWVNxMWl2NkV2R1h5WktqNmloNjhWOTJuWEM2Rmt0?=
 =?utf-8?B?UWpja2duOUVzQ3RWVElQb3hSZ2J3V2FaalhSeDhFUGZzV21MeDR6OTZIVS9u?=
 =?utf-8?B?YUw1ZGNaVlExTGMyYWVyVmtJc2RBazlGY3hiVVlwZXNyVUZWekY3MGVndkxS?=
 =?utf-8?B?Wm5RRWJhU29tOFYzTzB1RU9NTk9zVlRGZmViYkRaZlZUakFUWkxKb1NXTHV0?=
 =?utf-8?B?aW12R01QcXQzY1VzOGRSNVY0NlQyM0hzeGhHKzFBTHdjWWNqWkJja2d3T2hY?=
 =?utf-8?B?bm92QTh4TURqSEtDVHJNTjNpUlJjTm5BSHVZK0YzQWhoWUJZcFN6eUR2Y1Vx?=
 =?utf-8?B?dmNGYXJwZmdxUjArOWhWaDV3c29kcnVBcnhwVkpQb25sSUNEdXZUeFVtdDBw?=
 =?utf-8?B?YXpTUDRDdmRScmVvaFM0MzZSazNLbVo2UjE3dHl0MFVubnB6Q1ZDY1Bib1Ni?=
 =?utf-8?B?Y2NJdUgvRUh2ak5FK1loN25xMEp6ZTFUZDY5N3B2RzBHZmlxazlWMnp1QnBY?=
 =?utf-8?B?QzNINWZoNE1XOFRtZGlPRWlKOXV4UWlsNTVaM0FiSDlwUHNrWTFRSUdUL0Iw?=
 =?utf-8?B?NnZLTVdjMWZZd3paREE1T1RISHgyWnpwL09ERTA1NDJxTm80UUpzdkRNR1N1?=
 =?utf-8?B?eEUxOGV1WGpPclRHcjBUTUlBdEZ4ZjZmeGtrSVlvUHpYZlA0MDFadXlRU0Zz?=
 =?utf-8?B?UG0rYy84MUFOUFlWK0IvTzZyRWI1UkY4NUNBNGpwVGZ0SlpQMVF6V0xGQWlR?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tJcwFwehduJePwWXBeg8TRq+91Kmks9utQVeab47qx0g87jwRbcCawTlvqhxV48gfl8K+L6FB01xWuHVRieeTcpcB9OnJbQxcKMtv4hdcAtf/NmbKZKoKXTa8smZzi+7CR7WavG7j1sRpDQieK8wYDVmVIkZ7GaLVQpPkHvtQj0uabHEEQE1/KZjyV0TbQghKcRuinm6C3tuOlnztNn8d6HaMqtznS1+JMmKFy6+FixZ6Zk/mqCt8lah53hDRwMUuIoSr+f3kCmGYgYCBIdEG1kpMX0HJA4hvmF4OyggqVicr1ayQMLpoIXwHSeDpE11CQgG1nvyNsPvwhwDPzP1Zj5fFUJ+ZKebp3rxzQJABv9bUxvCGQnEqPK2mDBAPDveO5OQMlMx3VH7w5b4sqNnEnFhHTz8tH50mckiqXcAZIht0FEqgFjGMuWCGkyQDHlmJvqKofBF554zV+HzGMBaBCF/dLHwnTzYX7m0bRHnkhdOrHkHVues+4i1HYo+ODNvsZu+C/JN2HDDqM1YWMt9ytIDddq7AmphycDm5WFMajCTmVmxtDbhf7kQIIqXhyGI4FXRwzJg55wZA4AFJyKmR2exTK+xsNk8RjyOtjGb+4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b54a6d-dfc4-4342-e7aa-08dd8b9b5216
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 06:08:57.2242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQ5iWy4cNi1Lmzv+03jMX5PqAKAKYyf0s1GoRT0UNUsCV+ZTYQNYiZGEmFpReMSWbWW52D90MmD2j7TfU1SIGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050055
X-Proofpoint-GUID: 7kLRBq8DsbnieKHUlZH9VqTHIUHcshsJ
X-Authority-Analysis: v=2.4 cv=FMgbx/os c=1 sm=1 tr=0 ts=681855fc b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=dJF-WA3VIcfaQyZ8uXsA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14638
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA1NSBTYWx0ZWRfXy8A8aTf6O0gb EYVVk5LrSN+h054fx4C8rKYfGPe8kMkKzZNYJfva4q7XJEPbcwhUyH8d1wF1pJsSf9pmbyoWQ7v 7v5f0nknDvOZSym2IlDKmYGr1G52cYzAjiWIckVdDmtMzw3XyCar660UxEcIs5Br26sALm/5PcG
 lQRDSGOf66GJR68P7zlEEY6fn75+r7Gl3r1QbW+xkna53IVJK4Cq/3Rdala52A70neycEqKE49L Wu/h7n0ZDHFLNoT3wuDoaRirQJepuXD2/b/xVkN1B2d7Zu/TAoilJH7S/BdRTXFosy2114t5kUW fnPOqqET1DM8ntddVnC+gB+8cyBvySUskgNu2SC4im+qy5LmWy2fGQHv5JFcoiYgmrbipYsx5BM
 l1iSpDW7grYXsE3+Ax4p1gVGdDkmOaGI6244K+TSriMZ9rlEBU956jd+kTfNUvFTCjKL4nMu
X-Proofpoint-ORIG-GUID: 7kLRBq8DsbnieKHUlZH9VqTHIUHcshsJ

On 05/05/2025 06:25, Darrick J. Wong wrote:
> Ok so I even attached the reply to the WRONG VERSION.  Something in
> these changes cause xfs/289 to barf up this UBSAN warning, even on a
> realtime + rtgroups volume:
> 
> [ 1160.539004] ------------[ cut here ]------------
> [ 1160.540701] UBSAN: shift-out-of-bounds in /storage/home/djwong/cdev/work/linux-djw/include/linux/log2.h:67:13
> [ 1160.544597] shift exponent 4294967295 is too large for 64-bit type 'long unsigned int'
> [ 1160.547038] CPU: 3 UID: 0 PID: 288421 Comm: mount Not tainted 6.15.0-rc5-djwx #rc5 PREEMPT(lazy)  6f606c17703b80ffff7378e7041918eca24b3e68
> [ 1160.547045] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-4.module+el8.8.0+21164+ed375313 04/01/2014
> [ 1160.547047] Call Trace:
> [ 1160.547049]  <TASK>
> [ 1160.547051]  dump_stack_lvl+0x4f/0x60
> [ 1160.547060]  __ubsan_handle_shift_out_of_bounds+0x1bc/0x380
> [ 1160.547066]  xfs_set_max_atomic_write_opt.cold+0x22d/0x252 [xfs 1f657532c3dee9b1d567597a31645929273d3283]
> [ 1160.547249]  xfs_mountfs+0xa5c/0xb50 [xfs 1f657532c3dee9b1d567597a31645929273d3283]
> [ 1160.547434]  xfs_fs_fill_super+0x7eb/0xb30 [xfs 1f657532c3dee9b1d567597a31645929273d3283]
> [ 1160.547616]  ? xfs_open_devices+0x240/0x240 [xfs 1f657532c3dee9b1d567597a31645929273d3283]
> [ 1160.547797]  get_tree_bdev_flags+0x132/0x1d0
> [ 1160.547801]  vfs_get_tree+0x17/0xa0
> [ 1160.547803]  path_mount+0x720/0xa80
> [ 1160.547807]  __x64_sys_mount+0x10c/0x140
> [ 1160.547810]  do_syscall_64+0x47/0x100
> [ 1160.547814]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [ 1160.547817] RIP: 0033:0x7fde55d62e0a
> [ 1160.547820] Code: 48 8b 0d f9 7f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c6 7f 0c 00 f7 d8 64 89 01 48
> [ 1160.547823] RSP: 002b:00007fff11920ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> [ 1160.547826] RAX: ffffffffffffffda RBX: 0000556a10cd1de0 RCX: 00007fde55d62e0a
> [ 1160.547828] RDX: 0000556a10cd2010 RSI: 0000556a10cd2090 RDI: 0000556a10ce2590
> [ 1160.547829] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fff11920d50
> [ 1160.547830] R10: 0000000000000000 R11: 0000000000000246 R12: 0000556a10ce2590
> [ 1160.547832] R13: 0000556a10cd2010 R14: 00007fde55eca264 R15: 0000556a10cd1ef8
> [ 1160.547834]  </TASK>
> [ 1160.547835] ---[ end trace ]---
> 
> John, can you please figure this one out, seeing as it's 10:30pm on
> Sunday night here?

I'll check it

thanks for your effort

I have known some ubsan red herrings
- I hope that this is not one of them ..

