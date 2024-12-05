Return-Path: <linux-fsdevel+bounces-36515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583C69E4DE1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 08:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8BA18814B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 07:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669C119D062;
	Thu,  5 Dec 2024 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BrSaNmsa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gpSUFHYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C32F56;
	Thu,  5 Dec 2024 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382103; cv=fail; b=ge6rjlC29TLdU3N2NxXHQ4juPtKO9Z37IRlmmdTds/wgRfOEo8WhOvLuIVo3SSWnx+sRXAIVtPmJIOc+44VyFnId2VA5GcFVh9pHQG+GRrn9lbmzPa54swLx5VbxaU1AFQSaPIrXT9BHU49toquuPnqnM2o6sq329XrgsfPrFq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382103; c=relaxed/simple;
	bh=V+SOXE1w7gTEum1QuTk8T9n8shPWhxi1CrX0wyy6PNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SSaK9+YqqV8MAPqYfb+POkz+RFqbC2WHlERvpnTtFOJu1UfUiGYYah06zZa61dA13v1zGJvhd5UGd4wIei8z4oOPu+2SEK7d0VsiCckbQbEvAUY/ny/56zpG+1/Mk+q/3wlkgi1d7gPSxskQESMy/uXBopjzRufvZEoJSZ5RG48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BrSaNmsa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gpSUFHYJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B52OTxi009436;
	Thu, 5 Dec 2024 07:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=oSEUEl+PbWIVgPnJnL
	ZnxNIsFq5LTNCWX7FJeS16ew4=; b=BrSaNmsajaGhWsXOCoBO8wOCi7xYD0dVvX
	Nud6Rk3GZ5PzV7wlOj7i5qFRH8gcLfSQ+yKHzo1QltbL4cvtELsATbdn45yJLsQR
	7eYfnzIGqa4MfmV9AUL4LDE5WYqXbBGxO7wCZjvy5DeZ5VB8wodDg4sXf5J5ye4R
	/nR0xEKpOEajo8sJzg5Rez+M70MHyzhd8PiJWkpK1XByvUCb/Qr9iAPF2vxwdnWM
	AFlgY8uDTyY1x4Da3z50mRJoW0OAUNnzYgTu91JC6s6eXL7A6oYjPzmhrhJVjGki
	SLW6EbOut83kmkKPVji/Jw0g8sLA87jvQ+S9t86M6F2ZFoDeNnJA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tasa474-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 07:01:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B55ElSJ001454;
	Thu, 5 Dec 2024 07:01:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s5afuvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 07:01:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eytz/4MflMwRjktEhvVxEV7OhYJIAN5NCgb56oj7kc7PjzPuUjp4dATFAEZH3Uic8+ZTg3q/d2bJ5CdUAseJtg0UhwTbNFOSiA8Ne3jknzMXgpja+aNQytxWFtXPrnyGaq6uJ+tsqWv5izoP+mNOytovwwpk7gVqOUKKfVlo6hXsCL2US2n49sxMgmWo/EuIHmU4F7PneHeVANln6as58zTB30WqL2dX5ndq2U4OCRo5jSkhH99weFD/nNHQNVdDTVPjjHSvKwNNaz1YFT52AbaCE205P3aQ/eHFLf+FLFaNlGFsf/EMUfmadW1DL3/0NnZmyYg9wg7AiBcPyX5KZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSEUEl+PbWIVgPnJnLZnxNIsFq5LTNCWX7FJeS16ew4=;
 b=jAbRmdrA9kpiyS/gQ4JvEnfWitCihO2SeK1uSJRj1oGxmssAtgRbpjyN0XqCh3E3M+UMmlg90emdvYTyX4laZQDnL6TXFv1QiGZt4j0nDVQAt3CGzvG+P2jnI29NU4HUGCmVAVOgH8LgQ9xmc68q8UmjRgElodPzsxY4ETcTB+C9/9ErMpxb8/k9nr+7GjVMGLOPpmppLdMuU7Fqzl3qJjxgoGUBoJfsw1523Sk0noEN3lu2F3vnFL5/GyFwaYNpcr23b+RqZtKVoHFBNPKrP+CUUACK96X8wO3+GeLNNmlRxaDAp/JpX6NwhMph5LFnPMjqjNQxHQfnplkXoRR79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSEUEl+PbWIVgPnJnLZnxNIsFq5LTNCWX7FJeS16ew4=;
 b=gpSUFHYJjNhvuUa2aAEeEz0+AqLeJmLmA7NsZjHthI0/seXuBFH+q1xLF/vOSJJJC6tNHqRyYeK7x+Ort09fi7gpidh36GUccs0T7tKZ7QhNKl92e3hdCNXH+f/lKKKt8OsbbOhzhwITCXQYMsZhOPutwDCvsbRy7P1wjleNsm8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB6285.namprd10.prod.outlook.com (2603:10b6:806:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Thu, 5 Dec
 2024 07:01:23 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 07:01:21 +0000
Date: Thu, 5 Dec 2024 07:01:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: abstract get_arg_page() stack expansion and mmap
 read lock
Message-ID: <e300dfde-b6a5-4934-abc9-186f7fef6956@lucifer.local>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
 <5295d1c70c58e6aa63d14be68d4e1de9fa1c8e6d.1733248985.git.lorenzo.stoakes@oracle.com>
 <20241205001819.derfguaft7oummr6@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205001819.derfguaft7oummr6@master>
X-ClientProxiedBy: LO4P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d36231a-3a16-4d88-8ac0-08dd14faa001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?75FGNCksSjtVqBm0Y8L/pjrdEZaFBhFTktQmiLus8l1SVlwgkEhRqLBm7g2a?=
 =?us-ascii?Q?bNj6MaiF899laHdSpIzXfCkgwcLqjc8u4Z8+EkUl/FO4kAoYWzPT+bxgHeH3?=
 =?us-ascii?Q?Y8autjQzS5DXJlzaULoHi5t66itkID9fTYt/+dE/GgzYRUJm1veeih4M1s0o?=
 =?us-ascii?Q?l0bHfXtth+P6i0qMHsdX1whEaElrkWpECQEnYogbCs9sYYgTDem7cxYKBhb8?=
 =?us-ascii?Q?DyViMCE0HVf43pV06Z5guJRD89WLvRQC03x3sLJQYUEaW9xVk0MYdezll7x3?=
 =?us-ascii?Q?c0Vqew7Tq7gdifJLJse6+Fr3T+GRIPBrwUi3Ul+1isJGoX9rjkYnIr5YMgwY?=
 =?us-ascii?Q?ZTAHpmEU6FIusRPH/LsqEv0C3UtPorrcyU2jMuxZqs0GRjCMqKLAOvvtjD4o?=
 =?us-ascii?Q?QeckgVr1CY5Ch9eX1ndl8eSRleMier8jKl4iprYkl/izsLBchLW5pOBZ/k5E?=
 =?us-ascii?Q?9EPo1tKfc5K/838eFNmFVmXjHxfc+2czZt67rXFHNvw05pdQxWAsriucJypM?=
 =?us-ascii?Q?D7FNBaPAsYOn2/FN/QNIdzqmeVti1NkgLnBfWf2paWjxr7nith27tcPOora+?=
 =?us-ascii?Q?H7GTwndZ4cyf1DhUAEzeWJBN3f2n3HNC5GygUwaM/pxEinP/shy7mlF/xTy4?=
 =?us-ascii?Q?A++CdlazBwjKUA99kWODFYcM5YEGwyh2HuqAKFkBbeeMiaI8EmjLntgPeodu?=
 =?us-ascii?Q?vo+BhSea6D0Wks7XQChw5noWS4tUyec/4GRnXuXKG3HJkFXpq5K3bHJ/XkjW?=
 =?us-ascii?Q?NmS/ZLN0Zrb5K36KOFwOeMtZ6HiN4nCT+p7m+DAbCqF1GnKjF9JZUE875HDr?=
 =?us-ascii?Q?zgFDj72XJtS2dHWE1UmGeXUFhxy/DRNubhzHMJh8pmSbScaCi6a+m0CHpITq?=
 =?us-ascii?Q?ZRw4Ce2SkzpF8hPZcDNZ950Ee4nc+GepFi1s9Zii7FtNtP3QTGljl37+9ohi?=
 =?us-ascii?Q?/SeZeGV+CXCL1bVX5dR2iKZvfpdbw2feBmWyacdy1AEo4ne/l/dojrIcGey4?=
 =?us-ascii?Q?YAfORruvYgwMgUqO5DRUudj2Ku0NczhkesGhLXdUyZk9uh3CZ50Ktpy3dMnZ?=
 =?us-ascii?Q?Crq8QpF8Hh5b3QjD413a8RXVSkwDrFGxGhq1Q9L+J/1VKgh+wzabzJrZ1oqm?=
 =?us-ascii?Q?2JvpC1PjGtWNBXfGmuBrmTKFwB71fod1rxXkQ8HvXvEwimEETh3NZEX+VBrO?=
 =?us-ascii?Q?4ZnmalRcfxBqPUel47ChLsE1vagFyMYFPom+DMZ4KqKWtEQMft1qT+0C0Jvu?=
 =?us-ascii?Q?om+DyGCmdQMxAaIe3Bj/MQaRIK7Aw6kZBpVXdLlcy11oTm/ZgiMKq2wTv9C1?=
 =?us-ascii?Q?y6FX2IWR8PAtTqmoGBXbRBwqG3Y2jYomSiQxQjK6Njdukw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W3Hb7Pcmamu/hYI1OlyYpOvixZ6k4qwr1DuLBSTp+A8sk0G8NM4ldr/kezYW?=
 =?us-ascii?Q?DKdRNdZYQoK36GEGEK1pn3yzMVJ8SKupr8WguQY1qtN7FJ3xUbci8uzjRcL9?=
 =?us-ascii?Q?SHLWRAE5WmOG+yLCnODLg65pj1jyWva2Egz2M5frL/mw5fuzMmUUU1jNe0DN?=
 =?us-ascii?Q?AQ+YDmGIXRHHF9URqD/5E1YW8KvaCxBbxJKbuhlesSdsRnWdD5ojKS+5ItTY?=
 =?us-ascii?Q?/yBIu5NWmxC35SZLjsuhkEf+mjMoAYKN4E2B2DfzM7mh+JWCpvJjte6eAzde?=
 =?us-ascii?Q?sQRsFtRGMmWhbT3WF/ewbRMF4+m6h0xu4zHRGa7njTFFFYU/D3FTvoupyM/Y?=
 =?us-ascii?Q?8iY9mWRxj8/mxj/F8EGMrdmnH5ccflIOTLcfDwEMm/ZJYae2L7bZUBXxU+lk?=
 =?us-ascii?Q?ol5rZDH1VQ0/fK/0ecWb0PB3ii+ajt+sYYOLsPVcOXZ0X+pq/eQwimj+Nt49?=
 =?us-ascii?Q?q2pZ6x8AglC0rUjeg7lHSvsS0lPrcsm5wPcFLBIkKJ1r22nAVpjgQm+jw/OI?=
 =?us-ascii?Q?VV6T7xXs0QXT4ydW7j7+/Pr+KQ4pvkzoH7lk/6GFbMqrtr6iHryz6uQQuElc?=
 =?us-ascii?Q?vHFukJqBr/7pBaTBbwOt2zMDcTUyQ+VqLwamI/vuWEJN02YnHJiWXhPSIg7W?=
 =?us-ascii?Q?8w75jDd41a5dn+08LEaNDuEXPlwyIYU33HsEA+gAioxhPhu9h4UvXTTzDZNm?=
 =?us-ascii?Q?APoJ/AVbLQvTZUXPW8cVrGT8HUiW9lvFU0Wg+wT/6WEltev9zbS9we7gJVN6?=
 =?us-ascii?Q?t6tLxRxH05orExrFnJ2NZyi5FMbLWsoJmFOD/hAlPzQJn0686wsbf45Vu6Ok?=
 =?us-ascii?Q?myuNG9SkAorkoqUCZ3VvohYFM/g9MhzBkUGOMg4tKB5Us9/Q/pL2Yq0wA1ad?=
 =?us-ascii?Q?BJpNqxy8icT2//ZuOl84SqHybifUYwW4JeXYTD0XRwuj37SPUFXXYXi0ydpL?=
 =?us-ascii?Q?WIOs4C8s4iTt4d8pw0jOfziJ4HcSOpUBQjgpoC+Vgb8NS6Uk274HTwAMoQJ0?=
 =?us-ascii?Q?6eB+ypRvleZng3XsdE79fvIdpFIOM0Cvgwll94ea70scbgmgbqGlOpyR8L0f?=
 =?us-ascii?Q?orwIYZtjAhzX0zOVuTlU6DsUwOWh2pG0tLZ3svFkDQjO5qnFMttsvU8inJ2v?=
 =?us-ascii?Q?QYuvaKgK4Z+PrWZ0bmJnP6aL0uz6NPNPwpk4CCsaI9uMlBAi1IWD4ZMoneY9?=
 =?us-ascii?Q?7JczN11/AiZlBenPFKYonhZAiYzmjUQPX9VsYGuw8XXmH9fW5oWBoc6y9mWU?=
 =?us-ascii?Q?N8lM/wYB8uSxOBd/PLJyMzISVfSE6b85CxIIHSA+QgaBGAh8S4oExUbm2xh2?=
 =?us-ascii?Q?No1dYHuV73L5Sz2GqAOG8P/Mr5C4dxfaQVCThtlASb5jyuqOo18j0MqJcv3B?=
 =?us-ascii?Q?2Yz8sg7x9d6GFcPO4yNNpjqBnhWtVuDJxGg77GMuWyD+WdCkQH/hcIK3KPwg?=
 =?us-ascii?Q?tYGVG4Hi1wvPDMLBzMGr9vbczYhUbNeebu17mlPJmrRvv5TpET3YAHbsRIcR?=
 =?us-ascii?Q?H5Wtq4FGrDJdmN2OLtYDmjZONkUgfXIuvcvks7qNkW541trXH7u3hJMssP+e?=
 =?us-ascii?Q?caIhtuNPQ+j6Os/BGhu5cd22nhC3hN/B380gQwF7H0wpzA21d40A4KhjGp+H?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	InBXmNXkULOSVVHR1/QrgAitFSwGseegtPO3MZ0OdGw+UruLNorf/SNPLHhgRewj5LOeSN1nmLoud9DLKVP/erXnoWb9Mz/Ay5gfQglxGjONKpc7+9FVf013WQjSK2goyJ6vft7WLln9xOLJg2/HLugMyUaIEizY58jcaBL4ytYfKsNpvwbFV31zZ7X3IDVZOrj88/esZgoF2qDuebEaPbEPFhwrtYjQ22ldWJnfwM/PCl4EuQtpHdrEWMxUqqVFSpLUMTcApc85RXYq2SZZPAGZq4L+FdoScWWk+lBLyLiPi9jIImqxqcYaShgV3YHib0qdcq+pVOs+1X+dXmvIcWfkvcabPKUhCBBWlHvXo8fLvVHf+WZcApZpZxNesc1w2MwCqAsgS74C5WUiPUMo6iO/47DBuhb1yhIfvbmi3xXrAbHkz1ItLf37UlqfTAvmS/f7W9mb4gIaPM8+80ygHh+HsBQPOztfmIUSb9FEJo/P2Plgs9PxI6AMXrBUOwgjjWvsQUL7qR/BYY1qF6SVF1woovt6W/OL/np/rT7R+qMJvgcx2Rkx+ugElVfx+LBGPWB1/Ubqd1B3ygEnAJMCLfsoHA/99aEcUrd3/bp/lEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d36231a-3a16-4d88-8ac0-08dd14faa001
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 07:01:21.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cs8MEZEoHzPRH2gI1PUATv+DsrOyxfO325LczO/UJIlhcf+H5StDC6ibnkfh30I4DtDHsgxAYd93/c1yCxERkmZuzUGZzmLyktnM4v9zqfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_04,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412050052
X-Proofpoint-GUID: 4uNdoXM0PiWE7StMfBDy9IF2SQvucg0e
X-Proofpoint-ORIG-GUID: 4uNdoXM0PiWE7StMfBDy9IF2SQvucg0e

On Thu, Dec 05, 2024 at 12:18:19AM +0000, Wei Yang wrote:
> On Tue, Dec 03, 2024 at 06:05:10PM +0000, Lorenzo Stoakes wrote:
> >Right now fs/exec.c invokes expand_downwards(), an otherwise internal
> >implementation detail of the VMA logic in order to ensure that an arg page
> >can be obtained by get_user_pages_remote().
> >
> >In order to be able to move the stack expansion logic into mm/vma.c in
> >order to make it available to userland testing we need to find an
>
> Looks the second "in order" is not necessary.
>
> Not a native speaker, just my personal feeling.
>
> >alternative approach here.
> >
> >We do so by providing the mmap_read_lock_maybe_expand() function which also
> >helpfully documents what get_arg_page() is doing here and adds an
> >additional check against VM_GROWSDOWN to make explicit that the stack
> >expansion logic is only invoked when the VMA is indeed a downward-growing
> >stack.
> >
> >This allows expand_downwards() to become a static function.
> >
> >Importantly, the VMA referenced by mmap_read_maybe_expand() must NOT be
> >currently user-visible in any way, that is place within an rmap or VMA
> >tree. It must be a newly allocated VMA.
> >
> >This is the case when exec invokes this function.
> >
> >Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >---
> > fs/exec.c          | 14 +++---------
> > include/linux/mm.h |  5 ++---
> > mm/mmap.c          | 54 +++++++++++++++++++++++++++++++++++++++++++++-
> > 3 files changed, 58 insertions(+), 15 deletions(-)
> >
> >diff --git a/fs/exec.c b/fs/exec.c
> >index 98cb7ba9983c..1e1f79c514de 100644
> >--- a/fs/exec.c
> >+++ b/fs/exec.c
> >@@ -205,18 +205,10 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
> > 	/*
> > 	 * Avoid relying on expanding the stack down in GUP (which
> > 	 * does not work for STACK_GROWSUP anyway), and just do it
> >-	 * by hand ahead of time.
> >+	 * ahead of time.
> > 	 */
> >-	if (write && pos < vma->vm_start) {
> >-		mmap_write_lock(mm);
> >-		ret = expand_downwards(vma, pos);
> >-		if (unlikely(ret < 0)) {
> >-			mmap_write_unlock(mm);
> >-			return NULL;
> >-		}
> >-		mmap_write_downgrade(mm);
> >-	} else
> >-		mmap_read_lock(mm);
> >+	if (!mmap_read_lock_maybe_expand(mm, vma, pos, write))
> >+		return NULL;
> >
> > 	/*
> > 	 * We are doing an exec().  'current' is the process
> >diff --git a/include/linux/mm.h b/include/linux/mm.h
> >index 4eb8e62d5c67..48312a934454 100644
> >--- a/include/linux/mm.h
> >+++ b/include/linux/mm.h
> >@@ -3313,6 +3313,8 @@ extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admi
> > extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
> > extern void exit_mmap(struct mm_struct *);
> > int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
> >+bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
> >+				 unsigned long addr, bool write);
> >
> > static inline int check_data_rlimit(unsigned long rlim,
> > 				    unsigned long new,
> >@@ -3426,9 +3428,6 @@ extern unsigned long stack_guard_gap;
> > int expand_stack_locked(struct vm_area_struct *vma, unsigned long address);
> > struct vm_area_struct *expand_stack(struct mm_struct * mm, unsigned long addr);
> >
> >-/* CONFIG_STACK_GROWSUP still needs to grow downwards at some places */
> >-int expand_downwards(struct vm_area_struct *vma, unsigned long address);
> >-
> > /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> > extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
> > extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
> >diff --git a/mm/mmap.c b/mm/mmap.c
> >index f053de1d6fae..4df38d3717ff 100644
> >--- a/mm/mmap.c
> >+++ b/mm/mmap.c
> >@@ -1009,7 +1009,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
> >  * vma is the first one with address < vma->vm_start.  Have to extend vma.
> >  * mmap_lock held for writing.
> >  */
> >-int expand_downwards(struct vm_area_struct *vma, unsigned long address)
> >+static int expand_downwards(struct vm_area_struct *vma, unsigned long address)
> > {
> > 	struct mm_struct *mm = vma->vm_mm;
> > 	struct vm_area_struct *prev;
> >@@ -1940,3 +1940,55 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> > 	/* Shrink the vma to just the new range */
> > 	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> > }
> >+
> >+#ifdef CONFIG_MMU
> >+/*
> >+ * Obtain a read lock on mm->mmap_lock, if the specified address is below the
> >+ * start of the VMA, the intent is to perform a write, and it is a
> >+ * downward-growing stack, then attempt to expand the stack to contain it.
> >+ *
> >+ * This function is intended only for obtaining an argument page from an ELF
> >+ * image, and is almost certainly NOT what you want to use for any other
> >+ * purpose.
> >+ *
> >+ * IMPORTANT - VMA fields are accessed without an mmap lock being held, so the
> >+ * VMA referenced must not be linked in any user-visible tree, i.e. it must be a
> >+ * new VMA being mapped.
> >+ *
> >+ * The function assumes that addr is either contained within the VMA or below
> >+ * it, and makes no attempt to validate this value beyond that.
> >+ *
> >+ * Returns true if the read lock was obtained and a stack was perhaps expanded,
> >+ * false if the stack expansion failed.
> >+ *
> >+ * On stack expansion the function temporarily acquires an mmap write lock
> >+ * before downgrading it.
> >+ */
> >+bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
> >+				 struct vm_area_struct *new_vma,
> >+				 unsigned long addr, bool write)
> >+{
> >+	if (!write || addr >= new_vma->vm_start) {
> >+		mmap_read_lock(mm);
> >+		return true;
> >+	}
> >+
> >+	if (!(new_vma->vm_flags & VM_GROWSDOWN))
> >+		return false;
> >+
>
> In expand_downwards() we have this checked.
>
> Maybe we just leave this done in one place is enough?

Wei, I feel like I have repeated myself about 'mathematically smallest
code' rather too many times at this stage. Doing an unsolicited drive-by
review applying this concept, which I have roundly and clearly rejected, is
not appreciated.

At any rate, we are checking this _before the mmap lock is acquired_. It is
also self-documenting.

Please try to take on board the point that there are many factors when it
comes to writing kernel code, aversion to possibly generated branches being
only one of them.

>
> >+	mmap_write_lock(mm);
> >+	if (expand_downwards(new_vma, addr)) {
> >+		mmap_write_unlock(mm);
> >+		return false;
> >+	}
> >+
> >+	mmap_write_downgrade(mm);
> >+	return true;
> >+}
> >+#else
> >+bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
> >+				 unsigned long addr, bool write)
> >+{
> >+	return false;
> >+}
> >+#endif
> >--
> >2.47.1
> >
>
> --
> Wei Yang
> Help you, Help me

