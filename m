Return-Path: <linux-fsdevel+bounces-59874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8888B3E7D2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCEBD1883364
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576F82D6E58;
	Mon,  1 Sep 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c+xbPWNm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K0NZbtAO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8C10F2
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738194; cv=fail; b=MFXjlgd1mSoI38TfBzkRX7NEGTkA+IHWwmvs/ZA5LLnv6KLda3RawvHbltbEFeDlnmko4uCkZYyXMd5FAtdB7hZUfev2P7Wp2axHHxC1H9pCX55YtxhwKJiy8NRl7fmrxCmTwmqnD+IbMdQtIDprMKblq1StGsNPU3qpn00y3bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738194; c=relaxed/simple;
	bh=QRnVSqmTUDcNf+NyedBXDNa9Gk9fG3LPD0AxmL8Hjlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kCfce9LoEZbI3VtbvOeJHnicQ4TA/4QAoK+yRHkSemIUZ7Xeb+n9PHMlanY5IxDUFONbiv3XM8JAmREKdiwsRixZrDVGbzqRYh/RyvrZlyEFLU6Y0WbYWaON3s08SYS8FOp2Aa5oRb70EnQzzTkqB5nxuFlfRuy9el8XhKPklr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c+xbPWNm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K0NZbtAO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815gpTl001212;
	Mon, 1 Sep 2025 14:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gTg38EmeaM091rJ3yM
	LNXMEnakfUgYZ4KjeCpgQt3Tk=; b=c+xbPWNmF2uv+BXsMKlcpqL+ILkhEYJzPN
	HkKt7deZsSfgGdU90TGT6D2kqLhi47IUz9/CnLCNGe9rsO9hSA2qeoylCaSW+Ihl
	m1AQOU6+IG2AOfvBXY/Y0k5BcnHbSvca/8tDrS/EaX52vqAveYDmWdQmFdQ8xMXn
	I7kADZy6+3MZeTn1poE5phOtQN1frPCWI3FgW4FGa8thI3O+gJOnoPOnsDcqqjRN
	Y6+PIquWPJ7YJ3Wi/TtLTJFN0SaYQwcrGR8mJ8njdp+/cZARI8eLkRfgUagNBAeH
	O6r9ByY75fd9NAXjxEeY+OeoMM0IwLZA70FrOPqpmp+YonlwZmgw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbajj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:49:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581EK7Xe024836;
	Mon, 1 Sep 2025 14:49:48 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr7xx30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRs1ox4dIQb/LVdOdPdMU4pF9VQYlEQiW9mjtlpM3wARxyN8VbfmkhnDPm8BP20Iqu2xnXWxvyiobY/raRvQT/nsLAF8/d31snuqbgwtvhWkJBbtJDKa0iH2WQbTUnzCO/XP/KWu4t/vFzk7xINR18zHBRyEDFGdYRqxtPYwh0whFIL8JkUzJAK7dUiuF450PohJNBDEU+zRhVZCaE7JZE+9BMl2SWII7aA/2gSQ6XTs4nOgkuC0MvUuTNDIsZ0eaPuwVBZTPGm5UtVJ+pZix8AGsKNfZ8VHlOOALaEs1F8Q1qidDqWY60V4Fw1djtUyAHJj9Nr5yqPe0ceC/A/zfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTg38EmeaM091rJ3yMLNXMEnakfUgYZ4KjeCpgQt3Tk=;
 b=srXS5W+EIvxxZ7xYs9eaWcbkAXDy6+YlIAA1jqYI8ulyPUjlOca5N5mWmCCmW288J9K1ThHECarDR9E22pG5lP00lNt0ynMWHhuBGNITYdYecywJrP1FoKNWEwquL0V8FEB/obscO/qvkDlwAlsdEUfRkgMVQNjO6TjP1If0jQ35V9UVogqQSxmJbw7xDZcZ+HSbDGPPtqx+xUVGmFwUFhWOaLwFwWOX/ppEzVXMz1xPa2MW7d/Jbv1YsCkG9PjETyln1Uo6FoYLQD0cWCCwrH4Lkx0dIRbISuLGXYJTHdCNy8+J9p/GZIrfBK/yk7TPhkoGhCAHuspacYr+wGKFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTg38EmeaM091rJ3yMLNXMEnakfUgYZ4KjeCpgQt3Tk=;
 b=K0NZbtAOmkqd2tkfIK/JMSR31IpIVbgysMuO8bT/WkbixMTW118/X9Rxi/wqW5SQyh6wjTOwb97OFustTo1qTjhhSNoyXGaUHOx5OQI7jgjdt0rQiJ5SvQjTyC7JBU90ZA5KAZF1d76KhasxrXXAhoBipCrdxofgE+UBlOEERE8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA4PR10MB8709.namprd10.prod.outlook.com (2603:10b6:208:56d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 1 Sep
 2025 14:49:45 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 14:49:45 +0000
Date: Mon, 1 Sep 2025 15:49:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
        axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
        hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
        linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
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
Subject: Re: [PATCH v5 08/12] mm: constify arch_pick_mmap_layout() for
 improved const-correctness
Message-ID: <2ca532af-79b4-4f37-8e5a-c99181da88d1@lucifer.local>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-9-max.kellermann@ionos.com>
 <2ad655ca-7003-4030-bb2d-1c4bcfda30cc@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ad655ca-7003-4030-bb2d-1c4bcfda30cc@redhat.com>
X-ClientProxiedBy: GVZP280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA4PR10MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 129905b5-88d5-4781-fb5d-08dde966ca0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1k9E9CxMVw43jLeauDd+hoPaAdn8vJsVOV2/38mNvy1XXF/yme23PZr9MSB7?=
 =?us-ascii?Q?MfFt3xL8Fs9ofCNGMsA/WzZmo7bKeB8oK5Fb59d+6BQ6kSaGAjCHqn+zJ44y?=
 =?us-ascii?Q?gSa7wzuvfZyWX4DG7IMwC2l9CX/E+km/N0HwtPqMgJEIBUTpsiPMGq+A4HZC?=
 =?us-ascii?Q?0G1dfcQpjTjdGnUrJQbNYxeCBncnlwoXI0jJW80ItldQ/aQIynR7Eeq+cMhu?=
 =?us-ascii?Q?4n9ZtjFqfVZe8HggtUhzgdhMhWJ3O8lIoAv3rjXNACeZ32aoaND0HKaiOT/i?=
 =?us-ascii?Q?2IlVWhpRlcI63qx72TlYYmP7cjODrPjw14UKGkULrW0mB2fy/5dvhzcg9Uuh?=
 =?us-ascii?Q?aKLGiAzJHcTAwMnmKFr5SgV7Ox3B0Srii6vcCX3bnU04we4fhGpGc+lGZVf5?=
 =?us-ascii?Q?W8qqPhQNumotbmGulSN/AOorY5e6tknM7pxiLisCY/celgaxqKGpedx12EhF?=
 =?us-ascii?Q?gwJK2A090ajcC8dbvHJnG4pzKhgM0TwajB9l89xaB7l9j6gKv/oCC2lG88Va?=
 =?us-ascii?Q?aOQXTvk7WIA0V5g5WlIwNiZCC4R22kVL/ZeF6IjzHhqwFL0bZ4GCS5NY8X96?=
 =?us-ascii?Q?pRLxL8IVl8H9yvklOJ0NZwmOZonuXGmr8Kn7uFZIVWSCYwal05q5nA4cr7ky?=
 =?us-ascii?Q?VpN8OjRhkdeCeKx2HM83PQxsQ8YDvbJBBSAOelT/7BHFxvdVmCJ29ICtdhDZ?=
 =?us-ascii?Q?VTpjIedizfBODiRPbKEl75ZBAxnG28v+dwK4SeuvRM3yDi/OoW3mxGgJ3TZ0?=
 =?us-ascii?Q?bJfeErfX6azbhgRv3jQEcOcGUxzW2MLOzmGT0sU/6hozMnWhSWvfmlkXZKo6?=
 =?us-ascii?Q?PcrmOq7N9T7/8hlfFT/ezoyA0s4fuBLGl42nZkWpMvFDLXWKL5varsj3Nmuy?=
 =?us-ascii?Q?+iTMPkCgI0NsUXdsmpJFso1t7QYs12DiC/6H86MBnAxwjI9KxXzeCn04C19m?=
 =?us-ascii?Q?ez1c2xPNI53vo6fDvFWZngIKNat3yYpfcvY2CiOksQLRJ/u5DgUzSeW1EtEC?=
 =?us-ascii?Q?wfJn9+RyEOQQm+1DWvPcv6OQGwgkbhu2tGJSQ05/puSZI3zmvdmFeOtcACmp?=
 =?us-ascii?Q?TizYpk/Wv6o6vZLVXRgAqiYIODh3+ngVDJ6ZXprSfyy8/uuFB7it7pTkVAL7?=
 =?us-ascii?Q?JzNGaYqevH4uMLk8yL8clCO66jhEybOP/SRlnAbsoR2gKlfCtwGBmKl9jSnY?=
 =?us-ascii?Q?fCPu4htQ2MNxPS1dAUIpzUFuQTV2ld6iZSkpNhkqkzeTIkyTZeE5Fk821htT?=
 =?us-ascii?Q?ZVBRfNABUwd3d4LZNkqxwfdE1PQ+B89I3ZjnXw2GhOopcAW/VibGhAg5n60T?=
 =?us-ascii?Q?GFX2S1r8InTbVatbyzlsoDihjJ9XnE3SsQIuUSGCnEytgoIv02yrt9aqxGiE?=
 =?us-ascii?Q?idUmEetRE9sGtyT5XWYQzD7wTLR/BYNdz49Fjit9PWSZDonV5b5RIPshbu4J?=
 =?us-ascii?Q?/xVCulHE25M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YYbzEIeWL39MGHF4Vx6mTQSYyxCdVv50+FkUNV3xn7bHihVNOv99xE10Bii9?=
 =?us-ascii?Q?wfoCBJcRVj8OXtce3nez5KxGtrn/yUvpPZnd6DW4N0pXNqFUTuw42iPEP91+?=
 =?us-ascii?Q?rntYRcI/6Uy30s/eqFPqCdBSGFzfx0lcy6EJbIG8t4DumafNDXo+z7QPEeQD?=
 =?us-ascii?Q?zQZP1OELwxA4G0tfwksr4AMPA1woaMQpTQ+Rdo+KZr8wNHaecZ7I8UIT4K0Z?=
 =?us-ascii?Q?XeL4n/QE8812zW9w5d4DtEvbQL1RYEX/iVyPUt6mfoj01S2bTZgu2Wgf43fM?=
 =?us-ascii?Q?zFYdRMA2GK2W/Pj4/TwbcyPDMnspHVV7DW7WkGSkGFbdpUwvEuEISBiilVMD?=
 =?us-ascii?Q?WelMu6x45clZuXrNIsy/0lY0Q2/jBb/giObvsPElny/vfb7wSwmST5m6f+bo?=
 =?us-ascii?Q?fo4ad/21IcmEmDi7Of9VpjG5JWfxjQpGag0DtF1snAdL5hHPoCJ2lBb8gQXK?=
 =?us-ascii?Q?dgAFTfLWxv8ks5IBHFjB+cQjqHEINl8iwjUKX7ajzY01x0W6BbPJ1ZzZ9CyY?=
 =?us-ascii?Q?jIjyfExzhxjveQtMpA+P8SD9OSELvBZoZYfK3qAmfv0tD2Le5cr9y3CyoWQf?=
 =?us-ascii?Q?3Cnfdkw1ToP384dtGB4JZaMQLMerP22FkPZXZsxd7SsdA5LBAKj2usET3du3?=
 =?us-ascii?Q?B1jjwtd24TAhfcYnVBmjYD5mv+4RCC3eqMpPUzixPY30R/i/D30wUOLIQ8Rx?=
 =?us-ascii?Q?dZs3nuVmNX1N+3QrYNMGVntm8XmDxYdwb5ZyvoPTkDBIkwbF73gWgi7lbeSe?=
 =?us-ascii?Q?OxopQT0YcXC/6QhwV0JpU1vSaFc9BjiCljOb0KOJLkxWGVDYq4OHfWUJalS1?=
 =?us-ascii?Q?x2ZuK5smrc/qsKt2WEnvUKfXu/oV5iqQlyJk09GtnkGpnsG1Wz+B3d73ozG4?=
 =?us-ascii?Q?CWZO9GJ9/nosFxyzLV0oV/1PaPSsMniemr3roJFFqGJwMGIWCCpoP5d27wB2?=
 =?us-ascii?Q?ERMB9hfAZytCO/2JGEeFbhTEzXpIDz7EzKLNtBdovkoAqZgg7XX9qPR+HAtf?=
 =?us-ascii?Q?CtWJwqvQBErcdmkei6zmdPIETl7StrcazwsgoRklpC3ShcnHLJ+efmfb6yM8?=
 =?us-ascii?Q?QfTaLGGIAa6+fDQwVIfm9cii6LIMvDBmmBDW4q0ha8QEsxwTfuYpCWaz9glB?=
 =?us-ascii?Q?Sn5wO7Cb7ZSgMQfgBl/649E4dVBD4MLEdcCBnuCpJe/84HE990O0yG4sXDR2?=
 =?us-ascii?Q?fhGrcGDzm+KUXO1nxJYQtFebqmUMF2svJ/weeg6KuIrYNnRTaFmu8HtMU1bm?=
 =?us-ascii?Q?/Ux0tx+nQL7G3qh7zDUwvsFxo3FK4GBne/BLTihUwF5HwOKXpezKNzsoLb8k?=
 =?us-ascii?Q?cS/ySF/Kh2GVCfjKowjMANfDzwcxdUIqNelVv2F1/e1vkhqevbwbIEzYc2nT?=
 =?us-ascii?Q?xe2PNkqWy7Jbg1KdAhEg1S8tkcERWFDC76iAluhIYPNE60UW8GwjVIRneK+Y?=
 =?us-ascii?Q?6dJXnJTmOKfzbbKuln3lgL9UbxnyQw3yxrX/6rq85ZmMMWTA4wHxi3G/zVSE?=
 =?us-ascii?Q?6PLN6Jqi6ScPlYGusuNBCukBIFdtBPej10BBt9cBIidhzQUltN2nYuWysjzJ?=
 =?us-ascii?Q?1Prbk1cxqzQVJ682aqzCM/84WvAcfiydU0dZpY+B/6GjaDl8Pfkj0JZSRDW3?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+vk6NteGunCZMRrpaXV8MacXPaRxNJ2BO9V/H3SLoK6x1Jxmp9SYB4rl31MJg+S7WfTa8hNRwq89iOgkMyALc7PGU/SG9+SWjufoMoqT/oTG9ICcpNHDyx2dCzCfscHzKovwoJFqAPuAq6yF0Kv8nUGHLepshFoaalVQLglLpK//KfP6Bd/zgKf0BlipxxkiCYNR00KIsgK/HLCARIXpp62JM0qnLAGpZ0bYrqtl+PcjRZcykkx3ilSwnIG1tQbt0zuS6uK/IIOCibrnDiq5BoPkn4RZtK902fBcG5qdJmsB5o3nJuW2CsrxgK3C6Ow+h1YA1QhwGEJQCQILhkri/X6O1UeaGNOp3vftbREd/2xNppEyMkzGA9naH9Y7yfTXWaDR/Ym6wy0GKThS9ECZr9P02NLYlVi8kZSdNvJ+J/9E4MpwTXlw5/YVpOngZTmp8x2nBrR2Yej6tOWER+4xpDl4U1ZH5HAri9biSe7cm82Wn6NV1BuoHCKKyNtvC/S6aHhn9+6tmq7VuMxolQGYoq6VdUU6mEXw/7GGDxhH4CreNgv0TU3M3KWa2psqVjr4SrBqwJWiOWXQsuOibMNDHPFns80UUCfABzQH39s7bKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129905b5-88d5-4781-fb5d-08dde966ca0d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:49:45.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxguYk/ADJxBiZqc2Y4HPvevWsd+dLKHedKGbryw0oX8nGgtPSFlxhtKEHufll0cW19GmvphfUw2YwvqtoMwGOMp1nbBgTZHJhDH79SoEmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=674 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010157
X-Proofpoint-ORIG-GUID: 8iJ-9lxydt840m_goutzfi7BZrCb6eFs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX8ZiUlOO0R6u3
 XtA3aVjETANg8F9DZrJ+AjkNoG0yEKawf9KA6ylysfJqZ7UlDr3DLQe8nOv89pHBG4tkFxgrCE5
 MYA504Yw0lQJxZUh2hIbg9/cBpnJvrBSP5m+E+kD5FA6pzlrwmngnMk2iq1xmZ8zaNKp3uip9Wv
 vNS8bQfWMv90VS0YUC6UmiK4A6X43OqX6O1ekf2a83W7X4n+G74kp02YoraTywdBgFhrdHn9QJI
 YaZv9C8NLeovboVlm0V1T4HYb4qW5vXgASTql2tUGamnQlS9Hq3LwxgWDgymhHJM0yqhULBYWJg
 NYKINqsJZQbzsNw1haPSvDw9mzwT57oVK5dRiRpZcthVPASS78dYJz0Z6w4E7fTV/Xw7XJDpFfC
 Y3VPbiW8
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b5b28d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=pGLkceISAAAA:8
 a=iyTz58o3RSby2LqTmyMA:9 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-GUID: 8iJ-9lxydt840m_goutzfi7BZrCb6eFs

On Mon, Sep 01, 2025 at 03:58:14PM +0200, David Hildenbrand wrote:
> On 01.09.25 14:30, Max Kellermann wrote:
> > This function only reads from the rlimit pointer (but writes to the
> > mm_struct pointer which is kept without `const`).
> >
> > All callees are already const-ified or (internal functions) are being
> > constified by this patch.
> >
> > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> > Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
>
> [...]
>
> > index 2201da0afecc..0232d983b715 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -178,7 +178,7 @@ static inline void mm_update_next_owner(struct mm_struct *mm)
> >   #endif
> >   extern void arch_pick_mmap_layout(struct mm_struct *mm,
> > -				  struct rlimit *rlim_stack);
> > +				  const struct rlimit *rlim_stack);
> >   unsigned long
> >   arch_get_unmapped_area(struct file *filp, unsigned long addr,
> > @@ -211,7 +211,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
> >   				  unsigned long flags, vm_flags_t vm_flags);
> >   #else
> >   static inline void arch_pick_mmap_layout(struct mm_struct *mm,
> > -					 struct rlimit *rlim_stack) {}
> > +					 const struct rlimit *rlim_stack) {}
> >   #endif
>
> Should both these cases also use *const?
>
> (for the latter we probably don't care either, but maybe just to be
> consistent)

It'd be pretty hideous aesthetically. Really feel like we shouldn't be doing
it...

Imagine

static inline void foo(const struct mm_struct *const mm, const struct vm_area_struct *const vma,
			const struct rlimit *const rlim_stack);

I mean that's _just not readable_.

>
> --
> Cheers
>
> David / dhildenb
>

