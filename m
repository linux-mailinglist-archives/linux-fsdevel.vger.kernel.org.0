Return-Path: <linux-fsdevel+bounces-69218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C8CC737C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 11:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A45FD352A9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 10:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9607332D0DE;
	Thu, 20 Nov 2025 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VcOY+DXi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JOM/R1g0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6825785E;
	Thu, 20 Nov 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763635029; cv=fail; b=M53sd0xlF/kDQy9vl/MobxbXb7BjI0oeMmmC3QdWZAw/DJhDvqTm3G//qr3LqerFZZ+/kJI9Hksr0ccp7rrcaqd7lLAjOmZkGDLjpYXYYE+C1aLbH0LwHCoW/6I9uhCr1+gnUQqkhnRr+qlWHO4B+vdDxtiJTA08LJBtQZF00wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763635029; c=relaxed/simple;
	bh=EqZD3kM/f0fxFrifHsQGVJWjJvq+iDW6UAmXHXuJ0pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bYdTlHQS2T6z4uM6Ti21HgTc0voEgIjJgkPXaTyvieHzo2EhdRYJRFMnD+exioI5Ggv/VVHI4RTTOwnAjvqSoZpG5I6GnSzZbhCX8EYbSbszgA5IHsnYNRCCNaBx3vimlzcBZNUyvwlasjMmHdfca7KELjVX9UyoM/FntUa7ayc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VcOY+DXi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JOM/R1g0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK9ppkY002026;
	Thu, 20 Nov 2025 10:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=smcfSimr5A6yvY7PNE
	GX9hmkNvVxO8Q7mYfSlVN3Mtc=; b=VcOY+DXiYbEhQ+xT1e5HQjSDT3juA7RaOo
	MFwJk95MVRODBJ3WwneiZgbauWjBEBg4dYNNykFwJpI791em34T+RoqbDg5B1ERv
	ik8ZB15llTuZ7V/TlpGDKOYB2bRy48oXffkj0tp5dTZm0ZHgSD0BZDc3fdzdhony
	k8XW0g6qMxYOm8P1GYeaW8AZCFouOwcXPMHbnfPoffjNZLG79citU7CnNpeW6PSm
	Y5DNdswxsG49O3qAgVRY5sB//awlxgjU+RteY7CyQ1n5EiZ2N/ILTln0YI7sHn0Q
	gl1xM2wnSG/17HFZIuyO/5p8wluMd/QQiEcQ50gayiaVfDd0GPSg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd1gs6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 10:36:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK9aE0H040040;
	Thu, 20 Nov 2025 10:36:21 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyp6ad6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 10:36:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYBZMfTX6zMc1NQ3J7CfV07igLMuJdPJnXspEMMedT3YOKCf++TDyE/8irf0deKaoHGU6kbOgsCvH8UHf9UjUX9E5pLLsCFyUS6DHxxM4IuQOaTJULCUZRsbSpJZVwLlvu7mY2Uqvh+WnxuAvV+q+KLbHLaB0XuLPBJngq1Gm21yWhyvj2n0C2YqzqM+elXkw+/Tp6V1FmWnpCdW9bt0pYD5GUwvuYrxT9mXBesF32hv5l5gDC6622HZmVxJO9XskDfw78SXh149K0rWrTGU579GCZ5M3Af/U/mCDOFnJqKrpkehE4DWOSXtq1K3h2kDqjL4R+Ktc1DaPlpeUENNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smcfSimr5A6yvY7PNEGX9hmkNvVxO8Q7mYfSlVN3Mtc=;
 b=TjmaMNFWPPugxe+O5+4yFztnoIqo+8EM4tjstWd1TCQln930patSSw/IA40Vo0vz4252ncWHNbBlOOeomgivZSWZDFalJCPkZwhpYny0J5PJ5W+GNfqGAB9sRaUZ2GSo587qcKdmiDzpQ9oWRfaT3sjzM9mKffvWIp5x35mIb8r9/V7jWhlAmafPLHEmH53jTZarklcSHZMRRmptjmVWTQ/9qCpz9EZO0LdZNKlhV8hhB2ZPaPJEsQIGCBaeLo+P1ShLJfSyt+6j951UyvpTMAyjvCUDusKvTYDxJ+8puVXAz9MSnl7UUePWUzCq7lOoBONFMygXspDUjt/7K0YOyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smcfSimr5A6yvY7PNEGX9hmkNvVxO8Q7mYfSlVN3Mtc=;
 b=JOM/R1g0A9hC2xBdR+crfmFbcyai3aqR9+cfY5Ot8HkDXoDCaWmBgUnbL4zTbOlcFfHWS2+Ofs0YpDcO0hmwT2FoS+dt2K8+9iBtW89BZBWXqUYTVzeo50hXF+bEnGQkB1uHSDgMlrEGaLHIBkJDl5BCGLVCo/XEtDYpLrCGoP0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF00080FB4B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 10:36:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 10:36:18 +0000
Date: Thu, 20 Nov 2025 10:36:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Hildenbrand <david@redhat.com>, Dennis Zhou <dennis@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
        Yuanchu Xie <yuanchu@google.com>
Subject: Re: [PATCH 39/44] mm: use min() instead of min_t()
Message-ID: <0c264126-b7ff-4509-93a6-582d928769ea@lucifer.local>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-40-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119224140.8616-40-david.laight.linux@gmail.com>
X-ClientProxiedBy: LO4P123CA0369.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF00080FB4B:EE_
X-MS-Office365-Filtering-Correlation-Id: f227664f-a5d1-4b27-5d79-08de2820a3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5S8GlUofaaICziy8pQW7752XjhzXy8tNeEykevsfnSjw9ryVqpP8B6zvUhMp?=
 =?us-ascii?Q?T7fy77IjIgpU5IAw+1niw5BIOs1dnjxLojGy+d0QxUbNFd+9xudjXodxvNzG?=
 =?us-ascii?Q?1Ur/OMeAPwfhXq1cEDAQcNiR/u2QkI/NUoSkCjJz+NXhPjQGjHJUk3LD2Wio?=
 =?us-ascii?Q?LvuBFQ02B8Xpvzd7M+cPevK5PrNsR+Pz/eki4JEtAIUF5dP/TqEmGR1jKksR?=
 =?us-ascii?Q?eJ3xFEufpd2bERwMMaRpaH/IKHfn6ZSfh4N4pIH4Gy9ldp1P/UXri1lzLnFx?=
 =?us-ascii?Q?9fiRAVFXphr+yh3w5bb3qFraLUkMVDH8IjxziAM4Ck9PE8/aEa0wxhVtmPiC?=
 =?us-ascii?Q?i8WYoBMxBexzjFErJxdD+NxbnANyGkNejRZHfedaVA/OqhrqtYWJII0CPiPB?=
 =?us-ascii?Q?NlEPlulMzd+EF9adLhcYgxQGJ2tjzQRHc7IKz064hD+ODBDWiHLzxTWV+JRb?=
 =?us-ascii?Q?SLmMrSLAJ6DQKx9ZlzJxzU8F/V+0zWruvl4cpYG6xky2gTpBGrJIxfBUHKx4?=
 =?us-ascii?Q?jH3OYEvLCA1auHP4t1MkIlnXu7YFL2f0jjCkVzJyK/BqOXuF7k9bKaXiZYAo?=
 =?us-ascii?Q?R8eDW+hdq6Ny5VboslPCEJ4JkCod3jgxsbo6tusK0EcU2Am1TgvZVuTlkGGG?=
 =?us-ascii?Q?8isg5SoCZ3pqi3BdWL9N2isXB3XmvCznJNmygGSmzf9cthnjVwf17CfGpA66?=
 =?us-ascii?Q?iVLtH88jvtN8+7mYS9R0VsFI90tknIvX/yGDRsporhzPaRSPavco0P3T1roR?=
 =?us-ascii?Q?nIoZmbKmGXA1o2xZ/7Dff+jXyWNw4MBwTUSdb3c8LVBWCQkq8c//dZgjE2o6?=
 =?us-ascii?Q?5fwLoDKlMsVJyCjMMOocaUabw96WmQfdC8MfyNhXBTsojDW/kk+XwO9+Oa4w?=
 =?us-ascii?Q?/MCceMGidVsY/o+ofV0givYtKQAdORhwXMdMsrICWvQ7ROjb8FZV+RZaDVi2?=
 =?us-ascii?Q?Xu2NbaNl21bK+7gdqL+cnbPmwH23Nw1HEbl/5ivvB5h+CTFgnz7L4IwHX2QZ?=
 =?us-ascii?Q?PDoAm2YXiKW1Si1jJM1JfszRaJCdqwQwVfoa5DYILabA4o3ad95xYLH3bZgg?=
 =?us-ascii?Q?fKsPhCw39fdRAhJ414UVmETd/Dajd9DNtFOX0N8nKclogtOfpD6P2BOmKwBf?=
 =?us-ascii?Q?cBLxtbfFvsX9Ek3WY/PW4LfjcXtpypNUKbHn57eyBem+lEF6UyG+aKjPqYRd?=
 =?us-ascii?Q?DK1Pv3rdk+EvVeNTg7Q5YHOBi/d8S8IcYGZgjja7lFiy98lY4NLktA4PQdMe?=
 =?us-ascii?Q?Oo3hlwLEclifv0brybJ1RgcLcDPV7l/jmxnRus3fsWh1mOuiURMorC2ow6JZ?=
 =?us-ascii?Q?WhvGN1tLBPej7WvEkVu+xCIQ52lmWjETeHpmqb1salbXIRGwptjZGOTIBhVt?=
 =?us-ascii?Q?QQSbHmhX8EIUrTSf9VKQEuqiO0dtbrk4pXUegDrjfQn3VKCTS/sUbVcZ1Y1p?=
 =?us-ascii?Q?VlKXDoEKYKRizjU25wP6ODQ9dzmeZY+0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wut3NamvdHmw2Fq4zdS+5Sq4bIYizKxaV01jmIUAbtaR328ouraxDykD2AO5?=
 =?us-ascii?Q?2zqMncAvBXI2CA4stmj/ioQtAoam46HGGkAS+su2Cub3fk39XE5YjFXUp4zO?=
 =?us-ascii?Q?c0q11FkvuXjS8NBYmokHRI0ex2wKPHhm+a7Zah65OK+rlnCw5XI0QM+wtx53?=
 =?us-ascii?Q?9zc5odOpAjNVY3pGDM85A9rKis+T6ifh5RuNRfO/waMmDcvnpPBNrm5/yDTe?=
 =?us-ascii?Q?n89Vjmfw1ldXpnEdUc0Ja88UXDJrzCmREbvIpnuPahHRTCAupJiw8EM5QCyJ?=
 =?us-ascii?Q?QF49lHrYVF23OwAbp2Ll+uo+liNoL7Iuq8ejuTxTSykEJ1p3oUE4WRT2mwoQ?=
 =?us-ascii?Q?uVqyche6P1sXQSh+iE0fKf9Ot32HvKI14sprp/EPgxBjLqqq8VF7pwwSy5Cz?=
 =?us-ascii?Q?QOFMvMt1HFPHdWIAu4gCORVu9AuxI9kjDS2LvmuCVmBfFXFKu2qsGQyrIbjR?=
 =?us-ascii?Q?0uj307ltn9oNHYUIrgKcp7nR+0YuLIaBof2PzIcx7P1vSLHVryy6CCjNnpgE?=
 =?us-ascii?Q?t3AeoH+7A3xehKXIlsjPphGpThB4DvLw77yUV+bWnq+Ci6lzrgyqWerw5vDt?=
 =?us-ascii?Q?UOjz6WdU/ZRQyfYCEQX0KS8fZv09Wkm8UxWBMvr1MdqHZJOjlizHcTGpiGF3?=
 =?us-ascii?Q?tQOkcACCulI4nWYyVEd42KJOqvc4BCl8ypBoqHmcotSrhuxRkpJDqA/zebXO?=
 =?us-ascii?Q?WO1S33X6s8AFKA8TMX45taARu54C0Scuw534pLiQwRJ02Vpb19vrUd/ct/xQ?=
 =?us-ascii?Q?NbP/ADbMpVvEjHGhoMC7YOMwXV1xglbQT8AjYzU8NMGZ12TSDN5J5r5tZ0QO?=
 =?us-ascii?Q?1MJotjA1UOMZGnDV2fIixKcax9t/vl6DaFEoYwMJOsAjiClr54u7vV2nqgaV?=
 =?us-ascii?Q?7IkEdL/ZkZa1smI67KPffB8XIBzd9HfCAspIqpIVcHH06njSpZmO76Fw41E6?=
 =?us-ascii?Q?tm+dTyv/ukRVs3r2KBWXMzm36ulX8/147B5lx9Yl6tjZPNGqcNmtRHIb1+HU?=
 =?us-ascii?Q?rYu6RUSS1oDdyoEWrgB3XOBT7Y2W6pJkYOKwGVE90rXiICKaoUmF+st6Gaaz?=
 =?us-ascii?Q?JUKS4svxAqicI8fmWdEUGw19/gYcKQl0RHjcjR5TwQHsTbMhS5gwqyI2N7D7?=
 =?us-ascii?Q?2Bx3a2IR80/gKgYQVj5+F56jwL57m8i4lCSUb9fZN/2SSsv3TkR7+uIQtytk?=
 =?us-ascii?Q?LbZ/a3ZpFaZWUDOwHmEpgn/j9myWV3eeLbgAJhXoc994N7eC94usSZV/YB9K?=
 =?us-ascii?Q?/OeYN756hc/PfFJpCaFPcYzJ+dc6GgMa/67/IGXpRaYDRFZO6gXS2ShtNvh8?=
 =?us-ascii?Q?64I5bQ30xmBEc43fM1SKL0jVam7+CvvAu8bYerZ6JlCfNGWknUFZyXmaYIwe?=
 =?us-ascii?Q?ktHCT6FbYXJASwVc7MNGfA5MEo6NdvoOWuGnP4EdU4gNs+Chx1TwwP3mLhN3?=
 =?us-ascii?Q?mQUKt4Enzk1+njhd7nKEA2Ak18OoMLjeNSXYcZxX4qfR+VzVtaVk6NEYIUH8?=
 =?us-ascii?Q?0J1936Z6tAFU2GQAgOhnhs6C6ldJj0IFbFVEYbIMeT+MUFzk2sE2IlnTBlAh?=
 =?us-ascii?Q?R5LNyR1Tkvu6PW81RRg8wGyd7mEncQyZVAWWaKKZPPWstvUYrjHB1MO5QjbO?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dTCZwfwxj5qmLcClFyLLF/KbkfuMNb3ru4QwfDHg7pEaHAcN+uEO4G+8yji1oxQJYYJ700rL/j+teXjhNJpyU/APDZgUPP1sUh/YUdWn6PBMHR+dQbBgjfV8BzWTtyf2MM6FFkY5VogF8iV7kGG2Hg/5S2AqBcjijIswH9hSfDnvsH2yCcf0su9gJGFBtbLGtYzbdvs4chgKZvASCgGf1xm6nYLmlDyNajhSG3exHegZQbbGr4PmdVEND+XxFyK0/3br/Bkooe9pegnF9SV8JEH3RNeZ24t6gnC0+O90aGY4Z0Xy4AaUChKCNzPCzLZHvdD7EzjOfxV9WUIqanvak9rSUiDEuGwxDWO0IcQqGPkGNvmQc8/7x+hWp3uu41CpY1Ipt5sn/uSft1DHPUUqYhw7PTJqlQEIqFoZdKgi1VchRaBSBZLzr+NiuixV6a2JlNS2VhNxM2SvZkT0rtSM6VwV9BtuhfM7lTSUVcJr3gSaIalDI7pYDCkyyuSV7Wi9WLbVGnlgXitPhDheCy4FZQMp0obyEPmmeuZpS0wDSQRh2hSnM3ZCjlF9RUooTLQwyf1MX+GKR0nzxQQwQFWYzaDcnkoqagjde/C4LkQzxZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f227664f-a5d1-4b27-5d79-08de2820a3bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 10:36:18.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ip6us7itPcb0D28AyHg23a0ZCMdIIaaBh32c8ybLLVFo7gQASMP66y1FLuzI9uQxz736AJY9/g/bjGyAiXXmatH9hA7gYOwkZf5Fywclm6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF00080FB4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511200065
X-Proofpoint-GUID: cVyTduszgoY4t2-t7ttjYs2otqXRqbhV
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=691eef3b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=gCOPDTlD07IcCmHoYNIA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX3Cr3w0b7udt8
 YP22vdyBYKYgGIhPhtuApOvEH0rmmxequ0rTpQRQWgK9SCumRczDwfR1pctsKaiCwShaH6ORS5f
 ngIlJX2MpvC3Kgi1FfIlmCVzSLlFCkp+RQXG4tWSuIAgEW0uhstkBUkE1wEcEAZAS1XtwPS3QM1
 M6CuWpYr8qYAv0tSwWhNxfn+MHb3hTBjzt0ZShOryH27rYW0xfhO26Mt5+MYVt/KIW4KEIE3jWW
 t707Xepmp7OZ6/cCyoexRyvF61QibPCpB7YQDP09p/iJYhU5ienwBD9Iq/zPcUm2Oh3IJgQgCb0
 Nm4CcMZaQMLliIpMkd/3b3dNTj1AvBP0SnIk6ljAcNmqt3Uadh48ExYKGgIBanlsmZN5wQHoGw7
 PQjxySj1JHrLMiiAyGskRtJ8YXjiz3iKCEzVIztt8CmrZmucrwU=
X-Proofpoint-ORIG-GUID: cVyTduszgoY4t2-t7ttjYs2otqXRqbhV

I guess you decided to drop all reviewers for the series...?

I do wonder what the aversion to sending to more people is, email for review is
flawed but I don't think it's problematic to ensure that people signed up to
review everything for maintained files are cc'd...

On Wed, Nov 19, 2025 at 10:41:35PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
>
> min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> and so cannot discard significant bits.

you're changing min_t(int, ...) too? This commit message seems incomplete as a
result.

None of the changes you make here seem to have any bearing on reality, so I
think the commit message should reflect that this is an entirely pedantic change
for the sake of satisfying a check you feel will reveal actual bugs in the
future or something?

Commit messages should include actual motivation rather than a theoretical one.

>
> In this case the 'unsigned long' values are small enough that the result
> is ok.
>
> (Similarly for clamp_t().)
>
> Detected by an extra check added to min_t().

In general I really question the value of the check when basically every use
here is pointless...?

I guess idea is in future it'll catch some real cases right?

Is this check implemented in this series at all? Because presumably with the
cover letter saying you couldn't fix the CFS code etc. you aren't? So it's just
laying the groundwork for this?

>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  mm/gup.c      | 4 ++--
>  mm/memblock.c | 2 +-
>  mm/memory.c   | 2 +-
>  mm/percpu.c   | 2 +-
>  mm/truncate.c | 3 +--
>  mm/vmscan.c   | 2 +-
>  6 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index a8ba5112e4d0..55435b90dcc3 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -237,8 +237,8 @@ static inline struct folio *gup_folio_range_next(struct page *start,
>  	unsigned int nr = 1;
>
>  	if (folio_test_large(folio))
> -		nr = min_t(unsigned int, npages - i,
> -			   folio_nr_pages(folio) - folio_page_idx(folio, next));
> +		nr = min(npages - i,
> +			 folio_nr_pages(folio) - folio_page_idx(folio, next));

There's no cases where any of these would discard significant bits. But we
ultimately cast to unisnged int anyway (nr) so not sure this achieves anything.

But at the same time I guess no harm.

>
>  	*ntails = nr;
>  	return folio;
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e23e16618e9b..19b491d39002 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2208,7 +2208,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
>  		 * the case.
>  		 */
>  		if (start)
> -			order = min_t(int, MAX_PAGE_ORDER, __ffs(start));
> +			order = min(MAX_PAGE_ORDER, __ffs(start));

I guess this would already be defaulting to int anyway.

>  		else
>  			order = MAX_PAGE_ORDER;
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 74b45e258323..72f7bd71d65f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2375,7 +2375,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
>
>  	while (pages_to_write_in_pmd) {
>  		int pte_idx = 0;
> -		const int batch_size = min_t(int, pages_to_write_in_pmd, 8);
> +		const int batch_size = min(pages_to_write_in_pmd, 8);

Feels like there's just a mistake in pages_to_write_in_pmd being unsigned long?

Again I guess correct because we're not going to even come close to ulong64
issues with a count of pages to write.

>
>  		start_pte = pte_offset_map_lock(mm, pmd, addr, &pte_lock);
>  		if (!start_pte) {
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 81462ce5866e..cad59221d298 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1228,7 +1228,7 @@ static int pcpu_alloc_area(struct pcpu_chunk *chunk, int alloc_bits,
>  	/*
>  	 * Search to find a fit.
>  	 */
> -	end = min_t(int, start + alloc_bits + PCPU_BITMAP_BLOCK_BITS,
> +	end = umin(start + alloc_bits + PCPU_BITMAP_BLOCK_BITS,
>  		    pcpu_chunk_map_bits(chunk));

Is it really that useful to use umin() here? I mean in examples above all the
values would be positive too. Seems strange to use umin() when everything involves an int?

>  	bit_off = pcpu_find_zero_area(chunk->alloc_map, end, start, alloc_bits,
>  				      align_mask, &area_off, &area_bits);
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 91eb92a5ce4f..7a56372d39a3 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -849,8 +849,7 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
>  		unsigned int offset, end;
>
>  		offset = from - folio_pos(folio);
> -		end = min_t(unsigned int, to - folio_pos(folio),
> -			    folio_size(folio));
> +		end = umin(to - folio_pos(folio), folio_size(folio));

Again confused about why we choose to use umin() here...

min(loff_t - loff_t, size_t)

so min(long long, unsigned long)

And I guess based on fact we don't expect delta between from and folio start to
be larger than a max folio size.

So probably fine.

>  		folio_zero_segment(folio, offset, end);
>  	}
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b2fc8b626d3d..82cd99a5d843 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3489,7 +3489,7 @@ static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
>
>  static bool suitable_to_scan(int total, int young)
>  {
> -	int n = clamp_t(int, cache_line_size() / sizeof(pte_t), 2, 8);
> +	int n = clamp(cache_line_size() / sizeof(pte_t), 2, 8);

int, size_t (but a size_t way < INT_MAX), int, int

So seems fine.

>
>  	/* suitable if the average number of young PTEs per cacheline is >=1 */
>  	return young * n >= total;
> --
> 2.39.5
>

Generally the changes look to be correct but pointless.

