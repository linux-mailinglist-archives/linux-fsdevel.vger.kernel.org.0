Return-Path: <linux-fsdevel+bounces-23391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC9B92BAB5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23351C223A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A45015EFC0;
	Tue,  9 Jul 2024 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="icePBQOk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ovdTon0x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A54161B43;
	Tue,  9 Jul 2024 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530577; cv=fail; b=hGb1cxum5Cdt01f6KeOrAjT2A+D3EsakXfVRhZW/Z90E5cOcPcysm6/R6f66lRea/NJliTP9NFMMdTeA9d8KcjJd6h4Xw1n2g//LF2tTQNNaN9ca99N3lOJx7VGwVvH+e9jp/eQOObVAyEmRKxyr2ZwZZHReIxT1hXneRoBUAWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530577; c=relaxed/simple;
	bh=aIg0KUjin1nzt5b1/DGXE9CygsfOenO2+zGw1PvpBhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AIY0aNn5CqohQ8Pxze9Jj/tdp8jdpb1+I/7hDMjprHfVdZPLj0ZkdKRki9bKbbS5J5XMQlK6bsEpvAM4cQ7KmiGvc5r2SwZFUGBw+t1hfMTJn1XA2oMDiZ1zTIF8lw2QWMoTXHSM2MIU4GjRNUbQc7L0ISBVuDajTbnagwCmM2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=icePBQOk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ovdTon0x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT2Rm008089;
	Tue, 9 Jul 2024 13:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=DRCjYUvLHrgjkIs
	zsuXvbaaBTPe4YA20lUc07FceGjo=; b=icePBQOkG+DQ9HdmkSklTXllKSb3/Fv
	6fQwQpesJioXspUmGz2Zrm0sJeM70M6B04CN7TtqV0esLyiUesUoNrxUmsX55XR2
	1D1Y80yCQbrLn6IZ9KRfiAetMWdbx0jVASLQNNBmcWzd2Bd1TYnemQ5OYPDbRRXY
	lPN2Yvq2jvN4ZfLAx14sInS0dEqvAML79ac6RI06ViEk5jtALIpbACNaVrhBCRbI
	lrmzvGuYpQajtN0D2U9EcsDGGAprwKrqRyQLhEI2Vp5XDWr8UYduslUdyTicLAcx
	Zp2XAlSeTWP6pZhAeDWaIOu04ipv+m9Y76o49EyWF9Tx2ZE2XVPWitw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybmwpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:09:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469Clsgh008768;
	Tue, 9 Jul 2024 13:09:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu36e5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJgmFv9cIN+VyPEIKH9s8SLkl1xdKlp4a4C41pNowAx3a3xjDzXk82oBFfF3qD2TNuMIP17vSRJFKiUx6PZfIF4NvyKHMv1mFKuAN/vrQTUtbC4mLYcPz/+vsXile1i9PEkvjDrPgNm9fr841pRoZSkUn66RVa6puNciJahaEgDsyg/nwjhPytJBuz50A+5Jf4OMl+qNxLF8J3FWONIqDaoeUbhAGGk3Av5fBL6JYqdZFvDkvwozP/gVNkCsiscK4gVcfghP5UOqDbim3gleQXqMxIb4h7xJVUjmht5eF/6JlkIPyqrryKXnNLrrg5D/MNo1QbJqO1ssRSUx/aZgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRCjYUvLHrgjkIszsuXvbaaBTPe4YA20lUc07FceGjo=;
 b=S/H1s4C8gFMw5ERPNw7YzQT9YtwoZ3LQ/oLzisY0N7dq5BLV6DpYq0xvAt9G6NRjzzLY0RVAsXJwRebf5Dhs3oNOdYrPwG2ctt5gy/I8jGirmYbaYOSf0S2RYLGf6XzQ8b0LmWU0+r4q7xtweiC3LiUVGGczc/Q8Zesj8oOWb5LFe9LLvljUuLCRqZD5rtg8g3fZbxK2ZGLvPUYsnsiSffsHe0so48Wj6h6NB4HjstEw80+PS5P9E1q99h/89xS8KVI1m4Q+dmxU2ex6S0nMpAZDWansSlbfrKZt1c05H94RgK0F3PD8kv3y/Tl8oWMLfaP8zt8c7u+RM/U426KHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRCjYUvLHrgjkIszsuXvbaaBTPe4YA20lUc07FceGjo=;
 b=ovdTon0xpbR1FMinsZv1GBMdDfFV/jkwjd7sdyVHRGpKcFZJk8Hu/BcXWd/UcdfsT7VjnyTMyyxNW0QpB+XBVCVgA9gEKtDQYYQp4W8KRv68ztTV+0RnjxtQV4Sqri/UxQ3DcPt4ukPQZvUCCqleuw2DEZH65iGCGySYXV8qKJk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 13:09:16 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 13:09:16 +0000
Date: Tue, 9 Jul 2024 09:09:13 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v2 2/7] mm: move vma_modify() and helpers to internal
 header
Message-ID: <b7yc2e253u6qfppycoch36u6d72stylucz4nniwswls7lpfcjq@zrsp3uxiloql>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
 <d247ba767e16973c27e84179a0a52f2597d72254.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d247ba767e16973c27e84179a0a52f2597d72254.1720121068.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CH0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:610:b3::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f0cbe1-c062-4ac1-95c2-08dca01855bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SJCAgOmLpA52q/fIbvjDt+hk8KyPFrSyLA8W90T4/NrYwckrY3hkFDCCOVot?=
 =?us-ascii?Q?mrDvcKxYIyOiCSYE6mZyZISCY8nXxhi8qhecMPp1UzVPGj+4Ypp+A1fDKjLk?=
 =?us-ascii?Q?+A7YYL6GgQUTeDCTfoWk++VX6IPoqP4jUMUjxLlJ74RCpPUQiuX2bDCeLBfi?=
 =?us-ascii?Q?8kl/MX9/8paTYGYVh+l2Z9IYn2vMY3UsSfJnYzYyMOV2uMBMH/WJbqMNXJOV?=
 =?us-ascii?Q?sD9dFAn3Cl7Bfgu7DZvV1CsHJ+EYoqne2F8ZxiizbLiPyXHwDYJafqWAFWgJ?=
 =?us-ascii?Q?68oP4J3OGxJjDoKUzS47qI5DNieUe3XfkC3CkiDHihytsOM4yiMjS/LsfQ+t?=
 =?us-ascii?Q?VYFFOgujXuLJquVsZ7nHwhd4pX1qKv3vi3wbPEf/ZMBQV8hWxmnp6woY9xdf?=
 =?us-ascii?Q?JjEk8Mwy0Mrxo9Ng11jHq/BTs//0KC/6X8RPBnmdnkWgqJkaPiANCu5J9dj4?=
 =?us-ascii?Q?qB43UDQzc/18R67rz0sZb1CM25Yll1QWtT5/mnCAkkzkul6NumcOhmzlDBlU?=
 =?us-ascii?Q?JoBk4zAqQXnr2Cre7X6W1mzlxZs6/GD/1Pv1fY0qWRL4TGgBGroTkTXzj/o8?=
 =?us-ascii?Q?DNQxNZJFaBlwC6XHvaebyHesvFTK2KTvD89rQp4cbfZYS27bjvKH1FjIQLT7?=
 =?us-ascii?Q?fjNkMMECQZWJ34FK62H+aPkaJXTnE5llDCoW7/iU3TK6iNT0g8PHlYtmas2c?=
 =?us-ascii?Q?YeefINHwgr827BZ4V+kQOHx2LCw3dvRbLlkK7vyWCl9LBms4U/QTsgGZGCCk?=
 =?us-ascii?Q?x4Y/WUSe7+M9LgGF5q3FVPch2h7Irnsi1Yvea1Xrj6CvBSC3hSpGB3Zdefej?=
 =?us-ascii?Q?vOBxKEjGcZRu6CWSH+omfHXue0fy+651TIDE88bSCMyStW6a7CINVsRZYltQ?=
 =?us-ascii?Q?pMmz39/GRq2atFYlnKXwnuNTytstyrRgn3k8qdTnf1cj7e8zI8bjdsQpjygT?=
 =?us-ascii?Q?Qe0KAiSTiMt0eCrZuwWDHhtK74Smb+vTaojuqbAZHt6GkUtUHYtuAbHCTwWZ?=
 =?us-ascii?Q?nQpnOuCB5l7cNU8/6mLv12YKtWFX5hNZZZ0ib+wE6yexpdA5KEPom2JTGed8?=
 =?us-ascii?Q?UjWrffz61ocia13OX3CxXEKsdLbWVr1wYsav48+sJ/eiGV9M05WsncY0/iVN?=
 =?us-ascii?Q?lEu1KqIYogcJMZheA6z0227eYraXJOmdAoB1JvVuCqQIjvV/Gv1bkJa4g2oF?=
 =?us-ascii?Q?DJF1i5S9WH0bpN5CpiPqqWxuef9oPNck/JEEZ+0CtEUxKbuVZbclHQo1Qgno?=
 =?us-ascii?Q?LzMuOKYZuK9PUObvFOutGKv3YwxxMyoKAmJL44iUFYi+f3aW+NKKxmLtsqnL?=
 =?us-ascii?Q?QI/UjZ73hfRMU2uXZ6DHmQW084nMvQNfyKm+UxUpppRshA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BIGlEEadOSVbl3YCwnwf6wSRCk6EqkYqlc/3it5NEC8YrQi7tjg3xtplSC9d?=
 =?us-ascii?Q?gzG7jX6+raM/jYf3j9KWuqVCi7rAr+69GKbshVO61YirBa37jCx3gC1PZE2u?=
 =?us-ascii?Q?L0LShEYan6WOPgk1SETJizU605v6kk9mN4L/iZG0AgwlsK2Tq99kh6be8MVo?=
 =?us-ascii?Q?zilLYXLeVk8KAFMB3H06KokzgN36zzcdGuuc+ettHw9O2XkgnnVMwCQZRpq9?=
 =?us-ascii?Q?RowcIwyjNr57Ye/z0wfQ3lumDIOa3wVUBnToXpHWamqtdJVtQObj+nrYcOna?=
 =?us-ascii?Q?/6PguJHFbO1OUiArGxWV2Iy+QtmkdhbCwnu+X+SdViVaUoDRWWzG1jLyaYU/?=
 =?us-ascii?Q?NIjM2I1y6NfxUCgUWT4g/4xHoOobfUVLkQvOJryhzHbqaunjsxKB2sIyonRO?=
 =?us-ascii?Q?wqC9D+dgxvLjAc9EQ4id5V1K843PwWUp6Gs0dpm0L9JojpXpjckefpD4IYLf?=
 =?us-ascii?Q?NWYuhKdQbGzEbYiyLcwGYxbdtB0kp9Q2d85zYkkFS8f8wXyoHwJx+kNjq9DO?=
 =?us-ascii?Q?x6J/Yh+JKggcYGdgVCLZki5IaFW1j8Nj8Jlt2t584PIlajbGgPFaNlZpN0D7?=
 =?us-ascii?Q?LAJ2wTNl90C5NcqgjVm6DSuRG38VtwhlJqyaKv4ODI3TGb2bpYc/45HL+r3q?=
 =?us-ascii?Q?jEI3J41IrThZiQ5HnhT0128PlKXutLtCirLbuzao9ClwCufFgtFivENTD/ya?=
 =?us-ascii?Q?4/QHRYCtPKwJX7FylxK72mihtgacyuUnD905d7g15svnIo4YzltnZfCBYx9f?=
 =?us-ascii?Q?Hk8VpgmOm27Q1aJFCAbaF0v3gmNVuyR26f5gta5R9XQ5qRSzWDUCAh88Cfc1?=
 =?us-ascii?Q?DSB2zHbvoo/w9esl6Ijbscmf4+pc+mR8LZaM3BCEp2+Vj5kCo/48kBDs37IN?=
 =?us-ascii?Q?BDV7/z54iJYbtFCQRLtBAibAorhYHS4GBFPddKmu6rMULSNsTZkcxcVi4pmG?=
 =?us-ascii?Q?hCZ796v6urYne4CjNFxBdpTirC3RHXFiPxXvzHmW++2Qevw0P5a9Y0gSSFcc?=
 =?us-ascii?Q?LroXOflXe7j694FUHvQ3EW9x+y4J8UKXtU9O1hr0PVn+fhW1crdSCE7dAXcH?=
 =?us-ascii?Q?FLchyo3GGQ29jGztIr97Ld4cU0dd8LESfCFnLF9kc4/x/UAsLe3KIfvexIaZ?=
 =?us-ascii?Q?pkqfzpAfVcTV4Oyq5j9iEeCXPtNri0t5AyEkxRTfadSzHrE/DUwpSpb0Z3EN?=
 =?us-ascii?Q?l/S6tzirvMjESOQmbYuRUMc7xCrwcc/VXbr7IFq6J/PgB9+gaNH8Ia3Y8IIv?=
 =?us-ascii?Q?VxQJRE0LkEo0gyDY2bIRbfh3p8Wqh4veY2iLWHAut1Dtkin3HHfbkMNrYAj2?=
 =?us-ascii?Q?TvDzBg+juHe+OJQpbVjGxgegRxEay1oWITQBCDCwRrvV8xXh5BWF10ubT+ap?=
 =?us-ascii?Q?Taj5E/uOrXkiIA1HoDNTcCBB4mWLoqGQBwnNIVx0R5cX7nn1VKa3kUskvNLV?=
 =?us-ascii?Q?GWRJMn+j7O7qTZuaZbgPtrsljE2EnCx9mUe60n3z4cKBvXONRp7qfwBqPbSA?=
 =?us-ascii?Q?AOXDvQI7v7AzxxFUliMX6GAWqSNpKR4q0qmIWX6ETWwaBnxsQWjwkfCmW0y2?=
 =?us-ascii?Q?NmEp8sbWuuTuMppcb8c2Uz37G2ISeQnSm79xyKqv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hA7dLM/jY1jkV+ddnrRbE5cOCl8TwsS+A35a0WWipzmW00PXEjO6eRb+19Sse12lAD2Pf+WPuCoWjXWSrJfKBlQZsGB1ZRGhN+qs9uTgv0xaG4A6N/NG5qYE15+p7TQO6Q+FHpw9Hqxe9H4JX34/k+XdfvXXAbQkFrbxgL5Clw2233ZQaeMuiSMIXJA8yVdhHYkoQG+vn3QQ33Xkp62PSsGXFnShHcv3O3PtK6gn/3U1jgBT46B8ChkmDc/IFlrXH0Livn9K5E7+Jsoqo3mhujJHwrWf4sc2hn7x3poP1BI5KP5Y9bhMesWQJPwuHh7p06n16rVZxiS1BHKWYR9b1PsYz5LgoPzLfG290amzYKfMRXS4XU4Qrm9tRG/3sJppySQvtHGoueexaeBIBDqeuWnyCqVvDMlC/vq4KAV25qnrkOqD5FSMXzrRr5XmzYqerZcLdZx73I0iEiP8dRhJrBujbDIjrctn0CytBkh6fypNbB3btqEq8OiStcRAtBdnIPyFHXjuIUIz5BgaQVCOgUPzoPJp0t6qdNE1c9GObSsNbkCJYN6AK2Y6/jldXDioDKti4aTevVIGc+CNuBKnOqxTj+uH6QyNHG9IV+q6FIw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f0cbe1-c062-4ac1-95c2-08dca01855bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:09:15.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpBXVUVwAtbpUOyhQH9VRv2e8Cwkc0I40G51ISm+7eajAsp2wJTM+MTnDf4J67XqjBoAf5uNbGlGc83V8lTjUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090084
X-Proofpoint-GUID: AanY2mOaOorR7KVrQvUS8uPhCunxLwZo
X-Proofpoint-ORIG-GUID: AanY2mOaOorR7KVrQvUS8uPhCunxLwZo

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240704 15:28]:
> These are core VMA manipulation functions which invoke VMA splitting and
> merging and should not be directly accessed from outside of mm/.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

