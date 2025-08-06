Return-Path: <linux-fsdevel+bounces-56805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2643B1BEFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 05:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54898626BB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 03:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE571E573F;
	Wed,  6 Aug 2025 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PTRpiMGi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pcbxD3VN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D019E975;
	Wed,  6 Aug 2025 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449407; cv=fail; b=Urh3vyvRpvVIj2tbcjS884dwVeqgRz0e9Updxoxk6xN66Gj/4WxehnXF7/nuVjkST5Puwuz+863/9akNzcnQF1fbVAL4nnz0PzDXREtnTWbZ3OkS0rXdM9IP3te1y6S3GW7fw6GguB58LA0/MbIZQWskHOQ87J8q3Y9CgmfyClM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449407; c=relaxed/simple;
	bh=6dpOyEsHQDztv3cDjze2eQJSAYuC9i+BLNj3Vogaq3U=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=mrmpE3g/a9H2GfPdoKq3HFnmw/W9g2S4eYhwo5t9H1GRP3Uj5fcIeoCiN5Hi6B4mZaA5vuwcQe0J5JloM4oHoGVK7mDAzRvHZik6GuEoeXfIHI4ZN2l3N2VEGXUPlmEM+K6GtZKnoN3miK0XfzvCNS2f7gBjmOrEvZI6ma92odQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PTRpiMGi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pcbxD3VN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761u7ii021242;
	Wed, 6 Aug 2025 03:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=SIRslR36nSvEaR149p
	ZtcUKD86ectFlCh76sLbYZqDo=; b=PTRpiMGiQgDim+CuxW9bBWeXbN0qRMQA85
	0b5mTEigs17Mua6GXKuYrz9AAHgb/ilCtxvQ5AMQOkfYH8A3ZL6A2IlEIsc1gyxe
	joL1z8U2MRkXJXbcHayPODL+mfDfxYxaO/ADO/IMqYpziFaJAdG0L1yY0gOilBFu
	+lS30EbzCzg5HCZkfjCXTTxi8hpZvQDLB5p2v/NxSkehJSVgVGEXT1UXnj6hCYH7
	UVbUjHdEY8UC1iECyVJ/x2xu3gRAoLecA4kTu1FHM/9rmKbFVlT99OXQSwbClqHI
	Yxdp9q5xVE67SustLXXDTj6JVTy4DETuXBnVZD71MNnQjtei9Upg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvjrmy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 03:03:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5762ow88032102;
	Wed, 6 Aug 2025 03:03:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwpxm10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 03:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5nPO88YEXwkCuczpb3+Zuzd+cIa6/813Li9KPoXXPQaAJr0/r4YUoFfMmZwPkU2SsP1+F6Jz7Z0GHIqEO78z5+f1kcFLoXi4WQHLsTPg1EkdPfSyEHu3Fix4ocPpP9VJcsrL531Tus5C8aWEO6Y0WCVQL33qcroCSbvUfoVOLO6pht2o2vTa3GI9CrDY/BgTKB68PaMyBnGzQVZ9ZSlDaIozLqOz/pWjx19q+n0Bbmty0AxZhXEFZ/5jKV1jHwuKUoCFQN+0MUPnZyd2abMjvVRWqBBJIgPUe3of2qXtr0NDOqS0ecO+KmskoS4UKfBdWq30ujyk1C8BhibMWd1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIRslR36nSvEaR149pZtcUKD86ectFlCh76sLbYZqDo=;
 b=gUmRk4il5bsz58hsm7Kxu/ZcaAADtC6qu5LaEsY2BqWhe9r09M/SXLPxdh7G8bsGFQXbGlyruY6MS8yvV3UlLOMOw3VMRyQJBsahssfdJHPA1D8pX0UJvWCKPqemRcUy/uN/X5gxaXBYXyRB1oLKtfGUWdnhEgdLzUK1+416khkkMpy5mjNV3INtl98J5BgMN6wUbqGQ2AMdAS6KxEvsoJa5LLotldk+TsyRkg3TH1geTjqvhWjUdztzloFfaqjvJ3uJtGNaNBKRxRELinfkqNHgoT5epToG5e8rgxF6m8cGo0+JhLN44ZkVfM93giPgQWlwBikf8jVn1leYfAgvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIRslR36nSvEaR149pZtcUKD86ectFlCh76sLbYZqDo=;
 b=pcbxD3VN9LnvfokA0DYiT9PFdo74xttrF4/I5uvCCme4s8oXPWRZtZDPo0jAApHFlILZjRLXTx83ZWhL0Igxm7wPqcjtp9XYj6O0RSAH3i0TpoJyHMUobXAyfMokCWZXEnQtnwjUvwML3jkcvLYicU5/IMiHJg+RZTqSnR1Mwo4=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS0PR10MB8149.namprd10.prod.outlook.com (2603:10b6:8:1ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 03:03:16 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 03:03:16 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <snitzer@kernel.org>,
        <axboe@kernel.dk>, <dw@davidwei.uk>, <brauner@kernel.org>,
        Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCHv2 0/7] direct-io: even more flexible io vectors
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250805141123.332298-1-kbusch@meta.com> (Keith Busch's message
	of "Tue, 5 Aug 2025 07:11:16 -0700")
Organization: Oracle Corporation
Message-ID: <yq11ppp9mtk.fsf@ca-mkp.ca.oracle.com>
References: <20250805141123.332298-1-kbusch@meta.com>
Date: Tue, 05 Aug 2025 23:03:14 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH2PEPF0000385A.namprd17.prod.outlook.com
 (2603:10b6:518:1::7c) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS0PR10MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d88fa5-da31-49b1-2d95-08ddd495ca42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJQz1ofahCB5a8m3aT3pHf9fLu1q/s2CVDc1lLI21m8uM/WiApu0P6qWqUiD?=
 =?us-ascii?Q?zwLon7chksGvnwe7Hubv3g1zZbCxxE/VxHXo2vPp9uv3dlrL159M+G1YQGN/?=
 =?us-ascii?Q?l+4aRtR9qU6Ijc2bD14kJh4eeEOJrgKDKvUHEUNlbs9B7mK5TSLS6m0EeKMO?=
 =?us-ascii?Q?D8xYvzv9owDIBQd1CCdNdWmi1P9SHR7W9AN0ypifB7q7SmwONN2wfdpDng+u?=
 =?us-ascii?Q?b/VB/wYt/HhxYEYfyBdFBVgdY+nmOMjba6u34Tttt40QAWCOs99HRWFg/FzS?=
 =?us-ascii?Q?e5i1uf88JCJxcOp4L5m9wuhtbXZKCmg0VZTTHijYQ0b2EcAYHbzBUrt2Ml1x?=
 =?us-ascii?Q?gSbY8aEuUaBkS2YHHy5hLJJemRmIlnpsLMESfmhDMzZZQ0bSryPhmw0m7rRg?=
 =?us-ascii?Q?me5Wav46aShZSRuMGYABs+5N7ssAkBOFlkhbL1URE8IWN843uJxMQ9Ds9Wyt?=
 =?us-ascii?Q?41HKxb3GP4oP4nSn9cdDKsOP68ltGnsAs4Y5MiVaej/ON6UmXU0vo1SZ/jZP?=
 =?us-ascii?Q?x7xh1QApHjYYfpgxkvGuAfC2bBxbflkQeGt860lwlGMhGRjEfufC6vyKxqov?=
 =?us-ascii?Q?Ys020HJzQHP2OZAwPSdtoJ+Z2eaMkgb8F9uAIO6cJWJyDw5aVTtmFFBtLd9V?=
 =?us-ascii?Q?lzExKZDa2Lbcurdl/D0CDfDG96cf/q2fF1NEnplq8AjWzcPUkcXTjZxN3V8G?=
 =?us-ascii?Q?lpjNpXI78JMzqftiG8JGlEFq2zp2qkmOCYJ/M84RjwITICvyuyp6xogDyv4u?=
 =?us-ascii?Q?mN79IJSqe3Zdfbp6y5KOFPBaBtw6+yhuDQeqiWdGw+InHI/6emcoYTkgGwau?=
 =?us-ascii?Q?Awbron6SCBcoeHOy8+qga7npWBXueaXfWwwgzMYQgzmsPuPnFA3Lt9ZzbabU?=
 =?us-ascii?Q?i4wNvwHT8toUvHCVv4p8W+BF34HrkZuQQGmSaWyZKH3s5p1zUsfG7BcTtXo2?=
 =?us-ascii?Q?kY5/O042cFdqgL2uebVqT6q5ihZJbWls2mk33xUDeQo4s4Qea21Gous9D+tN?=
 =?us-ascii?Q?UT23L6oI4lUtods/2/Ka6v095yC0r+qXnEAYk7830/dDkjGJWGMO06gQyS5b?=
 =?us-ascii?Q?RGlN7KuOnrnBoz4zIh2uh3/XGNcYUSAeRQhrN3zaJ1YLYsDt8TAz6mtSioTf?=
 =?us-ascii?Q?wvSov0pOEbU3jaEUsl15IjdIcLhQK6Fb8rLSqJVugS8F1uGZGiCFyYhYSGj5?=
 =?us-ascii?Q?DRTS1VYslz9PtTo+K2uT7tJTpz5/FByx4R7seW+areXApXUtqIIrm6ubV5is?=
 =?us-ascii?Q?Htj46zSaQyHzmdmI2BGp08Xwd0d0ARd8XO91RmV4uq9wNxEwd6tyaOmR7uHW?=
 =?us-ascii?Q?A5piuz5BOrSBj+z4VLSfntXIUTKduRGNMrvPqI5lZ8J31WCujSKlkIpjL24X?=
 =?us-ascii?Q?RDOQWCXgwC+204SDcyjx6/uJmkjg2FG4sma9yRIury8c9AUeSAKdUSUg8vtR?=
 =?us-ascii?Q?Tha5v7INdWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hDap9LhdVJ5KVdo4SDvoZ8lCludJ8NUnfmXtKvvtjEJ9t6kI2Z/GHQcNfrPo?=
 =?us-ascii?Q?XT7JCdYTMklss3eQc1RSlJV06AaTCzWr/NapQPNh/99Zdjc+yeaMDUmK+z2X?=
 =?us-ascii?Q?/8Y3bmimCh0oZtpdfc/eYem2lrQcCgV37BgGxuvdHhyZfsftZvii2R+rKjMH?=
 =?us-ascii?Q?70A98v2m4dZPe6BxB+c7u8XO6CurNevoLCF0t36PcIqfp1fxnjXJri4eynNL?=
 =?us-ascii?Q?Ys9AT8dMPWXFbxcaQCWwrclvmVEzwTaLSJUOtEMNcAxUwpACN5O0ViWUgq9E?=
 =?us-ascii?Q?+K/ITv8iF9K80mDs0DmzNbWeP/daQzUf5E7Nz/nCv35XcwHjZp1U4DIsbebf?=
 =?us-ascii?Q?b+FfqrNI5WYVdysTUqqsMvIMnb5RNpDK02tRgu3C5w6IA7oL8+3KcXSPM+4o?=
 =?us-ascii?Q?R4GBy9n4c/lT5mawHXygEnBR7vXTUb6HbdClYAPPvxR7yKe4QlEeyzFKmnSv?=
 =?us-ascii?Q?Db5P6L+3KV0Bzopp8RqUf+n074oLd+/z2xVs7baukerXKI4aq1LnyxvQ6oPI?=
 =?us-ascii?Q?90W94Re61xpBFYsqNJJjUKaV8WIPYT3AXfjdKEN68asZVMMFO480O5EA99dn?=
 =?us-ascii?Q?tDojm6Hi6Tp4KuXOH4Y35egsEd5ymtPK6sXcZKLk7gJ6YS7In51Pys84W8B9?=
 =?us-ascii?Q?woSEwoTH8IB+YtrSzf+qAfrTUlr49QBBgsr4QbGJQaQJPlidNl1uEuNUhVgP?=
 =?us-ascii?Q?XCXBpHTr7Go89LyW0JszNmNbj2M5D0v0W2zkmS4YEZvN55u5+UD9489oZ7gk?=
 =?us-ascii?Q?b5qwAEGK0crJW427ljb9+tahGDwlvYjbelItwJNQa73TGHDxWP2tI2ywiEqO?=
 =?us-ascii?Q?ExsdQnSRYGaWLSezc9VO51zIJOfFm8+rs+HIuOU1eYNUQ1mTCmuoihE5Zn0f?=
 =?us-ascii?Q?r6XLiuZtCizfC1YaNbtML0RNaRI/+a7H3VAaT0Qep8NKIc5UxgLF9AR59rPr?=
 =?us-ascii?Q?y7b9sEAWhJ8KNIu/Lvx8WLfmZvXD+UXeLi5AJEBV1Ad3a57sZAMcmjPRLI+e?=
 =?us-ascii?Q?wQ0WP7HSDypplK3UeODQgKsHRo018oktJdsn1eecSa0u73DvSMGGn+9iGPj6?=
 =?us-ascii?Q?5OlBr9bbPDlp8s/7KwL0vgioKKqKeMvhLl6x3AzJLDOtP8SMdf/8zdARM5cc?=
 =?us-ascii?Q?po0VejiImM3nb+kIN8MZI7LGwBoZyQeA1bkDxR7y3/TB3jOqRyhRc6RNxwnD?=
 =?us-ascii?Q?9xVhy5XfkEZ8UZtLwmdCPsC3hS6/jnIUxDQIASMu+zqmPr9lbW6VvyO8cpen?=
 =?us-ascii?Q?p6VN2DmXqbYFHetxODV1fG+ESCzF5Rtky+IfJZ/hKBhYoWQLSIFtUZj26yMa?=
 =?us-ascii?Q?VlVMzLRy5vnVRotzz3wkaVu13tns5sQaoEypCEkXsTnPHORcKnO8izzpfXug?=
 =?us-ascii?Q?1cZAxhzRTPeASdM4zluVrmh3kDIvaPh5hFlo9tTpXnJYesvf+XK7LBE78JSm?=
 =?us-ascii?Q?tyb43vmkXxTI5koTdQaTDsVXj8Ej/3tTfDvX017NO1Q2IpdRAzZYpRE22nSN?=
 =?us-ascii?Q?YEuYMeq0NRsQp8628W3UchC+TgWN8HX+WD3z7B3ahaFRRS18TrLR4477CGLc?=
 =?us-ascii?Q?h4p4HX/A2w6xnh0qrhvHBq0hB1hCVC/GGB9ptRZlOnQ+WEp/p/0atMtZ6LMS?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gPcYwdtOp5ZqUjThBU7xKfrAGI4Sfo2yyQZj16MLbrx/POb2pDmrv43L6Jfa4WhbuFlmZ4swyYF8rvikDhJJyOoTtnwG+KS+dJFpLXyMq+8Ggv87u3ZzHIjrypSKJZFCKegLt0JzwKF7+s3jQUu+3AFQxYefsqBr7nZhNNkTHqrElMftJmyXjmO4supserXuHPcmcsyrZnRlZSwi7u1Mb3vcwPSMfZur6KmdU1QCfSQ+zO43U/EYcyBBJc0bbt+IjEu0NSgNzV0cmraib8JzYhr74XeqZsYptMqaMdyekLCYmIwkl5fdDJuTIhCR0sbV0l/iWyVt/bsHVIutuD/dRUBchI/cqlKZJcy9XJeotgtAdu+jtWBX5i3K3fp6uceaoodnG/YB6+qT0WuMnFRADAURY9QTqNRYd/0JE473jzO7efiMvZ6XMP9cHQGb2hl728VLoAI61zEXyY7YfGzJXUZQaFXjZIQJfN+hM90AdhW92l7SPJ7ZVin9At2HHqfptdJCgRHfpsViks/jAmgchTJhLmRSP4pufGl2rJt5rtyA/MYPfMu5Fmhd9sAevK47jqU8sxuHfOU9tGOor+BpyRWrtwUpaS/hHrGEvn7dE1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d88fa5-da31-49b1-2d95-08ddd495ca42
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 03:03:16.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWrZca+FBJFr1qVrqZYrflXykgMWO37f7xqTex7pjR9ifYTHF4JjwJh3QJebcR+k9np0FTuBNKkVGNVx6a8HG5Y1iAYnxrDPpMHtEQoYhS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=936
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508060020
X-Proofpoint-ORIG-GUID: iPGpZuBCdC4LTOQ0aovlcQNPV30XPA2d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAyMCBTYWx0ZWRfX8OBwA1SIFKtf
 baMJ445r3QCbT71bUUTw7C9BYxXJJ+eOn91I9NPbzrOgek+z510X0K5wu0tvATZz+SSVsfU3yb+
 BNdsmOY/QO2OrWjMxSx/F5kDECySaNist6cZAQlDBmc+8TQq5Bmc5khoepjUej41zAEPqANnFGa
 xjfLxakPDjDIRHQgekhAlj/tA3c+ZJxqGi/L2LoVs6VR5cwbZYsT9ynvu5z45tdM8cxfkHUE7+2
 SGLle4HkFYkupH65+J4WMZ1+zBjW+PbbOK95epwie1cOowW2ir8bigR8xP7R+7DGbNsVtpPP2HG
 KyM3wscdIk754fPZffaN4xPyjANdZLU+JPD1MoSitXuJgQ+VVLfcyYdQstpBPs/eIkMDPjDyOGP
 thbvjHTtUzImHdeG2TkWKCvyChSd1gZKNAoqjuHoQa52Je/znnYAqmBO7/ppY23cIIDpRRYs
X-Authority-Analysis: v=2.4 cv=dobbC0g4 c=1 sm=1 tr=0 ts=6892c5f9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=5bH7z0BLeiDiQMqUfeQA:9 a=MTAcVbZMd_8A:10
 cc=ntf awl=host:13596
X-Proofpoint-GUID: iPGpZuBCdC4LTOQ0aovlcQNPV30XPA2d


Keith,

> This series removes the direct io requirement that io vector lengths
> align to the logical block size.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

