Return-Path: <linux-fsdevel+bounces-21038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8888FCFD1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226AF1C21B66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D2B196427;
	Wed,  5 Jun 2024 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mWkWd78R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QfYHjkvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBC2195F29;
	Wed,  5 Jun 2024 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594434; cv=fail; b=smzivlZKcp1uuTQb6+0M5hcGIApIARY7PxlMYLLsvt869WNvHBZMuhOfCw1kUvmwaIr6UBOYRl9KhfwOVqeRjP837B7pXXsj8YYA2zHJLyp0bLSc0oc/WnxyQxaOt2N5VlnFfl8sznX9YbY1krob0kbft52duUM2x0XvblPjtF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594434; c=relaxed/simple;
	bh=RK6thvHKZ585Dl0ENW9D0A0hk9ETPBYr32P+6Pmcu/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QKFx/EyljnbYI+jTr330yLLeqdB+CcGSvOElXucPcmqlN359P/jd2RSQw0VKcF3OL93BQKk1sx1c1tE3zdO59c6roo376wuEWEl9z1NPf3YUnccNFxyTnljHPnNhjbmFCxUGSNhNJusshQs5AjjuCMbZEedOs8HbCZT/E45sl2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mWkWd78R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QfYHjkvU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455C5wlN005638;
	Wed, 5 Jun 2024 13:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : content-type :
 date : from : in-reply-to : message-id : mime-version : references :
 subject : to; s=corp-2023-11-20;
 bh=2ERedMjohCAFP+06HJvWA3Kp70yro6yp1e7efFoeVM8=;
 b=mWkWd78RLgpS2JfauyQhnfc0Oo8hBl+ZDGURHl3+BjK5unJdQds48+pQwxWUwznSQXGU
 pGsDq/SlX1lDa3/1Ah5wnrhlE6A73wMk+Mka99v2f6mUSSrLIJ6Akb2/2e++22vjm0mU
 2lk0goCiODKG4jYRbzmWm8W7iO9Db2SuWWVi0z/3SDj1pZvUu4kJ1YYtg9RhRWsV1Gsz
 cWx1ZpeWG3EdfGMLy7UlzAiqIodUWkyWvC6UyeUgMstmyoEZvplBmCJY7C49EBzBfZXq
 SIOIB6GX9mdMVR78V+b4KZDdO8sqD1LgyLC76ZwnCRVX1SHFFdrtd16qdWxrQGNM4264 EA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrs99rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 13:33:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 455CFwxG005543;
	Wed, 5 Jun 2024 13:33:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmeyxr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 13:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDP1y9IDHpPWwUEW8KRraSGAwl1hkKTuDpeCPdSG06+1PbCOXjfHYkjGdJxE8Hg2o4Eq5a90DgmDL+W308xWtraV4mTlhk2Unyse7gRl2+ITJv4vdy+oDJv4lLfqSYkRkgx03Ot3xl+Q+8ZAqvxZeRo1Fh2N+Q5UFFBYeuwta8ztCX5LvoraYEldIOREnhCrjAmtrrrqTUK8KeYolN++Xf5/FU/y+V6ozskjSSeHGBCyFtkhWcWP2OqWkb5a9GG8HFS7OCytfISjPvh2FwWUrESCC/W5ZFkVZq+uc3Z3/uIc0+4M3+9aK8pdEnmYpz5jK/71nLhEIWyWsWPm4G4YMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ERedMjohCAFP+06HJvWA3Kp70yro6yp1e7efFoeVM8=;
 b=HUuR0bNPwQEdLHj8wNBqs2VsNDYWucJ+Ah9fEUWi6Rr3irJpQc9MQzDy9ViP1An/r3xJcQJ4jcHg3jeruN3UH8HK7FYh2eNdiFR7yb44PN3QdZuFKp1o8wXb3I4mQ5T+qn3+XoGBQESUN4P0AOeqbUPbMzJxOJVfYN9iDzeJQSPNsxxy5PUYP9xdLKexFalKsvIzabbqmGcJ9rXTr5CdwZ3IcOBCPLoPaQGmeT3tRHPi1wlolpQFy+veHF0kar6aGVfd1LC0PJzep3zePykG2SktIhqxARUcFgoTcXlIv9W9VBd0eeYkGmYTppbxy+PlvCr7KMkFRQiqdhetGTi/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ERedMjohCAFP+06HJvWA3Kp70yro6yp1e7efFoeVM8=;
 b=QfYHjkvU6nIIR7Vd/5ib7iqbK8damVmBe2m2Sot5kNc2qGcmhrpn0g1YjA71umLsYSR+a5W1fkms64gN+wv7FjirIz3lgL/7DoOFFdL1Te7zROsVoTlLkHGkotZ7hzLODMPgWXF7rW0uzG5yoDEPToEGnQZp9lzBIS8nQhSPgIc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB7237.namprd10.prod.outlook.com (2603:10b6:208:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 13:33:14 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 13:33:14 +0000
Date: Wed, 5 Jun 2024 09:33:11 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-mm@kvack.org, surenb@google.com,
        rppt@kernel.org
Subject: Re: [PATCH v3 1/9] mm: add find_vma()-like API but RCU protected and
 taking VMA lock
Message-ID: <uevtozlryyqw5vj2duuzowupknfynmreruiw6m7bcxryjppqpm@7g766emooxfh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, surenb@google.com, rppt@kernel.org
References: <20240605002459.4091285-1-andrii@kernel.org>
 <20240605002459.4091285-2-andrii@kernel.org>
 <Zl-38XrUw9entlFR@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl-38XrUw9entlFR@casper.infradead.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f189a4f-580f-4abf-98ba-08dc85640cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MQIuJbh8028xMAicsRF81x3FZuQRtHkWxzaWldg8gB9+scXkGYFl+DUq5yO2?=
 =?us-ascii?Q?dM6l8wO+lHT4N/4Q/BQZe3vqYNtl3UIZbCpY40Oe5Tp7C3+PJEj31bPAdSBX?=
 =?us-ascii?Q?4IKqScacS+WJtffD0L5yhTt2HTa5G62L+40kRWnucirCT3AztDfbffQOeVrl?=
 =?us-ascii?Q?0GKpVkPogMh0w01DydnhX1DgJpPorrPMUv7xLyH32q6ufl7utj0fhQ/rk1/7?=
 =?us-ascii?Q?Xg0sRlNAkFKmD+A8qE1nQYcTMOFK79GPmyzdxwVNP4+patjVhdik85zPh2Wb?=
 =?us-ascii?Q?I087QUW/BsuTioUcY45h5MXnZBDfntYbtSawPBbeKYVlPCFK7xg8jF4zwSfK?=
 =?us-ascii?Q?RMoUcKEfhLYyPzduTcMv8tu5n+7Ij+mRJ2RwGDqbZOO/ekZPRz/1CpGCCTaN?=
 =?us-ascii?Q?6NHRAnwrOdllRLlibNvistN36cjn9Y4CMznS/zLFABqNGOQxp1OJU+9n+o+q?=
 =?us-ascii?Q?eoi7qU3wtqiFr5PQK/VEyhI5Z4I8cVDljhWjcsd74vwfImoSc/LpbOn8x/0l?=
 =?us-ascii?Q?OneNoBuTTHFawhYuCFza1fVNL+zFjVrrosPOyEGZD/3zTTdLbBKMtLXquSNm?=
 =?us-ascii?Q?lIxhXQZ/kfmwb4MF1fA0JNJtQTy9T5EibrnnT202UYPYCVXVj1HkmkqVLEaX?=
 =?us-ascii?Q?LLVv4GiUMxHbIRPGpOYuxy/lHnblf1vQXk5mVFK/vdU7eJ51qYjO45m6Mx78?=
 =?us-ascii?Q?Akrgqj31nyDpmy+RxsoIiiIIGLYMmvRupWqr7r8S85P4cqu5ZFinIt4gCuUy?=
 =?us-ascii?Q?IuaZRkuv/iqc4HjeJSkaPLDNqQlbgos3lUSVxtCccJGnY3qjNXIBfC+2AMzx?=
 =?us-ascii?Q?Tcwr7sMms67uwCuxTRdAjJq7hXGH2pkXdWEtoLJFPjfDEqMzbG35MOe9Znmx?=
 =?us-ascii?Q?dwmdk6dLZZHe9KkGs57HqCozPRsFhj/09yNWhgmBHUV9hCLDMKLUcrg1B2lF?=
 =?us-ascii?Q?nLqJKw1utVsaxAMd3yWMT4NZpYLZ6l2bgwMfAahzNvldUq4ZDI++moN5PQOc?=
 =?us-ascii?Q?TsSADzftqZYZEROdrz89mDZbFRoMC+Z8lYTiItMifuP3rJ+/918P0lrv4sE+?=
 =?us-ascii?Q?7tFv4r0EXoiiDZ2tqpctJ2fNiW5UH+PFE2WWEjFQipgpeB4SDjz3iX1KGLNr?=
 =?us-ascii?Q?90oxZBoQt5NRWF6erkf8+A5S/gdVVtzVm9OfESqCOsTid6BArxcPF2WZLIBe?=
 =?us-ascii?Q?PdXaLiBS4qDwSyMzqGUHBcu8KmpoO7aZq6wTgkx+j8YlTWrLqp0ga5isga11?=
 =?us-ascii?Q?MUirE0KRrHs7WxrddichbEosYoWReYJ5LTgRRa8cdZmSs8e3c0viY46x5JRx?=
 =?us-ascii?Q?TVo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jZ4pqBDbmrNSuEZrupprMVJrggg0aukxnrgnAkQV1q0sUrAH8WYov0ruZXF/?=
 =?us-ascii?Q?9SYUK0ecJ+3NlpcRlei7190f+ZKSq0UKMbckYu/oRLYs3z/P0x4RDnPyxh5A?=
 =?us-ascii?Q?/xWGU7UTswn+9m1lhZEwrmEHb4w8DCQ8TxgeauMwBMrn7Otl1ObCgBtRh8gt?=
 =?us-ascii?Q?ujwoimCB5YL+r3lcnUrQOM0Q8lyLNCT7l9eOAs3PqXTUNz8IayjIwJCPCrMp?=
 =?us-ascii?Q?Guy/KFnWgX8TyLkEZEUXl6Nt9Ic9UCXfmFVTs4Id9OARwG0zco+NUzSZlndI?=
 =?us-ascii?Q?+mZ2rPNc6mlpqs/i07QMDlyySOxYfB5D7XybVzk1mCoI1oTb655B0rrZ4O7C?=
 =?us-ascii?Q?eqJnfcoUV4wjw9UWAasZ1hKNVGg8vKfc9gmmmE0jFWasi9TwyOzkgILGiXfu?=
 =?us-ascii?Q?113t57iGC4cMX4/T+eBFftkN2XqSucvQB8qXu0bOAkAxNV7CHwyjUPhY9/gJ?=
 =?us-ascii?Q?pJY9APTsIWexvTBXKsrEbgW6KrbNrDbHYvI9ggkkij2kKHKD8elsOqNHhgjT?=
 =?us-ascii?Q?kFyTc1j50cvrQqy7JeqANbESC0CsJlnK4KDPpCzunsx55B7yZISsixFI6cS4?=
 =?us-ascii?Q?aNm6NNwjDGOS3Tcbh50RXiKJv+PFNE8+4VVMVoy45wRiJTm/VnhnZuvowtOB?=
 =?us-ascii?Q?clryitocY1lzM30o0tGzy9M/ZQqbbB5oz/b2QeJU7HM9XbWY3l+kxlA1491i?=
 =?us-ascii?Q?F6OjCDQP+xG7e5rtlO3QPWNqrQbydfOoeVuPIwR4qozaQ0eXQf38r+5cSRIF?=
 =?us-ascii?Q?nz1OPXlbxmKh5a0Ln+/wgjdCQViFnNba5X9r9QMEflNAibsJjlmqVxeXaEaK?=
 =?us-ascii?Q?ecjwoYM/k8zpdSynvRNAk5gawZnQZGZAy853tPmidnObVb6kdMEzRVc8MtYg?=
 =?us-ascii?Q?O6dziRMGHJXyqDgfZBHe4QL8q9mhrDK2hBGrprdkmWgP+7bz0cIUhDmzeW3c?=
 =?us-ascii?Q?HixfCNlui3C5WPe5FK67NZ0TwX8WF1HVdk7E3mICLGPZDQr9C9ImZBJ8zDGW?=
 =?us-ascii?Q?4UCyabcWKL26FaQ163iajblRzIjNBqs3WZIaTWBkZqv4F0uPfqLsBzbcvoWe?=
 =?us-ascii?Q?XxjKN/VJi8O1dXZF9u8SAtLnmyspeYZu3XRQ+c75Jc2SvIkZsh/imMCtKCxF?=
 =?us-ascii?Q?ZVjmEChO13dNVQ4jQeboXGiq9g9SHNt1Z4nPGFAtT/wUaBwR7Nl3LECxyjnS?=
 =?us-ascii?Q?M8C1An+OBReYRgcoqkU8wXxMpvlUnBmuIkg7z5g1UnLWqTZ7swkgIfGu9XDj?=
 =?us-ascii?Q?MgY4IgOzr8e0i7vPDY172UgIh56sMEyjH7afsR034L/He7/jpYsE78cRIaJ2?=
 =?us-ascii?Q?J96ctg/zdALCeLu3055OtbVq2WIMOl0Co7GmOeCY70g361nlEZBRQqpHwHOC?=
 =?us-ascii?Q?8qv8ssSIXu5KCoROD8+9qnUNvvjxVcmt0ih5n+uzzrnbvpGILS2Toud3qjHy?=
 =?us-ascii?Q?vGdXaNWV4icSlBWbSXPwOnkJXBFfuODPI9lje9i55yejQlqBYkHu6q0gJ1Ry?=
 =?us-ascii?Q?mNSBUD25jFh1U9MuV/blqb7QM28Xg7l4nJCHRRtirDVXkiWUU9ZYNKbybXTD?=
 =?us-ascii?Q?GGOeji3X17u5e0OCKbLnG58vg5WLzHhMtnXYnVnx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RdseA8tqikVsoPwCQFpEu/FVOSXBOiRS/KLrW3iDmQ/xCU1rZFu8OmBTiuOjCl6fhYy99kSys23Fa+HpwHtRLCJrEAYuvCbYTLJqgeDxkmkfH+PH/Dq7VU0yRhBliweF7U2246PEI1wVi5E56pUH5DzJ1Wsl0Q4Kv0EA9azgu0f4v2ugn3e0ZomF4jM3k8TObXB0YB4Ae35xNPEJ4RMoQ8uHGydU1nec8Ml+AJPfvf5AXdlSSnJedEC88+7R7+6KgctC7Z233tPKdHGwt6yytffOIm2sBBg2wY3go4dS6R4gQAfyezRJqy/yBTOs8xm+xLmhajrKLMvH8Saznhfe3Y8vg114fAWI9dlyYZg4hcnucT8W4CA1swtzDf2drHRs3/fq5bxLpeU1Rc424AcBwCRmIpEtx4Cr08sIUQKcFUPFV7Q4tJxiOnOIUQM4uBkGwPrWM7q6Cdix1C2pkOKvBrsDgtGe1+/QtFMK4ttZd+Jded6tmBcjUb8VwyfDE7HmYak353dx1yHKZnBQuDR4XcGPjZrO6S0IfaHoTMCfdyQJJJXYKIyr5shsStPQYKnHMq8ySqf163AyCaSWAEKr8bc/Hayl+rxX0En5/uaJHxE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f189a4f-580f-4abf-98ba-08dc85640cf8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 13:33:14.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CS2r8LEcz2n6mzx7jJn4nwmhNO4VoHE8t+vvs/0DmiyTvyLv9RHlD+1z1IrfrQ2sUG0TdxUEO5Y16tU6XS2aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050103
X-Proofpoint-ORIG-GUID: _xDbVosOgI0n7LHRiGBhfu3iVysb22s_
X-Proofpoint-GUID: _xDbVosOgI0n7LHRiGBhfu3iVysb22s_

* Matthew Wilcox <willy@infradead.org> [240604 20:57]:
> On Tue, Jun 04, 2024 at 05:24:46PM -0700, Andrii Nakryiko wrote:
> > +/*
> > + * find_and_lock_vma_rcu() - Find and lock the VMA for a given address, or the
> > + * next VMA. Search is done under RCU protection, without taking or assuming
> > + * mmap_lock. Returned VMA is guaranteed to be stable and not isolated.
> 
> You know this is supposed to be the _short_ description, right?
> Three lines is way too long.  The full description goes between the
> arguments and the Return: line.
> 
> > + * @mm: The mm_struct to check
> > + * @addr: The address
> > + *
> > + * Returns: The VMA associated with addr, or the next VMA.
> > + * May return %NULL in the case of no VMA at addr or above.
> > + * If the VMA is being modified and can't be locked, -EBUSY is returned.
> > + */
> > +struct vm_area_struct *find_and_lock_vma_rcu(struct mm_struct *mm,
> > +					     unsigned long address)
> > +{
> > +	MA_STATE(mas, &mm->mm_mt, address, address);
> > +	struct vm_area_struct *vma;
> > +	int err;
> > +
> > +	rcu_read_lock();
> > +retry:
> > +	vma = mas_find(&mas, ULONG_MAX);
> > +	if (!vma) {
> > +		err = 0; /* no VMA, return NULL */
> > +		goto inval;
> > +	}
> > +
> > +	if (!vma_start_read(vma)) {
> > +		err = -EBUSY;
> > +		goto inval;
> > +	}
> > +
> > +	/*
> > +	 * Check since vm_start/vm_end might change before we lock the VMA.
> > +	 * Note, unlike lock_vma_under_rcu() we are searching for VMA covering
> > +	 * address or the next one, so we only make sure VMA wasn't updated to
> > +	 * end before the address.
> > +	 */
> > +	if (unlikely(vma->vm_end <= address)) {
> > +		err = -EBUSY;
> > +		goto inval_end_read;
> > +	}
> > +
> > +	/* Check if the VMA got isolated after we found it */
> > +	if (vma->detached) {
> > +		vma_end_read(vma);
> > +		count_vm_vma_lock_event(VMA_LOCK_MISS);
> > +		/* The area was replaced with another one */
> 
> Surely you need to mas_reset() before you goto retry?

Probably more than that.  We've found and may have adjusted the
index/last; we should reconfigure the maple state.  You should probably
use mas_set(), which will reset the maple state and set the index and
long to address.


> 
> > +		goto retry;
> > +	}
> 

