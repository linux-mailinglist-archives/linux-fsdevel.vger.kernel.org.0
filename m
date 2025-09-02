Return-Path: <linux-fsdevel+bounces-59984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4149B400F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 14:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6190D7BA1BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599F728C874;
	Tue,  2 Sep 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TkFPcrWc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dB06f1NO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14852882A7;
	Tue,  2 Sep 2025 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816705; cv=fail; b=YlJCw/vamZeZ+5yejYuT1pTLhLdz1q3E4S/Vu39AGRR06u63T6X6laUfNVFYEINZriLkedOCXdpx2EAUL/rHFKkh5YrEuXiNthbAfvqfSQuqSkbYLrBHXeF+90kySOMUpRVFy6Uwh0HCeT+MPrY0IG4kim6+qrmoMfFzo2rxR2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816705; c=relaxed/simple;
	bh=tzlGNbxi1znssWorix7jmi5vWM92YAnDfgvenbSB6tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BuiQBhc9mwZYn/KNJu/U52w8yWq+Enp32rX+dPuwwLUYGBgZ2u45fY/levS/QjdO2YFKpvugO+V7nX4ikQotuPZG8oH+GoGaUuB3hdSU/q6uJVR78R6HgFTec4Ge190R0w6pfYBlOiVe+miC5Q+moACNI8A00WSh6c7J63RssMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TkFPcrWc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dB06f1NO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582ANp21010600;
	Tue, 2 Sep 2025 12:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=K5tJYx846b5hVW37QS
	sx47sOn20oXtQNDAqj01E957M=; b=TkFPcrWc4XrqBGi/IaQuEmVqmApjxtYhsR
	7pSdSDRnXGFQn5r5+eNnWxB6pce1vEFJ4Eap3akrZJLxAfakCnkCjGePbmbb7Rst
	S5aKQPVFWoACRFbUvvqK/Pf1KooOHmUoH9TD/MTXnXY/dtz8534LRa2IrpLCDJsB
	jg2vwM8j8HvT6Zy+giYGLx52sRVwIk0dEdoUhqKv1r108XlofBMOPyPzE/YrmDvR
	8OGJ3JxWp88mroYR2PJcFWLzERbgYI1Gs4n8f2CwSnwMOURnES2LCmTrL7LtlM1g
	SePWuCXvaaWUYUXE5J9EcDZKH2cAyGn1Q/qI6WUaPLmgHjTjrFAQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbbx19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 12:38:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582Bek0n015773;
	Tue, 2 Sep 2025 12:38:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01nanqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 12:38:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKWYeQHwEUP2giTCkdJndON59pRlqZsmdm/0c0KiiqByCrLwKShSiAcr2WvvBQgzJVlQxBtlEp7WgM1bev0EL3TEe3bCtquDRflATfuhjKrS/SvF3EtYhsUR4bUHfkBPaHpImww/n65/LdNooSGmz3eu3F3RTFu9ccV3YxCQ69h9yksz0uPCdowNAojwEsmNTMy0S+clj471vMESCMABzqD0Pgz4Eau2yCTPkgHoeO0axOgzkkXZqyurkHhroWRs3KuQmNWM5hmqta1YdyOzd5cFcZqtDI4A9CMpFJ9c2rAyg9oLLc/pImzWSA7czycOSt1UblWfYPKcKllPG0PDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5tJYx846b5hVW37QSsx47sOn20oXtQNDAqj01E957M=;
 b=MT0DoMPSIgEcDQB38pX6mfnf7TcDl51YKVU8QcZGHnQCOdifMZvb3Ms47c3ef89YII9/SCYsWEHUHB7J5+ed12X0+c9C6scPfXsEz1asiHjr2fgUqCwGa3xczh1v2niB5aZWRUEXYPzHLkwnyfPTqc4wIct3mOip1GheIEf/lcRANoyDEUzK/WUtGoBboWPN/si2+u0HA2V5J0DKyQDNHg/4hqp1XOZY00P8GLXk4mGm/UepHGYiEvI8/ZwXwn4N0mWpyXKaly+ljTUWsqk03/jqUTiXDENvsFivLk+ogAkTpbp+nOKhWj3R5C7jHNZB5BF/EoUsOQrVKsZle/MMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5tJYx846b5hVW37QSsx47sOn20oXtQNDAqj01E957M=;
 b=dB06f1NOryz42GrMVS3vJWro841HFxW/qYwGE3W6TQ9Z2ioabS6nGRqBK6L4ztu5JGYeglui+ClGKPy+frivZvBjtxmQKaifEGYdHTGyob3ggpIvkWB5qudjjR9XCUbH5DjYuyEJ9/lECK0LL6zq4sPT3pnyRm5MqQtM6Q0IFfs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4210.namprd10.prod.outlook.com (2603:10b6:a03:201::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Tue, 2 Sep
 2025 12:38:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 12:38:12 +0000
Date: Tue, 2 Sep 2025 13:38:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jan Kara <jack@suse.com>,
        gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2, udf: update to use mmap_prepare
Message-ID: <12e0e34b-ce27-4780-9972-908a51bd539f@lucifer.local>
References: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>
 <CAHc6FU4=L+PU5i6j3cH2KjA+PtvBk-56=CaWN3+yHqHrGX=VrQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4=L+PU5i6j3cH2KjA+PtvBk-56=CaWN3+yHqHrGX=VrQ@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0301.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: c6445a8b-3a78-4f94-3991-08ddea1d94ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e+AMEIcfWbyHrowbHpvnQpxkP+sQY/BczJcPdg/tqOqlG8rWkiuVLtFRYoHy?=
 =?us-ascii?Q?eHtq9n8UhujBr0HeaS8+U60kGb5sM2VP7+8D1ouG0W8NKVO2gp23KB6DAmzV?=
 =?us-ascii?Q?FQwWsKIjLgrd5TOF7L8nFhZFqDgsAsrcACfGzyZwLttSB5oo6ow014vS+Eol?=
 =?us-ascii?Q?TdH6ruR7H3V3MmPPuMv4GQFtu/1jTtEEKvWZUeY0u2wyqGDzSW5A84gjDYsE?=
 =?us-ascii?Q?Mzzfyr8pMeQsDAsPM+XxoaGsTOqH9d9mznsjVCwQ+306+WG6iQOQn19DxGh2?=
 =?us-ascii?Q?Hide93bFhvXq6uPwxL3RSbfVKYM5az763MtSs7sH7ZWVF+dySFD0EyRJUtC7?=
 =?us-ascii?Q?dnnFSRblI9Yi6D1dT2JRbh2fZEVMPuVtN0THF0PgrYF1jRcfM+F0Ygq/F0wi?=
 =?us-ascii?Q?V+kfQky0VA6PgedJ5BkgG2iJNqaWJ3pszH0sTwLcKs943TxUeCjOuGVUk8Lz?=
 =?us-ascii?Q?0l/yWiTSNntiq0Z/Ap2pfoeZMsrh2pI0vVQo9RWGXQzcMrDBk1wFfMxJ2N/x?=
 =?us-ascii?Q?0JW4yVrey8vVX7UsQ9yDtTnTnup6MaXvffoP58nwkiKAA4QWcDYWG7sJKoUU?=
 =?us-ascii?Q?YCdCWLLU8aUshmvx03Y8QbiFRoYbx/yj7FW6D4TGGaBZqGM+dYcUjwBUMqu2?=
 =?us-ascii?Q?2uPjmXfyaMa/k4heQ6v3wlube/DVi1s3kAud9qeijw5rtB3ZDXP4U+/HL+7s?=
 =?us-ascii?Q?Ocf5EaP7EvbT4wTe5o1QzSykjJqPbyGVa9klYD78Wk0IRBSB0zoXFpHvG8y/?=
 =?us-ascii?Q?uJ/Mea7OFDah8PqePdtG165xdMIsBU8bVd4yzZ3EMenbSlZTYnButCWuZk5A?=
 =?us-ascii?Q?bi/BVeuJuV3XlknXZIA1KN8jFYXVOujq7eVhyMpWQ9R1pEBp0E/PfFyaBDjg?=
 =?us-ascii?Q?e2I6be5+koHeKhTjOsnnu3rGajefO+acv6VKuIHt5QiTmK2aWyTylmKz/IAb?=
 =?us-ascii?Q?OqrEUpGIBMs5Igom7wQ0+qwbDZy9PqzesZoZ7X93R7BVKoKLA/4QILOZZ+E9?=
 =?us-ascii?Q?XV2bxHjfugl093zwhI/uYNDzT4H09n541d0xcVBgR/tyVhvZqHV53NiQrDoZ?=
 =?us-ascii?Q?OOzPiL9eZ3WMh+8talFUhC/3l/cAf8ei8HZmTzvIk7kQxSeYHwWmPWR3P+bk?=
 =?us-ascii?Q?0lnnG1cvWun1FpCCc5413jx6VEZKvxgkqFVTLSwtZxWULTONXjKDsQ/4WDag?=
 =?us-ascii?Q?xOZcFIdas9pIBeecS2DJPVjVyiJPqbIylAcFcCJNBKxZCuiUozjQApmjtmIS?=
 =?us-ascii?Q?yRBtOP5kWZs+VkhDyrlt7AKvZF3UN4prmHMU0r9PSx3Yz4e51eWzHRnn0xff?=
 =?us-ascii?Q?RhtUWKi7wxrNwUgN2q5Fmu1TSzOf8c87ljXM/motnlpW8Si13tfbUcf/cxa8?=
 =?us-ascii?Q?RVM+wv8EqbDOTBlJW4vzyU1/kWLdh8P39cwDV1cEvblYWq/3IFxY3+5J4tzH?=
 =?us-ascii?Q?SsgxzgYgwXo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I1Prt/6fDXsCPRFmFPKHUIm6xnU8ZHl9pDL0heKzyNaTbLXYNzuKkHY5lkZ0?=
 =?us-ascii?Q?Af0hm1NOluyzp8/PVCOp1RUAmTR/7v/5yIKvx3R6FqvjNVz0MONUhS6rglJD?=
 =?us-ascii?Q?hodJXa6itXTYQYgHUoLCP9o/FebQ4MUAityeutwLfw3G2qriPDBIuVtPzIum?=
 =?us-ascii?Q?G9XcxEqOu/NwwYQ0zsdLo6BML64CHTMJxNFQajJm3eM2ph7miD62X2WBM0vA?=
 =?us-ascii?Q?UJcSRHD4E1YfIkZ2/cW847/A8eJBjeHJ088lFh2A8GVQIF2KCTjgjsiVispI?=
 =?us-ascii?Q?wRumQZDO5qRsz2sevgCRNiBOe3+ftT2kRBrwPDITodQJklD4C8uz4wYxL50q?=
 =?us-ascii?Q?ydP7x2Z8sRLqKaSI/9jMrg11XGoBGqNkbwzJ9VNS1F9TM6F5xvjfJ//3qUcr?=
 =?us-ascii?Q?SAHhCHPg0wwvU8XH9BpY+LY9uo0fJxfQkFr/GM1FoMhrDa8ssMIiwf+OTHH3?=
 =?us-ascii?Q?QwNQObbsY0P1U65SU35S4JIsgCyzEWiqbJ6GQMc8gIlD3/WYwh31d3F+fNIJ?=
 =?us-ascii?Q?GN2spQWqAdMao6m8IWVVznRtXyH9vdf1LY0SXhjiAbpnnvWRzm4zEvrUgMuh?=
 =?us-ascii?Q?GOPjQTdnzYbOOl/YSHFlOUU8gBZFJ1wFPRtGqFbxW5ReQ3GLaw99+1ymouE5?=
 =?us-ascii?Q?NwkcU1F9WrfviOD2BrroYWKra/0kjc2/3TnazU1sHRnPn/RnHmdN8cXJ/wq+?=
 =?us-ascii?Q?GFgLODdEdqOXdWTLlij6kBjTONDC2+8fCRxVwLSDJeQh+YSjBX5n6H314RQo?=
 =?us-ascii?Q?i3IQo9IZjnidYw9NkVY3JAv5hm7nyPXdxrEzuHOWkRqzzCM6chAkt4eSu8lM?=
 =?us-ascii?Q?dL2Ukg8NyA3LHHQM8fMdXM1+GV1AHhv5gpGLv5M6ydAVC2PcxBIEdgI65wCh?=
 =?us-ascii?Q?tPmEZNZwW0EgMqyL9X62cok/xYWQdJaXnXiTVZmfmI8bfJFBlWI2hXihSEfW?=
 =?us-ascii?Q?i9r+/wbXnXc99BMHPYE+cL4ohtTjkKYuq7BV7yTJRAscMZXN5ECZxABJUUbm?=
 =?us-ascii?Q?ofDaqqIPH73lpH8a3Ru5+0Rty27ncZ06kr2/eg1PxRVBx/pIXPBD8lNVPzk5?=
 =?us-ascii?Q?zgNWfTocVXlTNfKPfWWCsXydU7hIJYmKPOzalN0eRbfsAK47irXH3ZiqhTqU?=
 =?us-ascii?Q?38DBTr2suMI93MV4YxOmJVrNfvuoEkWsIzgHxyqOLfzEZdmy3yFhkVYIqjmp?=
 =?us-ascii?Q?BVYCXS07LeluK/cH6Kv/gjSpkWVMFLWWcBI3VvhiaH+YmeG39gTAoCh2KJjA?=
 =?us-ascii?Q?R6CskHyAA5U3r1+74Y1N/bQlXxWByHPNwH/ncPzBQ9lZQqEo66dtJq11Dovy?=
 =?us-ascii?Q?1avOevrzvP7AVXVhDtCz/LezekOByz9AVq1OPyIM7re3Bvtux9LXwHtdg2/0?=
 =?us-ascii?Q?B6bFA/fiU1F3Z/XHysUvKbwwTTU2StHhKbZQtuuM0euejn0gfqT/2QWqkY71?=
 =?us-ascii?Q?4lqm92ICARIpLUEZMgIRyiIkywve0Q6i7Iy+50ipM/rIb2bBXLo+ZI6vObnb?=
 =?us-ascii?Q?oID/uVud5bfWrXe8WVhjc9EDUIFgT1116EY92Tkj6dD2wgIrOOLclQHrhj5x?=
 =?us-ascii?Q?oodmaa8kbjNHP+W7+T7LkX3IOcqotLJT1zZL0udRc01xjCCtxJ3E9LCI0UIa?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a7KkCbdfe881Z7NhxH87OEuo9MApfXJSfOUd2IkfZvYtgBUSyPEDqwemXwo/HFzkpFOfUseubCCTnYuakgB71PP3EEMNKGja+ZLsEhtdFOXnJRG6kkqQrq3iWW0djqhepa8f4vOZilN3L7r9qsPMHP/1DGLJfEEkVCRBw15xqW2h0F+xytktTi159Yco9oMNbDSnf4BdxGPmbwcMuklcN/De99RfPMrbUlkmnxDIGJwl1VPH/e8x5LPxIw1S+iwLp+d99QoHuzMrcXNPDV3VCojPdDMveVa33HjYlTozh3nWyac354Iv5VHTFJUmcS/jAfgHjvVDJznUFKPFu8fT5fYTKmcHNdlk41qjJcLTJYKz47ezVD5I3DovgMEmJ9gq1ELEw0YmaUsgEh5mMNzF8rxyFL4oDcMrrxI9Ptk8wMlKflsO4yP4v5lVAcIvh6VSm9cDY7DiXG4HWmelTA6MtYGcgDSGirk3CFQLM1s+dBiIUNwRFXleiZmrhprg3nJQwZiuOIGPvK0k3EnIJm2JcRYkfCqWvZc9/vzgKiS8TIMZf8D2VnPa4twRjgr9jrI28q8dF7fXCpg2Ka4KlgeVOa0cPDHsMQJkjAN1jlZDfOs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6445a8b-3a78-4f94-3991-08ddea1d94ab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 12:38:12.6208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiLByU5LgIHNW+n3W3MWF0ahAC9LLDBB7YYkV9JPjF2DWxhiJr0zEiP0+zjQ5woUmGoC2VUfh/AsP05EOrVD70ojur6I/hOzMj63LfrCAjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020125
X-Proofpoint-ORIG-GUID: jPtmBCbhwDrpnGNDb_LRyqEOccO5_yJo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX/NorCD8CcI+q
 NV3DRRCXs1kuBtH2iFgVATnfZKlMEKYRW5Lm0V+eOQMUOw2w+zAWeQW+yxAEmnC0Ux8B5QsCCEp
 xlROjGHrSg4ypJKmop/LwgWX30g2MD1/OzrafQIwgGvOSKO41wzlYe419GgbkLfIoIxOAwhfNfe
 jOYRCetD4SBshfmehqtyKrb9OvIpW3UytokiVg+BDy+YV0sMnGKDeEkFHwa4e9CVHgTgq05wDmq
 gl2PbWXctx3N6RTxG+jObTAJAu4H3oH8L+dWRKFv80DJC8vDm1CJtzQ7ehfKSK9XAQ6VfwNRt8C
 ge9JnBXyM+JZ6xLcGz3+pYW9Rj2HOOUUrEy5GRXid/hgdaFIAJ+kk2i+0Do4FGTW8YhTMLSB9Gu
 2uCTALxU
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b6e538 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=uRl7u8Ceap7dBusa15IA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: jPtmBCbhwDrpnGNDb_LRyqEOccO5_yJo

On Tue, Sep 02, 2025 at 02:34:15PM +0200, Andreas Gruenbacher wrote:
> > diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> > index bc67fa058c84..c28ff8786238 100644
> > --- a/fs/gfs2/file.c
> > +++ b/fs/gfs2/file.c
> > @@ -577,7 +577,7 @@ static const struct vm_operations_struct gfs2_vm_ops = {
> >  };
> >
> >  /**
> > - * gfs2_mmap
> > + * gfs2_mmap_prepare
> >   * @file: The file to map
> >   * @vma: The VMA which described the mapping
> >   *
> > @@ -588,8 +588,9 @@ static const struct vm_operations_struct gfs2_vm_ops = {
> >   * Returns: 0
> >   */
> >
> > -static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
> > +static int gfs2_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > +       struct file *file = desc->file;
> >         struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
> >
> >         if (!(file->f_flags & O_NOATIME) &&
> > @@ -605,7 +606,7 @@ static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
> >                 gfs2_glock_dq_uninit(&i_gh);
> >                 file_accessed(file);
> >         }
> > -       vma->vm_ops = &gfs2_vm_ops;
> > +       desc->vm_ops = &gfs2_vm_ops;
> >
> >         return 0;
> >  }
> > @@ -1585,7 +1586,7 @@ const struct file_operations gfs2_file_fops = {
> >         .iopoll         = iocb_bio_iopoll,
> >         .unlocked_ioctl = gfs2_ioctl,
> >         .compat_ioctl   = gfs2_compat_ioctl,
> > -       .mmap           = gfs2_mmap,
> > +       .mmap_prepare   = gfs2_mmap,
>
> This ought to be:
>   .mmap_prepare = gfs2_mmap_prepare,

Apologies, I missed this one (didn't set CONFIG_GFS2_FS_LOCKING_DLM in testing).

Christian - since this is trivial, could you fix up?

Thanks!

