Return-Path: <linux-fsdevel+bounces-59742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5DAB3DB4B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 09:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA5417BC03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD0274652;
	Mon,  1 Sep 2025 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rVTINx/r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SNYyK8zg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D6272E41;
	Mon,  1 Sep 2025 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712452; cv=fail; b=Ie5Zljx0hTPvpHHegh1U2V5hXGUJxYhMrQAnUyEp7osg9JoDp8z0igK9YLEIa3KJ468jWjY6jf4YT96jB9b5mPem7VX9KPQBj2rnQuqqtrd8raX8lLmWAZNTxHdvgG2RsUYmyBoLtHaszlqChx3bGHahxGOzVKBcCFjuQnjKeSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712452; c=relaxed/simple;
	bh=5cHq2bYyC0iaFq9GtLZr9IdfGt++LciYqxaXFLevs50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B9oiOpHTSCaqWxiTJCrqpzSdkJOGiiCBc7xjlUvthv/7sCv2bLYx+NR3ZK4vTlrtfN3tFVUU3wBFcGtOi3R5oftR8SqBNQdp3lyKG5/H/NNsaoJGWmq4k2ne8GN4NGJIABH8Gf+LRqnLMGM2TS93oHngd3sfHm7RMb5uho3HQwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rVTINx/r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SNYyK8zg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815gvPJ001828;
	Mon, 1 Sep 2025 07:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XeeFSB/GKbxynzmCFi
	le3kSKhtjg76/W33iYOF7hNYo=; b=rVTINx/r9KFP1m8z79BR8dB7su1oS1bxxM
	yVb+VJDxdODlwIKlorWavzDrQIl5V7jXKx5B3aeE5/BOFNxLzmdTqdh6oD4wIEfn
	aQ/KjtpfW+D91ObhnTtKnktXyWN1I2MumDR6C7dDyShJHubUia1/8CUcblydQTPp
	KqR5ybWjXifdpaNZcyu4+IcsTScmMk0GI6341QQoxcgkFye7lxZdhaksmGiO1ySS
	0MFbgzoIOifJN9+DwQObov3O+8dTckDCP/Xn4p58DpcHYhPgTN6Kd9Gfw+VJeH5F
	GzYmIdmSuUH8I/VJqi4v0wvSlnyEyMgw3imHyajkUuieexE0/BRA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmn9wn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 07:39:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5816p2j7028751;
	Mon, 1 Sep 2025 07:39:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr7vkuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 07:39:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbFxTl0D2+FGt1Hqt7Pq0nfmtm4CcbcCY7G5iansM3pyvcsJaHJ/K+8N7Akh6J/GnME3pQZF1MZ7eFY9ufSJJpNakJ6y8l2n7zjzohN+Xb+0EBG/g2x+nxIRRtsm1HMseTvnYSoM2qENRpVjLW3FmBi8OIhk6FWcFcPe+LEsu6diSawmPX2Du2iJPrUkJNrG8T+ANCoisgmZA8coV16wkCO1HneqbdZ6DeAq23DE9q3/Qf1kLb74nMXeAN/0Xty6hDFz04Kar4+LzhRHtD6CfSpJyXhcMxT+L/UqWmmnrgmkrR4JHzDNo9sVL8Ypq3LWKF4VAgK8pbk96OKLmtRfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeeFSB/GKbxynzmCFile3kSKhtjg76/W33iYOF7hNYo=;
 b=YOvjjoH1+kP1sgP4REtZOef0R8Yx79XDwBL25HTWb5Kn+mSBvXdDmHTUYNDG64k9+1RgTr1aFCG6G07a+LaImDYt+PW9uZHru6FUIvT7MUnkg+VT3wHhl6Z3XSiRFhSwjhJAEfjSclzBLVsLCv5L228+1jIXUkUc8xetfFwPc3Jit635u7cDDI0RW6sG22GwcWGHTP6Kq5V0SyG2UKuM1knERj+kDKOmGUftO9tDIhVBAimA9Vg25YuBYHqk/QfhLT+Q4jrNQBu65T4tg2x7ofvkLBQ/0QzCeQz/ry3qBLGmd1DBaLRRKWastFuhHWP+MPKPSs8bbPaZn8WP1yxTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeeFSB/GKbxynzmCFile3kSKhtjg76/W33iYOF7hNYo=;
 b=SNYyK8zgqtn3nEI+Y8RGkzEeJ6sgmfgRPZPJ1IZLXlPQZr/C1cM+Y3bP8goKjVoKjSB2Y21YxdhAPrx4Z3Pz/1OR7gLjrIS0boaz0wqz/T95PlME3M2GzPh+MFx3Z9/9vjlGLPE3Hx5Z1KYeP34gXp8F9ARy8qhZNnmOh4QzRuA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4460.namprd10.prod.outlook.com (2603:10b6:806:118::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 07:39:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 07:39:48 +0000
Date: Mon, 1 Sep 2025 08:39:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
	axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
	hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
	Russell King <linux@armlinux.org.uk>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller  <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,  Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, H. Peter Anvin"@web.codeaurora.org,
	<hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Wei Xu <weixugc@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] mm: add `const` to lots of pointer parameters
Message-ID: <f75e43c6-9b24-4042-a2be-4d55737a8fb5@lucifer.local>
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901061223.2939097-1-max.kellermann@ionos.com>
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: e94d014a-140b-4179-2f93-08dde92aba81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pV5MR2hslKtVtVHtXpL4WD+A+H6AqvFmiVm+msBH/xE330t5FNgvHcRyUzb8?=
 =?us-ascii?Q?N7xJ31vkklAfowYnWAy2QsaBkYvoX76laf+yp1WEYr6T8rrkVLg3Akn5+Q/k?=
 =?us-ascii?Q?NhhXvIgatXPODNmTA3IqvjnkTFzaKEDaoaywbJ1F5Ulj+IIQqzxNb1LtmAu4?=
 =?us-ascii?Q?E96khzU7CEsVzHr/e7QjD1hs2v5MLl5WHjELQ9y5Q+vZOe4OIEDEKompxqpK?=
 =?us-ascii?Q?SxCfni3HbjbVrP8DsnGuvLyulJ9e8XGkDXBuhpU71fN1EXSb8SgGD3ZAvfJ5?=
 =?us-ascii?Q?RxIZ5noB5lZcbg1Nw2VyNOf5o/sbjqqAW0EYuo5OGnETq5ALGnWYy5BfPFkr?=
 =?us-ascii?Q?F6LTTTOprMyU4ZKhlalRvRVjdzY6o0RYbNdwrZlensL7orWEGz2Q5Pn2lfYf?=
 =?us-ascii?Q?+mJcvm0xuTj6duYqAfHlj6RVcYyulL9QmAukgIpqjmEZMyLYn4zUt4GzSI3c?=
 =?us-ascii?Q?Q2xKYsjlGtTnVqExGJxoSbmGBw1j0QQocCoX37NDDIheK9yT2smxKixt1bV1?=
 =?us-ascii?Q?q5jguTOmTFtzJviZTpSCQFI2ItFCoH2tOylLGkK6hJaIxXbQRWSsOxKV/EP8?=
 =?us-ascii?Q?UicPF0blli/gIdnPhYzwGZg24Tl1XxQbNMtQveBTQ+G4RzAlJ7H8cKC/lwjJ?=
 =?us-ascii?Q?/8Sg4XbvzoFJAbx2YmtSmMd2WrdLC2G6p/aRtXJzlVap1KL0HDbCVvY6ogOU?=
 =?us-ascii?Q?hrE8e9jZIxMM3gWJOwDYgMDUAtrs8QZLsjxmFSA8nBNiWmHMpFdOadiDJt0Y?=
 =?us-ascii?Q?4hAex59aC4fTjxeivGgoC4I2nLdkl1lNlzT44dx0JD69JiAI6oPj7uKKIPGj?=
 =?us-ascii?Q?M3ZUheDTETNacQpggWAuRPaD1MiB7UCqDL0Ai823le6vaKPK0lMS0j1I3R0y?=
 =?us-ascii?Q?VmzJz7+YWEszUmyFz0rdHMmkxpDTwiHU81EKiB/fzhaanLAlrZKC8SldrgP0?=
 =?us-ascii?Q?0hPETnXhRS/c+EB6+byQvYODZjUWogQNSLNptmC1AZ4V1uKQDHKP0s37K45I?=
 =?us-ascii?Q?x1EQUDRu3nOYtsKxnb53G66zZ30Ckr8zO+pK45NTqNlXk9f/xcCJKR/fwUD2?=
 =?us-ascii?Q?E0YlZzLUpSlevRhtFYKP25cl/0QBBA27ub57A/EM2h3+Qj6YYidwTH9+WAdr?=
 =?us-ascii?Q?nwsWFOt2mX7KgkBDRtF4qEhjjVi08TPPmiWZdHjmOfHDB8jq7rlNJ8rO/cG8?=
 =?us-ascii?Q?7qx73GHsUEvFFYjU0yAglQR2/o2WO1+fsOAS3/riagKfuTLAJ6E8gfCRJOXQ?=
 =?us-ascii?Q?ygid2hqf0humDQt8jb7P7mPDVho98AFrl6bl1Ib4ziommrsizWOkTv8RyW8p?=
 =?us-ascii?Q?TFmZo5/8sJnqk/LzddD7xB2jEgkQpkvliCDM8uyCG8OwfmiRheQSdwkTw17e?=
 =?us-ascii?Q?QZv//AuJiH2gROCDofD2nv5r4mcOa1r+inQL4AX32RQh7V459zkX0cAOu+b8?=
 =?us-ascii?Q?tEgJQrCBX6M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hzGViah8ugF5csRY1r92qk/vRJsF1iMaZMNPnlQqI8Gro0EEBhS8LPkVFarw?=
 =?us-ascii?Q?jT426uoofxK9AkqwR8xU0oVY3KLBL36ip1kVrQQYdJV8FA40SJPmZCvCLsWK?=
 =?us-ascii?Q?IaBgKT7PE3IZ0gxwLD6VScQ9k2VMtoonJ9pSZ4o2Ph6YyjEJ5EFobSolUJBT?=
 =?us-ascii?Q?hx91U8Xgj2pbSWeqwZ+wh+Z5uvXETW+oFS9QRyfKmJaPpMzk9l2x168utIc3?=
 =?us-ascii?Q?mvnFdwlY1LNKa/sMJK/huatmSIiOqe9AgHtL9wI3QjFuF4dVsJAwgGsKAsqL?=
 =?us-ascii?Q?cmmBuAAtj1SajJT/U14Shxxu7Zbk0BHo8YE3NIadu5utfGSElI+6AcmOOJF3?=
 =?us-ascii?Q?Ycsu4pKSBMi8/VvJMv8/3waMtFJa+sknQi8H1V8qDf8JNmWeucp1ousVFKDR?=
 =?us-ascii?Q?GXiL/fd9r7ETeDAuojK1majLOTXF02XbQl1OhyoYKSa+/HLKulJ9MqH8wyLY?=
 =?us-ascii?Q?AcTpzENYBj7YkW9p8ru3NlsFSjOGOQHYXbZrzvh6CXAzUgsXrvOWuPqL1HBp?=
 =?us-ascii?Q?FVt3JFcG8YfuSAmOvVulB6v7QoMw1lfMUuZ0D16tOtKtpHdcq29zjnC66gyM?=
 =?us-ascii?Q?IiS/twxGQs7UW4sbYCDJazNN7n9eVPwNDqBODS2RuMgI4SO3eTaRtU8U2mmV?=
 =?us-ascii?Q?ZQOvgOd+Oa8NI0QZQwV+AoMy/BbOLwy/9VOwX45ytYIP1LC6fsNqcFVFR42F?=
 =?us-ascii?Q?mKItza73CMHPDN3X4aJvH9TevJr9/Q/vpo22Jxi1Q69cbMkPzWZXpWqPz+JI?=
 =?us-ascii?Q?yoGmtqSh6NB2olt5U3IumgGzkPvHHc4b9V3Egppg8/VELY//OpVwI+9X3826?=
 =?us-ascii?Q?BIDZJFjn/opuW69mqOSXNq2DcJdhXPcOXvdqrk9g8oe1KGELeQFD2jefL9kg?=
 =?us-ascii?Q?mK+6y1H7SuZa8seOouqMXHLzdT44Jt+nXcWKa72F7jcoGQ89SPSkDtQb5JgG?=
 =?us-ascii?Q?qqQuBvlyOwWKTwkdUuVQs9dAsPnU7OwPKpWQtxCP15K1kJfG2ohYrzGgGCkb?=
 =?us-ascii?Q?3Hp5qGaNv8gDyn0eJSa9MfOoWEj8Vsddbx7NhdgSNrQ+tzGEdXgfN850LmMq?=
 =?us-ascii?Q?dUYo2SNVrmc4tOTXwNeAvQfcLzNExlU1xQC7svWHdTXhPC/UkTvRWhAlsm3l?=
 =?us-ascii?Q?lxaJVSh9xVqmFhnaZkdRYBS/2h2RgqjQienREExUxzdptHI4Ub2xge1DME0E?=
 =?us-ascii?Q?Hy2RRNw1V7ztYVhi0hwdiQYXWzNYfbTQNlRNqVzFDOI8MA1fKE38509wAdxS?=
 =?us-ascii?Q?AWfXHh1hQDaYBOjvaTU6fJuWnbJ2iHGUWp4JiC5bv+R/WrS3iAd5B+Ygjiu9?=
 =?us-ascii?Q?HI0FZQEflOENj8ZALVtZ2LFUo8kL66FLGzruErTDRW1u1y9mP6443b1SOPks?=
 =?us-ascii?Q?M1DxBS/7ghrMgenxzwKm8LuePd1IZ+xCURzMxDuqmd2qfwFJEKMt6lefULzK?=
 =?us-ascii?Q?/Tzj8wAVNB37zv5nw5Ybwq1BCWae5Frs5VPyy6Y6Thds0QzJnUoelVnacsnI?=
 =?us-ascii?Q?nUnyvkcx83gnQ/Duyli7MzmUThtZwUqs+Gkp5wLcetfwQsCsvHcFVPKlq1KW?=
 =?us-ascii?Q?oqhsykFo1P12EgO+iXtOxYfoff3m67rDJlMh+0i7yVhCZ+m0H9gjJD1BqTg9?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M+sbvajOl0TMZ1QQUdpVNTIIKzRp/ZvWjnICydw6WBr7vu9AX1SdlRfxgIbG6ECQt9Lvd9hP6GxbxWYmmjoxrzkcZpFGeLx5iCKeonFz2nrTf1McyGgp2AMdeQhZsfQ4eVJ2ZBTOBjdr0aRZ2njTIV0bqPJgwH6O9fvAmCPJF4Vo3nGzjddHvT9KazKyW7a8FaYOE6SdbdWY4mELWvYbTRerd/rtT++HdojyyxFD4WPU6IOJAyx5sW6Lu5+1xSSLkVo8+qszFDwu34TvNaFKAel4hRTbmmx11L7MXgAaPppDZpoNpZGfHqbOqCIRqr1FQ3CQIpuRPGXRSJxJYeZNVtP03SLlxCGqWSKSQf7t65xma/kK/OcFS7sS+CfKPlE+T/vrlUkfyC3edVpiGyFdV4PH7i4Eub9KeSRxCa8rQyu49nVNalm6c9VxZvixLLRg4TC4BHnqzH0E3qh2VA0KgJIQkpGHg9HV/v9woJtfYoxHExFk2bs4VpZL2OG8CjUXF+hMCc9RFMcZQRNA512EpudAA/d89vY2l65yxz8vHKg2pQnqq4cXzpYff0LM2JJ7Va1B87zvUd0aOOZaVYZZEWs+P5fOzjrtEKyEY/cnRnU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94d014a-140b-4179-2f93-08dde92aba81
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 07:39:48.5473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzqhFL1HpzPA7EixFpYDrYp8d6FVBjVMvGouoy2Xgjakenjfl755yqdKfTQIfZXZXWbK5OUtByFi/OnQN3f2TWReHQYGWxHM0uwU0n/wrHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509010080
X-Proofpoint-GUID: FH2lblJH50kVCb2a5HvZoLOCB6jhqAxQ
X-Proofpoint-ORIG-GUID: FH2lblJH50kVCb2a5HvZoLOCB6jhqAxQ
X-Authority-Analysis: v=2.4 cv=Of2YDgTY c=1 sm=1 tr=0 ts=68b54dc9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=UgJECxHJAAAA:8
 a=-gg6dhmGWeoicojpQ1oA:9 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22 cc=ntf
 awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX0dwRzi3Fte3O
 TwkqzHhPRL8LGurjbpxksGGIgYLXO7m/JtqK56R0UyaH64+cvSMRpOW5K+VyZbEPIaQqJ/VhV3F
 LBlmEqwy+zIS2ZBLskv62DJCkciopRzcFTGv6/HvqsbMcB9+1iRgnhwy7x+2sgOq08Q+6UYWg9e
 BypgqJHTZ6SSm0Enm8IEUwo81elc+QDS707y0E1/ZOW0NyjGW2HOx1Mmww7GeZejkrydZm+EQpb
 A4A4OELPwk3qH6F+Xu7J4bKw1sNOG3pgbRKrA1BnKoo28zxtFWIf3htT3QNaNon1SFGv8yXUxJn
 7zp9Il5MJyXl019TEiorznwqWsJhxO0yyla/5agfM/oHCsCs3jsJSzyxapbbE8WTgGIBhhT1PL5
 a3+Tp3WvQgnDfAD5GJ+hjitaRnf7HA==

+cc missing people/lists.

Max, this is the 3rd time I've asked (and others have asked too), and I'm
trying to be nice here, but you are not cc'ing the correct people.

For ease of reference:

$ scripts/get_maintainer.pl --nogit-blame arch/arm/include/asm/highmem.h \
	arch/parisc/include/asm/processor.h \
	arch/parisc/kernel/sys_parisc.c \
	arch/s390/mm/mmap.c \
	arch/sparc/kernel/sys_sparc_64.c \
	arch/x86/mm/mmap.c \
	arch/xtensa/include/asm/highmem.h \
	include/linux/fs.h \
	include/linux/highmem-internal.h \
	include/linux/highmem.h \
	include/linux/mm.h \
	include/linux/mm_inline.h \
	include/linux/mm_types.h \
	include/linux/mmzone.h \
	include/linux/pagemap.h \
	include/linux/sched/mm.h \
	include/linux/shmem_fs.h \
	mm/highmem.c \
	mm/oom_kill.c \
	mm/shmem.c \
	mm/util.c

Gives you what you need, or you can just generate the patch set and do

$ scripts/get_maintainer.pl --nogit-blame *.patch

And filter out anybody who's not listed as a maintainer or reviewer.

Then cc everybody on all mails in series.

On Mon, Sep 01, 2025 at 08:12:11AM +0200, Max Kellermann wrote:
> For improved const-correctness.

The cover letter is included upstream, so you need to expand upon this.

Something like 'In order to ensure better const correctness, we wish to
mark read-only paramaeters const within mm, but to do so we must start at
the bottom of the call graph and work our way up, this series lays the
foundation for this.'.

So I think drop all this stuff about review into the vX -> vY bit, and move:

	Establishing const-correctness in this low-level part of the kernel
	enables doing the same in higher-level parts, e.g. filesystems.

Up here.

>
> This work was initially posted here:
>  https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/
>
> .. but got rejected by Lorenzo Stoakes:
>  https://lore.kernel.org/lkml/d6bf808d-7d74-4e22-ac4b-a6d1f4892262@lucifer.local/

:)

This is the nature of review, it's iterative. Given this cover letter is
included upstream this isn't really hugely useful.

To be clear - I am actually _very much_ in favour of us trying to attack
this, it's just how we do it, how we structure it and how we proceed moving
forwards.

Hence why I reviewed your 'taster' change and agreed with David's
suggestion for a structured way forwards.

>
> David Hildenbrand and Lorenzo Stoakes suggested splitting the patch
> into smaller chunks.  My second attempt with one smaller patch was met
> with agreement:
>
>  https://lore.kernel.org/lkml/20250828130311.772993-1-max.kellermann@ionos.com/
>
> Now this is the rest of the initial patch in small pieces, plus some
> more.
>
> Establishing const-correctness in this low-level part of the kernel
> enables doing the same in higher-level parts, e.g. filesystems.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> v1 -> v2:
> - made several parameter values const (i.e. the pointer address, not
>   just the pointed-to memory), as suggested by Andrew Morton and
>   Yuanchu Xie
> - drop existing+obsolete "extern" keywords on lines modified by these
>   patches (suggested by Vishal Moola)
> - add missing parameter names on lines modified by these patches
>   (suggested by Vishal Moola)
> - more "const" pointers (e.g. the task_struct passed to
>   process_shares_mm())
> - add missing "const" to s390, fixing s390 build failure
> - moved the mmap_is_legacy() change in arch/s390/mm/mmap.c from 08/12
>   to 06/12 (suggested by Vishal Moola)
>
> v2 -> v3:
> - remove garbage from 06/12

Has this dealt with the build bot issues found in v2? I guess this is what
was 08/12 then right?

> - changed tags on subject line (suggested by Matthew Wilcox)

This is nice, but to be nitty could you do it in reverse order and ideally
:) put a lore link to previous versions? It's super useful.

>
> Max Kellermann (12):
>   mm/shmem: add `const` to lots of pointer parameters
>   mm/pagemap: add `const` to lots of pointer parameters
>   mm/mmzone: add `const` to lots of pointer parameters
>   fs: add `const` to several pointer parameters
>   mm/oom_kill: add `const` to pointer parameter
>   mm/util, s390: add `const` to several pointer parameters
>   parisc: add `const` to mmap_upper_limit() parameter
>   mm/util, s390, sparc, x86: add const to arch_pick_mmap_layout()
>     parameter
>   mm/mm_types: add `const` to several pointer parameters
>   mm/mm_inline: add `const` to lots of pointer parameters
>   mm: add `const` to lots of pointer parameters
>   mm/highmem: add `const` to lots of pointer parameters

Hm I wonder if per-file is the rigth approach, but let me read through the
series and see.

>
>  arch/arm/include/asm/highmem.h      |  6 +--
>  arch/parisc/include/asm/processor.h |  2 +-
>  arch/parisc/kernel/sys_parisc.c     |  2 +-
>  arch/s390/mm/mmap.c                 |  7 ++--
>  arch/sparc/kernel/sys_sparc_64.c    |  3 +-
>  arch/x86/mm/mmap.c                  |  7 ++--
>  arch/xtensa/include/asm/highmem.h   |  2 +-
>  include/linux/fs.h                  |  7 ++--
>  include/linux/highmem-internal.h    | 38 ++++++++++---------
>  include/linux/highmem.h             |  8 ++--
>  include/linux/mm.h                  | 48 +++++++++++------------
>  include/linux/mm_inline.h           | 26 +++++++------
>  include/linux/mm_types.h            |  4 +-
>  include/linux/mmzone.h              | 42 ++++++++++----------
>  include/linux/pagemap.h             | 59 +++++++++++++++--------------
>  include/linux/sched/mm.h            |  4 +-
>  include/linux/shmem_fs.h            |  4 +-
>  mm/highmem.c                        | 10 ++---
>  mm/oom_kill.c                       |  3 +-
>  mm/shmem.c                          |  6 +--
>  mm/util.c                           | 20 ++++++----
>  21 files changed, 162 insertions(+), 146 deletions(-)
>
> --
> 2.47.2
>

Thanks, Lorenzo

