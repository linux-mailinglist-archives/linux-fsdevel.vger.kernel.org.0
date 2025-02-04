Return-Path: <linux-fsdevel+bounces-40734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63381A270C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD61163881
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE5320DD4C;
	Tue,  4 Feb 2025 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mefn4Vt1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FSRPqZQm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8A18DF81;
	Tue,  4 Feb 2025 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670532; cv=fail; b=JeD2eUkfOyU1YPwF9554M44NE8+ScrmpNcTMszbfVcpM+GTC+xA5FoOjWT9Q5FhHy78OeZYoIeU4YNPCg79a4AIHG7OVJyMP6WpSf86SZMaehldvVhUNVsr/0SeFY0jbOkqGnro22ZqkiAaI7QpfSlAjVap03IfEE0Ex2L0JHQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670532; c=relaxed/simple;
	bh=ErG50P8og5AFdYZsqOphx/4qGsKk8E3HjT7vAJt33iE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rq/52rPzi1L0HQGRt5SYFNJpnPTAIw5TeVZiUKno2u9vQb8KbgfXG1Fd2m6D/YD3O+zg6B2r4x48C0Lqo47zsAlWhL1snrISGMeJNcAxvWyAfylMSIZNXqLZK4Go8yIWSRWpwFe4Q1tA2pq4FFa2QGWfjgQ3/gMSdwRwGYFs5a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mefn4Vt1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FSRPqZQm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BewRm028088;
	Tue, 4 Feb 2025 12:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0lYuuEqLJ5DP4oFNh8ww3WHp/pQs+A3GJ6geVwhx95A=; b=
	Mefn4Vt1SOxapu6xVfu2HA6xTnnodfu7I+hv2ltN8iZKnhfZlZC2oRKI5ZgwLN6T
	1H0L8LXsYRNQJnVqQN2vyT2zKLA8TbQWNyjebDsAqkatTtN4P5fh0IqE+Ke3ViDv
	F9YMSQIHzG97GdYf1rpU0O9wL4tHHWaZIfS5nGrzx92C1NMg008SmjMOhnKzxR/T
	uTFo3Z06GKjShJhWCsMmzxwEsfh4Y31+UfBmnBLDQ3g8IZ//3NnEeY4PkMalATRQ
	EGZ2MD/WYAvxrF5cezAMJzrmqprYCmDbBMzm6oFc3fvNkeWTEph6CXPWFXSzCaAu
	TAy3psrmrgU8c0HPIOpddA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kckxgjab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514AcOQw029134;
	Tue, 4 Feb 2025 12:01:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p2w4kd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsRbwjhD11iLkfQi7OG4lATbNTDyjzz8QnBPLyIYyc62a90eFRYizCKbSwIsGoaums4Wh2GAj6AnJbNsPJ3rggPQV2wqzxdnzTuevA1Ry5qfr80Kfedi6jIVA+NPLJmmZGBB/szCWBMdEoaveQkVvTexbegotUDR4Rq2JdFQYAiUPGw5GC0OvqhxIRca7SfEgTH2SGhLpDWqY8GxO4802sPQtr0B+tthEYQeBllRAtuKdFOEFMayvce8FCqYQOuk3tq6e++yGDfPVCyjjd6IdEq2SVogRsF/UPEZCV19Nyu40E35KpnblOs6Yle/8yvoQXJN7lvwsSWxJHTMoGtdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lYuuEqLJ5DP4oFNh8ww3WHp/pQs+A3GJ6geVwhx95A=;
 b=WxeVdkdhqTFDSIJpuDK+sie2nnJ6t8PepOLghheBD9FxgESqjogx5ANCa5qTZsstxj0CVlLW8qoHcUtP7EGwU5HOG2WtkT9S0PfxrbWf1B/QnojffNw6tPYjWeWgMdoHtCskGan3pV1BLqVCYRtI0hRWCq1m0kAVySZLOlRtn8DiOm2DZwPUQ0RMmKNmKGyyA+60gXrFju6hvXhegRIIdt2LqeVahIvG9cviwY4k05OzNwx4r4fRyrAGnsj06Tbbfh69i54lnwuwSMA59sycETUH02K7H/FScUXhov4MuTpbyJAINE1kMhRSKicdlt1HTBRggxXiJDc04e9TSl49dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lYuuEqLJ5DP4oFNh8ww3WHp/pQs+A3GJ6geVwhx95A=;
 b=FSRPqZQm2PA0RYTGKlqpdlmSVYCRkWH4XbTh6/0lmRLXM+XZd+Vp/fcq9vdjPJY0dkXYV0lEN82g9O5P2XkF/cMp2/H0CTIOrLdIMghtzX5VU218B8/G8FSBj+BRUBk/5jvHJjKAzB5KqKXyitufIGv5UfUiy7vmI5MpIRIZVXk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:01:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:01:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 09/10] xfs: Update atomic write max size
Date: Tue,  4 Feb 2025 12:01:26 +0000
Message-Id: <20250204120127.2396727-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250204120127.2396727-1-john.g.garry@oracle.com>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:208:23c::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 945ed9ab-6eed-4907-6f7c-08dd4513b779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Kqm9Cz8xapO3vP5MZ45I7lZiFLle4a21cJfUc1Ba4r5Qoeq0/7SLVrkMqvb?=
 =?us-ascii?Q?iFAX8Hrz7UH+Lv96XFuJiUaq99B3zSOrizE9GNPjyYOAOPjOEJVb0fj+l1ms?=
 =?us-ascii?Q?bZLFKZ8g9oU0MiUKi8dnNkULoK9H9bgHGwJmw/rS7rDJmB4oBa/z70gNRLmO?=
 =?us-ascii?Q?UctY7EvecdNWwXOYACe/Kk9pyZQapypnJ+hpyubZaGhq92RL97XPbgY515Be?=
 =?us-ascii?Q?WNchoVuTQmbUOR6hwPNEJJbS/LGK1y9yB8oeGvxAHPcg0RDfHuOX7o/DMCo9?=
 =?us-ascii?Q?a1/O/vSHR41VDNxAW1I5Ua8tW8YLJky82iB313ok7fY4DFKYDYs9fq3djn+B?=
 =?us-ascii?Q?srv3xGuJWkBbwYLKrmwwDxNdrJ4KnsvTL5NiNR6bD5BHgl/GNT22YSrd/pJb?=
 =?us-ascii?Q?23r5wI6bO905BSCSZmGNMPfVJLj0OUW/hwNJ1yv3A7V18b6YG0GZhnPstmah?=
 =?us-ascii?Q?ejxNEpa/i71MpfNke6VrLq1sk9dKHKEMU8SOrUvfT9vgxGIjXmqxBakBWHDM?=
 =?us-ascii?Q?B77ECkN2z7h5MObz+pw/ySHKWIaIqKtew9r6nKoGXFWacXeBHTDhb9KsQFZC?=
 =?us-ascii?Q?BfKkT6FSVWtoa64K3X+Id4nU7/jtODhqFC28vY/CCSOCRW5jI8VdPjjmSjV7?=
 =?us-ascii?Q?hssdt1amXDJvOGobG7tqPGIzZtmgdbldEER79i3qFZNnMx6Xc5Y6revaJwYC?=
 =?us-ascii?Q?XbDiOH4LkWPZMvQ3bYE/Bky4BcutF4kTBNlYcHmgYgdaa65vMWliStga30vE?=
 =?us-ascii?Q?r/BVdt4nl6yQ0MUTcJKSHry62p5DDW0jt8Z9calHwrHdV2Z+tFVD6j9wQx72?=
 =?us-ascii?Q?H9aYG71KyBKIt6SlMYki7Tz12Ozp5Kr8dKd9ytkweZro27zUG3XOEUrsxFBf?=
 =?us-ascii?Q?UUqEwJhtKsliGCMR3XaqjkcLhVcKim7Obb0kmWXV6sxqRxMtndjz3Anw5Dm+?=
 =?us-ascii?Q?J8paMlqAKQfkZ2Tl7AqQPrdxp/RzijK6vZRiOUloAd7zHY3n+pV5dhwjmPdA?=
 =?us-ascii?Q?jdQk4fmIxUAsB0b6wAOiqIFSh4oFNBLttMXrxcvTHDJiDHtwGgUkkh08ipSO?=
 =?us-ascii?Q?isTYnCXyJGcP68X+Ve7Vr8t1XlQboIeflVDqjb2IPVPjvSh/+Cxs6cQhYDvZ?=
 =?us-ascii?Q?DDQvRRqGTGWYnkiBjY3WQ95Z4W/H2h2CPZ+dxRxMHvDuRJN1JdJy/GrTMZRL?=
 =?us-ascii?Q?dX6f0gF80OL8NtNF3YMrMUt5FgnegJy+E1Iv14tvKhhfvBf/R63YgpVJTyrS?=
 =?us-ascii?Q?bcNl8R5rvX25wtVTN0GHloCSMf9fO/SF8s+btHmvjgTgzn14PHmBMvmgnqfE?=
 =?us-ascii?Q?gEeBljm+gcSV830SMaKXmtkbNenLGuHuDvxmvuw5P3Rqw6GuV9ZerRFZTZnB?=
 =?us-ascii?Q?okeh3ZcjtLntb+EKRIFmU2bsfr00?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vGIFHC+7Ruz2lOpClVUAFc11qjJacbgOY0Z4BCTAD+SfPKR2gyyqvqS+smwV?=
 =?us-ascii?Q?EVRCpgSiHeEJBkv3KulZikiHZsh2fSjgOrVg5xda5Hv1krVGXHOFjtSRUSeh?=
 =?us-ascii?Q?nCaPJtnzTe/dzkZLbjZe7JJN53jLhNICF0y42P1o2u1uWh0bUR6qVW7d/G6Z?=
 =?us-ascii?Q?6UlhUsUUZHUgWvBbjbTXNkqU4Gv73zP4RAt+m/rqACwv6PfHV/CfWxJCatqU?=
 =?us-ascii?Q?LPkJbrw9oPqTTDCNY7FTuYJ+nY1nkwA8qSlxkU+tQKIODVfgayOexKNkIIn9?=
 =?us-ascii?Q?w230AZlQYlhb1Mum64v2eGSCEk0LwOlceLj16DMPsoPcEBs/djmqOSTczaIh?=
 =?us-ascii?Q?rwAQO9v2/5HFH5c3PJ0Q2d4wlvvc8x8HxarXFZ+Wg1CteqHEddcA8apLf8Gv?=
 =?us-ascii?Q?NXCYWtnzG+8pI+PumSf5DtVKMByNqnRNVc3gozXyvyvVzdSibYZbn+iMu/ga?=
 =?us-ascii?Q?5blnX3EKU9wyF0WOLo5/vHyexkrWJhWLElUAolbzOCmRHcpLe40ssSVnOdW5?=
 =?us-ascii?Q?UnZwkczGBed5MYkRXVxEmxLFpTxRM0L6Pe+sTdSC5lnciS8Uss9OGOdxiDHm?=
 =?us-ascii?Q?Vqa7UC+Y31Ol1OfGD8bYHoorRdZ5N3qarGP/PwOOUf5wmevuBfFO9DjjwIRw?=
 =?us-ascii?Q?JKd5SCYSPDxVPIk1v8K1YXj6eAxg+j+FAfdWDBzT/pz55aLhpuBgRi/hJ/9Q?=
 =?us-ascii?Q?inozxNpHQDAvcWudf1t9tMmt2NyjoBWy5dkrNY4x5AZ6zzRQvkoJJxY/Z89Q?=
 =?us-ascii?Q?RKpMx3L1O3woJBFWPiEr0vUO1p8JKSIGF6vWO+KSik389/B+cNdv7Gl5iDi2?=
 =?us-ascii?Q?ZKzmFGi8uiVNHeI9e1A64zwRzMRBJ71bKxLmitZWq56us+q5JPc+NkggAQR8?=
 =?us-ascii?Q?aJ75rYcegJsYawU0/KJy/cGb8/jCB275f0kvwf76SXwERbFGPsjofvIlvHyx?=
 =?us-ascii?Q?LxIwOkU0Ai4zFxf6WFoyJcL5b/5pnN/7B5drb2IamXJXOZomE6MMm6Usjs+N?=
 =?us-ascii?Q?OV9NGSCH1+49/9KoUxAlcRAYgm9c+Wn13nMHh3zzAvJ5WgattHfknxlvjJwc?=
 =?us-ascii?Q?X7kv2UpTZRbAILQdvAa2M4fjX6gddnyYR87dqM44yf404tt+kj75ShckDcFA?=
 =?us-ascii?Q?l8VmjjNX1zYnREqklv4RUVByA2jcczM7jcT3yELxxX/O5a9RVOjvbyQg5z2Y?=
 =?us-ascii?Q?khMqr6VFHxca98W7St9t91hzduLYmsj1CQq+rLl+zEtczSF2wsQkNPLbp3GS?=
 =?us-ascii?Q?kLpOWfbxZwo8mwGLAYy33V1Iuth4UCHgu35CtslHhu7k1HV9oKdV8qGb7CI3?=
 =?us-ascii?Q?bhHenuJARw05PoQ5cTdvD4mGQY6+rxjztv+l7H8KaNQPup0ue/mQ+63/KIIB?=
 =?us-ascii?Q?vJstnigz+Cm5jtKG5lelH1uXlwCZm+hw1+ezm/oeLRhsIcPcCp8A3dOTYKy2?=
 =?us-ascii?Q?dYLzu+hjdgOOXOp8vlP5chB17j2VbnWia6idbmUZkZ2yOMPdI5Ous7ePjjhV?=
 =?us-ascii?Q?guX4dGMABsyFh7MjL+KTGy+zn8VlW0FQmdMWiKMmQmztZ3cKn2pvHAhHXfMO?=
 =?us-ascii?Q?GJrTKdJVpN+5NOUVDs2AVWUj7FtmoyRuDzrHlOdoE3jafZwcmLYdUNZFfFAl?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fag2znFnTv0cUZRDX3bSZ1QJe43/AI/gvypqcYMCtLeRVAQ/gjzx6eG2RHPUU7UCLeVt4rCxPT927PohG5yHDQRIkavhGsp1m+BmLwXB3z16JCw/z5IS9oiRkMm8Hq1sYIP65lnIgpeHL7pNRy/4xF1Fcnw6mAN47Xvi7MJTaWHYx906uZUJKJK5pkWAapTj9Sv45/iU1OjyA32h2nH0REHUM+46+sLCngRHU6QIXrcbGQexQxcpv1obtfkSwO0JcSqbfC6Q/52Eb5mjPH3ewYlODPp1n7PAMac11M2x50Dnt7Hs6u0lohSjvQkqbJVpsKaNbY4Vuqt2ZYVFeODaheAmBT5d/VdHv+0DgirvBkyn+LcMxQOvt0ap4Hhj6Bt4l8ZfLYi9eBuSZrjK9J5IA4sPFqAiGBDy2X9ZCX+XJAtbG47Jvvlc0qvFZbS4GH/At0LpMfCp6fAzbTgEyiAmi5v9rqRfQFZA0ybmRwDVsrF1mQenbxT0lodVy1JYd/1I0S+6kS9MH39rJhVwmL3+OrudLfWA0b+q11saicjDkLrNJqylS6ohZeLAJIbIGtyofS+4a8m8yr0iNIRomHluzmhbfwV4J71qG/bgSQEaEyg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945ed9ab-6eed-4907-6f7c-08dd4513b779
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:01:54.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxjc8vkPBwwBw8QYQqwOqDP0OLI4Rtyn9pPxebo2CsluBPGhJgCc3WNPGJcjt5GTYI5TpUPwrijk1Qloqhgo+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040096
X-Proofpoint-GUID: m5wOJ231D3eaQUl0IKl3qCcGLo3_mQL3
X-Proofpoint-ORIG-GUID: m5wOJ231D3eaQUl0IKl3qCcGLo3_mQL3

Now that CoW-based atomic writes are supported, update the max size of an
atomic write.

For simplicity, limit at the max of what the mounted bdev can support in
terms of atomic write limits. Maybe in future we will have a better way
to advertise this optimised limit.

In addition, the max atomic write size needs to be aligned to the agsize.
Currently when attempting to use HW offload, we  just check that the
mapping startblock is aligned. However, that is just the startblock within
the AG, and the AG may not be properly aligned to the underlying block
device atomic write limits.

As such, limit atomic writes to the greatest power-of-2 which fits in an
AG, so that aligning to the startblock will be mean that we are also
aligned to the disk block.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c  |  7 ++++++-
 fs/xfs/xfs_mount.c | 28 ++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h |  1 +
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ea79fb246e33..95681d6c2bcd 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -606,12 +606,17 @@ xfs_get_atomic_write_attr(
 	unsigned int		*unit_min,
 	unsigned int		*unit_max)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+
 	if (!xfs_inode_can_atomicwrite(ip)) {
 		*unit_min = *unit_max = 0;
 		return;
 	}
 
-	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+	*unit_min = ip->i_mount->m_sb.sb_blocksize;
+	*unit_max =  min_t(unsigned int, XFS_FSB_TO_B(mp, mp->awu_max),
+					target->bt_bdev_awu_max);
 }
 
 static void
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 477c5262cf91..4e60347f6b7e 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -651,6 +651,32 @@ xfs_agbtree_compute_maxlevels(
 	levels = max(levels, mp->m_rmap_maxlevels);
 	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
 }
+static inline void
+xfs_mp_compute_awu_max(
+	struct xfs_mount	*mp)
+{
+	xfs_agblock_t		agsize = mp->m_sb.sb_agblocks;
+	xfs_agblock_t		awu_max;
+
+	if (!xfs_has_reflink(mp)) {
+		mp->awu_max = 1;
+		return;
+	}
+
+	/*
+	 * Find highest power-of-2 evenly divisible into agsize and which
+	 * also fits into an unsigned int field.
+	 */
+	awu_max = 1;
+	while (1) {
+		if (agsize % (awu_max * 2))
+			break;
+		if (XFS_FSB_TO_B(mp, awu_max * 2) > UINT_MAX)
+			break;
+		awu_max *= 2;
+	}
+	mp->awu_max = awu_max;
+}
 
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
@@ -736,6 +762,8 @@ xfs_mountfs(
 	xfs_agbtree_compute_maxlevels(mp);
 	xfs_rtbtree_compute_maxlevels(mp);
 
+	xfs_mp_compute_awu_max(mp);
+
 	/*
 	 * Check if sb_agblocks is aligned at stripe boundary.  If sb_agblocks
 	 * is NOT aligned turn off m_dalign since allocator alignment is within
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index fbed172d6770..34286c87ac4a 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -198,6 +198,7 @@ typedef struct xfs_mount {
 	bool			m_fail_unmount;
 	bool			m_finobt_nores; /* no per-AG finobt resv. */
 	bool			m_update_sb;	/* sb needs update in mount */
+	xfs_extlen_t		awu_max;	/* max atomic write */
 
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
-- 
2.31.1


