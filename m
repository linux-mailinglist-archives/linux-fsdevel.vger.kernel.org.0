Return-Path: <linux-fsdevel+bounces-30355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045D598A3AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB8CB27035
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDC618FDCD;
	Mon, 30 Sep 2024 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ebZeeEkO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pz5QHFJ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A968F18F2DF;
	Mon, 30 Sep 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700924; cv=fail; b=IXhLeQju7FhcS6IDWCHpuTCXjJexMFIAUBcU2r+XE1RGUqh9j1WZep/0n8IHfs6dtBhq5e1ivKqh3Ymg1/BOkFLB1x9FjCr3W0hjMTe0xu9rpzOVN98RsmZB9tz0GJRHJo6TQG7iJef3qwAUkvISnHfBmPoIc+C7TbDaBiKUbyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700924; c=relaxed/simple;
	bh=NinIDvEhirSEBGm7bFt3tXX01n/DkktU/GQXx95Z4ao=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZOqx787qUfaOm/nxyFzfqXw+mXqS7kVi7FOtb7hJOQEuO2VHCsfwHiD236PBq4iDGV7XGLMQDqJWVcDahej1FUlRbu0MxAhPM9HhMRzvrAfWk0mofBQHm/nJ/TSJY72hKM8hYAXQuOtUCIDhsVS8O0Kq7Y1MqRYJM/RvcvaZwJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ebZeeEkO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pz5QHFJ/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCUJAY021203;
	Mon, 30 Sep 2024 12:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=huGmzTJ8zuoJae
	v/esOq4qPXCvBYkwzqFZpl5JrQrj4=; b=ebZeeEkOqfG86FHE0/mFgFghbOd0WG
	50JZLG0xRHqdVHkeLDakP21fJ2Z1YKXkri/4rY5MBktEUhOT5NOSQZjdNOXEJGFD
	/ybfYj3FVwDdobdG6Bp+oknNOP7Fd7Sud81BF8CXQ4zQIimQKmoTSpIRIsdg+Lmb
	3aN2P1N5LtbfFB04P5kimDWVs8JGDXNwprxDgJvtzwmLBxJKW9SD9yyxe445y1i0
	+wko6WBXpiCqLI4+Ilt8uBQqWhlpUUm2NvuEEJstR38VYjUm2HWTB0SDgrfW3y15
	N1Wotu073nbKHJtpVp0hHnmjQtOf2OQytRhXc20jBSpLa4bKOKkmWx1w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dsu6q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:54:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCLlBB028642;
	Mon, 30 Sep 2024 12:54:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x88686dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMN427Nm6jJKVxsmfN+AiDIeAxZz7N4TuCpj2OyIuwhNYZZp3ona2cdYGJQlyKKqpuxuyDCSdRl0yzvMJoAmbnO2+jlwZ1gJXcilFFuaIG8/E5nfAvcJS81OfDThoRgHINWkTqpXPchjS43drEwcqfIkYzaIz8+//ueaFwf9lFU1/9gKQn0dwnPMuhpADrMgOQVKzIDX5Utt+3Kcc8cuHeeRWedA/ybSjehwDc8zjl3Bw7PQfY4Ig8XEf4UB2pQW3nQ8mqNfZvIykPYNTr2agcKcI693h009JsVGC3KFm3Qes6cIn9qtgZ9QHOva/rSC19jYqYhYj5fZZEJS80h0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huGmzTJ8zuoJaev/esOq4qPXCvBYkwzqFZpl5JrQrj4=;
 b=recogB1YiQJGw7CeawV23fchkrpJ2hkh0yQ1U3ax96orHRF85tSuYjNPF6KRDYDIHkLqoumQr2g9gRJmIptnUF0mZQHreuh/L83Z2O7AySpWUVOfbkxcsuEnK5pvUJTLqz5zZEXvniWkv2CGJmcKM/iZXv4alV5w5V3I/4vLqvNpstEw4vO5k3K4YiWJjKStGaNRYP5pbqa6jm6/Y5C7uGnBsZUnwoNtbVQqsxg7czsJ2d2f/mkIIOEQuwDnTe0ZxssJD3MKf9ElebKqz5z6KGrxjbZ1aLQ0DahjIo7ZggtR8+eRW0XzFkOWzbdEpvsZYigVs+d7gUmDJvFkyHs1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huGmzTJ8zuoJaev/esOq4qPXCvBYkwzqFZpl5JrQrj4=;
 b=pz5QHFJ/xh0q5EoY9ZRxNE1yUhTNE1Mc9mlS9rBOZoBu6u9VVuutXmQfcMPjR+qQrK+Jhv63WNnGC8vaXO4Z5wAn8Sg6Xb5LP9Ti8XhOxbBf4kmrvkMjA9nChqnEXRT4kHI8rYuRrUEd27uIwNgxRrmwpK6LD5iK1gy0sQDI+HU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 12:54:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Mon, 30 Sep 2024
 12:54:50 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 0/7] block atomic writes for xfs
Date: Mon, 30 Sep 2024 12:54:31 +0000
Message-Id: <20240930125438.2501050-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:180::41) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe0d17f-5e90-48ca-9747-08dce14f1266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nRY/lIp3qaAY0g2JxPUgNTQh+r+JK7t2iZ8bLjMPJnVGyMlCzBJEXYr4Xx/Z?=
 =?us-ascii?Q?6Fz5Xu12WKJAIrnArPUGbRj+j4l1ESIwOIsR3CDjInpaQUn6+tH4FXlXCdTU?=
 =?us-ascii?Q?bQ7GdlB1ueIHjdUYRdENp4XUKXa8K1ujoVC57MO/MeHilQuNTzEdHToF6hRo?=
 =?us-ascii?Q?vzMLT9u49gKYzTYWLkGlTPrTB/fYodMIQ9291ZyVvuTLMN2zOLJMHixrJSTE?=
 =?us-ascii?Q?6rpzRufzwwaGFcib7WWDZXCUVjGdPLqa+jwY+/1BRS4jAivbocGx/EGSCCa9?=
 =?us-ascii?Q?U1SFqVd4NKZf4ccJy/czoh200UE8b7DR2zEhJYMNQpQVl3fBgMlj1FDNpoQS?=
 =?us-ascii?Q?fdXqmal92vfl245ZEiwMvC/cmZnvSWwrbmokTvOcAAXe2d052bzgwEK5YNJ1?=
 =?us-ascii?Q?awnsFawPuc6sSEGdqN3VkdhP2SWnCPF2yhyOiX5Ihj5KfWdcnZyH3lRkyugX?=
 =?us-ascii?Q?fX3mY155uqisiU0C8XrSKrFwfr/wrgpypIWNUOwIiqWhY3SerlJNKIl+97NJ?=
 =?us-ascii?Q?44vdu7cUGRytX6lyOOPVvlLwasdTmGROhNjOXaV2EWYpNHtzaySlFI8eDtFO?=
 =?us-ascii?Q?jV9SootZTwtCgLGBw68t6a7VNa8PZt5RuBCCxqCGAaXLXSO6g9SAMJTl2Kkt?=
 =?us-ascii?Q?c9WwBAfKYvg3ABWk0s3ZdZKqbICF7WMyBlL3KmmcRTKUI0dAJwxp72CJZpym?=
 =?us-ascii?Q?khMrf33anxshrBAvY77Id2mvn7ucxnELIDNyad3jBkAYyZUhGqkkvV1SCkZG?=
 =?us-ascii?Q?AFP2/saNSPoFWjGgQTwZMZij94pZKLi0ypNxKFzCVu8SVKmWc42rQfWgtCB8?=
 =?us-ascii?Q?zttbI2ouQ4p2+k5E9JHgJtEC1hqQw5UCew7FkLLVkPtoniQOv3xj810/mXQb?=
 =?us-ascii?Q?ZCfhDCyDH8KJwbV79Ap++FOLAwgv8pQNN++XgRYMfSKtgPYX48l+zqGOYWLB?=
 =?us-ascii?Q?kswwCAfWIO3oCI0o653lJcmIukuWDapVxpHghjc97KF0+KWXAoZ/WdRX/hDE?=
 =?us-ascii?Q?pVfALxlGlR3OX+rMb4/7/4IQ9ASXl2ZoxRUmUCICSECeoEGDP8BcL+HFs0hW?=
 =?us-ascii?Q?yaWZWuwcJXB/mB7zvamGaMq5nfaJ6SKJGT3d7S7A0qQoki3A1JSAljplWfCk?=
 =?us-ascii?Q?IjTuwS0l/qcZieHJsglFGUto9f9rdHG6OCQyZcdjhAPvC9GDUXgRWrya101J?=
 =?us-ascii?Q?sYOw1rTacMuUMDrGupqZlIPsZqpUIoQ5zISroO7hk4Vb4LCiq+TxoEydk9S3?=
 =?us-ascii?Q?EgLNDoBvIBEbXPLnD/2DoLyjVlm0PgyTVjLzSuy0JpA1k6phU+6lGAc9w7Va?=
 =?us-ascii?Q?L5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RDvwlWTXrMvk1sQqV9JD8QdHvsVXc4Di23Yxd8NZEbFE19fGCbBw5TgABGSv?=
 =?us-ascii?Q?XTkJ+KT2ed9kQF8sjv8ZWRPD5BESlX4dqW4fFjB8XvbqUOyqHDtxOWpWc7t5?=
 =?us-ascii?Q?mK4Xu3b2ycn+QnrXTbFryXTV3wZm/O59XZoPtakkuc4FVHQveBE8c2CY+009?=
 =?us-ascii?Q?3gw3R33btkGiMh0hGxIPiO4wIMegvqUCMFhmJjqPL8fH2U0lvyKingT0PQ38?=
 =?us-ascii?Q?QNlHV4iwi3bGGRt/sNvnB96aEGRyPW6Hu6bw/jzcN89FrJn8zhtU+j61B3xx?=
 =?us-ascii?Q?9BYEMHpmquAnaGxiB/pAk5q2wFIlKL2/xICMzSUDrsZXgs6gTOZStYfL/ioM?=
 =?us-ascii?Q?B5aFNTTjgW0JjP87NUS27DFW7NhfPwq1sKYajgx1TPTwvznrNHxQKtln2Qq/?=
 =?us-ascii?Q?8gFqWjJiEsJdssCpKA59F9HnDaNZ7owQaNodcs0gOxT2S11hMsZ9gMGab+qX?=
 =?us-ascii?Q?NrAx2av0w4y7gvkCaAoZt34bQo3cNJwKs+xbDgV2HkVA2o1t1/5DPKM1m21O?=
 =?us-ascii?Q?c/U3w+dXuyiSgW/X9gLGxfDZqKqc1QCSdED2tEwPOF9wyI13ET/gUDsVVZb8?=
 =?us-ascii?Q?s2utrg4wYh3fzPDPZnU1zgT+X9N9Bk8FYf01xHNL5V0eLxXRx1F5KCHdJGwp?=
 =?us-ascii?Q?7JVqowxB5Ak8nfeV1MVv9p2FIUhCevKrvwT6AFCqLsBsIkrj1JHvktx5h8rT?=
 =?us-ascii?Q?X6QjVijIhZ+z8nGHONQUAxEujOy5JrZnu4Qt7d9WXphWLN0dfpLoCz/Gi1dP?=
 =?us-ascii?Q?RcbUlFcBJy9VJH9kvKGjHPKcgka25BzHv4rVKsNNTwMXFs1nx3+V9d4xsxXX?=
 =?us-ascii?Q?IOdGYg66giJHlYpYVgT4te8PsBGyttVxHl9s+FvkHoHcaLN7/eLyVdpbiYpQ?=
 =?us-ascii?Q?6qLnD35ZuTVBjRJn0nQi/NxBxzUFkkB1+iM0vZQ6Qd7QuASl0ShjWNsUpbwM?=
 =?us-ascii?Q?XGfw+NLg5Vo6dPVt1l5itbrTWp26dnsvEX1MZvEf6ka0wrE+VEfe3WOwpqzH?=
 =?us-ascii?Q?iVarCZbBSB/axLYS9oEMVG06FVZewN7w78zRaSqERbk93VrByQToC8NwkuO5?=
 =?us-ascii?Q?1Hsd95dz5UVK11zDXjc482wLOrwqV3gur/Yhu19QMHrb4KTr77LYb6d0Y9P2?=
 =?us-ascii?Q?0nipO6O9MIag8FkkQUB5LRf5/cPn0ECKlf+LZSVeNpbXN2chQ/KpnKQNUn80?=
 =?us-ascii?Q?nMvKLVAXOem3Q/XsjNf9QTfSnRQVuC4+QUABiXB7A7BVjgvd5mShBppTD3tQ?=
 =?us-ascii?Q?Ix/mPDH7LkGEYw6z0VEjwooDv5IsmDxAot6Hk8+wvhsB230J4UrSdknvkY0U?=
 =?us-ascii?Q?Hk+xngZQVSIBhqB85izg8Fspqal0ahteBCB5+O1eMpMZzkgpgsZUhq/dRIA7?=
 =?us-ascii?Q?J/GLmgau607qAi+4R9C/+ftuQslO8s3528E/j+PI1qHnt+P2G+dORRXNoWsj?=
 =?us-ascii?Q?g6MhztuufbDVWbaWuexqV2csUIBhH3WlqEZZsFpSpsvilaeUBnpP4WjdUACx?=
 =?us-ascii?Q?6CI1vbv9bxq23m8lJAr4gW2oJdlzAigaFpatZ9hSHTR5LRMs4oy1ZovsrFu5?=
 =?us-ascii?Q?Sf9/pg5vjiHLzOcHbLziqz8AQK8RHMjwgCgqlThMF3Pb9xUxjFt6l1IAFord?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C4BnzGCnrgPTLXZxvxOIY6yV9f/782eelD/iXlfQznQWoaQHXguKOBJH4GMS4X5CZvFYuaWrk2reg6rwgR7Ckec7BbA1LeKOJ8xISIq3tDBjlTCbq1+1SAAi9iCFpfT79EoQbx6Tj0B46KcT/LSmQJibmzZNVLTpBNmj0J7EbOzK3RXl/8oVG/SnqM/+cRuuAWsKk6XO68aX5Qi+Yea+FUXoldnWCYlsRqq18rvz0xkZIPTuExfATACfJgQJh7kb+ORbKJcUU/NJUSeGphQztdhllxa4EuTJ4nwA1LONrUqRiwX2AnDrOcT/EziA2V4J6Fn58GIj08E6Y5Gq+gbAn2y/z1h/IOs4DpTHZ7yJCsGe2sXQ2+HRPAH+U9Lb2xeuyH9DEiRVhNYP8BF8Q/p0At7KOGe4b5kEN9qj3X3FHLkbpuFrolXyZC5JroFRE10VzIBs7VpoKBRn2qLrNTojFlDQSgqQekF29DEmqQkFKHYpne9QRNds8tVpW6dud/7OT5hnzXWMKwqGAF6Pj9d1XZY9FrG4dXMprmPlRxjBJNedql+Y7JFxgijCD4msbfDjMKqEv85bFAtwhZXnhy6jINkYq25sG0DnoyOtJFndICQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe0d17f-5e90-48ca-9747-08dce14f1266
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:54:50.8507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3YkgHJd2FCyG/GMRY/XTZCs1eH2fi4PbE+moh4Q6SjRQJQjQM/Za90/Lmb3sRi1tzVPoJZ1dW8uB6VinPi30A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300093
X-Proofpoint-GUID: TB7TR0t_DRZL2lG4h3L8oSr7USVb0gOw
X-Proofpoint-ORIG-GUID: TB7TR0t_DRZL2lG4h3L8oSr7USVb0gOw

This series expands atomic write support to filesystems, specifically
XFS.

Flag FS_XFLAG_ATOMICWRITES is added as an enabling flag for atomic writes.

XFS can be formatted for atomic writes as follows:
mkfs.xfs  -i atomicwrites=1 -b size=16384 /dev/sda

Support can be enabled through xfs_io command:
$xfs_io -c "chattr +W" filename
$xfs_io -c "lsattr -v" filename
[atomic-writes] filename
$xfs_io -c statx filename
...
stat.stx_atomic_write_unit_min = 16384
stat.stx_atomic_write_unit_max = 16384
stat.stx_atomic_write_segments_max = 1
...

Dependence on forcealign is gone for the moment. This means that we can
only write a single FS block atomically. Since we can now have FS block
size > PAGE_SIZE for XFS, we can write atomically write > 4K blocks on
x86.

Using the large FS block size has downsides, so we still want the
forcealign feature.

Baseline is v6.12-rc1

Basic xfsprogs support at:
https://github.com/johnpgarry/xfsprogs-dev/tree/atomic-writes-v6

Patches for this series can be found at:
https://github.com/johnpgarry/linux/tree/atomic-writes-v6.12-fs-v6

Changes since v5:
- Drop forcealign dependency
- Can support atomically writing a single FS block
- XFS_DIFLAG2_ATOMICWRITES is inherited from parent directories
- Add RB tags from Darrick (thanks!)

Changes since v4:
- Drop iomap extent-based zeroing and use single bio to cover multiple
  extents
- Move forcealign to another series
- Various change in ioctl, sb, inode validation
- Add patch to tweak generic_atomic_write_valid() API

John Garry (7):
  block/fs: Pass an iocb to generic_atomic_write_valid()
  fs: Export generic_atomic_write_valid()
  fs: iomap: Atomic write support
  xfs: Support FS_XFLAG_ATOMICWRITES
  xfs: Support atomic write for statx
  xfs: Validate atomic writes
  xfs: Support setting FMODE_CAN_ATOMIC_WRITE

 block/fops.c                   |  8 +++----
 fs/iomap/direct-io.c           | 26 ++++++++++++++++++++---
 fs/iomap/trace.h               |  3 ++-
 fs/read_write.c                |  5 +++--
 fs/xfs/libxfs/xfs_format.h     | 11 ++++++++--
 fs/xfs/libxfs/xfs_inode_buf.c  | 38 ++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_util.c |  6 ++++++
 fs/xfs/libxfs/xfs_sb.c         |  2 ++
 fs/xfs/xfs_buf.c               | 15 +++++++++++++-
 fs/xfs/xfs_buf.h               |  5 ++++-
 fs/xfs/xfs_buf_mem.c           |  2 +-
 fs/xfs/xfs_file.c              | 19 +++++++++++++++++
 fs/xfs/xfs_inode.h             | 22 ++++++++++++++++++++
 fs/xfs/xfs_ioctl.c             | 37 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iops.c              | 24 +++++++++++++++++++++
 fs/xfs/xfs_mount.h             |  2 ++
 fs/xfs/xfs_reflink.c           |  4 ++++
 fs/xfs/xfs_super.c             |  4 ++++
 include/linux/fs.h             |  2 +-
 include/linux/iomap.h          |  1 +
 include/uapi/linux/fs.h        |  1 +
 21 files changed, 221 insertions(+), 16 deletions(-)

-- 
2.31.1


