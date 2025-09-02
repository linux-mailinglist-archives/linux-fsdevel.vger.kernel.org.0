Return-Path: <linux-fsdevel+bounces-59936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E37AB3F514
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0358D1A80FD5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 06:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4C72E2DDC;
	Tue,  2 Sep 2025 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DInE44yQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IKS+XYZa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD62E2850
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793647; cv=fail; b=JkiBKZTe8G4S6qaOD+iO0hIKP3WPaoJuY+YPUDvTDWXaBnDx2DZLgznst4mop4R+NhaiM177jPCDSpbl+VEOb1acnNuJiutF6CabGjIkLQzcM2DZvoog4Kpe0xJeBQEiw9qOSJLCs3aRZzNoQVugBKUzd3hrlgXHSmA5BqBI910=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793647; c=relaxed/simple;
	bh=laVH1KC1eS1BxX3JyAbSY7gewg/ATBFDEwmR6toEqz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZOZjsZbdVKjAWFVst8qnr6nFENUdP0xW3RhtS0c+sguG539i4l+Drow9TXAJFyAR+dfSNI0FowTtBvHjtYJekjw6ranQup5PjW4UK0iitK776lHfflEicDYTK1IoZ8Csw5Ay9M9dAu4h63V5yrw2QouOwU1yijF8MWbVEupgAu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DInE44yQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IKS+XYZa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5824glic007980;
	Tue, 2 Sep 2025 06:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ciBIt8Tabar2p/e36o
	i1QXKIQAjf80VQCZUWruqO1QI=; b=DInE44yQJ02wgCyUAF3kwOK8yGE+f1z9YC
	SIoXoXUrwwbWaP7n1+432IGK1pqlFWCInXajYlRjNzTHJh2aAOK7bC4LAxyWYqFv
	bed0Xc61PtPVI2rpKOlun3XSOXCaBKDvftfzZWAg6Nuxln/g8Gg4Zr5ac9SUo1C3
	ArxH35tNm/lqd8Dl4UtX/6j6GB07QMZ2WaLUupubKo3CX2M0iyx6pa9Y1XE2+wSt
	J+y6X+F1kj2hetp1JMRJPQ/g+A5pt7+0OJNkTe+rk2uUWbdlI56g+ScpPXvqBtf5
	bv8omH/SAxnQjuKfV0+ui/+thGfZnq5UC1ujnza9GOpbiTJRNLxQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48v8p4js2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:14:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5826BKu6024849;
	Tue, 2 Sep 2025 06:14:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr8evts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:14:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyUTac66S8HdMzDYL7M166xJ84iVOiVZ1sckhVb89Nlo7qKfcr3OC+EiKypMXhRxGWBOt+gnQNxmMvKJztMmyrP1whRO24IWrA6Oaewuc+f6dffwX3t222JCvZ+TOi2o8564WKGt8Fash3R94wO6L5d0y7Sxai/tXt87nSZlCJZtuqvfqb0BU87ncTDhxjf94CiYd81g0JwjUd4+CHT7IffxxMUaxY7cThdnWfH+EppYzh+jUn5wRwINFvzn2bIeh4H9Rb6h78Ya2u23Ecxh9cN0gW+4TarCs3QYErHRDm3GZH3CoSMz5N+6tEdumTGgZf0giI+hrLVXgRtgnv1Odg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciBIt8Tabar2p/e36oi1QXKIQAjf80VQCZUWruqO1QI=;
 b=eWM+s+JgTnJJgFhSFdGiPKQBARl8KGiMfo51tjhGocEzkaFzwRblXNNA/qa3C1xpw+JElFEgJbSVH95qKKw4jmgCX7rPVQ7nb/D1hL14/q6gZhMRcaDMvkmJS5sKmOYlPtbxHKt/wEZqHYJIAqJdiFYaan+L9/9dy5Xwa35QfRF86J4Slw/giDb/DpqyzWiBvW8A2FeEF7IstlmT4e1d0sEjs2mMomsdsImVzUaXIr+6yM7oXMaEfuuXmXRvw6Xb2C/cEw6P7Ur6x1pelJjM3AtP3aVnEXKYaSycPs4BKXrfkSiOP197WY5wyk7I6ZZm8zwN7frwmC1Dqxr11j67fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciBIt8Tabar2p/e36oi1QXKIQAjf80VQCZUWruqO1QI=;
 b=IKS+XYZa6BKrRoAT0KASSALjWeeiHyF/hiHBetvyVsY6nYqt3HJuP/gf5ykBklEVqhWdkY+guGbfCGcR8aebOjden753OIut45oZcTkamVYpI1D8Hh+ROQ+bD+MGuXxfNTPwDcFlDcTjLv0y7X6ffN+wiFxo32f1yLZ45uE0Yoc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6192.namprd10.prod.outlook.com (2603:10b6:930:30::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:13:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:13:58 +0000
Date: Tue, 2 Sep 2025 07:13:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 07/12] parisc: constify mmap_upper_limit() parameter
Message-ID: <d149c0e1-e814-4ba4-8f99-39ac2f3ab761@lucifer.local>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
 <20250901205021.3573313-8-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901205021.3573313-8-max.kellermann@ionos.com>
X-ClientProxiedBy: LO2P265CA0492.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7be702-b48e-41b1-0172-08dde9e7e775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qCAFefxmzxUO3KaKRB8X9OHqB0JW+jxYgOGiKAFuEDWW204eYvt1tO8qO0NN?=
 =?us-ascii?Q?J/+eKvp2K2S5/8e6EASNkKBveRlMWXePquZa+44xO9IsG5/A8IoZP/0Vttbf?=
 =?us-ascii?Q?ayNMJeboQn9tFB3pHQ9xPtbV2H/0brrf16A1uVbNYljULPaQjRSnLdOdoU0f?=
 =?us-ascii?Q?IStc11iE+pNiRsNEJw066yPxD/w9wQGlWk34twtJF7dEfjYq3v2YceXIckzP?=
 =?us-ascii?Q?SQNtypvAa09KP9+EkpwM4hpoWyBIBSrVYlQPpGaWHQFp7dF+QQ1G6QXQT594?=
 =?us-ascii?Q?zceQfrGNSpDExYTi17UK0Tw8D//uIVWVB8MeL7NAK9UX+Fw0Is0f/IXX0tA5?=
 =?us-ascii?Q?m+S2oEidg1WH+G5Impk+Dh+ERfbz0XEUA2iJv0OSdvRSea2X3GGsVecPkbWe?=
 =?us-ascii?Q?KgFYFhXQpgiNItw2QAHdDUkd7ZU//+vWRwMcu79Q2IkDFErkEo3eDh6nqDhK?=
 =?us-ascii?Q?Fwr+BMfaFhxFT0VmgKoKQ8bvXX4duW4Gi9+uF3ckpNc0IrW7leuoknZ/Enil?=
 =?us-ascii?Q?cce8kFoGzM2B802Q6LkWTfpTo1t2w3SOmQcQ/REbvd/xm/MQNndD1uQykoBU?=
 =?us-ascii?Q?SgRHp4tqkE/tFDbUnydvERfxdg42/IPbvOzaWWoeeGis+NUf42YK6vtZL1k0?=
 =?us-ascii?Q?eS0fbyaUYCn+bHFVmOUs0DLry6BTAFLxmqSXMYj0crQBZFBFfWj1j/0wGKub?=
 =?us-ascii?Q?QJ3IGFuBrn90tIQvV9fe4uBRksNg839D77g4C1AlVhJa6D4FsFLJo+TKeY4N?=
 =?us-ascii?Q?EHSCofLJS6OXZBmzWyEVX1g1koCn6/2EjnRC5loxkVRux3BGu2nOTcVzwtsw?=
 =?us-ascii?Q?WCxcnhIfkzBHQ/clQvuGiik7Md7QrDDvuF0TEmOC8wnMwk0oYzSohBqztD+4?=
 =?us-ascii?Q?00CRqQZnSuy64fNCInS1tBrmXY+H0dBKIypmA5UqglHARGqdDlddRSDCs26v?=
 =?us-ascii?Q?eolxNr8HOpYawzqdaeemFYUfIc8Oju/Msqx4oJZ886goR7qm3rNnwm1p3nAW?=
 =?us-ascii?Q?QQuYOKu4+v/pheipi4IvaU9K8tdf0AmtVNMpu4gzvl+JY9q3g9cXUfyRIRpU?=
 =?us-ascii?Q?2s+ZRddH6NQjiW4CzzuGi6LAfLegCWftEc2vO3ctWnmsqRK45RAPyo5bjIlA?=
 =?us-ascii?Q?VCYtOWFWNw+wiIxORkyJWXli4QViWL+UKYuZmxLywPt7fhTcvUAx7QZ9Sx7Y?=
 =?us-ascii?Q?8q9iSawxIjrEHH+sLCcKTLux4vFjLNvXWzt/cmZEN3kWSpe+x5lhMdPEQ52S?=
 =?us-ascii?Q?ZD+i72I5t0urAPbEEzNKhyWkqfhic64w8Ysw8YkwbZTy0RP+yytLNUqsOQxO?=
 =?us-ascii?Q?Rbwz4vPSJh9dJUjaDkhm6+//HR853yeJuA30gSfvzYuSyNHp6UWs3DG5kuJa?=
 =?us-ascii?Q?8WgIH6+DdeUeaWRm5zXjfKba6n0nID2Z4nPzozkme+e6nKT5TvtVd0LsxXlT?=
 =?us-ascii?Q?0xKXcBSubGY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vdkz0FXlCOJO+TiwwhHmtNmTv2VXj9q/SpSlEwq6WyBuAe8SMA3053AH8Or8?=
 =?us-ascii?Q?1Gv26aT5h0JVwhhgiTcGNc+8wKBFjZZIEimoHosiur2d62zky4We9hOuN1P6?=
 =?us-ascii?Q?sWhZGYaxCo68oh7J5N9+O5su/JvaXjUuXEgvgQ22GPLK8XoRizyMac3sfw4M?=
 =?us-ascii?Q?synXQEX+h3ITxXKqv1Y6XwdXhJrxQqOCPAAmpRkt9lMnv0XOkyCLWEGcaBst?=
 =?us-ascii?Q?yKX4Pb+0ndKzI5oEa5MjXGrjPismbaKV5RmwVUbzPizpXaI0na1oYGSy5CqE?=
 =?us-ascii?Q?ncoV3s4Xx7R9e5dTab6ny/5tcM2MqJky22q96dvTo/hPSatsi7SqEAcTda9C?=
 =?us-ascii?Q?SpRZGR+oyoJCnVu501Sr3WOGidkm2uA1KwBGmTzbUA5fVIIgsZq7TElhf+yO?=
 =?us-ascii?Q?5xVinYgpy7/ggSxFO5SydscbU0zBXQD4PVjpcTOl+msK7TGqmyxYZ7vhILHo?=
 =?us-ascii?Q?ner54tjCVk9Imu0MCZImq0jsyKPI06JBK7GY9opg0+twNCpalr69WTp+r0gq?=
 =?us-ascii?Q?anabUi2J8tVqzvUR4EGfzGiGajddoewgJ7qtUsHqtJvAcw5nXD4VGfLkozOn?=
 =?us-ascii?Q?4R7BqY8v26alRq2HzpkQioRtmj+Bg79iA/xK93QI6NeiyLkAcBqOm4RosWRZ?=
 =?us-ascii?Q?KgY/DW784Oqyk0wi6ypr5PUy5QGVFfLt10J5QXfG1XMj++cQpvBsRvsZ2rHZ?=
 =?us-ascii?Q?Feb6v4PPjB7mVOfyN0FrjIvEUFw3Z0NWNx/TlZQ+iTwLJ3H4UXicYp6bMjd+?=
 =?us-ascii?Q?V0ZgR5VxLGJI7oonfLVNOVvf5UUXCEF6E/HOT7EOZar0jA1nAygOLyDG4SrJ?=
 =?us-ascii?Q?TfkLOAhGmsSQLOBWBQYL1u7X/mOEhMY06WUbF9jcfG9Vi20+mMRDYHwlsT8m?=
 =?us-ascii?Q?1aXzF8lWjlZzkfBmS+mVKh+8CFCY3sFeTEfrIzuwhVnFuI/9Cx3UYaPiWpkt?=
 =?us-ascii?Q?fi5ztFrIQw57IShLFFm2RvDJhqiV8JZxcVE3Dm4WO7P27DE4pYW4OivCuDnF?=
 =?us-ascii?Q?aaQW9IwcCjCnGoVQIIdNwdO1wl20cfvACxP4U8JMmyHfWr8yA40k7+J5hcnK?=
 =?us-ascii?Q?PXzfO3ml6KKtEdNK+GLclz6GwxX2xt/qJJOSDPXQqo0Xvv7noTm2/Td8X16a?=
 =?us-ascii?Q?kvCe5r3ShDY9371kRzQt6/FP5uBnZ/h3dPmXQRXecUyprwlqyPDIPb+YQpru?=
 =?us-ascii?Q?vlGC3wOuU3lJuhW1jO6aAsFLEwml7g3mezs+zUs+s+CBPg65KCOieyTOeiCS?=
 =?us-ascii?Q?IbiipoKPTYCnlFMcPmvO5NoKkfTQv7fbrbdEiYofCgP1C36q4C9FDfyh8llk?=
 =?us-ascii?Q?4c3iOLxVDg7xD6huidadaaNoCuRMleFnnFG9OoA4+43mSJoZ3f+WlN5xhYmb?=
 =?us-ascii?Q?J4QtoabnPsCzSqOAbN8oyWmPE8HMaUU24S+LtslIL/OHD/zc/XmtrbviMQ9N?=
 =?us-ascii?Q?gMM2hCHg/2xKM/fkPCy4oqVvjg9epw+oxHCvQdtikH+bQpYj4XIHUiz+/xQM?=
 =?us-ascii?Q?a0oUQlEKz5cfvMglluGMmNe1prdA2AccYToKBQaqMDLZcFB0NhCvgRZh97TT?=
 =?us-ascii?Q?rANNr7MOgeX/+KQYeHWK5U8p+U8ky4yS2/hePlgXrrciTlRqSCWXUzlSjAYW?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0CLCpGEPEbqSiqXwhQI09bjDBSKOTXbv/ueaqFuXmjzuF6SMB9u3ZSfYAhFIogk2B9s8msif1UXNl5lFoXZHz8X9rd7SaCfTFo1O7HVKIq8toqGqAVfDip/QEkudbKt94K0pjv3is/xmhEVYfQyJXebKwfTCgR4mhmDVTTqSogjQcpDtO6ImbIPfcD/rkSRk09qAu+De8+c3c4YOYoJ4CUotPyT0RNqaK4eZsSHIYcfT6BTu0iUy87D2NuJtnuP0XIPmh8IrF13pLCIOTJLJCc5WQS1vobLli7m16A9w3vcNIz4cvuji5C4N+1ceoVmBsz1lMY2gyo3R7e5Ge/tA5oM8wWzCiezZgR/7KIEZdnW4YqEQdEocWCnU2opsQkQMhV2J1ikJj9oEQGgxLmAfU3a1CP5kPjqNv7jJgXS6KomB/J578y9MGj0WBQ0/hNDpGT9bN81fttDfY53W2xjZu8QVqfxQxYL6mNXqXK9Ebwx4WwHk92BaG/cVuw26x0HvjBz2dD60RVicsi+KzQuPXONePS61zmtrfgvoxiy0RDKOPnDuTk5CdPTavBDzCOxFAfuJUAhcICzFs8HH2RHWHpTUzGCmVyoNMmOxEeuAUt8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7be702-b48e-41b1-0172-08dde9e7e775
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:13:58.7053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gq6wEmZWXz6S93u1HcW+TCdL7X5gNuP/qYE7JHslJk2imm799e0Cs4TzBwkRX2WOEfumu8lpKuBhDxLPGR5BK9gTUjhAGLAA04Vb9emJRIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020060
X-Proofpoint-ORIG-GUID: 6vedegtuU4TA2hHpA25mU0T3Fr6KvIW6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDIyMiBTYWx0ZWRfXxus0AUWKc9Vo
 ghF8oDTHi9xviQjxPguxOmOtL4EGmtaCortz5a/Tno5u1/I8XcOcsU3V8Qk5IAbi4iprJiZfkct
 20K30ga0qYTm7UNo0PctSzye0c3oAy/dXwTJJHOpGcEsA684WURCYSXfKdwOOHvHqRKiD5lcMhP
 RuGElDV4Xx+bRu/3KQ9p1Qnhu80zCKFjPTt+LvJQ45KOg8uMocuVwSVuhWNExh2CwJHmu6lSigl
 E4HhwR0943wSvZoZxTXYNdAYfoT0Pl41+WjVUjEhBESIvWF2wkwSLAQIhFi3nqDO9bq7ExXGhnQ
 fDrl4NIk53cE9FfRYuXBksUqyIgz8DNgHV/XBNRhHq4QUJ/1JobZAvNyQmEj3CTyCT19doURnAR
 PkW1iXcp
X-Authority-Analysis: v=2.4 cv=doHbC0g4 c=1 sm=1 tr=0 ts=68b68b2b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=nIOw8EJm1Y1xcIlDrJcA:9 a=CjuIK1q_8ugA:10
 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-GUID: 6vedegtuU4TA2hHpA25mU0T3Fr6KvIW6

On Mon, Sep 01, 2025 at 10:50:16PM +0200, Max Kellermann wrote:
> For improved const-correctness.
>
> This piece is necessary to make the `rlim_stack` parameter to
> mmap_base() const.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  arch/parisc/include/asm/processor.h | 2 +-
>  arch/parisc/kernel/sys_parisc.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
> index 4c14bde39aac..dd0b5e199559 100644
> --- a/arch/parisc/include/asm/processor.h
> +++ b/arch/parisc/include/asm/processor.h
> @@ -48,7 +48,7 @@
>  #ifndef __ASSEMBLER__
>
>  struct rlimit;
> -unsigned long mmap_upper_limit(struct rlimit *rlim_stack);
> +unsigned long mmap_upper_limit(const struct rlimit *rlim_stack);
>  unsigned long calc_max_stack_size(unsigned long stack_max);
>
>  /*
> diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
> index f852fe274abe..b2cdbb8a12b1 100644
> --- a/arch/parisc/kernel/sys_parisc.c
> +++ b/arch/parisc/kernel/sys_parisc.c
> @@ -77,7 +77,7 @@ unsigned long calc_max_stack_size(unsigned long stack_max)
>   * indicating that "current" should be used instead of a passed-in
>   * value from the exec bprm as done with arch_pick_mmap_layout().
>   */
> -unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
> +unsigned long mmap_upper_limit(const struct rlimit *rlim_stack)
>  {
>  	unsigned long stack_base;
>
> --
> 2.47.2
>

