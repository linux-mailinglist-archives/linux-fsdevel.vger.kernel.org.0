Return-Path: <linux-fsdevel+bounces-67456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA39C40D39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 17:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D611620B15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F6D33342E;
	Fri,  7 Nov 2025 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CTaYqHfF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UGtK+bEq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051C331A75;
	Fri,  7 Nov 2025 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531982; cv=fail; b=CpFugKARhpfDG1jDBLdchyHSn3j3iXXnLnYTzHrzar0rs1b+aQy/M4I1sXqLPwWBUVkcVMnOq2Nq4vEc8/RV2n3PSELm2eLTsupNWP9dGzRxfCV80lsS9pvenfd3P/Z4Hozdm/gRurfY0TJ50ixJ1qK49fOUNdsuk9oo2od/fzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531982; c=relaxed/simple;
	bh=xFbh4cL7rhgMwndmyXXihrZYYJ1E7W+lMzoYZ1Rts9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6tiE9VI8+qHWBFk7oQwx7NLEipPscCjdsAymk0KG+sZJfRDzzjmT6d9fHSlWU4lb6par82nQblx4F10QaPiA7VUnB0Lt6+9f+rbaorSE54r78R6KO5BOoS7U4ByJGgAVizIZBNAJoC6daJaB2GWo6VkGeEU2HLFSqOgt2MHreI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CTaYqHfF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UGtK+bEq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7EumDV012752;
	Fri, 7 Nov 2025 16:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Mu1hBj7x4VPpJgD31MihexUBXMLVlPesPfvc/Qbopl8=; b=
	CTaYqHfF4DqPJ6fGzUTaZnJ/IqYG2vm81R+25podAm6qxHzNR4rXCWf3NJChls2g
	LeYcvEy/FlghEnWIpsjg3++gTjyipThw5jUrpgTXpdFDQSLfWI3Y4bSer6UjZqAX
	m4FYv1K9XvQ9fXhYWrPiGlYZgup8+Zgn+0Bl25O5holKzXdQvtb9rxns59d/Pq+W
	JiUb8xs2kFRdPP6urIe4cvQelX2T602f3tlufGNdocog7dE9xD7Ngzs77/Np/TNZ
	U7rX2kY7S+7Z8MAiUJHHY125BNxqJkdRGujYf7USIfsusONec/0y0f4YXgC1NBO3
	pm0KSSk0jF+krxyQ6SD9LQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9je8r7r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:12:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7FgLS7036126;
	Fri, 7 Nov 2025 16:12:11 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nqt0sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svdNVqkMzrGFjNKB701g/jr0JeKXkiOcQisT4N6upFg/NKf8xMEBocvJ1HiUsNmPIS41KNFHV2uEUcIAzYm7O/PW0qGDgL0At4AbfEZwl5pXsRiBuHiDik86OCKsXwgXWkRXQ1R/0W0kazSrGgZFrG8bu43W/u1GSPajhrzMPQpla+RcJX2UBJ/efBs3Br6qzb0IhZAuOxwQioHDbB42sQTyiuhES4daxcpQaeDpY/DiMozmQX3+A618ZSYz0Mm9O4VI9MiKSwwy+Pf1u4XfTDisMp0wmVi5FbJfZj4P9OVlUmuUY0TOslOs+c36Ksa98bMC8/qq5TBANA/J7+vERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu1hBj7x4VPpJgD31MihexUBXMLVlPesPfvc/Qbopl8=;
 b=TJ4hNZiI4K+NGolB3KdS95fyn3mzVGs+VJO3yF1ZxfG8bf0xhKV+8rfWIEvNR9Z2q3bRRlh+21hYgiCk661msjKSs/EeBXvQpMfxI+nxuU0k2jUjebhu5VNgzoUrisUg+Vr/4bVDXgTZNkM6vZC05BCO7cerp9UZUUpYyuhiyCP2fRXGbuihyBC6c4zC2/Y3lgklzd7OiF1iS0wjDwga2y2RvzGFA+owdcoGfXR8IB9MaJzVE6D23N4Vc4O/ShvMGR3SiMWOCaZe37c6oCE3ewfcnFL0APuz1r6zEu5QArkdJqnmxRSb/8Vu2EzAUZHcqsXJSUcxu69GM6LWulcV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu1hBj7x4VPpJgD31MihexUBXMLVlPesPfvc/Qbopl8=;
 b=UGtK+bEq0GP0pAPYAgyD6VwzxN3fkYrEEOSgY6XZoL5g6oZPxFSpY99Afu/NEfuCy52J/7F1xv7sMiA0gws7clFpeIZHY/ybVPDSJFO2cUAfftK8UuLykOy0TaFzV7A7dPi5OqgekRsNAXLd9bQbBImmUrj8FZIz5Lsi2x4lIzo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPFADA73EAD2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 16:12:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:12:07 +0000
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
Subject: [PATCH v3 4/8] mm: introduce copy-on-fork VMAs and make VM_MAYBE_GUARD one
Date: Fri,  7 Nov 2025 16:11:49 +0000
Message-ID: <ca74d10646662f53627a42d49fda3f39932e20d2.1762531708.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPFADA73EAD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6ac15b-2c10-44d9-eff1-08de1e1865c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ea1fkZyJ/j/dkAUvuudiftbLJ3LbDZVWahKZ9aGyLxipKv5Yi3uzgELrYkXJ?=
 =?us-ascii?Q?BIPAwqp2yeNpb1ZVW/OGWrRc4cl2S2ibEWj/wdSMniOkUdCAJGlvLNGk91zH?=
 =?us-ascii?Q?DekNeyHMLMr3OABg98gJBsn0QM3EclV6UUWPhx9mZwkwX0TvIsrh6Zf4UOOZ?=
 =?us-ascii?Q?GfMfSsCIfUsh/rY9F5RXKFOPLd6v+2D7Ej5VmTnAxAlcwSX4o2PQ/CHls8mS?=
 =?us-ascii?Q?3LQTDcXCxK8O2h9pjTB5xXGUO00/Y/FzMnTlPAjeeSCJNz5jf1RzEXzLvCAc?=
 =?us-ascii?Q?H0KxxGLpP6Me7nbYKxmdf6Kry75OXVtK6KgQMiH0SrXVXYfKJUVsSWqOaoCz?=
 =?us-ascii?Q?fPKlQmNiK/DVE+dfuWanEjle3zSuvrpShkbyu5Ny1nqF4/8Q0EMB4TkNRZmr?=
 =?us-ascii?Q?NJmEcJdrOkaN3Nb82N6Pg9+bP0E+euQ6tJNuabuBdprqni2a0X9Ol5CPGTdK?=
 =?us-ascii?Q?OOZ6UvnYFnHyX71v6FPvUcg4PJZ4lazVXEG6NA61bke7EXNC3QBsj0VAj1Lg?=
 =?us-ascii?Q?tqUuCdizOSVOoc7xh9tFZf0SBXaoZoWl4QlhiY89CqUGUffeRFZ8fXbBaTaC?=
 =?us-ascii?Q?8JyFTSsasWamqd6SXzpwnHTGp9fMG5NWt2mnS3d1T3MOPKnaTHm9/0A+Roch?=
 =?us-ascii?Q?IvQoDLPU0g4CT9hFB1eX4CY77GaMbzSMrMdsXfKG7S5HrwptdWp5uego7til?=
 =?us-ascii?Q?LY0ce/fyU5vWDa7kfs0/tc+1jzpGb1GMT9jdjkuset0ucEV6vXEEARVcPK2E?=
 =?us-ascii?Q?t9ojZx15WP+f+c1QowWdeExc+78ppQ9VI82q0lpEwLFqfBHgfNBA8wn6fS3D?=
 =?us-ascii?Q?3Vc4UYRCiAFAdCIY9lay+kfNnbON3i8Ff6dGoyZatYWXtP0wIs1YrgS8acPi?=
 =?us-ascii?Q?qfrrpjxxJC4MNGTG3zr84fCcP2u63atkAAuop5HOqWUiq5xNEYEU6slZbApU?=
 =?us-ascii?Q?cIIJDFwc0DHEkMvgY92Ku5rDwuzQsZlxEsq651L8m03OyCStG7ZDIUyx0LT4?=
 =?us-ascii?Q?WzU8sWfgQZMcFSXGl8qEmMmh4MycdOxgEJnuOW16+qmA7WAVI5p2UnBh6igl?=
 =?us-ascii?Q?hjkYXl0sDpi6PJ6ENSmojtYHjzOdHqvDWWyqUwIATdJ7agdEaVLsOthuIrlw?=
 =?us-ascii?Q?Qgr6ccIkeMU+0RiP+JxmiHtgSekojO2z6ccdFwt4NOJ7rcnX44j2WLk/S+A3?=
 =?us-ascii?Q?aF62CAw7YVTvDxklrieoIQCD7rjjd+5Yx/91Ir2tA8KmFC6YS2ygntQ/Jnw8?=
 =?us-ascii?Q?GUwgZ03eLdVvoi1YK5rWecJr0p9J4pcpYHRX+l6JUPGqZmt7f2k4+0lAq2T+?=
 =?us-ascii?Q?7pOLJLUq6Bu6JqRyxCa9W0z1aidQaq4YoF2xRQdxolMxOCBopO8iDX0ab9ly?=
 =?us-ascii?Q?Yczwz2axeTUYRTJ6kIvkPE7EJMSs/nKPSaqY4wVh1UcnmPTVL8qG8gA1dyUj?=
 =?us-ascii?Q?VfuVpEDne+40I9L5UGtG8Bgk2jQ/B9kW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r7dqM6lsTSeknB540yJiUXVnzSiVPVuXR8eaeDuB856HBdmYUhOe5igdTe1k?=
 =?us-ascii?Q?0G/7L7Y/mRMAhtwrxYm0wbnz+XWtSNJmWY8qM3Bq5Ra9c+gUx20s8MMDj8fk?=
 =?us-ascii?Q?YXPuDtVKSy3WPq4TNzoCA7Bsvg9a429KotTQMlzT3OvEsCYEFTWwg8SDjGZc?=
 =?us-ascii?Q?oFKELxzyMcdl5gls+tDo9J8m/KDHpjcar69TnrkeKzYSEwwehqdQlgzSo1V8?=
 =?us-ascii?Q?K11PAm7wzEGJyOIi4XhZI6IfCGflB7J8BHWDVCGjeGVbzz7sytTwxVo2RXGa?=
 =?us-ascii?Q?2tPdd42FSYm8ssEyNz67OLIWo22M+pdPqg0IKqo81qyoBgk+BU0B7LhcoAVp?=
 =?us-ascii?Q?3us6fXz/PUw74SjqPqnFPdgWy8IPrOFaCzztJXm/jM7rR7USK/1PYDsG5hi0?=
 =?us-ascii?Q?phQSTaK0tyEVEV3YEWOr+iEO81vqZcn8JKc36InOUfVfZTseH8Q9svRuqFGN?=
 =?us-ascii?Q?RS3+4j5oro44UudOf/I+xy+lkif3OLDf5Mz04qa2qYo8Qt3NwDFDYPMogTj6?=
 =?us-ascii?Q?pMLN9Tep97IZXU/VtH3lgT0V9iUd85rYGg9FitQTLQdkH6UeJ8VSd2YM/0/F?=
 =?us-ascii?Q?um6l+xP8X1uvpMQ+VH4K5R16XMbAj09hKE8W1rlgCTdcfyR1I6wphoj1xLiT?=
 =?us-ascii?Q?u0SWLLa9hH7kE1hmfSMDcXOE+AwPbYuynm/jpJm9UCHYPSFVK5DpHDul9qX/?=
 =?us-ascii?Q?9yHnHtR0ixjz+LTV97Uq8gJgyoLtFHhe29bMgCtozTVNO1zRRS8EYOIilWol?=
 =?us-ascii?Q?jksDccs9WSL0K38GGMTlIN28fTANpFVDIrRZ2walWDnOV2IOmKNmMzFFrJyQ?=
 =?us-ascii?Q?KEEw49j7l/qFJBcDpMt2UFjri2XWoRw64cMRKOn6XKlnNTxlik/xw9d7swVz?=
 =?us-ascii?Q?YrkZKirr+71OzqfFBAClnU5tjVxH2wjj6lG9cwy+jcaxLefe/pIDIZb/vV0u?=
 =?us-ascii?Q?xaqXC7lmpuQTQgbicpWX383+9PIICbYccbvCrtVszKlzPXkg/7WouZ5FeBYp?=
 =?us-ascii?Q?NHXhEfeSJbMTKUGj6dOJuSWuKKnUSwm6EzlwA9HkYbOEWInZM+hgW6JSh47O?=
 =?us-ascii?Q?a3t+yRxIl7FSBwOUgigSTEzcYk11h3aXUnpZ7WwEmMQ03YraKYf1VAiWIiN+?=
 =?us-ascii?Q?1VwD+18icHurZdMp4BA+vkBOEZ2zC3NKPhvy6Axb6sFxgj0teE8/fuWk7ZMm?=
 =?us-ascii?Q?n6W3QkoBGWAx++qHgVe6e6D1hs5AMY7tmUWdYq8w8fsUsDOLAXbh7aHGtA9u?=
 =?us-ascii?Q?T+vftIp/nCJBXt8UDUbpYzRbKxfy+cuzgXGXzqCglHbChnRuvpUCMJkpSYnr?=
 =?us-ascii?Q?Pyakhv8mTzG0KgfeOQsM3dqNf7mR6APZ5yetIR5FeK+Rf94kkhjkJ4M7ciyZ?=
 =?us-ascii?Q?NZtbJQwJJI21u/LXZF4mbLNvDAOAaPz/lBZ7EZXpvn8BACypkywMM/569C8m?=
 =?us-ascii?Q?M0XXLERadXlCHIbWA2kAVebQ7V/ju9T4qtG5mJLTB+R2Zn7H8AemzaUnd7i2?=
 =?us-ascii?Q?02lNr75bCEjOwXlvXshq79R6NIXKzUtr4KnM4OQ9ZbVTMdRUVCMC8UYvfzys?=
 =?us-ascii?Q?HVxaGv74HWjn0aSnLZ9M82ASsyFmCvpngR+vm3dv761GRz8Repo7jiZSmHOo?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6vYP1cyn1mrS699rH6XGy293k+ErNOpRLhpO8HcbBjtUK0/WSmbiWvhNn8QiDcRIg2tqWaC7KD7nZCMA6dB2IMX7m7YJspmbAxR3uZgu90Ez4BBvEWKaaFSQXkq5JfuH4L95KGRsQ2hMkURB6ebn799kslXoiCakjH+1OCqtCkg0SVrh6Hzr0UUuddb4pbfNS24Q7Fo1T2ZASAw8eiGdVHMad4fV4aR1EdTi0IQYnT5dacU5PxiAEhDI6mQvDImjTFAHalY3wc6uAd3ybthgbzWXolvj+5QSqv9eNscKOxVgXDkQ6tCZDxFPxdOCP8ArMCc+6jmkjQmiN05Wu0tJ4DTBgDIkSKggj12+Xfq22Ag4xtvXA80+yXTqdiLpHnvX7uUdmbPYmzJup+Vx3WR/owu/lrfTKyZ3XvX2tzYE3EEa4W5eL5zfbAYHTdfWtRGvWDWSeFTzCLG2ZhPuV+nVnVmy3sfpPFD4gYjvbm2Zm6M/1dIyYouRN4xW2cXdi8SeFHWd26lMbVKPgn5+5ZvbRbPW8A1HAQBJpL3OPCV/KjjuwriAdZk9tCOZcD2wB5BGDrV6MO23XMg5MIOGOVDAvxlGRbimapshWCnkXhYmXqQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6ac15b-2c10-44d9-eff1-08de1e1865c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:12:07.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qmje3pdPYv/tIkmLdrl9uSSmfnLsx+eTmMp2smiBOuxAxuoqfakBkiIjxAlZPiX7stDIfm4SIWsf6DN9ADceXXvaOW7sFhrpWQJgwtgXxAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFADA73EAD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070133
X-Authority-Analysis: v=2.4 cv=VKTQXtPX c=1 sm=1 tr=0 ts=690e1a5c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=2aSAhcd0sNhBC1N7tyoA:9 cc=ntf awl=host:12101
X-Proofpoint-ORIG-GUID: C0S8oWIW3TeD_V2laclW4AEGeiAtAA7e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDExOCBTYWx0ZWRfX8wVQrKcT1PF/
 q+X+/ttFxIoKlme+LunlN1VsMhgoUMAfoz5PSN9jROji+kdYzfdglGw6ZLEoR6k08dZMwZF0qgl
 JQYVsDfRqLqgZFDVCMgl5gyx3i5kqowB/TC8f8QhZPaB1npyVsW4NdZYPHa6cFcdHtZfApM5wb7
 d1MtfyimznUJ5XuhHDaG/g9fzCLIpMH4FvEYya1tQOPsZ0cQ5oGE74Ro0XjvBoaEnfjNWiyGQ4c
 /XMf6DhF/GF4nT2z/5gik+81iDUZgqBl40u7NKuQhuHnTxOEr1OQH2jsNG9JJmuEIVnBYn6xEGf
 E2dg2T10awnLV6xadJ0Si8dbLCLrzEdA5iySrUWs0Txuq581UNMnI96Lf2vrA+0i+1K0a0RzWbZ
 5XVRYyFxA6Os3nu8V44G2jpBToEUxKiwjMHCCERw4TjhRTKrrmY=
X-Proofpoint-GUID: C0S8oWIW3TeD_V2laclW4AEGeiAtAA7e

Gather all the VMA flags whose presence implies that page tables must be
copied on fork into a single bitmap - VM_COPY_ON_FORK - and use this rather
than specifying individual flags in vma_needs_copy().

We also add VM_MAYBE_GUARD to this list, as it being set on a VMA implies
that there may be metadata contained in the page tables (that is - guard
markers) which would will not and cannot be propagated upon fork.

This was already being done manually previously in vma_needs_copy(), but
this makes it very explicit, alongside VM_PFNMAP, VM_MIXEDMAP and
VM_UFFD_WP all of which imply the same.

Note that VM_STICKY flags ought generally to be marked VM_COPY_ON_FORK too
- because equally a flag being VM_STICKY indicates that the VMA contains
metadat that is not propagated by being faulted in - i.e. that the VMA
metadata does not fully describe the VMA alone, and thus we must propagate
whatever metadata there is on a fork.

However, for maximum flexibility, we do not make this necessarily the case
here.

Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               | 26 ++++++++++++++++++++++++++
 mm/memory.c                      | 18 ++++--------------
 tools/testing/vma/vma_internal.h | 26 ++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6c1c459e9acb..7946d01e88ff 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -556,6 +556,32 @@ extern unsigned int kobjsize(const void *objp);
  */
 #define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
 
+/*
+ * Flags which should result in page tables being copied on fork. These are
+ * flags which indicate that the VMA maps page tables which cannot be
+ * reconsistuted upon page fault, so necessitate page table copying upon
+ *
+ * VM_PFNMAP / VM_MIXEDMAP - These contain kernel-mapped data which cannot be
+ *                           reasonably reconstructed on page fault.
+ *
+ *              VM_UFFD_WP - Encodes metadata about an installed uffd
+ *                           write protect handler, which cannot be
+ *                           reconstructed on page fault.
+ *
+ *                           We always copy pgtables when dst_vma has uffd-wp
+ *                           enabled even if it's file-backed
+ *                           (e.g. shmem). Because when uffd-wp is enabled,
+ *                           pgtable contains uffd-wp protection information,
+ *                           that's something we can't retrieve from page cache,
+ *                           and skip copying will lose those info.
+ *
+ *          VM_MAYBE_GUARD - Could contain page guard region markers which
+ *                           by design are a property of the page tables
+ *                           only and thus cannot be reconstructed on page
+ *                           fault.
+ */
+#define VM_COPY_ON_FORK (VM_PFNMAP | VM_MIXEDMAP | VM_UFFD_WP | VM_MAYBE_GUARD)
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
diff --git a/mm/memory.c b/mm/memory.c
index 334732ab6733..5828cfe9679f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1465,25 +1465,15 @@ copy_p4d_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 static bool
 vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
+	if (src_vma->vm_flags & VM_COPY_ON_FORK)
+		return true;
 	/*
-	 * Always copy pgtables when dst_vma has uffd-wp enabled even if it's
-	 * file-backed (e.g. shmem). Because when uffd-wp is enabled, pgtable
-	 * contains uffd-wp protection information, that's something we can't
-	 * retrieve from page cache, and skip copying will lose those info.
+	 * The presence of an anon_vma indicates an anonymous VMA has page
+	 * tables which naturally cannot be reconstituted on page fault.
 	 */
-	if (userfaultfd_wp(dst_vma))
-		return true;
-
-	if (src_vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
-		return true;
-
 	if (src_vma->anon_vma)
 		return true;
 
-	/* Guard regions have momdified page tables that require copying. */
-	if (src_vma->vm_flags & VM_MAYBE_GUARD)
-		return true;
-
 	/*
 	 * Don't copy ptes where a page fault will fill them correctly.  Fork
 	 * becomes much lighter when there are big shared or private readonly
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index a54990aa3009..9a0b2abb1a58 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -146,6 +146,32 @@ extern unsigned long dac_mmap_min_addr;
  */
 #define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
 
+/*
+ * Flags which should result in page tables being copied on fork. These are
+ * flags which indicate that the VMA maps page tables which cannot be
+ * reconsistuted upon page fault, so necessitate page table copying upon
+ *
+ * VM_PFNMAP / VM_MIXEDMAP - These contain kernel-mapped data which cannot be
+ *                           reasonably reconstructed on page fault.
+ *
+ *              VM_UFFD_WP - Encodes metadata about an installed uffd
+ *                           write protect handler, which cannot be
+ *                           reconstructed on page fault.
+ *
+ *                           We always copy pgtables when dst_vma has uffd-wp
+ *                           enabled even if it's file-backed
+ *                           (e.g. shmem). Because when uffd-wp is enabled,
+ *                           pgtable contains uffd-wp protection information,
+ *                           that's something we can't retrieve from page cache,
+ *                           and skip copying will lose those info.
+ *
+ *          VM_MAYBE_GUARD - Could contain page guard region markers which
+ *                           by design are a property of the page tables
+ *                           only and thus cannot be reconstructed on page
+ *                           fault.
+ */
+#define VM_COPY_ON_FORK (VM_PFNMAP | VM_MIXEDMAP | VM_UFFD_WP | VM_MAYBE_GUARD)
+
 #define FIRST_USER_ADDRESS	0UL
 #define USER_PGTABLES_CEILING	0UL
 
-- 
2.51.0


