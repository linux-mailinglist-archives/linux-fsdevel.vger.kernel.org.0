Return-Path: <linux-fsdevel+bounces-55142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C7B073FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C33D1C2380E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456DB2F3634;
	Wed, 16 Jul 2025 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UcnHbg2v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ieGm1e91"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836372F2C69;
	Wed, 16 Jul 2025 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663069; cv=fail; b=kobytAe10jgd4HrMGNVKEwY0vaaOLE0KNxjpaNBbit7wMPrZma0Q+aMYeipxIFSzaPKtElkmuiW0nmdViEy0+JRgyJmNwgvh2zJ/W+h0Z/NXA0/EworTxSyjTnW16vHfOuF+I4wN5gnjg7JiN97O+nj7dCJfUzpYUTPrSL0e8JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663069; c=relaxed/simple;
	bh=RRuPL2iPKyBo3FRXRzDwtZ60xpUrvwqlGjUprYgfKZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FRR5LAtm0074ouNBxSqI4T6EMKDiCSHDoNGbremF3xHByqL5HQRR/XKsRMNmjlyKpVHN9HakD1e6JFgspnUtDcFFDwOexs1L1n9SdWDLZIP29fZn+IlSCOJSXNrenOa78IwCR0lraLbLEfn6V0QpluGOXg7qFz8tBT1k6Q4wYy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UcnHbg2v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ieGm1e91; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G7fnLi018581;
	Wed, 16 Jul 2025 10:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HO+EcofNoZAhAt9/Kv
	yu5lACKx2+saAv6DTzBplnmsk=; b=UcnHbg2vgiGJIXtu6qHInlqnYo0Qbq8TVS
	irzFHCOWEUNH7/y+ZocIuiWuVTfmfMm8sSezQ0nEIDdVaZxBByCTPkQpLIoD5tzD
	7QR8+F9YqDI/dA5NmHW++RiRQFwzXa15BDGa51NvYYHOVdrqjbxOKad2usEucAQY
	9wlulWLsxyf8ElAuCrMPqwro/gQtDhdoqO3Y6jVA7u0EcZVWUCec/6qOprxc+I7r
	lMtgd370hhPxe7xrA6Q1kog8Jq2Ra0ntkEeMQ4y9uwCRy+u8xNR/ACBJzW2IMexD
	JhO5t5eZOIGxT6EyB41Wck5BeoHKaHXxHg8GlZLGJfDr9dMSH6JQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqseh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 10:50:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56G9hkwN039873;
	Wed, 16 Jul 2025 10:50:29 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5b79ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 10:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUo7Tw4He7FRSKP4UdWXS52jssu7JMh83tiOodsTlbrsCUNUWHrOQQKka9gKxQ9LDHFp5aLBvdbZIZO/nfJecIQPIgOXPYTYM0SEc5m1TR0Epvfu7kYKt4PQYn4E26SzaLEpcoyaAcsMpVZVEFe033LWQt1GtBiSTXFIR0gTSlESg4Q429xgy6ZobUSUpbKmWPsJehpP7h/HYPERNPNT7SrQWWSM9HG2tX2g7swaZNIHs4D4syr4iYPNRWohE0/QpAl1Hv1L2NREGr0dunuTFCFZWVGtL6Fa01Wz+1GSxba2gytpFqbWJyKrkMoIJFpwT1F6N/ztsihGL4+TES9FLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO+EcofNoZAhAt9/Kvyu5lACKx2+saAv6DTzBplnmsk=;
 b=WEwa4RQP7B6W7reQem/W+FLjWEVE2R6yLrei4hT+m9A/Q8eqreo0Pk897WmtJxkphnX5r6M+3AooO7RL7gJAX7vPI3On7B2QP/Kj6JUx0PKDiJRZTZpb0YVK/XDzjetMUsgMKCW8mFkrDNZFgVrm+XEC94otm/eA67m2QJp7ew7rqC1rm5hW8fVzvSfCzoNsSj+Dxe2R6OA412A5KOomYjh/Z02csxbUukJIsYPCVHVHkiPzr/4n4dvd4LaRB7OgL7/Lozrx3g7qsaWLYk9+zoJ2r9Ew60lBy8PNMrWiDaSSXTHrDi9GNGwmpP/CPfmpSQBMeKwFrqWW0+Zk1VRrbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO+EcofNoZAhAt9/Kvyu5lACKx2+saAv6DTzBplnmsk=;
 b=ieGm1e91F/fEEd+MD7BAMW5Xx4MGZwK6Hq2DkFAZ2UU+22xAb9EsbTlrVgsW6+A1tSB1hPHo7nijPLTedi26gyZ2Rg3cFT5lK3c7O2/XCtAXpMyfySNbht1OoEJ5vgqaxDq+xcSz7LZe+1xVt9l+6m49rPlk1O65wxqPN1wLbVg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4114.namprd10.prod.outlook.com (2603:10b6:a03:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 10:50:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 10:50:25 +0000
Date: Wed, 16 Jul 2025 11:50:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, peterx@redhat.com,
        jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
        paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com,
        brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com,
        linux@weissschuh.net, willy@infradead.org, osalvador@suse.de,
        andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 1/7] selftests/proc: add /proc/pid/maps tearing from
 vma split test
Message-ID: <ac9c5912-e19e-4653-9b6c-e68ca3a058f7@lucifer.local>
References: <20250716030557.1547501-1-surenb@google.com>
 <20250716030557.1547501-2-surenb@google.com>
 <f041e611-9d28-4a30-8515-97080f742360@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f041e611-9d28-4a30-8515-97080f742360@redhat.com>
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d387a80-7843-46d9-7885-08ddc45691ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6SCZ0FoBoXkBAw/vlRn4DWuxO006Ua/vOholCNSDrCpgVJC0gVJYusVHyX3Z?=
 =?us-ascii?Q?R+h36CP6fYkVL8e+1Yq872y3wzgd5e7diiMM9d1Fu483wM3td45YkyyCpjH/?=
 =?us-ascii?Q?wNBMTqoJ9kiNRa89jqHig49XZ+haaahRONbOoEW48u/44AIvDCGG4Vp0jgsk?=
 =?us-ascii?Q?36S4yulQcovt6NMyjKTSN5811CPkLEePs2d/QXig0igzyR4CbeS+zBghlrcf?=
 =?us-ascii?Q?NASGvypFSuz/2UnD3JNVMQOSjxfKcCxOF8IVNv6W9B8nGmQh5AIsvmYhk/bC?=
 =?us-ascii?Q?ebnpztnC94D2CJJKsXmiF8tZc03wdc1T8UAvu6KTIKozUt4lLOL6M0ZqXmIl?=
 =?us-ascii?Q?/IlyVjMauUd2D/6nEJ11oowix+uEN4US8GyRtcBvWYIkpiC0dWuiSVSlzcL2?=
 =?us-ascii?Q?s0SF/0w2qwP1o6DINWDH863+eSHYYbRvMUXsvAbDw3Y8oZVig0hU0ODsOYZF?=
 =?us-ascii?Q?+8a6VhtD7JbNhLVL4RGK2eIC7n0sUC2deTqRRjQbF7Nf6WETSeCK95FVNj6Z?=
 =?us-ascii?Q?9dAGHyMRe/EkFvxD9G/Bo8dXielMp+1FA9bhg2QTej0mEUsqer4XCWYRXOVZ?=
 =?us-ascii?Q?zpCNfhCu5wAN0Z4WVOBvkMAMpVw1s6slIWGIiusQ9/dKIk/iPDGIR4CMgynO?=
 =?us-ascii?Q?qTlE0DQCpUCOj7qiG2D05kX4vNdI5z3KmTXy1Juu1ovuZuTiLfFKwloyqzte?=
 =?us-ascii?Q?vzh0EVCmlaCFG9lG0MNTBAtquaXA0y4KxfBHkbHXWuvYtlGy06k60sclbQWX?=
 =?us-ascii?Q?gSvuvv4Y9Fq3+sCujk7ePraQZ4kWZvAvdre/nrgqvkHqTGkybsxJP//6i9Nz?=
 =?us-ascii?Q?Zp8L3If1m7TABp8JbQJAt3JGMEKrUSnobxGEL0uQxFzplvuSEMugaB9bi+Wl?=
 =?us-ascii?Q?wpqkRzkmgSPPbqGX4Q/f2+NZU6As8CnKfM1EbEM603tUNl/wqrpMbO4tJ0w7?=
 =?us-ascii?Q?bSNLHrwID5Rvb3Ek/2O7V+jSBnwpLTvao4ptU3Cz2vaXyHh1YFDzZ31N2XCs?=
 =?us-ascii?Q?PcSPX82t5dFq2VOEF+Kfs9gkONo/tSMUTnH4FzWPJ4aaNeqrxUuURa2jEEBm?=
 =?us-ascii?Q?j9LOhDbdijNfmtOHVEE+6T1OACbAZHqH0f5OHibS0cWzn8aMXYehzS5mGNzh?=
 =?us-ascii?Q?MoeQMjSoTrs9jm4/HvdrZkKEvd8pEmxPI1bnMuRrBgVvtVBLj3Eg4/fJGYeS?=
 =?us-ascii?Q?4mwcCUV4yWB3eo7iAtqdLFN4IpUOQUO7L9D5wj0aN0/DdBQwB53SbikCxij5?=
 =?us-ascii?Q?5sBBUXKnF+CpBNR6VKHqz7ku1DIqMpkDsc0htrRSQQv9GqdP2kvDQ2VenemW?=
 =?us-ascii?Q?b2MwpOzTePpXxZzQccGn2XMGerNUwXKQZRWcN3YACtF99D37Dz7MTbj2GfpI?=
 =?us-ascii?Q?9hOFbNEcScao9M3Q69QFnAs1rmvChRTjC5jXYqpxbJ/qveE5/20obc81tO+0?=
 =?us-ascii?Q?AXgnZmeiToc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HEorOoAS979O87aZ55Qax6iwu6f/23sMQUUT0EE5lJ9XhUY/yzQqVmNSJI+6?=
 =?us-ascii?Q?Im/MiLabtqNPOb3WIjihJi7p7rExDZ+X5TRpa4ZrYhSCZy5BsprcMCOw6K8I?=
 =?us-ascii?Q?6zn7a5L4d0BfVbRxnf4FnjilkD6gIcwrv4Qp4HP4tziEurvRupW3Cc0L+vNF?=
 =?us-ascii?Q?MxfKnJvBx+qCDXGMNGTtOt2k/wPM1h0Gp+OkmYB5jM6FLoNhyLKp/VEjGrQw?=
 =?us-ascii?Q?e0vl1Vf0UMzDp9dgvh/9yVlfXqvc0HrU6LPn0onuWwPnYHkzNj5p7MGJ8ib1?=
 =?us-ascii?Q?Ly2Jaro4GyZDnA74uA5cmjQ35ozMSqukJyQBdbFb1xLBKjWkFWY0t3AMYruD?=
 =?us-ascii?Q?sEJX1GTFSzYSJLtWJdAKT5xSfQTJOcdoApMTwYq0a8ymoxNnR9wOGEo8e1su?=
 =?us-ascii?Q?hwNHRbyIyIOFh5bfmlNeXhb5ibs/fnqhV9xrMxOkbG7flXU4A/ixuE1qW+Yl?=
 =?us-ascii?Q?kcsvhTJRunSww2LJ1d/PmqAxKDiTYxD2wnvu1f4Pz2ie6c5Awbs0S9MKigGq?=
 =?us-ascii?Q?+xl+HuvMBcWoybWarhJQsmbLoZKSWq/mGYrw6dGmrcdOVt2gNQm83aI1zrxE?=
 =?us-ascii?Q?rtfjW0ltTeTaWc8VDXCxkVLjcAQsb6wRRSIZ9XDXDnc6DU9tGmU9a7pu8HXK?=
 =?us-ascii?Q?ETrCr+9iO6cEs/y3bnIVrhxzJyXX27Ds+Dxjnu19SLtOwo3UxY3UjoH2YKPk?=
 =?us-ascii?Q?5yrEFBFlrBT+/t6lfnZVE8V3cWqgLHwCn5Q7Yt9VIZzqA+oWYJYCYg6BIWeM?=
 =?us-ascii?Q?RmUDSK1WcXkJyvHc6TPfJytQZMCCgtouhT07yrzb3tuLmJxXshgVJIN25s6u?=
 =?us-ascii?Q?Iv5uO8Pa+qjeWH/KYg0cBGlJZ+rMMjqL+mAvO/fkAcTvOf523HAT3XvX6jY/?=
 =?us-ascii?Q?IaFrPWEj/PHc5NPn7uJdrtSUV4AwADszKVefdqLQz7b+p/VRnfFXJuJfmIuJ?=
 =?us-ascii?Q?F7c9TLxNrXiS42EFPdId8pt6Foo/IeVSekW7DqYfpWGnXr9kPFUz9ILyq04F?=
 =?us-ascii?Q?wDnydB81UNAsoH0/Qy/v6Fdy7007BD8hl2hJ6EsuERC6YzRR4Hq9jc4j1Qbt?=
 =?us-ascii?Q?sL/SA6bwBlhXbaCI/pZziBo40aZnAwzRQpvDvdUVv8oI2hQDTtmC0PSGMXZq?=
 =?us-ascii?Q?J2rhBWOq4NXGqn4hHcGcrbAdxfJOzBvLSmtkqhW3L+ONEDUFWLStnm0KZ6pY?=
 =?us-ascii?Q?bIo66q+lVGQOZ7EdfU+r5mwHQHeqT1MwwWlnWYhogtDvBXhlmoLqv0c7FIpI?=
 =?us-ascii?Q?eecmOojXuAnQQW8Cwa5kiWjY2H9rh97k7iEZVkYWWhplokzKkcfFgUlMYixA?=
 =?us-ascii?Q?h73rV5AyL2hLP8shbXmrD2punqf2pDXCz7mgSLsIqVMizkFSI4ssAsCMPlUo?=
 =?us-ascii?Q?gGlKt8Ie3lXe39lS5Jv1H+JhRlQWTwWwGHk5W1W6tnb6p9xdx4s/DUm7PU1l?=
 =?us-ascii?Q?9S5rYDfH504Zs4U2l9tW+pkFI6+UX3i2dcDczZL6UNRUGeTD/XFwTnv/yQdM?=
 =?us-ascii?Q?PVVXzGG8yYdr5LqrSgUNWnAi9hWq9SeGQkUe9IteqkbnF6JsA7PgiICiD4Ac?=
 =?us-ascii?Q?DbzDmvCqfFp6bFpotw3DHrVqH3YC943VOWsueNHve5TkqdL7LuCFnR0IJhh+?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fvt1RwUW7EGFPq6fYWF7DzWfGER1UnbeQqMdoCIbSd0Q13jz1l1DjknE/Kzo+M4tL4LvHeesk0cuzqPBzloULOWFhAoiBTNnevPjutPhudn4kWcza611CX2QnqOWFftiPxsSEC0zp4tDM2wcTP7eixKag3kWUg7YhTb9xr8V+1317ulyxGR4J875roSUIfJQlpS2MgZ2peZdKtMlD7dO1IdeAeGnmqQ0dwQAP/r0/+BmJo1N3An4azwlCJixnj+VxXXqWp4P50eeGymgkxJKnYrPFi+gSjySC0e2CH9cLPmT/eDALOa9DuHq+ToUH4yjhmqa3YgIQ87JQkgqc7H9l1S1VAiREdqHjL3H7okQ4wSi7poztPkLar/VVd8Di3Kfoz1ZrkNF21/97yU4sGJsudcpP93YZsTGYjfBBJn4WBtnVOdAsgDRx6tvobR6JXXVOXGRltQoduKIRgCaCBGwXwiueD8zS+xgjMrIhqPIiQcyXKYKYVjHGhqBqcueXnBCGVoJna2SMCTb15IWcEE23SRAzM8q7CZdvRgnJFCXg7XAjezUyoULyHfcoOp1UZxqUld/y4fB77HCRvjfGgOx3SwzL+06Py5kxwRgdeabBVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d387a80-7843-46d9-7885-08ddc45691ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 10:50:25.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+rNyuckdpIwObARq2ImTX7OTKOF6qk9WJcL2lkOSZReR7klxfiA6bEfcuGQYhMSdo5W/c/wIRGP/KVGFL9mRfGJhaet8F14FavtT2A+iNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160097
X-Proofpoint-GUID: p_Ej3ipZTpyKUmxcft1ZKP5kJVkQO5ry
X-Proofpoint-ORIG-GUID: p_Ej3ipZTpyKUmxcft1ZKP5kJVkQO5ry
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA5NyBTYWx0ZWRfXxPhDPgkAVXx4 /zL/cWUE+u021V/DBbV0OZeqy2vyGT89O6W7S4LV+QOOkzqjzqWyoSFKaXMfLS9BHcaNlRke66C iHKFUyOGsOJgmGtzq2sj+rUW6k9emK4lsa8L3gOF6c1O1nRU984EeaYDdl9bT8Q0inQZ8X63nfD
 1Md2GB8OXKtzIXcCeb4pGiwJxM2CFH6eYSG7Y8yKf1kUtCacxId8GYAGWraIONYqDQ+s5d6gEvs 6ejhYT7k4iM6foJW5BvKPD1VebvZ+5NnjG4URuQr9f4p3r5VrMmqw44MrD8kaqhXHWevCKW3K8d NKpIwSQimohffS1+JPyaNdlSOzm3iWDnU8ErOHrJyq/6MGKlDhYPaxOsr+rn4HGkCCBK9WgTLET
 7imBNY854Np0wUx65a7dTi1w6Pcm+scnteRjCaroNStkqDxXX43JsLPFfqkDp6h+PfwuGoby
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=687783f6 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=cMq8TJlj-K9RFVth140A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600

On Wed, Jul 16, 2025 at 12:44:23PM +0200, David Hildenbrand wrote:
> On 16.07.25 05:05, Suren Baghdasaryan wrote:
> > The /proc/pid/maps file is generated page by page, with the mmap_lock
> > released between pages.  This can lead to inconsistent reads if the
> > underlying vmas are concurrently modified. For instance, if a vma split
> > or merge occurs at a page boundary while /proc/pid/maps is being read,
> > the same vma might be seen twice: once before and once after the change.
> > This duplication is considered acceptable for userspace handling.
> > However, observing a "hole" where a vma should be (e.g., due to a vma
> > being replaced and the space temporarily being empty) is unacceptable.
> >
> > Implement a test that:
> > 1. Forks a child process which continuously modifies its address space,
> > specifically targeting a vma at the boundary between two pages.
> > 2. The parent process repeatedly reads the child's /proc/pid/maps.
> > 3. The parent process checks the last vma of the first page and
> > the first vma of the second page for consistency, looking for the
> > effects of vma splits or merges.
> >
> > The test duration is configurable via the -d command-line parameter
> > in seconds to increase the likelihood of catching the race condition.
> > The default test duration is 5 seconds.
> >
> > Example Command: proc-maps-race -d 10
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Why is this selftest not making use of any kselftest framework?
>
> I'm sure there is a very good reason :)
>
> Reading assert() feels very weird compared to other selftests.

Sorry to meta-review via your review again David :P

But just to say tools/testing/selftests/kselftest_harness.h is really good, and
makes life simple. See tools/testing/selftests/mm/guard-regions.c for an example
of how they can be used - pretty straightforward and avoids a lot of kselftest
boilerplate.

>
> --
> Cheers,
>
> David / dhildenb
>
>

