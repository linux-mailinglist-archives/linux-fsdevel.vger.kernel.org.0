Return-Path: <linux-fsdevel+bounces-68930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1856DC68D3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F71E383FD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E706834A3A7;
	Tue, 18 Nov 2025 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JjziNcuM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UA2pzOC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D983346E73;
	Tue, 18 Nov 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461190; cv=fail; b=MEHRv5w67lgIxWr6nW79E/GisOlmyPE32ltUlISx6D4oQmuOP+k3/FB5SyPpP15+l91QcbwPOG0lHcSEOEGMra4QoPuFDpo2VyxB9/VMmLutxqr4wThEFFus7fqnndvesRTWb0CwIZUselzHTxjKB+F37p4urB+ycqPVhivCjbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461190; c=relaxed/simple;
	bh=PZZFYbI0KbxcHZ7QumRJZ9ERYj2N1E9k4JGKHWdt3mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tBXvaJDRUUYtbr94MAlSEZRgANIg1/Of7qkG081qol8fXZ0DWB5gjk5bBgAgWa7q57AL6n+ojpWfDGaGGBOUQqT/jnazYK8v/4v8qx3T+LPJ/TwA2ABy4OKmB6NI3bIt3aG5nfw84SQzuVjzh0qOkJBVniltPiO49N1YPcxA3r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JjziNcuM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UA2pzOC8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI9CYH8008373;
	Tue, 18 Nov 2025 10:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j0+o73DZcBPC9d5sgCNOLtO+fpCPzD6UIDIHr41PxAg=; b=
	JjziNcuMquaSo45XqrU3iSaRHFMtKoiu0SNRTi/rEpvlckjgCx21k5vS2enfLAg9
	dIviJCKpcQlAfHFKH4exidDujZETbPCTTFNr2/l61p9nHkdNgg4gjViQKbSuJ96F
	pyBjWuzhJDrPo468doee7yx1wP9pK9ce6t44lUyADUe2EXn351sFubwty87B3pyA
	2V4e8YnwW/iF4Dz1XlH7s3yMSGBYPaDjxoQ7L9/jERTQF0L1Jrf/Ow9MPIxr2jd8
	gTI8jqQviH3L35mhxNBxwv3Mz15cuFYQ1wqUMkCp2m3bV0uqDgs/7vTluyixy+dp
	/9yku3PGV1LXRT8Z/PpG/Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej964gyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI8wjfp004268;
	Tue, 18 Nov 2025 10:18:41 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy8pp85-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3+RYaK4mGf6FAW+rPQKTlHanTWJ2GkVfLOyCXyMgkbcnuMUVtunyRwjuhWPUZ0LWAGTBJ7aGZxlTH5GqgfWboVsX9VtaJ0jLq866dza8wLRCiByosrUOJCYhp6mW5k4IvJqPInUthrtslG1QOIvV9A2m02xntcBRw4LZOru7LS/mGwlLCZKdaTqc6coYHmqSU4wbioou7ROPAkDCo/LyA5bBz3jubWPRyyxgvE2Q+THeMb+Xg4QaXedlk6e8LbrN10WtsCPZtoeVIBWzbSbp8J/25UJUGEXoKmfDYfwNYFUPh6XjQ0BLkDlOn+dZp0eIM2f871AhEdCORl3ztjpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0+o73DZcBPC9d5sgCNOLtO+fpCPzD6UIDIHr41PxAg=;
 b=NxTFmhjlNeYxd2sPXiavJw8KiksfV2LYMEdl+0XWoxXNq8YiVjidRgsYogQz/0x+nXA6Vsyx8VmZoiw0AedrYF2iaWrl+ljB00+OjK4BYG/6FfDc+LrQMK6M2TYgwHazuLHzt+TWI7ZjnYBj6e0g6ULGTtQdYK90HJi7g4usBwzQjR42f0RvbusvNGotCVjGHE7l9GRrS7rU0SnFJ4LzOqLtU1d9TG71MgOmhl37NznK5/+2N29KBAYgvQOBu1/4PjWvaF/zKT8YEjLAU3o5SvYSvs2A/RRx7CuIRnt7SAFQVwrU1gUu2MDSx3atrdoOuBnuyBcSs5i00RmEUvf23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0+o73DZcBPC9d5sgCNOLtO+fpCPzD6UIDIHr41PxAg=;
 b=UA2pzOC8EVeIhaa/v84/XEE4BUWGXnOyjeKpOlPwLCYlylqMSg8meT522gkny8f4vzUofvHD0UK/3uZBcuL6wRcxw1ZTGy/Y6bdL81TVOu2g11SwoHNIXciYwMOavx83LNhMwxhuaitYUy0Ncg3VzoePiK5ifvW1RKyOG6mLo7k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8756.namprd10.prod.outlook.com (2603:10b6:208:562::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 10:18:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 10:18:36 +0000
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
Subject: [PATCH v4 7/9] tools/testing/vma: add VMA sticky userland tests
Date: Tue, 18 Nov 2025 10:17:49 +0000
Message-ID: <5e2c7244485867befd052f8afc8188be6a4be670.1763460113.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0397.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: ce359fb4-8bd5-4412-e8b1-08de268bd59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uNAfdIM9pQjOyWdGL28QRc2JcOlRE4ucwHb5OO/8qpiSOOB1syRQmCUQATtX?=
 =?us-ascii?Q?ajdTIhxf+lTTwiylVEpKsSWhVxGWcTUnBdnrfuZFO0RwDUULQ8rs0QTDM2XZ?=
 =?us-ascii?Q?TYi5baJpjuLVqlGB5+ZD6jJtIcmYj4VBOQQXbTy9XqqaEhZCOpNBsrN1+VuJ?=
 =?us-ascii?Q?lyN+vS5kVSngQaz1llRcfksh4N4dGTlEWLdGqhvSWcp4TS3AYeRUwEdfZXVR?=
 =?us-ascii?Q?867Ss832GPKRtxg5FntusDkzbI072CXzkVCnO9aEraRHicxj3XwSOwk6fJpO?=
 =?us-ascii?Q?bcX95RED+pNPeK0cIjFLkubGn9gWRvRlW5Cr1AWryqwGRuspcXX4CjsAEsZ/?=
 =?us-ascii?Q?dfvPZ2AQ6EONP5r6KuFopmL6oRhRWsjhKAhfN5hzEmFzsv0rm2sgbw52P5PS?=
 =?us-ascii?Q?yOCQy12LiQK6wFVg/N6BhgYsNMLN8KDyMt1TXpQqhqkfoa0D6vsBAFt4MaRq?=
 =?us-ascii?Q?SmC5yS266sIUnra1pGpjWIAVoU2YJ9kUR/9VJOlZQjmQTihnvd//KadxJ2s2?=
 =?us-ascii?Q?5Vvrd0HtyhjL4D+s0aYNkpHHH5RtUXe1hmXQVWT3BxjQV8cSLRzkYj6wAXmi?=
 =?us-ascii?Q?XONAJkt03A1GlRUv9eha4/27+M+6IX/uHeewf4nqFoTx8jeu1R0IuqL2AVqO?=
 =?us-ascii?Q?TiRhSSD0lccvumNe7Z0yrIVeBbhe8qgqqxFmE0h+9NQwUXFS67E8vDQCz70U?=
 =?us-ascii?Q?H1lM4JzSrAyF0ibutpKyTimO4QQV8oAi4oD86Hj9u+3z9Bl/DSos3Iqf4q0R?=
 =?us-ascii?Q?HAf2zd4S7MVZPUzkP6+UNWVJwqyFaZ83iqJNsQrKZICs9+asXKNjPZsZpmM5?=
 =?us-ascii?Q?1HJEoVHvmUIfrmg5eVkl78rB3o4sZVpck3dBptPcQ0d430sJb6KGUCg7LC7w?=
 =?us-ascii?Q?ruLaG+kLj3zRlG9veU7St8AlMqJR9F5awdXKbX4mLhgk3M2ehO7Qei1lYLYl?=
 =?us-ascii?Q?obYCfu7NxZPvv1FVobgMwgnE6WP7DSgg9LtS5Ulb06yeSuedewJ6I+OLfAXw?=
 =?us-ascii?Q?EslzEa4n3t9jQe8uUI5XAvWpOpk7PhmcSkGwOwwvXagQ9oevn95L8Lrcz0Xe?=
 =?us-ascii?Q?YlPiaZ4599seTWB/ZJuX9i1Tmvl2XDjyhKb3i5ItFBcweZqwhwdmAmuFgb1V?=
 =?us-ascii?Q?v6dJs2t2F+FvAS/VKMU/lMKNC5WBtI+Wxfz5rohgfCAfqeHORkfTdQYC8ygK?=
 =?us-ascii?Q?nv+e1pPFsrAkyiaVts5773t9qPmzpC8AS1QipcZFox61PG4fDsaxBXwIZvkH?=
 =?us-ascii?Q?ECBkxcfb3sGej2PqDRXP+Z5Wplwxmli/hp5k3HbTfMD4h4wpUn+u4TLsIXdK?=
 =?us-ascii?Q?QMk3eYeX52cK6ZzyY1NoM2XVeuRHuvxCSqzbZLva2PSZRfK3wZIw15f2jjP8?=
 =?us-ascii?Q?2KhjQWtkaQgJqo42WymyBfbxasH/4COYKGc0PYPfB2XtsLHJWqeMWvG1QnS7?=
 =?us-ascii?Q?329DyMAErcWd9E5zwbXd+HZYo437Yi9i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AtD8LIgRwKLsoYlM5/RlQHRa4ErOOVhSXXeCXbGd9YBpMsjbAnZz7tgqSG8F?=
 =?us-ascii?Q?q2+17BNpa+PFwHbZ58ereKYGhC+bqsGNpZcVkSHJsKtKdIeGQRm9IY3stIbv?=
 =?us-ascii?Q?zauh2ex/Bc3JnJ05fTnjZSBIvaiey0fqeHfFasB2mlRYSGhkNsspAdX6RQ8s?=
 =?us-ascii?Q?43ax5+r5+L+BX1YsNSzOHRzAoYtcYHo7c2zEvMKX7mcGyc4XPOTmtLP11rB5?=
 =?us-ascii?Q?Ho09Jy8ranU/bNCsWGkRIHYCSH5otIiNTZO6HI+1/x7mRVM2WsRy+J/A3lkl?=
 =?us-ascii?Q?hCgHHUw1WyDB1Jp4NsbovX5a0YTGU+MN3sOOOZyAO7yi7xxNBW7CJrIWHZ7w?=
 =?us-ascii?Q?Iu/fwSkIIHVSdt6oSvqIvVWCqbCfBLnk0Y/fjI4zsvgNH1WU83IDC829tWXI?=
 =?us-ascii?Q?vDpV1A8PntcrsLANRQo9nrDxfteNdzVkpZ1dqVVLwooJbkCvTkvsB1QEt+4s?=
 =?us-ascii?Q?yQpipUPzCXjux0Du3HjjR7ctErCzP+3YrLBV1/GIlwj9fdu81ydy3v3DDId1?=
 =?us-ascii?Q?TPKvP+4YM0txQRYgL3EBPIfEhLNbEHp18djh5HqVbyefLBnZy9ErL5VWv7LO?=
 =?us-ascii?Q?ZlRIdctebEykyx865yV5oIIEU7svKt0gwTY42yQbn8LzINe7bFQbWksR0ChI?=
 =?us-ascii?Q?7qWiwVK43R0L9drbanrW/fGb1NnLB0QHpYGRr1k1bAPzv8wrgqwEmU4Kjhfb?=
 =?us-ascii?Q?C4S3J7E08BIiCxMgb5lll8b1TSQKqccXoKdyuedWyJBTzOHiDNkStXo8sdhp?=
 =?us-ascii?Q?oLcd70mgSOHVlB9dBXyL7BH+Dh9TXWRQdRYQ7m3UdedpWWfGtEDqbeWQ5gBH?=
 =?us-ascii?Q?MWqJb6cadwP5TDrN7CKTf5rYLmEReUCCDUv6GbuoThPgHd7BHmZGd8c3Y7Hl?=
 =?us-ascii?Q?3cEJrccj87qdEY6IcQEXvCv+7zgxz7VAbvcT+81NIiUQfSzyyIDbRLicSc8W?=
 =?us-ascii?Q?HST7WLdX3kCjUNausKFujGNibQpJTWK6t7T5A2kX7iyCY358HJaMnw8uh4Fw?=
 =?us-ascii?Q?jRR2+2pZehruFDYtAv/y2cr6ZBgnJZRkWGDT2oBhPIrkNsRPVRFEomukHT3u?=
 =?us-ascii?Q?+sk6enF+9DtLwqPC2Y+cPviSxVrOaaceprVREFGFV1Mu8fY/4C54PV6CXqnU?=
 =?us-ascii?Q?i7OmXUZBI1YpxOekWDwxzztKlsncBjvdhk26cGBhYXHY060rufCupqjmGVRh?=
 =?us-ascii?Q?fh5BMVpfx0GW3QnR10HDXwVzlpN43l2J5Gsct0RAm+m0zhyO0mDmIQJNUKls?=
 =?us-ascii?Q?4H5EFmF3Y+hwLLl3fk19wdf/HTjmy2GRJfTxgxBPCc4bjHuXGNS5rb9rNBOz?=
 =?us-ascii?Q?2Jq7Y72KTA4hEUKzFO4W3naOhsQy2CpNko3Zmgp6/Ht5N7QK6p6QXK2R1cqD?=
 =?us-ascii?Q?IuRsEl2ri5l1QNiUYIWv/ASeJwsbkPGVMUpvxEoDKkRODr+z6QhuntgkDQ4y?=
 =?us-ascii?Q?tYDkXnq3Dg2N7JKjt1XPoDxJM2yKYrV+a/HpCm3zBnpI5RVVhedZaqbLh5Q8?=
 =?us-ascii?Q?S2JQayVQAQe4DQ/shv5+r0jLKj4h+EuonwtFnXPsjf9OTdYmuOZWUAlpagvq?=
 =?us-ascii?Q?pyWwlLFJAgUellAvNIgbNE2jWaTEzB909bSHAf3CDSBjouu/K1heGbRsInHY?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YHFVmwrxYiSCBc+6xhZbjW5jTSss7t4PaArWz3Aq/yKuCxO6ylvRB90pvrMJGmmtLiOBduVWfaXGNHG8LZiRqWXpnDe3QMKIX1yw7gZOkLuuJX6ndk3QQQgGbmVuCc0sGyPJaDfl6Mh7gkdOctrsjb2rmRaOYUw7KSRlUHEc0at0h1HLSD7lRzKwdw8S4/G0E5jMYoZdTJTH9Y01XbEFCAUSPg1imqwc1fXHa97n/yiA6PouqHvlRQdJi9Lg7ElfJdOdtxIJczM7mfnOYb8UcTjNkPpa5DUOTxx62yo1aL0cVks/NdsLf/J9FP3FdCE1W85MbmeQjrKUSU6XOZC/IbZeOn/NVKBU/s9TAk8eUlXoT25+AprdkoZuBLabVXEwqySfkYSgzAE8mbKnOiPg4n5e/14suh/fD8qSz2cNTAa/R48coUVH+iYg2XjAgkSfCNOZYaJIkMAWQ8f+pI64/Bhg337cAjVmmnZ1dcf/U37gbwC0a9Du/UI8fJo/woY+YKCy1nLkbBNnDLvx1MnqSG3ZffjIDHMEPijBzvAnRf+yIBWEEoVrVO0SnZmuCDZjYeH3bm/Qop9feq1zN4gEaKCcF34n4asy8I9BPRlHBZI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce359fb4-8bd5-4412-e8b1-08de268bd59b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:18:36.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mY1ScsaNE2EmpLARlhtbWcS77l8fxpiXRyKXGQ5LzshS4joIYnPGESG5904R7TP+IRSXDdep51awhfM93q6dEGJh4TCNO2+5kAMmwJXpI7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511180082
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=691c4801 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=5lwAt1zO3iEXF7TzJt4A:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: 2nbEwgWdyessclDxbNLTSTwMYl5HXMuy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX8Bsq7nnoejxM
 Vl13/1FMmrF3bEDbKuxSduBu5K5M7yDbMnocjMdnd9kLk23/zEwymOpseNHLx0fHZDyF+EwOvCR
 DYLNQzRr2ot98L2UHQEE53yWJiPp7KnpyVqomIwrAvz9XEO0rQQ7BiLbPsyeo7n2bDvONMQZ8X2
 JkOQh8YZvyVdLjnEWvbUxBZbjLYFVC3CfQbmGI//k7h5hlPj6eIrG+qQR4DUdbtV4W2hT1R0D4X
 VRFgLq/X2dbRI7vtICfNE43KhSQ2VQy9aWaiwZ009NNF5APY0HcvWAzO0byK2iJA1r4icirsH5H
 375qIReDaDDRBhHa7eEA9MMfKzBiSdFev3FruejqPqamhzlNUZT6AfrsWrnZVHtOBcMtNcy+xBW
 mDFMHkDf+1DCQwtFLWsqULLg/3/aqQ==
X-Proofpoint-ORIG-GUID: 2nbEwgWdyessclDxbNLTSTwMYl5HXMuy

Modify existing merge new/existing userland VMA tests to assert that
sticky VMA flags behave as expected.

We do so by generating every possible permutation of VMAs being
manipulated being sticky/not sticky and asserting that VMA flags with this
property retain are retained upon merge.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/vma.c | 89 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 10 deletions(-)

diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index fd37ce3b2628..be79ab2ea44b 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -48,6 +48,8 @@ static struct anon_vma dummy_anon_vma;
 #define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
 #define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
 
+#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
+
 static struct task_struct __current;
 
 struct task_struct *get_current(void)
@@ -442,7 +444,7 @@ static bool test_simple_shrink(void)
 	return true;
 }
 
-static bool test_merge_new(void)
+static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky, bool c_is_sticky)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
@@ -470,23 +472,32 @@ static bool test_merge_new(void)
 	struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
 	bool merged;
 
+	if (is_sticky)
+		vm_flags |= VM_STICKY;
+
 	/*
 	 * 0123456789abc
 	 * AA B       CC
 	 */
 	vma_a = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
 	ASSERT_NE(vma_a, NULL);
+	if (a_is_sticky)
+		vm_flags_set(vma_a, VM_STICKY);
 	/* We give each VMA a single avc so we can test anon_vma duplication. */
 	INIT_LIST_HEAD(&vma_a->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_a.same_vma, &vma_a->anon_vma_chain);
 
 	vma_b = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vm_flags);
 	ASSERT_NE(vma_b, NULL);
+	if (b_is_sticky)
+		vm_flags_set(vma_b, VM_STICKY);
 	INIT_LIST_HEAD(&vma_b->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_b.same_vma, &vma_b->anon_vma_chain);
 
 	vma_c = alloc_and_link_vma(&mm, 0xb000, 0xc000, 0xb, vm_flags);
 	ASSERT_NE(vma_c, NULL);
+	if (c_is_sticky)
+		vm_flags_set(vma_c, VM_STICKY);
 	INIT_LIST_HEAD(&vma_c->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_c.same_vma, &vma_c->anon_vma_chain);
 
@@ -521,6 +532,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky || a_is_sticky || b_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to PREVIOUS VMA.
@@ -538,6 +551,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky || a_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to NEXT VMA.
@@ -557,6 +572,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky) /* D uses is_sticky. */
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge BOTH sides.
@@ -575,6 +592,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (is_sticky || a_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to NEXT VMA.
@@ -593,6 +612,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (is_sticky || c_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge BOTH sides.
@@ -610,6 +631,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 1);
+	if (is_sticky || a_is_sticky || c_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Final state.
@@ -638,6 +661,20 @@ static bool test_merge_new(void)
 	return true;
 }
 
+static bool test_merge_new(void)
+{
+	int i, j, k, l;
+
+	/* Generate every possible permutation of sticky flags. */
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			for (k = 0; k < 2; k++)
+				for (l = 0; l < 2; l++)
+					ASSERT_TRUE(__test_merge_new(i, j, k, l));
+
+	return true;
+}
+
 static bool test_vma_merge_special_flags(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
@@ -974,9 +1011,11 @@ static bool test_vma_merge_new_with_close(void)
 	return true;
 }
 
-static bool test_merge_existing(void)
+static bool __test_merge_existing(bool prev_is_sticky, bool middle_is_sticky, bool next_is_sticky)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t prev_flags = vm_flags;
+	vm_flags_t next_flags = vm_flags;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vm_area_struct *vma, *vma_prev, *vma_next;
@@ -989,6 +1028,13 @@ static bool test_merge_existing(void)
 	};
 	struct anon_vma_chain avc = {};
 
+	if (prev_is_sticky)
+		prev_flags |= VM_STICKY;
+	if (middle_is_sticky)
+		vm_flags |= VM_STICKY;
+	if (next_is_sticky)
+		next_flags |= VM_STICKY;
+
 	/*
 	 * Merge right case - partial span.
 	 *
@@ -1001,7 +1047,7 @@ static bool test_merge_existing(void)
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x6000, 3, vm_flags, &dummy_anon_vma);
 	vmg.middle = vma;
@@ -1019,6 +1065,8 @@ static bool test_merge_existing(void)
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 2);
+	if (middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
@@ -1034,7 +1082,7 @@ static bool test_merge_existing(void)
 	 *   NNNNNNN
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range_anon_vma(&vmg, 0x2000, 0x6000, 2, vm_flags, &dummy_anon_vma);
 	vmg.middle = vma;
@@ -1047,6 +1095,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 1);
+	if (middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted vma. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1061,7 +1111,7 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPV
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
@@ -1081,6 +1131,8 @@ static bool test_merge_existing(void)
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (prev_is_sticky || middle_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
@@ -1095,7 +1147,7 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPP
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
@@ -1110,6 +1162,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
+	if (prev_is_sticky || middle_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted vma. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1124,10 +1178,10 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPPPPP
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, next_flags);
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
@@ -1140,6 +1194,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
+	if (prev_is_sticky || middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted prev and next. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1159,9 +1215,9 @@ static bool test_merge_existing(void)
 	 * PPPVVVVVNNN
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, next_flags);
 
 	vmg_set_range(&vmg, 0x4000, 0x5000, 4, vm_flags);
 	vmg.prev = vma;
@@ -1204,6 +1260,19 @@ static bool test_merge_existing(void)
 	return true;
 }
 
+static bool test_merge_existing(void)
+{
+	int i, j, k;
+
+	/* Generate every possible permutation of sticky flags. */
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			for (k = 0; k < 2; k++)
+				ASSERT_TRUE(__test_merge_existing(i, j, k));
+
+	return true;
+}
+
 static bool test_anon_vma_non_mergeable(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
-- 
2.51.2


