Return-Path: <linux-fsdevel+bounces-23399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F5492BCA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 16:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC451C215B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1D5188CB7;
	Tue,  9 Jul 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e0LtMnKm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BqW4bRJE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E617F369;
	Tue,  9 Jul 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534517; cv=fail; b=UkfkAaFgVcBzk2GOVtJMUOxXVZ6Y2xgZmIVzfaCwFJxITi82m4EvPnVnmmoIIA2u41xENgAS8mlA2hTSkA1WXvH7ESwd4ON6AJGCH5XbzdRXf4Y6+L09vUlDF8hLY0IIP4c8BIzMHnMaHMjiZJSi7JDIbC4D0gWJdRnsn2Mtr7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534517; c=relaxed/simple;
	bh=ExjgJwJVJbIjPIm3iCs9yCSm4OdOlDwWKzu4H9wcIyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RkWzLwfiUhwOGWDNkNne7/cxvAMMD6i6SKZ20TXAx/jUDEIa8nbH2wJMtZcCnIXYhV5VevpyigBGLI9rIBS5LvdvLe83lZ2+EkEhNxqWVipI8n9nKhfdATtN3+ufKFFWQPTpGmhRDL+YBPLpqQafDDJRwj4KiVjFSnnKUwlvcIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e0LtMnKm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BqW4bRJE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT1Pg007967;
	Tue, 9 Jul 2024 14:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=92jQB6CN4x7+NTK
	N6GVOZklBCNbhxkM2ptOZYlWDGvI=; b=e0LtMnKmvkhSfEU5fz88RgsxfDYorvk
	oxsU6MBFQwaqsihpowqpRjcNIajtvIglt2k9hmJiaNGv+nc7aB0zacSJ2PsHHdI8
	+UkPXl89dADL4BmMjFy3JCd8aE68IuAklkCJah0G0NLIYzak662Tv6gDLdbdYKAE
	ulhCNuwlZqbTwhsBYDNrwFdjDAsr1dbH1JG3Ha4y3dhVju1PF25CpYk8OWZB6Z+C
	26h/MBqFP+NOgfP2WMctA9j+FEuw9cOaKTwjRiL7iKjZa/viNdf8HVIA5PLxO/Vn
	kW/yRg0CSMaBWVW17zmSj6BO5lGbkpDTp/uiXTz78IdbP9y0aUq8XNw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybn2tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 14:14:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469Dhd63005617;
	Tue, 9 Jul 2024 14:14:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tx2sg3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 14:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtpnLzVHApuN0AmdWaBTerb7LfnLXN710Ug/iwoa1MrXzQ5gRWvksKNtjElr3lsPIbE8ui5UXgMYjEC5W4L0eWd9jKmii1nnuPtD2Kkd0TXkcFxDNt8fX0cTju2yoKEegKd7KXy6If+K+z09Z/97IUkLsz9C12gGnY9TK21VHHcr6KcRCzSChDgZs2xJLv3FveJ5JNG/oMdM9+BmZFkJrvbBoYpDqZrytpXs6qG8uznsATgoTfAouJxcsbGCv9zSSqEItzZVL6RhOrNbtIFs8Eb2kzKwwA26xosuc0NUD1CrCKIVSpPadyzVk6nfvqW13MS6/cmpF8wjnS8A9g4+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92jQB6CN4x7+NTKN6GVOZklBCNbhxkM2ptOZYlWDGvI=;
 b=kB10zHx18qqR6UHZIQtHK7++uIZLMdUiyZ31dLHSbazlDiuo2wf7qfP+pXrFXwuD0mxVl/DjuRDkfQrmjIBRZ3xw4uBfakpuzYIxsAsvojZCSFAyMgaM/FGx3G6n2q2wn+BlXRQoeT2YZrI1/alq1fhgtGFdfWc27gxGJs/5xtaTHi+l/Qv2Y2M/aOg8JvuZEmvKUy5guLoTiAmM0UPE86eIL0SHllQdam2zEvu+1+DxzShWsHAeTMR8M+HJw2ErG4aYfWMo7W0vmHwHU6BVFF9/Oofz9dr2oivle7qrzOvpdKi24qAWFgMtT1he+VWwE3AzVPQLf1arn17CyGU/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92jQB6CN4x7+NTKN6GVOZklBCNbhxkM2ptOZYlWDGvI=;
 b=BqW4bRJEFmF+Vn436w7XS2G+kZasy1bWwSiViElxmWh+OOxCC4xIpk5daDfl1HEBDKlNSdo1gD4VBkX11uCZZwEoCW0EVKh8lY/ubu0skTNJ8Bf3nz7/QVFxia6uIkk4ld/5eiorouAtkU2sIn53BnbRlGEKSf4WGEvdzQZlFEQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA2PR10MB4459.namprd10.prod.outlook.com (2603:10b6:806:11f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 14:14:50 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 14:14:50 +0000
Date: Tue, 9 Jul 2024 15:14:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v2 1/7] userfaultfd: move core VMA manipulation logic to
 mm/userfaultfd.c
Message-ID: <428d74c2-f7d5-4660-b44e-7818b6a3bdd8@lucifer.local>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
 <76a0f9c7191544ad9ccd5c156d8c524cde67a894.1720121068.git.lorenzo.stoakes@oracle.com>
 <f8658375-db8c-4fc1-9401-5e59b61c76a1@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8658375-db8c-4fc1-9401-5e59b61c76a1@suse.cz>
X-ClientProxiedBy: LNXP265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::33) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA2PR10MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0ea6e0-7e6e-4b65-3f3f-08dca0217f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RQH5kMX0Uc8B8aT6ia3htdsLb6uwnzFzwofXcIQkUBJkadJ5XI5Bo726iX74?=
 =?us-ascii?Q?IzTsNmLeHfNXnbCqMKT2kxA1/slHiRxU5wXxvDlFs5uPjcbcXriDfpJlIxSu?=
 =?us-ascii?Q?cJ8Fuu5Fv7Xn89D3UcRQEu6/isQvHLhJfJ90KmSgJLqgYRLk03t6+yotY9xV?=
 =?us-ascii?Q?ZxfZRs9Q/Vy542xyJx0LHg/EbmLzxtOz5zyBbfkAMZ7Y7cRf1WtAFnTr5dAX?=
 =?us-ascii?Q?cZKKRRsioZYyZEYhyp2LJS2M/x+fi9FsZqlF1HxN8LmTN19C1NCqXWrais6Z?=
 =?us-ascii?Q?4vYLJgbnBIDj7mP5qDLtQU95IIlGLnw7UQMq2SaL5hyEzVXznR2NvGaXf51F?=
 =?us-ascii?Q?sTSkJiZg3poCUfx0ovTo1H9/pVugYpqV0rQwqc5949fm85/8c3yVjSPQrTAJ?=
 =?us-ascii?Q?utiWBTaAIp3hgs8OOym2IOeIKHIikTmlVHoxOcgKcrK8xNToHFSUuk4LWmst?=
 =?us-ascii?Q?PyaabD0IwZa/zyrUqEYthk1sO/idv9qVWeP0ouCy3D8tjRNGIpuYKI9M5dlx?=
 =?us-ascii?Q?nGQ/T64tGdK5yf00EQJSadv8zo5mq6m5ueTuQpCrE7NPl6TGAzQcap6skReb?=
 =?us-ascii?Q?mIlCvwSZXRY+4E3+yd8pMlTquGnbq3cC9XG2txrjBZGelzUoCIISHHlnOxSV?=
 =?us-ascii?Q?tZViIe9O5aiEaupnfTL3ttH1uUUPlMEqxpPRDDhh3S8C/CQ3EneeraFQhT17?=
 =?us-ascii?Q?f28ieIhaPuN6wFa+irNiVAosSftNN7C4KWXTFBW8wsTVwhML6fK5uSPPdqET?=
 =?us-ascii?Q?NCRbVXhycmzpYtroty/Bj6jpvoUuTtfTUtdICz971DCCAvaHdEIzlbBhU4B7?=
 =?us-ascii?Q?yWfyj43m5AvEXlXpj9jL1e0EDw7RamC/Fm3iz8flBlvPK+xGxR8c2noktWvC?=
 =?us-ascii?Q?kS+6OQS0RSlMCJQhVnqVHQwyX60iAIUT34dsj1GzFtmKRWKARyfCQsxxJVVZ?=
 =?us-ascii?Q?boCEHfZMydFTg7TOvCZM5smK9C9Rx39Tl43ykvQL1qMXcU0/o/IoBzQNn0ZB?=
 =?us-ascii?Q?kBKmO5Gz/CarDKVZDVc18cIXEFltYFFizDkl+LOeKkDLerbenmJE1q4kn01v?=
 =?us-ascii?Q?/77LzabSpLtRO4OVP7YlqA/gsM/fGJsGTGhqDkKtcNDHp/ODX+kxWGuqjZvJ?=
 =?us-ascii?Q?udkicJuAILkcjhZWT0kjFN60fJYbWS4WeCoV6U1o+GQttWoU+je1nOCchqEv?=
 =?us-ascii?Q?NDDh4DjrePBCdI+gAaZIPF+iVjj7VecPeeyDM03Avo8Grz9B4+7gwOIJFhjl?=
 =?us-ascii?Q?VBE8j4h3GLHG0pptI1ebFBNbyqGJwxKuwTtPtaj0EejId0X4Ps4gkQ+jhC+F?=
 =?us-ascii?Q?dRX2R5NYgQF1U35agLy9ZS0yfmwbceBCWfLnebw+zB5SeQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gvG9rwM8FMHJytR7E13HC44bqi0a93ltrJkhId/dLfXMole7RM9k1PeojR0A?=
 =?us-ascii?Q?uGFAyhUbFzyfbgex2lcGArlhYSeytpDoTPNsUtKjlxFLW0INI7iZM+mpyKa5?=
 =?us-ascii?Q?Ak3Tqz1YR/UaFxDheZ62o3dH5hby6mSPq3jqXUhKVYJ8GhMeVHM87TEV/Ps/?=
 =?us-ascii?Q?4yAD6dsSJW5ujfA+4Vf+h62Nm4uc7VaFJkgLmVnKMe9wXb0a9VF5fGWdjhEp?=
 =?us-ascii?Q?zFWcL0kyWppSL7Yha38fZo5zdPUSkatMNdRvLjOswPNhS2vyKqVk6n1rPGck?=
 =?us-ascii?Q?GBeFZ3SOakO0z2NCAWD/THACynPR64CcB1v7rM1iDJw+OLbTdiF0tlvlglbY?=
 =?us-ascii?Q?6O52Ilgeap0ZdfMKA9QJgf0ICbI93V22giIyUGneNAmD4SyReUnel/UIAEba?=
 =?us-ascii?Q?MQVY+bOqnL64LnsiYXrW08df9A3s5/I8qUzbFqel5+CjSp7fjHxTsyrWW6uy?=
 =?us-ascii?Q?sCuQuxBZYroSFAnYVhEiEr9e+iUl4XyeL1DYK0sjIQ5mVgcqEW+edrzIU5sU?=
 =?us-ascii?Q?p/cRqfQ7GmdjQj8sL8U6qZk/wfHGMjJaKTwXy6EgDEioUFNcHt1w3+jqsaxU?=
 =?us-ascii?Q?ZVi/ZQQjq/fGjuADPE/P86D2Y5y6RkCFHrSvzjUNi91IVk7Yd03Mws3hfOtx?=
 =?us-ascii?Q?Ubbh/ss++w2AmtIZYhJgQBj8P7o1WJsBUC8yDEW24Ocus0q8o/uoDzr38KpP?=
 =?us-ascii?Q?MhhAxO85rsVGHNpR0nLMLACwGceHbVqQYXSSk0WaOqwbKwAMOSovCiFMlmwl?=
 =?us-ascii?Q?2xLa6Yh+LXQRzZf0rZfxWuIwxW8TOVrZ+4rBoWDNZVcQqyzq7QxNT+YcjJhg?=
 =?us-ascii?Q?ewXuLnWJMwmM5u3USSA6a5Y9H0JfEQWsPr4H0rtsbEe7Ey5ArkdBAD6Whf5+?=
 =?us-ascii?Q?r0fcFnOLw0dq+R/cJhBBqygXY8MKf/ZLkfaV/PNvgRnAq41MuNQha3RueWqb?=
 =?us-ascii?Q?HUBgxgD/8WpyIFfaj9+AYf5EPc+Q8HL48KdkDpko8IvcYGT2HO47PxZobEfW?=
 =?us-ascii?Q?9076THH9gYAri8edBgNQqZcBSWqM+L2rlTYAYm2IbyQ+WnsWQHVy6OKBcv6K?=
 =?us-ascii?Q?wIUIF6gwHy/HeO7oA+MlaQ+21zzNeNHUM14ZB3Pv7Og1hbP3zsQau9L+WZ6y?=
 =?us-ascii?Q?zxabrcHDZJsVFnOLS7n7TUCUSZBi7nyv8w4/n+p+Aw1+GGORvhf7qqNsTo2l?=
 =?us-ascii?Q?5aD93PKg295AWoYa4caLONUzu+nEHNXHH42I3O9ZUTSZ3PLDgFH1EV6vbiAD?=
 =?us-ascii?Q?ApqlAXwPRLAEDAUdctGdoMzyFidH//ugKP+j4d3dgHgJrGvOXm7XfXgAXgP3?=
 =?us-ascii?Q?F7cgGsu9FFnezIgyD6r5520ZUmI+KmGUBwdgGeEJTTaTW0XKnsugxsFrSMF4?=
 =?us-ascii?Q?2b7Z57uzl0iLzE3RDcamu+VUT6vjWaAkNGUeVmcmWUw70gIQnuMfpuMWrKF5?=
 =?us-ascii?Q?CzPuknULntYCiXLEIxSb+jgMf8sUrM/qPIt6ZjYYFEqsedeDk5+jf91UKib4?=
 =?us-ascii?Q?45QOIjO/HONA9cNh5bPEgH/tC8pGPmHH9j1DDPyCTNgkM5SL8eKsGH2HQ/jv?=
 =?us-ascii?Q?0kyYdBgvIC5q8Hss/4TNZFAQKM9lfdR1EryCd2bQczgvLWnbkILIYwv1vrQE?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rdKpfqiHNuW2fxudeup3YeF50DSR78TuLd3mMo8l+/Fe0NnawX3bF6KJxvg49ZYv5iEtcrbqpSTvwolRJcUG/NVEeWyxs2OEW+700vB/fzr+DYA+fL12TbGTqGSbTV3A+zZGcWZJIOE2AaYnpLUPw1AhGAvve06+C9YnUEIine3mt3X1UinEN+KnARrRZp4e3Gj00uuv+zFpzxysxq92dks+dd/dFxfCUuTxXWoeFrBLPxm3YcZBdkcYnEKwk1PZvgM8nGKQR0ZY7bLBOmW95j1umtr0G1N9jSwuf5wJpZ3YxtE1yIpIb528a6gizpRKqw1lxXGoElOZ3D2qEpfOxp/cu7RUnez6+MTljvGPZ0FRO10DnEmYoMG2sZNYQXJNBsxvnfuvcQ0BjxXGwgkc5A+i8nC3b/hkNriXMSzL4UYV0nplqjNyygXsBIosVBJxq4VnimK93dZ+2vvcJVR3Wpb7dpsJN3XIXZ3H5go+iSxJ1PkhXn2GdrjHVwqKx0LKclLg9dor+xAhi1OakjJXdM72IqC72C06WivbHuIyAqDlopHd5WgzBk+lUxuTXErPKxLdXT1k0zS+uXFZX+XzkY36BrnoD5yYTVcglBnXB8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0ea6e0-7e6e-4b65-3f3f-08dca0217f18
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 14:14:50.7398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fx02U0STm/JsIKqNVaMU4Amk6BE3OtvMtQzGM9zDpAxsVq0evpsGJ1zgsbYmI7/Ev5nDoYKkLErYdXUiVTG7C8t5tYDEkbo+ClyhFqUEr+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090092
X-Proofpoint-GUID: MG-fRe8Gv75ualAOJHi879dtJRWab6jB
X-Proofpoint-ORIG-GUID: MG-fRe8Gv75ualAOJHi879dtJRWab6jB

On Tue, Jul 09, 2024 at 12:40:12PM GMT, Vlastimil Babka wrote:
> On 7/4/24 9:27 PM, Lorenzo Stoakes wrote:
> > This patch forms part of a patch series intending to separate out VMA logic
> > and render it testable from userspace, which requires that core
> > manipulation functions be exposed in an mm/-internal header file.
> >
> > In order to do this, we must abstract APIs we wish to test, in this
> > instance functions which ultimately invoke vma_modify().
> >
> > This patch therefore moves all logic which ultimately invokes vma_modify()
> > to mm/userfaultfd.c, trying to transfer code at a functional granularity
> > where possible.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -264,6 +264,25 @@ extern void userfaultfd_unmap_complete(struct mm_struct *mm,
> >  extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
> >  extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
> >
> > +extern void userfaultfd_reset_ctx(struct vm_area_struct *vma);
> > +
> > +extern struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
> > +						    struct vm_area_struct *prev,
> > +						    struct vm_area_struct *vma,
> > +						    unsigned long start,
> > +						    unsigned long end);
> > +
> > +int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
> > +			       struct vm_area_struct *vma,
> > +			       unsigned long vm_flags,
> > +			       unsigned long start, unsigned long end,
> > +			       bool wp_async);
> > +
> > +extern void userfaultfd_release_new(struct userfaultfd_ctx *ctx);
> > +
> > +extern void userfaultfd_release_all(struct mm_struct *mm,
> > +				    struct userfaultfd_ctx *ctx);
> > +
>
> Nit: the externs are superfluous. AFAIU the tribal knowledge (or is it
> documented?), we don't add them even if other declarations around have them,
> but we don't also actively remove them unless the lines are touched for
> other reasons. So the declarations are inconsistent but slowly move towards
> no externs.

Oh right, I was just keeping it consistent with existing decls (apart from
uffd_register_range() for some reason). Am aware the extern's are
superfluous here so this was the only reason.

I think as it's a nitty thing let's keep it as-is for now, I can do a
follow up patch perhaps to correct.

>
> >  #else /* CONFIG_USERFAULTFD */
> >
> >  /* mm helpers */
>

