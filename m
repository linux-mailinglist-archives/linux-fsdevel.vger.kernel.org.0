Return-Path: <linux-fsdevel+bounces-47844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7A6AA61D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E821BC3B37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF96122B5BC;
	Thu,  1 May 2025 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j2YHIa8S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SBWoSiqC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2302522839A;
	Thu,  1 May 2025 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118732; cv=fail; b=oSVPT7yxBPiyCAbc5D9n4BJbfeY0wtGaFl+RoJT195CJF3BJZU6PsMtNWUswRbvTfP5RTlPK0rJFdggbD8YuB9LoFA2KSEmRpnSoBouddsc0E765UUi3QlZOtXqg+bWH7JChZwTwuq1MXBGmtR1FOhKuxH1+sS8qEMSQu4ay/A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118732; c=relaxed/simple;
	bh=Y+h0SeI/WhZZN7iLnPC7D4DvuhV4YxHgH5qJQhdZCUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XN2GOEsgiCCKMuEd1Vka3cUdUdZJnePKfI43VLSqT6KNM1wsdGSY9fcSGqVEHsRFPon4Fn4hELvNn/UKmeCB2D/f+U9EugiQNBgTygaGO83EHEAyTdIik3jucTd+Dsdhw3uEzowy302A7efrMBI3t8nFaLXPT4hI5ANoLdGXojw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j2YHIa8S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SBWoSiqC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Gk3Pb008040;
	Thu, 1 May 2025 16:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Knrw86SB2+FjQtTS7zEUket55dWzKrgXBuOYNwpvZuU=; b=
	j2YHIa8SX3/QGNdXd6YsCrudfNj+8nHPoSUvXa22y70S0QjoccOpHOFjOOy56Tiz
	V4sFdTSRa9OxlmySNLFOHPjy95mmGuEIr0JmJXuV4U1IvdSkSHDu3DgRiLwpOwB7
	rBlkDTC5XLt3Ns1JbB8jtZJ9ao6U4SAbcJcefoq4ddpozyrgCkiziri7ZTfBkgLB
	RzWd9uAIvdlb63fT1m/R/KOtm2i2PT14VckTP4iHarBRY+YZJYrFt/FUTHKKrUBM
	APEnZK+5EsUXnJTSjGP311KDGEon74h1VU0Ga9QetRZQB18hBuLBCeMRaGgYZ1Eg
	uE7G/iRmhtJ0y7JMVdF5+g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uskftq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541GKbAX013815;
	Thu, 1 May 2025 16:58:31 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011029.outbound.protection.outlook.com [40.93.14.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxcs6x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeBtVeTEocrQXcbakYPpPnuobtCQzuR9GXdLDUKrsiGHzcb2+sk+6cGdyx3VNNvqvMJeQfzjgk+21HG/QrkNzBqrJHyrhGrpZmNj/3TcY2m2kAYn9FDQqM3agow3y1R+V4LD1IpNwVFdkm9+9C/Ad88EdaTdaQIik23H2E06xIlXEcc24eoQV6YZFdXAe4+njK3LC/iqWPGTRZdBk1X4dhhBrxZQMghCzUmJkKWoiw0A/zA8dehbUxV5RRJdebE6tYguHH+tuDtOqQgJRuXyfNrar2UNdLtTRF0qcoKwUIGkx7OKkvOrYWg40iVTbXlTbaZQaK7xOj+96wCs6xo5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Knrw86SB2+FjQtTS7zEUket55dWzKrgXBuOYNwpvZuU=;
 b=i0IfZK/g9yva10ZU6Ln1TYF7wSIwRvbad6IAYrKb7zxkXyT8xUhuaYjpDu2Ru9SYvt2QTvmJqL77tWXMRikLu3rhfZ690ud6kYzA0BUnlH2yN1zO8RAgHHq+Bb8oFPI9njE+xCKinEJktRp3dLt6NNnbpWtiq1m9GQnR1OKaHNcPIK0vwltfsGNApdFvi6UCjCct4Qg7iz3BaUe9xRFUmnGQbCTrzx+HXDYfOMLkLKhrO7x/6/eNjvA5KbdQtGd3H87HZwQFjSCCQAvzFCz9k5paeKTRYKjcSdEPW9jqgbk+ww+xjiALaxW8EMqWOjXWEHLo9hDsf+QcRTmhFRSTXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Knrw86SB2+FjQtTS7zEUket55dWzKrgXBuOYNwpvZuU=;
 b=SBWoSiqC8OadTrS0P0YgF2NaMZrsOoSMu/0jFWBMaQJ9xOBgQqJzs29gJqdaBMUGhEUbYYj0O43FMEwglxEGGy6m0aXRPGfZy+mZw0gk8Toizn+xkhtTiECJGK2z2UNGBgqJDpSB6lkt1Xko5jTSavKSlWVq3DnH20PjXQAuK6o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6040.namprd10.prod.outlook.com (2603:10b6:8:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.35; Thu, 1 May
 2025 16:57:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:57:51 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 03/15] xfs: add helpers to compute transaction reservation for finishing intent items
Date: Thu,  1 May 2025 16:57:21 +0000
Message-Id: <20250501165733.1025207-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: c9137905-f315-4645-8139-08dd88d14f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9sSiZgubdTmmdIcmcPTWgCsKZq5ZTR72WQT6nhQa0lRqm9itPTx1wTorz1Kw?=
 =?us-ascii?Q?WbZNcQzyhPQShWM5x1H53s7CqQkvD8tnuDYWb4vufqehtGNgPeHQpzpQSKtt?=
 =?us-ascii?Q?u/0dzv87CjAqDmtDNNo5qsIweH8eqi7YKsTi3owteadmY6Bzk5DI0S3rp2ul?=
 =?us-ascii?Q?2ryzh9ne8IUYiLOwr9w7CFA8jXWFpcwEinNA37J8TFbg0ZnNeq8S/8yKw8GO?=
 =?us-ascii?Q?K58Y1zTAoF9UxqF8R49qq5ZESF0mrY3/XogkZ0NrTV8zXK2szxSN2JdjAcgX?=
 =?us-ascii?Q?MAiHIAEb6B+1h9RrDyFAKsVYq1tjnGoxJFbYUvxYV4jidrygJvXDBjBhFMBH?=
 =?us-ascii?Q?BiDMkJn9xkB0fR20oL9kR+sVCZigXQZ/1iAvv7bT9KbpNi3jBV9rHm2jWD+z?=
 =?us-ascii?Q?j/xGu7tENws1QzZZYXxxV5QzNtzNQv9aKqTI49p6IRjtb3lhuEPUCTohgatr?=
 =?us-ascii?Q?Li1xTIn45kDiE4JY6xcMDsviOO/wSnuSD11fH85LZVF/v5iTaypLzyxoAaRr?=
 =?us-ascii?Q?yNqZrx4DwzHYBzRj4TwmLpiqwCCgSzuWgrIeVy9mYxp5scNlIHze0e74yuFQ?=
 =?us-ascii?Q?YbY3bNmdB+LwYz0Xzt/BfNYPAk2KCqqVU4zwEws40pKL5aS41ZtXvv0lYLWs?=
 =?us-ascii?Q?l73tFl1Xt3fE1+ntpRnOuzIwpJ2O5zMU1UDqkq2UbXCUX8LqwaVc/RfY8Clz?=
 =?us-ascii?Q?yKwMn4lsbFo0d+UkM/t34yBNjxAtR8wmlxRM1MWPnRPGGui1qys9T5Hm9Dil?=
 =?us-ascii?Q?NToy2usRnFHEvgDbvV2N4iagZSJYeq5Plzu/0t7ILRVbeQR2ed/NM60Tch8n?=
 =?us-ascii?Q?L+Hyc2IWdS9IqBTM8XxUyR8IxJpErrYpwiiOi3sKtNf4aDBmvdKTu45Ywosm?=
 =?us-ascii?Q?ZRUpv0BRPUTbKBE8mYOQTNUgSz8yme+ruloL7QHBgHlLcq+RlRNEKjy45Do2?=
 =?us-ascii?Q?5vn2hzMoT7UztvTxFl8jrUnMx0WAVBEvK9Dih5AA+BbefrpjuIp0FW9Fl0AN?=
 =?us-ascii?Q?BQNucEpaozKxdT3Cy1mAo0fMDE7G2W8oUHX+Hj/g1BLzVF/04LlQd5LFSCKK?=
 =?us-ascii?Q?b64Mr9RWZSLhgLhfAVhGjAsmwfARMnty7OPG+ABWKf6RcNWKKG7PyhvEj78Y?=
 =?us-ascii?Q?OKVtRTkBwqOm5VBjUQ5HjGvZKJeQja3f4tFv/n2XcIQTDJGSSs2nzIWj9Spm?=
 =?us-ascii?Q?+cQVh96zaaJmAv94NkGmTeQhS/47LAB6ScWPYlrnVDx8xOXDpqlURhYNktnb?=
 =?us-ascii?Q?36LF3y8BbXFdK5bY081qfZ6CJvDR3rkCPDapHcbPfuCnM/HewBpkkntgaytS?=
 =?us-ascii?Q?BXDqa7T03s6EtEr72EQHw3Vebs2QWt/ci2vOBBT+a62iSrW69wf/lt2CxZJH?=
 =?us-ascii?Q?i1Ryjb7ebftU1yXKKpR6Tr928YlkEwxijOuTfaLjOPmmr44EXfEn//DLB6fH?=
 =?us-ascii?Q?E+brRHa3Syc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tMKeV8BJ96kuypxFG/GCvWgbimPW72oyGB9NyWvlAFzvoJnbWtZM/KX/qHni?=
 =?us-ascii?Q?SQ5lKAfAooMvRXVnT3+z1yPFh5kA3dThKWwCTxKKQXRrJp2AvOHtO4FLPP1p?=
 =?us-ascii?Q?fmPS8TffiWgq6P8+ZRmqg+4SciO7BF6Jqa7Hg3WYw1NKVQQlwLPbBEYwkk0V?=
 =?us-ascii?Q?6A7m1b1T84UJem4h15GNKZ5+6oTrd2J1eaILJmBwJnKlI1OVW2ybv+qQNtn0?=
 =?us-ascii?Q?7+Pl/leTJc88PRN5utrSPgXWhdE/3PXcTIoFjuDCjGU4bXSnITHPRhFL6c2w?=
 =?us-ascii?Q?thznfLb4NV1VdJHurjIU/wicFBkRdFfPsgU01M8USpNcWCBlAhqpfXlCaZqD?=
 =?us-ascii?Q?G49olXm2v2YfgcHkMTfaGCeaX8KnB7qXSGknWJUcFLmtfS2KKA5tAC6zr9YX?=
 =?us-ascii?Q?E9hWU1SCeihmzqpyORBCFzOyku5kTt9MeO3lK5Ls9guRdK9xXCrbaN/8/mJy?=
 =?us-ascii?Q?Kwi1Q5WYfYla82HeSIHbOL8Ay7C8tBEDQlTs4gWFrUWX9iemO15zKx4gm1TP?=
 =?us-ascii?Q?6SajrJmAnbIJ9wPt1cqZ+LS4WcuFuhhs5+oZUPXXIPbOn9hhGxFejv904ud/?=
 =?us-ascii?Q?PD3ldrxS1BFodhLzoVMWMwbFhPEALPZ7hRalUuiC27/BukmWZBsyGNlBUhYg?=
 =?us-ascii?Q?fuUb36UXSUvgHA0RGzwJ+WiUR3daHcV22MuF24W49B2eMqdNjXAW0SPyoH/a?=
 =?us-ascii?Q?NiAbDAGzSr6kkCa85UilqOCj3XlpMCIzL4XgRBiMsqp8q61gesEsmMxFo/iE?=
 =?us-ascii?Q?fXphDWdlKHeR4VRzSAwBduRDipu64H5RlhQ/CbXNo37MIImKuZsIbv0lbXtF?=
 =?us-ascii?Q?USfxlISaadipp8eND1+5zJuD3DAnwSwRIYvlMtmS6t1Z/i/BTKxOoKyR4kH2?=
 =?us-ascii?Q?rzaR/Qsgn1VMuP58lcpUEL3XqPVEmzw429HKnEpyEpCsvk/MjgLtA+y2WpIF?=
 =?us-ascii?Q?g/f+cEgD53E2DiYWAQBpvqdigkVEa4BPiD+eR4jn3BSDCxSe5gy/5zm7Aby3?=
 =?us-ascii?Q?pqiwPvbkPf3HDvPcwiSi7f/fsKvOdj+Mgxfm2enxhEwk5WHvwoGxfKfzUXsN?=
 =?us-ascii?Q?h8xjQXy9eMtanBEArQZmJkKijLpWhBMwI/Pe4NI/CP+we4GWkzUx5hHnq0OM?=
 =?us-ascii?Q?abmVzqhRUvI00ooPy5oFhoJWcCnCdl9Ltr3WsaNFmKabloLAReM12jyiP70h?=
 =?us-ascii?Q?rwiXg/3oIZkKOxermfixlbD+hzu3xAoAPA7mRKs4SpiGRrPa/Uwc1mU2N/qw?=
 =?us-ascii?Q?oJ6k4zH86kLuIRQief3ZVL546RSNC3eeOBZlMLWwZ3ccKsCwV2qTkuq9sbWM?=
 =?us-ascii?Q?TiugLoh5BO2cyUdTfZ2W0T80HM+uDrkUnO7zLxhZukDHK1uXaUh5NdUwUW7M?=
 =?us-ascii?Q?0fgz49XzLFNCdrw8XuSjowTFQvm0Hb0DSv7T2PIZVYTeMfyHEOX83++eGC+O?=
 =?us-ascii?Q?rRIgZdyUj6KzM74DnkE/8wC19KboPENZXUmX6zDVE9u/4MWFyiVFkEQtoZyV?=
 =?us-ascii?Q?CXhNvyuAcc1FM7r9SZdddzGWzRtpV92fB9IgxNt9P8RDA+PQqfj9C/7t8pb6?=
 =?us-ascii?Q?F1VHpM5LAwHQ3j77dR327y4aeUP++R+7bMJlKZa4N5VgpRW8EUYo4KdOoPY/?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1c3PDADm5Miwpi2KIDkZ699JBEsQonbfpUn6ApLxaLyy4S7SM4SPZBUegtjDyNunVgsTB0YGsjqm1OwVzTGuTrW7ZMhv+aiI5mm9duPC2vB5Iefm5mh7QSOxYslcZGmG6S3wQSr1ZNCMefwKtTQj16TvVe0ZouCInZtnZxGQ3yRZeBuo1RNIU2QlvgRLd+o2J1YgrvDA5yE0+ucbJqo6nCaJWtW7idBoSGNiBa+btI2VriwOuLkDZz/qt4JmvT2FbQjwhCM2HVBaiTLCA4kO8ZjWWkUCELN+crUINio/02CLnOrAnlnJcpKWjzrlGJl4W46AEwf+aiHfBBdF3xmfBhRYjr6a0/vnLZmZHPqvJDLFK8eh1SeeF0ADfqeVWXfVBAW3pOugxlA53ER5nRxcOBNxRP11LlIa3LL/5z6yeEwTG/B76DisX5p7rS5Cb6qFMSiQlKVgfV5qb4bKXuVvhWofPHkA0yvX/OtimLXhM0kCkGzZSh47+bsa/r7SKlmRA3gPvOfAIn+uIVvJDSA8OWU0YBhOCrkNhtN+G94aIkkE6iwkHj350CXSkncrFsabLbBgf+czg8u8P4w3/bRzDGf+TvgHQankai8J9k4rulg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9137905-f315-4645-8139-08dd88d14f3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:57:51.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51hgMBvWj//oxiVNtd6je7hJsCuwAoK7O95OGLVg/XfiXfWA0NuhIi5naU5Vx7yqkw8opFQ4ujv/Kno6wDrbfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505010129
X-Proofpoint-ORIG-GUID: 5SduNN548ndzahgae36j4qrzkVu871q9
X-Proofpoint-GUID: 5SduNN548ndzahgae36j4qrzkVu871q9
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=6813a838 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=woQZa1pMVDXcXY9PtcEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfX84znFAPOgcN3 nUsGtBtdM5dj26ILTFrK1fWq11pw9BTgeRhFipC2z0u8lR7KWD6pKghu2PAhqNGVkB3DTl3TDe/ n0fnR+ioqMkD6buGrniGNE8407XwPnDbDOGoMafoN10I4bWYcAQKjPIinpm+wJXYM/kW84XU27v
 PgDunXwHhAPR6ZRLPthF+EaB4qO5mHjTIXkGAvo4/r+JnX3Nfnvc8hb2487bzi/y0ogicrt7VE2 JaxBjhlpTtR1rvCcwHB/GAZ7QxTU74Jr4mvt/IyTkTPpPXqBsxSPMwIx0i1e+b8PRt0tiA3/8iz OOeejLNi1VKpAZbMe2SjZO6dJWB2eYDcTFYFtwf04X0VjiVeCnMT0AgVZxlWmr1o3hMhdq6QPPH
 P3DuoWBz2fjdd0JnYGDcHDg5J6ECzsrS0/Ib+zNKJywCl+xDfIb0mcrP25D7sGn7/l36bNkf

From: "Darrick J. Wong" <djwong@kernel.org>

In the transaction reservation code, hoist the logic that computes the
reservation needed to finish one log intent item into separate helper
functions.  These will be used in subsequent patches to estimate the
number of blocks that an online repair can commit to reaping in the same
transaction as the change committing the new data structure.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 165 ++++++++++++++++++++++++++-------
 fs/xfs/libxfs/xfs_trans_resv.h |  18 ++++
 2 files changed, 152 insertions(+), 31 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 13d00c7166e1..580d00ae2857 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -263,6 +263,42 @@ xfs_rtalloc_block_count(
  * register overflow from temporaries in the calculations.
  */
 
+/*
+ * Finishing a data device refcount updates (t1):
+ *    the agfs of the ags containing the blocks: nr_ops * sector size
+ *    the refcount btrees: nr_ops * 1 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_cui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr_ops)
+{
+	if (!xfs_has_reflink(mp))
+		return 0;
+
+	return xfs_calc_buf_res(nr_ops, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_refcountbt_block_count(mp, nr_ops),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Realtime refcount updates (t2);
+ *    the rt refcount inode
+ *    the rtrefcount btrees: nr_ops * 1 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_rt_cui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr_ops)
+{
+	if (!xfs_has_rtreflink(mp))
+		return 0;
+
+	return xfs_calc_inode_res(mp, 1) +
+	       xfs_calc_buf_res(xfs_rtrefcountbt_block_count(mp, nr_ops),
+				     mp->m_sb.sb_blocksize);
+}
+
 /*
  * Compute the log reservation required to handle the refcount update
  * transaction.  Refcount updates are always done via deferred log items.
@@ -280,19 +316,10 @@ xfs_calc_refcountbt_reservation(
 	struct xfs_mount	*mp,
 	unsigned int		nr_ops)
 {
-	unsigned int		blksz = XFS_FSB_TO_B(mp, 1);
-	unsigned int		t1, t2 = 0;
+	unsigned int		t1, t2;
 
-	if (!xfs_has_reflink(mp))
-		return 0;
-
-	t1 = xfs_calc_buf_res(nr_ops, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_refcountbt_block_count(mp, nr_ops), blksz);
-
-	if (xfs_has_realtime(mp))
-		t2 = xfs_calc_inode_res(mp, 1) +
-		     xfs_calc_buf_res(xfs_rtrefcountbt_block_count(mp, nr_ops),
-				     blksz);
+	t1 = xfs_calc_finish_cui_reservation(mp, nr_ops);
+	t2 = xfs_calc_finish_rt_cui_reservation(mp, nr_ops);
 
 	return max(t1, t2);
 }
@@ -379,6 +406,96 @@ xfs_calc_write_reservation_minlogsize(
 	return xfs_calc_write_reservation(mp, true);
 }
 
+/*
+ * Finishing an EFI can free the blocks and bmap blocks (t2):
+ *    the agf for each of the ags: nr * sector size
+ *    the agfl for each of the ags: nr * sector size
+ *    the super block to reflect the freed blocks: sector size
+ *    worst case split in allocation btrees per extent assuming nr extents:
+ *		nr exts * 2 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_efi_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	return xfs_calc_buf_res((2 * nr) + 1, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_allocfree_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Or, if it's a realtime file (t3):
+ *    the agf for each of the ags: 2 * sector size
+ *    the agfl for each of the ags: 2 * sector size
+ *    the super block to reflect the freed blocks: sector size
+ *    the realtime bitmap:
+ *		2 exts * ((XFS_BMBT_MAX_EXTLEN / rtextsize) / NBBY) bytes
+ *    the realtime summary: 2 exts * 1 block
+ *    worst case split in allocation btrees per extent assuming 2 extents:
+ *		2 exts * 2 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_rt_efi_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_realtime(mp))
+		return 0;
+
+	return xfs_calc_buf_res((2 * nr) + 1, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_rtalloc_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize) +
+	       xfs_calc_buf_res(xfs_allocfree_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Finishing an RUI is the same as an EFI.  We can split the rmap btree twice
+ * on each end of the record, and that can cause the AGFL to be refilled or
+ * emptied out.
+ */
+inline unsigned int
+xfs_calc_finish_rui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_rmapbt(mp))
+		return 0;
+	return xfs_calc_finish_efi_reservation(mp, nr);
+}
+
+/*
+ * Finishing an RUI is the same as an EFI.  We can split the rmap btree twice
+ * on each end of the record, and that can cause the AGFL to be refilled or
+ * emptied out.
+ */
+inline unsigned int
+xfs_calc_finish_rt_rui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_rtrmapbt(mp))
+		return 0;
+	return xfs_calc_finish_rt_efi_reservation(mp, nr);
+}
+
+/*
+ * In finishing a BUI, we can modify:
+ *    the inode being truncated: inode size
+ *    dquots
+ *    the inode's bmap btree: (max depth + 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_bui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	return xfs_calc_inode_res(mp, 1) + XFS_DQUOT_LOGRES +
+	       xfs_calc_buf_res(XFS_BM_MAXLEVELS(mp, XFS_DATA_FORK) + 1,
+			       mp->m_sb.sb_blocksize);
+}
+
 /*
  * In truncating a file we free up to two extents at once.  We can modify (t1):
  *    the inode being truncated: inode size
@@ -411,16 +528,8 @@ xfs_calc_itruncate_reservation(
 	t1 = xfs_calc_inode_res(mp, 1) +
 	     xfs_calc_buf_res(XFS_BM_MAXLEVELS(mp, XFS_DATA_FORK) + 1, blksz);
 
-	t2 = xfs_calc_buf_res(9, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 4), blksz);
-
-	if (xfs_has_realtime(mp)) {
-		t3 = xfs_calc_buf_res(5, mp->m_sb.sb_sectsize) +
-		     xfs_calc_buf_res(xfs_rtalloc_block_count(mp, 2), blksz) +
-		     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 2), blksz);
-	} else {
-		t3 = 0;
-	}
+	t2 = xfs_calc_finish_efi_reservation(mp, 4);
+	t3 = xfs_calc_finish_rt_efi_reservation(mp, 2);
 
 	/*
 	 * In the early days of reflink, we included enough reservation to log
@@ -501,9 +610,7 @@ xfs_calc_rename_reservation(
 	     xfs_calc_buf_res(2 * XFS_DIROP_LOG_COUNT(mp),
 			XFS_FSB_TO_B(mp, 1));
 
-	t2 = xfs_calc_buf_res(7, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 3),
-			XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 3);
 
 	if (xfs_has_parent(mp)) {
 		unsigned int	rename_overhead, exchange_overhead;
@@ -611,9 +718,7 @@ xfs_calc_link_reservation(
 	overhead += xfs_calc_iunlink_remove_reservation(mp);
 	t1 = xfs_calc_inode_res(mp, 2) +
 	     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp), XFS_FSB_TO_B(mp, 1));
-	t2 = xfs_calc_buf_res(3, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 1),
-			      XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 1);
 
 	if (xfs_has_parent(mp)) {
 		t3 = resp->tr_attrsetm.tr_logres;
@@ -676,9 +781,7 @@ xfs_calc_remove_reservation(
 
 	t1 = xfs_calc_inode_res(mp, 2) +
 	     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp), XFS_FSB_TO_B(mp, 1));
-	t2 = xfs_calc_buf_res(4, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 2),
-			      XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 2);
 
 	if (xfs_has_parent(mp)) {
 		t3 = resp->tr_attrrm.tr_logres;
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index 0554b9d775d2..d9d0032cbbc5 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -98,6 +98,24 @@ struct xfs_trans_resv {
 void xfs_trans_resv_calc(struct xfs_mount *mp, struct xfs_trans_resv *resp);
 uint xfs_allocfree_block_count(struct xfs_mount *mp, uint num_ops);
 
+unsigned int xfs_calc_finish_bui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_efi_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_efi_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_rui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_rui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_cui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_cui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
 unsigned int xfs_calc_itruncate_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
-- 
2.31.1


