Return-Path: <linux-fsdevel+bounces-23162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B862D927DD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F341F238C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 19:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E797013F456;
	Thu,  4 Jul 2024 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cUG8nPvV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IZcdKzoL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D111422CC;
	Thu,  4 Jul 2024 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121330; cv=fail; b=b+4Ay1i5IPeP4Tx5u6+hZm96gmNfMCIGpqS8XQ7zcDeCITaQqcqm6Mk9yLmiORn81umirARSReMdmHpAL0dRr4GlOjRhmlo0mBnv3A2f+O5MzGAEFMFfsFQkCNtXDhLDpILejhyi6Z5v+k3SqCpokSNMBfY5vHkZKvvn7QWeN5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121330; c=relaxed/simple;
	bh=+xNNO+qW1A4LO7HmWKRpojOx9d+hjEH16PBAA6ekd+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DCytm1FaEZNUBErH7q7KhVoF+lvZV1+TwxI0zFaro2AiHZBTUQ7H+Nym1cYGakVXFuuQtEzc5KXqB+Yw7zh8s+nTF48bjwysL2XSKDvYbVuQYwOjuokng9WyyrMuqQLbzcOcLDT6i+fyloUDeNN+Tw3M0J5W6Z7LAT9LtRIghwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cUG8nPvV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IZcdKzoL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Df3sk016622;
	Thu, 4 Jul 2024 19:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=9nuDcU0AgFK1lYatfHQchPXh/k2nufkhLl9yFhIr0nA=; b=
	cUG8nPvVzLkE76Jj8ODpQBPNSoUMC49nbpOvLfLvfHK/4J8v09FmkF56OQNhD5Yl
	yopB/8sdbnw6nDhHV6GLM+IkJCj7x3zJmv85V/GwZYp6oz8q1H2ivFEuQ6EhVPXD
	ACDM9xLqX9iApkO7ccLfiQVnnOVZhzoe4ZqAkOeOKWahKo20eZ2zLd9zBlcNubUC
	lIL2Nnbx895roO4ekzjmlcxScrLdWm6Zd+VwJnPIrzqMx8iF+toYNONjf3ZFTdXR
	dhxJ1lsmwxOhGQDRpKWRLK4eRsR5yF0X6Ntzf5HMCzCG3wYxRZJR6SIOM+9zFZDc
	6EO83QpnZbj9zvgHXR7EWQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0ts4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464GB12j010894;
	Thu, 4 Jul 2024 19:28:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qaq0a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7qhcmzi9LmPXdMswY7RGFzmn3oFJJZIlNluEPgoQYeDfol31hVgX1azzuSZKnpQFR0RX/DxI9jZ//UvviijXxJZkMVTmpQ4rXNBEdEvpZIPCIGfzLD8HaxIgGat5dEd2pQwqpqMzUPWGF1jnpJ8oKl3FJmTs/+qgvu8b6jAOELUunFxB4H51Y6izZ1agcxDFowQALkd5yqI54Ak7REDG0Le3cgVO3JLcCBx90TxDT3kepW0Xgkz027kByvgHRYVol82zLmAsI1IVuKsn7G22kJZSBVgR28m0T7Jg2sf1QSY3jPFLM43ataIHYH1v3dNVtxYaqgVLn7hY/c1s7nbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nuDcU0AgFK1lYatfHQchPXh/k2nufkhLl9yFhIr0nA=;
 b=TdeHcCbWpEYTD1cnisawAf+aK6axipUk6fsZxaDHVsjBD146uBBeEKJlgZa/cuazSP+PaKTGoEdsSwcisqDNZ5+MoheruNONZkONp6KtIeKN13FYQiNuyEZKlpzLruVMFYdCKwCve8xCYuEMj9UfwV5LN7Zi+pUUYmyB/uK/rmUWoGrDAp2bds7Si1LwK3r+ossw0nm/QtgFyoFfiQhgx1QVXTKzC541Vlsru0HXhUJSVNo8zVKX6dtt7No7iWfJg/Hb+NEE9fp8gY6F278ajtIqkJ1gs2DF2hwlgNjBhogLWhvoMj4UvGmnA8unzbUHnH/hOp8TxF7FBBcErZsC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nuDcU0AgFK1lYatfHQchPXh/k2nufkhLl9yFhIr0nA=;
 b=IZcdKzoLxutxuPmUhW4RjJuF//Z4GhOcO9oK8cC4Us1CJnl4iel+/eC0Vp0mwhpINwuWb1fwIsFo/vIIjGy7/ABvxFA5Rtb4tq88tpQBhu/vh50qV4VoCUfDZhsc6FckiEW/3URqYwevE10BZK9W/gxHW/dsr9gM4kauDRmTrEY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB7228.namprd10.prod.outlook.com (2603:10b6:8:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 19:28:31 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 19:28:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v2 5/7] MAINTAINERS: Add entry for new VMA files
Date: Thu,  4 Jul 2024 20:28:00 +0100
Message-ID: <c21f13e43a4bba058f25073a2d89ac1ec5490fcb.1720121068.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::35) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea4d7ef-a25a-4490-cf96-08dc9c5f7d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?CPEaY/k3fiaYhSI0vB8aC0JaDUmehYOu48qqIWPBX176R2iVsEcYAPXUpblk?=
 =?us-ascii?Q?8NAk3Nrna0RCFFzmfbVECpJJ0mlhsl7/Tko3ebFUiYwfKlvXwatbM6e6hrL6?=
 =?us-ascii?Q?Lbqhf3R4xoOszKv+syIANcT9bF5ysYVHDl9GBbuamFBnsjdTICCA6Gw+jOLW?=
 =?us-ascii?Q?fmnI1iDp71FAOr/+KbcUwcSAKyeMhSs4P6wpw+7eBQkYMZ5WaW9u1s7hLj4c?=
 =?us-ascii?Q?kWaXgQJG2iPM84GylqnS3YyEizoRdjwWJjf+u4AvhWjWYF2DS+BP60QvO63e?=
 =?us-ascii?Q?Ohzis2uDzfWNdIwYRstXnkMkK+dABfu91MYgiL6Ci7+6O5EoGiewDOhKn79X?=
 =?us-ascii?Q?lWSe8c7rHgNJiUZBHhaqdp4nmqbcDnxTmN5bBhSp8CO3Exm93sRPgeXKojif?=
 =?us-ascii?Q?ojWJPlFVYYE27NPnmUUE76QGn0EabwA886YWYsQbPV8Djpum0J7KtDBqDvfh?=
 =?us-ascii?Q?etu8fDBt1BvHfe3FXeuNWVzr3hdzeJPzg7q1IntbGxvCEo6aEYAuACRayspb?=
 =?us-ascii?Q?OzQo/NXKA3GxcBT+4yFF3orXlu0mbesNhxZiwtLDOMwweC+g7fUfufmxf1s0?=
 =?us-ascii?Q?HyobH9C8VQu++3TtZHMNcGxvi+rBSYDaBcabb9Wxq++rSaDOwk9/2hzEseve?=
 =?us-ascii?Q?uVuV85e4hghNC+HE0A4iehsepzqIUtO5aZdR/uim28h2/QeWa8492oarbZUI?=
 =?us-ascii?Q?YbgQFVbOrMtwSZLkosSSHD4GUH8SynxzBsuIebnfGZmdgkHM4J2p8rDx2G/R?=
 =?us-ascii?Q?8nDbuiFIIScaVUl+pUp42ERgXfwXBsEAmZ0PJMzISUXC6VTv2TbVKcYLZAFM?=
 =?us-ascii?Q?yNKJyyDi9+dt3+Z77TerX7jjb8iNqnoNrTsLQbIotdFmz4xH9Jbj9o0OWpMz?=
 =?us-ascii?Q?pl4XUVSCB6riz4EgRinJ1azPnrWTGnG7ptVWZvS3q71/ggp5VRfjdmbu43Nk?=
 =?us-ascii?Q?3fRqzQVWYlWN5pcPdDyIpcl5y5bIz0FFDZ8l/GyWbD9jN5Lxsf0PxXV0YzUd?=
 =?us-ascii?Q?LOQKjW07NnTddmmi15xJ7T5pkU0w8fKBgRwE7fahnoNUA5z5Q/oAHljKsPHb?=
 =?us-ascii?Q?Uf1KMRGspGhAu4ay75cjvH2CxansGMVOqBjmS/ZfKh5Bf2Dqlg3DiIMjAqHh?=
 =?us-ascii?Q?qXP3jCJYDDwASLBwLOgE/PRYKq9u1VNEY9sZsk35Bu6ro1qO1dCStVUPsSKQ?=
 =?us-ascii?Q?n6mDCmzabLWC6yr5X43HqTPoH4+c9mkxRGNRfvr2OdHDMvvpNgh72wW6oVPL?=
 =?us-ascii?Q?CA9M0gg8iiGnNgvDqhePfNLOmEKYiQf3fQLePLOYYyPLht4R9j1L56I0w3oW?=
 =?us-ascii?Q?lBU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?H33jXF6Ap7hMH6S/oY8yZObGwdSSYHH4/7Fxt+stwqARyEIjos/+VCtxf6fx?=
 =?us-ascii?Q?YMBrEGW2bdakU6avRlgNZG/BJrEOuW22xoVuI/2nxZeBg1KwqMFpHm6+nQ+r?=
 =?us-ascii?Q?ohuPqjVtT9buh7ROyADAHK+pVU8UgYIkE93YPpgM+bzTsaBiEDJrrJhAK4gb?=
 =?us-ascii?Q?eglZAJbK7lyn7a+Jt8anrHqsbX2zzWW0wT0xsggS/X+knp319kOyFdqycN6F?=
 =?us-ascii?Q?DmVYoWuAJz1WPNAyuQIq8w3GJkykbgtVEdBaRQFWsoDqHwNOqBN9XCkbfxvm?=
 =?us-ascii?Q?9AyykjS6RRG+lrDB/Xu9fOxIf6VZFImVudmkMyzhBP2e4XWzr/d+QJEyV40Z?=
 =?us-ascii?Q?kjOnEpXig/vgprIw2edfL279tNVRIEAW5OyeH2hb/KM1a2wgIK5otmWULMty?=
 =?us-ascii?Q?k/6Shq2UYr2i7NswVocLtEL8OjNpd9d44qvOiSHFto473bCwKOxdljIvcmbx?=
 =?us-ascii?Q?9BDLl/xRjP81Ha77PbPc4Mlr1xRGA8Y2McL+XMishYAj6it8wdX3ihk745D1?=
 =?us-ascii?Q?Jh2PbhfPlae9NXiFqDpmYXFb0u+6AlIjY5ADMbYbKJ9jyayAtlCRrlBPcd+O?=
 =?us-ascii?Q?GbCiG1tijqEl1TRwAQ0b4Xqwj74Xv258iOgTikfeaVIYaypMfZjeVVV89b+a?=
 =?us-ascii?Q?jvYRVZkpbdJHZiWIpwckz9khcKfOHTKuy5ale3zoj+036JIhE0ZgmPqQS5wD?=
 =?us-ascii?Q?qi2dybJzaB2RSf91klgqKPBoK3yAkKlwTS/iDYpoOP8imZLyu13JySbV0sY6?=
 =?us-ascii?Q?+mUjEF/O3Ffd5zPnNiJswcOswG8fcTBcODE/Q7sp4sSYUp2F0vVm3LmvqSFH?=
 =?us-ascii?Q?SfNBuh2Y1krEx3gIXN/7qyA22T6grnzkME5j/rgGdo4DoTdHIAD3Q/kvLdH/?=
 =?us-ascii?Q?uZ32tY6grUC/KFE5i+QLgsrzmU7tKdVZ3qr/iGX1z4mMTx0uYhRMTGmJwwhk?=
 =?us-ascii?Q?CBe466e6zB8o4FACHK5+9bdRpdOAqtqswqF9PPrHws9Gv8TkutGCsojxDzHQ?=
 =?us-ascii?Q?7khQbz5R42R8Y5JUWZg8zIKtTx/dnA/044x+fmDHHRIsXK5bCVnHHXJdQVw+?=
 =?us-ascii?Q?FxST62gNzgndMJ1IeYdo7J2SXUF0B3ZixJUv9/QbraaNMU0Y2yK6Txawoc6M?=
 =?us-ascii?Q?rhvH+UIJWeA/6b1c3hKWTTu9cvdPLX1CmmTJjzAt5dSUbJZiUHUkJLEVdK/D?=
 =?us-ascii?Q?ss3kImpgdTD5PJn58n9DTbExeqqPfFz6kER3+9F+oUFiZHgRg12yO/ZKSVGO?=
 =?us-ascii?Q?PA6da2Mji+ZsqJpbbK4IlTtNLyG8hBBz+JIsqW90dW5BWT7mub1b6rfLMeIr?=
 =?us-ascii?Q?klLpODu0nbbnvcepWFleNDzgOsljGWK4TE0K+tNJ1gl9a+kFz1HOpMXc7qow?=
 =?us-ascii?Q?jzzKzvI2stcVAl9bFy1E1GFoVH9Httcw93SSoEx99b7TnthgeOvcMnOYjdd0?=
 =?us-ascii?Q?MMb5ekDi+WiB327u12RxExYiUG++TQ6+T5lQaNhrJKaehQ3y403PrzcEnHks?=
 =?us-ascii?Q?maG2c6t/W2wPg7EFB/U3hCAQ6EuWzIfRyily/RGR7uF/Uwfepwoy3mwiiBUN?=
 =?us-ascii?Q?ieUeO+rMRNecWl3+A3wiFY+GH8a/cELa3IxFmswARz1Y2dYppAkEDjeuDEUV?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GrT0Gi3R3TkIwgNSaUu6I6Cc/TLnBi4hlfB1fFFtno8jRKLCt6uIszeUUFcu/nSp4TlI7T0RlJdBbeWItznQRfrSaf7UZ1KTD7sedWtTnp3to6FvklWuGr1arjh5ol5SUe7ZQk18gGR9G6ZTgmCykWuDm3zG2VoPYoOS+yN+i7v5Ss3NXz5FVt9cTCUmn1+dUuHaC32bA/292vPNF1DcEUmXn0i4wOC6+9p0qfFaA6nSVWQv55reFeUQCgef7tJv6nuJCj73cUTcPCgVWTA9SJvBuktNN5Pmi8E5S1SeNFKVc/vdUybh2OJ6FatSbchtLz/5d8WiMCAAIsMsrH4SXyX9/oL2aNNxQn33Skpy1NbQEtEE2Zp4YLrQpN66r9HFi1Nxir9GT73w+Y6x+jLmXTUlA0oAS7OZHXXPK+RFjOtCYyaXlh134ETJd3qZlBQL2u/HRCSRT0NqbZozqI9Z+g15jEOS2rSURvTuBvEiCq551KEHK5uNFDJponfGpMbbKfyucWtCkhIHvZYjvFfOB8vHPqfIvdcCmDVa7WKLh+FEx2cT1v3F+OzvsxU/M7Zp//AeU2M3yuZCjo2yCcbUyf/PgpEyzw3F3ieL7UPjd00=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea4d7ef-a25a-4490-cf96-08dc9c5f7d21
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 19:28:31.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lAS4ljKJ+SjBnRuBFb6+yUSRHj5DMzdnf3clfCQHF13yesWnxp3sBUR7OJCRHOG+SKTvJ7t19FewIJ+4x2uhJOz7UJwS3EPhPn293TuJEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_15,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040140
X-Proofpoint-ORIG-GUID: XCYG-yznBCQEqdLewz6UJXbzS9bwhSz-
X-Proofpoint-GUID: XCYG-yznBCQEqdLewz6UJXbzS9bwhSz-

The vma files contain logic split from mmap.c for the most part and are all
relevant to VMA logic, so maintain the same reviewers for both.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb1f0d3d26bf..e5ece55b3cfc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23972,6 +23972,19 @@ F:	include/uapi/linux/vsockmon.h
 F:	net/vmw_vsock/
 F:	tools/testing/vsock/
 
+VMA
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	Liam R. Howlett <Liam.Howlett@oracle.com>
+R:	Vlastimil Babka <vbabka@suse.cz>
+R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	https://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	mm/vma.c
+F:	mm/vma.h
+F:	mm/vma_internal.h
+
 VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
 R:	Uladzislau Rezki <urezki@gmail.com>
-- 
2.45.2


