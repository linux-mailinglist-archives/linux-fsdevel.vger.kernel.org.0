Return-Path: <linux-fsdevel+bounces-55533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D978B0B7E0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 21:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D002D3AFA26
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 19:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6820D21D3E6;
	Sun, 20 Jul 2025 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iaeIeFvA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NHajvtMJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C66A33F;
	Sun, 20 Jul 2025 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753038443; cv=fail; b=j5kmHHfV4kXNgo5itEBTVb4AFfAc8QcCwlBO5h7xcamdAD/Wpjch13e8BTgcs511RH2tyqJYHqqa6fLfPJwV84XFMiqV8qpAlI2VAAw5VdbqqHKH13H4zxFXSw8x36nRpfeNOCCMOPbUhxmlCObAXshQUsYJFAkqVkrAhDYySxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753038443; c=relaxed/simple;
	bh=ykMr0i3nXhVnnHa4EtDG5UnvYMxsKZ9UknsbTb3a+rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gT6gyf02a9toN9c3NKJVWtgE4v5Q2zJd4/0kq9EytEAfExLqpURqiJbKQjc/EOe1/pAWpg6FNwDkIZgZ8B/ePdrGyMSqjIj6JI5klT0r6lS9lTgExAl6Z8QPTa0737L/W+nLNgUYmBURyJW18GRoCND6xuj+q7zwgjX/Utg0fqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iaeIeFvA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NHajvtMJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KFbVoI014362;
	Sun, 20 Jul 2025 19:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ykMr0i3nXhVnnHa4Et
	DG5UnvYMxsKZ9UknsbTb3a+rE=; b=iaeIeFvAIpqfiLhaV/gxbJqRqBkrnJCo7B
	pF4QoavmP0skYx8IBskT2F/58dU5makzbd1vCHPFoQoJY/VecPHf+w5y4I4AXT8O
	U4csarUmXhFlV8nWQ5zAF+wZjaYOGKIlQ1E3f/tuE4xpjbD/mSox+CuNnPD3ZE5C
	IlQmoEfvFVCMFhhu1/FpVaOcsCJgc5fF0E0EzcyJ/iba8vKiV2BXhCnU2UZEMAtT
	f2hiLsFpWnbxqgG+vcW9NLcl6+Z9ITW0972y1vnw13zCxDqjbsQYZT0SudG7O6FU
	D6nHfck5gc/sIQYUCkqILu8VVh4B68538tbk2W2+TANp5OMAZHiw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 480576hdrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 19:06:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56KGf2em014553;
	Sun, 20 Jul 2025 18:53:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tdk4u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 18:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtLmbK819Wk1wqe4i4tveLfrjqCaL9yXXRGCxJV3tfoAz42XVZ2CxFN6PxxEypxfUfbxJQZoz7+YP65uZvIUtJ02+DCkf/fv6ESyRvh5shKUAlfr8EZGe8KYFWjRs35m6cLOOLjP1J7HpbJH+nysBDyfw5JfT4HF9pz0ebF9T3CrSOION0sC+GQAYkQaqefGQWWGIMKPjGN1I9hEkmEZ7TBqDP39f2mRHH9KYo7/tAYR/aNUDelLm8/Fz59TJnhidhHslMQbapWOa/s8+bsqnqAD7Ugivge02weLertVowymTEoVLNLS7Mej9Tcg4hyfvizmlGzywi3J5w7XwhAiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykMr0i3nXhVnnHa4EtDG5UnvYMxsKZ9UknsbTb3a+rE=;
 b=boHcoXNdzXzBH8Eq4vDmBxoTgANAxiPQr+pIZyTsgD8+5shY2ib6QhVhyGY1lztHgHsHH4cEftHHzFbpwCX+xtpsbCGye/Jc5GCEK3BK11ej8drLxYwdz5lSVvMLIrTD5ds5mL9/rjDF6VgHH/MVqIf8W44YJv27UJUfPAOkg1+pw2+j8+FcwfL+HPo+JmqwAUYDu8C97xZPVZgg+JLkXw3ZASNUIbEMBS38L+fMoLXNn367Gq+WWuG+KvDrjxnQtFdFmv6UZzjgXO/DiGlZzTEeaYGSZc2JxMYILgjsOmEyeQJWq0lUmJyhEkIG3bLWlUgCzJOTkj1lwCK6lRs2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykMr0i3nXhVnnHa4EtDG5UnvYMxsKZ9UknsbTb3a+rE=;
 b=NHajvtMJybM3VDUKuvBByyafByt2IUW9GIsyoYKEwgHuakM0vDuzurb8V5Tq8tL1xMUV5IhKfcfKhDhUqtyM4cLK59wwl8vNoSrrN3gBPwdD5D/GHq3OVuL3whcZnNk04SUHktCMCfme96izuL3EpXunXjVUvva5ksPi9pxRsz8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8733.namprd10.prod.outlook.com (2603:10b6:208:574::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Sun, 20 Jul
 2025 18:53:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 18:53:01 +0000
Date: Sun, 20 Jul 2025 19:52:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 06/10] mm/mremap: check remap conditions earlier
Message-ID: <80c43a45-afe9-4ec8-831f-fee68fe68fa2@lucifer.local>
References: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
 <8b4161ce074901e00602a446d81f182db92b0430.1752770784.git.lorenzo.stoakes@oracle.com>
 <8fc92a38-c636-465e-9a2f-2c6ac9cb49b8@lucifer.local>
 <20250720112914.6692e658f4c5b7f4349214be@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720112914.6692e658f4c5b7f4349214be@linux-foundation.org>
X-ClientProxiedBy: LNXP265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: a46516f5-4c6a-4d99-936e-08ddc7bea684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HECLsH2WQfnX6hrpWq1BclWxtzfB+85RPQmExhm3XASIzvVzx4OouxwCNBzH?=
 =?us-ascii?Q?OqvYAfUU/RfyPeJsbZo2lumo1QSG40zPP4peoqZA/yqu9xtai6WEVB1FIYbp?=
 =?us-ascii?Q?fFzR1oDbpSSfg1wiAMSvrnfGZl6pWrJi+pS6bBARDZHLL18rVdBeZ3cNMOWb?=
 =?us-ascii?Q?VUdFPkJk/VPF/idzghG8kkwjAaiGTdCqHQJ0wWOLn1xD7hTOk/hTWBSj3qhO?=
 =?us-ascii?Q?EQzezadkYdD+D3RvuP9lLtPanoajMUMr8jo16+SndeCcPJN6Y2UXvZORhxPm?=
 =?us-ascii?Q?g/dqPlfwgEBO5eBofjtV/PtsKP8CBOW+iOFeLSb37Mzm3tv3mBnTOd8ahRx2?=
 =?us-ascii?Q?l6143OLFKVhIMlEfDbLAfjdzTgpmlu8aWqNaAWIu5cXLi6ZTQR0LUmtzSb70?=
 =?us-ascii?Q?rFiSNx0fNL0mpyCwS+BauVbQg9Taumoilz24zDZYArQrI5hHDIf513/lEP7h?=
 =?us-ascii?Q?TxcL5kkKMATTiF02/cKVngyn+bO2sC0yq+XEKLLhM3siJ5dBLRvifqbDseTE?=
 =?us-ascii?Q?fGQBRTuPEN9LzHJwa8xJGbg21BmFjlS3OrgY75FcWtmNgNCrbHPAu5n52w+t?=
 =?us-ascii?Q?8RuajXsT96PKtMz7YvDxbczDDM3KIwumMgD5ZnxzzPamSxU89S1lPwhsDObj?=
 =?us-ascii?Q?5tZYcFhchj/bClZbYNout9H5MDccccFen/uRuJ3bwEc1d8BEDK5eDctUlFrQ?=
 =?us-ascii?Q?4ZSGs2+TVZK3poY0k5LHXtLIwjHV5ScJ6gCgeMDFW8EKPMJOtcxuXl0iEi+v?=
 =?us-ascii?Q?+cStNxxW+JJF1f5ZLNTxEEXt/MQVtAXowpdY16o39rT5e3V6XtTTDEsyZZ0q?=
 =?us-ascii?Q?PMO7dSeaHHOn8z/qojxlNknEKXfAc4FCYKiizzCu9JViTSg9Gv4/RIanIFLK?=
 =?us-ascii?Q?ardy0RYxMy2mDakJtIphOXmd6+674ZgErJMnYSnV0FkXs9v3pSLHv8itJBrm?=
 =?us-ascii?Q?m3NlJdqQlmL8/iSWq+3JTONDjgIpXUnMw19gnX6zK9mK0qRpeo0VKaorJCkV?=
 =?us-ascii?Q?r+yA2elU7p55izbU0wh39wDl9R1lyobjZ6Rc5GdPFDeLjq7iKuV5z0v8+sDK?=
 =?us-ascii?Q?MagzsgmHbA5TpZvSnlkX2q10am/w11T1EKoj1qQahFAdkZHfjF5F9pbYGZSY?=
 =?us-ascii?Q?AMLUrHWTbjB599GuO6mUWLGiWMlmcusDzP6N2K6IH3FV6maFUDaldK62UmSc?=
 =?us-ascii?Q?SbHS9P9jwLroZODqjNolhCA8rt+GOd/c9INAr76P+imO8KruMu+qzLsaQuI/?=
 =?us-ascii?Q?I0SXZbsjDMR0ofPq7p0M+wD8kCRo8eenPJRWmkc4N2oHFQG2jDyrF5tfHg/F?=
 =?us-ascii?Q?z96ORAj8839IdgPOxfGo4M48/ZR3oR+ZcWaaTk9EfQTvDgkoqG27GcitqnNx?=
 =?us-ascii?Q?jmKPrsm+3IeWEtwWT5HnmvE/nwWv7PKQYX6Fjbg90Fk5lHlN8dADE0eOfCXZ?=
 =?us-ascii?Q?iS0jrGoHyMA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dUgtH7AsXqAcRF9N3auNjGcTkg/p8M9i2qAljF4bXpHZQPfcB/d8Xun/7rsq?=
 =?us-ascii?Q?F3Ij5q3/DyZ5Xo+Isq9cPsB53LH8bvNVBG28Q2Gbm8jQtM6U2DPTP9gwLbCC?=
 =?us-ascii?Q?mr1E2XSTZUDGeG+CFlsHmvls0ZtxbweHgPDuNC8Z9q5EfT9n3ulaToxgo0al?=
 =?us-ascii?Q?7tO3XEdfpIcUvnzh3Vt+5gWhwpPTpVDqdgJfxgRtKgJyPoMHsyQpzJ3+CZTl?=
 =?us-ascii?Q?qqKknoOsgNhJ+unpyjqFF1+IHDjz3wzQemwW3SezkdaIXN82ZZIR4t0BL3Xt?=
 =?us-ascii?Q?Vka3CW+7n9kvco+DRwl9lS1JZdbwKb0MAp1nKJdBKWhN9ooEn5EC1jgu75u+?=
 =?us-ascii?Q?cDBNATZt9vBLKSrkSTY2fc6dW6AdssALbN0CYTpOho0OGXLmWEQIMz2ROhIR?=
 =?us-ascii?Q?sxDvN+yehPYXDn1+S2y3y+cABIi06Kc+Qg5swOqWLjE5vqgE81vvbhU0t+Wk?=
 =?us-ascii?Q?+kRelmjSxLx+6hoDHyTQJBKx2axHFpEAuv80BySiuKx6DSfIBZNEVbsd1ifg?=
 =?us-ascii?Q?wKU0Cxwp8fptUY8rRmm+FRgg3IR/f1hcLZ0lIY4fL+ClZFE5Hzs74VmXdJ7a?=
 =?us-ascii?Q?DLlFh3NcDyq6Y9MOwvZy2rB1KUAoSMrHWXV+TRpkH7ZAWli6hxrfut4sv4LG?=
 =?us-ascii?Q?WyF8RGJx6dm1ufjJz9xLleS76WxUCCgerU9w02Q9DIrawn9kdut4ie2ihgfC?=
 =?us-ascii?Q?zQE++fYY4JUO9ExYitVpJpkSo5sq9SjimZOwzxOl82K1l7F80IgPtfadLPcl?=
 =?us-ascii?Q?R0rR+IpR/3zVA8lcuGC6uj8C62a0Lclj417pt8FbPDNqziGi+HWaQXLyYI2A?=
 =?us-ascii?Q?aNGKjtT++uvE5DTCX5pckepeMmr1xtKvDN2sSsN/Kq0uILbFjQ2dSVLoHRlj?=
 =?us-ascii?Q?r/epg5QC2mdIpgLa6+Y/lyrr+Z/4V9Z2CBVc8HYtzft2MyBtCdQCJXo8a6xh?=
 =?us-ascii?Q?0lK/CL0RJ7SjMwkmgq3ywHxaUwYl0bcs7/aQKed03RvpNu52SAECiX8Xo/TT?=
 =?us-ascii?Q?JH5HkQeEaoNvgZAohwa1Pv9YJ0z/z/CPLwxNpk8Ptko/jo5MTu4Ohjoz4Aza?=
 =?us-ascii?Q?Wmb0JpwHJNTehx5/m1cN6f61D1nffh5bEDAE0C98bOb59RA6kn+5Vq/6l18J?=
 =?us-ascii?Q?UlnQAEhvlM8QyYrmw/FRozxSRY+2142aJSDQVtCmo+Nfc4Xen7Uq7ylq1mAs?=
 =?us-ascii?Q?aAsHSap26L5bQpiMfr7ggAJoZJ1gAE8jm9dwRwtThQ8qyE0pfmiGS19Txpo7?=
 =?us-ascii?Q?Yk+YWqnlZPiwmeEt5oZyE2fuBSCqkh/mmzmQpWSXSF3JnGXDWKTPwd2IWOAy?=
 =?us-ascii?Q?YPjqY7MN2zPqMrhL64bkk2988LVFO4m6vOViLwju5hVwlFsz7CdCpXEPb4Jj?=
 =?us-ascii?Q?0SKuuIRM4W/DX6O87j+vBKDVQCnVBQWOEaRme4qMN9an8HzEi+PpAm/T94BE?=
 =?us-ascii?Q?SvDUe2heMnfN0ABggXplv3oZUNvI/bHqsawnLcA02f/+mAHp/qsUKh1jfvTC?=
 =?us-ascii?Q?MhlLTca7VY1VhJLYgm7kLxXXSPZuaeRyA+6Vvdwed7sFTCK8VRg/KIrgMJn3?=
 =?us-ascii?Q?cc68QRfOxM3xTcTY92UHARCCPjijQIln9Y/LO/bcTsHG4DN918VS8k5bNzSC?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jk0Dml4xYiKK/8g1WcAlQAHgVYi58D3Wn0Aoij4ufuExCYrV8aBTvZ4PaHhg0W26CobMEdaEhPVUnnK6pZK6EVmWuGFH58SH+MeNbqnzbBM/Uk/5BhzBJqpwQRCERdMNLrIzMPdAidLC6FCfBpUo+yunPMJPuoVHnxwEULlaRY70VjaLtcwAbH1FrfWOSP+60W6geOl+WAZakh/P1Z2Ok3u4bJtHU6za/ZPG12O0RVuXSc5G6yD6SjdhNkboegr3UoIEmVx6V6qNWr4pjH01oo4hhlFfoF6SBGHgVkQ3qpKTTu8ngzMLd8Osf1l/W+18VMo4lHReJ5002EwwhguQQ1rEpd52pT83i3XQjEIDg/bJFcLwufTJBWqzC8mjOl4ds21R84YG2fn5IHDw5nD2NzAfHfipY+U7/QFRJvnFpDnX2Ab6oaHTEXqd6X3UQwjmAnSqVXwpNGfbgbINlJyRkJDfkGGQRWRZBNG+MLHBbYUzxndXirGTQcHQ9Ut5EA0EF4tYZrAnm8kUiDBiSE6E4hHfW3gD+KQHhEaWGKLwOlZ9QYm9ESGybgNglcLB8f6sgO95siYXuDmU8VPvw8BB/sZQz9gPu9/wRvq+Hj2eQpI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46516f5-4c6a-4d99-936e-08ddc7bea684
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 18:53:00.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iN7/WBN8KL/0tvZbpx84N90g2sBiyRUVBvC1xgCq8DPSOCFghc2IvKY6m8yng07FN54Y3UCS5dIk3SmaO8r53otFIkmD/BJPlqlq9rtc/Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507200181
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MyBTYWx0ZWRfX+8UD+LBGFKZ3
 NrXGjKVy0ZDftZ1ay/8PkU4J5fH94Tp5hAidkL4NovRdiKpyLxCZ3llc3jDJvXog49qDpIlKlMu
 RieYrhqJ11P+fFtUUFRFYYDQQeeGsyKzvlvuszEVGN0U39PKK1ee/lEfj95NYTOdryVXvtVD0yc
 66r5Sx9o4nycsLVJIiQQCQVe58Wc0ut9nT3f845EnLG1vZYLwnYZRz73P2qfvkqj6I0XtVqhxyA
 spRDHZAdWJwYiaTU89i+rdGpnNMKPFs9mazN5rrERHCLs3MOXu/JJ4kNsoFMa0XiU32X/cj7DPm
 Dfyf6qzQkYtfqT8SeB67TeGd8ua4rTRv8J7AA2Dn7IYGbWaSzx2H4NFtlXA9ZWzJoWSi3giFrZy
 zhJb10n3FgN2EK4hXedXc3tmYhPU/osYa2na7fONzdg4DG0BlZKCcV2rjCJhtFuDghyVoD4M
X-Authority-Analysis: v=2.4 cv=doDbC0g4 c=1 sm=1 tr=0 ts=687d3e47 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=yBgIVVZx3LzMFinQzOkA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12061
X-Proofpoint-GUID: TWzkxLZcWylkupkPkwgEKkejq5cq2lK6
X-Proofpoint-ORIG-GUID: TWzkxLZcWylkupkPkwgEKkejq5cq2lK6

On Sun, Jul 20, 2025 at 11:29:14AM -0700, Andrew Morton wrote:
> On Sun, 20 Jul 2025 12:04:42 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Hi Andrew,
> >
> > It turns out there's some undocumented, unusual behaviour in mremap()
> > around shrinking of a range which was previously missed, but an LTP test
> > flagged up (seemingly by accident).
> >
> > Basically, if you specify an input range that spans multiple VMAs, this is
> > in nearly all cases rejected (this is the point of this series, after all,
> > for VMA moves).
> >
> > However, it turns out if you a. shrink a range and b. the new size spans
> > only a single VMA in the original range - then this requirement is entirely
> > dropped.
> >
> > So I need to slightly adjust the logic to account for this. I will also be
> > documenting this in the man page as it appears the man page contradicts
> > this or is at least very unclear.
> >
> > I attach a fix-patch, however there's some very trivial conflicts caused
> > due to code being moved around.
> >
>
> OK, I applied this as a -fix.
>
> Moved the two new hunks into check_prep_vma().
>
> Made sure the "We are expanding and the VMA .." hunk landed properly in
> check_prep_vma().
>
> I've pushed out the result, please check current mm-unstable.

Thanks, all looks good to me!

