Return-Path: <linux-fsdevel+bounces-36516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F07059E4DE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 08:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0C0167F83
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 07:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC919D8B2;
	Thu,  5 Dec 2024 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VdtkHod2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LTNIyfJQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DBA2F56;
	Thu,  5 Dec 2024 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382230; cv=fail; b=TvjSizrZMZz/mLTphCttFQps2qHP9uNOp/jA1iWC2WRgvewKXfjsQvO4HDYJUJneaYmZDOfT4mt/YlzzyW84mpSkGCRPNPyiCce4To3uHZPd9P9eECYTGxJFRtzJY2rjN1KHH0q9reeY9GfFzoaac5edNgyTbmH5WsUG8RB+kUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382230; c=relaxed/simple;
	bh=UA1aV066NZczHGVbruuZWKgQUKBXaxkI8eaHVzi1qGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NDHkN9ld7MJKQZ3dSMRuYAv4fTfBEh8Gch1eda6kxUiughTQn982iMtPFaOLrezhh4INsHnlb7zieEFAMATJuPTZzcisdLV9B3s4rhXAgfyi4JI7QPoT5S2P8Z16w6x61VXnYMLVfOAQMwrdC4Cf50FlP5i5uoGJnGdrIoQmNQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VdtkHod2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LTNIyfJQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B52MvL2014836;
	Thu, 5 Dec 2024 07:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=R0umvqYsoAD+B+hCI2
	XAYdt7tufU4CME1eho2Ke4PHg=; b=VdtkHod2VbU+l1qKbYE0TEyXB4jdASjWHM
	hY7597m6JuciXbwa/FmRxAvzi0onsmrm6xwUNxfvwS2TrvS8t4YPAb9Y4UjzJS6O
	xGrjZIDY/4YYzkxzBGntVv+jYBX7+IW1GZgzBQwjn/5un5sC85602VvfIjpyNH1V
	Z3AwccFbgsC9dtLT4RQPx1pbc6jnZFzEw/p6VqpjPWZOTW/1m03wfpfRXbd5RByu
	PTQSH9iWil0f7jnfyv4RCDFQuBimCSrkdtsnMresZgvfncYZAHJOGXO5Tz+x3mvQ
	fwXerxgh+uPELIkUlUxRO5/pOGnwnl5Vpl27DTjbmy15+SR0bC/Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tk9241k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 07:03:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B55GvT8036974;
	Thu, 5 Dec 2024 07:03:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5b08jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 07:03:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+pO2XI7y9Rv+bm/P7H5JQFdYyGbuYWx2jpiQyiU4K6BmTIRw7/Ikqa9Hrq2a0BNbouI+T2kDYgWJAC8LYR3PRHhLpvbO1BvfWS0RWis+p28rd9G0kfwxYr4ro6tDwu4U9nk3v2XMzPmTcMMYfyud+lTgClZvYn6jyJV2qWYDb2Lw5k9gv/M5natqohbXfNyRA9e/abmivjNxcw344WTmpiidS/oS4stdz8ciy9rFLbzC1TW1sUNLF6xzkZjm2T4SsCNoXjwN/v1KXug7eKnEw1Nazsx5zBKvGtKZW0+GVrBbuYQALeePfGBpfQnqi0Qe9sf9dN40sGaTwIWvtHYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0umvqYsoAD+B+hCI2XAYdt7tufU4CME1eho2Ke4PHg=;
 b=Mg2w9lK0WIVnUyAqNgEEEC5D+sB4ID6m6rIpWMXoJCzMfN85X2MscctudlgIDJmpXRU3ob/nsyELpm5nYg/DA2PnMJ/ASDbyPnUb4D3wNUzN6vkGUc8BTqOLUOxwjPXu5lnpLtuOQt70fMvnxQLUYqkb3LZjllT1neA1/GUlR6iRnkjZnbDEcloaaH0XM6TyPzsDjioXzaRl7zVRvKbt+7UYEaIdvkuQ82fn1h/J8y1MX5DluB7yqzpwgnJItpDG0UoHSWIL5eKZt1cvOInNqtH2XPVHf1o+ps9rhsl+UKudOAGVVDNsG6xVTWFO8LwYsOoPWYeioj8FliCWYFfVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0umvqYsoAD+B+hCI2XAYdt7tufU4CME1eho2Ke4PHg=;
 b=LTNIyfJQvgWIN43E4YVlc7NTrnZazKiGJ/5+980DVd6r9pHs/OuYJnAQ5hwl7z4zIBXtHSg2/EqcSThqDv6yIm5Xu/8D40O3NCKI96yq3rQoDRvwODDk268lO2UHgo2hi3fuc0lJ3EjHQ2NuoIx+YHXLcofFJ6ZWvd/tIB/pmb0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB6285.namprd10.prod.outlook.com (2603:10b6:806:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Thu, 5 Dec
 2024 07:03:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 07:03:11 +0000
Date: Thu, 5 Dec 2024 07:03:08 +0000
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
Subject: Re: [PATCH 0/5] mm/vma: make more mmap logic userland testable
Message-ID: <68dd91e4-b9c3-413c-b284-f43636e7ffba@lucifer.local>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
 <20241204235632.e44hokoy7izmrdtx@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204235632.e44hokoy7izmrdtx@master>
X-ClientProxiedBy: LO4P123CA0391.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 13dd1be1-563c-4bad-9dd7-08dd14fae13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ig0mvYrXhJz6bKTDWsf/3qQV1AZpdmNxJNZYpbqzsuymG3P4Wn++V3N9oZR5?=
 =?us-ascii?Q?0VfccTEd05DJlnBz0t3hUPQgReZgwKEwZw9ch02q8kPJn8xGK4f7jtWka62O?=
 =?us-ascii?Q?WWCKwY5/NO/ZMVXSDuzIlNrj+YfWk9ZB7pcx+GcB3XIqT8snu3hV5LIiCPfQ?=
 =?us-ascii?Q?2cFGm/DRRO/ByI27bkZsifcCew9jFxx+E6xW9fkzwCMoJL54ADtF2ZcH2RyG?=
 =?us-ascii?Q?ZlIHdEhBaSGuzXEnkvFildJMzmYBz6w2c2DeQ885j+NRiSpP3/+/hBRJ2NcW?=
 =?us-ascii?Q?hRhfVe4URLJtD2Medo/G/XwCvvWfioTUkhJPD7UyTW0zc4381KMt0qqbV3I3?=
 =?us-ascii?Q?3Pn2ogJmg8YbNlnDrR0LU/CG3lFTmk1KjCkUDhfutN7/2iB8UuBcB7QCk3Qg?=
 =?us-ascii?Q?Fo95SOfRE5gb+Stvm0DwfPhhYZLFJYNmmomxNkkFZcM65UOl4NmfTzM3nCDo?=
 =?us-ascii?Q?doFB+97OHHMWadPSZR+g372W4Bvu2CtRU/ktCU/0d1fsm/h5HDlnhqsDxQT1?=
 =?us-ascii?Q?MtaqJ3m+x/YrBF4+bziR5B6+5jMmO9UC3WMCZKF4fwa7aCQRiGHXioDw4Jz4?=
 =?us-ascii?Q?LQkVcTO50E7omNKF/k66y4JSnEgwaPKal5VA+yo6xYP9C6Sq966JsZ7pWkIE?=
 =?us-ascii?Q?lQdD6tKH8Z4BsCWsATs31TGrCqF4po8H8OuM9GENjxfBai24Xz4L41QOhC1D?=
 =?us-ascii?Q?YdZ8/1YNjLgfDqF22Rz54mBV4GhBO6qXrkT5rbPzi3x2S9wqCB0vO+nFPpzC?=
 =?us-ascii?Q?XWvdKRZMe73Qd8SEWIteNgb9rcoaJyggA0MUuitOBaCsEovTall3zvAelplf?=
 =?us-ascii?Q?rce5ZqnGJQL1rK2Rm2cbA2Iq+PxSkv9o2c7OtDzivIj3tArU8rHPcsnRHu8y?=
 =?us-ascii?Q?VQ4FHFDKZxpy41ScpNiFSQe7+vfdrOCK+E23Zbki5QLLWddWDWtw5Py+X+sD?=
 =?us-ascii?Q?1Yj1/KBOxskO/LGSpejgk9upG6Je2/QbDUrkaaXO82+/rzWNaC8pSn9WWZvM?=
 =?us-ascii?Q?1IGzWgZQlzK+J09DHLD1XTEnJZ5uBs/BIOp3qCi1x7+vfTJvngUOe02XmcDt?=
 =?us-ascii?Q?aJuXi3HDUFJ4jh2OphZt4ixLbpbmNZPWWLGD1JlkQ1+8vQSlVVssLgiKPB2O?=
 =?us-ascii?Q?KUcZbLNdHHo96sz75g64lUzthKf9soL5FrVoY17IkQXbCmcgwZGmGyC+ssaz?=
 =?us-ascii?Q?H3xaNL7/PAbBxzFQ2D5XRV+ItnfGgUSKiC/s+3VK16xa9JebQrkk95zNB8Is?=
 =?us-ascii?Q?Ui5z4bYv5w5uMyntjxp6mgoXcBTGojOk8uDwee0OULMuXLPzSFCvb2PQiOi/?=
 =?us-ascii?Q?6MbP6fgZjd7wdFhgsdAcb92yIkKiT/fUgZp83BPGhiRWXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iWF24jtYhY48RPelmE91HST1/K2/waUN0yLLe+XBKaSuPWqUhv4um+sba/jO?=
 =?us-ascii?Q?ugR74CJnN4Su0oxvTFxEp5GoPJ2XMulgebeKLn9i7efYwCl4JjMqk+pdrsoL?=
 =?us-ascii?Q?HQlOF9Jyo7F5BMo7ZLKnS+BSUy/MCECzAWnSV1o1RJYf5K8MznecOB5PknaR?=
 =?us-ascii?Q?3PPiUJ5IO5ptf1g4IFKT+Mc3nuyuuShfqS5ftYTIJ7gWgLOrB01jrdksBy2/?=
 =?us-ascii?Q?U7KNkUojoSKWYYhCyPzVFsDnym8BUuCXWhJv80DGFViPxnDsAgXGHqwMdFEK?=
 =?us-ascii?Q?q6i3cYOSspWsz6/Uo2/OY3oFUdHN+v/lZ4D/vzMINHtBj2VCkJ90W2S2nN3R?=
 =?us-ascii?Q?GHHEcrLMjvY3ND/ni5nlDaLTxzqlEvbasNoPz6m3mgo7p4ja+wq0X3hn8XQI?=
 =?us-ascii?Q?Ytk3spyCNVVZ8T7OcvHQwAfHHFblu2GkAVM16o60EbouyDRzyYrHFZXPOsMN?=
 =?us-ascii?Q?/WWB9Jc3ltiQUJMAh7o/3CgPY/q0x4/qcLHpfoFh24o1VP1KjdgJ70TsExWa?=
 =?us-ascii?Q?t0+UNqzRXkodDLEkhhBTtNs8313uZT4AGVlGOtdeGHzFGFRnC2XJ0InlV6Z7?=
 =?us-ascii?Q?jx2zOyeCiexWdMjYn+rDvzwuvKKtwateH0cY6G9zSLoqDu55R7YDQEXRbPao?=
 =?us-ascii?Q?wcFhtWW4vJWV+tIzZVoqM2QbfsFVnC6d8t16k2JzzPMAM1lXx75XYfduBtFA?=
 =?us-ascii?Q?CZgHgLDNkNuatKOqugaUlyDRCUo5rzjLoOvJ+2JfE5w8nmza/uKcOTq+YZfg?=
 =?us-ascii?Q?Zy9gDyJZBfu67ruDXZNiNu50rbSs4RuPpGd4FQneFtfohXuo9WWBJG9IBQJ8?=
 =?us-ascii?Q?ToOPYGDW2TrjlGfbCJ6Kpposd+0N7NdolYxRE3E+wtScbk4g545Dn91qI72/?=
 =?us-ascii?Q?YzYOvZ0cItKHFIutmUNNzt5v+2CKD9DraNQx0FrIt1gD/QSvqy65wKS1zrsz?=
 =?us-ascii?Q?fvBUnyqtH8zwxl0Xex8s7pTod+TMHt+GNwx+ZAL03Fh7xYF1HQ6eGeEV2/S3?=
 =?us-ascii?Q?2Xuj2dHEgb14G114pft4KX/YDxAfS1YBhupwkrDdvPCNGath2igWqxaltrpY?=
 =?us-ascii?Q?n8aPJIvqJSigch0THAM2LOBn+tQEeuh8dqMgB6cQeNDD96u8cdVrKdSlVBej?=
 =?us-ascii?Q?wrqlgHE5ogsxnY0O9VESnTxXQd40Efyond2ioJ9V1T/EnEjxx46z5l0tY4ub?=
 =?us-ascii?Q?BVyDtOJOow5Q8uQLOGx7bUWYiCzc6RcwVAX/yELgMK3pc8jKBI+EW34S+VLm?=
 =?us-ascii?Q?dnLfkU8rUSKKDhFOVUJRJLRm90tR8fr480VAzCNw/oIjQAwVLEqRjPGMZ+G+?=
 =?us-ascii?Q?xzHziFqVQjYkSveeCsn4RpN+uC417eHXMybzTZ5e+bRbuVqHrPpvQFoEmCMb?=
 =?us-ascii?Q?FeuGA8Rc4N+GMftqLeT9rsw2L8g5llC4lclnMPg4yHJwK88HvENKofMs/1Lu?=
 =?us-ascii?Q?i/SfgXUl8PnnL52NaoWiCdtihHVi1F05BHs8uxYEO4Yp/670Fznl2AAsNtOL?=
 =?us-ascii?Q?MNuCluyS5I6Piq16pTS9JexbV2Al/lrYh8ZPe54BGHASgOlgtaPXOh/aARJU?=
 =?us-ascii?Q?UWw1GxP4w/NjAGgcj0axMVPsUMhabSMGKddQr5CWjj03o2oTXXdfRy7T8YtH?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dpLESF53yZDhN/vVWsEB+Yj4D7PAXsZ1xpkh8R3rQHMYHjg/BRKke4lworMLoqWEoAD+NAVN3JuqSMZLTE8E7IGQ7ODwzciE8UKYxhcMcmGhwKgVgj4dQA5DNoV0y7jwZDe0s9LPk0yNt8Sb17PWWWdKcZ26ytbxQO7VP13VmURESqaBDPlodK6YlpN2UlYQ6OFw6cC+h14ZisYPJK8mY5AHVb+iVbknVd3fa2D8eEH9wFwAb0GnEPP35JRTLdrM36X/zbPp4+veW94YCknFwvIPEfTH4wqP/u9WU2gHft0BG0VA5+aZQNa6GYCgBxez8A/TPxH2hvG8TNMvh2KkdJBXJ/JqZtgbJAmi15xpY6iX9eauPHNO/kiWqHUZbHi6+B7SAzgkQGQZ1v5P24FysqHVv/WnfuMwzDV8aNTXOTreSqEhFfJ4OJ6b7XWLTgreZoF4gmEjb68WPBzKOzKdTNx6woajvKJsm+cy+E+2v6tk3bNXR22THrlNMN5Tc9cFsZntRNmbLFJNy6eyAhvq3s790UUb5Q0FI3yrK467qfJ9wkL1FXwt/JiNWA4G839ysA3uz54bovZQiWebmcuq/DpEX+TXaI4ITO4TnxV0gpk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dd1be1-563c-4bad-9dd7-08dd14fae13a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 07:03:11.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lS8daUWyRAw92fHxnK857JgOFqjbxO84cpF0M0SPCr4L1D2w6Gx9N3XPjwKCihNrGVq0+OS6B4HMLzMRf95KxvSuhMaEn1hXbBbLEg3VDqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_04,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412050053
X-Proofpoint-ORIG-GUID: E7-Ja3VdJwwc97vurwVG4CJ38y4Ccgc6
X-Proofpoint-GUID: E7-Ja3VdJwwc97vurwVG4CJ38y4Ccgc6

On Wed, Dec 04, 2024 at 11:56:32PM +0000, Wei Yang wrote:
> On Tue, Dec 03, 2024 at 06:05:07PM +0000, Lorenzo Stoakes wrote:
> >This series carries on the work the work started in previous series and
>                         ^^^      ^^^
>
> Duplicated?

Thanks yes, but trivial enough that I'm not sure it's worth a
correction. Will fix if need to respin.

>
> >continued in commit 52956b0d7fb9 ("mm: isolate mmap internal logic to
> >mm/vma.c"), moving the remainder of memory mapping implementation details
> >logic into mm/vma.c allowing the bulk of the mapping logic to be unit
> >tested.
> >
> >It is highly useful to do so, as this means we can both fundamentally test
> >this core logic, and introduce regression tests to ensure any issues
> >previously resolved do not recur.
> >
> >Vitally, this includes the do_brk_flags() function, meaning we have both
> >core means of userland mapping memory now testable.
> >
> >Performance testing was performed after this change given the brk() system
> >call's sensitivity to change, and no performance regression was observed.
>
> May I ask what performance test is done?

mmtests brk1, brk2 (will-it-scale)

You'd not really expect an impact based on relocation of this code, but
with brk it's always worth checking...

>
>
> --
> Wei Yang
> Help you, Help me

