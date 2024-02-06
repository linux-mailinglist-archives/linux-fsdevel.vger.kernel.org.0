Return-Path: <linux-fsdevel+bounces-10505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE1284BB92
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 18:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0B91C23E87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 17:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C156FAF;
	Tue,  6 Feb 2024 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RI3nqheQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UOfpNbwh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A58F6E;
	Tue,  6 Feb 2024 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239130; cv=fail; b=qdntcaxlx7yem8e+XX6PCEy6SOxZMFLRTPazzTOHWvkEp+cN0RWOzKXI/old1eWfYCUwBWlOQ+4yoTVW+slmKYf9Cq8YjqwMP6h7FlQKE5IhYVh2QEU3HInub7qPqVZx+2ioGtulKz21QQFaHGlRaB3buxQtPtJSXX/MeXvnyjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239130; c=relaxed/simple;
	bh=dxhp/SvByN7uWAgZarEsA37yFSSorp/qfWUmA82Ut/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EQJl0D5OCXet8q/qFc5QYkOC/Am1vBT9AewEs1PWON4vZ6XaPWpJx9bGExcezrGw3YNJFKvim4ECoM9nxyC1M4kZ0KqtHUIHSffi8Wdq1d5qjSjTAd1SAy+k8XHOxSvgYA0vx5sK6rRdUSuN0L3QXVVHyzFXPaIH80xFgGNXPns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RI3nqheQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UOfpNbwh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416GEohk017642;
	Tue, 6 Feb 2024 17:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=oJ9vuUnX84bletNern5D91uggb54lTKodKkDcfkrtns=;
 b=RI3nqheQdt/VxMjNu41eUxX+t3FinCTI0JFLOq1PmOGUMUhKUVW/m7fPvrCzttNyR7HZ
 Z3OZ6DS0NjDy/KzmASv+4V2jz1b01W3j+vrnvsFlISvNsUpsoCqbY/l2+ouPhM9HHAxJ
 zVlNiBsTCEUB1wln//oDGtsQYjhudHfgcc3ckEZf2OfM+k79h0hUAB19NocoVrsWM7vd
 kLKQjJCtjlSYBUjG/NrCIfjSlxuLKKFLskKprB8pzsGSl8ihsof2//09px3tNhYGq9Oc
 ilar0ZxvZ7pgFtx3Wj7sox5HijVAnzbdX/hscQWvceLjC1xrNMGkm3sAIsXPqOShTErz vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c32qfkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 17:05:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416G3iun038405;
	Tue, 6 Feb 2024 17:05:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx7m13d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 17:05:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZBaLkZeYdpET4FUzaMSUhxKoNny9O8F14gkF2owrbsyjoUaYDTvhFnN3CSZDYwxPOmluMHkcCDeyMxr3TjhBq6g7JKDTCyWtZQVzZ9uA0geIhSehF8Fo9CJTzcn1CECUraw8v7fZPBC3HMXqw+a7yC9j/lap3VWV07cFPyyTwlKyLatIzVBlHQLFclu0GOhU8EzhBaobAixVZzvRC6r3n3vNrG1mtzvQR6ONmSsqT7Wti7lVr92T38ZErEkr293E2TGII5KHzuib73tLFvRM3ikvwmIqRBI5R3JkI4VJRRzZ21zAdN3GlMBwjmPN3cxnJP+/RK5s+0gxP80FVz4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ9vuUnX84bletNern5D91uggb54lTKodKkDcfkrtns=;
 b=lF8ARDbz1ZvohScNZwhgRBckIoH9yE/YOpH36UXiPltpdOK05e+iqsd7AL+HL3OlJ2jjF9TqemIwWlDxtm47TkBCbdb0z519+zBPysNmOQ+XKBfw/KhnT0hYqfWZux89PyJ9YFRdTXvIw3CWrh1s2Jqbhn3VBLfQW5V/ZhDcf8NKhlsvFUyXSyJZ6TuVYanrcTfTejyuDmZ4aI8FsNUsvxMiWLJFmrdYjJvRmDJDruGuxag33ekxhDv5HSNDEnMTunqPG2pEuFKlnTJpCt7V+G1qOc6Bde8UtaNXF0zz3gqGK6u2i5A4CwmNt0EqQ+wF2I8KfRqywAcxDwHHlhOxXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ9vuUnX84bletNern5D91uggb54lTKodKkDcfkrtns=;
 b=UOfpNbwh6cDmWrb5bFo+o2njxLYFWKZ/G6/qm8v9C9qhU+kovDuQnvHisPz8x6krGd2EiDbWF3hJG5ZtNtG6eUGU95UZeWXLGc+PySrOmL1RpWYwxqeG+x0hA9D40gPlvlUalCbPUvymWLij0UOVO3rChxyJ5PuRTklXfCU6yTg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB4887.namprd10.prod.outlook.com (2603:10b6:408:124::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 17:05:04 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 17:05:03 +0000
Date: Tue, 6 Feb 2024 12:05:01 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
        aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
        axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
        jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v3 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240206170501.3caqeylaogpaemuc@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com,
	rppt@kernel.org
References: <20240206010919.1109005-1-lokeshgidra@google.com>
 <20240206010919.1109005-4-lokeshgidra@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206010919.1109005-4-lokeshgidra@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: aa229f6e-1667-426d-cbb5-08dc2735c2e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uvh0CW03XMCjmPEgeSgIGP6IQefxc1LWMCBAsp9LbQRP8puiyVdyHO37I4TB5qW2sZQStsh1lN4bKW8Y6GKs/vRNH55UJwTj8RkY0BiGwejxShT/QohEvLwYLLEwcGFpvI6Cfc3mAFFEgX83VRs5g2c3IynQYjs0TcO15ZAvC52ff0OJQD4b+MiwnZd5vMqELL7R/sjYxYQoYic02cpW/8gEQ+jEhHMZRBdqPVhNPglF8GaazpUKmpIgNCA3d1cQ5Ae39XWETG0acpasNeEFrk/i33ikSxqffljgRkFLFzN1qxlfxWql2TgdUoRE4Ng1CHq5ebnv5B5A1SKC7Dpt2H8zzB8D6NfQytRp405TO4ZOmrejkNizZw0Rn6C27bN9HiNp362+w+eVuonpX83OaL/d6oUeBZXI8J5nnImBGWABkdKUlQIVB+J7yuHBonaoq9ELpDak79u3nulyybDLmwIL7E4ye4NJYsmX7MPBu32/2soC1VIRPGIzGuM8r82v0dFPKL1XRqmbk4gKOaVUUsNp/1NdTWzKgOkWAi5NDhLKs6eTGCV+wrBttSzCyvgz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(230273577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(1076003)(33716001)(26005)(86362001)(41300700001)(478600001)(6486002)(5660300002)(2906002)(316002)(66476007)(6916009)(66946007)(66556008)(8936002)(4326008)(8676002)(6512007)(7416002)(9686003)(6506007)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rYohg0ZtOJCTyBnlFyL9ByL43k6s7ReAAuRmP7KlPnfwJieCBX9JXlCYIK5N?=
 =?us-ascii?Q?Wn2OwtxxKV680GWega8E0u74lIqbdtl+ZzEjVsYuSV44pFA8U0aElXKmUw91?=
 =?us-ascii?Q?MwMZtaM/MArIadzyAXqS7coiwE0+/C3DWkReJQ3Lxk55Lz3pYJPCUN6snfLz?=
 =?us-ascii?Q?HXdmckDHja9OTRDRjNSgwM3whIF4u+kjRe52HlYBTRvopqC8xs7VJH4ojLi6?=
 =?us-ascii?Q?W2Vz9OeFNnz7ws/hl9w3SnF3FT1tu2QZvsgO1rMYLKKcZlBUZt+w888rzoh2?=
 =?us-ascii?Q?Op1y6JwJMVTnblesF9bzs7kdZPRfYVS0TlA9xZP8I7oboEAV+Ld1ppsZwZm1?=
 =?us-ascii?Q?bfrXAM6ViWZoas981L2ORtq5L7tT22clnCsKGGca+FrNe9Xnewry14+AX540?=
 =?us-ascii?Q?zY1izvvbx7HCuKMhL3iNiNReyRM9qdKtIrD4P3FRwrIOK6zuNrODjYATYMj9?=
 =?us-ascii?Q?87DRhTxqpFBl0bh34d6O8/poMJoiHSbqHBx0VoAAnJIrvltLzeqIdyVBWZdg?=
 =?us-ascii?Q?4RGl4yiSDnq1EjUSi2raIrSQ/u+McRTeBhSQF/dYevPSXPA7mL3qdcL1oGSV?=
 =?us-ascii?Q?LC9u1qTsbSg95JOQDDe86L8hqoTKFSCkRkChfOUfq2gI5D82yM9r3rXXwEDX?=
 =?us-ascii?Q?CvweWSpNkGwy9F5qyY6UaCHN2df2PwUOkP6a2HHAF0ILLT+v1b6ZeKT4kYgG?=
 =?us-ascii?Q?G9vbMOfk4D25G6BLTplLsO4f15VEFtm4I9h4uGH0Klb6IJmY8kszyyja/KIa?=
 =?us-ascii?Q?w8GOIQyPX00Aq3+B4Dhqs8axJ1ArDQOLTXqk+h4SsET54fZX7JD/sA7417rv?=
 =?us-ascii?Q?iZYxtyGh6iT8A3YBD+4qrZtfdqxY81Dz3WUhrDBEP387OH1Fvbp1bFo9qgFk?=
 =?us-ascii?Q?1rbxeN4Go1/yXy29OzQdT9n9d7xbdy+7lofv2SbUwU5qWWA1GJ8JOkl+cP9a?=
 =?us-ascii?Q?ZfKjpcu0xcE0gW0OyvgMNGitDvf+GO/6izmJiI1M5LSLr3HuZTFrKcivl/9T?=
 =?us-ascii?Q?G73ZG1OTa22OdmxFMD9CJQPKUwKrTV3epcgMEPWtgSQ7TyeswWg4VARvtCwX?=
 =?us-ascii?Q?XnZTNcdzUu79vUVT3m17saQ6U9bY0QVDO7tA4vcfU2EqILFvDf1eD4Dzv4cq?=
 =?us-ascii?Q?tKC9HbYtLsuAfXUPcPyVzwI7oMMLAHdRrhSREuaVCdLdVySxnBQsz2h2Eo/e?=
 =?us-ascii?Q?5ofp9bUR8MxY3qTFX4tIfR67DrfV+Rbea/K4q1MjL4M6Q5qXQGDCdwsF22Vq?=
 =?us-ascii?Q?QG6SP64jQWKIo2yRRvOPXNhwqMFQKXtTcYKCw1TAp8fy8H0Yct5JumTt6OBH?=
 =?us-ascii?Q?CHdCthKQBHnbJJxKs8dDKFtEEgCLRDtAoKVq2PdddyeXbBj+N6yheVCT2DKx?=
 =?us-ascii?Q?XrLkV++y92orZNKOP6MZE4njaH+38qp2J+qlnaIyk4rJ+pudnabrrRxj2PIV?=
 =?us-ascii?Q?lXkXU7gS7V2wooD/qDBWppXKrXzA53A+OqLJaiRfS8vxovqDBhcVFoEbu2g9?=
 =?us-ascii?Q?IAm55tujUPOxvOm7bGzD3hmj9WdpqGBwf1Jue9Axz3BODhpAb8RdfnJofJZy?=
 =?us-ascii?Q?wBS3sUSnEqSuWMJvUGocBsNKF9YtkXSuYXCcKUPc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PLpib87iGh+PWgZshktFycjctpKc6b02/wa6Id/zpKnJ6wXXYlhw94Q4HyNZ5zQy+8FQNNR16JljngkjeMzkiVGGf4q54UTAtjrX1B7ywcRiGIugWBp0VXi9n+n7n777+qyHcUQ0/74rs+ovMJJWxALzl4KEuHEVkRjl5oI3rBOqDht9nCS5aFuljPEMKq6AQXh3+y77iB7mHbO2MdnO+PaXu7fAT6uU019aBaBh8758Ms6JswFsCmkzYMuD47hrkz3kUGmX4Of530Zj3Yz51IfQ+o62yJ61xJKtIZOYr49YuvC34+wcos3x5xLninymGcxBA/9wGC1HcYU2RN79rsCWfIksp0lrb9t1yc8/8X0OmTILSbRRFeoz7f5TlzLS+liT9O/RcQXXE8BHClkPPtXVeesKGBAdgfwz9sHg9vN55w45h0js+irjBxa7Rj1R9jbQ7can+n4sDT9BB4X1oIEUHStzNPKj4H6U1e00OTxLqrrdtAH9J+zaaAdkFZ28EZyUl/iJZyiaUFY46mdfQPx6rjaOvnf4H6XvXPEICit6ntdYjTN+U1FYmPyCsL+y5TCToWS+gQC2+zH2YVD0YFvPr4yc3/r/Pu4vWvWXAM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa229f6e-1667-426d-cbb5-08dc2735c2e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 17:05:03.7919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQgdopMuy9A8vf0lmrBIot3GzGrPEDrNttfqKqtEclGfoE5QExvXkrnenRob5aM1KmboQZkol9krKJa9AoLEZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=744 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060120
X-Proofpoint-GUID: wBg5nArjMvqZbm4A_Dnn9NWRYw8V-sHM
X-Proofpoint-ORIG-GUID: wBg5nArjMvqZbm4A_Dnn9NWRYw8V-sHM

* Lokesh Gidra <lokeshgidra@google.com> [240205 20:10]:
> All userfaultfd operations, except write-protect, opportunistically use
> per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
> critical section.
> 
> Write-protect operation requires mmap_lock as it iterates over multiple
> vmas.
> 
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---
>  fs/userfaultfd.c              |  13 +-
>  include/linux/mm.h            |  16 +++
>  include/linux/userfaultfd_k.h |   5 +-
>  mm/memory.c                   |  48 +++++++
>  mm/userfaultfd.c              | 242 +++++++++++++++++++++-------------
>  5 files changed, 222 insertions(+), 102 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index c00a021bcce4..60dcfafdc11a 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2005,17 +2005,8 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
>  		return -EINVAL;
>  
>  	if (mmget_not_zero(mm)) {
> -		mmap_read_lock(mm);
> -
> -		/* Re-check after taking map_changing_lock */
> -		down_read(&ctx->map_changing_lock);
> -		if (likely(!atomic_read(&ctx->mmap_changing)))
> -			ret = move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
> -					 uffdio_move.len, uffdio_move.mode);
> -		else
> -			ret = -EAGAIN;
> -		up_read(&ctx->map_changing_lock);
> -		mmap_read_unlock(mm);
> +		ret = move_pages(ctx, uffdio_move.dst, uffdio_move.src,
> +				 uffdio_move.len, uffdio_move.mode);
>  		mmput(mm);
>  	} else {
>  		return -ESRCH;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0d1f98ab0c72..e69dfe2edcce 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -753,6 +753,11 @@ static inline void release_fault_lock(struct vm_fault *vmf)
>  		mmap_read_unlock(vmf->vma->vm_mm);
>  }
>  
> +static inline void unlock_vma(struct mm_struct *mm, struct vm_area_struct *vma)
> +{
> +	vma_end_read(vma);
> +}
> +
>  static inline void assert_fault_locked(struct vm_fault *vmf)
>  {
>  	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> @@ -774,6 +779,9 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>  		{ mmap_assert_write_locked(vma->vm_mm); }
>  static inline void vma_mark_detached(struct vm_area_struct *vma,
>  				     bool detached) {}
> +static inline void vma_acquire_read_lock(struct vm_area_struct *vma) {
> +	mmap_assert_locked(vma->vm_mm);
> +}
>  
>  static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  		unsigned long address)
> @@ -786,6 +794,11 @@ static inline void release_fault_lock(struct vm_fault *vmf)
>  	mmap_read_unlock(vmf->vma->vm_mm);
>  }
>  
> +static inline void unlock_vma(struct mm_struct *mm, struct vm_area_struct *vma)
> +{
> +	mmap_read_unlock(mm);
> +}
> +

Instead of passing two variables and only using one based on
configuration of kernel build, why not use vma->vm_mm to
mmap_read_unlock() and just pass the vma?

It is odd to call unlock_vma() which maps to mmap_read_unlock().  Could
we have this abstraction depend on CONFIG_PER_VMA_LOCK in uffd so that
reading the code remains clear?  You seem to have pretty much two
versions of each function already.  If you do that, then we can leave
unlock_vma() undefined if !CONFIG_PER_VMA_LOCK.

>  static inline void assert_fault_locked(struct vm_fault *vmf)
>  {
>  	mmap_assert_locked(vmf->vma->vm_mm);
> @@ -794,6 +807,9 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
>  #endif /* CONFIG_PER_VMA_LOCK */
>  
>  extern const struct vm_operations_struct vma_dummy_vm_ops;
> +extern struct vm_area_struct *lock_vma(struct mm_struct *mm,
> +				       unsigned long address,
> +				       bool prepare_anon);
>  
>  /*
>   * WARNING: vma_init does not initialize vma->vm_lock.
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 3210c3552976..05d59f74fc88 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -138,9 +138,8 @@ extern long uffd_wp_range(struct vm_area_struct *vma,
>  /* move_pages */
>  void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
>  void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
> -		   unsigned long dst_start, unsigned long src_start,
> -		   unsigned long len, __u64 flags);
> +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> +		   unsigned long src_start, unsigned long len, __u64 flags);
>  int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval,
>  			struct vm_area_struct *dst_vma,
>  			struct vm_area_struct *src_vma,
> diff --git a/mm/memory.c b/mm/memory.c
> index b05fd28dbce1..393ab3b0d6f3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5760,8 +5760,56 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	count_vm_vma_lock_event(VMA_LOCK_ABORT);
>  	return NULL;
>  }
> +
> +static void vma_acquire_read_lock(struct vm_area_struct *vma)
> +{
> +	/*
> +	 * We cannot use vma_start_read() as it may fail due to false locked
> +	 * (see comment in vma_start_read()). We can avoid that by directly
> +	 * locking vm_lock under mmap_lock, which guarantees that nobody could
> +	 * have locked the vma for write (vma_start_write()).
> +	 */
> +	mmap_assert_locked(vma->vm_mm);
> +	down_read(&vma->vm_lock->lock);
> +}
>  #endif /* CONFIG_PER_VMA_LOCK */
>  
> +/*
> + * lock_vma() - Lookup and lock VMA corresponding to @address.

Missing arguments in the comment

> + * @prepare_anon: If true, then prepare the VMA (if anonymous) with anon_vma.
> + *
> + * Should be called without holding mmap_lock. VMA should be unlocked after use
> + * with unlock_vma().
> + *
> + * Return: A locked VMA containing @address, NULL of no VMA is found, or
> + * -ENOMEM if anon_vma couldn't be allocated.
> + */
> +struct vm_area_struct *lock_vma(struct mm_struct *mm,
> +				unsigned long address,
> +				bool prepare_anon)
> +{
> +	struct vm_area_struct *vma;
> +
> +	vma = lock_vma_under_rcu(mm, address);
> +

Nit: extra new line

> +	if (vma)
> +		return vma;
> +
> +	mmap_read_lock(mm);
> +	vma = vma_lookup(mm, address);
> +	if (vma) {
> +		if (prepare_anon && vma_is_anonymous(vma) &&
> +		    anon_vma_prepare(vma))
> +			vma = ERR_PTR(-ENOMEM);
> +		else
> +			vma_acquire_read_lock(vma);
> +	}
> +
> +	if (IS_ENABLED(CONFIG_PER_VMA_LOCK) || !vma || PTR_ERR(vma) == -ENOMEM)
> +		mmap_read_unlock(mm);
> +	return vma;
> +}
> +

It is also very odd that lock_vma() may, in fact, be locking the mm.  It
seems like there is a layer of abstraction missing here, where your code
would either lock the vma or lock the mm - like you had before, but
without the confusing semantics of unlocking with a flag.  That is, we
know what to do to unlock based on CONFIG_PER_VMA_LOCK, but it isn't
always used.

Maybe my comments were not clear on what I was thinking on the locking
plan.  I was thinking that, in the CONFIG_PER_VMA_LOCK case, you could
have a lock_vma() which does the per-vma locking which you can use in
your code.  You could call lock_vma() in some uffd helper function that
would do what is required (limit checking, etc) and return a locked vma.

The counterpart of that would be another helper function that would do
what was required under the mmap_read lock (limit check, etc).  The
unlocking would be entirely config dependant as you have today.

Just write the few functions you have twice: once for per-vma lock
support, once without it.  Since we now can ensure the per-vma lock is
taken in the per-vma lock path (or it failed), then you don't need to
mmap_locked boolean you had in the previous version.  You solved the
unlock issue already, but it should be abstracted so uffd calls the
underlying unlock vs vma_unlock() doing an mmap_read_unlock() - because
that's very confusing to see.

I'd drop the vma from the function names that lock the mm or the vma as
well.

Thanks,
Liam

