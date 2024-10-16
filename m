Return-Path: <linux-fsdevel+bounces-32090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CE59A0676
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AAF288538
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F2E2071F7;
	Wed, 16 Oct 2024 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KM4ZiaME";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gwRFLkRt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4404205142;
	Wed, 16 Oct 2024 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073051; cv=fail; b=PQX6THqt7CfCt9FImzh9gBq/KqtROnUH7KbKVFUraxdpXOZmFqnp5b5MBuIqODArRwWO672SSa17Ay1iwtmjJcslMjWvWDt0lxkQTBmTN0gi+BH+r3IviJJWJjPjnki3KmsltatrqJDQVAjVnJK7ia5v84PqXLIFragWRFhps0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073051; c=relaxed/simple;
	bh=7sYTQfRJi+Pg/3bmTlcxn4KenjXJ7ZFkDJthE1pnCSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mPO9rapUoDNJf/+V+WDSXQsLKMYehI0O53BNVQFhluAmWvMYalbM0sP2xdZU0WkCtrjzBoNCj1/+XVL5Oayovb37qrHorHqtzTFSA7oXdsqHi6cVO7TrN+5ujnnK+kqw/o2Xt/6tFOHyBGniYQ/iYyp9dfKB9yU7pGKKIhjlV9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KM4ZiaME; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gwRFLkRt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9tdup012975;
	Wed, 16 Oct 2024 10:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=P4QkuKPgfQips2jxDXpkAE4pKRyxdOB0HWwzFWFB5MU=; b=
	KM4ZiaME9WscugK5yt4+kmwNdIaWuipzzz3oGxmkMb+LNG43/U2zTax6u9GuSUUe
	U3XSP/UIbA50t6uCSEHIXPfn42QKZLrayJAPhd/pCffgFWZUNizJl+Fy1Eab4ZgH
	N8B4Fq7a/HTyGLnyJGC65zUrup1YIeAnvao++FIGBhCNjqsFZLsM3Un3Q9SEO8Jp
	f1+5o0zyKPumhHJy4cZWiRzRuNqLikVx4StFu7WfCAxZoYCZ0QjdGRRKzaEpyLf5
	XGuPbN812bS6aMCmMDO0UUlIxNEldR7onxlsFdw4wzo4Mab5WHAKZ5lcC7nVTvY8
	8KyP4k4VTBSVLPPTIdp7vA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2kfaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:03:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9ANib019471;
	Wed, 16 Oct 2024 10:03:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8mrkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:03:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFOnMvMHkrlg8bMxYCnr9/Oice9Q5Jjy2Dz05Yhd93X8FW+iVp46uZmwVfQPdTegfG01l6mhmBKeUOTtOHmKmPMoMdCraHHOQWAJlIejJ3BNBOXqb49Jv2JdxaHE+oKsjBc0RCqhXLBL5wv99Caw8GggdPrXyurf64wWvGF8ZjskK3aKChojONnhQ/Ur2YloqWSAEeHssRrnGe0W0LEb7x9M0TgyAd6NoIU09di7efHL40MPUd0PWqTMFHwziVaX17ayQQQhKk5/jJ7yOIO3Z8q/ZFMO0CCby1YGdXHByVvKg0Y9M87jBPuRgr/cOWi+EWr1dcLxrBHU4fZQTNdItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4QkuKPgfQips2jxDXpkAE4pKRyxdOB0HWwzFWFB5MU=;
 b=ZumPSgfSK/F4K4f+XE6dsxCNkyTlvBBTpBSh9lc1RwvsX8ISAyglWobyB6qEVnRdYEjaY78GY6sJ3+6qOHuz+bK7e0wRBiU2HA7n3JwCJXMHP1kCRe8kUty/ERGAFQiSeFPknjvqTNnEXDIxHJqMeYRUn7qmrONYbES3hYsVscs981AbQFbXaO05lDkq5yESJ71OyoC01x1oszeXVm9xBRCHPpICqDAuY0GBxe5kO2u22vKSA6v1Ik+4RsXOYGKRTfdLMOe7nxwNXvwCpawmXwOUzYXA1j3+J33Ddk8raZMYnS1MKy8AmFrxz2/vltryCiq5Ndmi9SmU2QK1EgDNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4QkuKPgfQips2jxDXpkAE4pKRyxdOB0HWwzFWFB5MU=;
 b=gwRFLkRtq/Kwgv/xt9rcftPwhIih8UXIDejdni5pU0ZwTFznp4paYqdOlUs9WS4+pUexNiDjsdibsMbHy5IdzDQ84Ll30bYo54+KcS4chdsjUh83y22hnAn405ovJzd18wZ9ayiJ51tU2VakpQivE9Kfo8ef305tbNKIaJfgVpo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 10:03:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:03:50 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 3/8] block: Add bdev atomic write limits helpers
Date: Wed, 16 Oct 2024 10:03:20 +0000
Message-Id: <20241016100325.3534494-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241016100325.3534494-1-john.g.garry@oracle.com>
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a85e4e-0c15-4da4-263f-08dcedc9d547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I8Ko78psgNHvMe6PbuexMJS77DT1S4WKdbQm5YNWUAJYyhQaMKOOBnPr6vYK?=
 =?us-ascii?Q?6m41Q5PSLc0jnyJLUOGRGYMRs6zvIhxM2pIvTBgGNLkuwkJeVh1nRPfC3qey?=
 =?us-ascii?Q?LrUTnNHyXjzXLRPOjYIkddnekwtYFuxab4QoDbHuGAeiuLcrVtCCK8ioX4nn?=
 =?us-ascii?Q?ckPtVhfdYwegnkGM5HnkyXjlDlQP/M8zZvOmUqEi6SJTxcEM722/VX+QZbEj?=
 =?us-ascii?Q?V3+By8CIbkB7lkGeXlaRphAeiDghfKzXRC2tfYzfwKX6UCq50WQFhfeLV3xm?=
 =?us-ascii?Q?HacPY0J4T/0/Ka19uBTLfAijvUjPH5YJWADWyKhIruAzdYNPu6FwOq5BLj0o?=
 =?us-ascii?Q?c4ec16iG36vHvDXZhyv8XdxxZrweVFjfnqObZn36BrUfFmjJg0K+qnjcuo22?=
 =?us-ascii?Q?q62+bjxmrfwK/vdxXUGBldL/ru6X5KvCIFi+4FFi8axAVfRYHIcgdI+cFxkP?=
 =?us-ascii?Q?VQMetFreRvNDbkNQl6xf98Bp4xPIsy5dxq+4vtRYuUVU7GG0TDbbDlko8xh2?=
 =?us-ascii?Q?EfEDBdt7YixpJ8+7fIZqlwnog8xXpwLZoaDECghU4W7uI+F/7jN3AOPQSPPJ?=
 =?us-ascii?Q?kKK9oBlsvsr8/7xmbx3ICKoCKqj2hVgP8SFS4FpMJy0HiUzhG2OJyK87ZFFb?=
 =?us-ascii?Q?yGxhAikm/eVTn06WQ58CDnkx8uKdpeuM3TSKQLLL6Ziyku6BFL8gp5wgxEKS?=
 =?us-ascii?Q?9Ge5XezSORDb6P0OgbkFtqRyLOB6DY48TBHqEZrOdshXcwnfeJ12UNkjfcMW?=
 =?us-ascii?Q?q3Ro7xVouRua4Q5D2NQQELMQaa2n4c3cK333U7miH9tq8FmE5sUhkT6oGy4/?=
 =?us-ascii?Q?ddMYdhv3xhE2fH5vpU+BWCuo1D4blrcVRKVPrscio4MLtgv7RzHs7EMcrfjG?=
 =?us-ascii?Q?JHsnkTjbOE2lMws/ZnTC7EyR39XEj8URrT1nulgkdCdhWu7rbDqcxrKzsyr/?=
 =?us-ascii?Q?1cmnjPsLQ35fEgwGqt145cBmRkrIyuwLY0GiXaFWWCFSg7IMddRuaDm6fPLA?=
 =?us-ascii?Q?Dr/IBv4TeIZXwqXRgK8cZ0qX9oIVuqZYBmW3qSkQIYoqvxl7jvZN7zFQB1cf?=
 =?us-ascii?Q?CO58yF9nk6kQG4R5A0UbkOqqHLH/OH/BZmlLupmDKvtHAyj+Jt2vFfDG3Qy4?=
 =?us-ascii?Q?GjDZTwtD7EeSjq7nnfWBNCyTO9oRCQ+q1Cg5kzdHPJMRo1k2qCpYmIdVm5TO?=
 =?us-ascii?Q?l7Qapx/kHxHegbc+cqqF+YsUZ1Vh/m5wXXdQ1HU8Eb3wehXMDJUkKH8+iGK7?=
 =?us-ascii?Q?QXaNnwW33410jrbG+raO8Pn604OIOhwFsb9HJznAqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?opFVRvb1QpVTkDbFW3BXg+48ysIQXQlkeTg6JgXfTLsPviedDR4MvIgJhZFW?=
 =?us-ascii?Q?/OA2RZqAzM3hzD67Q5cCKY513TpTPTX3xSI4bL+KBu0qPY+r9B++K+LFS+yY?=
 =?us-ascii?Q?iq1nOWx8FFOSOk3mU8TRxdk4bLzGWOfkeFpOGjGu5r9IbmJRokR2+51J6QhT?=
 =?us-ascii?Q?650z+jY4/v7LzXu/2niywNRTb+rAtRDAQ1+3OFQEOzxdl+lFxh9HYRz/Fmg2?=
 =?us-ascii?Q?YJHp+3qFAF/gGUX+kX9kRdFl6WANdZ53+EHRTYDbICeocFGcNV5vEx5Z8gUH?=
 =?us-ascii?Q?1qZ0dRy/+7tfqJcYhsd3GQFvJd2aIuJ/P1dFywiDX8Q0HquHCipybnr6IaKf?=
 =?us-ascii?Q?xi+1xRMNeJmXGJHnS/6ll3+aMQA98F4Z/CHL5WJxoe0hvcY6FadydLQF/1ks?=
 =?us-ascii?Q?bnH9t256DXj9v/YmZxcEB+tSi0ljcq/vliekITkCR55sKatp2Upjs7gNd5kg?=
 =?us-ascii?Q?4NkB6xW2VolygWkKxGJ5okHmCCLzBdDpMtimUuEnU9nejs1PatMKDwgOwZtx?=
 =?us-ascii?Q?6uAGy9Js6NL06NwRPcCZyLlJ4rYerEWz4G3A9k1PGn41vCr1mA52oE0HpFb0?=
 =?us-ascii?Q?sulaXwAIMJpz8zxii8/VMyqvpAVew5waCN0rjezdmL3Nwh9LbMa2SDPJoAjj?=
 =?us-ascii?Q?+ru6MEHiqqc7A/cu3oHmJ0gtFu4m/2Z2nKJ37A9lVpJ8HylwBWXEBUDWKC7i?=
 =?us-ascii?Q?l83AoydAA0v1SprbElxjIxVNI5P/vWJIjPBx2uv0tJDf9Zg/FQGfJwfPWxTC?=
 =?us-ascii?Q?KPdXylkU2q3HYDd4bC9iOg8AK7iKOI0MY6wZJiyNF5IYcq7IiNnJ8HDPs55H?=
 =?us-ascii?Q?P8XNGtFDiHAlxpGdpejhw31z6BjVDTnt2365gTNsu7rLIHiNVvbJiini1bHA?=
 =?us-ascii?Q?R1k64faYiG8S3jeQhozXE0IIKjwYnVp13x/EYEb1HtWoaofyupyreqCAgIFz?=
 =?us-ascii?Q?zZCieqLjcWNCH/YzBktik6/khqusbVCzRkbD6pGTLQK75GSVmR1fGb2zbRzV?=
 =?us-ascii?Q?IIL2DLSEXFz+vnHIWzvVYVUaF2D9VtCIP2xTkiJLwUUy5PuB7ryExx8223C9?=
 =?us-ascii?Q?tH9g+GBxGvfDrLdR/QH0rKACN5gNiyACvRSqUXt5Zc2zmvgoz8l2nmqQszAb?=
 =?us-ascii?Q?zJja7t/j8MMNO9d29wBXf/6PeU1pHsnMmikZa8d7YZ7+ePbYDBMTzEwQCXl8?=
 =?us-ascii?Q?/kdIM0HHMBIYlEwpFHDnd4r45ByX0k5fQ1rNw8ITD5Mtywks5mxel7TwU3/o?=
 =?us-ascii?Q?DdtmdpLgZC5IT8prfGEvzobi8v9vtSL6G2nBSz9UqS5LkscQPjC+1rwRuPR/?=
 =?us-ascii?Q?5n5tKm2G4JdH8854q2UAdDOMRhfC/lCu024tztI7nCBcqGRYENZnOzJCgxN9?=
 =?us-ascii?Q?z8ZsIyjqZT0mSpS7MEQrvM+zXWTNz6bL+JURlcBJntsgTjzpI/tbI927m1kP?=
 =?us-ascii?Q?fiQgzvxI9jNB+x9lo0C8fek8JfC7+kWJBnHQhGRH0L9MUqH86RadKSX9X13P?=
 =?us-ascii?Q?QCagE3X1a3AxtLvzAjbAZzhgtX4gZcs8evBQgm1VKUZXZMDABpiLf+xqnr6D?=
 =?us-ascii?Q?biHWxAo7eJ44DmHNi1ohO+MTdnNMd0GnSwUXCgQpg2OPskh+40PGm8oqE7Yq?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YuzwCmIRr/xn4+Fq7h/heYdPcLJJrVBi/PcGyPNVk7iIuvy9Ia8R3nl0OedimIw92UnGsXGB1Qwp5Q6s1mF+McGQjoeRQoCbfocW07urd1W7HnGtwS6/Hwjpe18ICeMqLAbQrzYv6gAwRV6aE3crSou/Hg+Tc9+NBdhkcShui0I5mP+6U1P8IMie5UXKAte6+jM/2ERfH6+8tedv/pKVbqPjG7Fle3v7raOpsoIdGr5TBKs30wmTb+ezSxNr4yNeyGhOo7LpZM+u4ffYD7wFSHpMw4XRTPKHrLDoyTWxvwFrvCpsPpqVzxp/9aKWfEAOz1n1wHK9EoCKKMroWqcuMcXsWeLwrz/aJsoRyq6rzKN5CB3zG2MDBiO2vN8+cQzRxn2+NXOM4N2gM0oxwnDzbKYmJCBEjfc+Nlz5EM9kdG5Kg2hmVm0rqIBf5P/jnG414uYgyAIq+ZRYxvd6gj34BkYKcaHpOdnjcD2FQVsQTcBQ7HAzNu8AL8RgfgUk0wO/6pk2lmzlujfSwMNcgHZ7q5k0O7XM7t39+YMCq6TFPhp+tvrg2Ou3bNaB7D49UBq4efftMkwpjyDAjS6NGw+fCxtwLeNdmX/k1GY+V9/PyV8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a85e4e-0c15-4da4-263f-08dcedc9d547
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:03:50.4510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Akd9cdv/eOhXaAfoZDEthn5fz/yd663aSlRsXu+2NZBmnflSoC+XpchlcCwJLmBaENmv93UxLw6N/95noL1+Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_07,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160062
X-Proofpoint-GUID: 4RxZMyiGHPzuUDMKHB88NsSp5zUj50vM
X-Proofpoint-ORIG-GUID: 4RxZMyiGHPzuUDMKHB88NsSp5zUj50vM

Add helpers to get atomic write limits for a bdev, so that we don't access
request_queue helpers outside the block layer.

We check if the bdev can actually atomic write in these helpers, so we
can avoid users missing using this check.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blkdev.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50c3b959da28..c2cc3c146d74 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1674,6 +1674,22 @@ static inline bool bdev_can_atomic_write(struct block_device *bdev)
 	return true;
 }
 
+static inline unsigned int
+bdev_atomic_write_unit_min_bytes(struct block_device *bdev)
+{
+	if (!bdev_can_atomic_write(bdev))
+		return 0;
+	return queue_atomic_write_unit_min_bytes(bdev_get_queue(bdev));
+}
+
+static inline unsigned int
+bdev_atomic_write_unit_max_bytes(struct block_device *bdev)
+{
+	if (!bdev_can_atomic_write(bdev))
+		return 0;
+	return queue_atomic_write_unit_max_bytes(bdev_get_queue(bdev));
+}
+
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
 
 #endif /* _LINUX_BLKDEV_H */
-- 
2.31.1


