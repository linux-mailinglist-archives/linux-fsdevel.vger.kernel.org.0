Return-Path: <linux-fsdevel+bounces-47756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE55FAA552A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 22:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0D307B4BE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 19:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805E027A45F;
	Wed, 30 Apr 2025 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DCCuqOwr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w3BQvLc2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A0427A47F;
	Wed, 30 Apr 2025 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043214; cv=fail; b=p7TjO0J5YmeHEOADUkkCxPbvd/j6djDBT02bg6G8hj0DZq23KI4WeqIgEPd8gXNfiLoI5H9FZbs2wMFbNPuwcCEZxlfSc6y9IQsaYKzq8ja4xipN8xByiEuAlZbu7aWnYr7SLtKWmkHNN+2RLGc0PscwYA2VDY92a1pfAPfJ/wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043214; c=relaxed/simple;
	bh=JXL35mgWehkuuRtdtKm7iUjNXSnwLSJ/4YD1vvsTp7U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S1ieH8bYFwadXZgzWYL4svggZuzlJlQYEg+cZjO1gGwH9qy3RLIZchS6OvYQ2n2G+5kfdhqXfaHTEQ/BTW6bqpe1KPpn5E6n0e+A3zIcRAp/fUuK8D6zOgSTdYV6Xz3dCmH7umN1B58Ldc7TfCEjudf0E8XSedpXTwV3BLo3t38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DCCuqOwr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w3BQvLc2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHtqw0014910;
	Wed, 30 Apr 2025 19:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=UTq+SEqqreKx6qnx
	u7QsV/akvEiqVob8VVdFb6zS0Fw=; b=DCCuqOwrVb8rVe/x3A/rmewBInUD8cF7
	C9+AO9jMjphhkeNeRL4ajpPwIIIcS/lTo4zOEMRlshwewsWwEebihnQBmFDB+faD
	qbPftU/yCS1Jf0T5Idyl4YJiW0w2tO0eT5qnhNKWrRSw858dQUAds63CMvpO9DOp
	s8uwZs3oaSWO0edhC9U6SM+0BAeGWeWE+Ik3rcbi5INkkUPRWOVf9PJ+nFZSKxpd
	dpDJFYjQQh1neqbh6Rt1yQhQSZaJNLRg3cYkpXt3RIU9gz3t4qYtrUOu9IYwrx6b
	LsvuaYsqJF3fk5L63yOTpfQ8o/PiHpl/DjSLORqPgnUCnFr0dMAnSg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukt1b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:59:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJHaiP023906;
	Wed, 30 Apr 2025 19:59:55 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010002.outbound.protection.outlook.com [40.93.6.2])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxj1fg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:59:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RB2L90ykg9ccswqDHkCPjltjS09Ucg1jNsFeqUG8Rkla4vbMIHPBE9dCv+40hC2p5pTDrq97sPOjt5UFlF+hCkyPrclgQZefE5tD7zeSJZ9GlhwmPQKPDPdO3Gywpyta8HgPVZAVx7I2jUT5TS25JJAsHGOWs1jPUhHhnXmOCQ14fmq9ou3TXDTSacLCqg1EpZy2HHqwHe/RksGmbV9MR5iKveUuI3iRrYuRKEoo3V/P6jiItlKxny1TcXtM0yds/kkeRAA1+6hB5jbigelaxjWxs/fA3Dm2Jy/wtDnH703LPObWr2fKHI0SegkwpR/gtkFKqc5tLadRDdGwgy6Kog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTq+SEqqreKx6qnxu7QsV/akvEiqVob8VVdFb6zS0Fw=;
 b=AIAl8pmAI3UcbJSgoALHqr2/YItxsDcP+kM/wXcsirRtEEEb4s8BybYEs5iuIisNzccOVmWxPr7Tk5tF2zttMXuRa/uJGJBI9/VBWlXI0MtBDvYCmI9k3hViucho7U1/z37utfa5Hpz56XxAosBOONLWpdToH+3mH+4zDiJWVdlatG0/9/XzR5t/zbd9c+utW8OMwPXObYq+L+1TxsQxxloK7Zl51Il0hDa/xSRXCXeyjukEadprl0/u0cmeqYTWKVHenMRpytSKH3fdJy0B9VqU2cj+X4fwyCspSOdbP17o52nfu7UWjjROOn3lXASFsnUY4BETLzZMxJdGgUxKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTq+SEqqreKx6qnxu7QsV/akvEiqVob8VVdFb6zS0Fw=;
 b=w3BQvLc2C43IXG520uUGffQOpXgmFbp5lE/QWCxYJ1wh5XIxN9uoxEH72l/1hxDycdTE05jLjHM4B5ZhFCYkzcigqkoHwoulxkLF4ZBNDY64n+1/RaNgYCxWUyCNItEj6Ugx5Iqu57hgVSmnA0xL4wAVvaXGUvut2R24Gqqy9OU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 19:59:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 19:59:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH 0/3] eliminate mmap() retry merge, add .mmap_proto hook
Date: Wed, 30 Apr 2025 20:59:34 +0100
Message-ID: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e853fa-209c-48ac-a493-08dd882191b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7bBHfVAcKIgUlCFGTMx52ioweZc6ei/JBGuQ4elJQpE8KmnODzFu9jL0EtC1?=
 =?us-ascii?Q?3W0s58OA2VJfb2dcvglmgcTY3u8ePbdIOwTFwauVGphFDQbvasNm65gewMzE?=
 =?us-ascii?Q?Yb9H9U16hDm3kRtkiI7vdcPEQm7Js/zyVk+6GT/MXA6ZVmQUigUiUH8Svvit?=
 =?us-ascii?Q?0y+aRif+TxaF5LgjHZeF7vyrufzTp9XwATl7FmJ3g2FYBYeOXcp3wxM99VVK?=
 =?us-ascii?Q?VMVOWWrAgN2jq5LdW1SqgWq7HjJmQS12BWCjZiHjc+SRAasBmCo6UsINBKxI?=
 =?us-ascii?Q?qJxzd21cFmaevwlmtm/SVu5Wr42xxUzwVa/70nE2pkY1JHyZ51YeNgVUdzQj?=
 =?us-ascii?Q?sNdOZ00wP8XAx8FqXHEbJIgdfH6bN/bqb0oFwuaoJ39PhjvmKK1aDLUgRQtP?=
 =?us-ascii?Q?FxEDb+mjbS/oC9v2D0+5M4u3ehrO0lpWywkibe4fG9MuhNC07pKIWAkN9sK7?=
 =?us-ascii?Q?OfUUGzL8FF9PkoUnJhi8gxcGqL1ON9VipiVAXoIdUypIiXaDyL9Q+k3m8u0R?=
 =?us-ascii?Q?uDc+6D+OksdfXHG/l7FdJfn2s3g5U+rp3McPRGjfO4eT+uoUvAIJRFXc2IjD?=
 =?us-ascii?Q?ylNdWkCtV92Woe191+UtifLKunQN/vK8Y7BPpcwQiyuT9LY7bC6PtnRRtb/a?=
 =?us-ascii?Q?IH0HMgGLQX5UpBU50cp+5puaaSP/bFV0GZH9GDdnLjNxa3CeeQA1wFOdk0a3?=
 =?us-ascii?Q?Muty605htQttGdEIGwuz4qNlhVmziMXvb69c+/iqN1ULexsjkPken4tQPdR9?=
 =?us-ascii?Q?AtfCNq30IUacHQIKZd7W7wFM6hDnnx/C7b+RZPL4kawl5QyH386HOznWPVLw?=
 =?us-ascii?Q?J+LxjHo7JeL4swfcz9KdztxteEDU4IWSIH3j5jJbei931WMfR/fLdUekX+lv?=
 =?us-ascii?Q?UUCIpH/D/+mLX7wf+31QwQXXjwjoOJGpVSEDxQSHNYBkzVAom63CUyQYIpc4?=
 =?us-ascii?Q?WbocozuibVTKCrCG84X+cBiNPgFtp2XOGEuUXAIA9VJMBISftWBf+sjXoAmX?=
 =?us-ascii?Q?wCf9dXBiJOAEQWRrRfrXoOhvD1VLFGkm5H46tsDvKz59etTzNb8DDqadGvVZ?=
 =?us-ascii?Q?bMAfhg2STLuk/OLpA/tX8zKjLWpXNr7lOYeE5LAqFDlWKPho2k0HW9KULjLr?=
 =?us-ascii?Q?5L/zQfK4EScgLEcdeEe/8KLyECJHYe2zD0fra5ewWI0WKYxlVjR87PWzB+QD?=
 =?us-ascii?Q?iv8iiZsFdCDwBu2u0/DqzT3ajEgO220fp/3j9rRT9BcyDwv+VkeIarxr3ZmW?=
 =?us-ascii?Q?VpHCghviMouCFe2FILaLlMfsEygcktZ4ZsPC0M4E4yIn41Dm6eZ8gLUSUtEk?=
 =?us-ascii?Q?6DQMRFsvGawmX3V01kr0qvDSvzjmPEkqPmoh7J1eT1frkqacSn/9e/4VqXwW?=
 =?us-ascii?Q?Q+uLNMYg6Mrs5mgpHaDfOgQVgPHo4xlKV46764RuoITWHzLk/1F0T1dsooFY?=
 =?us-ascii?Q?29zrAtWQBp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fO0mP8+FrJg2ZFy9aZUfmU1Go+t4qbKkShJPkzZOBsbMREB4q7tE7Z3j72uc?=
 =?us-ascii?Q?8M8z7K3YM9HU/yJ46wSwQ2g0gUmeja9+phI7DE/+w6wir4S6qd0T93GeEQAO?=
 =?us-ascii?Q?CKI2eUPG4EijT6uh4CUKmJmnqXrjP2ceFWHn1Dmz1XI+H2G0gxD9GHaNV7dQ?=
 =?us-ascii?Q?JfkqGOSbqUrU2vYkls93csy9NnO1zPO2LGCO5hIVa7B+dOp3AdIhd5RzRYbt?=
 =?us-ascii?Q?K8r0FlJaZopZqFOk3enQvB58enfHsxxFx61MxJuD3MQ0yHcsIplOOwUP4n0x?=
 =?us-ascii?Q?0cY/AdXGjnXbSr4h84b6Uhmz3V7n6vhsSQSmZIcHKJpJX8vPHInWl36pfAq7?=
 =?us-ascii?Q?ULbZ7yTV724dGKq4HHM0eG0fe7Bkk0x2VMgHrP0n5+LA+dkNtzmpB19/MinZ?=
 =?us-ascii?Q?Y/QwSZJlaR1IUUs86shHBvGyN0j1xqpTZi3Mr7uc3FiQG52KYS3ulStoX6pu?=
 =?us-ascii?Q?vdaRM1qOmq/PUQcZVBoJ8dhc4JUZMp2ZdnAX8gBWFjYObYgflQkdZQ7EYU03?=
 =?us-ascii?Q?5eSC34C2aSyd95CUlo171etQIDpbgzAZcabTf7Gw9CWrxr/26o51SaoorThF?=
 =?us-ascii?Q?8/pHbQpLtnp3B5iIMbfiZ4VDj/0bQ9M9+W9msb62iE2L8nqF6xO9ntozM7Nc?=
 =?us-ascii?Q?AzfiDSYbBozivMSQJVwG2MA8WkdgwXu+lBLptjZrk6+Orj13fX6YJmTRP3AD?=
 =?us-ascii?Q?Wi2cOukWKvouT0hSh+0IsBGQyI+IydPKkDaoLUUHfWnT+VqKbhDoJWYuaYm1?=
 =?us-ascii?Q?BsAg2fL6dhSzYaVR2FhJks4mz6VOCS46QpZmVyaAfm8wl1RlNHtTw35wSdsO?=
 =?us-ascii?Q?azaxAL4NwBPTPMcJi+Te97lDkREJqSwiiDXCswf7TYUY3BbUVhh6JeWfIxBw?=
 =?us-ascii?Q?uiCKHoB00iJbQKAYvRKgNIHqgtjQIUkUKgG1mjbv0eTBtJjLjmqDJNuCf9yK?=
 =?us-ascii?Q?qe+pLybqv84/kJ0hBDo2jOJmCgfQ3L8RzKIHJSF5K1sFUTNl/cF+XVqIOgrr?=
 =?us-ascii?Q?DkoykMVFcVWF8P8tVzo4GWxjUzVI+8pahxL4tCOT56jc2mWC5KNPYg+XL2Ur?=
 =?us-ascii?Q?JWPadI9miL6rYgijEY5F5ZoR4PpqXVbtExbUrCmrhTpXISt7bjQ0zvLhnSc/?=
 =?us-ascii?Q?I37BgcUP1Fkav2eKYFILKQexKmV/9+jJsQ46khP+fTTOD+8HkkrODlFMckTu?=
 =?us-ascii?Q?KIdlQTqL4998bsAj1nWm+wwAyVbbtfon8G6G7Wzpjs3QRcp7J0i6WP9AdAuT?=
 =?us-ascii?Q?7DFBkkGLvPHxuASpdHKb0gj/thSkhFp7B6JUwQq9INWqS1w4LkKdzeZIFE+X?=
 =?us-ascii?Q?oB104rzPTk7Eb8r20PzQHy2cU/MSAjFZN17k04cjDrCNFUR8GvoWnLBEGtnV?=
 =?us-ascii?Q?DEc7Y+Loh5SR5J4qWvhPSJshHT4RdFwW/swgTKYkdqtJKnEJi9URYAnx0Lgu?=
 =?us-ascii?Q?mKqw+7kgRvL3Q5XUVFqNHgIbR71TalKcAAXiD5pxAIpkKB36r3QT2SpK8NEt?=
 =?us-ascii?Q?oRo48lBihRYTNKA9Xa9DvshSCuFElSO77t2bcvzGndq+jm6mtHM2rlix8dVj?=
 =?us-ascii?Q?bYY9ebRxKHLhVLA+YJ6qOp+Z0u+XbNcBhscw40XxMhMKAfl5WR9p11lNyyC+?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tJ2pWO/kH/qY6O5ld5//lJVyAlJPJeFEexWYAAUJ/c7Uc4ACPewUdyOtz/SXKC49YszcS0eoyvLdnGEH3wP3SHjLziXtR+VtK9zRF7YCY/H22ig3uURtAKv2QFa9PCRHki9FJUm7gNKruf5OIZ+ee0mV8MPqg3MLNVbis5IfxvUOLs3NWR2h35WxkIhUBuVXNFAYuM8eFmq2V4ws3UG4x2jXV2RbEexaW7Gp55oBEZPNn0tNbtAmO2n7luPscxT0nJge3sFwOXNXhs7nU5zuczkiAx0a25Xkf5L7J8EnZSVEShdIlqwvWZDGoaBzPL88YGUclVTh/JIJa1j0mTC+oI12W8eGmICsjuVusYLXXMEKaernZ9twqQk5oYChqAi7jynY4J31PXVp3IR6TxjLcXwAQf+4NrtByO4MDyafczFYmvWp134SlwS0hYX/NL4b0IHefgNG1HzujCiIQ5cN0IuCLu4l4sMn1DEZNUjO/W4NBwt0YVgD86efD/1kYWGFc/dzSZAu7bD2qdXWbMZV2owvKT+9Khe30IcMha3UJZfSy6+XPZwc/G4nKX9d/oJwxdqtFB2xByyRaL/67Z8SPRzt66Wb0IhLzmHGohpiJOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e853fa-209c-48ac-a493-08dd882191b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:59:51.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhryTHsZ1xniEkEbBMNUpB4phSUASo1yPYDiIa6us1uGKK7xAjArvfwvWrH20ep7Uxq+qDZdknBGMKtREkLTfwL/ola+7txN/wB7awOe+I0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NiBTYWx0ZWRfX+hBHkULurMb/ LlYLGXWk+7y2bIRb9BnUydMVq1pqSYCq/KphlCvHci/HnH4McWRmhDPAtIkK0vWQxl+29QC5FBJ B3gXWFpKYJFeKYAp646+ndrld2IOqK+TaLsLj+Fcv0b8R9/I4WTxgfhNcKipATJL5qhanLt9A51
 DQj1ic1K60XID0iEX5Q+wUTj6NMSFCobnasEdv5qNWOy4kG85staOunUavuaEe95d0DYX/lMcA1 sskWj2+UtVk1zUbLpsE12LM1tC9LHqFyqOjuMXZoid2CyTioAF8DmR2QEAHhR4OG80x72Voe5dw PUjDoogWmxnqwKhLCBOh/pfWJ9SjIkLPZIAnMJZbNrUz3hIufAigtNxAoXLnZAKN8tteWswljQW
 pPEFRFrSZNSu2AGdXXINHVuwT0+YwVRd6b6BpT73Li1TMnXkmZKYuvleWBfkF+H5yNzPBHn7
X-Proofpoint-GUID: zenVxERrVYJosscQa3DoFmYliNGT8TCE
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=6812813c b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=oEByBfoX5-KuNZ1sLPUA:9 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: zenVxERrVYJosscQa3DoFmYliNGT8TCE

During the mmap() of a file-backed mapping, we invoke the underlying
driver's f_op->mmap() callback in order to perform driver/file system
initialisation of the underlying VMA.

This has been a source of issues in the past, including a significant
security concern relating to unwinding of error state discovered by Jann
Horn, as fixed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
error path behaviour") which performed the recent, significant, rework of
mmap() as a whole.

However, we have had a fly in the ointment remain - drivers have a great
deal of freedom in the .mmap() hook to manipulate VMA state (as well as
page table state).

This can be problematic, as we can no longer reason sensibly about VMA
state once the call is complete (the ability to do - anything - here does
rather interfere with that).

In addition, callers may choose to do odd or unusual things which might
interfere with subsequent steps in the mmap() process, and it may do so and
then raise an error, requiring very careful unwinding of state about which
we can make no assumptions.

Rather than providing such an open-ended interface, this series provides an
alternative, far more restrictive one - we expose a whitelist of fields
which can be adjusted by the driver, along with immutable state upon which
the driver can make such decisions:

struct vma_proto {
	/* Immutable state. */
	struct mm_struct *mm;
	unsigned long start;
	unsigned long end;

	/* Mutable fields. Populated with initial state. */
	pgoff_t pgoff;
	struct file *file;
	vm_flags_t flags;
	pgprot_t page_prot;

	/* Write-only fields. */
	const struct vm_operations_struct *vm_ops;
	void *private_data;
};

The mmap logic then updates the state used to either merge with a VMA or
establish a new VMA based upon this logic.

This is achieved via new f_op hook .vma_proto(), which is, importantly,
invoked very early on in the mmap() process.

If an error arises, we can very simply abort the operation with very little
unwinding of state required.

The existing logic contains another, related, peccadillo - since the
.mmap() callback might do anything, it may also cause a previously
unmergeable VMA to become mergeable with adjacent VMAs.

Right now the logic will retry a merge like this only if the driver changes
VMA flags, and changes them in such a way that a merge might succeed (that
is, the flags are not 'special', that is do not contain any of the flags
specified in VM_SPECIAL).

This has been the source of a great deal of pain for a while - it is hard
to reason about an .mmap() callback that might do - anything - but it's
also hard to reason about setting up a VMA and writing to the maple tree,
only to do it again utilising a great deal of shared state.

Since .mmap_proto() sets fields before the first merge is even attempted,
the use of this callback obviates the need for this retry merge logic.

A driver can specify either .mmap_proto(), .mmap() or both. This provides
maximum flexibility.

In researching this change, I examined every .mmap() callback, and
discovered only a very few that set VMA state in such a way that a. the VMA
flags changed and b. this would be mergeable.

In the majority of cases, it turns out that drivers are mapping kernel
memory and thus ultimately set VM_PFNMAP, VM_MIXEDMAP, or other unmergeable
VM_SPECIAL flags.

Of those that remain I identified a number of cases which are only
applicable in DAX, setting the VM_HUGEPAGE flag:

* dax_mmap()
* erofs_file_mmap()
* ext4_file_mmap()
* xfs_file_mmap()

For this remerge to not occur and to impact users, each of these cases
would require a user to mmap() files using DAX, in parts, immediately
adjacent to one another.

This is a very unlikely usecase and so it does not appear to be worthwhile
to adjust this functionality accordingly.

We can, however, very quickly do so if needed by simply adding an
.mmap_proto() hook to these as required.

There are two further non-DAX cases I idenitfied:

* orangefs_file_mmap() - Clears VM_RAND_READ if set, replacing with
  VM_SEQ_READ.
* usb_stream_hwdep_mmap() - Sets VM_DONTDUMP.

Both of these cases again seem very unlikely to be mmap()'d immediately
adjacent to one another in a fashion that would result in a merge.

Finally, we are left with a viable case:

* secretmem_mmap() - Set VM_LOCKED, VM_DONTDUMP.

This is viable enough that the mm selftests trigger the logic as a matter
of course. Therefore, this series replace the .secretmem_mmap() hook with
.secret_mmap_proto().

Lorenzo Stoakes (3):
  mm: introduce new .mmap_proto() f_op callback
  mm: secretmem: convert to .mmap_proto() hook
  mm/vma: remove mmap() retry merge

 include/linux/fs.h               |  7 +++
 include/linux/mm_types.h         | 24 ++++++++
 mm/memory.c                      |  3 +-
 mm/mmap.c                        |  2 +-
 mm/secretmem.c                   | 14 ++---
 mm/vma.c                         | 99 +++++++++++++++++++++++++++-----
 tools/testing/vma/vma_internal.h | 38 ++++++++++++
 7 files changed, 164 insertions(+), 23 deletions(-)

-- 
2.49.0


