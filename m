Return-Path: <linux-fsdevel+bounces-66341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF62EC1C4BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 868B74F74C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2454343D70;
	Wed, 29 Oct 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pLcdZYhE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="evoVoA8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3582D8771;
	Wed, 29 Oct 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756689; cv=fail; b=dGcfJvCjn12lRfEh3JNJ918yU7KN4I0hVrm+aC2tzoUsBtROFIwR3mbw8nL8TlDW1GrJIXRb6gKSwRPeTtLXGOdiSxkdtYtkArrpeZjRWsEP6yYSiojzJmf6Q6vDfLAyi6Y/Xi3Ii3W1Y8YjOMCoGbJzoIKF1dKKWogqV150qyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756689; c=relaxed/simple;
	bh=9aEjaiZ73BYMvSnlJisjcG3Q9Uj/b486zZpOLrAt2m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=elg+Y2R/CRpeOhf6htn110aCSDZtZUiFR9TzFinmEEyHNQsduxGCb3fzWIU65CpSTbqaVlo6dHE79vPKaIyszi+u3/mIe3efOwjb+/khF3TdSia6jplf6f6HIk8SpsouXp9zBy/esFDqyVJKJ6BEtFjQXX/NWxIHUEoUuzfSCxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pLcdZYhE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=evoVoA8G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGfsNE024883;
	Wed, 29 Oct 2025 16:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Rqd/6+oOTSKB2MjO0pWo1E6EgkjgwBUGU8fXiIeXa0U=; b=
	pLcdZYhEQxmEATyaH9xRL9oOcWY5t5mV9O50lagAey8zSqKySNYItKMX3unvF656
	KTANi57v/ZnOSYRxRHDHB22giUtm3R2D+L2D14cDdZ6Zd9rxDea0tO867fmXa08o
	zRaCbD7VS7Mu4ytAG5Jk+2KqcXEEjPFgOn+9IfUg7gOzfYU8z8cn70urAN5l9p20
	ahqeUZlDZZAYJNizDJj7HifwmhN0xPmjDS2B5mMdgY78E0c8qlks7c8PLZRTlD3f
	oBNVWwYBHq6i/eUYzKYmGXf0b4SKHKbzDt8KvWD3yI1912b8KnrU5vfCGBsmzux6
	eiIBIF9VBIxDjiN2IPjcgg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vvjeb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 16:51:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TFWEZG022996;
	Wed, 29 Oct 2025 16:51:07 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33xyfvr6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 16:51:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6MnIG8jLSLp134iUx0DnWfKzWKPerFgKT0t4zGhqzg/4xyg8GLBX47te2GgK39aJkLTu0gV53aI2ECchjgaaTv3D1qb8Rh8twskvi5AuonH7qy4flHJx7oJARVYTxV20X3u9nQXI4aOoZTE6rQT/B0obbGghlJNtmHZKIJ6p2hEqEXg5KegG0CTuuJFJ4nSDitatIpVmKCgRZ48s8Tg8TLIB/9xgZs+BiLfPfizBg9zxVcKXQJTupokhZ51hlhigfwthwcU5f1vO4rb3Kx0tE6ZAjLUdjXLoXfCmakWHFShNYyOs/RqbboNF1xA2Yob+bUBjj70vicIige4iMbgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rqd/6+oOTSKB2MjO0pWo1E6EgkjgwBUGU8fXiIeXa0U=;
 b=qxiRj00JLqfsKx5Iomlr++trQO8fxyfcxlMNVRnCk7FtVHnfRVFaXGGtVkbjxC+nEYPvRHaKyOevZyqnjNy+FZ9u3KR5QPTc12jptyeJTDaguM84EbVWeRlZmvT9w50mTQI3cI1RqAJZ/NiuZMJpVM2xbk7n/Up2uXtfgHBx6PJgGIO2LF5cs5+Spk2ql2qFjUW1dlvuKvhBz1vaZzpojKt0SdrV/8ZX7ujTCm57EGQympHwnSDqns2t9mw4X9jQePbyf25+HDW+4DSXscPiSqnqRjX2CnYVog/P/0crM3CxkUdN8VQmLkLR+OOb/wcIgnD9jwPQJMOGZL21blFSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rqd/6+oOTSKB2MjO0pWo1E6EgkjgwBUGU8fXiIeXa0U=;
 b=evoVoA8Gtas84Mq5mmCBw1jNljsVpMLJTxdhxDsHxd05fc5so2mDJm0Wthy6U3uta7nQO6H5efWicJa/FRxIVEXMqr+RYWVTnvCnT37x3mCr/GSSYxrqs2VmZOujjLPHvsvlAmmiyeGbtBdyMry6yfz8FUiDeERkhb6MxOfXDdg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4251.namprd10.prod.outlook.com (2603:10b6:5:21d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 16:51:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 16:51:03 +0000
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
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for guard regions
Date: Wed, 29 Oct 2025 16:50:31 +0000
Message-ID: <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0194.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 364ad750-746a-47b1-049d-08de170b5888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J7MiFcRtg+rWmq5E7CbwWdzKSwn/zSE0ymlmgyyKeJxcB/dFvxZkQ/S+sAAA?=
 =?us-ascii?Q?4QtrS8oQVyCGXPNOwUoDCTzooUGukQ3Z8siBW/gXaZ4yowgCygudP1tRl/W0?=
 =?us-ascii?Q?+s/zMvnrl6i15NVblzp7HDd3lcO8CP5S7gBGU48TO47xeVZo26KtUQl6Al1u?=
 =?us-ascii?Q?Chlc/9lQCawCighnbGeXtBMSZ36VR8idrNp0VRLaWFup/G60TRhRVrL4tj1f?=
 =?us-ascii?Q?bZXtAWoPtLVz0sUh4wTdXbDMxzrOMYuc1u9j//rHw7Jq+CXdSLkSPNATXOrN?=
 =?us-ascii?Q?aiNP40l/WgG/sHaIk+kogQGv/vT8cf3rP/dhFDaJBtsXO1VSMoBONbfeyUhv?=
 =?us-ascii?Q?XflSA3U6dDT5NwkcE7d4iqXIJmgclnuAU0zMaZQD75SMmDk0Wx0LChHYjqCd?=
 =?us-ascii?Q?MQBkyMLonRdXHNyj8+/KPiqfe370GgW8wlBFXUwq4yrQugMkMsKTvuESmpy8?=
 =?us-ascii?Q?JtbpFO2TJCwBhrsqYjk/H6+qr+05QtSH4Vm/RBfpDc0dPsAzE1JDEU6oTwET?=
 =?us-ascii?Q?uQDLwqergKqr3Md30yv0jUd/8nhcA2xucBtJTExdYSqHJChoNZsTQ/yKmscY?=
 =?us-ascii?Q?MfGBa6N6FE6Bp7MyZmd9OjFNnyuoGBXCl41j9shrBLen+tJa1agKkl65CP/X?=
 =?us-ascii?Q?rtxwlhAd5ksxdffJMoMIeEwX2P1AwvwOLELzWkuUt5dzOyu7lQj0bwiAwOt0?=
 =?us-ascii?Q?iEAz7SW5uFZh+H+9q1CTxWvzpHk9JjMDXxP1Z8i+qJQKM9WvhAWf0xo2twOI?=
 =?us-ascii?Q?dyhOMeJRB6QUciiGBUhrDF92JpIxxoNS8l7+QFbwjLsip/InaoAvUXwUFrdX?=
 =?us-ascii?Q?w2yvWYpCpHCghGpYf5AB0aT+zyGJeZSmgFTdsN4wSHfd3C0LXboa1yjYdqdb?=
 =?us-ascii?Q?W24d0Q2MvlKsf4WAApGS35OxkLfUlNu/u0m9jY3RKTiSHhZG9PIBg/O6s7Cc?=
 =?us-ascii?Q?UhYm9NJhVqHewanEm7A4OI1Q4fr48Zixo5jPA/zgqB110yJNyrfNI5no4Gv8?=
 =?us-ascii?Q?z3IETYWZCiOtW2ypfqk9nfikjeVJte6X1Jjp2buPQoXeRBcCu2RN2VrDymrF?=
 =?us-ascii?Q?KZtVa9kAZVmFFfpz5gYD4I/dx1Qs/N8cUTSFvjGQ54rctbmYdnQ++N6r18je?=
 =?us-ascii?Q?P4zsnJCCipSQQ38uD8PGnwQssHSfwlPswub+fldsQcFcJ5jV7kcEFvjADkCQ?=
 =?us-ascii?Q?lOPZ4mFUhbZGO2dP33Dkg1q5jaysXglaDe2E66GRRx7PYI5K6GMsNM5VMLgf?=
 =?us-ascii?Q?RJm8vFSdFVRexGNi07EQr3LL7cU9A/4ziFNkXW51R4bhA38IYhLL/qs/rxCH?=
 =?us-ascii?Q?hccmNgRTqsDi5Z+IZUB5+2J9M5r25lJrnCU6CWe2elK9CJSX7Zexm+E2gCPv?=
 =?us-ascii?Q?bmRiUmCEFoLY6z/YN7sf4uWOQgDg2JBQVJUi7y6pbPAvwYiCp4Ly1BiuhEEl?=
 =?us-ascii?Q?TSDcjdEhMbODkP6oGxb3uYcHn1J5iMdG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Ld1pBovjVxvQDxstvOEWF4BQQAEDG1TyHwwGK/NwwBgmOL1zxZOHimCeYAj?=
 =?us-ascii?Q?/onSgy9htqAuxZOSrMdRUQGFIgReWhOuYgdzVtCyTIoMdLqAmIFPhCuWEKND?=
 =?us-ascii?Q?u2dP3w8Z/hV/hvEEZmcIz2SVzqG3lPvTnkifJVH/wvHs2PMpTdkifeB36t8E?=
 =?us-ascii?Q?sWpK3udu7QHCDI6t5tW9lWNacf8xrXA1rHVfVU6TE3HlJBXr3BPX+4B+RXWn?=
 =?us-ascii?Q?/txuSYzoQnGoEtsVfK5uvbM1jkFWmBKyAJXeymUkNgSWTiVspujtLKjYik7/?=
 =?us-ascii?Q?n3to/4Peu906SUUfmJchG/kt7N6JtW3MeFg16EGbpCqNKjYygPHrcle7T0K2?=
 =?us-ascii?Q?uzXFSAK9Wwy/mB7fJBkG6vJ4PElmUSkfKF6Cmj+nwljQSjV7XAQjRZP/BxiY?=
 =?us-ascii?Q?BjatLkknxHxHnGKrvlaavEr3++8vyoN5PtS/5Cp1gAesxA/SJZ0XTJT4ZAoq?=
 =?us-ascii?Q?3eLPwdoUWb8DblCrJESyXD2+KRohO/lbt2mL+fmFCaNsXHAPGRrPvdvD3Od+?=
 =?us-ascii?Q?qfFvBOVB0k1sDk6D/ZlmVO87twS6gdCY94YN1AuTh55VMWTDjbABFalUGXVx?=
 =?us-ascii?Q?L02hNUhalhKhVfMAjay75BUcJkYmzGPX6p9GWgD/CsA6NGw5/LtxhFkmT4Az?=
 =?us-ascii?Q?Regd7PuPmy95SN/J2bjhxklUiw3zmV3w+11RI3222AO3JaWeEW0BeR84NCZZ?=
 =?us-ascii?Q?+OojxLK6+VoO1drYumJpl+NGSSP5/0N47hJxdXsfsdQMeWcoNQ/1ZJEpk5lf?=
 =?us-ascii?Q?skkjz1f3NREpTbmln2JnqxGK7QFusDkQqE7JAvtcdKXRFRbo90sk4CvZTgdd?=
 =?us-ascii?Q?U7oIt1hpElJjnKSCcMTj7HiQLBgnvdq2VIs950yyaKMfqZgqwC1nrgO1VxVx?=
 =?us-ascii?Q?oSnava9SWnGzdy4BG5hyi4Wzjyq9xDixmiJ16uwkhQ4qoYVIlnWJjFWPQP0D?=
 =?us-ascii?Q?veg1nKPf/q5LQsXuC4/tKN94744DCe7aP6R+UeFnBl8P0jeXVhfgxSNofT9l?=
 =?us-ascii?Q?HWGVy2GgHzHy1YSfpFDN/IMEhfxmy77FcBOl7oAYUnlb8BXUiSVf3mg0MQkE?=
 =?us-ascii?Q?DFYfZZNSnLaboeaeKCdL6yGLMGbD6sf4bprRem9Js4g1kg4wa3+tyXkZNE9G?=
 =?us-ascii?Q?vCUQzAFAGVJo1amOd77t0O3HJYQHsH/NabdTeteVTLqbmInWlGu1l879oqvG?=
 =?us-ascii?Q?WZaPgCqOeJoqhGkBAAeyzmZb2vP6K9GUQMd5x9BriueWj4nJTktpe6cWukDq?=
 =?us-ascii?Q?QO/Tm86Wav238sdSRkoPbW5vZ+jNxI1otke9TM5PfKuF6IQ/fptjfsEyt0DD?=
 =?us-ascii?Q?CHAFzrIstGgKEEtv3itXris26K+vn50wA+NG+lChkzsEkHOQnh3kvUVzqSBz?=
 =?us-ascii?Q?DeCxy0AQ5PGqDCDhpIAXOFYmWFrDNvLb9YFramK3GWQk8rh5ebrwbOY1q2S6?=
 =?us-ascii?Q?Hjd1VDpfM+0wcISVFdfujp1RfdWKh/eoeSq0sHhScOMdGwbYIndFNf0uHbSl?=
 =?us-ascii?Q?jnUxmJRrmGKtSuGgo/CCwXUvIJpQdWJ6nq0ChxleIMSCoARPgChPoEPlHFpc?=
 =?us-ascii?Q?47SGzxM3jeoWePBHiAGMw2+iyx5A5k6GIfP+SUep4f3U4CrPnJE56mwfzl4J?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dkL6xY5jCFy78Ob6uPHh/3+zRbhfLiRWpFgjaV/wEFesViytFARL90TOfHRL/x/bzTfK64FtPZrUxRfNUleFXIQ+FyPdAwZdyKTllrcbKJfamrWRhzCpDuwPx4p7Km2wwSysGQ9/L7ANoFYZegak0Cpr7QcYlQh+u4AeEOpD0U2KJsi3g9ccUdyVWxH1YZfh0o3tjeHX7wSGDGPjL/C6jsb9zdvXlyej5x3v8C4qJx1iSriNUJiy+tEmmj2XpLLgWMhmtUCaSBDNU5af2yEWXyUpyUKTfEum0NaeFvWXTOpQqfBQEP+82gZvjqnOoPYmG2eO3jsnWLa4e3Gjf2pbfwhLXEnZqv3AVtx7AbjQBdPYo5rTEQH4H8VS1uP+oY3AhsEet08uIdgzKo+Eeqbj8NVaxxflQ5G8Bprxd1SwE+8A1qqWwusREfJHnp6u3k/LANvkuOxW2tRg42hc75ks1V5/dI7ruJPdk7CqOxcuBC3aEuYcR0BzknyMNTlKC2OO14VTteGWIfXTGfag3m8PR5ByG8ddTB8uErslGV1cExa7HLS+rE4gd6yxKTVLS2rh34IaN7l2fovtW7t/XiNCd+NHMbDpxX/g/XGuc65wdd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364ad750-746a-47b1-049d-08de170b5888
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:51:03.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0in73PpQjA9rNib19qRPBHub6Nl7XWa1LCC4gSUFRGS5nuLmefrYtWkdZloRq0veBNt2y2Zh1nlN2nG1A5AmvorDVZeqYvm+S+6G5w7uUVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfX22EmFtDHGbNY
 ZTnqRDjiWz4OSnOGk+CcyYx+eKDmEfCDPCz/8gIzS0J6C3StcJgk4kulRRm+7vBtVMgEm0M3Uey
 2rV8yp0yOaKhFqxqm6zreFQ3xDgtXIKfzQClr+qFLPtqnbiI5NnDQovXwMUEvT9JkEelUgWqzHD
 aa/jYvT0L7TssoPEN7yrT5hCGu1i4+q8ktTxFVnKkWiL1vcz5wGdikdZBPpX+X4LvBIRdcsp+zD
 g+7+MHmRIdVE+gGlfDr70bCsmMhS2Ugero67ZA4o6wa76v7XBiiuumTm4SWJ8fNLdOYptIX9GIW
 Pf0GYkkpj83OI3e4F3fGoUyen0qY+JUpi1FsdlF04L9LNoiOYIvwsJPCX0WngaQgPfVMJuqLOmM
 9oTiZ6SlbJZxXy6LDoLC5qnkRUo/Zg==
X-Proofpoint-ORIG-GUID: km98Lm0_K6d3osjdaQb6-h1G-3V2NcAI
X-Proofpoint-GUID: km98Lm0_K6d3osjdaQb6-h1G-3V2NcAI
X-Authority-Analysis: v=2.4 cv=SJ1PlevH c=1 sm=1 tr=0 ts=690245fc cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=FInFkupy4FDABNBDCMwA:9 a=cPQSjfK2_nFv0Q5t_7PE:22

Currently, if a user needs to determine if guard regions are present in a
range, they have to scan all VMAs (or have knowledge of which ones might
have guard regions).

Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
pagemap") and the related commit a516403787e0 ("fs/proc: extend the
PAGEMAP_SCAN ioctl to report guard regions"), users can use either
/proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
operation at a virtual address level.

This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
that guard regions exist in ranges.

This patch remedies the situation by establishing a new VMA flag,
VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
uncertain because we cannot reasonably determine whether a
MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
additionally VMAs may change across merge/split).

We utilise 0x800 for this flag which makes it available to 32-bit
architectures also, a flag that was previously used by VM_DENYWRITE, which
was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
bee reused yet.

The MADV_GUARD_INSTALL madvise() operation now must take an mmap write
lock (and also VMA write lock) whereas previously it did not, but this
seems a reasonable overhead.

We also update the smaps logic and documentation to identify these VMAs.

Another major use of this functionality is that we can use it to identify
that we ought to copy page tables on fork.

For anonymous mappings this is inherent, however since commit f807123d578d
 ("mm: allow guard regions in file-backed and read-only mappings") which
 allowed file-backed guard regions, we have unfortunately had to enforce
this behaviour by settings vma->anon_vma to force page table copying.

The existence of this flag removes the need for this, so we simply update
vma_needs_copy() to check for this flag instead.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 Documentation/filesystems/proc.rst |  1 +
 fs/proc/task_mmu.c                 |  1 +
 include/linux/mm.h                 |  1 +
 include/trace/events/mmflags.h     |  1 +
 mm/madvise.c                       | 22 ++++++++++++++--------
 mm/memory.c                        |  4 ++++
 tools/testing/vma/vma_internal.h   |  1 +
 7 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 0b86a8022fa1..b8a423ca590a 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -591,6 +591,7 @@ encoded manner. The codes are the following:
     sl    sealed
     lf    lock on fault pages
     dp    always lazily freeable mapping
+    gu    maybe contains guard regions (if not set, definitely doesn't)
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fc35a0543f01..db16ed91c269 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1146,6 +1146,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_MAYSHARE)]	= "ms",
 		[ilog2(VM_GROWSDOWN)]	= "gd",
 		[ilog2(VM_PFNMAP)]	= "pf",
+		[ilog2(VM_MAYBE_GUARD)]	= "gu",
 		[ilog2(VM_LOCKED)]	= "lo",
 		[ilog2(VM_IO)]		= "io",
 		[ilog2(VM_SEQ_READ)]	= "sr",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index aada935c4950..f963afa1b9de 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -296,6 +296,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_UFFD_MISSING	0
 #endif /* CONFIG_MMU */
 #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
+#define VM_MAYBE_GUARD	0x00000800	/* The VMA maybe contains guard regions. */
 #define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
 
 #define VM_LOCKED	0x00002000
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index aa441f593e9a..a6e5a44c9b42 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -213,6 +213,7 @@ IF_HAVE_PG_ARCH_3(arch_3)
 	{VM_UFFD_MISSING,		"uffd_missing"	},		\
 IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
 	{VM_PFNMAP,			"pfnmap"	},		\
+	{VM_MAYBE_GUARD,		"maybe_guard"	},		\
 	{VM_UFFD_WP,			"uffd_wp"	},		\
 	{VM_LOCKED,			"locked"	},		\
 	{VM_IO,				"io"		},		\
diff --git a/mm/madvise.c b/mm/madvise.c
index fb1c86e630b6..216ae6ed344e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1141,15 +1141,22 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
 		return -EINVAL;
 
 	/*
-	 * If we install guard markers, then the range is no longer
-	 * empty from a page table perspective and therefore it's
-	 * appropriate to have an anon_vma.
+	 * It would be confusing for anonymous mappings to have page table
+	 * entries but no anon_vma established, so ensure that it is.
+	 */
+	if (vma_is_anonymous(vma))
+		anon_vma_prepare(vma);
+
+	/*
+	 * Indicate that the VMA may contain guard regions, making it visible to
+	 * the user that a VMA may contain these, narrowing down the range which
+	 * must be scanned in order to detect them.
 	 *
-	 * This ensures that on fork, we copy page tables correctly.
+	 * This additionally causes page tables to be copied on fork regardless
+	 * of whether the VMA is anonymous or not, correctly preserving the
+	 * guard region page table entries.
 	 */
-	err = anon_vma_prepare(vma);
-	if (err)
-		return err;
+	vm_flags_set(vma, VM_MAYBE_GUARD);
 
 	/*
 	 * Optimistically try to install the guard marker pages first. If any
@@ -1709,7 +1716,6 @@ static enum madvise_lock_mode get_lock_mode(struct madvise_behavior *madv_behavi
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
 	case MADV_COLLAPSE:
-	case MADV_GUARD_INSTALL:
 	case MADV_GUARD_REMOVE:
 		return MADVISE_MMAP_READ_LOCK;
 	case MADV_DONTNEED:
diff --git a/mm/memory.c b/mm/memory.c
index 4c3a7e09a159..a2c79ee43d68 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1478,6 +1478,10 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	if (src_vma->anon_vma)
 		return true;
 
+	/* Guard regions have momdified page tables that require copying. */
+	if (src_vma->vm_flags & VM_MAYBE_GUARD)
+		return true;
+
 	/*
 	 * Don't copy ptes where a page fault will fill them correctly.  Fork
 	 * becomes much lighter when there are big shared or private readonly
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index d873667704e8..e40c93edc5a7 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -56,6 +56,7 @@ extern unsigned long dac_mmap_min_addr;
 #define VM_MAYEXEC	0x00000040
 #define VM_GROWSDOWN	0x00000100
 #define VM_PFNMAP	0x00000400
+#define VM_MAYBE_GUARD	0x00000800
 #define VM_LOCKED	0x00002000
 #define VM_IO           0x00004000
 #define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
-- 
2.51.0


