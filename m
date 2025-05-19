Return-Path: <linux-fsdevel+bounces-49400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF73EABBD08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563F63A9612
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1ED275104;
	Mon, 19 May 2025 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pnU/Uuh4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0GNEWTVT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9D265CDC;
	Mon, 19 May 2025 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747655795; cv=fail; b=muoRxxk1s23/jIzFPmSWRKGgXdIKFFfLeQFEVtaMD6ZNFCbuKIsWlO+pVOJOJ7wCMOJY2zJbDM4ISeko2GQVeoWwhzU61sfgOY15P7VxInp2MRBVTh3jQ4SDiNCfT6txJqm/uVyqx+o4No+YGABra37ujDdoXfT3MrVkJ7hwqaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747655795; c=relaxed/simple;
	bh=6PlYQ41D1bKFgAk8btaiMJ7g0C4ERT7fDqtIMwe3X7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NyVqHhb3cuKtjy+fdpD+4pdLigUwRsQA+AKqoSdqx8s4R4W+yfDkQP62xxulHZ8EfQZp00UFAnbA6PV0BOprbZEmSbPfVRYaf9wER6gatsrh3jG1i7ntlTOm90w/c8tVqMH6Q4SjAy1ScGFQ2xxlggBfcurhmUGpGnldeFRuY4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pnU/Uuh4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0GNEWTVT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6ilpT012741;
	Mon, 19 May 2025 11:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6PlYQ41D1bKFgAk8bt
	aiMJ7g0C4ERT7fDqtIMwe3X7s=; b=pnU/Uuh4nShbc7L/Q3xA8PCgl0uKjgK3Ux
	AjP4olBQhButT13zqarI2M1EYwRnsJJRzjYPgVKSta1ePGpSQb7GSFVBgDBmDMbc
	XVLcvWbo8Vp+uyBZykLrOJjD29HuSj7sLEVmlmw3EhuNxqjkZShiQeY2ouUFfNER
	vXvV8sZm9JFwm0qdBp/0ZoMAkn2/C5oG3tO7dKnNiX4VPzn87UNAB88LKRnEG5Io
	cHdCsS0koO462fCIrj5mm8QDg2P8RDJ2SbIJ1b4CjtCcZzPAWW5GY+NseZbrm/+r
	d4ra7KW8Jh5Rx10ftohsRwpOV969yUSOn0ZB1xFSHsgNW6f4eplQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph23au5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 11:56:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JBk1tb002582;
	Mon, 19 May 2025 11:56:09 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012013.outbound.protection.outlook.com [40.93.14.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw6bu24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 11:56:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNJcVyZRFKTs9lkZzpAFFrqUVQbVZkm5e9gM33U9OAAcJPGT1I4nR+kwTUWlxWUTUht1jHanfNLA7Ctfosu65bnznR0XW7jj7VY/Gzl1SSepkupeSec6cLs1yO9CCPp0mOqagJKxUw/TkD+3CRT5LDvzxuSPlZedK4XMgYwaEtnnuRrmLxZYcb1uRI+mB1/9ejhTtOEgjYhmkbfQf2g7wwg2/n0gkOG8Nv2Ops2URLzbQSdJwq9fscdsAqJaIJIAhOSSmQ4G8Ngz7QOThIBsphoCGBbo8jZvpzjQEXq5XayVxV9sZxBcYNjoijrGbTlYGeY1E5bHspcoQhyED0dvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PlYQ41D1bKFgAk8btaiMJ7g0C4ERT7fDqtIMwe3X7s=;
 b=lsfc9afeYoiLmiHNWtkILqD52B77cvFlC6exxy+82x7DU1u5sY8geN2RMYYcrjBDA8fw+X1m8ghfA0p82efOgeJdXCxjuWoAYgWJB/rOTIZJdG37sU76jZdM715ot8cnolp7BvlfRvd6Sy0c/VUw/Fnk7/UEARmT7+QH2gq4KodXlN5g/kt572+jM/LAGqDYFaI7idHBILDM7ZxzHc7J7QSTg5teJ43WPvQIxnoSutqnAoTq3LN/PrAzXQh2xQlWMzwilKbG6hudQ03aJdozsSifADK0Bl+DA4HJxmpa/W1oVKdrfKNZC13qRsOkflOJctlJTh6soOWe5t7dJ3PnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PlYQ41D1bKFgAk8btaiMJ7g0C4ERT7fDqtIMwe3X7s=;
 b=0GNEWTVTS2d6NcApdFgjThA8soSLad1uiW+Z1BxIJgvE0Rny2C6Rwch4Won/ZgTr3MIoDnjx0SJUla9fpJHZQAgbCJxyJJ7sXI7lx7Lnqg6qMqYbktYceveiQyrEF0LdJIuzsEvv3KTDsWynpZI4koLvEFS8vA9LF2O0pgJg6pE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPF44A241B91.namprd10.prod.outlook.com (2603:10b6:518:1::798) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 11:56:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 11:56:06 +0000
Date: Mon, 19 May 2025 12:56:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] mm: ksm: prevent KSM from entirely breaking VMA
 merging
Message-ID: <bd7a2e05-af48-4d0f-b546-3d053690eba4@lucifer.local>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <135556a3-9b72-4ec0-acc3-21ee0d15ebe3@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <135556a3-9b72-4ec0-acc3-21ee0d15ebe3@redhat.com>
X-ClientProxiedBy: LO4P265CA0100.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPF44A241B91:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6b8b23-ad75-4832-78b0-08dd96cc2306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z5FNyWyKPeZXRnOm/6+CbzW5OajVaJSyxHD0g4FMdFOV79fBHu19kJVaMeaH?=
 =?us-ascii?Q?33ZsSLSiV1hspp+q417yad0V6vhaz3uWt9aRb7y4KdXZ4lCHATTWvxppm4hK?=
 =?us-ascii?Q?JfaLkZinzCilyEA8ew6+udREHQPgA/RPU/lfqYfKXtZ7hJVDA9YK/HSKZqPT?=
 =?us-ascii?Q?m3Ut30v8C8YMzDxgH7LaqjLNkLeOg4aLBYzyi5AbC67Wz7xllyCfmeCsamhC?=
 =?us-ascii?Q?bMJ7UTFGjpWAYTNGKPUKjMOIwQUG7LwEQk7FtoXkEuWzP+Bx30poQzuWmO33?=
 =?us-ascii?Q?0nWhe65SMXv1cKTUS7avcKvdLi+tfK00s02YcXFfWFYsXxPyR+10NvqcCCfJ?=
 =?us-ascii?Q?CwpCHrbVVedhss5b/TU7p8rtc+JJ3yzRwUFienrvSmOeashIW1ne/+H70IQ4?=
 =?us-ascii?Q?A3mPKtXyRqKaxERDo0IC2j6V8nUhXetsUnqvBVlrrSEr48OVtYw6ygSW5Z9I?=
 =?us-ascii?Q?2R+B9AozyNL9dq+ajU45tWQZYpfnAL4IPXoN9aWu9eg7risPDtXzQqK5F+Dd?=
 =?us-ascii?Q?goHGZX5hULpPbt1+j0WQ14m/B3cXbou4wHdCQgk5oTaNjts45s5nQyTYYOq9?=
 =?us-ascii?Q?8Erz/ukr6V4naiSRmK0a6eBHPxA8T3lQnWomNw/1Lxvpn/1Qkob5tRn8/8ay?=
 =?us-ascii?Q?X5xsj9ILbCEeUl8KP78AwWosxppNF922xXckTmUTYVFDamOjZ9sAqSY6Mfu5?=
 =?us-ascii?Q?+JBQ5BAPtVlKX5yXGonWoc3P4qQiEryin3p3xRa6dNnSPmX5mlBXPvN5GR0g?=
 =?us-ascii?Q?pLozTaOVdciOrjKbaUmfNuMFvFWf88PHJx0DBnG1PDem38/DPm6uhcy3W3St?=
 =?us-ascii?Q?XxyxZxSg9Ez0l4TbPvHftN/pvVLCH4sce29UYWL2WDkWyVpOA/7Y0rfGkXlM?=
 =?us-ascii?Q?jvrtsT7/oxaa2vj+pcXVB6bvDcSEc2RriTOzePr6LGy/RtJoPVYmw2Kq/kOP?=
 =?us-ascii?Q?J1HTW0mDDMe5c5cDSi9WepdOF+3czfQTBY2iUj1JtPglQObhH8Z1FoYJjahg?=
 =?us-ascii?Q?2Ph4YfIWvbRg/yc07fHICp2zrQzaxwq49w2GNE051jRIq7sHbTsPhsKXPWU5?=
 =?us-ascii?Q?EOVI3LL2UlO29RBFFjTGrK9UflEnyxvHnxgMcUlS4jaGmckcI1oERGh7nMFd?=
 =?us-ascii?Q?LPM39Crpwcxv8GT/H+AcKRCqm50Npi5hYoXQiRxiyvxClubV8LGVnnsrajBs?=
 =?us-ascii?Q?Dp2S7nXj/QrBNP8P6unaxiFh0TLMx2f7/F1vUWDFkJx5XQmz1b0LZwtCb/td?=
 =?us-ascii?Q?X2+99t5uU2PQEGWE6wkatew3J3jUX/sWRz5e2mzDNfD9YSqrhudcTjx2AFZC?=
 =?us-ascii?Q?GiYPEnCGniYcoUraN1A3TEHCCkBuRQWKbHwmFTm8io7AAmWD5lRtovTOIGZ3?=
 =?us-ascii?Q?IPRLjv9HGnfhkxZKYhu6CwZUV7+1+N01JnnkcrURFFnvEIsy+hsQW2mioIdN?=
 =?us-ascii?Q?LIW0BZ5IQlk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zr7dVAruRW1NHNlKgdqrh/9VoNM/T5rW6afew0Qg7vlSliTcBdEMErJMjVS6?=
 =?us-ascii?Q?gS2GqeJKrhLfVi4KT0mF2xHCV08M14ddjNMpD9v7pshyHyIf5d92RwtwSHgi?=
 =?us-ascii?Q?gj2AtTlwiadXrOb8GK6g5dtDEzj0J+UosX6whU9DZK4F7sO6sxEZH0mqAIBz?=
 =?us-ascii?Q?lLirT+xcvoGbbRHxGRwR5dYPzOvVQYB96E7vox9Q20/e5GvAVnMvrAOCs3Wh?=
 =?us-ascii?Q?Ws3wIeKkcTjMMLUk5OqIHlcC6jQAT246frxo1ieRi4dY9RYayaEqC1UbZxvC?=
 =?us-ascii?Q?fqYGbN9wqewot7Vj60TA7/2gikIXgvWYFrKC+JBMf3CkRxJDcwZh7npy1bG9?=
 =?us-ascii?Q?Kv/K6ZHzkSykwToUdRaJuJFy0sWWH8yk7hg0QnPWipSwZd9o/fzcB8gmgLAE?=
 =?us-ascii?Q?6MB6EfcdpL94eFXUhQc6i06L6m4DciCu4217OX6ZMefG3/fjY9xJeLa2YuXc?=
 =?us-ascii?Q?iNBuokQ8hBfeQgBBpvG3CyTMpoyNwYh9hWU7tSFNgsLpg5oXg6TdbmT10S4o?=
 =?us-ascii?Q?ZbNYfPl1BVLmbxQIUOZmBE7j/g+m3pIIZ7GxfSFKHePleVHPKRXgyeOFQJnV?=
 =?us-ascii?Q?QhwuBs+r1D4K7ANOJ/47EqHPMguC69l2SjSts3pjfVg55M5rYBBPmqCTxwlO?=
 =?us-ascii?Q?myQuHk7D0VEPpOmbo6E4ETkJaBReQqnN8ydB0B49VHgOh3YSFE5mDXFBFLzN?=
 =?us-ascii?Q?eDbEnGEkmQAjLKOF7s3udgiuqt85DZO9GtwkAHLnrIQdnKKqQL0LNsPVoooP?=
 =?us-ascii?Q?F158pSOmsMExsY7LTO6hjK2xQl6ePO1nXK/yUWYBgNMhPj1+ahSXYURGHF/P?=
 =?us-ascii?Q?iNb/6DCvRmPuPgQzqYwfUvHlCXGT3v/6F0phWfHqrzV9XKocLpN47SbJceU4?=
 =?us-ascii?Q?vnb/pe7REF0V6rdyUJcWKyhx94k1OJYKZpMTcjwfHBQ0UJN8K19zdBN9irCT?=
 =?us-ascii?Q?5QG7C9l1h7d59NBwch2abBP2sa043R3gE7HeJJipXzaa5ArnTdFBlAyhIr3w?=
 =?us-ascii?Q?S0DkkH+C5zS+86fZaP4qaxStzn533l82xRMhbyBQRFm6Qvw5j4/8WNQkG1tg?=
 =?us-ascii?Q?Fxp0H6nTmGDB1/lwJkglxAoHi1tQu7fZ5Zj3cW/sW8Tmw3PzSJuFBB1zh0hG?=
 =?us-ascii?Q?CvtD9FmW/Q01y9z7KJDwQvCLkCABNvmOdFLZUCDUTs4GhO+FvdilxdVFDzqN?=
 =?us-ascii?Q?nGim4VXFi/trTTovNzg2FiANeAfMSFnHEttieRGgPA4Hrx4eCyTiF/FJIy2e?=
 =?us-ascii?Q?FWWNbU7R/Wx0XGZfPDwl0Ewr9X7so1OvRMUOT149pxIsLJMgcB3Cl+OgVv9d?=
 =?us-ascii?Q?kzcNl5pzNH8pZQCyUeHIsOQ+4zSdKPfiSUMWVNVrwuI3aqGQ9A1WYJgO2PUH?=
 =?us-ascii?Q?DbqT3MPyAj5et6hVoMyQJIe7k1A0/l9PlCFi4QCZby0dPTpSAb/4jNMU2sE+?=
 =?us-ascii?Q?uuyCJgU9j8gAsO7yZnee5prRSt6JU17fXgbh2flFGu5rMno0JrMXYcj/XKFu?=
 =?us-ascii?Q?qqo0w/MfEr7iGU69wI1FJsXVYUW51WLNCByhfzP3yQtFYnTwBl2io6rlITCX?=
 =?us-ascii?Q?bWPludKAt7IWDC4wRo8YxLDLGTh7x2HSuGv+sLtVggJYjBHIYkrT1+SEHwZX?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lbAaO80MigI1IzwAUDHXTpTKVbS+gW1fvI8jn12h0CopFFfueiyZGdX2D/uoICsItI/bcjbZVDR8/gbs3Dr4KARfp1MvSItR9htzKc6CiZgql+dAVogukr3fhAKMv1nMd6dSCfC0taVdTVF70Y55TbQYfl3Dl3Xb9bbvdvOQ46HyYm8bv5wsuFoX73lbKdCA7uR/fgCYl+r3fjLd+34Safmz0I/SbQJPK046Hs7yAQyHh9wpS8eqvCn2/sXD7+z3ufUJaCtjAi/0tcvvQRXW2RnEr5M59xoIMBzUtoq5ZgiFAKGeFYKCBvxRNBdHvknWIieP3HdXBSw9EZYcs1eslw9KTRFJoXp25QUkZH19mqR9xGb7o/TYndYOrGfwoEbCjSjOHCyg4/FlrriNHyDQJYXkq3qfJaqgutcPaCLgVKnAbocWRNXBeAHUDcJAvsnA1ouR7uVj9EJGytZVdx82nof4zqF+2boMteGN5Ci2HVUzff4nWzvUgod7FKcSdWBXF7rSogFoeytcZiCaYARP91kAv8RkwNMH6tsiHBf9SGRSzT7QaH0Kd25+7lZTmcTJw2arcGkhtQWxzaVH0DMaYvi03nyCWg6M+V1mEpp85To=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6b8b23-ad75-4832-78b0-08dd96cc2306
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 11:56:06.2766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qykv4KM/gCERZ1mEzRQonLwKyFLagm93OPJr+7FaJZF03Z4dTPvRetVeHKEllqebEN932Z4h5/wIO6tCNhn73Yv8lE+Jlle50Nhb+cbKQqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF44A241B91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=914 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190112
X-Authority-Analysis: v=2.4 cv=GN4IEvNK c=1 sm=1 tr=0 ts=682b1c5a cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=2jawkCiR8wENqFlHrgAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ucyzGrr5mL26gMVKX-uU68TfnFpFjCrW
X-Proofpoint-GUID: ucyzGrr5mL26gMVKX-uU68TfnFpFjCrW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDExMSBTYWx0ZWRfX56vVJXbrzfno osRVhv5z3DExeOBytJIZkJSpSPoO8/xw+a5kD0Uf+om61Guanfc6cLZazMyBiOoIcHtzVWmN6v9 tyDTW6TVpzaEaCPIo+jC3gIH91y/kTXs9rmEte1xaCwEDdwucrCgWO4FJwjtmvwWzlK/KJFgznJ
 pT7LAz7SmNpA/NOCS28qqe3i1SCYqKKvsqdHUYveMk84z5HAxN3M2S2aSLjOrLC5g5g1IZ9Nf+1 V1pymd9xFgGZmc8odp73IJVVy9JIoeVel34q8DsLhJ5aGVjIMqYr5bfiiKS299zVzTD0ek0PpZv pxfOLeiaAAauFDgn/f2ynveET9zDExPp5CgGwntTqjD4tZps73YNaqAph3lKJdXs5moBB1bmUcb
 JHQhR/h4wcPWqYu15jd6eD3xmjy+oMCXQY/ufWV3Ib79NQgNXl5W55des5n6r0pg0qBveq8X

On Mon, May 19, 2025 at 01:53:43PM +0200, David Hildenbrand wrote:
> On 19.05.25 10:51, Lorenzo Stoakes wrote:
> > When KSM-by-default is established using prctl(PR_SET_MEMORY_MERGE), this
> > defaults all newly mapped VMAs to having VM_MERGEABLE set, and thus makes
> > them available to KSM for samepage merging. It also sets VM_MERGEABLE in
> > all existing VMAs.
> >
> > However this causes an issue upon mapping of new VMAs - the initial flags
> > will never have VM_MERGEABLE set when attempting a merge with adjacent VMAs
> > (this is set later in the mmap() logic), and adjacent VMAs will ALWAYS have
> > VM_MERGEABLE set.
>
> Just to clarify, you mean that VM_MERGEABLE is set later, during
> __mmap_new_vma()->ksm_add_vma()->__ksm_add_vma(), and we are already past
> vma_merge_new_range(), correct?

Yes.

The self test asserts this is in fact the behaviour, and if you run it in a
kernel without this patchset you can observe it in action.

>
> --
> Cheers,
>
> David / dhildenb
>

