Return-Path: <linux-fsdevel+bounces-67737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 519ABC4874A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 19:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E541891A2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 18:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FB9313265;
	Mon, 10 Nov 2025 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S109Q9GV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gcAsUAoD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DF82E6CC4;
	Mon, 10 Nov 2025 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797633; cv=fail; b=dbWY2YlHZqIvPeBUNt4susx1pmxoWxmb+TyBx5oh5QQ/bhhgVR6kjsEoH5dj2MQ/+HXRzPaC+OLLzBIKXmFRp1lByu29w1HrscFuB95IkFdKwwtyRVpWV6/eSxn91OCqwGGfTf1Kbj2lgIZDFCnI56P7lar1ZQR3juSM9jW83m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797633; c=relaxed/simple;
	bh=BLql5qddJH3uHLtzvGj/Sd+PD+9VbSH2LvTMjlHSv04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Em8E/tXN9iMzNbTFFKYDQqT0sii8JjQA3FFHiylttq94rj9PM1ABMMS/CANQv7vcYPXUvcIQejiM8QqKKltthPwLnSI8CQoHMVQ4D0wcGYzbayE/xEMQhoADm8KEVCNty42ORgJAgxgH+bhf4Ex2AhyYAppfLK9FmQD5v0ww5WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S109Q9GV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gcAsUAoD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAEgLSY022916;
	Mon, 10 Nov 2025 17:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aYhUdYurpLA4+ntSbU
	CDmi08M5mWQgrK1cFqi0Lo+SI=; b=S109Q9GVcwCg7S8xG+4WnY8lNhU2azp5ZF
	luilrsfzViK38k5spk9EoWX7VGN8mNv96hKtCwLFTzIGArO8ZdqnF4N4bRuw4Jp4
	QeZjiOWcmFUCi/S8a1mSOoYoyKfvW5zOIDgQ0Zlv612F1Rc+C4DXbmy6XcttqO5a
	bL95YqvUQSxNyt0k8dzE74LHCnOXKtqSoLBmTlFusVqAZpnBLw4RE3MRtV1L4684
	Y6ZvkqWpmlWvt/d5arKoznWIlvuDlMC/KpUA37CheqOLH4vynPbdaPgx2Avkh/qu
	GR/K1RA1yigS85nAIWq/OGVHxHiPBxR8JLwBFYAu8lvZXCO9Bqrg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abgwt8ncb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:59:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAHTMSs012544;
	Mon, 10 Nov 2025 17:59:24 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vabykgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:59:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFmec3cWJtJT7MEJws5p/pRhJO7sa25TEf8yVXxZw8HWn5HxpLZwLBmGq5ztQY410LYEswzARlU9cLPBwwuE0h4p1cH6ylIH0BJ4SlV5YFC3CxvnrGrwVWufLRo4k4uKX9xcaKnNo+epB1jvPIgq5SOVoyCXQh8JJbKIF+2AzDBYsF7q6KhJvU+LvABLiSJ+8p08y8SCOyIx6Lovjpc+UlZGDQe8KnEq3+o4CrD+yXuSK2gwyaGzoecBnvuDWf+4SdnEu6wZrTX9TlZRq+4KHWrK/rD0y14niZJ8W3e8lRCLBSUOk5jtpXj7uDMfYVgFLqil6fXKq6Cyq/ntquAeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYhUdYurpLA4+ntSbUCDmi08M5mWQgrK1cFqi0Lo+SI=;
 b=wIjyEqhQMtBNU+wUCSBCyU+RdzW/m0xZ7c1/kznRiimHufCPbNOYlWYCRyXUh398IQMjEenpxfPVOXfrR84sWJ9W/epXO9UGfGQvKd1VC9AQzPj7S1YvIhzOhJs/eORtGVFwohGUKHLW8mmKyvjl/80gU2zhzI0jZKJAPhUPJHIZFJJFJBsCh3KrG9nmRV+ba8PIJlpc8GEpTcFZUXKwgdBmkJjBUPt12mUBbLIlDw4VOMqQdfoopIaTKuEPSoFBCrTd/INx96GndtdylRE0w29EmDdy+kOGO+QDU+A/za4Z/rL8jIdPybBIsYW7ZCmtGinN95AYL6uTauHfuD2qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYhUdYurpLA4+ntSbUCDmi08M5mWQgrK1cFqi0Lo+SI=;
 b=gcAsUAoDb1Rgi1nkMQkErFbZRy/FIKjWLg7DQ5uT4pXOgQ5+Z+bgLKKeCR1jHzwl/1JlZhFm8svvNo6B+kHe44ot9SO63/iUXM7uZ8SwniFq2MgEta0y/eJ51NaUtVaW/tmNbz+X7FjsmlEaDKm86dpFZxEUR+95b6YFL014h/Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS5PR10MB997753.namprd10.prod.outlook.com (2603:10b6:8:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:59:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 17:59:21 +0000
Date: Mon, 10 Nov 2025 17:59:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 2/8] mm: add atomic VMA flags and set VM_MAYBE_GUARD
 as such
Message-ID: <b2fb32db-1edc-4420-ae42-96f1efa9b7f9@lucifer.local>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <cda9d4c073d773ef6c2cf2939d66cf80544cff40.1762531708.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda9d4c073d773ef6c2cf2939d66cf80544cff40.1762531708.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0686.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS5PR10MB997753:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8a60a2-f0f1-4ae0-7a8f-08de2082dffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gy0tc8VC3h08FdY8KQA3hIR94BJaUZ4iGXleb0HmYTXzj5ZeVLLu5ABn3o5x?=
 =?us-ascii?Q?zKFsa6E1fS+zuf/HXZepvZsFA+9s4EdDTfGly9bJq8krhuKU+x/cWis+Oero?=
 =?us-ascii?Q?nKBO6P3OP/Mkj5nMz8PApoZjg9c5dfLQOvVY57c+Sm1mefSfG4uYivt8v36H?=
 =?us-ascii?Q?6v0gQiRtoFrXTP0k0PE/kCj0xM38HoMdjkD+s4B2w1Jcr7LVZFvyo+KCgp/i?=
 =?us-ascii?Q?uu9gp2a/H6Esfh9RppVzSTFihLOjg4K+FUe6S7mI1N0hRJ8gUuBHfdoQIAFV?=
 =?us-ascii?Q?q6Uv4zliEZuHThYgnYHCFPrcmIvwHCeFP0j2rIzty0sdFDpa0qchploy5wSv?=
 =?us-ascii?Q?eMsqARbTEyIgWY9U/5vg8nEdsJT81NgehFTKk4rTixIRjQqMkUWxfvHi5Epv?=
 =?us-ascii?Q?jjLNu71CwbNTpKip/DQBfgbQpepWvF/c3n6Up35wqArOl8RL9lhl7x2YkGON?=
 =?us-ascii?Q?P+zxwv1SP1CK0fJuoZOnpq1gublJBiYJU4RldBjFhreCFf8qIuL+cku6+jtK?=
 =?us-ascii?Q?dTkzgwtAyw/949fqsMQUUprvT0IlW8opqfTRrhwW+YHN6z99yZsprDBf6SuM?=
 =?us-ascii?Q?u871IUP5WFYd5Sx3+WqvUQ2Iid6ggJXxFxInE/SYZCqQnJkd17EP04zLRt+I?=
 =?us-ascii?Q?o3PwMzDtXbxR9HoJJpdab+1CvC9x4ziAZLrW+SwAg4FYK7NYTPrHhqb4qHD9?=
 =?us-ascii?Q?am9q883nAzYfFLosrua1lojyBM1JWxluUWKEpbkW/t5jG8YgKvBEJ9tq8KC5?=
 =?us-ascii?Q?d3SkiU/MuIQL+8cPVJDx+aoF3FObIuPC2kS4eEpVtRf9CDSocqnZt5YRPR+B?=
 =?us-ascii?Q?xgCOy8IIC5TsL6Vb93P5E8FY6hDp48eh1XZDdZKlf6oMugtOoyBAPtw5pDiP?=
 =?us-ascii?Q?C6TLocJ75dOIg9cYo7qHIbi04uYf9jGmXZfDjYJkZG5B1+Ni3D6m3GTzqQtT?=
 =?us-ascii?Q?vIV0xdorg3qa4i3f5GWdI3daCj5wELYHZLE0jjNiSgRvIDzXk10TpRBtKIal?=
 =?us-ascii?Q?kbIzitWcH8wLTRx5eka7IKNp8OMfNQYjwoHmtphJhHRfRWp2UxTbKjVXSJ0P?=
 =?us-ascii?Q?NSnFgCNKarntoiVrAU7FGcrwjKh3ulgNU+aF6UAVXYStA/HL1NmcJPy4iU3Z?=
 =?us-ascii?Q?56/eXrexaSh1P1QArswsDGbqGqGYxMi3Hqja7jMbdRRWLNuI8T1w9cNc4K8H?=
 =?us-ascii?Q?RNunfqdrzWaf9LNN6iMiqKdektjnufykKywz6Cxb38xkzBe2tR45srXGFrRg?=
 =?us-ascii?Q?Vg1+MlPhkbxri73ie6OH/MOkRykAjf6Px7GOSKsFoPSH649fhwZSNrHsoBqc?=
 =?us-ascii?Q?vTX/25EDxiusI159HQ/a+kyOdUifIy/mLEw26oyh6p0DjVYvlretsMbuaXPC?=
 =?us-ascii?Q?DugwJF/+0Ta2sglsv8y7FsXvoqfGJ/3lMAm8hcVnaZM+1VD6jvtMZS/vjDcQ?=
 =?us-ascii?Q?YI/3/f7cA3avB7c+PG8Ini1imLmn7HEb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kidp/BdPe8TWJOr03RGDvOeQBQF5DTz3SOTidX7Qc4wBoZYk6mmGaKom9lKv?=
 =?us-ascii?Q?cNcNpRF1MjgFm0SXsh8Ihz4dgAe3FXxE3ucOl5+85J9Bd+jfdmS55JnTGmQu?=
 =?us-ascii?Q?b9q/rQp9+4Q9EATzy7tVbAkjc/gHq8kndspA606jbXtQyYzzj9T40E5O0jpN?=
 =?us-ascii?Q?Og0T7gFtd7THLHzvEpIHA2pYYAmUk0QMb2++prr3KA3/Fg6II09wnEqRW65+?=
 =?us-ascii?Q?jRJRuKL4UkEDP8BZoQRUxD7xeyrr+xBXSYPpsJUMsS97Yx6FbtD3ePufFIS6?=
 =?us-ascii?Q?9P8S25fEKOPWZTr3Hu7E3h1mpvrpWuHShvD82Cxdre7C0SwQuNhnvYuQqrnH?=
 =?us-ascii?Q?7ystiQn3mEheIT3/K4UkY/rZL8PYI+YIBZ/ckCUSYmW6kM8eRA92A4kxnnBu?=
 =?us-ascii?Q?RplA/yQ0j0NAC7DIdxZ2wFuhv/gvWKnher/sh6jQLcOsXUeNWtu4DYwVQLSr?=
 =?us-ascii?Q?6DIBtxUkHp3W7WL97ehTSS23W3UXyvdOU8SMjAeRFA6EPXrT55kQFyRYb9hv?=
 =?us-ascii?Q?Jc+EFPtQMdcBSXrNCaDVXhYR0QJzBDdI/0T1vzLjlm+2CSjlKOdO3IOk6yjP?=
 =?us-ascii?Q?ovuHRMI5MT46QnJrLPCEgKTccQym5XRepKnDZQNGVgdGLEQLDDEYCdWUXQVI?=
 =?us-ascii?Q?PH+8VljMfZnsqgiiTuiB6/Y0q/HWpwK0voIG3aTBkuJuuA9SJchS4A2Lylxy?=
 =?us-ascii?Q?XidcmwF513misoaWvbVXn3TmhHnheCagMdr4qh11z3Quz3eeMrnDJOyBr2lm?=
 =?us-ascii?Q?0e8jqz5AG2/g/mhr0+sgAg+dnyULSLIhF8mWmOJofPAnZ41Wx181LrK9iGo4?=
 =?us-ascii?Q?BMFra9xbb1r5aiVgubj3Fu/hzm9EjNFKdx611b28vKvKUqgLycvlUXCtk65c?=
 =?us-ascii?Q?DisYQJoCl2LfhWZvvPhAeipKF9tgxhOaJG7toPTuHQ5vxqb7LQFYslfClj2Y?=
 =?us-ascii?Q?dSmaOU0kRC8vA1MUTOJgS/DevqbNqBb+XAOXTWDWq7KYfYcnhz9tq72t5X+i?=
 =?us-ascii?Q?AF6t8uKQ5cUEVppugps6jYP5Lpa4rkrbAvenVxpVE+k7RBdhTtUB6hO6044g?=
 =?us-ascii?Q?K1d7QqBUXBu33Ix8z650b9ZFLgOld5k6XyyACzfcquXgKKzPlBWVcRAGKxpM?=
 =?us-ascii?Q?NGjnq2wmj+SuYIbZhn1Za5XFCVnHj2ws0C4c1CLB8SNPmlb/z/fZYshBZNTr?=
 =?us-ascii?Q?F4hgdsLocZsWX8KwK64dok0RkGQkiKS+eHP+65ncRKGBzcc0MjMnj84m4iKb?=
 =?us-ascii?Q?K3C+GSkNWWWj7279cLHI24JvBu00+gGmfvUw81ietcYorM9gMuNBsAf8E7J0?=
 =?us-ascii?Q?Epdzeh2zsoykiBtbQeIrXUbFJNKjXcrHCnitwyYoE/si/CX2ydzYhuhQsi2D?=
 =?us-ascii?Q?zqqdsMATYr03hhKTkf1kkg3uGB6mbPuNa6rJdWWnNYRuig4z59HyZb8ZDjpR?=
 =?us-ascii?Q?hUh6/eIgxonAZIfj7Uesp6yw2kxv+Xrs2726DeUj4JLG09i3+QP8r1VNgn7b?=
 =?us-ascii?Q?ArkUbdMTvlMEAvBvFzBP9L4K0T5tBpZi/V+MPe12QG+tfnhhQoDfUVHIFnfR?=
 =?us-ascii?Q?UMp0nv1SZJCG7Mv4T5Gn+GtUUAzzC9I+uiatMKAjGvU73gBDrVIByjrnuCCA?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iMft61gCTsP9kcJjLke/aGylDAR4ocLDgwYFu2gebPKbC7+Xap4q6WBrTykmGiJQUYlg40djs3hnm2KZ6kgU7zXcDcjUn9YmARs+GvWknsvnWMkbQWUNrWq1ycasrGTrrJSjTcyr+HtUffd1EYQkbj2jUFzj4QNySyrebFYX1EhfhIxYvbq8+ccRgDZ27Zq5CAiEqJqTS1XM3o8IFzJpfKs7UDFYAnFK71/wF6rJHvBdSNAgdUMIKAcC9KSET+NUllizbt/QR2nVSUmAhaZ0vgfGlS6kVUPGxhKRIZWEChJJKIejXw+16S6wnUNlg1KBlgK4Vg5VFjxE7AELdEVU5QV6t/gMc8QbJZpJJEwvhNp9ozmKBT39n5hm8e1JphHf7/ZsU64o0/uLdtir/yGRK6zch8Gh7Bl3IryT9sIMN6fPWbMWCMNbxRtQf3zFRGD1bsfoM6yDVlfJg/Egp7HdYRZ/bv9fQlP/HXe1GU8G3eBNUMENlSscEpkTy9lLfCCQoUFy6xIOYwagnkTBM26gA2sf1zEW7F3RKKIHNgCXrxeAMV+dKQzPKm3kSCW6p1hc7nxcyIj9yHi0mnsd+7hLsgMZRNc2mm735k21e/LZwFQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8a60a2-f0f1-4ae0-7a8f-08de2082dffb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:59:20.9485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktQujMu/ys9CLI1JbtSZzw/I86Rmr35IenEEmNZJhkrqX4VJDHieKDVGPHvcUj+isY8SJCEQGHeiTKLGMupJGsZZTd5XC95k2Z4RNG5DP3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR10MB997753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100152
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExNyBTYWx0ZWRfX0phkQVcYF4bd
 R2QPgcRxqFAxy9AVL4YCuUNwSrw8822qEuc7YmlAtbeeujRgd4/6saeQdVXb4xRW+AFC7qXtahg
 8mmNd/8q64L95ss3OMo6kKq61CAMlR1E545zNQ2gOx+UKF+7f2dUnxDusek2VJlhwabNA/47K78
 Ihp9ZBVRJhpA8kYS8a2Xk4KpNSHQqxA+A8ICL3KXHgXrcq1MJUoeNIDtg91CxnITXjnuK1CLDCg
 iJ8hN+L4xGk/cI4Fzq/72BD0rBfVRSiopfhI7w67NiN+APNNKjMuuZU6tOWhdesOIopRu3vtx+j
 Zt87KfzEnmMcVJ6nOCgtUiBeXJIKFY1lTZ2/j9hjsq0WZaSmSlVz3ZO6Qn45HTeANmQj6CZPEVv
 7eGi7oRWooMOZyNFsz19TFEKdI8sYDnaQZfvE2HUEsxkrIVImBU=
X-Proofpoint-ORIG-GUID: 0wiyjJIvP14Rq0I03Gq66lGBT4zcOABI
X-Authority-Analysis: v=2.4 cv=DpVbOW/+ c=1 sm=1 tr=0 ts=691227fc b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=xTTohR40ulQbAbyPfxgA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12099
X-Proofpoint-GUID: 0wiyjJIvP14Rq0I03Gq66lGBT4zcOABI

Hi Andrew,

OK take 2 here :) please apply this fix-patch which both makes sparse happy and
avoids a clang compilation error on this commit.

Cheers, Lorenzo

----8<----
From 553fb3f0fc9f3c351bddf956b00d1dfaa2a32920 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 10 Nov 2025 17:35:11 +0000
Subject: [PATCH] fixup

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 699566c21ff7..a9b8f6205204 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -886,7 +886,7 @@ static inline void vma_flag_set_atomic(struct vm_area_struct *vma, int bit)
 		vma_assert_locked(vma);

 	if (__vma_flag_atomic_valid(vma, bit))
-		set_bit(bit, &vma->__vm_flags);
+		set_bit(bit, &ACCESS_PRIVATE(vma, __vm_flags));
 }

 /*
@@ -899,7 +899,9 @@ static inline void vma_flag_set_atomic(struct vm_area_struct *vma, int bit)
 static inline bool vma_flag_test_atomic(struct vm_area_struct *vma, int bit)
 {
 	if (__vma_flag_atomic_valid(vma, bit))
-		return test_bit(bit, &vma->__vm_flags);
+		return test_bit(bit, &vma->vm_flags);
+
+	return false;
 }

 static inline void vma_set_anonymous(struct vm_area_struct *vma)
--
2.51.0

